	.comm	commonVar,40
	.lcomm	localCommonVar,40

	lw	$4,commonVar+8
	lw	$6,localCommonVar+4
