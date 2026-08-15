	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgte\\FGO_01.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set	noat
	.set	noreorder
	.set noreorder
	.globl RotMatrix
RotMatrix:
	lh	$t7,0($a0)
	addu	$v0,$a1,$zero
	bgez	$t7,.L800F2570
	andi	$t9,$t7,4095
	negu	$t7,$t7
	bgez	$t7,.L800F2548
	andi	$t7,$t7,4095
.L800F2548:
	sll	$t8,$t7,2
	lui	$t9,%hi(_rsincos)
	addu	$t9,$t9,$t8
	lw	$t9,%lo(_rsincos)($t9)
	nop
	sll	$t8,$t9,16
	sra	$t8,$t8,16
	negu	$t3,$t8
	j	.L800F2590
	sra	$t0,$t9,16
.L800F2570:
	sll	$t8,$t9,2
	lui	$t9,%hi(_rsincos)
	addu	$t9,$t9,$t8
	lw	$t9,%lo(_rsincos)($t9)
	nop
	sll	$t8,$t9,16
	sra	$t3,$t8,16
	sra	$t0,$t9,16
.L800F2590:
	lh	$t7,2($a0)
	nop
	bgez	$t7,.L800F25D4
	andi	$t9,$t7,4095
	negu	$t7,$t7
	bgez	$t7,.L800F25AC
	andi	$t7,$t7,4095
.L800F25AC:
	sll	$t8,$t7,2
	lui	$t9,%hi(_rsincos)
	addu	$t9,$t9,$t8
	lw	$t9,%lo(_rsincos)($t9)
	nop
	sll	$t4,$t9,16
	sra	$t4,$t4,16
	negu	$t6,$t4
	j	.L800F25F8
	sra	$t1,$t9,16
.L800F25D4:
	sll	$t8,$t9,2
	lui	$t9,%hi(_rsincos)
	addu	$t9,$t9,$t8
	lw	$t9,%lo(_rsincos)($t9)
	nop
	sll	$t6,$t9,16
	sra	$t6,$t6,16
	negu	$t4,$t6
	sra	$t1,$t9,16
.L800F25F8:
	.word	0x012B0019
	lh	$t7,4($a0)
	sh	$t6,4($a1)
	mflo	$t8
	negu	$t9,$t8
	sra	$t6,$t9,12
	.word	0x01280019
	sh	$t6,10($a1)
	bgez	$t7,.L800F2660
	andi	$t9,$t7,4095
	mflo	$t8
	sra	$t6,$t8,12
	sh	$t6,16($a1)
	negu	$t7,$t7
	bgez	$t7,.L800F2638
	andi	$t7,$t7,4095
.L800F2638:
	sll	$t8,$t7,2
	lui	$t9,%hi(_rsincos)
	addu	$t9,$t9,$t8
	lw	$t9,%lo(_rsincos)($t9)
	nop
	sll	$t8,$t9,16
	sra	$t8,$t8,16
	negu	$t5,$t8
	j	.L800F268C
	sra	$t2,$t9,16
.L800F2660:
	mflo	$t7
	sra	$t6,$t7,12
	sh	$t6,16($a1)
	sll	$t8,$t9,2
	lui	$t9,%hi(_rsincos)
	addu	$t9,$t9,$t8
	lw	$t9,%lo(_rsincos)($t9)
	nop
	sll	$t8,$t9,16
	sra	$t5,$t8,16
	sra	$t2,$t9,16
.L800F268C:
	.word	0x01490019
	nop
	nop
	mflo	$t7
	sra	$t6,$t7,12
	sh	$t6,0($a1)
	.word	0x01A90019
	nop
	nop
	mflo	$t7
	negu	$t6,$t7
	sra	$t7,$t6,12
	.word	0x014C0019
	sh	$t7,2($a1)
	nop
	mflo	$t7
	sra	$t8,$t7,12
	nop
	.word	0x030B0019
	nop
	nop
	mflo	$t7
	sra	$t6,$t7,12
	nop
	.word	0x01A80019
	nop
	nop
	mflo	$t7
	sra	$t9,$t7,12
	subu	$t7,$t9,$t6
	.word	0x03080019
	sh	$t7,6($a1)
	nop
	mflo	$t6
	sra	$t7,$t6,12
	nop
	.word	0x01AB0019
	nop
	nop
	mflo	$t6
	sra	$t9,$t6,12
	addu	$t6,$t9,$t7
	.word	0x01AC0019
	sh	$t6,12($a1)
	nop
	mflo	$t7
	sra	$t8,$t7,12
	nop
	.word	0x030B0019
	nop
	nop
	mflo	$t7
	sra	$t6,$t7,12
	nop
	.word	0x01480019
	nop
	nop
	mflo	$t7
	sra	$t9,$t7,12
	addu	$t7,$t9,$t6
	.word	0x03080019
	sh	$t7,8($a1)
	nop
	mflo	$t6
	sra	$t7,$t6,12
	nop
	.word	0x014B0019
	nop
	nop
	mflo	$t6
	sra	$t9,$t6,12
	subu	$t6,$t9,$t7
	sh	$t6,14($a1)
	jr	$ra
	nop
	.set	reorder


	.text
