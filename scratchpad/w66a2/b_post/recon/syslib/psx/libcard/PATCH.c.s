	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcard\\PATCH.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	D_80148AC4
	.section	.bss
	.align	2
D_80148AC4:
	.space	4
	.text
		.set noat
	.set	noreorder
	.set noreorder
	.globl func_8010CA40
func_8010CA40:
	lui   $v0, 0xA001
	addiu $v0, $v0, -8276
	jr    $v0
	 nop
	nop
	lui   $t0, 0xA001
	addiu $t0, $t0, -8320
	jalr  $t0
	 nop
	.type  func_8010CA40, @function
	.size  func_8010CA40, 0x24
pad_8010CA64:
	nop
	.set at

		.set noat
	.set	noreorder
	.set noreorder
	.globl _patch_card
_patch_card:
	lui   $at, %hi(D_80148AC4)
	sw    $ra, %lo(D_80148AC4)($at)
	jal   EnterCriticalSection
	 nop
	addiu $t1, $zero, 0x56
	addiu $t2, $zero, 0xB0
	jalr  $t2
	 nop
	lw    $v0, 24($v0)
	nop
	lw    $v1, 112($v0)
	nop
	andi  $t1, $v1, 0xFFFF
	sll   $t1, $t1, 16
	lw    $v1, 116($v0)
	nop
	andi  $t2, $v1, 0xFFFF
	addu  $v1, $t1, $t2
	addiu $v0, $v1, 0x28
	lui   $t2, %hi(func_8010CA40)
	addiu $t2, $t2, %lo(func_8010CA40)
	lui   $t1, %hi(func_8010CA40 + 0x14)
	addiu $t1, $t1, %lo(func_8010CA40 + 0x14)
.L_patch_card_loop:
	lw    $v1, 0($t2)
	nop
	sw    $v1, 0($v0)
	addiu $t2, $t2, 4
	bne   $t2, $t1, .L_patch_card_loop
	 addiu $v0, $v0, 4
	lui   $at, 0x1
	jal   FlushCache
	 sw   $v0, -8196($at)
	lui   $ra, %hi(D_80148AC4)
	lw    $ra, %lo(D_80148AC4)($ra)
	nop
	jr    $ra
	 nop
	.set	pop

		.set noat
	.set	noreorder
	.set noreorder
	.globl _patch_card2
_patch_card2:
	lui   $at, %hi(D_80148AC4)
	sw    $ra, %lo(D_80148AC4)($at)
	jal   EnterCriticalSection
	 nop
	addiu $t1, $zero, 0x57
	addiu $t2, $zero, 0xB0
	jalr  $t2
	 nop
	lw    $v0, 364($v0)
	nop
	lw    $v1, 2504($v0)
	lui   $t2, %hi(func_8010CA40 + 0x14)
	addiu $t2, $t2, %lo(func_8010CA40 + 0x14)
	lui   $t1, %hi(_patch_card)
	addiu $t1, $t1, %lo(_patch_card)
.L_patch_card2_loop:
	lw    $t0, 0($t2)
	nop
	sw    $t0, 2504($v0)
	addiu $t2, $t2, 4
	bne   $t2, $t1, .L_patch_card2_loop
	 addiu $v0, $v0, 4
	jal   FlushCache
	 nop
	lui   $ra, %hi(D_80148AC4)
	lw    $ra, %lo(D_80148AC4)($ra)
	nop
	jr    $ra
	 nop
	.set	pop

		.set noat
	.set	noreorder
	.set noreorder
	.globl _copy_memcard_patch
_copy_memcard_patch:
	ori   $v0, $zero, 0xDF80
	lui   $t2, %hi(InitCARD2 + 0x10)
	addiu $t2, $t2, %lo(InitCARD2 + 0x10)
	lui   $t1, %hi(func_8010CA40)
	addiu $t1, $t1, %lo(func_8010CA40)
.L_copy_memcard_patch_loop:
	lw    $v1, 0($t2)
	nop
	sw    $v1, 0($v0)
	addiu $t2, $t2, 4
	bne   $t2, $t1, .L_copy_memcard_patch_loop
	 addiu $v0, $v0, 4
	jr    $ra
	 nop
	.set	pop


	.text
