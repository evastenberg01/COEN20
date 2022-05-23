		.syntax			unified
        .cpu			cortex-m4
        .text
       
		.global			PutNibble
        .thumb_func

//void PutNibble(void *nibbles, uint32_t which, uint32_t value) ;
//R0 = nibbles, R1 = which, R2 = value
PutNibble:
        
		PUSH {R4, R5}
        MOV R4, R0          // R4 <- R0
        MOV R5, R1          // R5 <- R1
        LSR R5, R5, 1       // R5 <- R1/2
        ADD R4, R4, R5      // R4 <- R0 + R5
        LDRB R4, [R4]       
        AND R1, R1, 1       // R1 <- R1 & 1
        CMP R1, 0
        ITE EQ
        BFIEQ R4, R2, 0, 4  //R4<3..0> <- R2<4>
        BFINE R4, R2, 4, 4  //R4<4..8> <- R2<4>
        STRB R4,[R0, R5]    //R4 -> byte with address of R0 + R5
        POP {R4, R5}
        BX LR


        .global    GetNibble
        .thumb_func

//uint32_t GetNibble(void *nibbles, uint32_t which) ;
//R0 = nibbles, R1 = which
GetNibble:
        
		PUSH {R4, R5}
        MOV R4, R0          //R4 <- R0
        MOV R5, R1          //R5 <- R1
        LSR R5, R5, 1       //R5 <- R1/2
        ADD R4, R4, R5      //R4 <- R0 + R5
        LDRB R4, [R4]       //R4 <- byte with nibble
        AND R1, R1, 1       //R4 <- R4 & 1, if 0 even, if 1 odd
        CMP R1, 0
        ITE EQ
        UBFXEQ R0, R4, 0, 4 //R0 <- R4<3..0>
        UBFXNE R0, R4, 4, 4 //R0 <- R4<8..4>
        POP {R4, R5}
        BX LR

		.end

