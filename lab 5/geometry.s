		.syntax		unified
    	.cpu     	cortex-m4
    	.text

		
		.global   	Log2Phys
    	.thumb_func
    	.align


Log2Phys:

		PUSH 	{R4,R5,R6,R7,R8}

//compute cylinder R4 = lba/(heads*sectors)
//lba = R0, heads = R1, sectors = R2, struct = R3

		MUL 	R4, R1, R2 		//heads*sectors
		UDIV 	R4, R0, R4 		//r4 = lba/heads*sectors
		STRH	R4, [R3]	

//compute head R5
//head = (lba/sectors) % heads

		UDIV 	R5, R0, R2 		//R5 = lba/sectors
		UDIV 	R6, R5, R1 		//quotient = (lba/sectors) / heads
		MLS		R6, R1, R6, R5	
		ADD		R3, R3, 2		//increment by 2
		STRB	R6, [R3]

//compute sector

		UDIV 	R5, R0, R2 		//R5 = r0(dividend)/r2(divisor)
		MLS 	R8, R2, R7,R0 	//R6 = R5(quotient)*r2(divisor)
		ADD 	R8, R8, 1		//increment by 1
		ADD 	R3, R3, 1		//increment by 1
		STRB	R8, [R3]

		POP		{R4,R5,R6,R7,R8}
		BX		LR
//structures 


		.end
