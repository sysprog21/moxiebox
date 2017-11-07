/*
 * Input:
 * $r0	-- pointer to return buffer
 * $r1	-- length of return buffer
 *
 * Output:
 * none
 */

	.globl	setreturn
	.type	setreturn,@function
	.text
setreturn:
	ssr	$r0, 6
	ssr	$r1, 7
	ret

.Lend:
	.size	setreturn,.Lend-setreturn
