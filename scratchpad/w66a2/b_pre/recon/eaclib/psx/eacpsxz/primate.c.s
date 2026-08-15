	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\primate.c"
gcc2_compiled.:
__gnu_compiled_c:
	.rdata
	.align	2
$LC0:
	.ascii	"Draw Lists\000"
	.text
	.align	2
	.globl	initlinkmode
	.align	2
	.globl	waitdraw
	.align	2
	.globl	settrans

	.comm	maxot,4

	.comm	maxprim,4

	.comm	otbuf,4

	.comm	otbl,4

	.comm	otbl2,4

	.comm	primbuf,4

	.comm	primbase,4

	.comm	primbuf2,4

	.comm	primptr,4

	.comm	nextprim,4

	.comm	oti,4

	.comm	otp,4

	.comm	drawpending,4

	.comm	linkmodeflag,4

	.comm	semitrans,4

	.text
	.def	initlinkmode;	.val	initlinkmode;	.scl	2;	.type	0x61;	.endef
	.text
	.ent	initlinkmode
initlinkmode:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	unused;	.val	4;	.scl	17;	.type	0x11;	.endef
	.def	maxprimArg;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	linkmode;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$17,20($sp)
	lw	$4,otbuf
	li	$2,16			# 0x00000010
	sw	$31,24($sp)
	sw	$2,maxot
	sw	$16,maxprim
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L2
	move	$17,$6
	.set	macro
	.set	reorder

	jal	purgememadr
$L2:
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$6,16			# 0x00000010
	lw	$2,maxprim
	lw	$3,maxot
	sll	$5,$2,1
	addu	$5,$5,$2
	sll	$5,$5,2
	addu	$5,$5,$2
	addu	$5,$5,$3
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sll	$5,$5,3
	.set	macro
	.set	reorder

	lw	$5,maxot
	move	$4,$2
	sw	$4,otbuf
	sw	$4,otbl
	sll	$2,$5,3
	addu	$3,$4,$2
	sll	$2,$5,2
	addu	$2,$4,$2
	sw	$2,otbl2
	sll	$2,$16,1
	addu	$2,$2,$16
	sll	$2,$2,2
	addu	$2,$2,$16
	sll	$2,$2,2
	sw	$3,primbuf
	sw	$3,primbase
	addu	$3,$3,$2
	sw	$3,primbuf2
	jal	ClearOTagR
	lw	$2,otbuf
	lw	$3,primbuf
	lw	$4,otbl
	lw	$31,24($sp)
	sw	$17,linkmodeflag
	lw	$17,20($sp)
	lw	$16,16($sp)
	sw	$0,oti
	sw	$0,otp
	sw	$0,drawpending
	sw	$3,primptr
	sw	$4,nextprim
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	initlinkmode
	.def	waitdraw;	.val	waitdraw;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	waitdraw
waitdraw:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,drawpending
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	sw	$0,drawpending
$L4:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	waitdraw
	.def	settrans;	.val	settrans;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	settrans
settrans:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	mode;	.val	4;	.scl	17;	.type	0x4;	.endef
	bltz	$4,$L7
	beq	$4,$0,$L8
	.set	noreorder
	.set	nomacro
	j	$L9
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L8:
	li	$2,1			# 0x00000001
$L9:
	sw	$2,semitrans
	.def	done;	.val	$L7;	.scl	6;	.type	0x0;	.endef
$L7:
	lw	$2,semitrans
	.set	noreorder
	.set	nomacro
	j	$31
	sra	$2,$2,1
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	settrans
	.def	maxot;	.val	maxot;	.scl	2;	.type	0x4;	.endef
	.def	maxprim;	.val	maxprim;	.scl	2;	.type	0x4;	.endef
	.def	otbuf;	.val	otbuf;	.scl	2;	.type	0x12;	.endef
	.def	otbl;	.val	otbl;	.scl	2;	.type	0x12;	.endef
	.def	otbl2;	.val	otbl2;	.scl	2;	.type	0x12;	.endef
	.def	primbuf;	.val	primbuf;	.scl	2;	.type	0x12;	.endef
	.def	primbase;	.val	primbase;	.scl	2;	.type	0x12;	.endef
	.def	primbuf2;	.val	primbuf2;	.scl	2;	.type	0x12;	.endef
	.def	primptr;	.val	primptr;	.scl	2;	.type	0x12;	.endef
	.def	nextprim;	.val	nextprim;	.scl	2;	.type	0x12;	.endef
	.def	oti;	.val	oti;	.scl	2;	.type	0x4;	.endef
	.def	otp;	.val	otp;	.scl	2;	.type	0x4;	.endef
	.def	drawpending;	.val	drawpending;	.scl	2;	.type	0x4;	.endef
	.def	linkmodeflag;	.val	linkmodeflag;	.scl	2;	.type	0x4;	.endef
	.def	semitrans;	.val	semitrans;	.scl	2;	.type	0x4;	.endef
