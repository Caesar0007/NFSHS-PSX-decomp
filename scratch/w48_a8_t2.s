	.text
	.align	2
	.globl	DsReadyCallback
	.section .bss
	.align	2
ds_ready_cb:
	.space	4
	.text
DsReadyCallback:
	lw	$2,ds_ready_cb
	sw	$4,ds_ready_cb
	j	$31
