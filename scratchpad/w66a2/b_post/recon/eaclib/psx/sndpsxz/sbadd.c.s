	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sbadd.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDbankadd

	.text
	.def	SNDbankadd;	.val	SNDbankadd;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDbankadd
SNDbankadd:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	bank_out;	.val	18;	.scl	17;	.type	0x14;	.endef
	.def	bankData;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	lui	$2,%hi(sndgs) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(sndgs) # low
	sw	$31,28($sp)
	sw	$17,20($sp)
	lb	$2,60($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	move	$17,$5
	.set	macro
	.set	reorder

	jal	iSNDbankalloc
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,2
	move	$4,$17
	sw	$2,0($18)
	lw	$2,152($16)
	move	$5,$4
	addu	$2,$2,$3
	sw	$17,0($2)
	sw	$17,4($2)
	lui	$2,%hi(SNDbankremove) # high
	addiu	$2,$2,%lo(SNDbankremove) # low
	.set	noreorder
	.set	nomacro
	jal	iSNDdownloadbank
	sw	$2,124($16)
	.set	macro
	.set	reorder

	j	$L3
$L2:
	li	$2,-10			# 0xfffffff6
$L3:
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
	.end	SNDbankadd
