#include <syscall.h>

#include <ppc-asm.h>
#define r2 2

FUNC_START(_start)
	addis	r3,r2,scratch@toc@ha
	addi	r3,r3,scratch@toc@l

	/* Take the COW fault */
	stdx	r4,0,r3

1:	lbarx	r4,0,r3
	cmpdi	r4,2
	beq	2f
	cmpdi	r4,3
	beq	3f
	cmpdi	r4,4
	beq	4f
	cmpdi	r4,5
	beq	5f
	cmpdi	r4,6
	beq	6f
	cmpdi	r4,7
	beq	7f
	cmpdi	r4,8
	beq	8f
	stbcx.	r4,0,r3
	bne	1b

2:
3:
4:
5:
	nop
6:
7:
8:

	li	r0,SYS_exit
	li	r3,0
	sc
FUNC_END(_start)

	.section .data
	.balign 16
scratch:
	.space 16
