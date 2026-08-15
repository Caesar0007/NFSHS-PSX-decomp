	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\threads.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iscurrentthread
	.align	2
	.globl	yieldthread

	.comm	g_currentthread,4


	.text
	.def	iscurrentthread;	.val	iscurrentthread;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iscurrentthread
iscurrentthread:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	lw	$2,g_currentthread
	#nop
	xor	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$2,1
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iscurrentthread
	.def	yieldthread;	.val	yieldthread;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	yieldthread
yieldthread:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31

	.loc	1 0
LM2:
	.end	yieldthread
	.def	g_currentthread;	.val	g_currentthread;	.scl	2;	.type	0x4;	.endef
