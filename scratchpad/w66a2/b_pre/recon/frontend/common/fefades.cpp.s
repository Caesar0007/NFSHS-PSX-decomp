	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fefades.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	CalcFadeVal__Fiii
	.ent	CalcFadeVal__Fiii
CalcFadeVal__Fiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,128			# 0x00000080
	subu	$3,$3,$6
	andi	$2,$4,0x00ff
	mult	$3,$2
	mflo	$10
	#nop
	andi	$2,$5,0x00ff
	mult	$6,$2
	mflo	$9
	#nop
	sra	$2,$4,8
	andi	$2,$2,0x00ff
	mult	$3,$2
	mflo	$8
	#nop
	sra	$2,$5,8
	andi	$2,$2,0x00ff
	mult	$6,$2
	mflo	$7
	#nop
	sra	$4,$4,16
	andi	$4,$4,0x00ff
	mult	$3,$4
	mflo	$2
	#nop
	sra	$5,$5,16
	andi	$5,$5,0x00ff
	mult	$6,$5
	addu	$4,$10,$9
	sra	$4,$4,7
	addu	$3,$8,$7
	sra	$3,$3,7
	sll	$3,$3,8
	mflo	$12
	#nop
	#nop
	addu	$2,$2,$12
	sra	$2,$2,7
	sll	$2,$2,16
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	or	$2,$2,$4
	.set	macro
	.set	reorder

	.end	CalcFadeVal__Fiii
	.align	2
	.globl	CalcFadeVal__Fii
	.ent	CalcFadeVal__Fii
CalcFadeVal__Fii:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$6,$5
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CalcFadeVal__Fii
	.align	2
	.globl	CalcFadeVal__Fiiii
	.ent	CalcFadeVal__Fiiii
CalcFadeVal__Fiiii:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	move	$16,$7
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	move	$6,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CalcFadeVal__Fiiii
	.align	2
	.globl	CalcTextFadeUnselToSel__F13tMenuTextTypess
	.ent	CalcTextFadeUnselToSel__F13tMenuTextTypess
CalcTextFadeUnselToSel__F13tMenuTextTypess:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$8,%hi(kRGBVals) # high
	lui	$7,%hi(textDefinitions) # high
	addiu	$7,$7,%lo(textDefinitions) # low
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,1
	addu	$3,$2,$7
	addiu	$8,$8,%lo(kRGBVals) # low
	addu	$2,$2,$7
	sll	$5,$5,16
	sll	$7,$6,16
	sra	$6,$5,16
	sw	$31,16($sp)
	lbu	$3,3($3)
	lbu	$2,4($2)
	sll	$3,$3,2
	addu	$3,$3,$8
	sll	$2,$2,2
	addu	$2,$2,$8
	lw	$4,0($3)
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiiii
	sra	$7,$7,16
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CalcTextFadeUnselToSel__F13tMenuTextTypess
	.align	2
	.globl	CalcTextFadeSelToHi__F13tMenuTextTypess
	.ent	CalcTextFadeSelToHi__F13tMenuTextTypess
CalcTextFadeSelToHi__F13tMenuTextTypess:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$6
	lui	$7,%hi(kRGBVals) # high
	lui	$6,%hi(textDefinitions) # high
	addiu	$6,$6,%lo(textDefinitions) # low
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,1
	addu	$3,$2,$6
	addiu	$7,$7,%lo(kRGBVals) # low
	addu	$2,$2,$6
	sll	$6,$5,16
	sw	$31,20($sp)
	lbu	$3,4($3)
	lbu	$2,5($2)
	sll	$3,$3,2
	addu	$3,$3,$7
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$4,0($3)
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	sra	$6,$6,16
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$0
	sll	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	sra	$6,$16,16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CalcTextFadeSelToHi__F13tMenuTextTypess
	.align	2
	.globl	CalcOnOffFade__F13tMenuTextTypesssRiT4
	.ent	CalcOnOffFade__F13tMenuTextTypesssRiT4
CalcOnOffFade__F13tMenuTextTypesssRiT4:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$19,28($sp)
	move	$19,$6
	sw	$20,32($sp)
	move	$20,$7
	sw	$17,20($sp)
	sll	$17,$5,16
	sra	$17,$17,16
	move	$6,$17
	lui	$7,%hi(kRGBVals) # high
	addiu	$7,$7,%lo(kRGBVals) # low
	lui	$5,%hi(textDefinitions) # high
	addiu	$5,$5,%lo(textDefinitions) # low
	sll	$3,$4,1
	addu	$3,$3,$4
	sll	$3,$3,1
	addu	$2,$3,$5
	addu	$4,$3,$5
	addu	$3,$3,$5
	sw	$31,52($sp)
	sw	$fp,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lbu	$2,4($2)
	lw	$23,72($sp)
	lw	$fp,76($sp)
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$16,0($2)
	lbu	$2,5($4)
	move	$4,$16
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$18,0($2)
	lbu	$2,3($3)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$21,0($2)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$16
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	move	$18,$2
	.set	macro
	.set	reorder

	move	$5,$16
	move	$6,$17
	move	$22,$2
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	move	$4,$21
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$21
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$18
	sll	$19,$19,16
	sra	$19,$19,16
	move	$6,$19
	sll	$20,$20,16
	sra	$20,$20,16
	move	$7,$20
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiiii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$22
	move	$6,$19
	move	$7,$20
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiiii
	sw	$2,0($23)
	.set	macro
	.set	reorder

	sw	$2,0($fp)
	lw	$31,52($sp)
	lw	$fp,48($sp)
	lw	$23,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	CalcOnOffFade__F13tMenuTextTypesssRiT4
