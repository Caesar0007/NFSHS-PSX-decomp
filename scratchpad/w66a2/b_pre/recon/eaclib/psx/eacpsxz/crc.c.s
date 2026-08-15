	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\crc.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl crc16
crc16:
	lui	$8,%hi(D_80135C58)
	addiu	$8,$8,%lo(D_80135C58)
	addiu	$3,$0,251
	addiu	$5,$5,-4
	bltz	$5,.L800F61D0
	 addiu	$2,$0,234
.L800F6164:
	lbu	$9,0($4)
	lbu	$10,1($4)
	xor	$9,$9,$2
	addu	$11,$9,$8
	lbu	$12,0($11)
	lbu	$13,256($11)
	xor	$2,$12,$3
	xor	$10,$10,$2
	addu	$11,$10,$8
	lbu	$12,0($11)
	lbu	$3,256($11)
	xor	$2,$12,$13
	lbu	$9,2($4)
	lbu	$10,3($4)
	xor	$9,$9,$2
	addu	$11,$9,$8
	lbu	$12,0($11)
	lbu	$13,256($11)
	xor	$2,$12,$3
	xor	$10,$10,$2
	addu	$11,$10,$8
	lbu	$12,0($11)
	lbu	$3,256($11)
	xor	$2,$12,$13
	addiu	$5,$5,-4
	bgez	$5,.L800F6164
	 addiu	$4,$4,4
.L800F61D0:
	addiu	$5,$5,3
	bltz	$5,.L800F6208
	 nop
.L800F61DC:
	lbu	$9,0($4)
	nop
	xor	$9,$9,$2
	addu	$11,$9,$8
	lbu	$12,0($11)
	lbu	$13,256($11)
	xor	$2,$12,$3
	addu	$3,$13,$0
	addiu	$5,$5,-1
	bgez	$5,.L800F61DC
	 addiu	$4,$4,1
.L800F6208:
	sll	$3,$3,8
	jr	$31
	 or	$2,$2,$3
	.set at
	.set reorder


	.text
