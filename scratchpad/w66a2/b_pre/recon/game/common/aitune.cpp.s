	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aitune.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	AITune_BTC
	.data
	.align	2
AITune_BTC:
	.word	98304
	.word	55705
	.word	65536
	.word	5760
	.word	64
	.word	1920
	.word	5760
	.word	65536
	.word	65536
	.word	65536
	.word	3840
	.word	2880
	.word	5760
	.word	8320
	.word	52428
	.word	72089
	.word	65536
	.word	2880
	.word	3840
	.word	7680
	.word	9600
	.globl	AITune_BTCPerpAccMults
	.align	2
AITune_BTCPerpAccMults:
	.word	49152
	.word	55705
	.word	65536
	.globl	AITune_trackInfo
	.align	2
AITune_trackInfo:
	.word	0
	.word	1
	.word	170
	.word	0
	.word	1
	.word	130
	.word	0
	.word	1
	.word	135
	.word	0
	.word	1
	.word	120
	.word	0
	.word	1
	.word	118
	.word	0
	.word	-1
	.word	130
	.word	0
	.word	1
	.word	145
	.word	0
	.word	-1
	.word	110
	.word	0
	.word	1
	.word	121
	.word	0
	.word	1
	.word	140
	.word	0
	.word	1
	.word	145
	.word	0
	.word	1
	.word	90
	.globl	AITune_accelerationScale
	.align	2
AITune_accelerationScale:
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.word	65536
	.globl	copTuningInfo
	.align	2
copTuningInfo:
	.word	65536
	.word	78643
	.word	6407964
	.word	6407964
	.word	65536
	.word	78643
	.word	6407964
	.word	6407964
	.word	65536
	.word	78643
	.word	6407964
	.word	6407964
	.word	65536
	.word	78643
	.word	6407964
	.word	6407964
	.word	65536
	.word	78643
	.word	6407964
	.word	6407964
	.word	65536
	.word	78643
	.word	6407964
	.word	6407964
	.globl	AITune_MaxTraffic
	.align	2
AITune_MaxTraffic:
	.word	5
	.word	5
	.word	5
	.word	5
	.word	1
	.word	1
	.word	1
	.word	1
	.globl	AITune_LifeTimer
	.align	2
AITune_LifeTimer:
	.word	25
	.word	50
	.word	75
	.word	100
	.word	200
	.word	400
	.word	500
	.word	800
	.word	900
	.word	1000
	.word	1100
	.word	1200
	.text
	.align	2
	.globl	AITune_GetOneWay__Fv
	.align	2
	.globl	AITune_GetDriveSide__Fv
	.align	2
	.globl	AITune_GetRoughLapTimes__Fv
	.align	2
	.globl	AITune_StartUp1__Fv
	.align	2
	.globl	AITune_StartUp2__Fv
	.align	2
	.globl	AITune_CleanUp1__Fv
	.align	2
	.globl	AITune_CleanUp2__Fv
	.globl	AITune_oneWay
	.sdata
	.align	2
AITune_oneWay:
	.space	4
	.globl	AITune_driveSide
	.align	2
AITune_driveSide:
	.space	4
	.globl	AITune_gRoughLapTime
	.align	2
AITune_gRoughLapTime:
	.space	4

	.extern	BWorldSm_slices, 4
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	AITune_GetOneWay__Fv
AITune_GetOneWay__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+60) # high
	lw	$4,%lo(GameSetup_gData+60)($2)
	#nop
	slt	$2,$4,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L601
	lui	$3,%hi(AITune_trackInfo) # high
	.set	macro
	.set	reorder

	lw	$2,BWorldSm_slices
	#nop
	lbu	$2,61($2)
	#nop
	srl	$2,$2,4
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$2,1
	.set	macro
	.set	reorder

$L601:
	addiu	$3,$3,%lo(AITune_trackInfo) # low
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	j	$31
	.end	AITune_GetOneWay__Fv
	.text
	.ent	AITune_GetDriveSide__Fv
AITune_GetDriveSide__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+60) # high
	lw	$4,%lo(GameSetup_gData+60)($2)
	#nop
	slt	$2,$4,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L604
	lui	$3,%hi(AITune_trackInfo) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L604:
	addiu	$3,$3,%lo(AITune_trackInfo) # low
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,4($2)
	j	$31
	.end	AITune_GetDriveSide__Fv
	.text
	.ent	AITune_GetRoughLapTimes__Fv
AITune_GetRoughLapTimes__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+60) # high
	lw	$4,%lo(GameSetup_gData+60)($2)
	#nop
	slt	$2,$4,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L607
	lui	$3,%hi(AITune_trackInfo) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,190			# 0x000000be
	.set	macro
	.set	reorder

$L607:
	addiu	$3,$3,%lo(AITune_trackInfo) # low
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,8($2)
	j	$31
	.end	AITune_GetRoughLapTimes__Fv
	.text
	.ent	AITune_StartUp1__Fv
AITune_StartUp1__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	AITune_GetOneWay__Fv
	sw	$2,AITune_oneWay
	jal	AITune_GetDriveSide__Fv
	sw	$2,AITune_driveSide
	jal	AITune_GetRoughLapTimes__Fv
	lw	$31,16($sp)
	sw	$2,AITune_gRoughLapTime
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AITune_StartUp1__Fv
	.text
	.ent	AITune_StartUp2__Fv
AITune_StartUp2__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AITune_StartUp2__Fv
	.text
	.ent	AITune_CleanUp1__Fv
AITune_CleanUp1__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AITune_CleanUp1__Fv
	.text
	.ent	AITune_CleanUp2__Fv
AITune_CleanUp2__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AITune_CleanUp2__Fv
