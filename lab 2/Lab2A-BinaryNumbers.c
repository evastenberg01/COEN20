#include <stdio.h>

int32_t Bits2Signed(int8_t bits[8]); //converts an array of bits to a signed int
uint32_t Bits2Unsigned(int8_t bits[8]); //converts an array of bits to unsigned int
void Increment(int8_t bits[8]); // adds 1 to value represented
void Unsigned2Bits(uint32_t n, int8_t bits[8]); //converts unsigned int to array of bits

int32_t Bits2Signed(int8_t bits[8])
{ 
	int32_t val = Bits2Unsigned(bits); //binary to unsigned
	if(val >= 128){ //becomes negative after 128
		val -= 256;
	}
	return val;
}

uint32_t Bits2Unsigned(int8_t bits[8])
{
	uint32_t val = 0;
	for(int i = 7; i>=0; i--) //determines unsigned value
		val = 2*val + bits[i]; //poly exp
	return val;
}

void Increment(int8_t bits[8])
{
	int i;
	for(i = 0; i < 8; i++)
	{
		if(bits[i] == 0)//if 0
		{
			bits[i] = 1;//increment by 1
			break;
		}
		if(bits[i] == 1) //if 1
			bits[i] = 0;//decrement to 0
	}
	return;
}

void Unsigned2Bits(uint32_t n, int8_t bits[8])
{
	int i = 0;
	int r;
	while(i < 8)
	{
		r = n%2; //modulus gets assigned to r
		n = n/2; //new integer value through division
		bits[i] = r; //remainder becomes new bits
		i++;
	}
	return;
}
