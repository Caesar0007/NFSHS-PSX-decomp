	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcard\\END.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	D_80148AD4
	.section	.bss
	.align	2
D_80148AD4:
	.space	4
	.text
		.set noat
	.set	noreorder
	.set noreorder
	.globl _ExitCard
_ExitCard:
	lui   $at, %hi(D_80148AD4)
	sw    $ra, %lo(D_80148AD4)($at)
	jal   EnterCriticalSection
	 nop
	addiu $t1, $zero, 0x56
	addiu $t2, $zero, 0xB0
	jalr  $t2
	 nop
	lw    $v0, 24($v0)
	lui   $t2, %hi(D_8010CC30)
	addiu $t2, $t2, %lo(D_8010CC30)
	lui   $t1, %hi(D_8010CC3C)
	addiu $t1, $t1, %lo(D_8010CC3C)
.L_ExitCard_loop:
	lw    $v1, 0($t2)
	nop
	sw    $v1, 112($v0)
	addiu $t2, $t2, 4
	bne   $t2, $t1, .L_ExitCard_loop
	 addiu $v0, $v0, 4
	jal   FlushCache
	 nop
	jal   ExitCriticalSection
	 nop
	lui   $ra, %hi(D_80148AD4)
	lw    $ra, %lo(D_80148AD4)($ra)
	nop
	jr    $ra
	 nop
	.globl D_8010CC30
D_8010CC30:
	.word 0
	.word 0
	.word 0
	.globl D_8010CC3C
D_8010CC3C:
	.word 0
	.set at


	.text
