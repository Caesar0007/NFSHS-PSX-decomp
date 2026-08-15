	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fixdsqrt.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl fixedsqrt
fixedsqrt:
	beqz	$4,.L800EB0F8
	 lui	$9,0x8000
	lui	$8,%hi(D_8012356C)
	addiu	$8,$8,%lo(D_8012356C)
.L800EB0BC:
	and	$10,$4,$9
	addiu	$8,$8,-4
	beqz	$10,.L800EB0BC
	 srl	$9,$9,1
	lw	$11,0($8)
	lw	$12,132($8)
	.word	0x008B0018
	nop
	mflo	$8
	mfhi	$9
	srl	$8,$8,16
	sll	$9,$9,16
	or	$2,$8,$9
	jr	$31
	 addu	$2,$2,$12
.L800EB0F8:
	jr	$31
	 addu	$2,$0,$0
	.set at
	.set reorder


	.text
