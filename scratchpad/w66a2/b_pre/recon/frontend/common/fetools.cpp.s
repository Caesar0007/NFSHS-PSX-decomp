	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fetools.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	s_upper__FPc
	.ent	s_upper__FPc
s_upper__FPc:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$16,$4
	.set	macro
	.set	reorder

	move	$6,$2
	.set	noreorder
	.set	nomacro
	blez	$6,$L600
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$5,$16,$4
$L607:
	lbu	$3,0($5)
	#nop
	addu	$2,$3,-97
	sltu	$2,$2,26
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L605
	addu	$2,$3,224
	.set	macro
	.set	reorder

	sb	$2,0($5)
$L605:
	addu	$4,$4,1
	slt	$2,$4,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L607
	addu	$5,$16,$4
	.set	macro
	.set	reorder

$L600:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	s_upper__FPc
	.align	2
	.globl	s_lower__FPc
	.ent	s_lower__FPc
s_lower__FPc:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$16,$4
	.set	macro
	.set	reorder

	move	$6,$2
	.set	noreorder
	.set	nomacro
	blez	$6,$L608
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$5,$16,$4
$L615:
	lbu	$3,0($5)
	#nop
	addu	$2,$3,-65
	sltu	$2,$2,26
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L613
	addu	$2,$3,32
	.set	macro
	.set	reorder

	sb	$2,0($5)
$L613:
	addu	$4,$4,1
	slt	$2,$4,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L615
	addu	$5,$16,$4
	.set	macro
	.set	reorder

$L608:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	s_lower__FPc
	.align	2
	.globl	FeTools_DrawPSXButton__FUcUsii
	.ent	FeTools_DrawPSXButton__FUcUsii
FeTools_DrawPSXButton__FUcUsii:
	.frame	$sp,72,$31		# vars= 24, regs= 4/0, args= 32, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$18,64($sp)
	move	$18,$6
	move	$8,$0
	li	$2,48830			# 0x0000bebe
	sw	$17,60($sp)
	addu	$17,$7,1
	andi	$6,$5,0xffff
	sw	$2,36($sp)
	li	$2,80			# 0x00000050
	sw	$31,68($sp)
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L618
	sw	$16,56($sp)
	.set	macro
	.set	reorder

	li	$2,160			# 0x000000a0
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L619
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L620
	li	$2,35			# 0x00000023
	.set	macro
	.set	reorder

$L618:
	li	$4,26			# 0x0000001a
	li	$5,24			# 0x00000018
	addu	$6,$18,3
	addu	$7,$17,-2
	addu	$16,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	li	$4,27			# 0x0000001b
	li	$5,24			# 0x00000018
	addu	$6,$18,4
	addu	$7,$17,4
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L641
	sw	$16,24($sp)
	.set	macro
	.set	reorder

$L619:
	li	$4,28			# 0x0000001c
	li	$5,24			# 0x00000018
	move	$6,$18
	addu	$17,$17,-1
	move	$7,$17
	addu	$16,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	li	$4,29			# 0x0000001d
	li	$5,24			# 0x00000018
	addu	$6,$18,10
	move	$7,$17
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L641
	sw	$16,24($sp)
	.set	macro
	.set	reorder

$L620:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L621
	li	$2,4096			# 0x00001000
	.set	macro
	.set	reorder

	andi	$5,$5,0xffff
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L623
	slt	$2,$5,4097
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L629
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L626
	move	$4,$8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L643
	li	$5,24			# 0x00000018
	.set	macro
	.set	reorder

$L629:
	li	$2,16384			# 0x00004000
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L624
	li	$2,32768			# 0x00008000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L625
	move	$4,$8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L643
	li	$5,24			# 0x00000018
	.set	macro
	.set	reorder

$L623:
	li	$8,18			# 0x00000012
	.set	noreorder
	.set	nomacro
	j	$L617
	addu	$17,$17,-3
	.set	macro
	.set	reorder

$L624:
	li	$8,19			# 0x00000013
	.set	noreorder
	.set	nomacro
	j	$L617
	addu	$17,$17,-4
	.set	macro
	.set	reorder

$L625:
	li	$8,20			# 0x00000014
	.set	noreorder
	.set	nomacro
	j	$L617
	addu	$17,$17,-2
	.set	macro
	.set	reorder

$L626:
	li	$8,21			# 0x00000015
	.set	noreorder
	.set	nomacro
	j	$L617
	addu	$17,$17,-1
	.set	macro
	.set	reorder

$L621:
	andi	$5,$5,0xffff
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L632
	slt	$2,$5,4097
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L638
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L635
	move	$4,$8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L643
	li	$5,24			# 0x00000018
	.set	macro
	.set	reorder

$L638:
	li	$2,16384			# 0x00004000
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L633
	li	$2,32768			# 0x00008000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L634
	move	$4,$8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L643
	li	$5,24			# 0x00000018
	.set	macro
	.set	reorder

$L632:
	li	$8,15			# 0x0000000f
	.set	noreorder
	.set	nomacro
	j	$L617
	addu	$17,$17,-3
	.set	macro
	.set	reorder

$L633:
	li	$8,12			# 0x0000000c
	.set	noreorder
	.set	nomacro
	j	$L617
	addu	$17,$17,-3
	.set	macro
	.set	reorder

$L634:
	li	$8,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	j	$L617
	addu	$17,$17,-3
	.set	macro
	.set	reorder

$L635:
	li	$8,16			# 0x00000010
	addu	$18,$18,2
$L617:
	move	$4,$8
	li	$5,24			# 0x00000018
$L643:
	move	$6,$18
	move	$7,$17
	addu	$2,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
$L641:
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
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

	.end	FeTools_DrawPSXButton__FUcUsii
	.rdata
	.align	2
