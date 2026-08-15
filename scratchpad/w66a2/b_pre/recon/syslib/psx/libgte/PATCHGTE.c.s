	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgte\\PATCHGTE.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.section .text
	.set noat
	.set	noreorder
	.set noreorder
	.globl _patch_gte
_patch_gte:
	lui   $at, %hi(_patch_gte_ra_save)
	sw    $ra, %lo(_patch_gte_ra_save)($at)
	jal   EnterCriticalSection
	 nop
	addiu $t1, $zero, 86
	addiu $t2, $zero, 176
	jalr  $t2
	 nop
	lw    $v0, 24($v0)
	nop
	addiu $v0, $v0, 40
	addu  $t7, $v0, $zero
	lui   $t2, %hi(_gte_patch_text)
	addiu $t2, $t2, %lo(_gte_patch_text)
	lui   $t1, %hi(_gte_patch_text+24)
	addiu $t1, $t1, %lo(_gte_patch_text+24)
1:
	lw    $v1, 0($t2)
	lw    $t3, 0($v0)
	addiu $t2, $t2, 4
	bne   $v1, $t3, 3f
	 addiu $v0, $v0, 4
	bne   $t2, $t1, 1b
	 nop
	addu  $v0, $t7, $zero
	lui   $t2, %hi(_gte_patch_text+24)
	addiu $t2, $t2, %lo(_gte_patch_text+24)
	lui   $t1, %hi(_gte_patch_text+48)
	addiu $t1, $t1, %lo(_gte_patch_text+48)
2:
	lw    $v1, 0($t2)
	nop
	sw    $v1, 0($v0)
	addiu $t2, $t2, 4
	bne   $t2, $t1, 2b
	 addiu $v0, $v0, 4
3:
	jal   FlushCache
	 nop
	jal   ExitCriticalSection
	 nop
	lui   $ra, %hi(_patch_gte_ra_save)
	lw    $ra, %lo(_patch_gte_ra_save)($ra)
	nop
	jr    $ra
	 nop
	.globl _patch_gte_handler_1
_patch_gte_handler_1:
	.type  _patch_gte_handler_1, @function
	.size  _patch_gte_handler_1, 0x30
	.globl _gte_patch_text
_gte_patch_text = _patch_gte_handler_1
	.word 0xaf410004
	.word 0xaf420008
	.word 0xaf43000c
	.word 0xaf5f007c
	.word 0x40037000
	.word 0x00000000
	.globl D_80106518
D_80106518:
	.word 0xaf410004
	.word 0xaf420008
	.word 0x40026800
	.word 0xaf43000c
	.word 0x40037000
	.word 0xaf5f007c
	.globl D_80106530
D_80106530:
	.word 0x00000000
	.set	pop

 #NO_APP
	.text

	.comm	_patch_gte_ra_save,4

	.text
	.def	_patch_gte_ra_save;	.val	_patch_gte_ra_save;	.scl	2;	.type	0x4;	.endef
