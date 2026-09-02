	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\stcdint.c"

 # GNU C 2.6.3 [AL 1.1, MM 40] Sony Playstation compiled by GNU C

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -fno-strength-reduce -o

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
	.frame	$sp,64,$31		# vars= 24, regs= 1/0, args= 32, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	lw	$2,StFinalSector
	li	$4,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L1
	sw	$31,56($sp)
	.set	macro
	.set	reorder

	lw	$2,StRgb24
	#nop
	beq	$2,$0,$L61
	lw	$2,_d1_chcr
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,0x01000000		# 16777216
	and	$2,$2,$3
	beq	$2,$0,$L61
	lw	$2,StEmu_Addr
	sw	$4,StCdIntrFlag
	beq	$2,$0,$L4
	lw	$2,StEmu_Idx
	#nop
	addu	$2,$2,1
	sw	$2,StEmu_Idx
$L4:
	sw	$4,debug_cause
	j	$L1
$L61:
	.set	noreorder
	.set	nomacro
	jal	CdReady
	addu	$5,$sp,48
	.set	macro
	.set	reorder

	li	$3,0x00000005		# 5
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
	li	$2,0x00000003		# 3
	.set	macro
	.set	reorder

	sw	$2,debug_cause
	j	$L1
$L6:
	lw	$2,StRingIdx1
	lw	$3,StRingAddr
	sll	$2,$2,5
	addu	$2,$2,$3
	sw	$2,_st_slot
	#.set	volatile
	lhu	$2,0($2)
	#.set	novolatile
	#nop
	beq	$2,$0,$L7
	lw	$2,StEmu_Addr
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L62
	li	$2,0x00000004		# 4
	.set	macro
	.set	reorder

	lw	$2,StEmu_Idx
	#nop
	addu	$2,$2,1
	sw	$2,StEmu_Idx
	li	$2,0x00000004		# 4
$L62:
	sw	$2,debug_cause
	j	$L1
$L7:
	lw	$2,_cd_idx
	#nop
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$2,_cd_reg3
	#nop
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$2,_cd_idx
	li	$4,0x00020000		# 131072
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$3,_cd_reg3
	li	$2,0x00000080		# 128
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$2,_cdrom_delay
	ori	$4,$4,0x0943
	#.set	volatile
	sw	$4,0($2)
	#.set	novolatile
	lw	$3,_com_delay
	li	$2,0x00001323		# 4899
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,StMode
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L9
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$5,$sp,40
$L13:
	lw	$2,_cd_reg2
	addu	$3,$5,$4
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	addu	$4,$4,1
	sb	$2,0($3)
	sltu	$2,$4,4
	bne	$2,$0,$L13
	move	$4,$0
	lw	$3,_cd_reg2
$L18:
	#.set	volatile
	lbu	$2,0($3)
	#.set	novolatile
	addu	$4,$4,1
	sltu	$2,$4,8
	bne	$2,$0,$L18
$L9:
	lw	$2,StEmu_Addr
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L20
	li	$8,0x11000000		# 285212672
	.set	macro
	.set	reorder

	li	$6,0x00000008		# 8
	move	$7,$0
	lw	$5,StEmu_Idx
	lw	$4,_st_slot
	sll	$5,$5,11
	.set	noreorder
	.set	nomacro
	jal	_st_copy_words
	addu	$5,$5,$2
	.set	macro
	.set	reorder

	j	$L21
$L20:
	li	$4,0x00000003		# 3
	move	$6,$0
	lw	$5,_st_slot
	li	$7,0x00000008		# 8
	sw	$8,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	_st_dma
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L21:
	lw	$4,_d3_chcr
	#nop
	#.set	volatile
	lw	$2,0($4)
	#.set	novolatile
	li	$3,0x01000000		# 16777216
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L23
	move	$3,$4
	.set	macro
	.set	reorder

	li	$4,0x01000000		# 16777216
$L22:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	and	$2,$2,$4
	bne	$2,$0,$L22
