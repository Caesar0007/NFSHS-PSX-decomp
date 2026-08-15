	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgte\\MSC00.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noreorder
	.globl InitGeom
InitGeom:
	lui  $at, %hi(_InitGeom_ra_save)
	sw   $ra, %lo(_InitGeom_ra_save)($at)
	jal  _patch_gte
	lui  $ra, %hi(_InitGeom_ra_save)
	lw   $ra, %lo(_InitGeom_ra_save)($ra)
	nop
	mfc0 $v0, $12
	lui  $v1, 0x4000
	or   $v0, $v0, $v1
	mtc0 $v0, $12
	nop
	addiu $t0, $zero, 0x155
	ctc2  $t0, $29
	nop
	addiu $t0, $zero, 0x100
	ctc2  $t0, $30
	nop
	addiu $t0, $zero, 0x3E8
	ctc2  $t0, $26
	nop
	addiu $t0, $zero, -0x1062
	ctc2  $t0, $27
	nop
	lui  $t0, 0x140
	ctc2  $t0, $28
	nop
	ctc2  $zero, $24
	ctc2  $zero, $25
	nop
	jr   $ra
	 nop
	.set pop

 #NO_APP
	.text

	.comm	_InitGeom_ra_save,4

	.text
	.def	_InitGeom_ra_save;	.val	_InitGeom_ra_save;	.scl	2;	.type	0x4;	.endef
