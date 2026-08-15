	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fastmovf.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	fastmovfxya

	.extern	nextprim, 4
	.extern	primptr, 4

	.text
	.def	.0fake;	.scl	10;	.type	0x8;	.size	8;	.endef
	.def	x;	.val	0;	.scl	8;	.type	0x3;	.endef
	.def	y;	.val	2;	.scl	8;	.type	0x3;	.endef
	.def	w;	.val	4;	.scl	8;	.type	0x3;	.endef
	.def	h;	.val	6;	.scl	8;	.type	0x3;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	.0fake;	.size	8;	.endef
	.def	RECT;	.scl	13;	.tag	.0fake;	.size	8;	.type	0x8;	.endef
	.def	fastmovfxya;	.val	fastmovfxya;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	fastmovfxya
fastmovfxya:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	shape;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	x;	.val	8;	.scl	17;	.type	0x4;	.endef
	.def	y;	.val	9;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	move	$8,$5
	move	$9,$6
	sw	$31,28($sp)
	sw	$16,24($sp)
	lh	$5,4($4)
	lw	$3,12($4)
	lh	$4,6($4)
	sll	$2,$3,20
	sra	$7,$2,20
	sll	$6,$3,4
	lui	$2,%hi(currentwindow) # high
	addiu	$10,$2,%lo(currentwindow) # low
	lw	$2,24($10)
	#nop
	subu	$2,$2,$8
	.set	noreorder
	.set	nomacro
	blez	$2,$L2
	sra	$6,$6,20
	.set	macro
	.set	reorder

	addu	$8,$8,$2
	addu	$7,$7,$2
	subu	$5,$5,$2
$L2:
	lw	$3,32($10)
	addu	$2,$8,$5
	subu	$2,$2,$3
	blez	$2,$L3
	subu	$5,$5,$2
$L3:
	lw	$2,28($10)
	#nop
	subu	$2,$2,$9
	blez	$2,$L4
	addu	$9,$9,$2
	addu	$6,$6,$2
	subu	$4,$4,$2
$L4:
	lw	$3,36($10)
	addu	$2,$9,$4
	subu	$2,$2,$3
	blez	$2,$L5
	subu	$4,$4,$2
$L5:
	sh	$7,16($sp)
	sh	$6,18($sp)
	sh	$5,20($sp)
	.set	noreorder
	.set	nomacro
	blez	$5,$L6
	sh	$4,22($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$4,$L6
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	lw	$16,primptr
	lw	$6,4($10)
	lw	$7,8($10)
	addu	$2,$16,24
	move	$4,$16
	addu	$6,$6,$8
	sw	$2,primptr
	.set	noreorder
	.set	nomacro
	jal	SetDrawMove
	addu	$7,$7,$9
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,nextprim
	#.set	novolatile
	#.set	volatile
	lw	$13,nextprim
	#.set	novolatile
 #APP
	lwl	$14,2($2)
 sll $15,$16,8
 swl $14,2($16)
 swl $15,2($2)
 #NO_APP
	#.set	volatile
	sw	$16,nextprim
	#.set	novolatile
$L6:
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
	.end	fastmovfxya
