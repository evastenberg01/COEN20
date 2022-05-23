		.syntax		unified
		.cpu		cortex-m4
		.text

		.global		CopyCell
		.thumb_func
		.align

// row = R2, col = R3
CopyCell:

		PUSH	{R4,R5,LR}
		LDR		R2,=0
		LDR		R3,=0
		MOV		R4,R0
		MOV		R5,R1

L0:		CMP		R2,60			//checks if R2 < 60
		BGE		L3				//ends loop if R2 > 60

L1:		CMP		R3,60			//if R3 < 60, continue
		BGE		L2				//if not, move to L2
		LDR		R1,[R5,R3,LSL 2]
		STR		R1,[R4,R3,LSL 2]
		ADD 	R3,R3,1
		B		L1				//repeat

L2:		ADD		R4,R4,960		//add 240 * 4
		ADD		R5,R5,960
		ADD		R2,R2,1			//add 1 to row number
		LDR		R3,=0			//resets column number to zero
		B		L0				//repeat

L3:		POP		{R4,R5,PC}

		.global		FillCell
		.thumb_func
		.align

FillCell:
//set row and col equal to 0
		LDR		R2,=0	
		LDR		R3,=0

L4:		CMP		R2,60			//if R2 < 60
		BGE		L7				
		LDR		R3,=0

L5:		CMP		R3,60
		BLO		L6				//moves to L6 if col < 60
		ADD		R2,R2,1		
		ADD		R0,R0,960
		B		L4

L6:		STR		R1,[R0,R3,LSL 2]
		ADD		R3,R3,1			//increment col by 1
		B		L5				//return

L7:		Bx		LR

		.end
		

