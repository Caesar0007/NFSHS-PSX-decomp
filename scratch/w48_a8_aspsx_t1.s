	.text
	.align	2
	.globl	DsReadyCallback
	.comm	ds_ready_cb,4
	.ent	DsReadyCallback
DsReadyCallback:
	lw	$2,ds_ready_cb
	sw	$4,ds_ready_cb
	j	$31
	.end	DsReadyCallback
