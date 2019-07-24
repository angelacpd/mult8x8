# mult8x8
Sequential 8 x 8 bits multiplier

The input to the multiplier consists of two 8-bit multiplicands (dataa and datab). The output from the multiplier is a 16-bit product (product8x8_out).
Additional outputs are a done bit (DONE_FLAG) and seven signals to drive a seven segment display (seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, & seg_g).

This 8 x 8 multiplier requires four clock cycles to perform the full multiplication. During each cycle, a pair of 4-bit portion of the multiplicands is multiplied by a 4 x 4 multiplier. The multiplication result of these 4 bit slices is then accumulated. At the end of the four cycles (during the 5th cycle), the fully composed 16-bit product can be read at the output. The following equations illustrate the mathematical principles supporting this implementation: result[15..0]	=	a[7..0] * b[7..0] =	( (a[7..4] * 2^4) + a[3..0] * 2^0 ) * ( (b[7..4] * 2^4) + b[3..0] * 2^0 ) =	( (a[7..4] * b[7..4]) * 2^8) +	( (a[7..4] * b[3..0]) * 2^4) +	( (a[3..0] * b[7..4]) * 2^4) +	( (a[3..0] * b[3..0]) * 2^0)
