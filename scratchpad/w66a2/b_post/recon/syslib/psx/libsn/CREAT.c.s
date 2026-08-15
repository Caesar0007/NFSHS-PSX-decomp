	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libsn\\CREAT.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noreorder
	.globl PCcreat
PCcreat:
	addu  $a1, $a0, $zero
	addu  $a2, $zero, $zero
	break 0x102
	beqz  $v0, 1f
	 addu $v0, $v1, $zero
	addiu $v0, $zero, -1
1:	jr   $ra
	 nop
	.set pop


	.text
