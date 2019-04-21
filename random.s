	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"random.c"
	.global	__aeabi_idivmod
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Valor: %d\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	mov	r3, #3
	str	r3, [fp, #-8]
	mov	r0, #0
	bl	time
	mov	r3, r0
	mov	r0, r3
	bl	srand
	bl	rand
	mov	r3, r0
	ldr	r1, [fp, #-8]
	mov	r0, r3
	bl	__aeabi_idivmod
	mov	r3, r1
	add	r3, r3, #1
	str	r3, [fp, #-8]
	ldr	r1, [fp, #-8]
	ldr	r0, .L3
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L4:
	.align	2
.L3:
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516"
	.section	.note.GNU-stack,"",%progbits
