	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\shpsubs.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl shapecount
shapecount:
	lw	$2,8($4)
	jr	$31
	 nop
	.globl shapepointer
shapepointer:
	lw	$8,8($4)
	sll	$10,$5,3
	sltu	$1,$5,$8
	beqz	$1,.L800F0AD8
	 addu	$10,$4,$10
	lw	$2,20($10)
	jr	$31
	 addu	$2,$4,$2
.L800F0AD8:
	jr	$31
	 addiu	$2,$0,0
	.globl shapename
shapename:
	lw	$8,8($4)
	sll	$10,$5,3
	sltu	$1,$5,$8
	beqz	$1,.L800F0B08
	 addu	$10,$4,$10
	lw	$2,16($10)
	nop
	swr	$2,0($6)
	swl	$2,3($6)
	jr	$31
.L800F0B08:
	 addiu	$2,$0,0
	swr	$2,0($6)
	swl	$2,3($6)
	jr	$31
	 nop
	.set at
	.set reorder


	.text
