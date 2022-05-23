/*
	This code was written to support the book, "ARM Assembly for Embedded Applications",
	by Daniel W. Lewis. Permission is granted to freely share this software provided
	that this notice is not removed. This software is intended to be used with a run-time
    library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY 
    board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/
		.syntax     unified
		.cpu        cortex-m4
		.text

// ----------------------------------------------------------
// void OffBy0(void *dst, const void *src) 
// ----------------------------------------------------------

		.global		OffBy0
		.thumb_func
		.align
OffBy0:	            
		BX          LR


// ----------------------------------------------------------
// void OffBy1(void *dst, const void *src)
// ----------------------------------------------------------

		.global		OffBy1
		.thumb_func
		.align
OffBy1:	// R0 = op1, R1 = op2
		BX          LR
		

// ----------------------------------------------------------
// void OffBy2(void *dst, const void *src)
// ----------------------------------------------------------

		.global		OffBy2
		.thumb_func
		.align

OffBy2:	// R0 = op1, R1 = op2
		BX			LR

// ----------------------------------------------------------
// void OffBy3(void *dst, const void *src)
// ----------------------------------------------------------

		.global		OffBy3
		.thumb_func
		.align

OffBy3:	// R0 = op1, R1 = op2
		.end


