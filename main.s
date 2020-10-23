.include "tn85def.inc"

;midi clock timing
.equ	CLOCK_SPEED, 8000000
.equ	BAUDRATE, 31250
.equ	CYCLES_PER_BIT, (CLOCK_SPEED / BAUDRATE)
.equ	FULL_BIT_TICKS, (CYCLES_PER_BIT / 8)
.equ	TIMER_TICKS, 3





.org 0x0000
	rjmp reset		;1
	rjmp unhandled		;2
	rjmp interrupt0  	;3
	rjmp gbclock	   	;4
	rjmp unhandled    	;5
	rjmp unhandled   	;6
	rjmp unhandled    	;7
	rjmp unhandled    	;8
	rjmp unhandled    	;9
	rjmp unhandled    	;10
	rjmp timer_0compareA   	;11
	rjmp unhandled    	;12
	rjmp unhandled    	;13
	rjmp unhandled    	;14
	rjmp USI_overflow    	;15


reset:

	ldi r16, 0
	mov r2, r16 ;bits to skip
	ldi r16, 1
	mov r0, r16 ;start/stop


	;init the stack
	ldi r16, 0x02
	out SPH, r16
	ldi r16, 0x5F
	out SPL, r16

	;load the indirect midi buffer address to start at beginning of sram
	ldi r27, 0
	ldi r26, 0x60		
	
	;init the writing location
	ldi r16, 0
	mov r7, r16
	mov r4, r16 ;queue to 0
	ldi r16, 0x60
	mov r6, r16


	ldi r16, (0<<DDB0)|(1<<DDB1)|(1<<DDB2)|(1<<DDB5);initialize the data direction of DB
	out DDRB, r16 ;write to DDRB register


	sei

	ldi r16, 0 	
	out USICR, r16 ;disable the USI


	ldi r16, 0b10000100
	out TCCR1, r16 ;CTC mode
	


	ldi r16, 10
	out OCR1A, r16 
	ldi r16, 11
	out OCR1C, r16 



	ldi r17, 2
	out TCCR0A, r17 ;CTC mode
	
	ldi r17, 2
	out TCCR0B, r17 ;set the timer rate to clock/8




	ldi r16, 1<<PCIF 
	out GIFR, r16 ;clear the pin change interrupt

	in r16, GIMSK
	ori r16, 1<<PCIE
	out GIMSK, r16 ;enable pin change interrupt

	in r16, PCMSK
	ori r16, 1<<PCINT0
	out PCMSK, r16 ;enable pin change on pin0

	



	
execution_loop:
	sei
	
	nop
	cli
	and r4,r4
	breq execution_loop
	dec r4


	ld r19, X+	
	rcall check_end_buffer

	mov ZL, r19
	andi ZL, 0xF0
	cli
	cpi ZL, 0xF0
	brne not_an_f
	sei


	ldi ZH, (((0xff00 & 0x0200) >> 8) >> 1) ;lookuptable high byte
	ldi ZL, 0

	andi r19, 0x0F
	add ZL, r19

	ijmp
		

not_an_f:
	sei
	ldi ZH, 0x03 ;lookuptable high byte
	mov ZL,r19
	swap ZL	
	ori ZL, 0xF0
	lpm r19,Z
	mov r2,r19



	rjmp execution_loop







gbclock:
	


	cli
	sbis PORTB, PB5
	rjmp clear_jump
	cbi PORTB, PB5
	rjmp time_change

clear_jump:
	sbi PORTB, PB5


time_change:
	dec r5
	brne clock_return
	in r20, TIMSK
	andi r20, ~(1<<OCIE1A) ;set output compare interrupt
	out TIMSK, r20
	

clock_return:
	sei
	reti









interrupt0:

	in r17, PINB
	andi r17, 1<<PINB0
	breq skip_INT0_ret ;check if PINB0 is high, if so return
	reti

skip_INT0_ret:

	



;	in r17, GIMSK
;	andi r17, ~(1<<PCIE)
;	out GIMSK, r17 ;disable pin interrupts


	in r17, PCMSK
	andi r17, ~(1<<PCINT0)
	out PCMSK, r17 ;disable pin change on pin0

	
	ldi r17, TIMER_TICKS
	;set the count up value to activate in the middle of a start bit
	out OCR0A, r17 
	
	
	ldi r17, 0
	out TCNT0, r17 ;initialize the counter to 0

	ldi r17, 1 << OCF0A
	out TIFR, r17 ;clear output compare flag
	
	in r17, TIMSK
	ori r17, 1<<OCIE0A ;set output compare interrupt
	out TIMSK, r17

	
	reti





