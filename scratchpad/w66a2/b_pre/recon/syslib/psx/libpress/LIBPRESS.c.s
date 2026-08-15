	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpress\\LIBPRESS.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.rdata
	.align	2
_mdec_iqtab:
	.word	1073741825
	.word	319819778
	.word	370545424
	.word	370546198
	.word	454694938
	.word	437918491
	.word	454760986
	.word	488447259
	.word	488776226
	.word	454761757
	.word	538975517
	.word	639967778
	.word	572728101
	.word	673588771
	.word	808462376
	.word	943205934
	.word	1397048634
	.word	319819778
	.word	370545424
	.word	370546198
	.word	454694938
	.word	437918491
	.word	454760986
	.word	488447259
	.word	488776226
	.word	454761757
	.word	538975517
	.word	639967778
	.word	572728101
	.word	673588771
	.word	808462376
	.word	943205934
	.word	1397048634
	.align	2
_mdec_idcttab:
	.word	1610612736
	.word	1518492290
	.word	1518492290
	.word	1518492290
	.word	1518492290
	.word	1785560458
	.word	418924316
	.word	-1193023737
	.word	-2106223214
	.word	821786177
	.word	-1983983868
	.word	-821786178
	.word	1983983867
	.word	-418944403
	.word	-1193049483
	.word	2106214172
	.word	-1785587464
	.word	-1518511486
	.word	1518511485
	.word	-1518511486
	.word	1518511485
	.word	-2106243300
	.word	1785534712
	.word	-418933358
	.word	-1193050742
	.word	-1984024325
	.word	-821791167
	.word	1984024324
	.word	821791166
	.word	-1193076488
	.word	-2106234259
	.word	-1785561718
	.word	-418953444
	.text
	.align	2
	.globl	DecDCTReset
	.ent	DecDCTReset
DecDCTReset:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	addu	$16,$4,$0
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L2
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	jal	ResetCallback
$L2:
	.set	noreorder
	.set	nomacro
	jal	MDEC_rest
	addu	$4,$16,$0
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	DecDCTReset
	.align	2
	.globl	DecDCTin
	.ent	DecDCTin
DecDCTin:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	andi	$2,$5,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	li	$3,-134283264			# 0xf7ff0000
	lw	$2,0($4)
	ori	$3,$3,0xffff
	.set	noreorder
	.set	nomacro
	j	$L8
	and	$2,$2,$3
	.set	macro
	.set	reorder

$L4:
	lw	$2,0($4)
	li	$3,0x08000000		# 134217728
	or	$2,$2,$3
$L8:
	sw	$2,0($4)
	andi	$2,$5,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	li	$3,0x02000000		# 33554432
	.set	macro
	.set	reorder

	lw	$2,0($4)
	.set	noreorder
	.set	nomacro
	j	$L9
	or	$2,$2,$3
	.set	macro
	.set	reorder

$L6:
	li	$3,-33619968			# 0xfdff0000
	lw	$2,0($4)
	ori	$3,$3,0xffff
	and	$2,$2,$3
$L9:
	sw	$2,0($4)
	lhu	$5,0($4)
	jal	_MDEC_in_dma
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	DecDCTin
	.align	2
	.globl	DecDCTout
	.ent	DecDCTout
DecDCTout:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	_MDEC_out_dma
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	DecDCTout
	.align	2
	.globl	DecDCTinSync
	.ent	DecDCTinSync
DecDCTinSync:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L12
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	MDEC_in_sync
	j	$L13
$L12:
	jal	_MDEC_get_reg1
	srl	$2,$2,29
	andi	$2,$2,0x0001
$L13:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	DecDCTinSync
	.align	2
	.globl	DecDCToutCallback
	.ent	DecDCToutCallback
DecDCToutCallback:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	addu	$5,$4,$0
	.set	noreorder
	.set	nomacro
	jal	DMACallback
	li	$4,0x00000001		# 1
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	DecDCToutCallback
	.rdata
	.align	2
$LC0:
	.ascii	"MDEC_rest:bad option(%d)\n\000"
	.text
	.align	2
	.ent	MDEC_rest
MDEC_rest:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	addu	$5,$4,$0
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L17
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	li	$2,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L18
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

	j	$L16
$L17:
	lw	$3,MDEC1_ptr
	li	$2,-2147483648			# 0x80000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,D0_CHCR_ptr
	la	$4,_mdec_iqtab
	#.set	volatile
	sw	$0,0($2)
	#.set	novolatile
	lw	$2,D1_CHCR_ptr
	li	$5,0x00000020		# 32
	#.set	volatile
	sw	$0,0($2)
	#.set	novolatile
	lw	$3,MDEC1_ptr
	li	$2,0x60000000		# 1610612736
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	jal	_MDEC_in_dma
	la	$4,_mdec_idcttab
	.set	noreorder
	.set	nomacro
	jal	_MDEC_in_dma
	li	$5,0x00000020		# 32
	.set	macro
	.set	reorder

	j	$L15
$L18:
	lw	$3,MDEC1_ptr
	#nop
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,D0_CHCR_ptr
	#nop
	#.set	volatile
	sw	$0,0($2)
	#.set	novolatile
	lw	$2,D1_CHCR_ptr
	#nop
	#.set	volatile
	sw	$0,0($2)
	#.set	novolatile
	lw	$2,D1_CHCR_ptr
	lw	$3,MDEC1_ptr
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	li	$2,0x60000000		# 1610612736
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	j	$L15
$L16:
	la	$4,$LC0
	jal	printf
$L15:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	MDEC_rest
	.align	2
	.ent	_MDEC_in_dma
