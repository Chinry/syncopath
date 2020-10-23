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






debug_write_4:
	sbrc r4,0
	sbi PORTB, PB1
	sbrs r4,0
	cbi PORTB, PB1


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r4,1
	sbi PORTB, PB1
	sbrs r4,1
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r4,2
	sbi PORTB, PB1
	sbrs r4,2
	cbi PORTB, PB1
	
	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2


	sbrc r4,3
	sbi PORTB, PB1
	sbrs r4,3
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r4,4
	sbi PORTB, PB1
	sbrs r4,4
	cbi PORTB, PB1
	
	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r4,5
	sbi PORTB, PB1
	sbrs r4,5
	cbi PORTB, PB1


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r4,6
	sbi PORTB, PB1
	sbrs r4,6
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r4,7
	sbi PORTB, PB1
	sbrs r4,7
	cbi PORTB, PB1


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	ret





debug_write18:
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









