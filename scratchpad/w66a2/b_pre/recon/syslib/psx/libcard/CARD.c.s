	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcard\\CARD.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	_card_clear

	.text
	.def	_card_clear;	.val	_card_clear;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	_card_clear
_card_clear:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	chan;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	_new_card
	move	$16,$4
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,63			# 0x0000003f
	.set	noreorder
	.set	nomacro
	jal	_card_write
	move	$6,$0
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


	.loc	1 0
LM1:
	.end	_card_clear
