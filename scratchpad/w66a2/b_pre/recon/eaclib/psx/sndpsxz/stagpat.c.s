	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\stagpat.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDresetpatch
	.align	2
	.globl	iSNDresettimbre
	.align	2
	.globl	iSNDresolveheader
	.align	2
	.globl	iSNDfindfreekey
	.align	2
	.globl	iSNDplaytaggedtimbre
	.align	2
	.globl	iSNDplaytaggedpatch
	.align	2
	.globl	iSNDresolvetaggedpatch
	.align	2
	.globl	iSNDremovetaggedpatch

	.extern	DAT_801371cc, 5
	.extern	snddefaultenvelope, 1

	.text
	.def	iSNDresetpatch;	.val	iSNDresetpatch;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDresetpatch
iSNDresetpatch:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	patch;	.val	4;	.scl	17;	.type	0x4;	.endef
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,144($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDresetpatch
	.def	iSNDresettimbre;	.val	iSNDresettimbre;	.scl	2;	.type	0x6c;	.endef
	.text
	.ent	iSNDresettimbre
iSNDresettimbre:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	t;	.val	6;	.scl	17;	.type	0x14;	.endef
	.def	buf;	.val	5;	.scl	17;	.type	0x4;	.endef
	move	$6,$4
	li	$2,37			# 0x00000025
	addu	$5,$5,148
$L3:
	sw	$0,0($5)
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bgez	$2,$L3
	addu	$5,$5,-4
	.set	macro
	.set	reorder

	li	$4,127			# 0x0000007f
	li	$3,-1			# 0xffffffff
	li	$2,60			# 0x0000003c
	sw	$3,20($6)
	sw	$3,32($6)
	li	$3,1			# 0x00000001
	sw	$2,28($6)
	li	$2,64			# 0x00000040
	sw	$2,48($6)
	la	$2,snddefaultenvelope
	sw	$0,4($6)
	sw	$4,8($6)
	sw	$0,12($6)
	sw	$4,16($6)
	sw	$0,24($6)
	sw	$3,36($6)
	sw	$0,40($6)
	sw	$3,44($6)
	sw	$0,52($6)
	sw	$4,56($6)
	sw	$0,60($6)
	sw	$0,64($6)
	sw	$0,68($6)
	sw	$0,72($6)
	sw	$0,76($6)
	sw	$0,84($6)
	sw	$0,92($6)
	sw	$4,112($6)
	sw	$0,116($6)
	sw	$0,120($6)
	sw	$0,124($6)
	sw	$0,128($6)
	sw	$0,132($6)
	sw	$0,140($6)
	sw	$0,136($6)
	sw	$3,148($6)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,100($6)
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSNDresettimbre
	.def	iSNDresolveheader;	.val	iSNDresolveheader;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDresolveheader
iSNDresolveheader:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	hdr;	.val	4;	.scl	17;	.type	0x14;	.endef
	.def	out;	.val	5;	.scl	17;	.type	0x14;	.endef
	lw	$2,72($5)
	lw	$3,72($4)
	#nop
	addu	$2,$2,$3
	sw	$2,72($4)
	lw	$2,84($5)
	lw	$3,84($4)
	#nop
	addu	$2,$2,$3
	sw	$2,84($4)
	lw	$2,92($5)
	lw	$3,92($4)
	#nop
	addu	$2,$2,$3
	sw	$2,92($4)
	lw	$2,116($5)
	lw	$3,116($4)
	#nop
	addu	$2,$2,$3
	sw	$2,116($4)
	lw	$2,128($5)
	lw	$3,128($4)
	lw	$6,100($4)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L9
	sw	$2,128($4)
	.set	macro
	.set	reorder

	lw	$2,100($5)
	#nop
	addu	$2,$2,$6
	sw	$2,100($4)
$L9:
	j	$31

	.loc	1 0
LM3:
	.end	iSNDresolveheader
	.def	iSNDfindfreekey;	.val	iSNDfindfreekey;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDfindfreekey
iSNDfindfreekey:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	top;	.val	$L11;	.scl	6;	.type	0x0;	.endef
$L11:
	lui	$5,%hi(DAT_801371cc) # high
	lbu	$3,%lo(DAT_801371cc)($5)
	#nop
	addu	$2,$3,1
	sb	$2,%lo(DAT_801371cc)($5)
	andi	$2,$2,0x00ff
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	lui	$2,%hi(sndgs) # high
	.set	macro
	.set	reorder

	addu	$2,$3,2
	sb	$2,%lo(DAT_801371cc)($5)
	lui	$2,%hi(sndgs) # high
$L19:
	addiu	$2,$2,%lo(sndgs) # low
	lbu	$3,17($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L14
	move	$4,$0
	.set	macro
	.set	reorder

	move	$6,$3
	lbu	$5,%lo(DAT_801371cc)($5)
	lw	$3,148($2)
	.def	loop;	.val	$L15;	.scl	6;	.type	0x0;	.endef
$L15:
	lb	$2,11($3)
	#nop
	beq	$2,$0,$L16
	lbu	$2,55($3)
	#nop
	beq	$2,$5,$L11
$L16:
	addu	$4,$4,1
	slt	$2,$4,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L15
	addu	$3,$3,100
	.set	macro
	.set	reorder

	.def	done;	.val	$L14;	.scl	6;	.type	0x0;	.endef
$L14:
	lui	$2,%hi(DAT_801371cc) # high
	lbu	$2,%lo(DAT_801371cc)($2)
	j	$31

	.loc	1 0
LM4:
	.end	iSNDfindfreekey
	.def	iSNDplaytaggedtimbre;	.val	iSNDplaytaggedtimbre;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplaytaggedtimbre
iSNDplaytaggedtimbre:
	.frame	$sp,80,$31		# vars= 8, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	timbre;	.val	0;	.scl	9;	.type	0x4;	.endef
	.def	tag;	.val	22;	.scl	17;	.type	0x4;	.endef
	.def	vol;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	header;	.val	7;	.scl	17;	.type	0x4;	.endef
	.def	baseNote;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	velScale;	.val	20;	.scl	9;	.type	0x4;	.endef
	.def	pitchOff;	.val	24;	.scl	9;	.type	0x4;	.endef
	.def	baseNote;	.val	2;	.scl	4;	.type	0x4;	.endef
	.def	velScale;	.val	3;	.scl	4;	.type	0x4;	.endef
	.def	pitchOff;	.val	2;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,80
	sw	$22,64($sp)
	move	$22,$5
	sw	$18,48($sp)
	move	$18,$6
	sw	$4,80($sp)
	move	$4,$18
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	lb	$20,7($22)
	lb	$16,8($22)
	lb	$23,9($22)
	lb	$fp,10($22)
	.set	noreorder
	.set	nomacro
	jal	iSNDresolveheader
	move	$5,$7
	.set	macro
	.set	reorder

	lw	$4,52($18)
	lw	$19,48($18)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L48
	slt	$2,$19,128
	.set	macro
	.set	reorder

	jal	randrange
	addu	$19,$19,$2
	slt	$2,$19,128
$L48:
	bne	$2,$0,$L23
	.set	noreorder
	.set	nomacro
	j	$L24
	li	$19,127			# 0x0000007f
	.set	macro
	.set	reorder

	.def	detune_low;	.val	$L23;	.scl	6;	.type	0x0;	.endef
$L23:
	bgez	$19,$L24
	move	$19,$0
	.def	detune_done;	.val	$L24;	.scl	6;	.type	0x0;	.endef
$L24:
	lw	$4,20($18)
	lw	$5,44($18)
	lw	$6,24($18)
	.set	noreorder
	.set	nomacro
	jal	iSNDallocchan
	addu	$7,$sp,32
	.set	macro
	.set	reorder

	move	$21,$2
	.set	noreorder
	.set	nomacro
	bltz	$21,$L47
	lui	$3,%hi(sndgs+148) # high
	.set	macro
	.set	reorder

	sll	$2,$21,1
	addu	$2,$2,$21
	sll	$2,$2,3
	addu	$2,$2,$21
	sll	$2,$2,2
	lw	$3,%lo(sndgs+148)($3)
	lbu	$4,148($18)
	addu	$17,$3,$2
	sb	$4,51($17)
	lhu	$4,64($18)
	#nop
	sh	$4,92($17)
	lw	$3,28($18)
	lw	$2,96($sp)
	#nop
	subu	$3,$3,$2
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$4,$4,$2
	sh	$4,92($17)
	lw	$2,144($18)
	#nop
	beq	$2,$0,$L27
	lw	$2,104($sp)
	#nop
	addu	$2,$4,$2
	sh	$2,92($17)
$L27:
	lw	$4,68($18)
	#nop
	beq	$4,$0,$L28
	jal	randrange
	lhu	$3,92($17)
	#nop
	addu	$3,$3,$2
	sh	$3,92($17)
$L28:
	lw	$2,72($18)
	#nop
	#.set	volatile
	sw	$2,68($17)
	#.set	novolatile
	lw	$2,84($18)
	#nop
	#.set	volatile
	sw	$2,72($17)
	#.set	novolatile
	lw	$3,92($18)
	sll	$2,$16,16
	#.set	volatile
	sw	$2,28($17)
	#.set	novolatile
	#.set	volatile
	sw	$3,76($17)
	#.set	novolatile
	lb	$3,51($17)
	li	$2,1			# 0x00000001
	sw	$0,20($17)
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L29
	sb	$20,61($17)
	.set	macro
	.set	reorder

	addu	$2,$20,-64
	mult	$2,$3
	mflo	$10
	#nop
	#nop
	addu	$20,$10,64
$L29:
	addu	$2,$19,$20
	addu	$20,$2,-64
	.set	noreorder
	.set	nomacro
	bgez	$20,$L30
	slt	$2,$20,128
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L31
	move	$20,$0
	.set	macro
	.set	reorder

$L30:
	bne	$2,$0,$L31
	li	$20,127			# 0x0000007f
$L31:
	lw	$2,72($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L33
	addu	$2,$2,$20
	.set	macro
	.set	reorder

	lb	$20,0($2)
$L33:
	lw	$4,60($18)
	lw	$16,56($18)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L49
	slt	$2,$16,128
	.set	macro
	.set	reorder

	jal	randrange
	addu	$16,$16,$2
	slt	$2,$16,128
$L49:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L50
	slt	$2,$16,-128
	.set	macro
	.set	reorder

	li	$16,127			# 0x0000007f
	slt	$2,$16,-128
$L50:
	beq	$2,$0,$L37
	li	$16,-128			# 0xffffff80
$L37:
	lw	$3,100($sp)
	#nop
	mult	$16,$3
	mflo	$3
	#nop
	li	$2,-2130575360			# 0x81020000
	ori	$2,$2,0x0409
	mult	$3,$2
	sb	$19,46($17)
	mfhi	$8
	#nop
	#nop
	addu	$2,$8,$3
	sra	$2,$2,6
	sra	$3,$3,31
	subu	$2,$2,$3
	sb	$2,44($17)
	lw	$3,40($18)
	sb	$23,47($17)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,2
	sh	$2,90($17)
	lw	$2,100($18)
	#nop
	sw	$2,64($17)
	lw	$2,112($18)
	lw	$3,64($17)
	sb	$0,49($17)
	sll	$2,$2,16
	sw	$2,36($17)
	lbu	$2,36($18)
	#nop
	sb	$2,48($17)
	lbu	$2,32($18)
	#nop
	sb	$2,50($17)
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L38
	sw	$2,40($17)
	.set	macro
	.set	reorder

	li	$2,2147418112			# 0x7fff0000
	ori	$2,$2,0xffff
	sw	$2,40($17)
$L38:
	lw	$2,64($17)
	lw	$4,36($17)
	lw	$2,4($2)
	lw	$3,40($17)
	sll	$2,$2,16
	subu	$2,$2,$4
	div	$2,$2,$3
	sw	$2,32($17)
	lw	$2,116($18)
	#nop
	sw	$2,80($17)
	lw	$2,128($18)
	#nop
	sw	$2,84($17)
	lbu	$2,120($18)
	#nop
	sb	$2,56($17)
	lbu	$2,132($18)
	#nop
	sb	$2,57($17)
	lbu	$2,136($18)
	#nop
	sh	$2,88($17)
	lw	$2,124($18)
	#nop
	beq	$2,$0,$L39
	jal	iSNDrandom
	lw	$3,120($18)
	#nop
	remu	$3,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L40
	sb	$3,58($17)
	.set	macro
	.set	reorder

$L39:
	sb	$0,58($17)
$L40:
	lw	$2,140($18)
	#nop
	beq	$2,$0,$L41
	jal	iSNDrandom
	lw	$3,132($18)
	#nop
	remu	$3,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L42
	sb	$3,59($17)
	.set	macro
	.set	reorder

$L41:
	sb	$0,59($17)
$L42:
	lhu	$2,14($22)
	#nop
	sh	$2,62($17)
	lhu	$2,12($22)
	move	$4,$21
	sh	$0,94($17)
	.set	noreorder
	.set	nomacro
	jal	iSNDcalcpitch
	sh	$2,96($17)
	.set	macro
	.set	reorder

	lbu	$2,76($18)
	sb	$fp,53($17)
	sb	$2,52($17)
	lbu	$2,4($22)
	#nop
	sb	$2,10($17)
	lhu	$2,0($22)
	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	iSNDcalcvol
	sh	$2,8($17)
	.set	macro
	.set	reorder

	lb	$2,11($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L43
	addu	$8,$20,-64
	.set	macro
	.set	reorder

	lhu	$8,16($22)
	lh	$9,18($22)
	j	$L44
$L43:
	sll	$8,$8,8
	andi	$8,$8,0xffff
	move	$9,$0
$L44:
	lhu	$2,14($22)
	lb	$6,45($17)
	lhu	$7,98($17)
	sw	$2,16($sp)
	lui	$2,%hi(iSNDplatformrate) # high
	lb	$3,52($17)
	lw	$2,%lo(iSNDplatformrate)($2)
	#nop
	mult	$2,$3
	mflo	$11
	#nop
	lb	$3,53($17)
	#nop
	mult	$11,$3
	mflo	$3
	#nop
	li	$2,-2113536000			# 0x82060000
	ori	$2,$2,0x1029
	mult	$3,$2
	lw	$4,80($sp)
	move	$5,$21
	sw	$8,24($sp)
	sw	$9,28($sp)
	mfhi	$11
	#nop
	#nop
	addu	$2,$11,$3
	sra	$2,$2,13
	sra	$3,$3,31
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformplay
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	bltz	$16,$L45
	lw	$2,32($sp)
	j	$L47
$L45:
	.set	noreorder
	.set	nomacro
	jal	iSNDfreechan
	move	$4,$21
	.set	macro
	.set	reorder

	move	$2,$16
$L47:
	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	iSNDplaytaggedtimbre
	.def	iSNDplaytaggedpatch;	.val	iSNDplaytaggedpatch;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplaytaggedpatch
iSNDplaytaggedpatch:
	.frame	$sp,440,$31		# vars= 368, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	bank;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	tag;	.val	23;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,440
	sw	$23,428($sp)
	move	$23,$5
	sw	$21,420($sp)
	move	$21,$0
	sw	$20,416($sp)
	li	$20,-9			# 0xfffffff7
	sw	$18,408($sp)
	move	$18,$21
	sw	$19,412($sp)
	move	$19,$21
	sw	$22,424($sp)
	move	$22,$21
	sw	$31,436($sp)
	sw	$fp,432($sp)
	sw	$17,404($sp)
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L52
	sw	$16,400($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L83
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

$L52:
	lb	$17,5($23)
	lb	$16,6($23)
	sw	$4,384($sp)
	lbu	$2,3($4)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L84
	addu	$2,$4,8
	.set	macro
	.set	reorder

	addu	$2,$4,4
$L84:
	sw	$2,384($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDresetpatch
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	iSNDresettimbre
	addu	$5,$sp,184
	.set	macro
	.set	reorder

	jal	iSNDenteraudio
	jal	iSNDfindfreekey
	move	$fp,$2
$L55:
	addu	$4,$sp,384
$L85:
	addu	$5,$sp,388
	addu	$6,$sp,392
	.set	noreorder
	.set	nomacro
	jal	iSNDgettag
	addu	$7,$sp,396
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L56
	li	$2,253			# 0x000000fd
	.set	macro
	.set	reorder

	lw	$5,388($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L59
	li	$2,254			# 0x000000fe
	.set	macro
	.set	reorder

	lw	$21,384($sp)
	.set	noreorder
	.set	nomacro
	j	$L85
	addu	$4,$sp,384
	.set	macro
	.set	reorder

$L59:
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L60
	slt	$2,$5,38
	.set	macro
	.set	reorder

	lw	$2,36($sp)
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L86
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	lw	$2,40($sp)
	#nop
	slt	$2,$2,$16
	bne	$2,$0,$L86
	lw	$2,44($sp)
	#nop
	slt	$2,$17,$2
	bne	$2,$0,$L86
	lw	$2,48($sp)
	#nop
	slt	$2,$2,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L86
	move	$5,$23
	.set	macro
	.set	reorder

	move	$4,$21
	addu	$6,$sp,32
	addu	$7,$sp,184
	sw	$17,16($sp)
	sw	$16,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDplaytaggedtimbre
	sw	$22,24($sp)
	.set	macro
	.set	reorder

	move	$20,$2
	.set	noreorder
	.set	nomacro
	bltz	$20,$L63
	sll	$2,$18,2
	.set	macro
	.set	reorder

	addu	$2,$sp,$2
	sw	$20,336($2)
	addu	$18,$18,1
	addu	$4,$sp,32
$L86:
	.set	noreorder
	.set	nomacro
	jal	iSNDresettimbre
	addu	$5,$sp,184
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L85
	addu	$4,$sp,384
	.set	macro
	.set	reorder

$L60:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L85
	addu	$4,$sp,384
	.set	macro
	.set	reorder

	sll	$4,$5,2
	lw	$6,392($sp)
	addu	$2,$sp,$4
	sw	$6,32($2)
	lw	$3,396($sp)
	#nop
	sw	$3,184($2)
	li	$2,36			# 0x00000024
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L85
	addu	$4,$sp,384
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	randrange
	move	$4,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L55
	move	$22,$2
	.set	macro
	.set	reorder

$L56:
	lw	$2,36($sp)
	#nop
	slt	$2,$16,$2
	bne	$2,$0,$L66
	lw	$2,40($sp)
	#nop
	slt	$2,$2,$16
	bne	$2,$0,$L66
	lw	$2,44($sp)
	#nop
	slt	$2,$17,$2
	bne	$2,$0,$L66
	lw	$2,48($sp)
	#nop
	slt	$2,$2,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L66
	move	$4,$21
	.set	macro
	.set	reorder

	move	$5,$23
	addu	$6,$sp,32
	addu	$7,$sp,184
	sw	$17,16($sp)
	sw	$16,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDplaytaggedtimbre
	sw	$22,24($sp)
	.set	macro
	.set	reorder

	move	$20,$2
	.set	noreorder
	.set	nomacro
	bltz	$20,$L63
	sll	$2,$18,2
	.set	macro
	.set	reorder

	addu	$2,$sp,$2
	sw	$20,336($2)
	addu	$18,$18,1
$L66:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L63
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	bne	$18,$2,$L69
	lw	$4,336($sp)
	jal	iSNDgetchan
	move	$4,$2
	.set	noreorder
	.set	nomacro
	bltz	$4,$L71
	lui	$2,%hi(sndgs+148) # high
	.set	macro
	.set	reorder

	sll	$3,$4,1
	addu	$3,$3,$4
	sll	$3,$3,3
	addu	$3,$3,$4
	lw	$2,%lo(sndgs+148)($2)
	sll	$3,$3,2
	addu	$19,$2,$3
	sb	$0,55($19)
	.set	noreorder
	.set	nomacro
	j	$L71
	sb	$0,54($19)
	.set	macro
	.set	reorder

$L69:
	.set	noreorder
	.set	nomacro
	blez	$18,$L73
	move	$16,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(sndgs) # high
	addiu	$21,$2,%lo(sndgs) # low
	addu	$17,$sp,336
$L75:
	lw	$4,0($17)
	jal	iSNDgetchan
	move	$4,$2
	.set	noreorder
	.set	nomacro
	bltz	$4,$L74
	sll	$2,$4,1
	.set	macro
	.set	reorder

	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	lw	$3,148($21)
	sll	$2,$2,2
	addu	$19,$3,$2
	sb	$fp,55($19)
	sb	$0,54($19)
$L74:
	addu	$16,$16,1
	slt	$2,$16,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L75
	addu	$17,$17,4
	.set	macro
	.set	reorder

$L73:
	li	$2,1			# 0x00000001
	sb	$2,54($19)
$L71:
	jal	iSNDleaveaudio
	.set	noreorder
	.set	nomacro
	j	$L83
	move	$2,$20
	.set	macro
	.set	reorder

	.def	fail;	.val	$L63;	.scl	6;	.type	0x0;	.endef
$L63:
	.set	noreorder
	.set	nomacro
	jal	iSNDleaveaudio
	move	$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$18,$L79
	addu	$17,$sp,336
	.set	macro
	.set	reorder

$L81:
	lw	$4,0($17)
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	jal	SNDstop
	addu	$16,$16,1
	.set	macro
	.set	reorder

	slt	$2,$16,$18
	bne	$2,$0,$L81
$L79:
	move	$2,$20
$L83:
	lw	$31,436($sp)
	lw	$fp,432($sp)
	lw	$23,428($sp)
	lw	$22,424($sp)
	lw	$21,420($sp)
	lw	$20,416($sp)
	lw	$19,412($sp)
	lw	$18,408($sp)
	lw	$17,404($sp)
	lw	$16,400($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,440
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	iSNDplaytaggedpatch
	.def	iSNDresolvetaggedpatch;	.val	iSNDresolvetaggedpatch;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDresolvetaggedpatch
iSNDresolvetaggedpatch:
	.frame	$sp,56,$31		# vars= 16, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	bank;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	patch_idx;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	scratch;	.val	20;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,56
	sw	$17,36($sp)
	move	$17,$4
	sw	$19,44($sp)
	move	$19,$5
	sw	$20,48($sp)
	move	$20,$6
	sw	$31,52($sp)
	sw	$18,40($sp)
	sw	$16,32($sp)
	sw	$17,16($sp)
	lbu	$2,3($17)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L88
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L95
	addu	$2,$17,8
	.set	macro
	.set	reorder

$L88:
	addu	$2,$17,4
$L95:
	sw	$2,16($sp)
	li	$18,253			# 0x000000fd
$L90:
	addu	$4,$sp,16
$L96:
	addu	$5,$sp,20
	addu	$6,$sp,24
	.set	noreorder
	.set	nomacro
	jal	iSNDgettag
	addu	$7,$sp,28
	.set	macro
	.set	reorder

	beq	$2,$0,$L91
	lw	$2,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L96
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformresolve
	move	$6,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L90
	move	$16,$2
	.set	macro
	.set	reorder

$L91:
	.set	noreorder
	.set	nomacro
	bltz	$16,$L97
	move	$2,$16
	.set	macro
	.set	reorder

	lbu	$2,3($17)
	#nop
	ori	$2,$2,0x0001
	sb	$2,3($17)
	move	$2,$16
$L97:
	lw	$31,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	iSNDresolvetaggedpatch
	.def	iSNDremovetaggedpatch;	.val	iSNDremovetaggedpatch;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDremovetaggedpatch
iSNDremovetaggedpatch:
	.frame	$sp,48,$31		# vars= 16, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	bank;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	patch_idx;	.val	18;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,48
	sw	$16,32($sp)
	move	$16,$4
	sw	$31,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,16($sp)
	lbu	$2,3($16)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L99
	move	$18,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L105
	addu	$2,$16,8
	.set	macro
	.set	reorder

$L99:
	addu	$2,$16,4
$L105:
	sw	$2,16($sp)
	li	$17,253			# 0x000000fd
	addu	$4,$sp,16
$L106:
	addu	$5,$sp,20
	addu	$6,$sp,24
	.set	noreorder
	.set	nomacro
	jal	iSNDgettag
	addu	$7,$sp,28
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L102
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L106
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformremove
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L106
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L102:
	lbu	$3,3($16)
	#nop
	andi	$3,$3,0x00fe
	sb	$3,3($16)
	lw	$31,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM8:
	.end	iSNDremovetaggedpatch
