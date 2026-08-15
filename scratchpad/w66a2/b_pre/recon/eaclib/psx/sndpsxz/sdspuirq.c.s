	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sdspuirq.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDpsxenablespuirq
	.align	2
	.globl	iSNDpsxdisablespuirq

	.text
	.def	iSNDpsxenablespuirq;	.val	iSNDpsxenablespuirq;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpsxenablespuirq
iSNDpsxenablespuirq:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(sndpd+1300) # high
	lw	$3,%lo(sndpd+1300)($2)
	#nop
	lhu	$2,426($3)
	#nop
	ori	$2,$2,0x0040
	#.set	volatile
	sh	$2,426($3)
	#.set	novolatile
	j	$31

	.loc	1 0
LM1:
	.end	iSNDpsxenablespuirq
	.def	iSNDpsxdisablespuirq;	.val	iSNDpsxdisablespuirq;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpsxdisablespuirq
iSNDpsxdisablespuirq:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(sndpd+1300) # high
	lw	$3,%lo(sndpd+1300)($2)
	#nop
	lhu	$2,426($3)
	#nop
	andi	$2,$2,0xffbf
	#.set	volatile
	sh	$2,426($3)
	#.set	novolatile
	j	$31

	.loc	1 0
LM2:
	.end	iSNDpsxdisablespuirq