_MDEC_in_dma:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	addu	$17,$4,$0
	sw	$16,16($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	MDEC_in_sync
	addu	$16,$5,$0
	.set	macro
	.set	reorder

	lw	$3,DPCR_ptr
	srl	$16,$16,5
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	sll	$16,$16,16
	ori	$2,$2,0x0088
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,D0_MADR_ptr
	addu	$2,$17,4
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,D0_BCR_ptr
	ori	$16,$16,0x0020
	#.set	volatile
	sw	$16,0($2)
	#.set	novolatile
	lw	$3,MDEC0_ptr
	lw	$2,0($17)
	li	$4,0x01000000		# 16777216
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,D0_CHCR_ptr
	ori	$4,$4,0x0201
	#.set	volatile
	sw	$4,0($2)
	#.set	novolatile
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_MDEC_in_dma
	.align	2
	.ent	_MDEC_out_dma
_MDEC_out_dma:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	addu	$17,$4,$0
	sw	$16,16($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	MDEC_out_sync
	addu	$16,$5,$0
	.set	macro
	.set	reorder

	lw	$3,DPCR_ptr
	#nop
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	srl	$16,$16,5
	ori	$2,$2,0x0088
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,D1_CHCR_ptr
	sll	$16,$16,16
	#.set	volatile
	sw	$0,0($2)
	#.set	novolatile
	lw	$2,D1_MADR_ptr
	ori	$16,$16,0x0020
	#.set	volatile
	sw	$17,0($2)
	#.set	novolatile
	lw	$2,D1_BCR_ptr
	li	$3,0x01000000		# 16777216
	#.set	volatile
	sw	$16,0($2)
	#.set	novolatile
	lw	$2,D1_CHCR_ptr
	ori	$3,$3,0x0200
	#.set	volatile
	sw	$3,0($2)
	#.set	novolatile
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_MDEC_out_dma
	.rdata
	.align	2
$LC1:
	.ascii	"MDEC_in_sync\000"
	.text
	.align	2
	.ent	MDEC_in_sync
MDEC_in_sync:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lw	$3,MDEC1_ptr
	li	$2,0x00100000		# 1048576
	sw	$31,24($sp)
	#.set	volatile
	sw	$2,16($sp)
	#.set	novolatile
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	li	$3,0x20000000		# 536870912
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L29
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	li	$4,-1			# 0xffffffff
$L26:
	#.set	volatile
	lw	$2,16($sp)
	#.set	novolatile
	#nop
	addu	$2,$2,-1
	#.set	volatile
	sw	$2,16($sp)
	#.set	novolatile
	#.set	volatile
	lw	$2,16($sp)
	#.set	novolatile
	#nop
	bne	$2,$4,$L24
	la	$4,$LC1
	jal	MDEC_status
	.set	noreorder
	.set	nomacro
	j	$L29
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L24:
	lw	$2,MDEC1_ptr
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L26
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L29:
	lw	$31,24($sp)
	addu	$sp,$sp,32
	j	$31
	.end	MDEC_in_sync
	.rdata
	.align	2
$LC2:
	.ascii	"MDEC_out_sync\000"
	.text
	.align	2
	.ent	MDEC_out_sync
MDEC_out_sync:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lw	$3,D1_CHCR_ptr
	li	$2,0x00100000		# 1048576
	sw	$31,24($sp)
	#.set	volatile
	sw	$2,16($sp)
	#.set	novolatile
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	li	$3,0x01000000		# 16777216
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L36
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	li	$4,-1			# 0xffffffff
$L33:
	#.set	volatile
	lw	$2,16($sp)
	#.set	novolatile
	#nop
	addu	$2,$2,-1
	#.set	volatile
	sw	$2,16($sp)
	#.set	novolatile
	#.set	volatile
	lw	$2,16($sp)
	#.set	novolatile
	#nop
	bne	$2,$4,$L31
	la	$4,$LC2
	jal	MDEC_status
	.set	noreorder
	.set	nomacro
	j	$L36
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L31:
	lw	$2,D1_CHCR_ptr
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L33
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L36:
	lw	$31,24($sp)
	addu	$sp,$sp,32
	j	$31
	.end	MDEC_out_sync
	.align	2
	.globl	_MDEC_get_reg1
	.ent	_MDEC_get_reg1
_MDEC_get_reg1:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,MDEC1_ptr
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	j	$31
	.end	_MDEC_get_reg1
	.rdata
	.align	2
$LC3:
	.ascii	"%s timeout:\n\000"
	.text
	.align	2
	.ent	MDEC_status
MDEC_status:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	addu	$5,$4,$0
	la	$4,$LC3
	sw	$31,16($sp)
	jal	printf
	lw	$3,MDEC1_ptr
	li	$2,-2147483648			# 0x80000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,D0_CHCR_ptr
	#nop
	#.set	volatile
	sw	$0,0($2)
	#.set	novolatile
	lw	$2,D1_CHCR_ptr
	#nop
	#.set	volatile
	sw	$0,0($2)
	#.set	novolatile
	addu	$2,$0,$0
	lw	$3,D1_CHCR_ptr
	lw	$4,MDEC1_ptr
	#.set	volatile
	lw	$3,0($3)
	#.set	novolatile
	#nop
	li	$3,0x60000000		# 1610612736
	#.set	volatile
	sw	$3,0($4)
	#.set	novolatile
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	MDEC_status

	.lcomm	D0_MADR_ptr,4

	.lcomm	D0_BCR_ptr,4

	.lcomm	D0_CHCR_ptr,4

	.lcomm	D1_MADR_ptr,4

	.lcomm	D1_BCR_ptr,4

	.lcomm	D1_CHCR_ptr,4

	.lcomm	MDEC0_ptr,4

	.lcomm	MDEC1_ptr,4

	.lcomm	DPCR_ptr,4
