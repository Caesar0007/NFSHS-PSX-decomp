	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgte\\MSC02.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set	noreorder
	.set noreorder
	.globl VectorNormalS
VectorNormalS:
	lw    $t0, 0($a0)
	lw    $t1, 4($a0)
	lw    $t2, 8($a0)
	b     .L_vecnormSS_tail
	 nop
	.set	pop

		.set	noreorder
	.set noreorder
	.globl VectorNormal
VectorNormal:
	lw    $t0, 0($a0)
	lw    $t1, 4($a0)
	lw    $t2, 8($a0)
	addu  $a3, $ra, $zero
	jal   _VectorNormalSS_kernel
	 nop
	sw    $t0, 0($a1)
	sw    $t1, 4($a1)
	sw    $t2, 8($a1)
	addu  $ra, $a3, $zero
	jr    $ra
	 nop
	.set	pop

		.set	noreorder
	.set noreorder
	.globl VectorNormalSS
VectorNormalSS:
	lh    $t0, 0($a0)
	lh    $t1, 2($a0)
	lh    $t2, 4($a0)
.L_vecnormSS_tail:
	addu  $a3, $ra, $zero
	jal   _VectorNormalSS_kernel
	 nop
	sh    $t0, 0($a1)
	sh    $t1, 2($a1)
	sh    $t2, 4($a1)
	addu  $ra, $a3, $zero
	jr    $ra
	 nop
	.set	pop

		.set noat
	.set	noreorder
	.set noreorder
	.globl _VectorNormalSS_kernel
_VectorNormalSS_kernel:
	mtc2  $t0, $9
	mtc2  $t1, $10
	mtc2  $t2, $11
	nop
	.word 0x4AA00428
	mfc2  $t3, $25
	mfc2  $t4, $26
	mfc2  $t5, $27
	add   $t3, $t3, $t4
	add   $v0, $t3, $t5
	mtc2  $v0, $30
	nop
	nop
	mfc2  $v1, $31
	addiu $at, $zero, -2
	and   $v1, $v1, $at
	addiu $t6, $zero, 31
	sub   $t6, $t6, $v1
	sra   $t6, $t6, 1
	addi  $t3, $v1, -24
	bltz  $t3, 1f
	 nop
	b     2f
	 sllv  $t4, $v0, $t3
1:
	addiu $t3, $zero, 24
	sub   $t3, $t3, $v1
	srav  $t4, $v0, $t3
2:
	addi  $t4, $t4, -64
	sll   $t4, $t4, 1
	lui   $t5, %hi(D_8013485C)
	addu  $t5, $t5, $t4
	lh    $t5, %lo(D_8013485C)($t5)
	nop
	mtc2  $t5, $8
	mtc2  $t0, $9
	mtc2  $t1, $10
	mtc2  $t2, $11
	nop
	nop
	.word 0x4B90003D
	mfc2  $t0, $25
	mfc2  $t1, $26
	mfc2  $t2, $27
	srav  $t0, $t0, $t6
	srav  $t1, $t1, $t6
	srav  $t2, $t2, $t6
	jr    $ra
	 nop
	.set	pop


	.text
