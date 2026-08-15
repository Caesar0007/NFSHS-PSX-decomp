	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screendisplay.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	DrawBackground__14tScreenDisplay
	.ent	DrawBackground__14tScreenDisplay
DrawBackground__14tScreenDisplay:
	.frame	$sp,48,$31		# vars= 0, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	subu	$sp,$sp,48
	sw	$31,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lw	$2,10972($2)
	#nop
	sra	$2,$2,1
	move	$3,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L601
	move	$16,$0
	.set	macro
	.set	reorder

	li	$3,128			# 0x00000080
$L601:
	sll	$2,$3,16
	sra	$17,$2,16
	addu	$4,$16,11
$L606:
	move	$5,$0
	move	$6,$5
	move	$7,$5
	sw	$17,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	addu	$4,$16,11
	.set	macro
	.set	reorder

	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	DrawBackground__14tScreenDisplay
	.rdata
	.align	2
$LC0:
	.ascii	"zDsply\000"
	.text
	.align	2
	.globl	GetShapeInfo__14tScreenDisplayRsT1PPcT3
	.ent	GetShapeInfo__14tScreenDisplayRsT1PPcT3
GetShapeInfo__14tScreenDisplayRsT1PPcT3:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($sp)
	#nop
	sw	$0,0($2)
	li	$2,43			# 0x0000002b
	sh	$0,0($6)
	sh	$2,0($5)
	lui	$2,%hi($LC0) # high
	addiu	$2,$2,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($7)
	.set	macro
	.set	reorder

	.end	GetShapeInfo__14tScreenDisplayRsT1PPcT3
	.align	2
	.globl	___14tScreenDisplay
	.ent	___14tScreenDisplay
___14tScreenDisplay:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___7tScreen
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___14tScreenDisplay
	.globl	screenDisplay
	.data
	.align	2
screenDisplay:
	.space	4
