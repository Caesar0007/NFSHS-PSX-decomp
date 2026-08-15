	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\random.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl random
random:
	lui	$4,%hi(seed)
	addiu	$4,$4,%lo(seed)
	lw	$13,20($4)
	lw	$12,16($4)
	lw	$11,12($4)
	lw	$10,8($4)
	lw	$9,4($4)
	lw	$8,0($4)
	addu	$12,$12,$13
	sltu	$5,$12,$13
	addu	$11,$11,$12
	sltu	$6,$11,$12
	addu	$11,$11,$5
	sltu	$5,$11,$5
	addu	$5,$5,$6
	addu	$10,$10,$11
	sltu	$6,$10,$11
	addu	$10,$10,$5
	sltu	$5,$10,$5
	addu	$5,$5,$6
	addu	$9,$9,$10
	sltu	$6,$9,$10
	addu	$9,$9,$5
	sltu	$5,$9,$5
	addu	$5,$5,$6
	addu	$8,$8,$9
	sltu	$6,$8,$9
	addu	$8,$8,$5
	addiu	$13,$13,0x1
	bnez	$13,.L800E7858
	 nop
	addiu	$12,$12,0x1
	bnez	$12,.L800E7858
	 nop
	addiu	$11,$11,0x1
	bnez	$11,.L800E7858
	 nop
	addiu	$10,$10,0x1
	bnez	$10,.L800E7858
	 nop
	addiu	$9,$9,0x1
	bnez	$9,.L800E7858
	 nop
	addiu	$8,$8,0x1
.L800E7858:
	sw	$13,20($4)
	sw	$12,16($4)
	sw	$11,12($4)
	sw	$10,8($4)
	sw	$9,4($4)
	sw	$8,0($4)
	jr	$31
	 addu	$2,$8,$0
	.globl seedrandom
seedrandom:
	lui	$5,%hi(seed)
	addiu	$5,$5,%lo(seed)
	lui	$1,0xf22d
	ori	$1,$1,0xe56
	addu	$4,$4,$1
	sw	$4,0($5)
	lui	$1,0x9604
	ori	$1,$1,0x1893
	addu	$4,$4,$1
	sw	$4,4($5)
	lui	$1,0x3df3
	ori	$1,$1,0xb646
	addu	$4,$4,$1
	sw	$4,8($5)
	lui	$1,0x40dd
	ori	$1,$1,0xe76d
	addu	$4,$4,$1
	sw	$4,12($5)
	lui	$1,0x9732
	ori	$1,$1,0x7ae1
	addu	$4,$4,$1
	sw	$4,16($5)
	lui	$1,0xd1a9
	ori	$1,$1,0xfbe7
	addu	$4,$4,$1
	sw	$4,20($5)
	jr	$31
	 nop
	.set at
	.set reorder


	.text
