

debug_write:
	sbrc r21,7
	sbi PORTB, PB1
	sbrs r21,7
	cbi PORTB, PB1


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r21,6
	sbi PORTB, PB1
	sbrs r21,6
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r21,5
	sbi PORTB, PB1
	sbrs r21,5
	cbi PORTB, PB1
	
	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2


	sbrc r21,4
	sbi PORTB, PB1
	sbrs r21,4
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r21,3
	sbi PORTB, PB1
	sbrs r21,3
	cbi PORTB, PB1
	
	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r21,2
	sbi PORTB, PB1
	sbrs r21,2
	cbi PORTB, PB1


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r21,1
	sbi PORTB, PB1
	sbrs r21,1
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r21,0
	sbi PORTB, PB1
	sbrs r21,0
	cbi PORTB, PB1


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	ret









