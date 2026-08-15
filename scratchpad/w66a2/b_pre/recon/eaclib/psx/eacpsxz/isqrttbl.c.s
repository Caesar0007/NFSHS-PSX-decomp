	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\isqrttbl.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	remapshiftjiscode
 #APP
		.globl decodeshiftjis2
decodeshiftjis2 = decodeshiftjis
	.globl decodeshiftjis3
decodeshiftjis3 = decodeshiftjis

 #NO_APP
	.align	2
	.globl	decodeshiftjis

	.text
	.def	remapshiftjiscode;	.val	remapshiftjiscode;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	remapshiftjiscode
remapshiftjiscode:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	c;	.val	4;	.scl	17;	.type	0xe;	.endef
	addu	$5,$4,-32
	sltu	$2,$5,96
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	lui	$3,%hi(D_8013BD50) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(D_8013BD50) # low
	sll	$2,$5,1
	addu	$2,$2,$3
	lhu	$4,0($2)
$L2:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	remapshiftjiscode
	.def	decodeshiftjis;	.val	decodeshiftjis;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	decodeshiftjis
decodeshiftjis:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	cursor;	.val	17;	.scl	17;	.type	0x5c;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$16,0($17)
	#nop
	lbu	$4,0($16)
	#nop
	andi	$2,$4,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	addu	$16,$16,1
	.set	macro
	.set	reorder

	lbu	$3,0($16)
	addu	$16,$16,1
	sll	$2,$4,8
	.set	noreorder
	.set	nomacro
	j	$L5
	or	$2,$3,$2
	.set	macro
	.set	reorder

$L4:
	jal	remapshiftjiscode
$L5:
	sw	$16,0($17)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	andi	$2,$2,0xffff
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	decodeshiftjis
