	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\paths.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Paths_StartUp__Fv
	.globl	Paths_Paths
	.data
	.align	2
Paths_Paths:
	.space	200
	.globl	Paths_File
	.sdata
	.align	2
Paths_File:
	.space	4

	.extern	fePath, 1
	.extern	burnPath, 1

	.text
	.text
	.ent	Paths_StartUp__Fv
Paths_StartUp__Fv:
	.frame	$sp,24,$31		# vars= 24, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$4,burnPath
	li	$3,49			# 0x00000031
	lui	$2,%hi(Paths_Paths) # high
	addiu	$2,$2,%lo(Paths_Paths) # low
	addu	$2,$2,196
$L601:
	sw	$4,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L601
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	lui	$2,%hi(Paths_Paths) # high
	addiu	$2,$2,%lo(Paths_Paths) # low
	la	$3,fePath
	sw	$3,144($2)
	sw	$3,128($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Paths_StartUp__Fv
