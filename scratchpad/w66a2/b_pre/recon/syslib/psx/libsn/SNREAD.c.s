	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libsn\\SNREAD.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noreorder
	.globl _SN_read
_SN_read:
	break 0x105
	beqz  $v0, 1f
	 addu $v0, $v1, $zero
	addiu $v0, $zero, -1
1:	jr   $ra
	 nop
	.set pop


	.text
