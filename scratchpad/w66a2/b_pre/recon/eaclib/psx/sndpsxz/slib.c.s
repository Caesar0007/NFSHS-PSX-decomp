	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\slib.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	sndpd
	.globl	D_801479F0
	.globl	DAT_801479f0
	.globl	D_80147A0C
	.globl	DAT_80147e28
	.globl	D_80147E34
	.section	.bss
	.align	2
sndpd:
	.space	0xd8
D_801479F0:
DAT_801479f0:
	.space	0x1c
D_80147A0C:
	.space	0x41c
DAT_80147e28:
	.space	0xc
D_80147E34:
	.space	0x210
	.text
 #NO_APP
	.globl	sndpdsafeloop
	.data
	.align	2
sndpdsafeloop:
	.byte	0
	.byte	7
	.byte	0
	.byte	0
	.space	12
	.text
	.align	2
	.globl	iSNDplatformoutputcaps
	.align	2
	.globl	iSNDplatformoutputset
	.align	2
	.globl	iSNDinit
	.align	2
	.globl	iSNDrestore
	.align	2
	.globl	iSNDserve

	.text
	.def	iSNDplatformoutputcaps;	.val	iSNDplatformoutputcaps;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformoutputcaps
iSNDplatformoutputcaps:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(sndgs) # high
	addiu	$2,$3,%lo(sndgs) # low
	li	$5,24			# 0x00000018
	li	$4,44100			# 0x0000ac44
	sb	$0,7($2)
	sb	$0,8($2)
	sb	$0,9($2)
	sb	$5,6($2)
	sh	$4,%lo(sndgs)($3)
	li	$3,1			# 0x00000001
	sb	$3,4($2)
	li	$3,2			# 0x00000002
	sh	$4,2($2)
	sb	$3,5($2)
	sb	$0,19($2)
	sb	$0,20($2)
	sb	$0,18($2)
	sb	$5,17($2)
	sh	$4,14($2)
	sb	$3,16($2)
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDplatformoutputcaps
	.def	iSNDplatformoutputset;	.val	iSNDplatformoutputset;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformoutputset
iSNDplatformoutputset:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(sndgs) # high
	addiu	$4,$2,%lo(sndgs) # low
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lbu	$5,4($4)
	lbu	$2,16($4)
	li	$3,24			# 0x00000018
	sltu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	sb	$3,17($4)
	.set	macro
	.set	reorder

	sb	$5,16($4)
$L5:
	lbu	$3,5($4)
	lbu	$2,16($4)
	#nop
	sltu	$2,$3,$2
	beq	$2,$0,$L6
	sb	$3,16($4)