timer_0compareA:

	cli	
	

	in r17, TIMSK
	andi r17, ~(1<<OCIE0A) ;disable compare interrupt
	out TIMSK, r17
	
	sei

	ldi r17, 0
	out TCNT0, r17 ;initialize the counter to 0

	ldi r17, FULL_BIT_TICKS
	out OCR0A, r17 ;shift every bit width
	
		
	;clear start condition flag
	;set counter overflow flag
	;init the 4 bit counter to 8 which will overflow after 8 bits
	ldi r17, 1<<USIOIF | 8;
	out USISR, r17

	;enable counter overflow interrupt
	;set wire mode to 0
	;set the clock source to the timer0
	ldi r17, (1<<USIOIE)|(0<<USIWM0)|(1<<USICS0)
	out USICR, r17


	reti






USI_overflow:

	ldi r17, 0
	out USICR, r17 ;disable USI
	
	and r2,r2
	brne skip_byte



	in r18, USIBR ;store the recieved byte
	
	
	rcall reverse_byte ;reverse the byte sent rewriting register 18
	

	cpi r18, 0xF8
	breq start_send_tick_timer
		

	push r27
	push r26

	mov r27, r7
	mov r26, r6

	st X+, r18
	rcall check_end_buffer
	inc r4

	mov r7, r27
	mov r6, r26

	pop r26
	pop r27

;skip_byte:
	and r2,r2
	breq return_from_tick_start
	dec r2

return_from_tick_start:

	

	ldi r17, 1<<PCIF
	out GIFR, r17 ;clear pin change interrupt

;	in r17, GIMSK
;	ori r17, 1<<PCIE
;	out GIMSK, r17 ;enable pin change interrupt
	

	in r17, PCMSK
	ori r17, 1<<PCINT0
	out PCMSK, r17 ;enable pin change on pin0
	
	reti







start_send_tick_timer:

	
	and r0,r0
	breq return_from_tick_start
		
	ldi r17, 0
	out TCNT1, r17 ;initialize the counter to 0
		

	;zero the count up to 8

	ldi r17, 16
	mov r5, r17


	in r17, TIMSK
	ori r17, 1<<OCIE1A ;set output compare interrupt
	out TIMSK, r17


	rjmp return_from_tick_start





reverse_byte:
	mov    r17, r18            
	add    r17, r17            
	andi   r17, 0xAA           
	lsr    r18                 
	andi   r18, 0x55           
	or     r17, r18            
	mov    r18, r17            
	add    r18, r18            
	add    r18, r18            
	andi   r18, 0xCC           
	lsr    r17                 
	lsr    r17                 
	andi   r17, 0x33           
	or     r18, r17            
	swap   r18                 
	ret	




unhandled:
	nop
	reti


check_end_buffer:
	cpi r27, 0x01
	brne quick_ret
	cpi r26, 0x60
	brne quick_ret

	ldi r27, 0
	ldi r26, 0x60
		
quick_ret:
	ret




.org 0x0200
start_stop_table:
	rjmp execution_loop ;0
	rjmp execution_loop  ;1
	rjmp inc_2_twice ;2
	rjmp inc_2_once  ;3
	rjmp execution_loop ;4
	rjmp execution_loop ;5
	rjmp execution_loop ;6
	rjmp execution_loop ;7
	rjmp execution_loop ;8
	rjmp execution_loop ;9
	rjmp inc_0 ;A
	rjmp inc_0;B
	rjmp zero_0;C
	rjmp execution_loop;D
	rjmp execution_loop;E
	rjmp execution_loop;F



inc_2_twice:
	inc r2
inc_2_once:
	inc r2
	rjmp execution_loop




inc_0:
	inc r0
	rjmp execution_loop

zero_0:
	eor r0,r0
	rjmp execution_loop




.org 0x03F0
.byte 1 ;0
.byte 1 ;1
.byte 1 ;2
.byte 1 ;3
.byte 1 ;4
.byte 1 ;5
.byte 1 ;6
.byte 1 ;7
.byte 3 ;8
.byte 3 ;9
.byte 3 ;A
.byte 3 ;B
.byte 2 ;C
.byte 2 ;D
.byte 3 ;E
.byte 1 ;F not handled



.include "debug.inc"
