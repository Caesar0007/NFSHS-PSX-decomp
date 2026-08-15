	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\xform.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	xformy
	.align	2
	.globl	fixedxformx
	.align	2
	.globl	fixedxformy
	.align	2
	.globl	fixedxformz

	.text
	.def	matrixtdef;	.scl	10;	.type	0x8;	.size	36;	.endef
	.def	m;	.val	0;	.scl	8;	.dim	9;	.size	36;	.type	0x34;	.endef
	.def	.eos;	.val	36;	.scl	102;	.tag	matrixtdef;	.size	36;	.endef
	.def	matrixtdef;	.scl	13;	.tag	matrixtdef;	.size	36;	.type	0x8;	.endef
	.def	xformy;	.val	xformy;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	xformy
xformy:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	out;	.val	16;	.scl	17;	.tag	matrixtdef;	.size	36;	.type	0x18;	.endef
	.def	angle;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$4
	move	$4,$5
	addu	$5,$sp,16
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	intsincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	sw	$0,4($16)
	sw	$0,12($16)
	lw	$4,20($sp)
	lw	$3,16($sp)
	li	$2,65536			# 0x00010000
	sw	$2,16($16)
	sw	$0,20($16)
	sw	$0,28($16)
	subu	$2,$0,$3
	sw	$4,0($16)
	sw	$2,8($16)
	sw	$3,24($16)
	sw	$4,32($16)
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	xformy
	.def	fixedxformx;	.val	fixedxformx;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	fixedxformx
fixedxformx:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	out;	.val	16;	.scl	17;	.tag	matrixtdef;	.size	36;	.type	0x18;	.endef
	.def	angle;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$4
	move	$4,$5
	addu	$5,$sp,16
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedsincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	lw	$4,20($sp)
	lw	$3,16($sp)
	li	$2,65536			# 0x00010000
	sw	$2,0($16)
	sw	$0,4($16)
	sw	$0,8($16)
	sw	$0,12($16)
	sw	$0,24($16)
	sw	$3,20($16)
	subu	$3,$0,$3
	sw	$4,16($16)
	sw	$3,28($16)
	sw	$4,32($16)
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	fixedxformx
	.def	fixedxformy;	.val	fixedxformy;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	fixedxformy
fixedxformy:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	out;	.val	16;	.scl	17;	.tag	matrixtdef;	.size	36;	.type	0x18;	.endef
	.def	angle;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$4
	move	$4,$5
	addu	$5,$sp,16
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedsincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	sw	$0,4($16)
	sw	$0,12($16)
	lw	$4,20($sp)
	lw	$3,16($sp)
	li	$2,65536			# 0x00010000
	sw	$2,16($16)
	sw	$0,20($16)
	sw	$0,28($16)
	subu	$2,$0,$3
	sw	$4,0($16)
	sw	$2,8($16)
	sw	$3,24($16)
	sw	$4,32($16)
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	fixedxformy
	.def	fixedxformz;	.val	fixedxformz;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	fixedxformz
fixedxformz:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	out;	.val	16;	.scl	17;	.tag	matrixtdef;	.size	36;	.type	0x18;	.endef
	.def	angle;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$4
	move	$4,$5
	addu	$5,$sp,16
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedsincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	sw	$0,8($16)
	sw	$0,20($16)
	sw	$0,24($16)
	sw	$0,28($16)
	lw	$4,20($sp)
	lw	$3,16($sp)
	li	$2,65536			# 0x00010000
	sw	$2,32($16)
	sw	$3,4($16)
	subu	$3,$0,$3
	sw	$4,0($16)
	sw	$3,12($16)
	sw	$4,16($16)
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	fixedxformz