$L6:
	lb	$2,60($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L7
	lui	$2,%hi(sndpd) # high
	.set	macro
	.set	reorder

	addiu	$5,$2,%lo(sndpd) # low
	lbu	$3,2($5)
	lbu	$2,16($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L7
	move	$17,$0
	.set	macro
	.set	reorder

	move	$18,$4
	addu	$16,$5,216
	.def	voiceloop;	.val	$L8;	.scl	6;	.type	0x0;	.endef
$L8:
	#.set	volatile
	lbu	$3,28($16)
	#.set	novolatile
	li	$2,2			# 0x00000002
	bne	$3,$2,$L9
	#.set	volatile
	lbu	$2,33($16)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L9
	move	$4,$17
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$5,36($16)
	#.set	novolatile
	#.set	volatile
	lbu	$6,37($16)
	#.set	novolatile
	sll	$5,$5,24
	sll	$6,$6,24
	sra	$5,$5,24
	.set	noreorder
	.set	nomacro
	jal	iSNDsetvol
	sra	$6,$6,24
	.set	macro
	.set	reorder

$L9:
	lbu	$2,17($18)
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L8
	addu	$16,$16,44
	.set	macro
	.set	reorder

$L7:
	lui	$2,%hi(sndgs+16) # high
	lbu	$3,%lo(sndgs+16)($2)
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	lui	$2,%hi(sndpd+2) # high
	sb	$3,%lo(sndpd+2)($2)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSNDplatformoutputset
	.def	InitWaitSpu;	.scl	10;	.type	0x8;	.size	432;	.endef
	.def	pad;	.val	0;	.scl	8;	.dim	430;	.size	430;	.type	0x3c;	.endef
	.def	status;	.val	430;	.scl	8;	.type	0xd;	.endef
	.def	.eos;	.val	432;	.scl	102;	.tag	InitWaitSpu;	.size	432;	.endef
	.def	iSNDinit;	.val	iSNDinit;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDinit
iSNDinit:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	li	$10,528482304			# 0x1f800000
	ori	$10,$10,0x1014
	li	$9,528482304			# 0x1f800000
	ori	$9,$9,0x10c0
	li	$8,528482304			# 0x1f800000
	ori	$8,$8,0x10c4
	li	$7,528482304			# 0x1f800000
	ori	$7,$7,0x10c8
	li	$6,528482304			# 0x1f800000
	ori	$6,$6,0x10f0
	li	$5,528482304			# 0x1f800000
	ori	$5,$5,0x1c00
	lui	$4,%hi(sndpd) # high
	addiu	$4,$4,%lo(sndpd) # low
	li	$2,65			# 0x00000041
	sw	$31,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	sh	$2,1306($4)
	#.set	volatile
	lw	$2,0($6)
	#.set	novolatile
	li	$3,720896			# 0x000b0000
	or	$2,$2,$3
	#.set	volatile
	sw	$2,0($6)
	#.set	novolatile
	#.set	volatile
	sh	$0,384($5)
	#.set	novolatile
	#.set	volatile
	sh	$0,386($5)
	#.set	novolatile
	#.set	volatile
	sh	$0,426($5)
	#.set	novolatile
	#.set	volatile
	sh	$0,384($5)
	#.set	novolatile
	#.set	volatile
	sh	$0,386($5)
	#.set	novolatile
	#.set	volatile
	lhu	$3,430($5)
	#.set	novolatile
	li	$2,8192			# 0x00002000
	sh	$2,1308($4)
	sw	$10,1276($4)
	sw	$9,1280($4)
	sw	$8,1284($4)
	sw	$7,1288($4)
	sw	$6,1292($4)
	sw	$5,1296($4)
	andi	$3,$3,0x07ff
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L13
	sw	$5,1300($4)
	.set	macro
	.set	reorder

	li	$3,528482304			# 0x1f800000
	ori	$3,$3,0x1c00
$L14:
	#.set	volatile
	lhu	$2,430($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x07ff
	bne	$2,$0,$L14
$L13:
	lui	$2,%hi(sndpd) # high
	addiu	$17,$2,%lo(sndpd) # low
	#.set	volatile
	lw	$3,1300($17)
	#.set	novolatile
	li	$2,4			# 0x00000004
	#.set	volatile
	sh	$2,428($3)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($17)
	#.set	novolatile
	#nop
	#.set	volatile
	sh	$0,400($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($17)
	#.set	novolatile
	#nop
	#.set	volatile
	sh	$0,402($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($17)
	#.set	novolatile
	#nop
	#.set	volatile
	sh	$0,404($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($17)
	#.set	novolatile
	#nop
	#.set	volatile
	sh	$0,406($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($17)
	#.set	novolatile
	li	$4,4			# 0x00000004
	#.set	volatile
	sh	$0,432($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($17)
	#.set	novolatile
	lui	$5,%hi(iSNDdmcallback) # high
	#.set	volatile
	sh	$0,434($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($17)
	#.set	novolatile
	addiu	$5,$5,%lo(iSNDdmcallback) # low
	#.set	volatile
	sh	$0,436($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($17)
	#.set	novolatile
 #APP
	mfc0 $16,$12
	nop
	li $1,-1026
	and $8,$16,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	#nop
	#.set	volatile
	sh	$0,438($2)
	#.set	novolatile
	#.set	volatile
	lw	$3,1300($17)
	#.set	novolatile
	li	$2,49152			# 0x0000c000
	#.set	volatile
	sh	$2,426($3)
	#.set	novolatile
	jal	DMACallback
 #APP
	mtc0 $16,$12
 #NO_APP
	lui	$4,%hi(sndpdsafeloop) # high
	addiu	$4,$4,%lo(sndpdsafeloop) # low
	li	$5,4096			# 0x00001000
	li	$6,16			# 0x00000010
	li	$7,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	iSNDdmqueue
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(sndgs) # high
	addiu	$3,$2,%lo(sndgs) # low
	lbu	$2,17($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L19
	move	$4,$0
	.set	macro
	.set	reorder

	li	$6,512			# 0x00000200
	li	$9,-1			# 0xffffffff
	move	$8,$3
	move	$7,$17
	move	$5,$7
$L20:
	sll	$2,$4,4
	#.set	volatile
	lw	$3,1296($7)
	#.set	novolatile
	addu	$4,$4,1
	addu	$3,$3,$2
	sh	$0,0($3)
	sh	$0,2($3)
	sh	$0,4($3)
	sh	$6,6($3)
	sh	$6,14($3)
	sh	$0,8($3)
	sh	$0,10($3)
	sb	$9,255($5)
	lbu	$2,17($8)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L20
	addu	$5,$5,44
	.set	macro
	.set	reorder

$L19:
	li	$4,16711680			# 0x00ff0000
	.set	noreorder
	.set	nomacro
	jal	iSNDpsxkeyon
	ori	$4,$4,0xffff
	.set	macro
	.set	reorder

	lui	$17,%hi(sndpd) # high
	addiu	$16,$17,%lo(sndpd) # low
	#.set	volatile
	lw	$3,1300($16)
	#.set	novolatile
	li	$2,65534			# 0x0000fffe
	#.set	volatile
	sh	$2,418($3)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($16)
	#.set	novolatile
	li	$3,16383			# 0x00003fff
	#.set	volatile
	sh	$3,384($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,1300($16)
	#.set	novolatile
	#nop
	#.set	volatile
	sh	$3,386($2)
	#.set	novolatile
	#.set	volatile
	lw	$3,1300($16)
	#.set	novolatile
	#nop
	#.set	volatile
	lhu	$2,426($3)
	#.set	novolatile
	#nop
	ori	$2,$2,0x0001
	#.set	volatile
	sh	$2,426($3)
	#.set	novolatile
	lw	$4,4($16)
	jal	iSNDpsxfxinit
	lui	$4,%hi(iSNDserver) # high
	addiu	$4,$4,%lo(iSNDserver) # low
	#.set	volatile
	sb	$0,1($16)
	#.set	novolatile
	jal	addtimer
	lbu	$2,%lo(sndpd)($17)
	#nop
	bne	$2,$0,$L24
	lui	$4,%hi(SNDSYS_restore) # high
	.set	noreorder
	.set	nomacro
	jal	addexit
	addiu	$4,$4,%lo(SNDSYS_restore) # low
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$2,%lo(sndpd)($17)
$L24:
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	iSNDinit
	.def	RestoreVoice;	.scl	10;	.type	0x8;	.size	246;	.endef
	.def	pad;	.val	0;	.scl	8;	.dim	245;	.size	245;	.type	0x3c;	.endef
	.def	active;	.val	245;	.scl	8;	.type	0xc;	.endef
	.def	.eos;	.val	246;	.scl	102;	.tag	RestoreVoice;	.size	246;	.endef
	.def	iSNDrestore;	.val	iSNDrestore;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDrestore
iSNDrestore:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	lui	$2,%hi(sndgs) # high
	addiu	$3,$2,%lo(sndgs) # low
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lbu	$2,63($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L26
	move	$16,$3
	.set	macro
	.set	reorder

$L27:
	jal	iSNDleaveaudio
	lbu	$2,63($16)
	#nop
	bne	$2,$0,$L27
$L26:
	lui	$2,%hi(sndgs) # high
	addiu	$2,$2,%lo(sndgs) # low
	move	$19,$2
	lw	$3,68($19)
	lui	$2,%hi(sndpd) # high
	addiu	$21,$2,%lo(sndpd) # low
	addu	$20,$3,100
	li	$18,1			# 0x00000001
$L44:
	lbu	$2,17($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L34
	move	$16,$0
	.set	macro
	.set	reorder

	move	$17,$21
$L35:
	#.set	volatile
	lbu	$2,245($17)
	#.set	novolatile
	#nop
	beq	$2,$0,$L43
	lw	$2,68($19)
	#nop
	sltu	$2,$20,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L43
	move	$18,$0
	.set	macro
	.set	reorder

	li	$4,16711680			# 0x00ff0000
	.set	noreorder
	.set	nomacro
	jal	iSNDpsxkeyoff
	ori	$4,$4,0xffff
	.set	macro
	.set	reorder

	#.set	volatile
	sb	$0,245($17)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	iSNDfreechan
	move	$4,$16
	.set	macro
	.set	reorder

	move	$18,$0
$L43:
	lbu	$2,17($19)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L35
	addu	$17,$17,44
	.set	macro
	.set	reorder

$L34:
	jal	SNDSYS_service
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L44
	li	$18,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$4,%hi(iSNDserver) # high
	.set	noreorder
	.set	nomacro
	jal	deltimer
	addiu	$4,$4,%lo(iSNDserver) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDpsxfxinit
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,4			# 0x00000004
 #APP
	mfc0 $16,$12
	nop
	li $1,-1026
	and $8,$16,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	DMACallback
	move	$5,$0
	.set	macro
	.set	reorder

 #APP
	mtc0 $16,$12
 #NO_APP
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	iSNDrestore
	.def	iSNDserve;	.val	iSNDserve;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDserve
iSNDserve:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	lui	$2,%hi(sndpd) # high
	sw	$16,24($sp)
	addiu	$16,$2,%lo(sndpd) # low
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$0,16($sp)
	lw	$2,1824($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L54
	move	$19,$0
	.set	macro
	.set	reorder

	jal	$31,$2
$L54:
	lui	$2,%hi(sndgs+17) # high
	lbu	$2,%lo(sndgs+17)($2)
	#nop
	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L55
	move	$21,$0
	.set	macro
	.set	reorder

	move	$fp,$16
	move	$23,$21
$L56:
	lui	$5,%hi(D_801479F0) # high
	addiu	$5,$5,%lo(D_801479F0) # low
	addu	$16,$23,$5
	lw	$3,1296($fp)
	sll	$2,$21,4
	addu	$20,$3,$2
	#.set	volatile
	lbu	$3,29($16)
	#.set	novolatile
	li	$2,2			# 0x00000002
	bne	$3,$2,$L59
	lhu	$2,12($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L60
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	#.set	volatile
	sb	$2,38($16)
	#.set	novolatile
	j	$L61
$L60:
	lbu	$2,38($16)
	#nop
	beq	$2,$0,$L61
	lbu	$2,33($16)
	#nop
	bne	$2,$0,$L61
	lbu	$2,39($16)
	#nop
	sll	$2,$2,24
	bgez	$2,$L61
	#.set	volatile
	lbu	$2,31($16)
	#.set	novolatile
	move	$22,$23
	andi	$18,$2,0x00ff
$L63:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L66
	move	$17,$21
	.set	macro
	.set	reorder

	lui	$5,%hi(D_801479F0) # high
	addiu	$5,$5,%lo(D_801479F0) # low
	#.set	volatile
	lbu	$2,32($16)
	#.set	novolatile
	#.set	volatile
	lbu	$3,32($16)
	#.set	novolatile
	sll	$2,$2,24
	sra	$17,$2,24
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$L71
	addu	$16,$2,$5
	.set	macro
	.set	reorder

$L66:
	lui	$5,%hi(D_80147A0C-28) # high
	addiu	$5,$5,%lo(D_80147A0C-28) # low
	addu	$16,$22,$5
$L71:
	move	$4,$17
	#.set	volatile
	sb	$0,29($16)
	#.set	novolatile
	#.set	volatile
	sb	$0,28($16)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	iSNDfreechan
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	sll	$4,$17,4
	lw	$3,1296($fp)
	li	$2,512			# 0x00000200
	addu	$3,$4,$3
	sh	$2,6($3)
	li	$2,1			# 0x00000001
	sll	$2,$2,$17
	lw	$3,1296($fp)
	or	$19,$19,$2
	addu	$3,$4,$3
	sh	$0,0($3)
	lw	$2,1296($fp)
	#nop
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bgtz	$18,$L63
	sh	$0,2($4)
	.set	macro
	.set	reorder

$L61:
	lbu	$2,40($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L73
	li	$3,1246560256			# 0x4a4d0000
	.set	macro
	.set	reorder

	lw	$2,8($16)
	ori	$3,$3,0xc96f
	multu	$2,$3
	mfhi	$5
	#nop
	#nop
	srl	$2,$5,7
	sh	$2,4($20)
	sb	$0,40($16)
$L73:
	#.set	volatile
	lw	$2,16($16)
	#.set	novolatile
	#nop
	blez	$2,$L74
	#.set	volatile
	lw	$2,16($16)
	#.set	novolatile
	#.set	volatile
	lw	$3,8($16)
	#.set	novolatile
	#nop
	subu	$2,$2,$3
	#.set	volatile
	sw	$2,16($16)
	#.set	novolatile
	j	$L79
$L74:
	#.set	volatile
	lw	$2,12($16)
	#.set	novolatile
	#.set	volatile
	lw	$3,8($16)
	#.set	novolatile
	#nop
	addu	$2,$2,$3
	#.set	volatile
	sw	$2,12($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,12($16)
	#.set	novolatile
	#.set	volatile
	lw	$3,20($16)
	#.set	novolatile
	#nop
	sltu	$2,$2,$3
	bne	$2,$0,$L79
	lbu	$2,39($16)
	#nop
	sll	$2,$2,24
	bltz	$2,$L77
	#.set	volatile
	lw	$2,12($16)
	#.set	novolatile
	#.set	volatile
	lw	$3,20($16)
	#.set	novolatile
	#nop
	subu	$2,$2,$3
	#.set	volatile
	sw	$2,12($16)
	#.set	novolatile
	j	$L79
$L77:
	#.set	volatile
	lw	$2,20($16)
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,12($16)
	#.set	novolatile
	j	$L79
$L59:
	#.set	volatile
	lbu	$3,29($16)
	#.set	novolatile
	li	$2,3			# 0x00000003
	bne	$3,$2,$L79
	lhu	$2,12($20)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L81
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sll	$2,$2,$21
	or	$19,$19,$2
	li	$2,512			# 0x00000200
	sb	$0,29($16)
	sh	$2,6($20)
	sh	$0,0($20)
	.set	noreorder
	.set	nomacro
	j	$L79
	sh	$0,2($20)
	.set	macro
	.set	reorder

$L81:
	lw	$5,16($sp)
	sll	$2,$2,$21
	or	$5,$5,$2
	sw	$5,16($sp)
$L79:
	lbu	$3,28($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L92
	lui	$2,%hi(sndgs+17) # high
	.set	macro
	.set	reorder

	lbu	$2,29($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L92
	lui	$2,%hi(sndgs+17) # high
	.set	macro
	.set	reorder

	lbu	$2,31($16)
	#nop
	sltu	$2,$2,2
	bne	$2,$0,$L84
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
	addu	$3,$3,$fp
	lbu	$2,245($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L92
	lui	$2,%hi(sndgs+17) # high
	.set	macro
	.set	reorder

$L84:
	.set	noreorder
	.set	nomacro
	jal	iSNDstartvoice
	move	$4,$21
	.set	macro
	.set	reorder

	or	$19,$19,$2
	lui	$2,%hi(sndgs+17) # high
$L92:
	lbu	$2,%lo(sndgs+17)($2)
	addu	$21,$21,1
	slt	$2,$21,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L56
	addu	$23,$23,44
	.set	macro
	.set	reorder

$L55:
	lw	$5,16($sp)
	#nop
	beq	$5,$0,$L86
	.set	noreorder
	.set	nomacro
	jal	iSNDpsxkeyoff
	move	$4,$5
	.set	macro
	.set	reorder

$L86:
	beq	$19,$0,$L88
	.set	noreorder
	.set	nomacro
	jal	iSNDpsxkeyon
	move	$4,$19
	.set	macro
	.set	reorder

$L88:
	lw	$31,60($sp)
	lw	$fp,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	iSNDserve
	.def	sndpdsafeloop;	.val	sndpdsafeloop;	.scl	2;	.dim	16;	.size	16;	.type	0x3c;	.endef
