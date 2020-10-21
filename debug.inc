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
	sbrc r18,0
	sbi PORTB, PB1
	sbrs r18,0
	cbi PORTB, PB1


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r18,1
	sbi PORTB, PB1
	sbrs r18,1
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r18,2
	sbi PORTB, PB1
	sbrs r18,2
	cbi PORTB, PB1
	
	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2


	sbrc r18,3
	sbi PORTB, PB1
	sbrs r18,3
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r18,4
	sbi PORTB, PB1
	sbrs r18,4
	cbi PORTB, PB1
	
	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r18,5
	sbi PORTB, PB1
	sbrs r18,5
	cbi PORTB, PB1


	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r18,6
	sbi PORTB, PB1
	sbrs r18,6
	cbi PORTB, PB1

	nop
	sbi PORTB, PB2
	nop
	cbi PORTB, PB2

	sbrc r18,7
	sbi PORTB, PB1
	sbrs r18,7
	cbi PORTB, PB1


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



