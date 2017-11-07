/*
 * _exit interface for moxie simulator
 */

/*
 * Input:
 * $r0	-- exit value
 *
 * Output:
 * none
 */

	.globl	_exit
	.type	_exit,@function
	.text
_exit:
	swi	1	/* SYS_exit */
.Lend:
	.size	_exit,.Lend-_exit
