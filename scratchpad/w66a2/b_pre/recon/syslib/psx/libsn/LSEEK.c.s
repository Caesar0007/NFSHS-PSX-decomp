	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libsn\\LSEEK.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noreorder
	.globl PClseek
PClseek:
	addu  $a3, $a2, $zero
	addu  $a2, $a1, $zero
	addu  $a1, $a0, $zero
	break 0x107
	beqz  $v0, 1f
	 addu $v0, $v1, $zero
	addiu $v0, $zero, -1
1:	jr   $ra
	 nop
	.set pop


	.text
