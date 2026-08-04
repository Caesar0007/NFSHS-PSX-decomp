	.text
	.set reorder
	.globl	StSetMask
StSetMask:
	sw	$4,StSTART_FLAG
	sw	$5,StStartFrame
	sw	$6,StEndFrame
	j	$31
	.comm	StSTART_FLAG,4
	.comm	StStartFrame,4
	.comm	StEndFrame,4