$LC0:
	.ascii	"%stiny.pfn\000"
	.align	2
$LC1:
	.ascii	"%ssmall.pfn\000"
	.align	2
$LC2:
	.ascii	"%stitle.pfn\000"
	.text
	.align	2
	.globl	FeTools_init__Fv
	.ent	FeTools_init__Fv
FeTools_init__Fv:
	.frame	$sp,280,$31		# vars= 256, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,280
	sw	$31,276($sp)
	.set	noreorder
	.set	nomacro
	jal	Font_ExitFromGame__Fv
	sw	$16,272($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$16,%hi(Paths_Paths) # high
	addiu	$16,$16,%lo(Paths_Paths) # low
	lui	$5,%hi($LC0) # high
	lw	$6,132($16)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadrz
	move	$5,$0
	.set	macro
	.set	reorder

	move	$4,$2
	li	$5,960			# 0x000003c0
	li	$6,385			# 0x00000181
	move	$7,$0
	lui	$2,%hi(font12) # high
	.set	noreorder
	.set	nomacro
	jal	Font_LoadFont__FPciic
	sw	$4,%lo(font12)($2)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC1) # high
	lw	$6,132($16)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC1) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadrz
	move	$5,$0
	.set	macro
	.set	reorder

	move	$4,$2
	li	$5,896			# 0x00000380
	li	$6,256			# 0x00000100
	move	$7,$0
	lui	$2,%hi(font18) # high
	.set	noreorder
	.set	nomacro
	jal	Font_LoadFont__FPciic
	sw	$4,%lo(font18)($2)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC2) # high
	lw	$6,132($16)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC2) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadrz
	move	$5,$0
	.set	macro
	.set	reorder

	move	$4,$2
	li	$5,960			# 0x000003c0
	li	$6,256			# 0x00000100
	move	$7,$0
	lui	$2,%hi(fontTitle) # high
	.set	noreorder
	.set	nomacro
	jal	Font_LoadFont__FPciic
	sw	$4,%lo(fontTitle)($2)
	.set	macro
	.set	reorder

	lui	$3,%hi(currentSize) # high
	lw	$31,276($sp)
	lw	$16,272($sp)
	li	$2,3			# 0x00000003
	sh	$2,%lo(currentSize)($3)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,280
	.set	macro
	.set	reorder

	.end	FeTools_init__Fv
	.align	2
	.globl	FeTools_deinit__Fv
	.ent	FeTools_deinit__Fv
FeTools_deinit__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(font18) # high
	lw	$4,%lo(font18)($2)
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	purgememadr
	lui	$2,%hi(fontTitle) # high
	lw	$4,%lo(fontTitle)($2)
	jal	purgememadr
	lui	$2,%hi(font12) # high
	lw	$4,%lo(font12)($2)
	jal	purgememadr
	jal	Font_DeInit__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FeTools_deinit__Fv
	.align	2
	.globl	FeTools_FormatMoney__FPcl
	.ent	FeTools_FormatMoney__FPcl
FeTools_FormatMoney__FPcl:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,32($sp)
	move	$18,$4
	sw	$17,28($sp)
	li	$17,32			# 0x00000020
	sw	$16,24($sp)
	.set	noreorder
	bgez	$5,1f
	move	$16,$5
	subu	$16,$0,$16
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	bgez	$5,$L649
	sw	$31,36($sp)
	.set	macro
	.set	reorder

	li	$17,45			# 0x0000002d
$L649:
	slt	$2,$16,1000
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L650
	li	$2,983040			# 0x000f0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,131			# 0x00000083
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$2
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$16
	.set	macro
	.set	reorder

	j	$L648
$L650:
	ori	$2,$2,0x423f
	slt	$2,$2,$16
	bne	$2,$0,$L652
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,132			# 0x00000084
	.set	macro
	.set	reorder

	li	$3,274857984			# 0x10620000
	ori	$3,$3,0x4dd3
	mult	$16,$3
	move	$4,$18
	move	$5,$2
	move	$6,$17
	sra	$2,$16,31
	mfhi	$11
	#nop
	#nop
	sra	$7,$11,6
	subu	$7,$7,$2
	sll	$2,$7,5
	subu	$2,$2,$7
	sll	$2,$2,2
	addu	$2,$2,$7
	sll	$2,$2,3
	.set	noreorder
	.set	nomacro
	j	$L655
	subu	$2,$16,$2
	.set	macro
	.set	reorder

$L652:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,133			# 0x00000085
	.set	macro
	.set	reorder

	li	$3,1125842944			# 0x431b0000
	ori	$3,$3,0xde83
	mult	$16,$3
	mfhi	$8
	#nop
	li	$3,274857984			# 0x10620000
	ori	$3,$3,0x4dd3
	mult	$16,$3
	move	$4,$18
	move	$5,$2
	sra	$9,$16,31
	sra	$7,$8,18
	subu	$7,$7,$9
	sll	$2,$7,5
	subu	$2,$2,$7
	sll	$8,$2,6
	subu	$8,$8,$2
	sll	$8,$8,3
	addu	$8,$8,$7
	mfhi	$10
	#nop
	sll	$8,$8,6
	subu	$8,$16,$8
	mult	$8,$3
	move	$6,$17
	sra	$3,$10,6
	subu	$3,$3,$9
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,3
	subu	$2,$16,$2
	sra	$8,$8,31
	sw	$2,20($sp)
	mfhi	$12
	#nop
	#nop
	sra	$2,$12,6
	subu	$2,$2,$8
$L655:
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L648:
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	FeTools_FormatMoney__FPcl
	.globl	currentSize
	.section .data,"aw",@progbits
	.align	2
currentSize:
	.space	2
