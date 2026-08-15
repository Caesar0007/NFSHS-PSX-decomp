	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\group.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	LocateNextGroupType__15SerializedGroupi
	.align	2
	.globl	LocateGroupType__15SerializedGroupii
	.align	2
	.globl	LocateGroupNum__15SerializedGroupi
	.align	2
	.globl	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	.align	2
	.globl	CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
	.align	2
	.globl	CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi

	.text
	.text
	.ent	LocateNextGroupType__15SerializedGroupi
LocateNextGroupType__15SerializedGroupi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,4($4)
	#nop
	addu	$4,$4,$2
	lw	$3,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$5,$L605
	move	$2,$0
	.set	macro
	.set	reorder

	move	$2,$4
$L605:
	j	$31
	.end	LocateNextGroupType__15SerializedGroupi
	.text
	.ent	LocateGroupType__15SerializedGroupii
LocateGroupType__15SerializedGroupii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$0
	lw	$7,12($4)
	li	$2,-1			# 0xffffffff
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	beq	$7,$2,$L608
	addu	$4,$4,16
	.set	macro
	.set	reorder

	move	$9,$2
$L610:
	lw	$2,0($4)
	#nop
	bne	$2,$5,$L611
	.set	noreorder
	.set	nomacro
	bne	$8,$6,$L612
	addu	$8,$8,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

$L612:
$L611:
	lw	$2,4($4)
	#nop
	andi	$3,$2,0x0003
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L613
	addu	$2,$2,4
	.set	macro
	.set	reorder

	subu	$2,$2,$3
	sw	$2,4($4)
$L613:
	lw	$2,4($4)
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	bne	$7,$9,$L610
	addu	$4,$4,$2
	.set	macro
	.set	reorder

$L608:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	LocateGroupType__15SerializedGroupii
	.text
	.ent	LocateGroupNum__15SerializedGroupi
LocateGroupNum__15SerializedGroupi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,12($4)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L617
	addu	$4,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L617:
	.set	noreorder
	.set	nomacro
	blez	$5,$L618
	move	$3,$0
	.set	macro
	.set	reorder

$L619:
	lw	$2,4($4)
	addu	$3,$3,1
	addu	$4,$4,$2
	slt	$2,$3,$5
	bne	$2,$0,$L619
$L618:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

	.end	LocateGroupNum__15SerializedGroupi
	.text
	.ent	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
LocateCreateGroupType__15SerializedGroupiP9SimpleMemi:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$19,28($sp)
	move	$19,$6
	sw	$18,24($sp)
	move	$18,$7
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	move	$6,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L625
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L626
	move	$2,$0
	.set	macro
	.set	reorder

$L625:
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	move	$6,$18
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
	move	$6,$19
	.set	macro
	.set	reorder

$L626:
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	.text
	.ent	CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$5
	move	$4,$6
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$17,4($18)
	move	$6,$0
	addu	$17,$17,-12
	.set	noreorder
	.set	nomacro
	jal	Alloc__9SimpleMemii
	move	$5,$17
	.set	macro
	.set	reorder

	addu	$4,$18,16
	move	$16,$2
	addu	$5,$16,4
	lw	$2,12($18)
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	blockmove
	sw	$2,0($16)
	.set	macro
	.set	reorder

	move	$2,$16
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

	.end	CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
	.text
	.ent	CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi
CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$5
	move	$4,$6
	sw	$17,20($sp)
	addu	$17,$7,4
	move	$5,$17
	move	$6,$0
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	Alloc__9SimpleMemii
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	addu	$4,$18,16
	addu	$5,$16,4
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	blockmove
	sw	$0,0($16)
	.set	macro
	.set	reorder

	move	$2,$16
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

	.end	CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi
