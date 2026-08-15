	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\clock.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Clock_MasterInterruptHandler__Fv
	.align	2
	.globl	Clock_SystemStartUp__Fv
	.align	2
	.globl	Clock_SystemCleanUp__Fv
	.globl	clock_realTime
	.data
	.align	2
clock_realTime:
	.space	12
	.globl	clock_InterruptStarted
	.sdata
	.align	2
clock_InterruptStarted:
	.space	4
	.globl	stopClock
	.align	2
stopClock:
	.space	4
	.globl	generic128HzClock
	.align	2
generic128HzClock:
	.space	4

	.extern	R3DCar_ClockLast, 4
	.extern	Input_gTime, 4

	.text
	.text
	.ent	Clock_MasterInterruptHandler__Fv
Clock_MasterInterruptHandler__Fv:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	savegp
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$2,stopClock
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L601
	lui	$4,%hi(clock_realTime) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(clock_realTime)($4)
	lw	$2,generic128HzClock
	addu	$3,$3,1
	addu	$2,$2,1
	sw	$3,%lo(clock_realTime)($4)
	addiu	$4,$4,%lo(clock_realTime) # low
	andi	$3,$3,0x0001
	sw	$2,generic128HzClock
 #APP
 #NO_APP
	bne	$3,$0,$L601
	lw	$2,4($4)
	#nop
	addu	$2,$2,1
	sw	$2,4($4)
	andi	$2,$2,0x0001
	bne	$2,$0,$L601
	lw	$2,8($4)
	#nop
	addu	$2,$2,1
	sw	$2,8($4)
	andi	$2,$2,0x0001
	bne	$2,$0,$L604
	jal	Input_Update__Fv
$L604:
	jal	Input_Store__Fv
$L601:
	lw	$4,16($sp)
	jal	restoregp
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Clock_MasterInterruptHandler__Fv
	.text
	.ent	Clock_SystemStartUp__Fv
Clock_SystemStartUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,clock_InterruptStarted
	subu	$sp,$sp,24
	sw	$31,16($sp)
	sw	$0,stopClock
	sw	$0,generic128HzClock
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$4,%hi(Clock_MasterInterruptHandler__Fv) # high
	sw	$2,clock_InterruptStarted
	.set	noreorder
	.set	nomacro
	jal	addtimer
	addiu	$4,$4,%lo(Clock_MasterInterruptHandler__Fv) # low
	.set	macro
	.set	reorder

	lui	$2,%hi(clock_realTime) # high
	sw	$0,%lo(clock_realTime)($2)
	addiu	$2,$2,%lo(clock_realTime) # low
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,Input_gTime
$L606:
	lw	$31,16($sp)
	sw	$0,R3DCar_ClockLast
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Clock_SystemStartUp__Fv
	.text
	.ent	Clock_SystemCleanUp__Fv
Clock_SystemCleanUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,clock_InterruptStarted
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	sw	$0,clock_InterruptStarted
	lui	$4,%hi(Clock_MasterInterruptHandler__Fv) # high
	.set	noreorder
	.set	nomacro
	jal	deltimer
	addiu	$4,$4,%lo(Clock_MasterInterruptHandler__Fv) # low
	.set	macro
	.set	reorder

$L607:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Clock_SystemCleanUp__Fv
