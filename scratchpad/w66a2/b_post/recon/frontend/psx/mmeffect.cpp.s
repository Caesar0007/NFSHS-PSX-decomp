	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\psx\\\\mmeffect.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	FeDraw_SetABRMode__Fi

	.text
	.text
	.ent	FeDraw_SetABRMode__Fi
FeDraw_SetABRMode__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$5,$4
	li	$11,528482304			# 0x1f800000
	ori	$11,$11,0x0004
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	li	$4,2			# 0x00000002
	move	$6,$0
	li	$7,256			# 0x00000100
	li	$10,-16777216			# 0xff000000
	sw	$31,28($sp)
	sw	$16,24($sp)
	lw	$16,0($11)
	lw	$8,528482304
	lw	$3,0($16)
	lw	$2,0($8)
	and	$3,$3,$10
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($16)
	addu	$3,$16,12
	lw	$2,0($8)
	and	$9,$16,$9
	sw	$3,0($11)
	and	$2,$2,$10
	or	$2,$2,$9
	.set	noreorder
	.set	nomacro
	jal	GetTPage
	sw	$2,0($8)
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	move	$6,$5
	andi	$7,$2,0xffff
	.set	noreorder
	.set	nomacro
	jal	SetDrawMode
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	FeDraw_SetABRMode__Fi
