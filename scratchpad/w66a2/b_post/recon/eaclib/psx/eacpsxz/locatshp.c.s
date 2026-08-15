	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\locatshp.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	locateshape
	.align	2
	.globl	locateshapez

	.text
	.def	locateshape;	.val	locateshape;	.scl	2;	.type	0x61;	.endef
	.text
	.ent	locateshape
locateshape:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	shapefile;	.val	4;	.scl	17;	.type	0x11;	.endef
	.def	namekey;	.val	5;	.scl	17;	.type	0x14;	.endef
	lw	$3,8($4)
	lw	$5,0($5)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L3
	sll	$2,$3,3
	.set	macro
	.set	reorder

	addu	$6,$2,$4
	addu	$3,$3,-1
	.def	scan;	.val	$L4;	.scl	6;	.type	0x0;	.endef
$L4:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L5
	addu	$6,$6,-8
	.set	macro
	.set	reorder

	lw	$2,16($6)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L4
	addu	$3,$3,-1
	.set	macro
	.set	reorder

	addu	$3,$3,1
$L5:
	sll	$2,$3,3
	addu	$3,$2,$4
	lw	$2,16($3)
	#nop
	bne	$2,$5,$L3
	lw	$2,20($3)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder

	.def	notfound;	.val	$L3;	.scl	6;	.type	0x0;	.endef
$L3:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	locateshape
	.def	locateshapez;	.val	locateshapez;	.scl	2;	.type	0x61;	.endef
	.text
	.ent	locateshapez
locateshapez:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	shapefile;	.val	4;	.scl	17;	.type	0x11;	.endef
	.def	namekey;	.val	5;	.scl	17;	.type	0x14;	.endef
	lw	$3,8($4)
	lw	$5,0($5)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L11
	sll	$2,$3,3
	.set	macro
	.set	reorder

	addu	$6,$2,$4
	addu	$3,$3,-1
	.def	scan;	.val	$L12;	.scl	6;	.type	0x0;	.endef
$L12:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L13
	addu	$6,$6,-8
	.set	macro
	.set	reorder

	lw	$2,16($6)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L12
	addu	$3,$3,-1
	.set	macro
	.set	reorder

	addu	$3,$3,1
$L13:
	sll	$2,$3,3
	addu	$3,$2,$4
	lw	$2,16($3)
	#nop
	bne	$2,$5,$L11
	lw	$2,20($3)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder

	.def	notfound;	.val	$L11;	.scl	6;	.type	0x0;	.endef
$L11:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	locateshapez
