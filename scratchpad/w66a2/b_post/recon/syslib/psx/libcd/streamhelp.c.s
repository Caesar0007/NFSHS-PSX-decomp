	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\streamhelp.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	_ds_word0
	.globl	_ds_word1
	.globl	_ds_ready_cb
	.section	.bss
	.align	2
_ds_word0:
	.space	4
_ds_word1:
	.space	4
	.space	8
_ds_ready_cb:
	.space	4
	.text
 #NO_APP
	.section .data,"aw",@progbits
	.align	2
_un_cd_idx:
	.word	528488448
	.align	2
_un_cd_reg3:
	.word	528488451
	.text
	.align	2
	.globl	StUnSetRing
	.ent	StUnSetRing
StUnSetRing:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	EnterCriticalSection
	lw	$3,DS_active
	li	$2,0x00000001		# 1
	bne	$3,$2,$L2
	.set	noreorder
	.set	nomacro
	jal	DsDataCallback
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DsReadyCallback
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	j	$L3
$L2:
	.set	noreorder
	.set	nomacro
	jal	CdDataCallback
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdReadyCallback
	addu	$4,$0,$0
	.set	macro
	.set	reorder

$L3:
	lw	$2,_un_cd_idx
	#nop
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$2,_un_cd_reg3
	#nop
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	jal	ExitCriticalSection
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	StUnSetRing
	.align	2
	.globl	StGetNext
	.ent	StGetNext
StGetNext:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$7,$4,$0
	lw	$2,StRingIdx3
	lw	$3,StRingAddr
	sll	$2,$2,5
	addu	$6,$3,$2
	lhu	$3,0($6)
	li	$2,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L9
	addu	$8,$5,$0
	.set	macro
	.set	reorder

	lw	$2,StEndFrame
	sw	$0,StRingIdx3
	beq	$2,$0,$L6
	sh	$0,0($6)
$L6:
	lw	$2,StRingIdx3
	lw	$3,StRingAddr
	sll	$2,$2,5
	addu	$6,$3,$2
$L9:
	lhu	$3,0($6)
	li	$2,0x00000002		# 2
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L7
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	li	$2,0x00000004		# 4
	sh	$2,0($6)
	addu	$2,$0,$0
	lw	$3,StRingSize
	lw	$4,StRingAddr
	lw	$5,StRingIdx3
	sll	$3,$3,5
	addu	$4,$4,$3
	sll	$3,$5,6
	subu	$3,$3,$5
	sll	$3,$3,5
	addu	$4,$4,$3
	sw	$4,0($7)
	sw	$6,0($8)
$L7:
	j	$31
	.end	StGetNext
	.align	2
	.globl	StFreeRing
	.ent	StFreeRing
StFreeRing:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$5,-2113404928			# 0x82080000
	ori	$5,$5,0x2083
	lw	$2,StRingSize
	lw	$3,StRingAddr
	sll	$2,$2,5
	addu	$2,$3,$2
	subu	$4,$4,$2
	sra	$2,$4,2
	mult	$2,$5
	sra	$4,$4,31
	mfhi	$7
	#nop
	#nop
	addu	$2,$7,$2
	sra	$2,$2,8
	subu	$5,$2,$4
	sll	$2,$5,5
	addu	$3,$3,$2
	li	$4,0x00000004		# 4
	lh	$2,0($3)
	lhu	$3,6($3)
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L17
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	sll	$2,$3,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L12
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	addu	$6,$2,$0
$L13:
	addu	$2,$4,$5
	addu	$4,$4,1
	lw	$3,StRingAddr
	sll	$2,$2,5
	addu	$3,$3,$2
	slt	$2,$4,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L13
	sh	$0,0($3)
	.set	macro
	.set	reorder

$L12:
	addu	$2,$4,$5
	sw	$2,StRingIdx3
	addu	$2,$0,$0
$L17:
	j	$31
	.end	StFreeRing
	.align	2
	.globl	init_ring_status
	.ent	init_ring_status
init_ring_status:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L18
	addu	$6,$0,$0
	.set	macro
	.set	reorder

$L20:
	addu	$2,$6,$4
	addu	$6,$6,1
	lw	$3,StRingAddr
	sll	$2,$2,5
	addu	$3,$3,$2
	sltu	$2,$6,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L20
	sw	$0,0($3)
	.set	macro
	.set	reorder

$L18:
	j	$31
	.end	init_ring_status
	.align	2
	.globl	data_ready_callback
	.ent	data_ready_callback
data_ready_callback:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,StRingIdx2
	lw	$3,StRingAddr
	subu	$sp,$sp,24
	sw	$31,16($sp)
	sll	$2,$2,5
	addu	$3,$3,$2
	li	$2,0x00000002		# 2
	sh	$2,0($3)
	lwl	$2,31($3)
	lwr	$2,28($3)
	swl	$2,_ds_word0+3
	swr	$2,_ds_word0
	lw	$2,8($3)
	lw	$3,StRingIdx1
	lw	$4,StFunc1
	sw	$2,_ds_word1
	sw	$3,StRingIdx2
	beq	$4,$0,$L23
	jal	$31,$4
$L23:
	sw	$0,StFinalSector
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	data_ready_callback
	.align	2
	.globl	StSetMask
	.ent	StSetMask
StSetMask:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$4,StSTART_FLAG
	sw	$5,StStartFrame
	sw	$6,StEndFrame
	j	$31
	.end	StSetMask
