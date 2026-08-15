	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\felines.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	PSXDrawBrightEndLine__Fiiiiiiii
	.ent	PSXDrawBrightEndLine__Fiiiiiiii
PSXDrawBrightEndLine__Fiiiiiiii:
	.frame	$sp,48,$31		# vars= 0, regs= 1/0, args= 40, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	lw	$2,64($sp)
	lw	$3,68($sp)
	lw	$8,72($sp)
	lw	$9,76($sp)
	sw	$31,40($sp)
	sw	$0,32($sp)
	sw	$2,16($sp)
	sw	$3,20($sp)
	sw	$8,24($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXTransDrawBrightEndLine__Fiiiiiiiii
	sw	$9,28($sp)
	.set	macro
	.set	reorder

	lw	$31,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	PSXDrawBrightEndLine__Fiiiiiiii
	.align	2
	.globl	PSXTransDrawBrightEndLine__Fiiiiiiiii
	.ent	PSXTransDrawBrightEndLine__Fiiiiiiiii
PSXTransDrawBrightEndLine__Fiiiiiiiii:
	.frame	$sp,72,$31		# vars= 0, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$22,56($sp)
	lw	$22,88($sp)
	sw	$fp,64($sp)
	lw	$fp,92($sp)
	sw	$23,60($sp)
	lw	$23,96($sp)
	sw	$19,44($sp)
	move	$19,$4
	sw	$18,40($sp)
	move	$18,$5
	sw	$20,48($sp)
	move	$20,$6
	sw	$21,52($sp)
	move	$21,$7
	sw	$16,32($sp)
	li	$16,128			# 0x00000080
	sw	$31,68($sp)
	.set	noreorder
	.set	nomacro
	beq	$23,$16,$L601
	sw	$17,36($sp)
	.set	macro
	.set	reorder

	li	$5,16711680			# 0x00ff0000
	ori	$5,$5,0xffff
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	li	$6,64			# 0x00000040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L603
	move	$3,$2
	.set	macro
	.set	reorder

	sltu	$2,$fp,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L604
	subu	$2,$16,$23
	.set	macro
	.set	reorder

	mult	$22,$2
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L624
	sra	$16,$2,7
	.set	macro
	.set	reorder

	addu	$2,$2,127
	sra	$16,$2,7
$L624:
	sra	$7,$2,10
	slt	$2,$7,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	move	$17,$21
	.set	macro
	.set	reorder

	li	$7,8			# 0x00000008
$L606:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$fp,$2,$L607
	addu	$2,$20,$22
	.set	macro
	.set	reorder

	move	$4,$18
	addu	$5,$20,$16
	subu	$5,$5,$7
	move	$6,$17
	sw	$19,16($sp)
	sw	$19,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L622
	sw	$3,24($sp)
	.set	macro
	.set	reorder

$L607:
	subu	$20,$2,$16
	move	$4,$18
	move	$5,$20
	move	$6,$17
	sw	$3,16($sp)
	sw	$3,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L623
	sw	$19,24($sp)
	.set	macro
	.set	reorder

$L604:
	mult	$21,$2
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L625
	sra	$17,$2,7
	.set	macro
	.set	reorder

	addu	$2,$2,127
	sra	$17,$2,7
$L625:
	sra	$7,$2,10
	slt	$2,$7,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L611
	move	$16,$22
	.set	macro
	.set	reorder

	li	$7,8			# 0x00000008
$L611:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$fp,$2,$L612
	addu	$4,$18,$17
	.set	macro
	.set	reorder

	addu	$2,$18,$21
	subu	$18,$2,$17
	move	$4,$18
	move	$5,$20
	move	$6,$7
	move	$7,$16
	sw	$3,16($sp)
	sw	$19,20($sp)
	sw	$3,24($sp)
$L623:
	.set	noreorder
	.set	nomacro
	jal	PSXDrawGouraudSquare__Fiiiiiiii
	sw	$19,28($sp)
	.set	macro
	.set	reorder

	j	$L614
$L612:
	subu	$4,$4,$7
	move	$5,$20
	move	$6,$7
	move	$7,$16
	sw	$19,16($sp)
	sw	$3,20($sp)
	sw	$19,24($sp)
$L622:
	.set	noreorder
	.set	nomacro
	jal	PSXDrawGouraudSquare__Fiiiiiiii
	sw	$3,28($sp)
	.set	macro
	.set	reorder

	j	$L614
$L603:
	move	$17,$21
	move	$16,$22
$L614:
	lw	$8,100($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L615
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$fp,$2,$L626
	addu	$4,$18,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$23,$0,$L627
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	addu	$4,$18,$17
$L626:
	move	$5,$20
	lw	$8,100($sp)
	move	$7,$16
	sw	$19,16($sp)
	sw	$0,20($sp)
	sw	$19,24($sp)
	sw	$0,28($sp)
	subu	$4,$4,$8
	.set	noreorder
	.set	nomacro
	jal	PSXDrawGouraudSquare__Fiiiiiiii
	move	$6,$8
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
$L627:
	.set	noreorder
	.set	nomacro
	beq	$fp,$2,$L628
	move	$4,$18
	.set	macro
	.set	reorder

	bne	$23,$0,$L615
$L628:
	move	$5,$20
	lw	$6,100($sp)
	move	$7,$16
	sw	$0,16($sp)
	sw	$19,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawGouraudSquare__Fiiiiiiii
	sw	$19,28($sp)
	.set	macro
	.set	reorder

$L615:
	lw	$8,104($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L620
	move	$4,$19
	.set	macro
	.set	reorder

	sw	$16,16($sp)
	move	$5,$18
	move	$6,$20
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	move	$7,$17
	.set	macro
	.set	reorder

	j	$L601
$L620:
	move	$5,$18
	move	$6,$20
	move	$7,$17
	li	$2,1			# 0x00000001
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L601:
	lw	$31,68($sp)
	lw	$fp,64($sp)
	lw	$23,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	PSXTransDrawBrightEndLine__Fiiiiiiiii
