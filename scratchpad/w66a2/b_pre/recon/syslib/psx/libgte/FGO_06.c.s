	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgte\\FGO_06.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set	noat
	.set	noreorder
	.set noreorder
	.globl RotMatrixZ
RotMatrixZ:
	addu	$t7,$a0,$zero
	addu	$v0,$a1,$zero
	bgez	$t7,.L800F3170
	andi	$t9,$t7,4095
	negu	$t7,$t7
	bgez	$t7,.L800F3148
	andi	$t7,$t7,4095
.L800F3148:
	sll	$t8,$t7,2
	lui	$t9,%hi(_rsincos)
	addu	$t9,$t9,$t8
	lw	$t9,%lo(_rsincos)($t9)
	nop
	sll	$t6,$t9,16
	sra	$t6,$t6,16
	negu	$t1,$t6
	j	.L800F3190
	sra	$t0,$t9,16
.L800F3170:
	sll	$t8,$t9,2
	lui	$t9,%hi(_rsincos)
	addu	$t9,$t9,$t8
	lw	$t9,%lo(_rsincos)($t9)
	nop
	sll	$t8,$t9,16
	sra	$t1,$t8,16
	sra	$t0,$t9,16
.L800F3190:
	lh	$t2,0($a1)
	lh	$t5,6($a1)
	.word	0x010A0019
	lh	$t3,2($a1)
	lh	$t6,8($a1)
	mflo	$t8
	lh	$t4,4($a1)
	lh	$t7,10($a1)
	.word	0x012D0019
	nop
	nop
	mflo	$t9
	subu	$t9,$t8,$t9
	sra	$t8,$t9,12
	.word	0x010B0019
	sh	$t8,0($a1)
	nop
	mflo	$t8
	nop
	nop
	.word	0x012E0019
	nop
	nop
	mflo	$t9
	subu	$t9,$t8,$t9
	sra	$t8,$t9,12
	.word	0x010C0019
	sh	$t8,2($a1)
	nop
	mflo	$t8
	nop
	nop
	.word	0x012F0019
	nop
	nop
	mflo	$t9
	subu	$t9,$t8,$t9
	sra	$t8,$t9,12
	.word	0x012A0019
	sh	$t8,4($a1)
	nop
	mflo	$t8
	nop
	nop
	.word	0x010D0019
	nop
	nop
	mflo	$t9
	addu	$t9,$t8,$t9
	sra	$t8,$t9,12
	.word	0x012B0019
	sh	$t8,6($a1)
	nop
	mflo	$t8
	nop
	nop
	.word	0x010E0019
	nop
	nop
	mflo	$t9
	addu	$t9,$t8,$t9
	sra	$t8,$t9,12
	.word	0x012C0019
	sh	$t8,8($a1)
	nop
	mflo	$t8
	nop
	nop
	.word	0x010F0019
	nop
	nop
	mflo	$t9
	addu	$t9,$t8,$t9
	sra	$t8,$t9,12
	sh	$t8,10($a1)
	jr	$ra
	nop
	.set	reorder


	.text
