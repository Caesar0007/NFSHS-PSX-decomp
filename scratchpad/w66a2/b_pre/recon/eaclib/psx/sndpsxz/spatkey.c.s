	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\spatkey.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDpatchkey
	.align	2
	.globl	iSNDcalcvol
	.align	2
	.globl	iSNDpsxkeyon
	.align	2
	.globl	iSNDpsxkeyoff
	.align	2
	.globl	iSNDpsxeffecton
	.align	2
	.globl	iSNDpsxeffectoff
	.align	2
	.globl	iSNDpsxeffectvol
	.align	2
	.globl	iSNDsetvol
	.align	2
	.globl	iSNDsetslot
	.align	2
	.globl	iSNDstartvoice

	.text
	.def	iSNDpatchkey;	.val	iSNDpatchkey;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpatchkey
iSNDpatchkey:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	chan;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	tag;	.val	5;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs) # high
	addiu	$7,$2,%lo(sndgs) # low
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	lw	$3,148($7)
	sll	$2,$2,2
	addu	$3,$3,$2
	lbu	$6,55($3)
	#nop
	beq	$6,$0,$L2
	lw	$2,0($5)
	#nop
	addu	$2,$2,1
	sw	$2,0($5)
	lbu	$3,17($7)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	move	$4,$7
	.set	macro
	.set	reorder

	li	$7,1			# 0x00000001
$L4:
	lw	$3,0($5)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$3,148($4)
	sll	$2,$2,2
	addu	$3,$3,$2
	lbu	$2,55($3)
	#nop
	bne	$2,$6,$L7
	lb	$2,11($3)
	#nop
	bne	$2,$7,$L7
	lw	$2,0($3)
	#nop
	bgez	$2,$L13
$L7:
	lw	$2,0($5)
	#nop
	addu	$2,$2,1
	sw	$2,0($5)
	lbu	$3,17($4)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	move	$2,$0
	.set	macro
	.set	reorder

	j	$L14
$L2:
	lw	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L14
	move	$2,$0
	.set	macro
	.set	reorder

	sw	$4,0($5)
$L13:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.def	no_key;	.val	$L9;	.scl	6;	.type	0x0;	.endef
$L9:
	move	$2,$0
$L14:
	j	$31

	.loc	1 0
LM1:
	.end	iSNDpatchkey
	.def	iSNDcalcvol;	.val	iSNDcalcvol;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDcalcvol
iSNDcalcvol:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	chan;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$5,%hi(sndgs) # high
	addiu	$5,$5,%lo(sndgs) # low
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	lw	$3,148($5)
	sll	$2,$2,2
	addu	$4,$3,$2
	lb	$3,44($4)
	lh	$2,30($4)
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	lh	$2,38($4)
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	lb	$2,61($5)
	#nop
	mult	$3,$2
	mflo	$2
	#nop
	li	$3,1099300864			# 0x41860000
	ori	$3,$3,0x143d
	mult	$2,$3
	lw	$5,80($4)
	sra	$2,$2,31
	mfhi	$3
	#nop
	#nop
	sra	$3,$3,19
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L16
	sb	$3,45($4)
	.set	macro
	.set	reorder

	lbu	$2,58($4)
	sll	$3,$3,24
	addu	$2,$5,$2
	lb	$2,0($2)
	sra	$3,$3,24
	mult	$3,$2
	mflo	$3
	#nop
	li	$2,-2130575360			# 0x81020000
	ori	$2,$2,0x0409
	mult	$3,$2
	mfhi	$2
	#nop
	#nop
	addu	$2,$2,$3
	sra	$2,$2,6
	sra	$3,$3,31
	subu	$2,$2,$3
	sb	$2,45($4)
$L16:
	lw	$3,68($4)
	#nop
	beq	$3,$0,$L18
	lb	$2,45($4)
	#nop
	addu	$2,$3,$2
	lbu	$2,0($2)
	#nop
	sb	$2,45($4)
$L18:
	j	$31

	.loc	1 0
