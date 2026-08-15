	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\setfont.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	setfont

	.text
	.def	DecodeFn;	.scl	13;	.type	0x94;	.endef
	.def	setfont;	.val	setfont;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	setfont
setfont:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	fontId;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	lui	$2,%hi(currentfont) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(currentfont) # low
	sw	$31,28($sp)
	sw	$16,16($sp)
	lw	$16,28($18)
	li	$2,100			# 0x00000064
	sw	$2,124($17)
	lb	$2,16($18)
	#nop
	sw	$2,12($17)
	lb	$2,17($18)
	#nop
	sw	$2,16($17)
	lb	$2,18($18)
	#nop
	sw	$2,28($17)
	lb	$2,19($18)
	#nop
	sw	$2,32($17)
	lb	$2,19($18)
	lb	$3,18($18)
	#nop
	addu	$2,$2,$3
	sw	$2,36($17)
	lb	$2,19($18)
	lb	$3,18($18)
	addu	$16,$18,$16
	addu	$2,$2,$3
	sw	$2,40($17)
	lhu	$3,10($18)
	li	$2,1			# 0x00000001
	sw	$2,24($17)
	sw	$0,176($17)
	sw	$0,172($17)
	sw	$18,128($17)
	sw	$16,136($17)
	sw	$3,116($17)
	lw	$2,20($18)
	move	$4,$16
	addu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	jal	shapedepth
	sw	$2,132($17)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	shapedepth
	sw	$2,20($17)
	.set	macro
	.set	reorder

	lh	$3,4($16)
	#nop
	mult	$3,$2
	li	$3,-32			# 0xffffffe0
	mflo	$6
	#nop
	#nop
	addu	$2,$6,31
	and	$2,$2,$3
	sra	$2,$2,3
	sw	$2,120($17)
	lh	$2,14($18)
	li	$3,2			# 0x00000002
	andi	$2,$2,0x0003
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L3
	lui	$2,%hi(decodeshiftjis) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L7
	addiu	$2,$2,%lo(decodeshiftjis) # low
	.set	macro
	.set	reorder

	.def	notsjis;	.val	$L3;	.scl	6;	.type	0x0;	.endef
$L3:
	lw	$2,116($17)
	#nop
	slt	$2,$2,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$4,$18,32
	.set	macro
	.set	reorder

	lui	$2,%hi(decodeshiftjis2) # high
	.set	noreorder
	.set	nomacro
	j	$L7
	addiu	$2,$2,%lo(decodeshiftjis2) # low
	.set	macro
	.set	reorder

$L5:
	.set	noreorder
	.set	nomacro
	jal	geti
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	sltu	$2,$2,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L6
	lui	$2,%hi(decodeshiftjis3) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L7
	addiu	$2,$2,%lo(decodeshiftjis3) # low
	.set	macro
	.set	reorder

$L6:
	lui	$2,%hi(decodeansi) # high
	addiu	$2,$2,%lo(decodeansi) # low
$L7:
	sw	$2,160($17)
	lui	$16,%hi(currentfont) # high
	addiu	$16,$16,%lo(currentfont) # low
	addu	$4,$16,52
	li	$5,64			# 0x00000040
	sw	$0,44($16)
	sw	$0,48($16)
	.set	noreorder
	.set	nomacro
	jal	blockclear
	sw	$0,180($16)
	.set	macro
	.set	reorder

	jal	inittextdraw
	sw	$0,164($16)
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


	.loc	1 0
LM1:
	.end	setfont
