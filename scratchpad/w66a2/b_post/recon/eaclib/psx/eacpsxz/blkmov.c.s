	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\blkmov.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl blockmove
blockmove:
	slt    $1, $4, $5
	bnez   $1, .L800E64D0
.L800E62E4:
	or     $2, $4, $5
	andi   $2, $2, 3
	bnez   $2, .L800E641C
	nop
	addiu  $6, $6, -64
	bltz   $6, .L800E6390
	nop
.L800E6300:
	lw     $8, 0($4)
	lw     $9, 4($4)
	lw     $10, 8($4)
	lw     $11, 12($4)
	lw     $12, 16($4)
	lw     $13, 20($4)
	lw     $14, 24($4)
	lw     $15, 28($4)
	sw     $8, 0($5)
	sw     $9, 4($5)
	sw     $10, 8($5)
	sw     $11, 12($5)
	sw     $12, 16($5)
	sw     $13, 20($5)
	sw     $14, 24($5)
	sw     $15, 28($5)
	lw     $8, 32($4)
	lw     $9, 36($4)
	lw     $10, 40($4)
	lw     $11, 44($4)
	lw     $12, 48($4)
	lw     $13, 52($4)
	lw     $14, 56($4)
	lw     $15, 60($4)
	sw     $8, 32($5)
	sw     $9, 36($5)
	sw     $10, 40($5)
	sw     $11, 44($5)
	sw     $12, 48($5)
	sw     $13, 52($5)
	sw     $14, 56($5)
	sw     $15, 60($5)
	addiu  $6, $6, -64
	addiu  $4, $4, 64
	bgez   $6, .L800E6300
	addiu  $5, $5, 64
.L800E6390:
	addiu  $6, $6, 48
	bltz   $6, .L800E63CC
	nop
.L800E639C:
	lw     $8, 0($4)
	lw     $9, 4($4)
	lw     $10, 8($4)
	lw     $11, 12($4)
	sw     $8, 0($5)
	sw     $9, 4($5)
	sw     $10, 8($5)
	sw     $11, 12($5)
	addiu  $6, $6, -16
	addiu  $4, $4, 16
	bgez   $6, .L800E639C
	addiu  $5, $5, 16
.L800E63CC:
	addiu  $6, $6, 12
	bltz   $6, .L800E63F0
	nop
.L800E63D8:
	lw     $8, 0($4)
	addiu  $6, $6, -4
	sw     $8, 0($5)
	addiu  $4, $4, 4
	bgez   $6, .L800E63D8
	addiu  $5, $5, 4
.L800E63F0:
	addiu  $6, $6, 3
	bltz   $6, .L800E6414
	nop
.L800E63FC:
	lb     $8, 0($4)
	addiu  $6, $6, -1
	sb     $8, 0($5)
	addiu  $4, $4, 1
	bgez   $6, .L800E63FC
	addiu  $5, $5, 1
.L800E6414:
	jr     $31
	nop
.L800E641C:
	addiu  $6, $6, -16
	bltz   $6, .L800E6478
	nop
.L800E6428:
	lwl    $8, 3($4)
	lwr    $8, 0($4)
	lwl    $9, 7($4)
	lwr    $9, 4($4)
	lwl    $10, 11($4)
	lwr    $10, 8($4)
	lwl    $11, 15($4)
	lwr    $11, 12($4)
	swl    $8, 3($5)
	swr    $8, 0($5)
	swl    $9, 7($5)
	swr    $9, 4($5)
	swl    $10, 11($5)
	swr    $10, 8($5)
	swl    $11, 15($5)
	swr    $11, 12($5)
	addiu  $6, $6, -16
	addiu  $4, $4, 16
	bgez   $6, .L800E6428
	addiu  $5, $5, 16
.L800E6478:
	addiu  $6, $6, 12
	bltz   $6, .L800E64A4
	nop
.L800E6484:
	lwl    $8, 3($4)
	lwr    $8, 0($4)
	addiu  $6, $6, -4
	swl    $8, 3($5)
	swr    $8, 0($5)
	addiu  $4, $4, 4
	bgez   $6, .L800E6484
	addiu  $5, $5, 4
.L800E64A4:
	addiu  $6, $6, 3
	bltz   $6, .L800E64C8
	nop
.L800E64B0:
	lb     $8, 0($4)
	addiu  $6, $6, -1
	sb     $8, 0($5)
	addiu  $4, $4, 1
	bgez   $6, .L800E64B0
	addiu  $5, $5, 1
.L800E64C8:
	jr     $31
	nop
.L800E64D0:
	add    $7, $4, $6
	slt    $1, $5, $7
	beqz   $1, .L800E62E4
	nop
	add    $4, $4, $6
	add    $5, $5, $6
	or     $2, $4, $5
	andi   $2, $2, 3
	bnez   $2, .L800E6548
	nop
	addiu  $6, $6, -16
	bltz   $6, .L800E6534
	nop
.L800E6504:
	lw     $8, -16($4)
	lw     $9, -12($4)
	lw     $10, -8($4)
	lw     $11, -4($4)
	sw     $8, -16($5)
	sw     $9, -12($5)
	sw     $10, -8($5)
	sw     $11, -4($5)
	addiu  $4, $4, -16
	addiu  $6, $6, -16
	bgez   $6, .L800E6504
	addiu  $5, $5, -16
.L800E6534:
	addiu  $6, $6, 12
	bltz   $6, .L800E65D0
	nop
	j      .L800E65B0
	nop
.L800E6548:
	addiu  $6, $6, -16
	bltz   $6, .L800E65A4
	nop
.L800E6554:
	lwl    $8, -13($4)
	lwr    $8, -16($4)
	lwl    $9, -9($4)
	lwr    $9, -12($4)
	lwl    $10, -5($4)
	lwr    $10, -8($4)
	lwl    $11, -1($4)
	lwr    $11, -4($4)
	swl    $8, -13($5)
	swr    $8, -16($5)
	swl    $9, -9($5)
	swr    $9, -12($5)
	swl    $10, -5($5)
	swr    $10, -8($5)
	swl    $11, -1($5)
	swr    $11, -4($5)
	addiu  $6, $6, -16
	addiu  $4, $4, -16
	bgez   $6, .L800E6554
	addiu  $5, $5, -16
.L800E65A4:
	addiu  $6, $6, 12
	bltz   $6, .L800E65D0
	nop
.L800E65B0:
	lwl    $8, -1($4)
	lwr    $8, -4($4)
	addiu  $6, $6, -4
	swl    $8, -1($5)
	swr    $8, -4($5)
	addiu  $4, $4, -4
	bgez   $6, .L800E65B0
	addiu  $5, $5, -4
.L800E65D0:
	addiu  $6, $6, 3
	bltz   $6, .L800E65F0
.L800E65D8:
	addiu  $6, $6, -1
	lb     $8, -1($4)
	addiu  $4, $4, -1
	sb     $8, -1($5)
	bgez   $6, .L800E65D8
	addiu  $5, $5, -1
.L800E65F0:
	jr     $31
	nop
	.set at
	.set reorder


	.text
