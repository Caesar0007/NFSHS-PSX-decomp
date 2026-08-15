	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libapi\\COUNTER.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SetRCnt
	.ent	SetRCnt
SetRCnt:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	andi	$8,$4,0xffff
	slt	$2,$8,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	li	$7,0x00000048		# 72
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L10
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L2:
	lw	$2,RCnt_regs
	sll	$3,$8,4
	addu	$3,$3,$2
	sltu	$2,$8,2
	#.set	volatile
	sh	$0,4($3)
	#.set	novolatile
	#.set	volatile
	sh	$5,8($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	andi	$2,$6,0x0010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L11
	andi	$2,$6,0x0001
	.set	macro
	.set	reorder

	li	$7,0x00000049		# 73
$L11:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	andi	$2,$6,0x1000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L12
	ori	$7,$7,0x0100
	.set	macro
	.set	reorder

$L3:
	li	$2,0x00000002		# 2
	.set	noreorder
	.set	nomacro
	bne	$8,$2,$L12
	andi	$2,$6,0x1000
	.set	macro
	.set	reorder

	andi	$2,$6,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	andi	$2,$6,0x1000
	.set	macro
	.set	reorder

	li	$7,0x00000248		# 584
$L12:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L13
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	ori	$7,$7,0x0010
$L13:
	lw	$4,RCnt_regs
	sll	$3,$8,4
	addu	$3,$3,$4
	#.set	volatile
	sh	$7,4($3)
	#.set	novolatile
$L10:
	j	$31
	.end	SetRCnt
	.align	2
	.globl	GetRCnt
	.ent	GetRCnt
GetRCnt:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	andi	$3,$4,0xffff
	slt	$2,$3,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L15
	sll	$3,$3,4
	.set	macro
	.set	reorder

	lw	$2,RCnt_regs
	#nop
	addu	$3,$3,$2
	#.set	volatile
	lhu	$2,0($3)
	#.set	novolatile
	j	$L16
$L15:
	addu	$2,$0,$0
$L16:
	j	$31
	.end	GetRCnt
	.align	2
	.globl	StartRCnt
	.ent	StartRCnt
StartRCnt:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	andi	$2,$4,0xffff
	sll	$4,$2,2
	lw	$5,RCnt_ctrl
	lw	$4,RCnt_irq($4)
	lw	$3,4($5)
	slt	$2,$2,3
	or	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,4($5)
	.set	macro
	.set	reorder

	.end	StartRCnt
