		.syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		Zeller1
		.thumb_func
		.align
/*		
//R0 = k, R1 = m, R2 = D, R3 = C
Zeller1:
		PUSH	{R4}				// set R4 to temp
		LDR		R3,=13
		MUL		R1,R1,R3			// m <- 13*m
		SUB		R1,R1,1				// m <- m - 1
		ADD		R2,R2,R2,LSR 2		// D <- D + D/4
		LSR		R4,R3,2				// temp <- C/4
		SUB		R3,R4,R3,LSL 1		// C <- temp - 2*C
		ADD		R0,R0,R1			// f <- f + m
		ADD		R0,R0,R2			// f <- f + D
		ADD		R0,R0,R3			// f <- f + C
		LDR		R12,=7				// 7 stored in R12
		UDIV	R4,R0,R12			// quotient
		MLS		R0,R12,R4,R0		// f <- f = quotient*7
		CMP		R0,0				// compares R0 and 0
		BHS		end1				// if greater or equal, go to end1
		ADD		R0,R0,7				// f <- f + 7

end1:
		POP		{R4}
		BX		LR

		.global		Zeller2
		.thumb_func
		
//R0 = k, R1 = m, R2 = D, R3 = C
Zeller2:
		PUSH	{R4,R5}				
		LDR		R12,=13				// R12 <- 13
		MUL		R1,R1,R12			// m <- 13*m
		SUB		R1,R1,1				// m <- m - 1
		LDR		R12,=3435973837		// m <- (m*13 - 1)/5
		UMULL	R1,R12,R12,R1		// R1 <- (3435973837*10000)63..32
		LSR		R1,R12,2			// R0 <- R12 LSR 2^2
		ADD		R2,R2,R2,LSR 2		
		LSR		R4,R3,2
		SUB		R3,R4,R3,LSL 1
		ADD		R0,R0,R1
		ADD		R0,R0,R2
		ADD		R0,R0,R3
		LDR		R4,=7
		LDR		R5,=2454267027
		SMMLA	R5,R5,R0,R0			// R5 <- (613566757*10000)63..32
		LSR		R12,R0,31			// R0 <- (dividend < 0) ? 1:0
		ADD		R12,R12,R5,ASR 2
		MLS		R0,R12,R4,R0		// f <- f = quotient*7
		CMP		R0,0			
		BHS		end2
		ADD		R0,R0,7

end2:
		POP		{R4,R5}
		BX		LR

		.global		Zeller3
		.thumb_func
*/
Zeller3:
		PUSH	{R4}
		ADD		R0,R0,R2
		ADD		R0,R0,R2,LSR 2
		ADD		R0,R0,R3,LSR 2
		SUB		R0,R0,R3,LSL 1
		ADD		R4,R1,R1,LSL 3
		ADD		R2,R4,R1,LSL 2
		SUB		R2,R2,1
		LDR		R4,=5
		UDIV	R2,R2,R4			// (13*m - 1)/5
		ADD		R0,R0,R2
		LDR		R4,=7
		SDIV	R2,R0,R4			// temp <- f/7
		LSL		R4,R2,3				// R4 <- 8*temp
		SUB		R2,R4,R2			// 8*temp - temp <- 7*temp
		SUB		R2,R0,R2			// temp <- f - temp
		CMP		R2,0				// temp ? 0
		IT		LT					// temp < 0 ?
		ADDLT	R2,R2,7				// if temp < 0, temp += 7
		MOV		R0,R2
		
		POP		{R4}
		BX		LR

		.end
