	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\platform.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Platform_InitMemory__Fv
	.align	2
	.globl	Platform_ReserveMemory__FiPc
	.align	2
	.globl	Platform_TempReserveMemory__FiPc
	.align	2
	.globl	Platform_SysStartUp__Fv
	.align	2
	.globl	Platform_DebuggerPollHost__Fv
	.align	2
	.globl	nfs2eacinit__Fv
	.align	2
	.globl	Platform_ResetDCTBuffer__Fv
	.align	2
	.globl	Platform_GetDCTBuffer__FiPc
	.globl	gTotalMemory
	.sdata
	.align	2
gTotalMemory:
	.space	4
	.globl	gLowMemory
	.align	2
gLowMemory:
	.space	4
	.globl	gHighMemory
	.align	2
gHighMemory:
	.space	4
	.globl	gCurrentMemory
	.align	2
gCurrentMemory:
	.space	4
	.globl	gSysStartUp
	.align	2
gSysStartUp:
	.space	4
	.globl	gDctXtraMem
	.align	2
gDctXtraMem:
	.space	4
	.globl	gPlatformInitMem
	.data
	.align	2
gPlatformInitMem:
	.space	64
	.globl	gEAMemPoolBase
	.align	2
gEAMemPoolBase:
	.space	64
	.globl	gDctBuffer
	.align	2
gDctBuffer:
	.space	64

	.extern	nfs_sysInfo, 4
	.extern	disablecd, 4

	.text
	.text
	.ent	Platform_InitMemory__Fv
Platform_InitMemory__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,-2147418112			# 0x80010000
	ori	$3,$3,0x0080
	lui	$2,%hi(gPlatformInitMem) # high
	addiu	$2,$2,%lo(gPlatformInitMem) # low
	subu	$2,$2,$3
	sw	$2,gTotalMemory
	addu	$2,$2,$3
	sw	$3,gLowMemory
	sw	$2,gHighMemory
	sw	$3,gCurrentMemory
	j	$31
	.end	Platform_InitMemory__Fv
	.text
	.ent	Platform_ReserveMemory__FiPc
Platform_ReserveMemory__FiPc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$2,$4,3
	.set	noreorder
	.set	nomacro
	bgez	$2,$L602
	move	$3,$2
	.set	macro
	.set	reorder

	addu	$3,$2,3
$L602:
	sra	$2,$3,2
	lw	$5,gCurrentMemory
	sll	$2,$2,2
	addu	$4,$5,$2
	lw	$2,gLowMemory
	lw	$3,gTotalMemory
	subu	$2,$4,$2
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L603
	move	$2,$5
	.set	macro
	.set	reorder

	sw	$4,gCurrentMemory
	j	$31
$L603:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	Platform_ReserveMemory__FiPc
	.text
	.ent	Platform_TempReserveMemory__FiPc
Platform_TempReserveMemory__FiPc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$4,$4,3
	.set	noreorder
	.set	nomacro
	bgez	$4,$L606
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$2,$4,3
$L606:
	sra	$2,$2,2
	sll	$4,$2,2
	lw	$6,gCurrentMemory
	lw	$5,gLowMemory
	lw	$3,gTotalMemory
	addu	$4,$6,$4
	subu	$4,$4,$5
	slt	$3,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L609
	move	$2,$0
	.set	macro
	.set	reorder

	move	$2,$6
$L609:
	j	$31
	.end	Platform_TempReserveMemory__FiPc
	.text
	.ent	Platform_SysStartUp__Fv
Platform_SysStartUp__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	li	$5,-2145452032			# 0x801f0000
	ori	$5,$5,0xc000
	lui	$4,%hi(gEAMemPoolBase) # high
	addiu	$4,$4,%lo(gEAMemPoolBase) # low
	subu	$5,$5,$4
	sw	$31,36($sp)
	sw	$16,32($sp)
	sw	$0,disablecd
	sw	$5,nfs_sysInfo
	jal	initmemadr
	jal	nfs2eacinit__Fv
	li	$4,512			# 0x00000200
	li	$5,240			# 0x000000f0
	li	$6,1			# 0x00000001
	move	$16,$6
	move	$7,$0
	sw	$16,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_SetEnvironment__Fiiiiiiii
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	initlinkmode
	move	$6,$5
	.set	macro
	.set	reorder

	lui	$4,%hi(D_8013DAA0) # high
	.set	noreorder
	.set	nomacro
	jal	setdirectory
	addiu	$4,$4,%lo(D_8013DAA0) # low
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,1000			# 0x000003e8
	.set	noreorder
	.set	nomacro
	jal	initlinkmode
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,1000			# 0x000003e8
	.set	noreorder
	.set	nomacro
	jal	initlinkmode
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$16,gSysStartUp
	.set	noreorder
	.set	nomacro
	jal	inittimer
	li	$4,128			# 0x00000080
	.set	macro
	.set	reorder

	jal	Paths_StartUp__Fv
	li	$4,30			# 0x0000001e
	li	$5,8192			# 0x00002000
	.set	noreorder
	.set	nomacro
	jal	initasync
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Platform_SysStartUp__Fv
	.text
	.ent	Platform_DebuggerPollHost__Fv
Platform_DebuggerPollHost__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Platform_DebuggerPollHost__Fv
	.text
	.ent	nfs2eacinit__Fv
nfs2eacinit__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	FlushCache
	jal	ResetCallback
	.set	noreorder
	.set	nomacro
	jal	ResetGraph
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	initjoy
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$4,10			# 0x0000000a
	li	$5,800			# 0x00000320
	.set	noreorder
	.set	nomacro
	jal	FILE_init
	li	$6,48			# 0x00000030
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	nfs2eacinit__Fv
	.text
	.ent	Platform_ResetDCTBuffer__Fv
Platform_ResetDCTBuffer__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gDctBuffer) # high
	addiu	$2,$2,%lo(gDctBuffer) # low
	sw	$2,gDctXtraMem
	j	$31
	.end	Platform_ResetDCTBuffer__Fv
	.text
	.ent	Platform_GetDCTBuffer__FiPc
Platform_GetDCTBuffer__FiPc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,gDctXtraMem
	#nop
	addu	$4,$2,$4
	sw	$4,gDctXtraMem
	j	$31
	.end	Platform_GetDCTBuffer__FiPc
