	.syntax		unified
	.cpu		cortex-m4
	.text


/* uint32_t Add(uint32_t a, int32_t b); */
		.global		Add
		.thumb_func
		.align

Add:
		ADD			R0,R0,R1     // x+1
		BX			LR


/* uint32_t Less1(uint32_t x); */
		.global		Less1
		.thumb_func
		.align
Less1:
		SUB			R0,1     // x-1
		BX			LR

/*int32_t Square2x(int32_t x); */
	
		.global		Square2x
		.thumb_func

Square2x:
		Add			R0,R0,R0	//Add value of R0 to itself
		B			Square		//calls square function with R0

		.global		Last
		.thumb_func

Last:
		Push 	{R4, LR}		//save data on R4
		MOV		R4, R0			//save the value of x to R4
		BL		SquareRoot		//calls squareroot function
		ADD		R0,R0,R4		//R0 changed from Square(x) and adds saved x in R4
		POP		{R3, PC}		//return original R4

	/* End of file */
	.end
