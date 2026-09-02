	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\stcdint.c"
gcc2_compiled.:
__gnu_compiled_c:
	.section .data,"aw",@progbits
	.align	2
_cd_idx:
	.word	528488448
	.align	2
_cd_reg3:
	.word	528488451
	.align	2
_cd_reg2:
	.word	528488450
	.align	2
_cdrom_delay:
	.word	528486424
	.align	2
_com_delay:
	.word	528486432
	.align	2
_dpcr:
	.word	528486640
	.align	2
_dicr:
	.word	528486644
	.align	2
_d1_chcr:
	.word	528486552
	.align	2
_d3_chcr:
	.word	528486584
 #APP
		.local	_st_slot
	.section	.bss
	.align	2
_st_slot:
	.space	4
	.text
 #NO_APP
	.text
	.align	2
	.globl	StCdInterrupt
	.ent	StCdInterrupt
StCdInterrupt:
	.frame	$sp,72,$31		# vars= 24, regs= 4/0, args= 32, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	lui	$2,%hi(StFinalSector) # high
	lw	$2,%lo(StFinalSector)($2)
	li	$4,1			# 0x00000001
	sw	$31,68($sp)
	sw	$18,64($sp)
	sw	$17,60($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L1
	sw	$16,56($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(StRgb24) # high
	lw	$2,%lo(StRgb24)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L68
	lui	$2,%hi(_d1_chcr) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(_d1_chcr)($2)
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,16777216			# 0x01000000
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L69
	lui	$2,%hi(StEmu_Addr) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(StEmu_Addr)($2)
	lui	$2,%hi(StCdIntrFlag) # high
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L4
	sw	$4,%lo(StCdIntrFlag)($2)
	.set	macro
	.set	reorder

	lui	$3,%hi(StEmu_Idx) # high
	lw	$2,%lo(StEmu_Idx)($3)
	#nop
	addu	$2,$2,$4
	sw	$2,%lo(StEmu_Idx)($3)
$L4:
	lui	$2,%hi(debug_cause) # high
	.set	noreorder
	.set	nomacro
	j	$L1
	sw	$4,%lo(debug_cause)($2)
	.set	macro
	.set	reorder

$L68:
$L69:
	.set	noreorder
	.set	nomacro
	jal	CdReady
	addu	$5,$sp,48
	.set	macro
	.set	reorder

	li	$3,5			# 0x00000005
	beq	$2,$3,$L1
	lbu	$2,48($sp)
	lbu	$3,49($sp)
	#.set	volatile
	sh	$2,34($sp)
	#.set	novolatile
	#.set	volatile
	sh	$3,36($sp)
	#.set	novolatile
	#.set	volatile
	lhu	$2,34($sp)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	lui	$3,%hi(debug_cause) # high
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	j	$L1
	sw	$2,%lo(debug_cause)($3)
	.set	macro
	.set	reorder

$L6:
	lui	$4,%hi(_st_slot) # high
	lui	$3,%hi(StRingAddr) # high
	lui	$2,%hi(StRingIdx1) # high
	lw	$2,%lo(StRingIdx1)($2)
	lw	$3,%lo(StRingAddr)($3)
	sll	$2,$2,5
	addu	$3,$3,$2
	sw	$3,%lo(_st_slot)($4)
	#.set	volatile
	lhu	$2,0($3)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L7
	lui	$2,%hi(StEmu_Addr) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(StEmu_Addr)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	lui	$3,%hi(StEmu_Idx) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(StEmu_Idx)($3)
	#nop
	addu	$2,$2,1
	sw	$2,%lo(StEmu_Idx)($3)
$L8:
	lui	$3,%hi(debug_cause) # high
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	j	$L1
	sw	$2,%lo(debug_cause)($3)
	.set	macro
	.set	reorder

$L7:
	lui	$3,%hi(_cd_idx) # high
	lw	$2,%lo(_cd_idx)($3)
	lui	$4,%hi(_cd_reg3) # high
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$2,%lo(_cd_reg3)($4)
	#nop
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$2,%lo(_cd_idx)($3)
	li	$5,131072			# 0x00020000
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$3,%lo(_cd_reg3)($4)
	li	$2,128			# 0x00000080
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lui	$2,%hi(_cdrom_delay) # high
	lw	$2,%lo(_cdrom_delay)($2)
	ori	$5,$5,0x0943
	#.set	volatile
	sw	$5,0($2)
	#.set	novolatile
	lui	$2,%hi(_com_delay) # high
	lw	$3,%lo(_com_delay)($2)
	li	$2,4899			# 0x00001323
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lui	$2,%hi(StMode) # high
	lw	$2,%lo(StMode)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L9
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$5,$sp,40
	lui	$6,%hi(_cd_reg2) # high
$L13:
	lw	$2,%lo(_cd_reg2)($6)
	addu	$3,$5,$4
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	addu	$4,$4,1
	sb	$2,0($3)
	sltu	$2,$4,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L13
	lui	$2,%hi(_cd_reg2) # high
	.set	macro
	.set	reorder

	move	$4,$0
	lw	$3,%lo(_cd_reg2)($2)
$L18:
	#.set	volatile
	lbu	$2,0($3)
	#.set	novolatile
	addu	$4,$4,1
	sltu	$2,$4,8
	bne	$2,$0,$L18
$L9:
	lui	$2,%hi(StEmu_Addr) # high
	lw	$8,%lo(StEmu_Addr)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L20
	li	$9,285212672			# 0x11000000
	.set	macro
	.set	reorder

	li	$6,8			# 0x00000008
	move	$7,$0
	lui	$3,%hi(_st_slot) # high
	lui	$2,%hi(StEmu_Idx) # high
	lw	$5,%lo(StEmu_Idx)($2)
	lw	$4,%lo(_st_slot)($3)
	sll	$5,$5,11
	.set	noreorder
	.set	nomacro
	jal	_st_copy_words
	addu	$5,$8,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L62
	lui	$2,%hi(_d3_chcr) # high
	.set	macro
	.set	reorder

$L20:
	li	$4,3			# 0x00000003
	move	$6,$0
	lui	$2,%hi(_st_slot) # high
	lw	$5,%lo(_st_slot)($2)
	li	$7,8			# 0x00000008
	sw	$9,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	_st_dma
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(_d3_chcr) # high
$L62:
	lw	$4,%lo(_d3_chcr)($2)
	#nop
	#.set	volatile
	lw	$2,0($4)
	#.set	novolatile
	li	$3,16777216			# 0x01000000
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L23
	move	$3,$4
	.set	macro
	.set	reorder

	li	$4,16777216			# 0x01000000
$L22:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	and	$2,$2,$4
	bne	$2,$0,$L22
$L23:
	li	$4,131072			# 0x00020000
	lui	$2,%hi(_cdrom_delay) # high
	lui	$6,%hi(_st_slot) # high
	ori	$4,$4,0x0843
	lw	$3,%lo(_cdrom_delay)($2)
	lw	$2,%lo(_st_slot)($6)
	lui	$5,%hi(StSTART_FLAG) # high
	lwl	$11,43($sp)
	lwr	$11,40($sp)
	swl	$11,31($2)
	swr	$11,28($2)
	lui	$2,%hi(_com_delay) # high
	#.set	volatile
	sw	$4,0($3)
	#.set	novolatile
	lw	$3,%lo(_com_delay)($2)
	li	$2,4901			# 0x00001325
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,%lo(StSTART_FLAG)($5)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L63
	lui	$18,%hi(_st_slot) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(StStartFrame) # high
	lw	$4,%lo(StStartFrame)($2)
	#nop
	beq	$4,$0,$L63
	lw	$3,%lo(_st_slot)($6)
	#nop
	#.set	volatile
	lhu	$2,8($3)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L27
	lui	$2,%hi(StEmu_Addr) # high
	.set	macro
	.set	reorder

	#.set	volatile
	sh	$0,0($3)
	#.set	novolatile
	lw	$2,%lo(StEmu_Addr)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1
	lui	$3,%hi(StEmu_Idx) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(StEmu_Idx)($3)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L1
	sw	$2,%lo(StEmu_Idx)($3)
	.set	macro
	.set	reorder

$L27:
	sw	$0,%lo(StSTART_FLAG)($5)
	lui	$18,%hi(_st_slot) # high
$L63:
	lw	$4,%lo(_st_slot)($18)
	#nop
	lhu	$3,0($4)
	li	$2,352			# 0x00000160
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L64
	lui	$2,%hi(StEmu_Addr) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(CChannel) # high
	#.set	volatile
	lhu	$2,2($4)
	#.set	novolatile
	lw	$3,%lo(CChannel)($3)
	srl	$2,$2,10
	andi	$2,$2,0x001f
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L30
	lui	$2,%hi(StEmu_Addr) # high
	.set	macro
	.set	reorder

$L64:
	lw	$2,%lo(StEmu_Addr)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L32
	lui	$2,%hi(StEmu_Idx) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L33
	sw	$0,%lo(StEmu_Idx)($2)
	.set	macro
	.set	reorder

$L32:
	#.set	volatile
	lhu	$2,0($4)
	#.set	novolatile
$L33:
	lui	$4,%hi(debug_cause) # high
	lui	$2,%hi(_st_slot) # high
	lw	$3,%lo(_st_slot)($2)
	li	$2,5			# 0x00000005
	sw	$2,%lo(debug_cause)($4)
	#.set	volatile
	sh	$0,0($3)
	#.set	novolatile
	j	$L1
$L30:
	lui	$5,%hi(Stsector_offset) # high
	lh	$3,%lo(Stsector_offset)($5)
	#.set	volatile
	lhu	$2,4($4)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L65
	lui	$16,%hi(StRingIdx2) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(Stframe_no) # high
	lw	$3,%lo(Stframe_no)($2)
	#nop
	beq	$3,$0,$L34
	#.set	volatile
	lhu	$2,8($4)
	#.set	novolatile
	#nop
	beq	$3,$2,$L34
$L65:
	lw	$4,%lo(StRingIdx2)($16)
	lui	$17,%hi(StRingIdx1) # high
	sh	$0,%lo(Stsector_offset)($5)
	lw	$5,%lo(StRingIdx1)($17)
	lui	$2,%hi(Stframe_no) # high
	sw	$0,%lo(Stframe_no)($2)
	.set	noreorder
	.set	nomacro
	jal	init_ring_status
	subu	$5,$5,$4
	.set	macro
	.set	reorder

	lw	$2,%lo(StRingIdx2)($16)
	lw	$3,%lo(_st_slot)($18)
	sw	$2,%lo(StRingIdx1)($17)
	lui	$2,%hi(StEmu_Addr) # high
	#.set	volatile
	sh	$0,0($3)
	#.set	novolatile
	lw	$2,%lo(StEmu_Addr)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L36
	lui	$3,%hi(StEmu_Idx) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(StEmu_Idx)($3)
	#nop
	addu	$2,$2,1
	sw	$2,%lo(StEmu_Idx)($3)
$L36:
	lui	$3,%hi(debug_cause) # high
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	j	$L1
	sw	$2,%lo(debug_cause)($3)
	.set	macro
	.set	reorder

$L34:
	lui	$18,%hi(_st_slot) # high
	lw	$3,%lo(_st_slot)($18)
	#nop
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L66
	lui	$5,%hi(debug_cause) # high
	.set	macro
	.set	reorder

	lui	$6,%hi(Stsector_offset) # high
	lui	$2,%hi(StEndFrame) # high
	#.set	volatile
	lhu	$3,8($3)
	#.set	novolatile
	lw	$4,%lo(StEndFrame)($2)
	lui	$5,%hi(Stframe_no) # high
	sh	$0,%lo(Stsector_offset)($6)
	andi	$2,$3,0xffff
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L38
	sw	$2,%lo(Stframe_no)($5)
	.set	macro
	.set	reorder

	sltu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L67
	lui	$2,%hi(StRingSize) # high
	.set	macro
	.set	reorder

	lui	$16,%hi(StRingIdx2) # high
	lw	$4,%lo(StRingIdx2)($16)
	lui	$17,%hi(StRingIdx1) # high
	sw	$0,%lo(Stframe_no)($5)
	lw	$5,%lo(StRingIdx1)($17)
	sh	$0,%lo(Stsector_offset)($6)
	.set	noreorder
	.set	nomacro
	jal	init_ring_status
	subu	$5,$5,$4
	.set	macro
	.set	reorder

	lw	$2,%lo(StRingIdx2)($16)
	lw	$3,%lo(_st_slot)($18)
	sw	$2,%lo(StRingIdx1)($17)
	#.set	volatile
	sh	$0,0($3)
	#.set	novolatile
	lui	$3,%hi(StSTART_FLAG) # high
	lui	$2,%hi(StFunc2) # high
	lw	$4,%lo(StFunc2)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L39
	sw	$2,%lo(StSTART_FLAG)($3)
	.set	macro
	.set	reorder

	jal	$31,$4
$L39:
	lui	$2,%hi(StEmu_Addr) # high
	lw	$2,%lo(StEmu_Addr)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L40
	lui	$3,%hi(StEmu_Idx) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(StEmu_Idx)($3)
	#nop
	addu	$2,$2,1
	sw	$2,%lo(StEmu_Idx)($3)
$L40:
	lui	$3,%hi(debug_cause) # high
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	j	$L1
	sw	$2,%lo(debug_cause)($3)
	.set	macro
	.set	reorder

$L38:
	lui	$2,%hi(StRingSize) # high
$L67:
	lui	$7,%hi(StRingIdx1) # high
	lui	$6,%hi(_st_slot) # high
	lw	$2,%lo(StRingSize)($2)
	lw	$3,%lo(StRingIdx1)($7)
	lw	$4,%lo(_st_slot)($6)
	subu	$2,$2,$3
	#.set	volatile
	lhu	$3,6($4)
	#.set	novolatile
	addu	$2,$2,-1
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L41
	lui	$2,%hi(StEndFrame) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(StEndFrame)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L42
	lui	$3,%hi(StRingAddr) # high
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	lui	$3,%hi(StSTART_FLAG) # high
	#.set	volatile
	sh	$2,0($4)
	#.set	novolatile
	lui	$2,%hi(StFunc2) # high
	lw	$4,%lo(StFunc2)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L43
	sw	$2,%lo(StSTART_FLAG)($3)
	.set	macro
	.set	reorder

	jal	$31,$4
$L43:
	lui	$2,%hi(StEmu_Addr) # high
	lw	$2,%lo(StEmu_Addr)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L44
	lui	$3,%hi(StEmu_Idx) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(StEmu_Idx)($3)
	#nop
	addu	$2,$2,1
	sw	$2,%lo(StEmu_Idx)($3)
$L44:
	lui	$3,%hi(debug_cause) # high
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	j	$L1
	sw	$2,%lo(debug_cause)($3)
	.set	macro
	.set	reorder

$L42:
	lw	$2,%lo(StRingAddr)($3)
	#nop
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L45
	lui	$2,%hi(StEmu_Addr) # high
	.set	macro
	.set	reorder

	#.set	volatile
	sh	$0,0($4)
	#.set	novolatile
	lw	$2,%lo(StEmu_Addr)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L46
	lui	$3,%hi(StEmu_Idx) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(StEmu_Idx)($3)
	#nop
	addu	$2,$2,1
	sw	$2,%lo(StEmu_Idx)($3)
$L46:
	lui	$3,%hi(debug_cause) # high
	li	$2,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	j	$L1
	sw	$2,%lo(debug_cause)($3)
	.set	macro
	.set	reorder

$L45:
	li	$2,1			# 0x00000001
	#.set	volatile
	sh	$2,0($4)
	#.set	novolatile
	lw	$5,%lo(StRingAddr)($3)
	lw	$3,%lo(_st_slot)($6)
	move	$4,$0
	sw	$0,%lo(StRingIdx1)($7)
$L50:
	lw	$2,0($3)
	addu	$3,$3,4
	addu	$4,$4,1
	sw	$2,0($5)
	sltu	$2,$4,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L50
	addu	$5,$5,4
	.set	macro
	.set	reorder

	lui	$2,%hi(StRingAddr) # high
	lw	$3,%lo(StRingAddr)($2)
	lui	$2,%hi(_st_slot) # high
	sw	$3,%lo(_st_slot)($2)
$L41:
	lui	$2,%hi(StRingIdx1) # high
	lw	$3,%lo(StRingIdx1)($2)
	lui	$2,%hi(StRingIdx2) # high
	sw	$3,%lo(StRingIdx2)($2)
	lui	$5,%hi(debug_cause) # high
$L66:
	lui	$4,%hi(Stsector_offset) # high
	li	$3,10			# 0x0000000a
	sw	$3,%lo(debug_cause)($5)
	lui	$5,%hi(StRingBase) # high
	lui	$3,%hi(StRingIdx1) # high
	lhu	$2,%lo(Stsector_offset)($4)
	lw	$3,%lo(StRingIdx1)($3)
	addu	$2,$2,1
	sh	$2,%lo(Stsector_offset)($4)
	lui	$2,%hi(StRingSize) # high
	lui	$4,%hi(StRingAddr) # high
	lw	$2,%lo(StRingSize)($2)
	lw	$4,%lo(StRingAddr)($4)
	sll	$2,$2,5
	addu	$4,$4,$2
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,5
	lui	$3,%hi(StRgb24) # high
	lw	$3,%lo(StRgb24)($3)
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L52
	sw	$4,%lo(StRingBase)($5)
	.set	macro
	.set	reorder

	li	$9,285212672			# 0x11000000
	li	$3,131072			# 0x00020000
	lui	$2,%hi(_cdrom_delay) # high
	lw	$2,%lo(_cdrom_delay)($2)
	ori	$3,$3,0x0943
	#.set	volatile
	sw	$3,0($2)
	#.set	novolatile
	lui	$2,%hi(_com_delay) # high
	lw	$3,%lo(_com_delay)($2)
	.set	noreorder
	.set	nomacro
	j	$L61
	li	$2,4899			# 0x00001323
	.set	macro
	.set	reorder

$L52:
	li	$2,553779200			# 0x21020000
	ori	$2,$2,0x0843
	li	$9,289406976			# 0x11400000
	lui	$3,%hi(_cdrom_delay) # high
	lw	$3,%lo(_cdrom_delay)($3)
	ori	$9,$9,0x0100
$L61:
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lui	$2,%hi(_st_slot) # high
	lw	$3,%lo(_st_slot)($2)
	#nop
	#.set	volatile
	lhu	$2,6($3)
	#.set	novolatile
	#.set	volatile
	lhu	$3,4($3)
	#.set	novolatile
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L54
	lui	$2,%hi(StEmu_Addr) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(StFinalSector) # high
	lw	$8,%lo(StEmu_Addr)($2)
	li	$10,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L55
	sw	$10,%lo(StFinalSector)($3)
	.set	macro
	.set	reorder

	li	$6,504			# 0x000001f8
	move	$7,$10
	lui	$2,%hi(StRingBase) # high
	lui	$16,%hi(StEmu_Idx) # high
	lw	$5,%lo(StEmu_Idx)($16)
	lw	$4,%lo(StRingBase)($2)
	sll	$5,$5,11
	addu	$5,$8,$5
	.set	noreorder
	.set	nomacro
	jal	_st_copy_words
	addu	$5,$5,32
	.set	macro
	.set	reorder

	lw	$2,%lo(StEmu_Idx)($16)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L56
	sw	$2,%lo(StEmu_Idx)($16)
	.set	macro
	.set	reorder

$L55:
	li	$4,3			# 0x00000003
	move	$6,$0
	lui	$2,%hi(StRingBase) # high
	lw	$5,%lo(StRingBase)($2)
	li	$7,504			# 0x000001f8
	sw	$9,16($sp)
	sw	$10,20($sp)
	.set	noreorder
	.set	nomacro
	jal	_st_dma
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L56:
	lui	$2,%hi(Stsector_offset) # high
	sh	$0,%lo(Stsector_offset)($2)
	lui	$2,%hi(Stframe_no) # high
	sw	$0,%lo(Stframe_no)($2)
	lui	$2,%hi(StCHANNEL) # high
	lw	$3,%lo(StCHANNEL)($2)
	lui	$2,%hi(CChannel) # high
	.set	noreorder
	.set	nomacro
	j	$L57
	sw	$3,%lo(CChannel)($2)
	.set	macro
	.set	reorder

$L54:
	lw	$3,%lo(StEmu_Addr)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L58
	li	$6,504			# 0x000001f8
	.set	macro
	.set	reorder

	move	$7,$0
	lui	$2,%hi(StRingBase) # high
	lui	$16,%hi(StEmu_Idx) # high
	lw	$5,%lo(StEmu_Idx)($16)
	lw	$4,%lo(StRingBase)($2)
	sll	$5,$5,11
	addu	$5,$3,$5
	.set	noreorder
	.set	nomacro
	jal	_st_copy_words
	addu	$5,$5,32
	.set	macro
	.set	reorder

	lw	$2,%lo(StEmu_Idx)($16)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L57
	sw	$2,%lo(StEmu_Idx)($16)
	.set	macro
	.set	reorder

$L58:
	li	$4,3			# 0x00000003
	move	$6,$0
	lui	$2,%hi(StRingBase) # high
	lw	$5,%lo(StRingBase)($2)
	li	$7,504			# 0x000001f8
	sw	$9,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	_st_dma
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L57:
	lui	$2,%hi(_com_delay) # high
	lw	$3,%lo(_com_delay)($2)
	li	$2,4901			# 0x00001325
	lui	$4,%hi(StRingIdx1) # high
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lui	$2,%hi(_st_slot) # high
	lw	$3,%lo(_st_slot)($2)
	li	$2,3			# 0x00000003
	#.set	volatile
	sh	$2,0($3)
	#.set	novolatile
	lui	$3,%hi(StEmu_Addr) # high
	lw	$2,%lo(StRingIdx1)($4)
	lw	$3,%lo(StEmu_Addr)($3)
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1
	sw	$2,%lo(StRingIdx1)($4)
	.set	macro
	.set	reorder

	lui	$2,%hi(StFinalSector) # high
	lw	$2,%lo(StFinalSector)($2)
	#nop
	beq	$2,$0,$L1
	jal	data_ready_callback
$L1:
	lw	$31,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	StCdInterrupt
	.align	2
	.globl	_st_copy_words
	.ent	_st_copy_words
_st_copy_words:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L74
	move	$3,$0
	.set	macro
	.set	reorder

$L72:
	lw	$2,0($5)
	addu	$5,$5,4
	addu	$3,$3,1
	sw	$2,0($4)
	sltu	$2,$3,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L72
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L74:
	j	$31
	.end	_st_copy_words
	.rdata
	.align	2
$LC0:
	.ascii	"StCdInterrupt: DMA ch busy %08x\n\000"
	.text
	.align	2
	.globl	_st_dma
	.ent	_st_dma
_st_dma:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,28($sp)
	move	$17,$4
	sw	$18,32($sp)
	move	$18,$5
	sw	$19,36($sp)
	move	$19,$6
	sw	$20,40($sp)
	move	$20,$7
	move	$4,$0
	li	$7,65536			# 0x00010000
	sll	$5,$17,4
	li	$6,528482304			# 0x1f800000
	addu	$2,$5,$6
	li	$3,16777216			# 0x01000000
	sw	$31,44($sp)
	sw	$16,24($sp)
	#.set	volatile
	lw	$2,4232($2)
	#.set	novolatile
	lbu	$16,68($sp)
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L77
	addu	$3,$5,$6
	.set	macro
	.set	reorder

	li	$6,16777216			# 0x01000000
$L78:
	.set	noreorder
	.set	nomacro
	beq	$4,$7,$L87
	li	$2,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,4232($3)
	#.set	novolatile
	#nop
	and	$2,$2,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L78
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L77:
	li	$5,1			# 0x00000001
$L89:
	.set	noreorder
	.set	nomacro
	bne	$16,$5,$L81
	lui	$2,%hi(_dicr) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(_dicr)($2)
	#nop
	lbu	$4,2($3)
	sll	$2,$5,$17
	.set	noreorder
	.set	nomacro
	j	$L88
	or	$2,$4,$2
	.set	macro
	.set	reorder

$L87:
	lui	$4,%hi($LC0) # high
	addu	$2,$5,$2
	#.set	volatile
	lw	$5,4232($2)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	printf
	addiu	$4,$4,%lo($LC0) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L89
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L81:
	lw	$3,%lo(_dicr)($2)
	sll	$2,$5,$17
	lbu	$4,2($3)
	nor	$2,$0,$2
	and	$2,$4,$2
$L88:
	sb	$2,2($3)
	lui	$2,%hi(_dicr) # high
	lw	$2,%lo(_dicr)($2)
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,16($sp)
	#.set	novolatile
 #APP
	
 #NO_APP
	sll	$6,$17,2
	addu	$6,$6,3
	li	$3,1			# 0x00000001
	sll	$3,$3,$6
 #APP
	
 #NO_APP
	li	$5,528482304			# 0x1f800000
	lui	$2,%hi(_dpcr) # high
	ori	$5,$5,0x1080
	lw	$4,%lo(_dpcr)($2)
	sll	$2,$17,4
	addu	$5,$2,$5
	sll	$2,$19,16
	#.set	volatile
	lw	$6,0($4)
	#.set	novolatile
	or	$2,$2,$20
	or	$6,$6,$3
	#.set	volatile
	sw	$6,0($4)
	#.set	novolatile
	#.set	volatile
	sw	$18,0($5)
	#.set	novolatile
	addu	$5,$5,4
	#.set	volatile
	sw	$2,0($5)
	#.set	novolatile
	lui	$2,%hi(_cd_idx) # high
	lw	$3,%lo(_cd_idx)($2)
	#nop
	#.set	volatile
	lbu	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L84
	addu	$5,$5,4
	.set	macro
	.set	reorder

$L83:
	#.set	volatile
	lbu	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0040
	beq	$2,$0,$L83
$L84:
	#.set	volatile
	lw	$2,64($sp)
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,0($5)
	#.set	novolatile
	#.set	volatile
	lw	$2,0($5)
	#.set	novolatile
	lw	$31,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#.set	volatile
	sw	$2,16($sp)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	_st_dma
