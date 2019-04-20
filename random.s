	.global	__aeabi_idivmod
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type main, %function 
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push  {fp, lr}
	add   fp, sp, #4
	sub   sp, sp, #8
	mov   r3, #3			@ numeros a generar
	str   r3, [fp, #-8]
	mov   r0, #0
	bl    time
	mov   r3, r0
	mov   r0, r3
	bl    srand
	bl    rand
	mov   r3, r0
	ldr   r1, [fp, #-8]
	mov   r0, r3
	bl    __aeabi_idivmod
	mov   r3, r1
	add   r3, r3, #1		@ Valor Random
	str   r3, [fp, #-8]
	LDR   R0, =display
	MOV   R1, R3
	BL    printf
	
	
	mov   r3, #0
	mov   r0, r3
	sub   sp, fp, #4
	@ sp needed
	pop   {fp, pc}

	mov   r7, #1
	swi   0
.data
display:
	.asciz "%d"
