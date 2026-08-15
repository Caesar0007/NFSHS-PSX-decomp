	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libsn\\SNWRITE.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noreorder
	.globl _SN_write
_SN_write:
	break 0x106
	beqz  $v0, 1f
	 addu $v0, $v1, $zero
	addiu $v0, $zero, -1
1:	jr   $ra
	 nop
	.set pop


	.text
