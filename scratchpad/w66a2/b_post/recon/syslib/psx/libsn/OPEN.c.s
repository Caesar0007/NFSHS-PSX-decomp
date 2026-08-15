	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libsn\\OPEN.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noreorder
	.globl PCopen
PCopen:
	addu  $a2, $a1, $zero
	addu  $a1, $a0, $zero
	break 0x103
	beqz  $v0, 1f
	 addu $v0, $v1, $zero
	addiu $v0, $zero, -1
1:	jr   $ra
	 nop
	.set pop


	.text
