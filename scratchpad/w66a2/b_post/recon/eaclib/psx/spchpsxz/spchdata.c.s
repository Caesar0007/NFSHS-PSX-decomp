	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\spchpsxz\\spchdata.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSPCH_GetMatchValue
	.align	2
	.globl	VoxSentence_GetShortRule
	.align	2
	.globl	VoxSentence_GetNumPhrases
	.align	2
	.globl	VoxEvent_GetFilterLengthFlag
	.align	2
	.globl	iSPCH_GetOffset8
	.align	2
	.globl	iSPCH_GetOffset16

	.text
	.def	iSPCH_GetMatchValue;	.val	iSPCH_GetMatchValue;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_GetMatchValue
iSPCH_GetMatchValue:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	base;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	index;	.val	5;	.scl	17;	.type	0x4;	.endef
	sll	$5,$5,2
	addu	$4,$4,$5
	lw	$2,8($4)
	j	$31

	.loc	1 0
LM1:
	.end	iSPCH_GetMatchValue
	.def	VoxSentence_GetShortRule;	.val	VoxSentence_GetShortRule;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	VoxSentence_GetShortRule
VoxSentence_GetShortRule:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	sentence;	.val	4;	.scl	17;	.type	0x4;	.endef
	lbu	$2,3($4)
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$2,0x0003
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	VoxSentence_GetShortRule
	.def	VoxSentence_GetNumPhrases;	.val	VoxSentence_GetNumPhrases;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	VoxSentence_GetNumPhrases
VoxSentence_GetNumPhrases:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	sentence;	.val	4;	.scl	17;	.type	0x4;	.endef
	lbu	$2,3($4)
	.set	noreorder
	.set	nomacro
	j	$31
	srl	$2,$2,2
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	VoxSentence_GetNumPhrases
	.def	VoxEvent_GetFilterLengthFlag;	.val	VoxEvent_GetFilterLengthFlag;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	VoxEvent_GetFilterLengthFlag
VoxEvent_GetFilterLengthFlag:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	event;	.val	4;	.scl	17;	.type	0x4;	.endef
	lbu	$2,10($4)
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$2,0x0001
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	VoxEvent_GetFilterLengthFlag
	.def	iSPCH_GetOffset8;	.val	iSPCH_GetOffset8;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_GetOffset8
iSPCH_GetOffset8:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	base;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	tableBase;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	index;	.val	6;	.scl	17;	.type	0x4;	.endef
	addu	$5,$5,$6
	lbu	$2,0($5)
	#nop
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	iSPCH_GetOffset8
	.def	iSPCH_GetOffset16;	.val	iSPCH_GetOffset16;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_GetOffset16
iSPCH_GetOffset16:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	base;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	tableBase;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	index;	.val	6;	.scl	17;	.type	0x4;	.endef
	sll	$6,$6,1
	addu	$6,$6,$5
	lhu	$2,0($6)
	#nop
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	iSPCH_GetOffset16
