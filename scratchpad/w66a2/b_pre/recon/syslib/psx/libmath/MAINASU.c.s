	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\MAINASU.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noat
	.set	noreorder
	.set noreorder
	.globl _mainasu
_mainasu:
	addiu	$sp,$sp,-40
	sw	$s0,32($sp)
	addu	$s0,$a0,$zero
	addiu	$v0,$zero,1
	sw	$a2,48($sp)
	nor	$a2,$zero,$a2
	sw	$a1,44($sp)
	nor	$a1,$zero,$a1
	sw	$zero,28($sp)
	sw	$v0,24($sp)
	sw	$a2,48($sp)
	sw	$a1,44($sp)
	sw	$zero,16($sp)
	lw	$a3,24($sp)
	lw	$a1,44($sp)
	lw	$a2,48($sp)
	sw	$ra,36($sp)
	jal	_add_mant_d
	 addiu	$a0,$sp,44
	lw	$v0,44($sp)
	lw	$v1,48($sp)
	sw	$v0,0($s0)
	sw	$v1,4($s0)
	addu	$v0,$s0,$zero
	lw	$ra,36($sp)
	lw	$s0,32($sp)
	jr	$ra
	 addiu	$sp,$sp,40
	.set pop


	.text