$L23:
	li	$4,0x00020000		# 131072
	ori	$4,$4,0x0843
	lw	$2,_st_slot
	lw	$3,_cdrom_delay
	lwl	$5,43($sp)
	lwr	$5,40($sp)
	swl	$5,31($2)
	swr	$5,28($2)
	#.set	volatile
	sw	$4,0($3)
	#.set	novolatile
	lw	$3,_com_delay
	li	$2,0x00001325		# 4901
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,StSTART_FLAG
	li	$2,0x00000001		# 1
	bne	$3,$2,$L26
	lw	$4,StStartFrame
	#nop
	beq	$4,$0,$L26
	lw	$3,_st_slot
	#nop
	#.set	volatile
	lhu	$2,8($3)
	#.set	novolatile
	#nop
	beq	$4,$2,$L27
	#.set	volatile
	sh	$0,0($3)
	#.set	novolatile
	lw	$2,StEmu_Addr
	#nop
	beq	$2,$0,$L1
	lw	$2,StEmu_Idx
	#nop
	addu	$2,$2,1
	sw	$2,StEmu_Idx
	j	$L1
$L27:
	sw	$0,StSTART_FLAG
$L26:
	lw	$4,_st_slot
	#nop
	lhu	$3,0($4)
	li	$2,0x00000160		# 352
	bne	$3,$2,$L31
	#.set	volatile
	lhu	$2,2($4)
	#.set	novolatile
	lw	$3,CChannel
	srl	$2,$2,10
	andi	$2,$2,0x001f
	beq	$2,$3,$L30
$L31:
	lw	$2,StEmu_Addr
	#nop
	beq	$2,$0,$L32
	sw	$0,StEmu_Idx
	j	$L33
$L32:
	#.set	volatile
	lhu	$2,0($4)
	#.set	novolatile
$L33:
	lw	$3,_st_slot
	li	$2,0x00000005		# 5
	sw	$2,debug_cause
	#.set	volatile
	sh	$0,0($3)
	#.set	novolatile
	j	$L1
$L30:
	lh	$3,Stsector_offset
	#.set	volatile
	lhu	$2,4($4)
	#.set	novolatile
	#nop
	bne	$3,$2,$L35
	lw	$3,Stframe_no
	#nop
	beq	$3,$0,$L34
	#.set	volatile
	lhu	$2,8($4)
	#.set	novolatile
	#nop
	beq	$3,$2,$L34
$L35:
	lw	$4,StRingIdx2
	lw	$5,StRingIdx1
	sw	$0,Stframe_no
	sh	$0,Stsector_offset
	.set	noreorder
	.set	nomacro
	jal	init_ring_status
	subu	$5,$5,$4
	.set	macro
	.set	reorder

	lw	$2,StRingIdx2
	lw	$3,_st_slot
	sw	$2,StRingIdx1
	#.set	volatile
	sh	$0,0($3)
	#.set	novolatile
	lw	$2,StEmu_Addr
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L63
	li	$2,0x00000006		# 6
	.set	macro
	.set	reorder

	lw	$2,StEmu_Idx
	#nop
	addu	$2,$2,1
	sw	$2,StEmu_Idx
	li	$2,0x00000006		# 6
$L63:
	sw	$2,debug_cause
	j	$L1
$L34:
	lw	$3,_st_slot
	#nop
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L64
	li	$2,0x0000000a		# 10
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,8($3)
	#.set	novolatile
	lw	$3,StEndFrame
	sh	$0,Stsector_offset
	andi	$2,$2,0xffff
	sw	$2,Stframe_no
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L38
	sltu	$2,$2,$3
	.set	macro
	.set	reorder

	bne	$2,$0,$L38
	lw	$4,StRingIdx2
	lw	$5,StRingIdx1
	sw	$0,Stframe_no
	sh	$0,Stsector_offset
	.set	noreorder
	.set	nomacro
	jal	init_ring_status
	subu	$5,$5,$4
	.set	macro
	.set	reorder

	lw	$2,StRingIdx2
	lw	$3,_st_slot
	sw	$2,StRingIdx1
	#.set	volatile
	sh	$0,0($3)
	#.set	novolatile
	lw	$3,StFunc2
	li	$2,0x00000001		# 1
	sw	$2,StSTART_FLAG
	beq	$3,$0,$L39
	jal	$31,$3
$L39:
	lw	$2,StEmu_Addr
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L65
	li	$2,0x00000007		# 7
	.set	macro
	.set	reorder

	lw	$2,StEmu_Idx
	#nop
	addu	$2,$2,1
	sw	$2,StEmu_Idx
	li	$2,0x00000007		# 7
