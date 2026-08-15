	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\psx\\\\mdec.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"MDECstruct\000"
	.align	2
$LC1:
	.ascii	"MDEC buffers\000"
	.text
	.align	2
	.globl	initmdec
	.align	2
	.globl	restoremdec
	.align	2
	.globl	mdecreset__Fv
	.align	2
	.globl	mdec
	.align	2
	.globl	mdecdone
	.align	2
	.globl	MDECCompleteHandler__Fv

	.extern	timerhz, 4
	.extern	gMDECinfo, 8

	.text
	.text
	.ent	initmdec
initmdec:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$21,36($sp)
	move	$21,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$20,32($sp)
	move	$20,$6
	sw	$23,44($sp)
	move	$23,$7
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,44			# 0x0000002c
	move	$6,$23
	sw	$31,48($sp)
	sw	$22,40($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$18,$2
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,44			# 0x0000002c
	.set	macro
	.set	reorder

	li	$2,1128595456			# 0x43450000
	ori	$2,$2,0x444d
	lui	$22,%hi(gMDECinfo) # high
	sw	$2,0($18)
	lw	$2,%lo(gMDECinfo)($22)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L604
	addu	$3,$21,15
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DecDCTReset
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$4,%hi(MDECCompleteHandler__Fv) # high
	.set	noreorder
	.set	nomacro
	jal	DecDCToutCallback
	addiu	$4,$4,%lo(MDECCompleteHandler__Fv) # low
	.set	macro
	.set	reorder

	addu	$3,$21,15
$L604:
	li	$4,-16			# 0xfffffff0
	and	$3,$3,$4
	addu	$2,$19,15
	and	$2,$2,$4
	mult	$3,$2
	sw	$21,4($18)
	sw	$19,8($18)
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L602
	sw	$20,12($18)
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L602:
	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	sra	$2,$2,8
	sll	$16,$2,1
	addu	$16,$16,$2
	sll	$16,$16,8
	sll	$17,$20,4
	subu	$17,$17,$20
	sll	$17,$17,5
	addu	$16,$17,$16
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$23
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	blockclear
	sw	$4,36($18)
	.set	macro
	.set	reorder

	mult	$21,$20
	lw	$2,36($18)
	sh	$20,28($18)
	addu	$2,$2,$17
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L603
	sw	$2,40($18)
	.set	macro
	.set	reorder

	addu	$4,$4,15
$L603:
	lh	$2,28($18)
	sll	$3,$19,16
	sh	$19,22($18)
	sra	$19,$3,16
	mult	$2,$19
	sra	$3,$4,4
	sh	$3,20($18)
	sh	$19,30($18)
	mflo	$2
	#nop
	#nop
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,32($18)
	move	$2,$18
	lw	$3,%lo(gMDECinfo)($22)
	lw	$31,48($sp)
	lw	$23,44($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$3,$3,1
	sw	$3,%lo(gMDECinfo)($22)
	lw	$22,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	initmdec
	.text
	.ent	restoremdec
restoremdec:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$3,%hi(gMDECinfo) # high
	lw	$2,%lo(gMDECinfo)($3)
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	sw	$2,%lo(gMDECinfo)($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DecDCToutCallback
	move	$4,$0
	.set	macro
	.set	reorder

$L606:
	lw	$4,36($16)
	jal	purgememadr
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	sw	$0,0($4)
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

	.end	restoremdec
	.text
	.ent	mdecreset__Fv
mdecreset__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(gMDECinfo) # high
	lw	$3,%lo(gMDECinfo)($2)
	subu	$sp,$sp,24
	sw	$16,16($sp)
	addiu	$16,$2,%lo(gMDECinfo) # low
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L608
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DecDCTReset
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$4,%hi(MDECCompleteHandler__Fv) # high
	.set	noreorder
	.set	nomacro
	jal	DecDCToutCallback
	addiu	$4,$4,%lo(MDECCompleteHandler__Fv) # low
	.set	macro
	.set	reorder

$L608:
	sw	$0,4($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	mdecreset__Fv
	.text
	.ent	mdec
mdec:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	lui	$2,%hi(gMDECinfo) # high
	sw	$19,28($sp)
	addiu	$19,$2,%lo(gMDECinfo) # low
	lui	$2,%hi(ticks) # high
	sw	$18,24($sp)
	move	$18,$2
	lw	$2,timerhz
	lw	$3,%lo(ticks)($18)
	sw	$20,32($sp)
	move	$20,$4
	sw	$23,44($sp)
	move	$23,$5
	sw	$21,36($sp)
	move	$21,$6
	sw	$22,40($sp)
	move	$22,$7
	sw	$16,16($sp)
	move	$16,$20
	sw	$31,48($sp)
	sw	$17,20($sp)
	sll	$2,$2,2
	addu	$17,$3,$2
$L612:
	lw	$2,4($19)
	#nop
	beq	$2,$0,$L611
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($18)
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L612
	jal	mdecreset__Fv
	j	$L612
$L611:
	sw	$20,4($19)
	lw	$5,40($16)
	.set	noreorder
	.set	nomacro
	jal	DecDCTvlc
	addu	$4,$23,8
	.set	macro
	.set	reorder

	li	$5,2			# 0x00000002
	lw	$3,12($16)
	li	$2,24			# 0x00000018
	sh	$21,24($16)
	sh	$21,16($16)
	sh	$22,26($16)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L616
	sh	$22,18($16)
	.set	macro
	.set	reorder

	li	$5,3			# 0x00000003
$L616:
	lw	$4,40($16)
	jal	DecDCTin
	lw	$4,36($16)
	lw	$5,32($16)
	jal	DecDCTout
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

	.end	mdec
	.text
	.ent	mdecdone
mdecdone:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gMDECinfo) # high
	addiu	$2,$2,%lo(gMDECinfo) # low
	#.set	volatile
	lw	$2,4($2)
	#.set	novolatile
	#nop
	xor	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$0,$2
	.set	macro
	.set	reorder

	.end	mdecdone
	.text
	.ent	MDECCompleteHandler__Fv
MDECCompleteHandler__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(gMDECinfo) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(gMDECinfo) # low
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$16,4($17)
	#nop
	lw	$5,36($16)
	.set	noreorder
	.set	nomacro
	jal	LoadImage
	addu	$4,$16,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L619
	lui	$3,%hi(g_mdecdrawsyncfailed) # high
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,%lo(g_mdecdrawsyncfailed)($3)
$L619:
	lhu	$2,24($16)
	lhu	$3,12($16)
	lh	$4,20($16)
	addu	$2,$2,$3
	sh	$2,24($16)
	sll	$2,$2,16
	lh	$3,16($16)
	sra	$2,$2,16
	addu	$3,$3,$4
	slt	$2,$2,$3
	beq	$2,$0,$L620
	lw	$4,36($16)
	lw	$5,32($16)
	jal	DecDCTout
	j	$L618
$L620:
	sw	$0,4($17)
$L618:
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

	.end	MDECCompleteHandler__Fv
