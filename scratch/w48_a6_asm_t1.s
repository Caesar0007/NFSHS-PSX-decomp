	.text
	.align	2
	.globl	StSetMask
	.ent	StSetMask
StSetMask:
	.frame	$sp,0,$31
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$4,StSTART_FLAG
	sw	$5,StStartFrame
	sw	$6,StEndFrame
	j	$31
	.end	StSetMask
	.comm	StSTART_FLAG,4
	.comm	StStartFrame,4
	.comm	StEndFrame,4
