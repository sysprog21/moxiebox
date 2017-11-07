/*
 * _mmap interface for moxie simulator
 */

#include "syscall.h"

/*
 * Input (see mmap man page):
 * $r0	-- addr
 * $r1	-- length
 * $r2	-- prot
 * $r3	-- flags
 * $r4	-- fd
 * $r5	-- offset
 *
 * Output:
 * $r0	-- mmap value
 */

	.globl	mmap
	.type	mmap,@function
	.text
mmap:
	swi	90	/* SYS_mmap */
	ret
.Lend:
	.size	mmap,.Lend-mmap