$L65:
	sw	$2,debug_cause
	j	$L1
$L38:
	lw	$2,StRingSize
	lw	$3,StRingIdx1
	lw	$4,_st_slot
	subu	$2,$2,$3
	#.set	volatile
	lhu	$3,6($4)
	#.set	novolatile
	addu	$2,$2,-1
	sltu	$2,$2,$3
	beq	$2,$0,$L41
	lw	$2,StEndFrame
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L42
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	#.set	volatile
	sh	$2,0($4)
	#.set	novolatile
	lw	$3,StFunc2
	li	$2,0x00000001		# 1
	sw	$2,StSTART_FLAG
	beq	$3,$0,$L43
	jal	$31,$3
$L43:
	lw	$2,StEmu_Addr
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L66
	li	$2,0x00000008		# 8
	.set	macro
	.set	reorder

	lw	$2,StEmu_Idx
	#nop
	addu	$2,$2,1
	sw	$2,StEmu_Idx
	li	$2,0x00000008		# 8
$L66:
	sw	$2,debug_cause
	j	$L1
$L42:
	lw	$2,StRingAddr
	#nop
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L45
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	#.set	volatile
	sh	$0,0($4)
	#.set	novolatile
	lw	$2,StEmu_Addr
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L67
	li	$2,0x00000009		# 9
	.set	macro
	.set	reorder

	lw	$2,StEmu_Idx
	#nop
	addu	$2,$2,1
	sw	$2,StEmu_Idx
	li	$2,0x00000009		# 9
$L67:
	sw	$2,debug_cause
	j	$L1
$L45:
	#.set	volatile
	sh	$2,0($4)
	#.set	novolatile
	lw	$5,StRingAddr
	lw	$3,_st_slot
	move	$4,$0
	sw	$0,StRingIdx1
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

	lw	$2,StRingAddr
	#nop
	sw	$2,_st_slot
$L41:
	lw	$2,StRingIdx1
	#nop
	sw	$2,StRingIdx2
	li	$2,0x0000000a		# 10
$L64:
	sw	$2,debug_cause
	lhu	$2,Stsector_offset
	lw	$3,StRingSize
	lw	$4,StRingIdx1
	addu	$2,$2,1
	sh	$2,Stsector_offset
	lw	$2,StRingAddr
	sll	$3,$3,5
	addu	$3,$3,$2
	sll	$2,$4,6
	subu	$2,$2,$4
	sll	$2,$2,5
	lw	$4,StRgb24
	addu	$3,$3,$2
	sw	$3,StRingBase
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L52
	li	$8,0x11000000		# 285212672
	.set	macro
	.set	reorder

	li	$3,0x00020000		# 131072
	lw	$2,_cdrom_delay
	ori	$3,$3,0x0943
	#.set	volatile
	sw	$3,0($2)
	#.set	novolatile
	lw	$3,_com_delay
	li	$2,0x00001323		# 4899
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	j	$L53
$L52:
	li	$3,0x21020000		# 553779200
	ori	$3,$3,0x0843
	li	$8,0x11400000		# 289406976
	lw	$2,_cdrom_delay
	ori	$8,$8,0x0100
	#.set	volatile
	sw	$3,0($2)
	#.set	novolatile
$L53:
	lw	$2,_st_slot
	#nop
	#.set	volatile
	lhu	$3,6($2)
	#.set	novolatile
	#.set	volatile
	lhu	$2,4($2)
	#.set	novolatile
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L54
	li	$3,0x00000001		# 1
	.set	macro
	.set	reorder

	lw	$2,StEmu_Addr
	sw	$3,StFinalSector
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L55
	li	$6,0x000001f8		# 504
	.set	macro
	.set	reorder

	li	$7,0x00000001		# 1
	lw	$5,StEmu_Idx
	lw	$4,StRingBase
	sll	$5,$5,11
	addu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	jal	_st_copy_words
	addu	$5,$5,32
	.set	macro
	.set	reorder

	lw	$2,StEmu_Idx
	#nop
	addu	$2,$2,1
	sw	$2,StEmu_Idx
	j	$L56