LM2:
	.end	iSNDcalcvol
	.def	iSNDpsxkeyon;	.val	iSNDpsxkeyon;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpsxkeyon
iSNDpsxkeyon:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	mask;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndpd) # high
	addiu	$2,$2,%lo(sndpd) # low
	#.set	volatile
	lw	$3,1300($2)
	#.set	novolatile
	#nop
	#.set	volatile
	sh	$4,392($3)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($2)
	#.set	novolatile
	sra	$4,$4,16
	#.set	volatile
	sh	$4,394($2)
	#.set	novolatile
	j	$31

	.loc	1 0
LM3:
	.end	iSNDpsxkeyon
	.def	iSNDpsxkeyoff;	.val	iSNDpsxkeyoff;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpsxkeyoff
iSNDpsxkeyoff:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	mask;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndpd) # high
	addiu	$2,$2,%lo(sndpd) # low
	#.set	volatile
	lw	$3,1300($2)
	#.set	novolatile
	#nop
	#.set	volatile
	sh	$4,396($3)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($2)
	#.set	novolatile
	sra	$4,$4,16
	#.set	volatile
	sh	$4,398($2)
	#.set	novolatile
	j	$31

	.loc	1 0
LM4:
	.end	iSNDpsxkeyoff
	.def	iSNDpsxeffecton;	.val	iSNDpsxeffecton;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSNDpsxeffecton
iSNDpsxeffecton:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	mask;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$3,%hi(sndpd) # high
	addiu	$3,$3,%lo(sndpd) # low
	#.set	volatile
	lw	$5,1300($3)
	#.set	novolatile
	#nop
	#.set	volatile
	lhu	$2,408($5)
	#.set	novolatile
	#nop
	or	$2,$2,$4
	#.set	volatile
	sh	$2,408($5)
	#.set	novolatile
	#.set	volatile
	lw	$3,1300($3)
	#.set	novolatile
	#nop
	#.set	volatile
	lhu	$2,410($3)
	#.set	novolatile
	sra	$4,$4,16
	or	$2,$2,$4
	#.set	volatile
	sh	$2,410($3)
	#.set	novolatile
	j	$31

	.loc	1 0
LM5:
	.end	iSNDpsxeffecton
	.def	iSNDpsxeffectoff;	.val	iSNDpsxeffectoff;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSNDpsxeffectoff
iSNDpsxeffectoff:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	mask;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$5,%hi(sndpd) # high
	addiu	$5,$5,%lo(sndpd) # low
	#.set	volatile
	lw	$6,1300($5)
	#.set	novolatile
	#nop
	#.set	volatile
	lhu	$2,408($6)
	#.set	novolatile
	nor	$3,$0,$4
	and	$2,$2,$3
	#.set	volatile
	sh	$2,408($6)
	#.set	novolatile
	#.set	volatile
	lw	$3,1300($5)
	#.set	novolatile
	sra	$4,$4,16
	#.set	volatile
	lhu	$2,410($3)
	#.set	novolatile
	nor	$4,$0,$4
	and	$2,$2,$4
	#.set	volatile
	sh	$2,410($3)
	#.set	novolatile
	j	$31

	.loc	1 0
LM6:
	.end	iSNDpsxeffectoff
	.def	iSNDpsxeffectvol;	.val	iSNDpsxeffectvol;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpsxeffectvol
iSNDpsxeffectvol:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	left;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	right;	.val	5;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndpd) # high
	addiu	$2,$2,%lo(sndpd) # low
	#.set	volatile
	lw	$3,1300($2)
	#.set	novolatile
	#nop
	#.set	volatile
	sh	$4,388($3)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($2)
	#.set	novolatile
	#nop
	#.set	volatile
	sh	$5,390($2)
	#.set	novolatile
	j	$31

	.loc	1 0
LM7:
	.end	iSNDpsxeffectvol
	.def	iSNDsetvol;	.val	iSNDsetvol;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDsetvol
iSNDsetvol:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	chan;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	left;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	right;	.val	6;	.scl	17;	.type	0x4;	.endef
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,2
	subu	$2,$2,$4
	sll	$2,$2,2
	lui	$3,%hi(sndpd+216) # high
	addiu	$3,$3,%lo(sndpd+216) # low
	addu	$8,$2,$3
	addu	$9,$3,-216
	sll	$4,$4,4
	lw	$2,1296($9)
	#.set	volatile
	lbu	$3,31($8)
	#.set	novolatile
	addu	$7,$2,$4
	andi	$4,$3,0x00ff
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L25
	lui	$2,%hi(sndgs+16) # high
	.set	macro
	.set	reorder

	lbu	$3,%lo(sndgs+16)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L26
	sll	$2,$5,7
	.set	macro
	.set	reorder

	addu	$2,$2,$5
	andi	$2,$2,0x7fff
	sh	$2,0($7)
	sll	$2,$6,7
	addu	$2,$2,$6
	andi	$2,$2,0x7fff
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,2($7)
	.set	macro
	.set	reorder

$L26:
	lbu	$2,30($8)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L27
	addu	$3,$5,$6
	.set	macro
	.set	reorder

	bgez	$5,$L28
	subu	$5,$0,$5
$L28:
	.set	noreorder
	.set	nomacro
	bgez	$6,$L34
	slt	$2,$5,128
	.set	macro
	.set	reorder

	subu	$6,$0,$6
$L34:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L35
	slt	$2,$6,128
	.set	macro
	.set	reorder

	li	$5,127			# 0x0000007f
$L35:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L27
	addu	$3,$5,$6
	.set	macro
	.set	reorder

	li	$6,127			# 0x0000007f
	addu	$3,$5,$6
$L27:
	sll	$2,$3,7
	addu	$2,$2,$3
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L32
	andi	$4,$2,0x7fff
	.set	macro
	.set	reorder

$L25:
	lbu	$3,%lo(sndgs+16)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L33
	sll	$2,$5,7
	.set	macro
	.set	reorder

	addu	$2,$2,$5
	andi	$2,$2,0x7fff
	sh	$2,0($7)
	sh	$0,2($7)
	#.set	volatile
	lbu	$2,32($8)
	#.set	novolatile
	lw	$3,1296($9)
	sll	$2,$2,24
	sra	$2,$2,20
	addu	$7,$3,$2
	sll	$2,$6,7
	addu	$2,$2,$6
	andi	$2,$2,0x7fff
	sh	$0,0($7)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,2($7)
	.set	macro
	.set	reorder

$L33:
	addu	$2,$2,$5
	sra	$2,$2,1
	andi	$4,$2,0x7fff
	sll	$2,$6,7
	addu	$2,$2,$6
	sra	$2,$2,1
	sh	$4,0($7)
	sh	$4,2($7)
	andi	$4,$2,0x7fff
	#.set	volatile
	lbu	$3,32($8)
	#.set	novolatile
	lw	$2,1296($9)
	sll	$3,$3,24
	sra	$3,$3,20
	addu	$7,$2,$3
$L32:
	sh	$4,0($7)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$4,2($7)
	.set	macro
	.set	reorder


	.loc	1 0
LM8:
	.end	iSNDsetvol
	.def	iSNDsetslot;	.val	iSNDsetslot;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDsetslot
iSNDsetslot:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	chan;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	addr;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	pitch;	.val	6;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(DAT_80147e28) # high
	sll	$4,$4,4
	sra	$5,$5,3
	lw	$2,%lo(DAT_80147e28)($2)
	li	$3,15			# 0x0000000f
	addu	$2,$2,$4
	sh	$3,8($2)
	li	$3,5			# 0x00000005
	sh	$3,10($2)
	li	$3,512			# 0x00000200
	sh	$6,4($2)
	sh	$5,6($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$3,14($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM9:
	.end	iSNDsetslot
	.def	iSNDstartvoice;	.val	iSNDstartvoice;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSNDstartvoice
iSNDstartvoice:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	.def	chan;	.val	18;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$4
	li	$4,1246560256			# 0x4a4d0000
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$2,$2,2
	subu	$2,$2,$18
	sll	$2,$2,2
	lui	$3,%hi(sndpd+216) # high
	sw	$20,32($sp)
	addiu	$20,$3,%lo(sndpd+216) # low
	sw	$16,16($sp)
	addu	$16,$2,$20
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	#.set	volatile
	sb	$0,36($16)
	#.set	novolatile
	#.set	volatile
	sb	$0,37($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,8($16)
	#.set	novolatile
	ori	$4,$4,0xc96f
	multu	$2,$4
	#.set	volatile
	lw	$5,0($16)
	#.set	novolatile
	move	$4,$18
	mfhi	$8
	#nop
	#nop
	srl	$21,$8,7
	.set	noreorder
	.set	nomacro
	jal	iSNDsetslot
	move	$6,$21
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sll	$19,$2,$18
	li	$2,2			# 0x00000002
	#.set	volatile
	sb	$2,28($16)
	#.set	novolatile
	#.set	volatile
	sb	$2,29($16)
	#.set	novolatile
	#.set	volatile
	sb	$0,38($16)
	#.set	novolatile
	#.set	volatile
	lbu	$3,31($16)
	#.set	novolatile
	li	$2,2			# 0x00000002
	bne	$3,$2,$L38
	#.set	volatile
	lbu	$2,32($16)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,2
	subu	$3,$3,$2
	sll	$3,$3,2
	#.set	volatile
	lbu	$2,39($16)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	.set	noreorder
	.set	nomacro
	bltz	$2,$L39
	addu	$17,$3,$20
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$2,39($16)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	sra	$2,$2,22
	addu	$2,$20,$2
	lw	$2,1056($2)
	#nop
	lw	$7,8($2)
	.set	noreorder
	.set	nomacro
	j	$L42
	move	$6,$21
	.set	macro
	.set	reorder

$L39:
	li	$4,613548032			# 0x24920000
	#.set	volatile
	lw	$2,4($16)
	#.set	novolatile
	#.set	volatile
	lw	$5,4($16)
	#.set	novolatile
	ori	$4,$4,0x4925
	srl	$3,$5,2
	multu	$3,$4
	mfhi	$3
	#nop
	srl	$2,$2,2
	multu	$2,$4
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	mfhi	$7
	#nop
	beq	$5,$2,$L41
	addu	$7,$7,1
$L41:
	sll	$7,$7,4
	move	$6,$21
$L42:
	#.set	volatile
	lbu	$4,32($16)
	#.set	novolatile
	#.set	volatile
	lw	$5,0($16)
	#.set	novolatile
	sll	$4,$4,24
	sra	$4,$4,24
	.set	noreorder
	.set	nomacro
	jal	iSNDsetslot
	addu	$5,$5,$7
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$3,32($16)
	#.set	novolatile
	li	$2,2			# 0x00000002
	#.set	volatile
	sb	$2,28($17)
	#.set	novolatile
	#.set	volatile
	sb	$2,29($17)
	#.set	novolatile
	li	$2,1			# 0x00000001
	#.set	volatile
	sb	$0,38($17)
	#.set	novolatile
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$2,$3
	or	$19,$19,$2
$L38:
	#.set	volatile
	lbu	$5,34($16)
	#.set	novolatile
	move	$4,$18
	sll	$5,$5,24
	.set	noreorder
	.set	nomacro
	jal	iSNDvol
	sra	$5,$5,24
	.set	macro
	.set	reorder

	move	$4,$18
	#.set	volatile
	lbu	$6,35($16)
	#.set	novolatile
	move	$5,$0
	sll	$6,$6,24
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformfxlevel
	sra	$6,$6,24
	.set	macro
	.set	reorder

	move	$2,$19
	lw	$31,40($sp)
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
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM10:
	.end	iSNDstartvoice
