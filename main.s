.include "tn85def.inc"


.equ	CLOCK_SPEED, 8000000
.equ	BAUDRATE, 31250
.equ	CYCLES_PER_BIT, (CLOCK_SPEED / BAUDRATE)
.equ	FULL_BIT_TICKS, (CYCLES_PER_BIT / 8)
.equ	HALF_BIT_TICKS, (FULL_BIT_TICKS / 2)
.equ	TIMER_TICKS, (HALF_BIT_TICKS - (99/8))


.org 0x0000
	rjmp reset		;1
	rjmp interrupt0 	;2
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
	ldi r16, (0<<DDB0)|(0<<DDB1)|(1<DDB2) ;initialize the data direction of DI
	out DDRB, r16 ;write to DDRB register

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
	rjmp execution_loop








interrupt0:
	in r17, PINB
	andi r17, 1<<PINB0
	breq skip_INT0_ret ;check if PINB0 is high, if so return
	reti

skip_INT0_ret:
	in r17, GIMSK
	andi r17, ~(1<<PCIE)
	out GIMSK, r16 ;disable pin interrupts
	
	ldi r17, 2<<WGM00
	out TCCR0A, r17 ;CTC mode
	
	ldi r17, 2
	out TCCR0B, r17 ;set the timer rate to clock/8

	in r17, GTCCR
	ori r17, 1 << PSR0
	out GTCCR, r17 ;reset the clock prescaler

	ldi r17,
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
	in r17, TIMSK
	andi r17, ~(1<<OCIE0A) ;disable compare interrupt
	out TIMSK, r17

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
	ldi USISR = 1<<USIOIF | 8;
	reti






USI_overflow:
	in r18, USIBR ;store the recieved byte
	
	ldi r17, 0
	out USICR, r17

	rcall reverse_byte

	ldi r17, 1<<PCIF
	out GIFR, r17 ;clear pin change interrupt

	in r17, GIMSK
	ori r17, 1<<PCIE
	out GIMSK, r17 ;enable pin change interrupt
	
	reti



reverse_byte:
	;only use r18 and r17
	mov r0, r18
	andi r18, 0x55
	eor r0, r18
	lsr r18
	ret	




unhandled:
	nop
	rjmp unhandled 















