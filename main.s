.include "tn85def.inc"

;midi clock timing
.equ	CLOCK_SPEED, 8000000
.equ	BAUDRATE, 31250
.equ	CYCLES_PER_BIT, (CLOCK_SPEED / BAUDRATE)
.equ	FULL_BIT_TICKS, (CYCLES_PER_BIT / 8)
.equ	TIMER_TICKS, 2

;ram addressing 

.equ	SRAM_START, 0x0060
.equ	MIDI_BUFFER_END, (SRAM_START + 0x00FF)




.org 0x0000
	rjmp reset		;1
	rjmp unhandled		;2
	rjmp interrupt0  	;3
	rjmp unhandled   	;4
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
	;initialize the indirect address to the midi buffer to start at the
	;beginning of sram
	ldi r27, 0
	ldi r26, 0x60		

	;initialize the writing location to be the same
	ldi r16, 0
	mov r3, r16
	mov r4, r16 ;queue to 0
	mov r5, r16
	ldi r16, 0x60
	mov r2, r16

	;init the stack
	ldi r16, 0x02
	out SPH, r16
	ldi r16, 0x5F
	out SPL, r16

	ldi r16, (0<<DDB0)|(1<<DDB1)|(1<<DDB2);initialize the data direction of DB
	out DDRB, r16 ;write to DDRB register

	;sbi PORTB,PB0 ;enable pullups for input

	sei

	ldi r16, 0 	
	out USICR, r16 ;disable the USI

	ldi r16, 1<<PCIF 
	out GIFR, r16 ;clear the pin change interrupt

	in r16, GIMSK
	ori r16, 1<<PCIE
	out GIMSK, r16 ;enable pin change interrupt

	in r16, PCMSK
	ori r16, 1<<PCINT0
	out PCMSK, r16 ;enable pin change on pin0

	


	
execution_loop:
	mov r16, r4
	cpi r16, 0 ;check if the queue count is 0
	breq execution_loop
	
	dec r4	
	ld r16, X+
	rcall check_end_buffer

	cpi r16, 0xF8
	brne execution_loop
	
	rcall debug_write_1





;enable timer for the clock 122 prescaled counts on off and switch the 
	

	








	rjmp execution_loop










debug_write_start:

	nop
	cbi PORTB, PB2


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2
	ret


debug_write_1:




	
	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2



	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	
	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2



	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	ret

debug_write:
	sbrc r16,0
	sbi PORTB, PB1
	sbrs r16,0
	cbi PORTB, PB1


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r16,1
	sbi PORTB, PB1
	sbrs r16,1
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r16,2
	sbi PORTB, PB1
	sbrs r16,2
	cbi PORTB, PB1
	
	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2


	sbrc r16,3
	sbi PORTB, PB1
	sbrs r16,3
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r16,4
	sbi PORTB, PB1
	sbrs r16,4
	cbi PORTB, PB1
	
	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r16,5
	sbi PORTB, PB1
	sbrs r16,5
	cbi PORTB, PB1


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r16,6
	sbi PORTB, PB1
	sbrs r16,6
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r16,7
	sbi PORTB, PB1
	sbrs r16,7
	cbi PORTB, PB1


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	ret




check_end_buffer:
	cpi r27, 0x01
	brne quick_ret
	cpi r26, 0x60
	brne quick_ret

	ldi r27, 0
	ldi r26, 0x60
		
quick_ret:
	ret






interrupt0:
	in r17, PINB
	andi r17, 1<<PINB0
	breq skip_INT0_ret ;check if PINB0 is high, if so return
	reti

skip_INT0_ret:
	in r17, GIMSK
	andi r17, ~(1<<PCIE)
	out GIMSK, r17 ;disable pin interrupts


	in r17, PCMSK
	andi r17, ~(1<<PCINT0)
	out PCMSK, r17 ;enable pin change on pin0

	
	
	ldi r17, 2
	out TCCR0A, r17 ;CTC mode
	
	ldi r17, 2
	out TCCR0B, r17 ;set the timer rate to clock/8

	;in r17, GTCCR
	;ori r17, 1 << PSR0
	;out GTCCR, r17 ;reset the clock prescaler

	ldi r17, TIMER_TICKS
	;set the count up value to activate in the middle of a start bit
	out OCR0A, r17 
	
	ldi r17, 0
	out TCNT0, r17 ;initialize the counter to 0

	;ldi r17, 1 << OCF0A
	;out TIFR, r17 ;clear output compare flag
	
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
	
		

	;enable counter overflow interrupt
	;set wire mode to 0
	;set the clock source to the timer0
	ldi r17, (1<<USIOIE)|(0<<USIWM0)|(1<<USICS0)
	out USICR, r17

	;clear start condition flag
	;set counter overflow flag
	;init the 4 bit counter to 8 which will overflow after 8 bits
	ldi r17, 1<<USIOIF | 8;
	out USISR, r17

	reti






USI_overflow:

	ldi r17, 0
	out USICR, r17 ;disable USI

	in r18, USIBR ;store the recieved byte
	

	
;	rcall reverse_byte ;reverse the byte sent rewriting register 18




	;store the reading address to the stack
	push r27	
	push r26
	
	;load the writing address
	mov r27, r3
	mov r26, r2
	
	;write midi to memory
	st X+, r18	
	rcall check_end_buffer
	inc r4 ;increment the counter for the queue		

	;save writing address
	mov r3, r27
	mov r2, r26


	;pop reading address from the stack
	pop r26
	pop r27




	ldi r17, 1<<PCIF
	out GIFR, r17 ;clear pin change interrupt

	in r17, GIMSK
	ori r17, 1<<PCIE
	out GIMSK, r17 ;enable pin change interrupt
	

	in r17, PCMSK
	ori r17, 1<<PCINT0
	out PCMSK, r17 ;enable pin change on pin0
	
	reti



reverse_byte:
	;only use r18 and r0
	mov r0, r18
	andi r18, 0x55
	eor r0, r18
	lsr r18
	brcc skip_carry_clear
	lsl r0
skip_carry_clear:
	adc r0, r18
	mov r18, r0
	andi r18, 0x99
	eor r0, r18
	swap r0
	or r18, r0
	ret	




unhandled:
	nop
	reti















