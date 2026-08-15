	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\spchpsxz\\spchrand.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSPCH_EACrandom
	.align	2
	.globl	iSPCH_EACseedrandom
	.align	2
	.globl	iSPCH_Rand
	.align	2
	.globl	iSPCH_BindData

	.text
	.def	iSPCH_EACrandom;	.val	iSPCH_EACrandom;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_EACrandom
iSPCH_EACrandom:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(seedX) # high
	addiu	$2,$2,%lo(seedX) # low
	lw	$3,20($2)
	lw	$2,16($2)
	#nop
	addu	$6,$3,$2
	sltu	$3,$6,$3
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L3
	move	$7,$0
	.set	macro
	.set	reorder

	sltu	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	lui	$9,%hi(seedX) # high
	.set	macro
	.set	reorder

$L3:
	li	$7,1			# 0x00000001
	lui	$9,%hi(seedX) # high
$L9:
	addiu	$8,$9,%lo(seedX) # low
	lw	$3,12($8)
	lw	$4,8($8)
	lw	$5,4($8)
	sw	$6,16($8)
	addu	$2,$6,$3
	addu	$6,$2,$7
	sltu	$7,$6,$3
	addu	$2,$6,$4
	sw	$6,12($8)
	addu	$6,$2,$7
	sltu	$7,$6,$4
	addu	$2,$6,$5
	sw	$6,8($8)
	addu	$6,$2,$7
	lw	$3,%lo(seedX)($9)
	lw	$2,20($8)
	sltu	$7,$6,$5
	sw	$6,4($8)
	addu	$3,$6,$3
	addu	$6,$3,$7
	addu	$2,$2,1
	sw	$6,%lo(seedX)($9)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	sw	$2,20($8)
	.set	macro
	.set	reorder

	lw	$2,16($8)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	sw	$2,16($8)
	.set	macro
	.set	reorder

	lw	$2,12($8)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	sw	$2,12($8)
	.set	macro
	.set	reorder

	lw	$2,8($8)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	sw	$2,8($8)
	.set	macro
	.set	reorder

	lw	$2,4($8)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	sw	$2,4($8)
	.set	macro
	.set	reorder

	addu	$2,$6,1
	sw	$2,%lo(seedX)($9)
	move	$6,$2
$L4:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSPCH_EACrandom
	.def	iSPCH_EACseedrandom;	.val	iSPCH_EACseedrandom;	.scl	2;	.type	0x64;	.endef
	.text
	.ent	iSPCH_EACseedrandom
iSPCH_EACseedrandom:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	seed;	.val	4;	.scl	17;	.type	0xe;	.endef
	li	$2,-231931904			# 0xf22d0000
	ori	$2,$2,0x0e56
	addu	$4,$4,$2
	li	$3,-1778122752			# 0x96040000
	ori	$3,$3,0x1893
	lui	$2,%hi(seedX) # high
	sw	$4,%lo(seedX)($2)
	addu	$4,$4,$3
	li	$3,1039335424			# 0x3df30000
	ori	$3,$3,0xb646
	addiu	$2,$2,%lo(seedX) # low
	sw	$4,4($2)
	addu	$4,$4,$3
	li	$3,1088225280			# 0x40dd0000
	ori	$3,$3,0xe76d
	sw	$4,8($2)
	addu	$4,$4,$3
	li	$3,-1758330880			# 0x97320000
	ori	$3,$3,0x7ae1
	sw	$4,12($2)
	addu	$4,$4,$3
	li	$3,-777453568			# 0xd1a90000
	ori	$3,$3,0xfbe7
	sw	$4,16($2)
	addu	$4,$4,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,20($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSPCH_EACseedrandom
	.def	iSPCH_Rand;	.val	iSPCH_Rand;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_Rand
iSPCH_Rand:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	n;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_EACrandom
	move	$16,$4
	.set	macro
	.set	reorder

	andi	$3,$2,0xffff
	rem	$2,$3,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	iSPCH_Rand
	.def	iSPCH_BindData;	.val	iSPCH_BindData;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_BindData
iSPCH_BindData:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	dat;	.val	4;	.scl	17;	.type	0x1d;	.endef
	lhu	$2,0($4)
	#nop
	sltu	$2,$2,286
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L18
	move	$6,$0
	.set	macro
	.set	reorder

	move	$5,$6
	lui	$2,%hi(gEventDats) # high
	addiu	$3,$2,%lo(gEventDats) # low
$L14:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L17
	addu	$5,$5,1
	.set	macro
	.set	reorder

	sw	$4,0($3)
	.set	noreorder
	.set	nomacro
	j	$L18
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L17:
	slt	$2,$5,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	addu	$3,$3,4
	.set	macro
	.set	reorder

	.def	done;	.val	$L18;	.scl	6;	.type	0x0;	.endef
$L18:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	iSPCH_BindData
