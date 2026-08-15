	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libapi\\COUNTER_data.c"
gcc2_compiled.:
__gnu_compiled_c:
	.globl	RCnt_regs
	.sdata
	.align	2
RCnt_regs:
	.word	528486656
	.globl	RCnt_ctrl
	.align	2
RCnt_ctrl:
	.word	528486512
	.globl	RCnt_irq
	.data
	.align	2
RCnt_irq:
	.word	16
	.word	32
	.word	64
	.word	1
	.word	0
	.word	0
	.text

	.text
	.def	RCnt_regs;	.val	RCnt_regs;	.scl	2;	.type	0x1c;	.endef
	.def	RCnt_ctrl;	.val	RCnt_ctrl;	.scl	2;	.type	0x1c;	.endef
	.def	RCnt_irq;	.val	RCnt_irq;	.scl	2;	.dim	6;	.size	24;	.type	0x3f;	.endef
