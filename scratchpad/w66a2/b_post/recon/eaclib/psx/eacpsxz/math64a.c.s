	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\math64a.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl make64
make64:
	slti	$8,$6,32
	bnez	$8,.L800FE4A8
	 addi	$9,$6,-32
	sllv	$14,$5,$9
	sw	$0,0($4)
	sw	$14,4($4)
	jr	$31
	 nop
.L800FE4A8:
	blez	$6,.L800FE4CC
	 addiu	$11,$0,32
	sub	$10,$11,$6
	sllv	$13,$5,$6
	srav	$14,$5,$10
	sw	$13,0($4)
	sw	$14,4($4)
	jr	$31
	 nop
.L800FE4CC:
	sw	$5,0($4)
	sra	$14,$5,31
	sw	$14,4($4)
	jr	$31
	 nop
	.globl divu64
divu64:
	addiu	$2,$0,0
	addiu	$9,$0,32
	addiu	$9,$9,-1
.L800FE4EC:
	sll	$2,$2,1
	sll	$5,$5,1
	srl	$10,$4,31
	addu	$5,$5,$10
	sltu	$11,$5,$6
	bnez	$11,.L800FE510
	 sll	$4,$4,1
	subu	$5,$5,$6
	addiu	$2,$2,1
.L800FE510:
	bnez	$9,.L800FE4EC
	 addiu	$9,$9,-1
	jr	$31
	 nop
	.set at
	.set reorder


	.text
