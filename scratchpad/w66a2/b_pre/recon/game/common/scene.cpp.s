	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\scene.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Scene_Init__Fi
	.align	2
	.globl	Scene_DeInit__Fv
	.align	2
	.globl	Scene_PurgeScene__Fv
	.align	2
	.globl	Scene_BuildCustomSceneList__Fv
	.rdata
	.align	2
$LC0:
	.ascii	"%sscene.viv\000"
	.align	2
$LC1:
	.ascii	"tr%02d%02d.scn\000"
	.text
	.align	2
	.globl	Scene_LoadSceneFile__Fi
	.align	2
	.globl	GetPlaneY__FPC8coorddefN20
	.globl	gGameSceneList
	.sdata
	.align	2
gGameSceneList:
	.space	4

	.extern	GameSetup_gData, 2600
	.extern	Object_customSliceNum, 4

	.text
	.text
	.ent	Scene_Init__Fi
Scene_Init__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	blez	$4,$L602
	sw	$0,gGameSceneList
$L602:
	j	$31
	.end	Scene_Init__Fi
	.text
	.ent	Scene_DeInit__Fv
Scene_DeInit__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Scene_PurgeScene__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Scene_DeInit__Fv
	.text
	.ent	Scene_PurgeScene__Fv
Scene_PurgeScene__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,gGameSceneList
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L605
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
	sw	$0,gGameSceneList
$L605:
	jal	Object_ClearCustomObjects__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Scene_PurgeScene__Fv
	.text
	.ent	Scene_BuildCustomSceneList__Fv
Scene_BuildCustomSceneList__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Object_ClearCustomObjects__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$2,gGameSceneList
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	li	$18,-1			# 0xffffffff
	.set	macro
	.set	reorder

	addu	$17,$2,16
	lw	$18,8($2)
	lw	$2,4($2)
	sw	$18,Object_customSliceNum
	.set	noreorder
	.set	nomacro
	blez	$2,$L607
	move	$16,$0
	.set	macro
	.set	reorder

$L611:
	lw	$3,0($17)
	#nop
	slt	$2,$3,3
	beq	$2,$0,$L610
	.set	noreorder
	.set	nomacro
	bltz	$3,$L610
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Object_AddCustomObject__FP9SceneElemi
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L610:
	lw	$2,gGameSceneList
	#nop
	lw	$2,4($2)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L611
	addu	$17,$17,92
	.set	macro
	.set	reorder

$L607:
	move	$2,$18
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Scene_BuildCustomSceneList__Fv
	.text
	.ent	Scene_LoadSceneFile__Fi
Scene_LoadSceneFile__Fi:
	.frame	$sp,160,$31		# vars= 136, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,160
	sw	$16,152($sp)
	sw	$31,156($sp)
	.set	noreorder
	.set	nomacro
	jal	Object_ClearCustomObjects__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$2,%hi(Paths_Paths+24) # high
	lui	$5,%hi($LC0) # high
	lw	$6,%lo(Paths_Paths+24)($2)
	addiu	$5,$5,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$0,144($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	li	$5,16			# 0x00000010
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_addbigsync
	addu	$7,$sp,144
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC1) # high
	addiu	$5,$5,%lo($LC1) # low
	lui	$2,%hi(GameSetup_gData+60) # high
	lw	$6,%lo(GameSetup_gData+60)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	sw	$0,gGameSceneList
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$4,144($sp)
	sw	$2,gGameSceneList
	.set	noreorder
	.set	nomacro
	jal	FILE_delbigsync
	li	$5,100			# 0x00000064
	.set	macro
	.set	reorder

	lw	$31,156($sp)
	lw	$16,152($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,160
	.set	macro
	.set	reorder

	.end	Scene_LoadSceneFile__Fi
	.text
	.ent	GetPlaneY__FPC8coorddefN20
GetPlaneY__FPC8coorddefN20:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	lw	$4,0($18)
	lw	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$19,$6
	.set	macro
	.set	reorder

	lw	$4,4($18)
	lw	$5,4($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,8($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$17,$17,$16
	addu	$17,$17,$2
	lw	$4,0($18)
	lw	$5,0($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$17,$0,$17
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,8($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$2
	addu	$16,$16,$17
	lw	$5,4($18)
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	subu	$4,$0,$16
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	GetPlaneY__FPC8coorddefN20
