	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\feapp.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	__14tFEApplication
	.ent	__14tFEApplication
__14tFEApplication:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$23,44($sp)
	move	$23,$4
	sw	$16,16($sp)
	addu	$16,$23,44
	move	$4,$16
	sw	$31,48($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	addu	$17,$23,344
	move	$4,$17
	lui	$18,%hi(tDialogBase_vtable) # high
	addiu	$18,$18,%lo(tDialogBase_vtable) # low
	li	$21,288			# 0x00000120
	li	$20,-1			# 0xffffffff
	lui	$19,%hi(tDialogMessageString_vtable) # high
	addiu	$19,$19,%lo(tDialogMessageString_vtable) # low
	li	$22,128			# 0x00000080
	sw	$18,96($16)
	sw	$0,112($16)
	sh	$0,110($16)
	sh	$0,130($16)
	sh	$0,126($16)
	sh	$0,124($16)
	sh	$0,108($16)
	sh	$0,106($16)
	sh	$0,104($16)
	sh	$0,102($16)
	sh	$21,128($16)
	sh	$20,100($16)
	sh	$0,136($16)
	sw	$0,120($16)
	sw	$19,96($16)
	sw	$0,148($16)
	sw	$0,132($16)
	sw	$0,120($16)
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$22,140($16)
	.set	macro
	.set	reorder

	addu	$16,$23,568
	move	$4,$16
	lui	$2,%hi(tDialogHelp_vtable) # high
	addiu	$2,$2,%lo(tDialogHelp_vtable) # low
	sw	$18,96($17)
	sw	$2,96($17)
	li	$2,1400			# 0x00000578
	sw	$0,112($17)
	sh	$0,110($17)
	sh	$0,130($17)
	sh	$0,126($17)
	sh	$0,124($17)
	sh	$0,108($17)
	sh	$0,106($17)
	sh	$0,104($17)
	sh	$0,102($17)
	sh	$21,128($17)
	sh	$20,100($17)
	sh	$0,136($17)
	sw	$0,120($17)
	sh	$20,144($17)
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$2,120($17)
	.set	macro
	.set	reorder

	addu	$17,$23,720
	move	$4,$17
	lui	$2,%hi(tDialogMessageStringWithTimeout_vtable) # high
	addiu	$2,$2,%lo(tDialogMessageStringWithTimeout_vtable) # low
	sw	$18,96($16)
	sw	$19,96($16)
	sw	$2,96($16)
	li	$2,1152			# 0x00000480
	sw	$0,112($16)
	sh	$0,110($16)
	sh	$0,130($16)
	sh	$0,126($16)
	sh	$0,124($16)
	sh	$0,108($16)
	sh	$0,106($16)
	sh	$0,104($16)
	sh	$0,102($16)
	sh	$21,128($16)
	sh	$20,100($16)
	sh	$0,136($16)
	sw	$0,120($16)
	sw	$0,148($16)
	sw	$0,132($16)
	sw	$0,120($16)
	sw	$22,140($16)
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$2,120($16)
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,-1			# 0xffffffff
	move	$3,$23
	lui	$2,%hi(tDialogNoInputMessage_vtable) # high
	addiu	$2,$2,%lo(tDialogNoInputMessage_vtable) # low
	sw	$18,96($17)
	sw	$0,112($17)
	sh	$0,110($17)
	sh	$0,130($17)
	sh	$0,126($17)
	sh	$0,124($17)
	sh	$0,108($17)
	sh	$0,106($17)
	sh	$0,104($17)
	sh	$0,102($17)
	sh	$21,128($17)
	sh	$20,100($17)
	sh	$0,136($17)
	sw	$0,120($17)
	sw	$19,96($17)
	sw	$0,148($17)
	sw	$0,132($17)
	sw	$0,120($17)
	sw	$22,140($17)
	sw	$2,96($17)
$L662:
	sw	$0,872($3)
	sw	$0,880($3)
	sw	$5,888($3)
	addu	$4,$4,1
	slt	$2,$4,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L662
	addu	$3,$3,4
	.set	macro
	.set	reorder

	move	$2,$23
	lw	$31,48($sp)
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

	.end	__14tFEApplication
	.align	2
	.globl	_._14tFEApplication
	.ent	_._14tFEApplication
_._14tFEApplication:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	addu	$4,$17,720
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,568
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,344
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,44
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	andi	$16,$16,0x0001
	beq	$16,$0,$L696
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$17
	.set	macro
	.set	reorder

$L696:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	_._14tFEApplication
	.align	2
	.globl	PerformMenuInitialization__14tFEApplication
	.ent	PerformMenuInitialization__14tFEApplication
PerformMenuInitialization__14tFEApplication:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(frontEnd+833) # high
	sw	$31,16($sp)
	sw	$0,0($4)
	lbu	$2,%lo(frontEnd+833)($2)
	#nop
	sll	$4,$2,3
	addu	$4,$4,$2
	sll	$4,$4,2
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Volume__Fi
	sra	$4,$4,6
	.set	macro
	.set	reorder

	jal	InitializeClass__11tDialogBase
	jal	Clock_SystemStartUp__Fv
	move	$4,$0
	lui	$3,%hi(Draw_gDoVSync) # high
	li	$2,1			# 0x00000001
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetABR__Fib
	sw	$2,%lo(Draw_gDoVSync)($3)
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

	.end	PerformMenuInitialization__14tFEApplication
	.align	2
	.globl	PerformMenuDestruction__14tFEApplication
	.ent	PerformMenuDestruction__14tFEApplication
PerformMenuDestruction__14tFEApplication:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Clock_SystemCleanUp__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$17,$0
$L699:
	sll	$2,$17,16
	sra	$2,$2,14
	addu	$16,$18,$2
	lw	$3,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L704
	addu	$2,$17,1
	.set	macro
	.set	reorder

	lw	$2,96($3)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	addu	$2,$17,1
$L704:
	move	$17,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L699
	sw	$0,12($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_StopSong__Fi
	li	$4,1000			# 0x000003e8
	.set	macro
	.set	reorder

	lui	$2,%hi(Draw_gDoVSync) # high
	move	$4,$0
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetABR__Fib
	sw	$0,%lo(Draw_gDoVSync)($2)
	.set	macro
	.set	reorder

	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	PerformMenuDestruction__14tFEApplication
	.align	2
	.globl	DrawHelpIcons__14tFEApplication
	.ent	DrawHelpIcons__14tFEApplication
DrawHelpIcons__14tFEApplication:
	.frame	$sp,112,$31		# vars= 48, regs= 7/0, args= 32, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$17,84($sp)
	move	$17,$4
	sw	$21,100($sp)
	li	$21,7864320			# 0x00780000
	lui	$2,%hi(screenheight) # high
	lw	$2,%lo(screenheight)($2)
	ori	$21,$21,0x6e14
	sw	$19,92($sp)
	li	$19,14			# 0x0000000e
	sw	$31,104($sp)
	sw	$20,96($sp)
	sw	$18,88($sp)
	sw	$16,80($sp)
	sw	$21,36($sp)
	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L706
	addu	$18,$2,-25
	.set	macro
	.set	reorder

	lh	$2,100($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L732
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

	sb	$0,73($sp)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,252			# 0x000000fc
	.set	macro
	.set	reorder

	addu	$17,$sp,56
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$16,$2,-1
	.set	noreorder
	.set	nomacro
	bltz	$16,$L733
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

	li	$20,917504			# 0x000e0000
	addu	$4,$sp,72
$L734:
	sra	$5,$20,16
	sll	$6,$18,16
	sra	$6,$6,16
	move	$7,$21
	addu	$18,$18,-8
	addu	$2,$17,$16
	lbu	$2,0($2)
	addu	$16,$16,-1
	sb	$2,72($sp)
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$16,$L734
	addu	$4,$sp,72
	.set	macro
	.set	reorder

	lui	$2,%hi(gPadinfo) # high
$L733:
	addiu	$4,$2,%lo(gPadinfo) # low
	lbu	$2,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L713
	addu	$18,$18,8
	.set	macro
	.set	reorder

	lbu	$3,5($4)
	li	$2,35			# 0x00000023
	bne	$3,$2,$L712
$L713:
	lbu	$2,36($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L735
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

	lbu	$3,37($4)
	li	$2,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L735
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

$L712:
	addu	$18,$18,-8
	li	$4,53			# 0x00000035
	li	$5,24			# 0x00000018
	move	$6,$19
	move	$7,$18
	addu	$2,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gPadinfo) # high
$L735:
	addiu	$4,$2,%lo(gPadinfo) # low
	lbu	$2,5($4)
	li	$3,35			# 0x00000023
	beq	$2,$3,$L717
	lbu	$2,37($4)
	#nop
	bne	$2,$3,$L705
$L717:
	li	$4,54			# 0x00000036
	li	$5,24			# 0x00000018
	addu	$6,$19,-1
	addu	$7,$18,-9
	addu	$2,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	j	$L705
$L706:
	lui	$2,%hi(gPadinfo) # high
$L732:
	addiu	$4,$2,%lo(gPadinfo) # low
	lbu	$2,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L721
	li	$2,35			# 0x00000023
	.set	macro
	.set	reorder

	lbu	$3,5($4)
	#nop
	bne	$3,$2,$L720
$L721:
	lbu	$2,36($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L736
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

	lbu	$3,37($4)
	li	$2,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L736
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

$L720:
	li	$4,53			# 0x00000035
	li	$5,24			# 0x00000018
	move	$6,$19
	move	$7,$18
	addu	$2,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	addu	$19,$19,14
	lui	$2,%hi(gPadinfo) # high
$L736:
	addiu	$4,$2,%lo(gPadinfo) # low
	lbu	$2,5($4)
	li	$3,35			# 0x00000023
	beq	$2,$3,$L723
	lbu	$2,37($4)
	#nop
	bne	$2,$3,$L722
$L723:
	li	$4,54			# 0x00000036
	li	$5,24			# 0x00000018
	move	$6,$19
	move	$7,$18
	addu	$2,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	addu	$19,$19,15
$L722:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,252			# 0x000000fc
	.set	macro
	.set	reorder

	move	$4,$2
	sll	$5,$19,16
	sra	$5,$5,16
	sll	$6,$18,16
	sra	$6,$6,16
	move	$7,$21
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,252			# 0x000000fc
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$2
	.set	macro
	.set	reorder

	li	$4,252			# 0x000000fc
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$2
	.set	macro
	.set	reorder

	addu	$3,$19,5
	subu	$16,$16,$2
	lw	$2,4($17)
	addu	$19,$3,$16
	lw	$2,92($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L725
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$4,8($17)
	#nop
	beq	$4,$0,$L724
	lw	$2,92($4)
	#nop
	beq	$2,$0,$L724
$L725:
	li	$3,1			# 0x00000001
$L724:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L705
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

	addiu	$4,$2,%lo(gPadinfo) # low
	lbu	$2,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L729
	li	$2,35			# 0x00000023
	.set	macro
	.set	reorder

	lbu	$3,5($4)
	#nop
	bne	$3,$2,$L728
$L729:
	lbu	$2,36($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L737
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

	lbu	$3,37($4)
	li	$2,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L737
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

$L728:
	li	$4,55			# 0x00000037
	li	$5,24			# 0x00000018
	move	$6,$19
	move	$7,$18
	addu	$2,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	addu	$19,$19,14
	lui	$2,%hi(gPadinfo) # high
$L737:
	addiu	$4,$2,%lo(gPadinfo) # low
	lbu	$2,5($4)
	li	$3,35			# 0x00000023
	beq	$2,$3,$L731
	lbu	$2,37($4)
	#nop
	bne	$2,$3,$L730
$L731:
	li	$4,56			# 0x00000038
	li	$5,24			# 0x00000018
	move	$6,$19
	move	$7,$18
	addu	$2,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	addu	$19,$19,15
$L730:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,253			# 0x000000fd
	.set	macro
	.set	reorder

	move	$4,$2
	sll	$5,$19,16
	sra	$5,$5,16
	sll	$6,$18,16
	sra	$6,$6,16
	move	$7,$21
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L705:
	lw	$31,104($sp)
	lw	$21,100($sp)
	lw	$20,96($sp)
	lw	$19,92($sp)
	lw	$18,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	DrawHelpIcons__14tFEApplication
	.align	2
	.globl	Redraw__14tFEApplication
	.ent	Redraw__14tFEApplication
Redraw__14tFEApplication:
	.frame	$sp,112,$31		# vars= 56, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$18,88($sp)
	move	$18,$4
	sw	$31,108($sp)
	sw	$22,104($sp)
	sw	$21,100($sp)
	sw	$20,96($sp)
	sw	$19,92($sp)
	sw	$17,84($sp)
	sw	$16,80($sp)
	lbu	$22,556($18)
	.set	noreorder
	.set	nomacro
	jal	FeAudio_systemtask__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Draw_StartFrameRender__Fv
	lui	$17,%hi(Draw_gPlayer1View) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(Draw_gPlayer1View)($17)
	jal	Draw_StartRenderingView__Fi
	jal	largestunused
	addu	$4,$sp,24
	lui	$5,%hi(D_80010044) # high
	addiu	$5,$5,%lo(D_80010044) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	li	$5,256			# 0x00000100
	li	$6,215			# 0x000000d7
	li	$7,3			# 0x00000003
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	jal	AudioMus_Buffered__Fv
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Threshold__Fv
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	lui	$5,%hi(D_80010048) # high
	addiu	$5,$5,%lo(D_80010048) # low
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	li	$5,16			# 0x00000010
	li	$6,215			# 0x000000d7
	li	$7,3			# 0x00000003
	li	$2,2			# 0x00000002
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gFlip) # high
	lw	$4,%lo(Draw_gPlayer1View)($17)
	lw	$5,%lo(gFlip)($2)
	jal	Draw_GetDRAWENV__Fii
	lw	$3,8($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L739
	move	$21,$2
	.set	macro
	.set	reorder

	lui	$2,%hi(screenheight) # high
	lw	$2,%lo(screenheight)($2)
	#nop
	srl	$3,$2,31
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L740
	srl	$20,$2,1
	.set	macro
	.set	reorder

$L739:
	lui	$2,%hi(screenheight) # high
	lhu	$20,%lo(screenheight)($2)
$L740:
	jal	DrawAllDialogs__11tDialogBase
	.set	noreorder
	.set	nomacro
	jal	DrawHelpIcons__14tFEApplication
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$2,%hi(gPadinfo) # high
	addiu	$3,$2,%lo(gPadinfo) # low
	lbu	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L767
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lbu	$2,36($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

$L767:
	lw	$5,%lo(menuDefs)($2)
	#nop
	lw	$2,44($5)
	#nop
	ori	$2,$2,0x0001
	sw	$2,44($5)
	lw	$4,4($18)
	#nop
	lw	$2,8($4)
	li	$3,512			# 0x00000200
	sw	$3,72($sp)
	sll	$2,$2,2
	addu	$4,$4,$2
	lw	$3,16($4)
	addu	$2,$5,44
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L765
	lui	$2,%hi(gPadinfo+4) # high
	.set	macro
	.set	reorder

	addu	$4,$5,176
	move	$5,$0
	addu	$6,$sp,72
	.set	noreorder
	.set	nomacro
	jal	ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand
	addu	$7,$sp,64
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L765
	lui	$2,%hi(gPadinfo+4) # high
	.set	macro
	.set	reorder

$L741:
	lw	$4,%lo(menuDefs)($2)
	#nop
	lw	$2,44($4)
	li	$3,-2			# 0xfffffffe
	and	$2,$2,$3
	sw	$2,44($4)
	lui	$2,%hi(gPadinfo+4) # high
$L765:
	lbu	$2,%lo(gPadinfo+4)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L745
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($2)
	#nop
	lw	$2,0($4)
	#nop
	ori	$2,$2,0x0001
	sw	$2,0($4)
	lw	$3,4($18)
	#nop
	lw	$2,8($3)
	#nop
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$3,16($3)
	li	$2,1024			# 0x00000400
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L747
	sw	$2,76($sp)
	.set	macro
	.set	reorder

	addu	$4,$3,176
	move	$5,$0
	addu	$6,$sp,76
	.set	noreorder
	.set	nomacro
	jal	ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand
	addu	$7,$sp,64
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L766
	li	$9,528482304			# 0x1f800000
	.set	macro
	.set	reorder

$L745:
	lw	$4,%lo(menuDefs)($2)
	#nop
	lw	$2,0($4)
	li	$3,-2			# 0xfffffffe
	and	$2,$2,$3
	sw	$2,0($4)
$L747:
	li	$9,528482304			# 0x1f800000
$L766:
	ori	$9,$9,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	addu	$5,$sp,56
	li	$19,1			# 0x00000001
	li	$17,16711680			# 0x00ff0000
	lw	$4,0($9)
	ori	$17,$17,0xffff
	sh	$0,56($sp)
	lhu	$3,2($21)
	li	$2,512			# 0x00000200
	sh	$2,60($sp)
	lui	$2,%hi(screenheight) # high
	lhu	$2,%lo(screenheight)($2)
	lw	$6,528482304
	li	$8,-16777216			# 0xff000000
	sh	$3,58($sp)
	sh	$2,62($sp)
	lw	$3,0($4)
	lw	$2,0($6)
	and	$3,$3,$8
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($6)
	addu	$3,$4,12
	sw	$3,0($9)
	and	$3,$4,$7
	and	$2,$2,$8
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetDrawArea
	sw	$2,0($6)
	.set	macro
	.set	reorder

	sll	$2,$20,16
$L768:
	sb	$19,556($18)
	andi	$3,$19,0x00ff
	sra	$2,$2,16
	mult	$3,$2
	andi	$2,$19,0x00ff
	sll	$2,$2,2
	addu	$2,$18,$2
	mflo	$10
	#nop
	#nop
	sh	$10,340($18)
	lw	$3,4($2)
	#nop
	beq	$3,$0,$L752
	lw	$2,104($3)
	#nop
	lh	$4,80($2)
	lw	$2,84($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L752:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,36($2)
	#nop
	beq	$3,$0,$L753
	lw	$2,104($3)
	#nop
	lh	$4,80($2)
	lw	$2,84($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L753:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$4,12($2)
	#nop
	beq	$4,$0,$L754
	jal	UpdateTransition__7tScreen
$L754:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,4($2)
	#nop
	beq	$3,$0,$L755
	lw	$2,104($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L755
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,4($2)
	#nop
	lw	$2,104($3)
	#nop
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L755:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$4,12($2)
	#nop
	beq	$4,$0,$L756
	.set	noreorder
	.set	nomacro
	jal	Draw__7tScreenb
	move	$5,$0
	.set	macro
	.set	reorder

$L756:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,4($2)
	#nop
	beq	$3,$0,$L757
	lw	$2,560($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L759
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$2,104($3)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	bne	$2,$0,$L760
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,4($2)
	#nop
	lw	$2,104($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	sltu	$16,$2,1
$L760:
	beq	$16,$0,$L758
$L759:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,4($2)
	#nop
	lw	$2,104($3)
	#nop
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L758:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,36($2)
	#nop
	beq	$3,$0,$L757
	lw	$2,104($3)
	#nop
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L757:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$4,12($2)
	#nop
	beq	$4,$0,$L762
	.set	noreorder
	.set	nomacro
	jal	Draw__7tScreenb
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L762:
	lw	$4,528482308
	addu	$5,$sp,56
	sh	$0,56($sp)
	lhu	$3,2($21)
	lhu	$6,340($18)
	li	$2,512			# 0x00000200
	addu	$3,$3,$6
	lw	$6,528482304
	li	$7,-16777216			# 0xff000000
	sh	$2,60($sp)
	sh	$20,62($sp)
	sh	$3,58($sp)
	lw	$3,0($4)
	lw	$2,0($6)
	and	$3,$3,$7
	and	$2,$2,$17
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$3,0($6)
	addu	$2,$4,12
	sw	$2,528482308
	and	$2,$4,$17
	and	$3,$3,$7
	or	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	SetDrawArea
	sw	$3,0($6)
	.set	macro
	.set	reorder

	addu	$2,$19,-1
	move	$19,$2
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L768
	sll	$2,$20,16
	.set	macro
	.set	reorder

	lui	$2,%hi(Draw_gPlayer1View) # high
	sb	$22,556($18)
	lw	$4,%lo(Draw_gPlayer1View)($2)
	jal	Draw_StopRenderingView__Fi
	jal	Draw_StopFrameRender__Fv
	lw	$31,108($sp)
	lw	$22,104($sp)
	lw	$21,100($sp)
	lw	$20,96($sp)
	lw	$19,92($sp)
	lw	$18,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	Redraw__14tFEApplication
	.align	2
	.globl	UpdateMusic__14tFEApplication
	.ent	UpdateMusic__14tFEApplication
UpdateMusic__14tFEApplication:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd+833) # high
	lbu	$2,%lo(frontEnd+833)($2)
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	sll	$4,$2,3
	addu	$4,$4,$2
	sll	$4,$4,2
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Volume__Fi
	sra	$4,$4,6
	.set	macro
	.set	reorder

	lw	$16,0($16)
	#nop
	andi	$2,$16,0x1000
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L770
	lui	$4,%hi(bigBuf+80) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_PlaySong__FPc
	addiu	$4,$4,%lo(bigBuf+80) # low
	.set	macro
	.set	reorder

	j	$L769
$L770:
	andi	$2,$16,0x2000
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L772
	lui	$4,%hi(bigBuf+88) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_PlaySong__FPc
	addiu	$4,$4,%lo(bigBuf+88) # low
	.set	macro
	.set	reorder

	j	$L769
$L772:
	andi	$2,$16,0x4000
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L774
	lui	$4,%hi(bigBuf+96) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_PlaySong__FPc
	addiu	$4,$4,%lo(bigBuf+96) # low
	.set	macro
	.set	reorder

	j	$L769
$L774:
	andi	$2,$16,0x8000
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L776
	lui	$4,%hi(bigBuf+108) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_PlaySong__FPc
	addiu	$4,$4,%lo(bigBuf+108) # low
	.set	macro
	.set	reorder

	j	$L769
$L776:
	.set	noreorder
	.set	nomacro
	jal	AudioMus_StopSong__Fi
	li	$4,1000			# 0x000003e8
	.set	macro
	.set	reorder

$L769:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	UpdateMusic__14tFEApplication
	.align	2
	.globl	SetMenu__14tFEApplicationsP5tMenu
	.ent	SetMenu__14tFEApplicationsP5tMenu
SetMenu__14tFEApplicationsP5tMenu:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$6
	sll	$2,$5,16
	sra	$3,$2,16
	sll	$2,$3,2
	addu	$2,$17,$2
	sw	$31,28($sp)
	sw	$18,24($sp)
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L778
	move	$18,$5
	.set	macro
	.set	reorder

	bne	$3,$0,$L780
	lw	$2,0($16)
	lw	$3,0($17)
	andi	$2,$2,0xf000
	beq	$2,$3,$L780
	.set	noreorder
	.set	nomacro
	jal	UpdateMusic__14tFEApplication
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L780:
	lw	$2,104($16)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L781
	sll	$2,$18,16
	.set	macro
	.set	reorder

	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$3,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L783
	sw	$16,20($2)
	.set	macro
	.set	reorder

	beq	$16,$0,$L783
	lw	$2,104($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L784
	move	$4,$17
	.set	macro
	.set	reorder

$L781:
	sra	$2,$2,14
	addu	$2,$17,$2
	sw	$16,20($2)
$L783:
	move	$4,$17
$L784:
	sll	$5,$18,16
	lw	$6,80($16)
	.set	noreorder
	.set	nomacro
	jal	SetScreen__14tFEApplicationsP7tScreen
	sra	$5,$5,16
	.set	macro
	.set	reorder

$L778:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	SetMenu__14tFEApplicationsP5tMenu
	.align	2
	.globl	SetScreen__14tFEApplicationsP7tScreen
	.ent	SetScreen__14tFEApplicationsP7tScreen
SetScreen__14tFEApplicationsP7tScreen:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sll	$5,$5,16
	sra	$5,$5,14
	addu	$4,$4,$5
	sw	$31,16($sp)
	lw	$2,12($4)
	#nop
	beq	$6,$2,$L785
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L785
	sw	$6,28($4)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L785
	move	$4,$2
	.set	macro
	.set	reorder

	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
	move	$6,$0
	.set	macro
	.set	reorder

$L785:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	SetScreen__14tFEApplicationsP7tScreen
	.align	2
	.globl	DisplayHelp__14tFEApplications
	.ent	DisplayHelp__14tFEApplications
DisplayHelp__14tFEApplications:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	addu	$4,$4,344
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sh	$5,144($4)
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

	.end	DisplayHelp__14tFEApplications
	.align	2
	.globl	FreeHelpShapeCluts__Fv
	.ent	FreeHelpShapeCluts__Fv
FreeHelpShapeCluts__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$0
	sw	$18,24($sp)
	lui	$18,%hi(gHelpShapes) # high
	sw	$31,28($sp)
	sw	$17,20($sp)
$L792:
	lw	$2,%lo(gHelpShapes)($18)
	sll	$17,$16,5
	addu	$3,$17,$2
	lw	$2,4($3)
	#nop
	beq	$2,$0,$L791
	lh	$4,4($3)
	jal	Texture_MenuReleaseClutId__Fs
	lw	$2,%lo(gHelpShapes)($18)
	#nop
	addu	$2,$17,$2
	sw	$0,4($2)
$L791:
	addu	$16,$16,1
	slt	$2,$16,59
	bne	$2,$0,$L792
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	FreeHelpShapeCluts__Fv
	.align	2
	.globl	RunDemoVideo__14tFEApplication
	.ent	RunDemoVideo__14tFEApplication
RunDemoVideo__14tFEApplication:
	.frame	$sp,72,$31		# vars= 40, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	subu	$sp,$sp,72
	sw	$18,64($sp)
	move	$18,$4
	sw	$31,68($sp)
	sw	$17,60($sp)
	sw	$16,56($sp)
	lw	$3,4($18)
	addu	$2,$2,176
	bne	$3,$2,$L795
	.set	noreorder
	.set	nomacro
	jal	AudioMus_StopSong__Fi
	li	$4,120			# 0x00000078
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeAudio_systemtask__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$3,4($18)
	#nop
	lw	$2,104($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	li	$5,2			# 0x00000002
	lw	$4,12($18)
	.set	noreorder
	.set	nomacro
	jal	TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
	move	$6,$0
	.set	macro
	.set	reorder

$L797:
	lw	$3,4($18)
	#nop
	lw	$2,104($3)
	move	$16,$0
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L801
	lw	$3,12($18)
	#nop
	lw	$2,96($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	bne	$2,$0,$L800
$L801:
	li	$16,1			# 0x00000001
$L800:
	beq	$16,$0,$L798
	.set	noreorder
	.set	nomacro
	jal	Redraw__14tFEApplication
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeAudio_systemtask__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L797
$L798:
	lw	$3,12($18)
	#nop
	lw	$2,96($3)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Audio_FECleanUp__Fv
	lui	$17,%hi(currentVideo) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Audio_DeInitDriver__Fv
	lui	$16,%hi(gLargestUnused) # high
	.set	macro
	.set	reorder

	jal	PSXFront_FreeDrawMemory__Fv
	jal	FeTools_deinit__Fv
	jal	FreeHelpShapeCluts__Fv
	jal	largestunused
	lbu	$4,%lo(currentVideo)($17)
	sw	$2,%lo(gLargestUnused)($16)
	addu	$4,$4,1
	.set	noreorder
	.set	nomacro
	jal	play_movie__Fc
	andi	$4,$4,0x00ff
	.set	macro
	.set	reorder

	jal	largestunused
	.set	noreorder
	.set	nomacro
	jal	PSXFront_AllocateDrawMemory__Fv
	sw	$2,%lo(gLargestUnused)($16)
	.set	macro
	.set	reorder

	jal	FeTools_init__Fv
	jal	DisplayLoadingText__7tScreen
	li	$4,55296			# 0x0000d800
	li	$5,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	jal	Audio_InitDriver__Fii
	ori	$5,$5,0x8000
	.set	macro
	.set	reorder

	jal	AudioCmn_LoadFESamples__Fv
	jal	LoadAllHelpShapes__Fv
	.set	noreorder
	.set	nomacro
	jal	UpdateMusic__14tFEApplication
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd+833) # high
	lbu	$2,%lo(frontEnd+833)($2)
	#nop
	sll	$4,$2,3
	addu	$4,$4,$2
	sll	$4,$4,2
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Volume__Fi
	sra	$4,$4,6
	.set	macro
	.set	reorder

	jal	largestunused
	lw	$5,4($18)
	#nop
	lw	$3,104($5)
	sw	$2,%lo(gLargestUnused)($16)
	lh	$4,16($3)
	lw	$2,20($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$5,$4
	.set	macro
	.set	reorder

	lw	$3,12($18)
	#nop
	lw	$2,96($3)
	#nop
	lh	$4,48($2)
	lw	$2,52($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	lw	$3,4($18)
	#nop
	lw	$2,104($3)
	#nop
	lh	$4,48($2)
	lw	$2,52($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	li	$5,2			# 0x00000002
	lw	$4,12($18)
	.set	noreorder
	.set	nomacro
	jal	TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu
	move	$6,$0
	.set	macro
	.set	reorder

	li	$2,1431633920			# 0x55550000
	lw	$4,%lo(currentVideo)($17)
	ori	$2,$2,0x5556
	addu	$4,$4,1
	mult	$4,$2
	sra	$3,$4,31
	mfhi	$7
	#nop
	#nop
	subu	$3,$7,$3
	sll	$2,$3,1
	addu	$2,$2,$3
	subu	$4,$4,$2
	sw	$4,%lo(currentVideo)($17)
$L795:
	lw	$31,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	RunDemoVideo__14tFEApplication
	.align	2
	.globl	MainLoop__14tFEApplicationP5tMenu
	.ent	MainLoop__14tFEApplicationP5tMenu
MainLoop__14tFEApplicationP5tMenu:
	.frame	$sp,408,$31		# vars= 352, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,408
	sw	$18,376($sp)
	move	$18,$4
	sw	$16,368($sp)
	move	$16,$5
	li	$8,-1			# 0xffffffff
	addu	$4,$sp,16
	move	$5,$0
	li	$6,8			# 0x00000008
	sw	$31,404($sp)
	sw	$fp,400($sp)
	sw	$23,396($sp)
	sw	$22,392($sp)
	sw	$21,388($sp)
	sw	$20,384($sp)
	sw	$19,380($sp)
	sw	$17,372($sp)
	sh	$8,336($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$0,344($sp)
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	PerformMenuInitialization__14tFEApplication
	sb	$0,557($18)
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	#nop
	sw	$2,356($sp)
	lui	$2,%hi(gFlip) # high
	sw	$0,%lo(gFlip)($2)
	sb	$0,556($18)
$L803:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,324($2)
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,4($2)
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,12($2)
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,20($2)
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,28($2)
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,560($2)
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,332($2)
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,36($2)
	lbu	$2,556($18)
	#nop
	addu	$2,$2,1
	sb	$2,556($18)
	andi	$2,$2,0x00ff
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L803
	move	$4,$18
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetMenu__14tFEApplicationsP5tMenu
	move	$6,$16
	.set	macro
	.set	reorder

	addu	$23,$sp,104
	lui	$8,%hi(ticks) # high
$L936:
	lw	$8,%lo(ticks)($8)
	li	$9,1			# 0x00000001
	sw	$9,348($sp)
	addu	$9,$sp,120
	sw	$9,364($sp)
	sw	$8,352($sp)
	sb	$0,556($18)
$L810:
	lbu	$2,556($18)
	#nop
	sltu	$2,$2,2
	beq	$2,$0,$L811
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$4,$18,$2
	lw	$2,20($4)
	#nop
	beq	$2,$0,$L818
	lw	$3,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L814
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$2,104($3)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L815
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,12($2)
	#nop
	beq	$3,$0,$L815
	lw	$2,96($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	sltu	$16,$0,$2
$L815:
	beq	$16,$0,$L818
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L814
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$2,104($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	move	$16,$2
$L814:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$4,20($2)
	#nop
	lw	$2,104($4)
	#nop
	lh	$3,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,$3
	.set	macro
	.set	reorder

	beq	$2,$0,$L820
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,4($2)
	.set	noreorder
	.set	nomacro
	j	$L821
	sw	$3,36($2)
	.set	macro
	.set	reorder

$L820:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,36($2)
$L821:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,20($2)
	#nop
	sw	$3,4($2)
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$4,4($2)
	#nop
	lw	$2,104($4)
	#nop
	lh	$3,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,$3
	.set	macro
	.set	reorder

	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L822
	sw	$0,20($2)
	.set	macro
	.set	reorder

	lw	$2,28($18)
	#nop
	bne	$2,$0,$L822
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,324($2)
	sw	$0,348($sp)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	j	$L823
	sw	$3,324($2)
	.set	macro
	.set	reorder

$L822:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$4,4($2)
	#nop
	lw	$2,104($4)
	#nop
	lh	$3,48($2)
	lw	$2,52($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,$3
	.set	macro
	.set	reorder

	lw	$8,344($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L823
	move	$4,$18
	.set	macro
	.set	reorder

	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$2,4($2)
	#nop
	lw	$6,88($2)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SetMenu__14tFEApplicationsP5tMenu
	sw	$0,344($sp)
	.set	macro
	.set	reorder

$L823:
	lui	$9,%hi(ticks) # high
	lw	$9,%lo(ticks)($9)
	#nop
	sw	$9,356($sp)
$L818:
	lbu	$2,556($18)
	li	$8,1			# 0x00000001
	bne	$2,$8,$L926
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,4($2)
	#nop
	beq	$3,$0,$L825
	lw	$2,104($3)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L825
	lhu	$9,336($sp)
	#nop
	sll	$2,$9,16
	bgez	$2,$L825
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,36($2)
	#nop
	beq	$3,$0,$L828
	lw	$2,104($3)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L825
$L828:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,4($2)
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,12($2)
	#nop
	beq	$3,$0,$L829
	lw	$2,96($3)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L829:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,12($2)
$L825:
	lbu	$2,556($18)
$L926:
	sll	$2,$2,2
	addu	$4,$18,$2
	lw	$2,28($4)
	#nop
	beq	$2,$0,$L834
	lw	$3,12($4)
	#nop
	beq	$3,$0,$L831
	lw	$2,96($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L834
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$4,$18,$2
	lw	$2,20($4)
	#nop
	bne	$2,$0,$L834
	lw	$3,12($4)
	#nop
	beq	$3,$0,$L831
	lw	$2,96($3)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L831:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,28($2)
	.set	noreorder
	.set	nomacro
	jal	largestunused
	sw	$3,12($2)
	.set	macro
	.set	reorder

	lui	$3,%hi(gLargestUnused) # high
	sw	$2,%lo(gLargestUnused)($3)
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$4,12($2)
	#nop
	lw	$2,96($4)
	#nop
	lh	$3,48($2)
	lw	$2,52($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,$3
	.set	macro
	.set	reorder

	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,28($2)
	lbu	$2,556($18)
	li	$5,2			# 0x00000002
	sll	$2,$2,$5
	addu	$2,$18,$2
	lw	$4,12($2)
	.set	noreorder
	.set	nomacro
	jal	TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu
	move	$6,$0
	.set	macro
	.set	reorder

$L834:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L917
	move	$4,$0
	.set	macro
	.set	reorder

	lbu	$fp,556($18)
	lw	$3,0($2)
	#nop
	andi	$2,$3,0x0010
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L838
	move	$17,$fp
	.set	macro
	.set	reorder

	lui	$8,%hi(frontEnd) # high
	addiu	$8,$8,%lo(frontEnd) # low
	lbu	$2,3($8)
	li	$9,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$9,$L837
	andi	$2,$3,0x0008
	.set	macro
	.set	reorder

	bne	$2,$0,$L837
$L838:
	li	$4,1			# 0x00000001
$L837:
	beq	$4,$0,$L839
	move	$17,$0
	li	$fp,1			# 0x00000001
$L839:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$5,4($2)
	#nop
	lw	$3,0($5)
	#nop
	andi	$2,$3,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L927
	andi	$2,$3,0x0040
	.set	macro
	.set	reorder

	lbu	$fp,557($18)
	#nop
	move	$17,$fp
$L927:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L928
	andi	$2,$3,0x0080
	.set	macro
	.set	reorder

	move	$fp,$0
	move	$17,$fp
$L928:
	beq	$2,$0,$L842
	li	$fp,1			# 0x00000001
	move	$17,$fp
$L842:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L843
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$2,104($5)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$5,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L843
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,12($2)
	#nop
	beq	$3,$0,$L843
	lw	$2,96($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	sltu	$16,$0,$2
$L843:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L917
	move	$22,$17
	.set	macro
	.set	reorder

	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,4($2)
	#nop
	lw	$2,104($3)
	#nop
	lh	$4,32($2)
	lw	$2,36($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	sw	$2,360($sp)
$L845:
	sll	$2,$22,16
	sra	$16,$2,16
	slt	$2,$fp,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L917
	move	$4,$16
	.set	macro
	.set	reorder

	sll	$2,$16,3
	lw	$5,360($sp)
	addu	$2,$23,$2
	.set	noreorder
	.set	nomacro
	jal	FEInput_GetKeyFromPlayer__F7tPlayerl
	sw	$0,0($2)
	.set	macro
	.set	reorder

	lw	$8,364($sp)
	sll	$4,$16,2
	addu	$5,$8,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L849
	sw	$2,0($5)
	.set	macro
	.set	reorder

	sb	$22,557($18)
$L849:
	addu	$2,$sp,$4
	lui	$9,%hi(ticks) # high
	lw	$3,%lo(ticks)($9)
	lw	$2,16($2)
	#nop
	subu	$3,$3,$2
	sltu	$3,$3,16
	beq	$3,$0,$L851
	lw	$2,0($5)
	lw	$8,360($sp)
	#nop
	and	$2,$8,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L929
	sll	$2,$22,16
	.set	macro
	.set	reorder

$L851:
	lw	$3,0($5)
	addu	$2,$18,$4
	sw	$3,332($2)
	sll	$2,$22,16
$L929:
	lw	$9,364($sp)
	sra	$16,$2,14
	addu	$17,$9,$16
	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L930
	sll	$2,$22,16
	.set	macro
	.set	reorder

	jal	GetTopMostDialog__11tDialogBase
	addu	$3,$sp,$16
	lw	$8,352($sp)
	move	$16,$2
	sw	$8,356($sp)
	sw	$8,16($3)
 #APP
 #NO_APP
	lw	$3,0($17)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L853
	addu	$4,$18,344
	.set	macro
	.set	reorder

	lw	$2,112($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L853
	li	$9,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	sw	$9,0($17)
	.set	macro
	.set	reorder

$L853:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L854
	sll	$2,$22,16
	.set	macro
	.set	reorder

	sra	$5,$2,16
	lw	$8,364($sp)
	sll	$2,$5,2
	addu	$6,$8,$2
	lw	$3,0($6)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L854
	sll	$7,$5,3
	.set	macro
	.set	reorder

	lw	$2,96($16)
	addu	$7,$23,$7
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

$L854:
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L856
	sll	$5,$22,16
	.set	macro
	.set	reorder

	sra	$5,$5,16
	sll	$6,$5,2
	sll	$7,$5,3
	addu	$7,$23,$7
	lw	$9,364($sp)
	lw	$2,96($3)
	addu	$6,$9,$6
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L856:
	sll	$2,$22,16
	sra	$5,$2,16
	lw	$8,364($sp)
	sll	$2,$5,2
	addu	$6,$8,$2
	lw	$2,0($6)
	li	$9,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$9,$L852
	sll	$7,$5,3
	.set	macro
	.set	reorder

	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,4($2)
	#nop
	lw	$2,104($3)
	addu	$7,$23,$7
	lh	$4,24($2)
	lw	$2,28($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L852:
	sll	$2,$22,16
$L930:
	sra	$2,$2,13
	addu	$2,$23,$2
	lw	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L859
	addu	$3,$2,-1
	.set	macro
	.set	reorder

	sltu	$2,$3,8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L859
	lui	$2,%hi($L915) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L915) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L915:
	.word	$L861
	.word	$L863
	.word	$L864
	.word	$L865
	.word	$L900
	.word	$L883
	.word	$L900
	.word	$L914
	.text
$L861:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lbu	$3,556($18)
	#nop
	sll	$4,$3,2
	addu	$4,$18,$4
	lw	$2,324($4)
	sll	$3,$3,6
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,4($4)
	addu	$2,$18,$2
	sw	$3,196($2)
	lbu	$3,556($18)
	#nop
	sll	$3,$3,2
	addu	$3,$18,$3
	lw	$2,324($3)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L862
	sw	$2,324($3)
	.set	macro
	.set	reorder

$L863:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,324($2)
$L862:
	sll	$2,$22,16
	sra	$2,$2,13
	addu	$2,$23,$2
	lbu	$5,556($18)
	lw	$6,4($2)
	.set	noreorder
	.set	nomacro
	jal	SetMenu__14tFEApplicationsP5tMenu
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L845
	addu	$22,$22,1
	.set	macro
	.set	reorder

$L864:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lbu	$3,556($18)
	#nop
	sll	$4,$3,2
	addu	$4,$18,$4
	lw	$2,324($4)
	sll	$3,$3,6
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,4($4)
	addu	$2,$18,$2
	sw	$3,196($2)
	lbu	$3,556($18)
	#nop
	sll	$3,$3,2
	addu	$3,$18,$3
	lw	$2,324($3)
 #APP
 #NO_APP
	li	$8,1			# 0x00000001
	sw	$8,344($sp)
 #APP
 #NO_APP
	addu	$2,$2,$8
	sw	$2,324($3)
	sll	$2,$22,16
	sra	$2,$2,13
	addu	$2,$23,$2
	lbu	$5,556($18)
	lw	$6,4($2)
	move	$3,$5
	sll	$3,$3,2
	addu	$3,$18,$3
	lhu	$3,324($3)
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	SetMenu__14tFEApplicationsP5tMenu
	sh	$3,336($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L859
	sw	$0,328($18)
	.set	macro
	.set	reorder

$L865:
	lbu	$4,556($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L931
	li	$8,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$2,$4
	sll	$2,$2,2
	addu	$2,$18,$2
	lhu	$9,336($sp)
	lw	$2,324($2)
	sll	$3,$9,16
	sra	$3,$3,16
	slt	$3,$3,$2
	bne	$3,$0,$L866
$L931:
	bne	$4,$8,$L868
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$2,324($2)
	#nop
	bgtz	$2,$L866
$L868:
	lbu	$4,556($18)
	#nop
	sll	$2,$4,2
	addu	$3,$18,$2
	lw	$2,560($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L869
	li	$9,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L859
	sw	$0,560($3)
	.set	macro
	.set	reorder

$L869:
	subu	$2,$9,$4
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,560($2)
	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$0,560($2)
$L866:
	lbu	$2,556($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L932
	li	$8,1			# 0x00000001
	.set	macro
	.set	reorder

	sll	$2,$2,2
	addu	$2,$18,$2
	lhu	$8,336($sp)
	lw	$2,324($2)
	sll	$3,$8,16
	sra	$3,$3,16
	bne	$2,$3,$L870
	lw	$2,8($18)
	#nop
	beq	$2,$0,$L870
	lw	$3,36($18)
	#nop
	beq	$3,$0,$L872
	lw	$2,104($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L872:
	lw	$3,40($18)
	#nop
	beq	$3,$0,$L873
	lw	$2,104($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L873:
	lw	$3,8($18)
	#nop
	lw	$2,104($3)
	li	$9,-1			# 0xffffffff
	sh	$9,336($sp)
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	li	$5,2			# 0x00000002
	lw	$4,16($18)
	.set	noreorder
	.set	nomacro
	jal	TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L874
	sw	$0,328($18)
	.set	macro
	.set	reorder

$L870:
	lbu	$2,556($18)
	li	$8,1			# 0x00000001
$L932:
	.set	noreorder
	.set	nomacro
	bne	$2,$8,$L874
	sll	$2,$2,2
	.set	macro
	.set	reorder

	addu	$2,$18,$2
	lw	$2,324($2)
	#nop
	bgtz	$2,$L923
	lw	$2,8($18)
	#nop
	beq	$2,$0,$L874
 #APP
 #NO_APP
	lhu	$9,336($sp)
	lw	$3,8($18)
	sll	$2,$9,16
	sra	$2,$2,16
	addu	$2,$2,-1
	sw	$2,324($18)
	lw	$2,104($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	lw	$3,36($18)
	#nop
	beq	$3,$0,$L876
	lw	$2,104($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L876:
	lw	$3,40($18)
	#nop
	beq	$3,$0,$L877
	lw	$2,104($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L877:
	li	$5,2			# 0x00000002
	move	$6,$0
	lw	$4,16($18)
	li	$8,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
	sh	$8,336($sp)
	.set	macro
	.set	reorder

	lw	$2,324($18)
	move	$4,$18
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$6,196($2)
	.set	noreorder
	.set	nomacro
	jal	SetMenu__14tFEApplicationsP5tMenu
	move	$5,$0
	.set	macro
	.set	reorder

$L874:
	lbu	$3,556($18)
	#nop
	sll	$2,$3,2
	addu	$2,$18,$2
	lw	$2,324($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L879
	li	$9,1			# 0x00000001
	.set	macro
	.set	reorder

$L923:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$3,556($18)
	#nop
	sll	$3,$3,2
	addu	$3,$18,$3
	lw	$2,324($3)
	#nop
	addu	$2,$2,-1
	sw	$2,324($3)
	lbu	$3,556($18)
	#nop
	sll	$2,$3,2
	addu	$2,$18,$2
	move	$5,$3
	lw	$2,324($2)
	sll	$3,$3,6
	sll	$2,$2,2
	addu	$2,$2,$3
	addu	$2,$18,$2
	lw	$6,196($2)
	.set	noreorder
	.set	nomacro
	jal	SetMenu__14tFEApplicationsP5tMenu
	move	$4,$18
	.set	macro
	.set	reorder

	lbu	$2,556($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,4($2)
	#nop
	lw	$2,104($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L859
	lbu	$3,556($18)
	#nop
	sll	$3,$3,2
	addu	$3,$18,$3
	lw	$2,324($3)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L859
	sw	$2,324($3)
	.set	macro
	.set	reorder

$L879:
	bne	$3,$9,$L859
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	move	$4,$9
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L845
	addu	$22,$22,1
	.set	macro
	.set	reorder

$L883:
	lbu	$4,556($18)
	li	$8,1			# 0x00000001
	subu	$2,$8,$4
	sll	$2,$2,2
	addu	$3,$18,$2
	lw	$2,560($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L884
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	sll	$2,$4,2
	addu	$2,$18,$2
	move	$9,$8
	.set	noreorder
	.set	nomacro
	j	$L859
	sw	$9,560($2)
	.set	macro
	.set	reorder

$L884:
	lui	$8,%hi(frontEnd) # high
	addiu	$8,$8,%lo(frontEnd) # low
	sw	$0,560($3)
	lbu	$3,4($8)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L933
	lui	$9,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_StopSong__Fi
	li	$4,400			# 0x00000190
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	Init_Memcard__FbT0
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$19,$0
	move	$17,$19
	lui	$20,%hi(FEApp) # high
	addu	$21,$sp,24
	slt	$2,$17,2
$L924:
	beq	$2,$0,$L888
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L888
	addu	$4,$17,661
	.set	macro
	.set	reorder

	lw	$16,%lo(FEApp)($20)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$16,720
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($20)
	sw	$2,144($16)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

$L894:
	lw	$4,%lo(FEApp)($20)
	#nop
	lw	$2,852($4)
	#nop
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L893
	lui	$9,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	jal	Redraw__14tFEApplication
	j	$L894
$L893:
	sll	$4,$17,16
	sra	$4,$4,16
	addiu	$9,$9,%lo(frontEnd) # low
	addu	$2,$17,$9
	lbu	$6,293($2)
	.set	noreorder
	.set	nomacro
	jal	SavePinkSlipsCarsWithErrorDialogs__Fsss
	move	$5,$0
	.set	macro
	.set	reorder

	move	$19,$2
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L897
	li	$8,1			# 0x00000001
	.set	macro
	.set	reorder

	bne	$17,$8,$L897
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,663			# 0x00000297
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$21
	move	$5,$16
	move	$6,$2
	.set	noreorder
	.set	nomacro
	jal	sprintf
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,1			# 0x00000001
	lw	$2,%lo(FEApp)($20)
	li	$6,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	SavePinkSlipsCarsWithErrorDialogs__Fsss
	sw	$21,864($2)
	.set	macro
	.set	reorder

$L897:
	lw	$4,%lo(FEApp)($20)
	addu	$17,$17,1
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L924
	slt	$2,$17,2
	.set	macro
	.set	reorder

$L888:
	jal	DeInit_Memcard__Fv
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L934
	lui	$8,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateMusic__14tFEApplication
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$9,%hi(frontEnd) # high
	addiu	$9,$9,%lo(frontEnd) # low
	lbu	$2,833($9)
	#nop
	sll	$4,$2,3
	addu	$4,$4,$2
	sll	$4,$4,2
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Volume__Fi
	sra	$4,$4,6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L845
	addu	$22,$22,1
	.set	macro
	.set	reorder

$L900:
	lui	$8,%hi(frontEnd) # high
$L934:
	addiu	$8,$8,%lo(frontEnd) # low
	lbu	$3,4($8)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L903
	lui	$9,%hi(frontEnd) # high
	.set	macro
	.set	reorder

$L933:
	addiu	$9,$9,%lo(frontEnd) # low
	lbu	$2,298($9)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L904
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(carManager) # low
	lui	$8,%hi(frontEnd) # high
	lbu	$2,556($18)
	addiu	$8,$8,%lo(frontEnd) # low
	addu	$2,$2,$8
	lbu	$5,92($2)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$sp,128
	.set	macro
	.set	reorder

	j	$L907
$L904:
	addiu	$4,$4,%lo(carManager) # low
	lui	$9,%hi(frontEnd) # high
	lbu	$2,556($18)
	addiu	$9,$9,%lo(frontEnd) # low
	move	$7,$2
	addu	$2,$2,$9
	lbu	$5,291($2)
	.set	noreorder
	.set	nomacro
	jal	GetGarageCar__11tCarManagersR8tCarInfos
	addu	$6,$sp,128
	.set	macro
	.set	reorder

	j	$L907
$L903:
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	lui	$8,%hi(frontEnd) # high
	lbu	$2,556($18)
	addiu	$8,$8,%lo(frontEnd) # low
	move	$7,$2
	addu	$2,$2,$8
	lbu	$5,293($2)
	.set	noreorder
	.set	nomacro
	jal	GetPinkSlipsCar__11tCarManagersR8tCarInfos
	addu	$6,$sp,128
	.set	macro
	.set	reorder

$L907:
	lbu	$2,320($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L935
	lui	$9,%hi(ticks) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	move	$4,$2
	.set	macro
	.set	reorder

	lui	$9,%hi(ticks) # high
$L935:
	lw	$16,%lo(ticks)($9)
	lui	$8,%hi(ticks) # high
$L925:
	lw	$2,%lo(ticks)($8)
	#nop
	subu	$2,$2,$16
	sltu	$2,$2,256
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L910
	lui	$2,%hi(GameSetup_gData+36) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeAudio_systemtask__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L925
	lui	$8,%hi(ticks) # high
	.set	macro
	.set	reorder

$L910:
	sw	$0,%lo(GameSetup_gData+36)($2)
	.set	noreorder
	.set	nomacro
	jal	PerformMenuDestruction__14tFEApplication
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L922
	move	$2,$0
	.set	macro
	.set	reorder

$L914:
	lui	$3,%hi(GameSetup_gData+36) # high
	li	$2,2			# 0x00000002
	sw	$2,%lo(GameSetup_gData+36)($3)
	.set	noreorder
	.set	nomacro
	jal	PerformMenuDestruction__14tFEApplication
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L922
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L859:
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L845
	addu	$22,$22,1
	.set	macro
	.set	reorder

$L917:
	lbu	$2,556($18)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L810
	sb	$2,556($18)
	.set	macro
	.set	reorder

$L811:
	lw	$9,348($sp)
	#nop
	beq	$9,$0,$L918
	.set	noreorder
	.set	nomacro
	jal	Redraw__14tFEApplication
	move	$4,$18
	.set	macro
	.set	reorder

$L918:
	lw	$8,352($sp)
	lw	$9,356($sp)
	#nop
	subu	$2,$8,$9
	slt	$2,$2,3841
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L936
	lui	$8,%hi(ticks) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	RunDemoVideo__14tFEApplication
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$8,%hi(ticks) # high
	lw	$2,%lo(ticks)($8)
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L936
	sw	$2,356($sp)
	.set	macro
	.set	reorder

$L922:
	lw	$31,404($sp)
	lw	$fp,400($sp)
	lw	$23,396($sp)
	lw	$22,392($sp)
	lw	$21,388($sp)
	lw	$20,384($sp)
	lw	$19,380($sp)
	lw	$18,376($sp)
	lw	$17,372($sp)
	lw	$16,368($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,408
	.set	macro
	.set	reorder

	.end	MainLoop__14tFEApplicationP5tMenu
	.align	2
	.globl	RunPostGame__14tFEApplication
	.ent	RunPostGame__14tFEApplication
RunPostGame__14tFEApplication:
	.frame	$sp,64,$31		# vars= 16, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$18,40($sp)
	lui	$2,%hi(frontEnd) # high
	sw	$16,32($sp)
	addiu	$16,$2,%lo(frontEnd) # low
	sw	$31,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$17,36($sp)
	lbu	$3,4($16)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L938
	move	$18,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L979
	lui	$2,%hi(Cars_gNewCarStatsList) # high
	.set	macro
	.set	reorder

	lbu	$2,298($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L938
	lui	$2,%hi(Cars_gNewCarStatsList) # high
	.set	macro
	.set	reorder

$L979:
	.set	noreorder
	.set	nomacro
	jal	StatChk_ClearNewRecords__Fv
	addiu	$21,$2,%lo(Cars_gNewCarStatsList) # low
	.set	macro
	.set	reorder

	move	$17,$0
	move	$20,$16
	li	$19,-1			# 0xffffffff
	move	$16,$18
$L940:
	move	$4,$17
	addu	$2,$17,$20
	lbu	$5,866($2)
	.set	noreorder
	.set	nomacro
	jal	Front_ResetPSXController__Fii
	addu	$17,$17,1
	.set	macro
	.set	reorder

	sw	$0,872($16)
	sw	$0,880($16)
	sw	$19,888($16)
	slt	$2,$17,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L940
	addu	$16,$16,4
	.set	macro
	.set	reorder

	move	$4,$21
	lui	$2,%hi(Cars_gNumRaceCars) # high
	lh	$5,%lo(Cars_gNumRaceCars)($2)
	.set	noreorder
	.set	nomacro
	jal	StatChk_IsRecordLapTime__FP10Car_tStatssPs
	addu	$6,$sp,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L944
	lui	$2,%hi(frontEnd+3) # high
	.set	macro
	.set	reorder

	lbu	$3,%lo(frontEnd+3)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L945
	li	$3,6			# 0x00000006
	.set	macro
	.set	reorder

	lh	$3,24($sp)
	li	$4,7			# 0x00000007
	sll	$2,$3,2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L946
	addu	$2,$18,$2
	.set	macro
	.set	reorder

	li	$4,8			# 0x00000008
$L946:
	.set	noreorder
	.set	nomacro
	j	$L948
	sw	$4,888($2)
	.set	macro
	.set	reorder

$L945:
	lh	$2,24($sp)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$3,888($2)
$L948:
	lh	$2,24($sp)
	li	$3,1			# 0x00000001
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$3,880($2)
$L944:
	lui	$2,%hi(Cars_gNumRaceCars) # high
	lh	$5,%lo(Cars_gNumRaceCars)($2)
	.set	noreorder
	.set	nomacro
	jal	StatChk_IsTopTime__FP10Car_tStatss
	move	$4,$21
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$4,$2,16
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L949
	lui	$2,%hi(frontEnd+3) # high
	.set	macro
	.set	reorder

	lbu	$2,%lo(frontEnd+3)($2)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L950
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	andi	$2,$4,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L951
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sw	$3,880($18)
	lw	$3,888($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L980
	andi	$2,$4,0x0002
	.set	macro
	.set	reorder

	lh	$2,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L952
	andi	$2,$4,0x0002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L976
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L976
	li	$2,13			# 0x0000000d
	.set	macro
	.set	reorder

$L952:
$L980:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L976
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
$L976:
	sw	$2,888($18)
$L951:
	andi	$2,$4,0x000c
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L949
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,892($18)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L959
	sw	$5,884($18)
	.set	macro
	.set	reorder

	lh	$2,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L981
	andi	$2,$4,0x0008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L960
	li	$2,11			# 0x0000000b
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L949
	sw	$2,892($18)
	.set	macro
	.set	reorder

$L960:
	li	$2,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	j	$L949
	sw	$2,892($18)
	.set	macro
	.set	reorder

$L959:
	andi	$2,$4,0x0008
$L981:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L963
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L949
	sw	$2,892($18)
	.set	macro
	.set	reorder

$L963:
	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	j	$L949
	sw	$2,892($18)
	.set	macro
	.set	reorder

$L950:
	sw	$3,880($18)
	lw	$3,888($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L966
	andi	$2,$4,0x0002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L977
	li	$2,9			# 0x00000009
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L977
	li	$2,12			# 0x0000000c
	.set	macro
	.set	reorder

$L966:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L970
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L949
	sw	$0,888($18)
	.set	macro
	.set	reorder

$L970:
$L977:
	sw	$2,888($18)
$L949:
	lw	$2,880($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L972
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	move	$4,$18
	lw	$3,%lo(menuDefs)($2)
	lui	$2,%hi(frontEnd+868) # high
	addiu	$2,$2,%lo(frontEnd+868) # low
	addu	$5,$3,14032
	addu	$3,$3,12728
	sw	$2,28($3)
	lui	$2,%hi(screenUserName) # high
	lw	$6,%lo(screenUserName)($2)
	li	$2,7			# 0x00000007
	sh	$0,128($3)
	sh	$2,32($3)
	sh	$0,36($3)
	sh	$0,34($3)
	.set	noreorder
	.set	nomacro
	j	$L978
	sw	$5,100($6)
	.set	macro
	.set	reorder

$L972:
	lw	$2,884($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L938
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	move	$4,$18
	lw	$3,%lo(menuDefs)($2)
	li	$2,1			# 0x00000001
	addu	$5,$3,14160
	addu	$3,$3,12868
	sh	$2,128($3)
	lui	$2,%hi(frontEnd+900) # high
	addiu	$2,$2,%lo(frontEnd+900) # low
	sw	$2,28($3)
	lui	$2,%hi(screenUserName) # high
	lw	$6,%lo(screenUserName)($2)
	li	$2,7			# 0x00000007
	sh	$2,32($3)
	sh	$0,36($3)
	sh	$0,34($3)
	.set	noreorder
	.set	nomacro
	j	$L978
	sw	$5,100($6)
	.set	macro
	.set	reorder

$L938:
	.set	noreorder
	.set	nomacro
	jal	MenuExtended_PostGameMenu__FR12tMenuCommand
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$5,20($sp)
	move	$4,$18
$L978:
	jal	MainLoop__14tFEApplicationP5tMenu
	lw	$31,56($sp)
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
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	RunPostGame__14tFEApplication
	.align	2
	.globl	RunFrontEnd__14tFEApplication
	.ent	RunFrontEnd__14tFEApplication
RunFrontEnd__14tFEApplication:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(menuDefs) # high
	lw	$5,%lo(menuDefs)($2)
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	MainLoop__14tFEApplicationP5tMenu
	addu	$5,$5,176
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

	.end	RunFrontEnd__14tFEApplication
	.globl	FEApp
	.data
	.align	2
FEApp:
	.space	4
	.globl	currentVideo
	.align	2
currentVideo:
	.space	4
	.globl	gLargestUnused
	.align	2
gLargestUnused:
	.space	4
