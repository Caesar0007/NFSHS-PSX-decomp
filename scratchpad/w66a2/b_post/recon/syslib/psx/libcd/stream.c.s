	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\stream.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	StFunc1
	.globl	StFunc2
	.globl	StEmu_Addr
	.globl	StCdIntrFlag
	.globl	CChannel
	.globl	StCHANNEL
	.globl	Stframe_no
	.globl	StRgb24
	.globl	StEndFrame
	.globl	StSTART_FLAG
	.globl	StEmu_Idx
	.globl	Stsector_offset
	.globl	StFinalSector
	.globl	StRingBase
	.globl	StRingAddr
	.globl	StRingIdx1
	.globl	StRingIdx2
	.globl	StRingIdx3
	.globl	StRingSize
	.globl	StStartFrame
	.globl	StMode
	.section	.bss
	.align	2
StFunc1:
	.space	4
StFunc2:
	.space	4
StEmu_Addr:
	.space	4
StCdIntrFlag:
	.space	4
CChannel:
	.space	4
StCHANNEL:
	.space	4
Stframe_no:
	.space	4
StRgb24:
	.space	4
StEndFrame:
	.space	4
StSTART_FLAG:
	.space	4
StEmu_Idx:
	.space	4
Stsector_offset:
	.space	4
StFinalSector:
	.space	4
StRingBase:
	.space	4
StRingAddr:
	.space	4
StRingIdx1:
	.space	4
StRingIdx2:
	.space	4
StRingIdx3:
	.space	4
StRingSize:
	.space	4
StStartFrame:
	.space	4
StMode:
	.space	4
	.text
 #NO_APP
	.text
	.align	2
	.globl	StClearRing
	.ent	StClearRing
StClearRing:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lw	$5,StRingSize
	sw	$31,16($sp)
	sw	$0,StRingIdx3
	sw	$0,StRingIdx2
	sw	$0,StRingIdx1
	sw	$0,StFinalSector
	.set	noreorder
	.set	nomacro
	jal	init_ring_status
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	sw	$0,StCdIntrFlag
	sh	$0,Stsector_offset
	sw	$0,Stframe_no
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	StClearRing
	.align	2
	.globl	StSetStream
	.ent	StSetStream
StSetStream:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	addu	$16,$4,$0
	sw	$17,20($sp)
	addu	$17,$7,$0
	sw	$18,24($sp)
	lw	$18,48($sp)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	StSetMask
	li	$4,0x00000001		# 1
	.set	macro
	.set	reorder

	andi	$16,$16,0x0001
	sw	$0,StEmu_Addr
	sw	$17,StFunc1
	sw	$16,StRgb24
	sw	$0,CChannel
	sw	$0,StCHANNEL
	sh	$0,Stsector_offset
	sw	$0,Stframe_no
	sw	$18,StFunc2
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	StSetStream
	.align	2
	.globl	StSetRing
	.ent	StSetRing
StSetRing:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	sw	$4,StRingAddr
	sw	$5,StRingSize
	jal	StClearRing
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	StSetRing
