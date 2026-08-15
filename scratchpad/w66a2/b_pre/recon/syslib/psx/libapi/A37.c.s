	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libapi\\A37.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	ExitCriticalSection

	.text
	.def	ExitCriticalSection;	.val	ExitCriticalSection;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	ExitCriticalSection
ExitCriticalSection:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
 #APP
	addiu $a0, $zero, 0x2
	syscall 0
 #NO_APP
	j	$31

	.loc	1 0
LM1:
	.end	ExitCriticalSection