$L55:
	li	$4,0x00000003		# 3
	move	$6,$0
	lw	$5,StRingBase
	li	$7,0x000001f8		# 504
	sw	$8,16($sp)
	sw	$3,20($sp)
	.set	noreorder
	.set	nomacro
	jal	_st_dma
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L56:
	lw	$2,StCHANNEL
	sh	$0,Stsector_offset
	sw	$0,Stframe_no
	sw	$2,CChannel
	j	$L57
$L54:
	lw	$2,StEmu_Addr
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L58
	li	$6,0x000001f8		# 504
	.set	macro
	.set	reorder

	move	$7,$0
	lw	$5,StEmu_Idx
	lw	$4,StRingBase
	sll	$5,$5,11
	addu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	jal	_st_copy_words
	addu	$5,$5,32
	.set	macro
	.set	reorder

	lw	$2,StEmu_Idx
	#nop
	addu	$2,$2,1
	sw	$2,StEmu_Idx
	j	$L57
$L58:
	li	$4,0x00000003		# 3
	move	$6,$0
	lw	$5,StRingBase
	li	$7,0x000001f8		# 504
	sw	$8,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	_st_dma
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L57:
	lw	$3,_com_delay
	li	$2,0x00001325		# 4901
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,_st_slot
	li	$2,0x00000003		# 3
	#.set	volatile
	sh	$2,0($3)
	#.set	novolatile
	lw	$2,StRingIdx1
	lw	$3,StEmu_Addr
	addu	$2,$2,1
	sw	$2,StRingIdx1
	beq	$3,$0,$L1
	lw	$2,StFinalSector
	#nop
	beq	$2,$0,$L1
	jal	data_ready_callback
$L1:
	lw	$31,56($sp)
	addu	$sp,$sp,64
	j	$31
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
	beq	$6,$0,$L68
	move	$3,$0
	.set	macro
	.set	reorder

$L70:
	lw	$2,0($5)
	addu	$5,$5,4
	addu	$3,$3,1
	sw	$2,0($4)
	sltu	$2,$3,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L70
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L68:
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
	sw	$16,24($sp)
	move	$16,$4
	sw	$18,32($sp)
	move	$18,$5
	sw	$19,36($sp)
	move	$19,$6
	sw	$20,40($sp)
	move	$20,$7
	move	$4,$0
	li	$6,0x00010000		# 65536
	sll	$5,$16,4
	li	$3,0x01000000		# 16777216
	sw	$31,44($sp)
	sw	$17,28($sp)
	#.set	volatile
	lw	$2,528486536($5)
	#.set	novolatile
	lbu	$17,68($sp)
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L86
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L75:
	beq	$4,$6,$L84
	#.set	volatile
	lw	$2,528486536($5)
	#.set	novolatile
	#nop
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L75
	addu	$4,$4,1
	.set	macro
	.set	reorder

	li	$2,0x00000001		# 1
$L86:
	bne	$17,$2,$L78
	lw	$3,_dicr
	#nop
	lbu	$4,2($3)
	sll	$2,$2,$16
	.set	noreorder
	.set	nomacro
	j	$L85
	or	$2,$4,$2
	.set	macro
	.set	reorder

$L84:
	#.set	volatile
	lw	$5,528486536($5)
	#.set	novolatile
	la	$4,$LC0
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L86
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L78:
	lw	$3,_dicr
	sll	$2,$2,$16
	lbu	$4,2($3)
	nor	$2,$0,$2
	and	$2,$4,$2
$L85:
	sb	$2,2($3)
	lw	$2,_dicr
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
	sll	$6,$16,2
	addu	$6,$6,3
	li	$3,0x00000001		# 1
	sll	$3,$3,$6
 #APP
	
 #NO_APP
	li	$5,0x1f800000		# 528482304
	ori	$5,$5,0x1080
	sll	$2,$16,4
	addu	$5,$2,$5
	lw	$4,_dpcr
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
	lw	$3,_cd_idx
	#nop
	#.set	volatile
	lbu	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L81
	addu	$5,$5,4
	.set	macro
	.set	reorder

$L80:
	#.set	volatile
	lbu	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0040
	beq	$2,$0,$L80
$L81:
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
	#nop
	#.set	volatile
	sw	$2,16($sp)
	#.set	novolatile
	lw	$31,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,48
	j	$31
	.end	_st_dma
