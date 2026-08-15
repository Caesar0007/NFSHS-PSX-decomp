	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libetc\\INTR_DMA.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.ent	_bzero_w
_bzero_w:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L2
	addu	$2,$5,-1
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
$L3:
	sw	$0,0($4)
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L3
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L2:
	j	$31
	.end	_bzero_w
	.align	2
	.globl	startIntrDMA
	.ent	startIntrDMA
startIntrDMA:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$4,dma_cb
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_bzero_w
	li	$5,0x00000008		# 8
	.set	macro
	.set	reorder

	li	$4,0x00000003		# 3
	lw	$2,D_8013BD20
	la	$5,_dma_isr
	.set	noreorder
	.set	nomacro
	jal	InterruptCallback
	sw	$0,0($2)
	.set	macro
	.set	reorder

	la	$2,func_80106878
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	startIntrDMA
	.rdata
	.align	2
$LC0:
	.ascii	"DMA bus error: code=%08x\n\000"
	.align	2
$LC1:
	.ascii	"MADR[%d]=%08x\n\000"
	.text
	.align	2
	.globl	_dma_isr
	.ent	_dma_isr
_dma_isr:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	lw	$2,D_8013BD20
	subu	$sp,$sp,48
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	srl	$2,$2,24
	andi	$17,$2,0x007f
	beq	$17,$0,$L10
	li	$20,0x00000001		# 1
	li	$19,0x00ff0000		# 16711680
	ori	$19,$19,0xffff
	la	$21,dma_cb
$L11:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L9
	addu	$16,$0,$0
	.set	macro
	.set	reorder

	addu	$18,$21,$0
$L19:
	slt	$2,$16,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	andi	$2,$17,0x0001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	addu	$2,$16,24
	.set	macro
	.set	reorder

	lw	$4,D_8013BD20
	sll	$2,$20,$2
	#.set	volatile
	lw	$3,0($4)
	#.set	novolatile
	or	$2,$2,$19
	and	$3,$3,$2
	#.set	volatile
	sw	$3,0($4)
	#.set	novolatile
	lw	$2,0($18)
	#nop
	beq	$2,$0,$L14
	jal	$31,$2
$L14:
	addu	$18,$18,4
	srl	$17,$17,1
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L19
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L9:
	lw	$2,D_8013BD20
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	srl	$2,$2,24
	andi	$17,$2,0x007f
	bne	$17,$0,$L11
$L10:
	lw	$5,D_8013BD20
	#nop
	#.set	volatile
	lw	$2,0($5)
	#.set	novolatile
	li	$3,-16777216			# 0xff000000
	and	$2,$2,$3
	li	$3,-2147483648			# 0x80000000
	beq	$2,$3,$L22
	#.set	volatile
	lw	$2,0($5)
	#.set	novolatile
	#nop
	andi	$2,$2,0x8000
	beq	$2,$0,$L8
$L22:
	la	$4,$LC0
	#.set	volatile
	lw	$5,0($5)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	printf
	addu	$16,$0,$0
	.set	macro
	.set	reorder

$L27:
	la	$4,$LC1
	addu	$5,$16,$0
	lw	$2,D_8013BD44
	sll	$3,$16,4
	addu	$3,$3,$2
	#.set	volatile
	lw	$6,0($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	printf
	addu	$16,$16,1
	.set	macro
	.set	reorder

	slt	$2,$16,7
	bne	$2,$0,$L27
$L8:
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,48
	j	$31
	.end	_dma_isr
	.align	2
	.globl	func_80106878
	.ent	func_80106878
func_80106878:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	la	$3,dma_cb
	sll	$2,$4,2
	addu	$3,$2,$3
	lw	$7,0($3)
	addu	$6,$5,$0
	beq	$6,$7,$L30
	beq	$6,$0,$L31
	li	$2,0x00ff0000		# 16711680
	lw	$5,D_8013BD20
	ori	$2,$2,0xffff
	sw	$6,0($3)
	#.set	volatile
	lw	$3,0($5)
	#.set	novolatile
	addu	$4,$4,16
	and	$3,$3,$2
	li	$2,0x00000001		# 1
	sll	$2,$2,$4
	or	$3,$3,$2
	li	$2,0x00800000		# 8388608
	.set	noreorder
	.set	nomacro
	j	$L33
	or	$3,$3,$2
	.set	macro
	.set	reorder

$L31:
	li	$2,0x00ff0000		# 16711680
	lw	$5,D_8013BD20
	ori	$2,$2,0xffff
	sw	$0,0($3)
	#.set	volatile
	lw	$3,0($5)
	#.set	novolatile
	addu	$4,$4,16
	and	$3,$3,$2
	li	$2,0x00800000		# 8388608
	or	$3,$3,$2
	li	$2,0x00000001		# 1
	sll	$2,$2,$4
	nor	$2,$0,$2
	and	$3,$3,$2
$L33:
	#.set	volatile
	sw	$3,0($5)
	#.set	novolatile
$L30:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$7,$0
	.set	macro
	.set	reorder

	.end	func_80106878
