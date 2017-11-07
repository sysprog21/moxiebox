/* crt0.S -- startup file for moxiebox
 */

	.globl	__start
	.weak	_start
	.text
	.type	__start,@function
__start:
_start:
	/* zero fp to allow unwinders to stop */
	xor	$fp, $fp

	/* load sim stack pointer */
	gsr	$sp, 7

	/* zero the bss area */
	ldi.l	$r0, __bss_start__
	xor	$r1, $r1
	ldi.l	$r2, __bss_end__
	sub	$r2, $r0
	jsra	memset

	/* load sim memory descriptor base address */
	gsr	$r0, 6
	sta.l	moxie_memmap, $r0

	/* Set argc and argv (empty). */
	xor	$r0, $r0
	xor	$r1, $r1

	/* Call _init to invoke static constructors, etc.  */
	jsra	_init
	
	/* Call _fini at exit time for static destructors.  */
	ldi.l	$r0, _fini
	jsra	atexit

	jsra	main
	jsra	exit

.Lend:
	.size	__start,(.Lend-__start)
