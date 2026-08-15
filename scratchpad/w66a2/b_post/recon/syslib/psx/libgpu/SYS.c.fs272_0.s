	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\SYS.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	D_8013EAD8
	.globl	_gp1_shadow
	.section	.bss
	.align	2
D_8013EAD8:
	.space	32
_gp1_shadow:
	.space	256
	.text
 #NO_APP
	.globl	GPU_printf
	.section .bss,"aw",@progbits
	.align	2
GPU_printf:
	.word	0
	.data
	.align	2
_move_prim:
	.word	83886079
	.word	-2147483648
	.space	12
	.rdata
	.align	2
_gpu_tbl:
	.word	$LC0
	.word	_que_ref
	.word	_gpu_que_push
	.word	_BlitClear
	.word	_send_gp1
	.word	_send_gp0
	.word	_gpu_dma_chain
	.word	_drs
	.word	_dws
	.word	_gpu_que_drain
	.word	_get_gp1
	.word	_clearOTagR_dma
	.word	_get_gpuinfo
	.word	_reset
	.word	_get_status
	.word	_sync
	.align	2
$LC0:
	.ascii	"GPU\000"
	.section .data,"aw",@progbits
	.align	2
GEnv_drv:
	.word	_gpu_tbl
	.rdata
	.align	2
_vmode_w:
	.half	1024
	.half	0
	.half	1024
	.half	0
	.half	1024
	.half	0
	.align	2
_vmode_h:
	.half	512
	.half	0
	.half	512
	.half	0
	.half	1024
	.half	0
	.align	2
_disp_overscan:
	.half	590
	.half	3150
	.half	600
	.half	3160
	.half	539
	.half	3227
	.half	615
	.half	3175
	.half	620
	.half	3180
	.half	610
	.half	3170
	.half	624
	.half	3184
	.half	560
	.half	3248
	.half	635
	.half	3195
	.half	640
	.half	3200
	.align	2
_disp_mult:
	.byte	10
	.byte	8
	.byte	7
	.byte	5
	.byte	4
	.align	2
_otc_term:
	.word	83886079
	.align	2
$LC1:
	.ascii	"ResetGraph:jtb=%08x,env=%08x\n\000"
	.align	2
$LC2:
	.ascii	"ResetGraph(%d)...\n\000"
	.text
	.align	2
	.globl	ResetGraph
	.ent	ResetGraph
ResetGraph:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	move	$17,$4
	andi	$3,$17,0x0007
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L4
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	slt	$2,$3,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	beq	$3,$0,$L4
	j	$L2
$L8:
	beq	$3,$2,$L5
	j	$L2
$L4:
	la	$4,$LC1
	la	$5,_gpu_tbl
	la	$6,GEnv
	jal	printf
$L5:
	la	$16,GEnv
 #APP
 #NO_APP
	move	$4,$16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	_memset
	li	$6,128			# 0x00000080
	.set	macro
	.set	reorder

	jal	ResetCallback
	li	$2,16711680			# 0x00ff0000
	lw	$4,GEnv_drv
	ori	$2,$2,0xffff
	.set	noreorder
	.set	nomacro
	jal	GPU_cw
	and	$4,$4,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	_reset
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$4,$16,16
	#.set	volatile
	sb	$2,0($16)
	#.set	novolatile
	#.set	volatile
	lbu	$2,0($16)
	#.set	novolatile
	li	$3,1			# 0x00000001
	#.set	volatile
	sb	$3,1($16)
	#.set	novolatile
	sll	$2,$2,2
	lhu	$3,_vmode_w($2)
	#.set	volatile
	lbu	$2,0($16)
	#.set	novolatile
	li	$5,-1			# 0xffffffff
	sh	$3,4($16)
	sll	$2,$2,2
	lhu	$2,_vmode_h($2)
	li	$6,92			# 0x0000005c
	.set	noreorder
	.set	nomacro
	jal	_memset
	sh	$2,6($16)
	.set	macro
	.set	reorder

	addu	$4,$16,108
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	_memset
	li	$6,20			# 0x00000014
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$2,0($16)
	#.set	novolatile
	j	$L10
$L2:
	lbu	$2,GEnv+2
	#nop
	sltu	$2,$2,2
	bne	$2,$0,$L9
	la	$4,$LC2
	lw	$2,GPU_printf
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$17
	.set	macro
	.set	reorder

$L9:
	lw	$2,GEnv_drv
	#nop
	lw	$2,52($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L10:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	ResetGraph
	.rdata
	.align	2
$LC3:
	.ascii	"SetDispMask(%d)...\n\000"
	.text
	.align	2
	.globl	SetDispMask
	.ent	SetDispMask
SetDispMask:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	la	$17,GEnv+2
	lbu	$2,0($17)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	move	$16,$4
	.set	macro
	.set	reorder

	la	$4,$LC3
	lw	$2,GPU_printf
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$16
	.set	macro
	.set	reorder

$L12:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L13
	addu	$4,$17,106
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	_memset
	li	$6,20			# 0x00000014
	.set	macro
	.set	reorder

$L13:
	li	$4,50331648			# 0x03000000
	lw	$2,GEnv_drv
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L14
	ori	$4,$4,0x0001
	.set	macro
	.set	reorder

	li	$4,50331648			# 0x03000000
$L14:
	lw	$2,16($2)
	#nop
	jal	$31,$2
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	SetDispMask
	.rdata
	.align	2
$LC4:
	.ascii	"DrawSync(%d)...\n\000"
	.text
	.align	2
	.globl	DrawSync
	.ent	DrawSync
DrawSync:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
	lbu	$2,GEnv+2
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L17
	move	$16,$4
	.set	macro
	.set	reorder

	la	$4,$LC4
	lw	$2,GPU_printf
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$16
	.set	macro
	.set	reorder

$L17:
	lw	$2,GEnv_drv
	#nop
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DrawSync
	.rdata
	.align	2
$LC5:
	.ascii	"%s:bad RECT\000"
	.align	2
$LC6:
	.ascii	"(%d,%d)-(%d,%d)\n\000"
	.align	2
$LC7:
	.ascii	"%s:\000"
	.text
	.align	2
	.globl	_image
	.ent	_image
_image:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$16,24($sp)
	move	$8,$4
	la	$4,GEnv+2
	lbu	$3,0($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L20
	move	$16,$5
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	beq	$3,$2,$L23
	j	$L19
$L20:
	lh	$5,4($16)
	lh	$3,2($4)
	#nop
	slt	$2,$3,$5
	bne	$2,$0,$L22
	lh	$7,0($16)
	#nop
	addu	$2,$5,$7
	slt	$2,$3,$2
	bne	$2,$0,$L22
	lh	$3,2($16)
	lh	$4,4($4)
	#nop
	slt	$2,$4,$3
	bne	$2,$0,$L22
	lh	$6,6($16)
	#nop
	addu	$2,$3,$6
	slt	$2,$4,$2
	bne	$2,$0,$L22
	blez	$5,$L22
	bltz	$7,$L22
	bltz	$3,$L22
	bgtz	$6,$L19
$L22:
	la	$4,$LC5
	j	$L26
$L23:
	la	$4,$LC7
$L26:
	lw	$2,GPU_printf
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$8
	.set	macro
	.set	reorder

	la	$4,$LC6
	lh	$5,0($16)
	lh	$6,2($16)
	lh	$7,4($16)
	lh	$3,6($16)
	lw	$2,GPU_printf
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sw	$3,16($sp)
	.set	macro
	.set	reorder

$L19:
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	_image
	.rdata
	.align	2
$LC8:
	.ascii	"ClearImage\000"
	.text
	.align	2
	.globl	ClearImage
	.ent	ClearImage
ClearImage:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$19,$4
	la	$4,$LC8
	move	$18,$5
	move	$5,$19
	move	$17,$6
	.set	noreorder
	.set	nomacro
	jal	_image
	move	$16,$7
	.set	macro
	.set	reorder

	lw	$2,GEnv_drv
	move	$5,$19
	lw	$4,12($2)
	andi	$16,$16,0x00ff
	sll	$16,$16,16
	andi	$17,$17,0x00ff
	sll	$17,$17,8
	or	$16,$16,$17
	andi	$18,$18,0x00ff
	li	$6,8			# 0x00000008
	lw	$2,8($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	or	$7,$16,$18
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

	.end	ClearImage
	.rdata
	.align	2
$LC9:
	.ascii	"LoadImage\000"
	.text
	.align	2
	.globl	LoadImage
	.ent	LoadImage
LoadImage:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$16,$4
	move	$17,$5
	la	$4,$LC9
	.set	noreorder
	.set	nomacro
	jal	_image
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$2,GEnv_drv
	move	$5,$16
	lw	$4,32($2)
	li	$6,8			# 0x00000008
	lw	$2,8($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$7,$17
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	LoadImage
	.rdata
	.align	2
$LC10:
	.ascii	"StoreImage\000"
	.text
	.align	2
	.globl	StoreImage
	.ent	StoreImage
StoreImage:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$16,$4
	move	$17,$5
	la	$4,$LC10
	.set	noreorder
	.set	nomacro
	jal	_image
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$2,GEnv_drv
	move	$5,$16
	lw	$4,28($2)
	li	$6,8			# 0x00000008
	lw	$2,8($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$7,$17
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	StoreImage
	.rdata
	.align	2
$LC11:
	.ascii	"MoveImage\000"
	.text
	.align	2
	.globl	MoveImage
	.ent	MoveImage
MoveImage:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$16,$4
	move	$18,$5
	move	$17,$6
	la	$4,$LC11
	.set	noreorder
	.set	nomacro
	jal	_image
	move	$5,$16
	.set	macro
	.set	reorder

	lh	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L33
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lh	$2,6($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L31
	sll	$2,$17,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L33
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L31:
	la	$3,_move_prim+8
	andi	$4,$18,0xffff
	lw	$5,0($16)
	lw	$7,GEnv_drv
	or	$2,$2,$4
	sw	$2,4($3)
	sw	$5,0($3)
 #APP
 #NO_APP
	lw	$2,4($16)
	addu	$5,$3,-8
	sw	$2,8($3)
	lw	$4,24($7)
	li	$6,20			# 0x00000014
	lw	$2,8($7)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$7,$0
	.set	macro
	.set	reorder

$L33:
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

	.end	MoveImage
	.rdata
	.align	2
$LC12:
	.ascii	"ClearOTagR(%08x,%d)...\n\000"
	.text
	.align	2
	.globl	ClearOTagR
	.ent	ClearOTagR
ClearOTagR:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$16,$4
	lbu	$2,GEnv+2
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L35
	move	$17,$5
	.set	macro
	.set	reorder

	la	$4,$LC12
	move	$5,$16
	lw	$2,GPU_printf
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$6,$17
	.set	macro
	.set	reorder

$L35:
	lw	$2,GEnv_drv
	move	$4,$16
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$17
	.set	macro
	.set	reorder

	li	$6,16711680			# 0x00ff0000
	ori	$6,$6,0xffff
	move	$2,$16
	la	$5,_otc_link
	la	$3,_otc_term
	and	$3,$3,$6
	li	$4,67108864			# 0x04000000
	or	$3,$3,$4
	sw	$3,0($5)
	and	$5,$5,$6
	sw	$5,0($2)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	ClearOTagR
	.rdata
	.align	2
$LC13:
	.ascii	"DrawOTag(%08x)...\n\000"
	.text
	.align	2
	.globl	DrawOTag
	.ent	DrawOTag
DrawOTag:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
	lbu	$2,GEnv+2
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L37
	move	$16,$4
	.set	macro
	.set	reorder

	la	$4,$LC13
	lw	$2,GPU_printf
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$16
	.set	macro
	.set	reorder

$L37:
	lw	$2,GEnv_drv
	move	$5,$16
	lw	$4,24($2)
	move	$6,$0
	lw	$2,8($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$7,$6
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DrawOTag
	.rdata
	.align	2
$LC14:
	.ascii	"PutDrawEnv(%08x)...\n\000"
	.text
	.align	2
	.globl	PutDrawEnv
	.ent	PutDrawEnv
PutDrawEnv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	la	$18,GEnv+2
	lbu	$2,0($18)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L39
	move	$17,$4
	.set	macro
	.set	reorder

	la	$4,$LC14
	lw	$2,GPU_printf
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$17
	.set	macro
	.set	reorder

$L39:
	addu	$16,$17,28
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_set_drawenv
	move	$5,$17
	.set	macro
	.set	reorder

	li	$4,16711680			# 0x00ff0000
	ori	$4,$4,0xffff
	move	$5,$16
	li	$6,64			# 0x00000040
	lw	$2,28($17)
	lw	$3,GEnv_drv
	or	$2,$2,$4
	sw	$2,28($17)
	lw	$4,24($3)
	lw	$2,8($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$7,$0
	.set	macro
	.set	reorder

	addu	$4,$18,14
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	memcpy
	li	$6,92			# 0x0000005c
	.set	macro
	.set	reorder

	move	$2,$17
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

	.end	PutDrawEnv
	.rdata
	.align	2
$LC15:
	.ascii	"PutDispEnv(%08x)...\n\000"
	.text
	.align	2
	.globl	PutDispEnv
	.ent	PutDispEnv
PutDispEnv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$17,$4
	la	$18,GEnv+2
	lbu	$2,0($18)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L41
	li	$16,134217728			# 0x08000000
	.set	macro
	.set	reorder

	la	$4,$LC15
	lw	$2,GPU_printf
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$17
	.set	macro
	.set	reorder

$L41:
	lhu	$3,2($17)
	lw	$5,GEnv_drv
 #APP
 #NO_APP
	andi	$3,$3,0x03ff
	lhu	$4,0($17)
	sll	$3,$3,10
	andi	$4,$4,0x03ff
	li	$2,83886080			# 0x05000000
	or	$4,$4,$2
	lw	$2,16($5)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	or	$4,$3,$4
	.set	macro
	.set	reorder

	lw	$3,122($18)
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L43
	addu	$4,$18,106
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,106($18)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	lh	$3,0($17)
	sra	$2,$2,16
	bne	$2,$3,$L43
	#.set	volatile
	lhu	$2,2($4)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	lh	$3,2($17)
	sra	$2,$2,16
	bne	$2,$3,$L43
	#.set	volatile
	lhu	$2,4($4)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	lh	$3,4($17)
	sra	$2,$2,16
	bne	$2,$3,$L43
	#.set	volatile
	lhu	$2,6($4)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	lh	$3,6($17)
	sra	$2,$2,16
	beq	$2,$3,$L42
$L43:
	jal	GetVideoMode
	sb	$2,18($17)
	andi	$2,$2,0x00ff
	li	$3,1			# 0x00000001
	bne	$2,$3,$L44
	ori	$16,$16,0x0008
$L44:
	lbu	$2,17($17)
	#nop
	beq	$2,$0,$L45
	ori	$16,$16,0x0010
$L45:
	lbu	$2,16($17)
	#nop
	beq	$2,$0,$L46
	ori	$16,$16,0x0020
$L46:
	lbu	$2,GEnv+3
	#nop
	beq	$2,$0,$L47
	ori	$16,$16,0x0080
$L47:
	lh	$3,4($17)
	#nop
	slt	$2,$3,281
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L49
	slt	$2,$3,353
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L50
	slt	$2,$3,401
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L49
	ori	$16,$16,0x0001
	.set	macro
	.set	reorder

$L50:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L52
	slt	$2,$3,561
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L49
	ori	$16,$16,0x0040
	.set	macro
	.set	reorder

$L52:
	beq	$2,$0,$L54
	.set	noreorder
	.set	nomacro
	j	$L49
	ori	$16,$16,0x0002
	.set	macro
	.set	reorder

$L54:
	ori	$16,$16,0x0003
$L49:
	lbu	$2,18($17)
	lh	$3,6($17)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L57
	slt	$2,$3,289
	.set	macro
	.set	reorder

	slt	$2,$3,257
$L57:
	bne	$2,$0,$L59
	ori	$16,$16,0x0024
$L59:
	lw	$2,GEnv_drv
	#nop
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
	sb	$2,18($17)
$L42:
	la	$4,GEnv+116
	#.set	volatile
	lhu	$2,0($4)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	lh	$3,8($17)
	sra	$2,$2,16
	bne	$2,$3,$L60
	#.set	volatile
	lhu	$2,2($4)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	lh	$3,10($17)
	sra	$2,$2,16
	bne	$2,$3,$L60
	#.set	volatile
	lhu	$2,4($4)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	lh	$3,12($17)
	sra	$2,$2,16
	bne	$2,$3,$L60
	#.set	volatile
	lhu	$2,6($4)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	lh	$3,14($17)
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L60
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	lbu	$3,18($17)
	#nop
	bne	$3,$2,$L61
$L60:
	jal	GetVideoMode
	sb	$2,18($17)
	andi	$2,$2,0x00ff
	lh	$4,10($17)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L63
	addu	$16,$4,19
	.set	macro
	.set	reorder

	addu	$16,$4,16
$L63:
	lh	$2,14($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L65
	addu	$18,$16,$2
	.set	macro
	.set	reorder

	addu	$18,$16,240
$L65:
	lh	$3,4($17)
	#nop
	slt	$2,$3,281
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L66
	move	$6,$0
	.set	macro
	.set	reorder

	slt	$2,$3,353
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L66
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	slt	$2,$3,401
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L66
	li	$6,2			# 0x00000002
	.set	macro
	.set	reorder

	slt	$2,$3,561
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L66
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$6,3			# 0x00000003
$L66:
	lh	$3,8($17)
	lbu	$2,_disp_mult($6)
	#nop
	mult	$3,$2
	lbu	$3,18($17)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	addu	$2,$2,$6
	sll	$2,$2,2
	lhu	$3,_disp_overscan+2($2)
	lhu	$2,_disp_overscan($2)
	#nop
	subu	$3,$3,$2
	lh	$5,12($17)
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L67
	addu	$4,$2,$7
	.set	macro
	.set	reorder

	mult	$3,$5
	mflo	$7
	#nop
	#nop
	sra	$3,$7,8
$L67:
	#.set	volatile
	lbu	$2,18($17)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L68
	addu	$3,$4,$3
	.set	macro
	.set	reorder

	slt	$2,$4,540
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L69
	li	$5,540			# 0x0000021c
	.set	macro
	.set	reorder

	slt	$2,$4,3221
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L70
	li	$5,3220			# 0x00000c94
	.set	macro
	.set	reorder

	move	$5,$4
$L69:
$L70:
	lbu	$2,_disp_mult($6)
	move	$4,$5
	sll	$2,$2,2
	addu	$5,$4,$2
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L104
	slt	$2,$16,19
	.set	macro
	.set	reorder

	slt	$2,$3,3261
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L74
	li	$5,3260			# 0x00000cbc
	.set	macro
	.set	reorder

	move	$5,$3
$L74:
	slt	$2,$16,19
$L104:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L77
	move	$3,$5
	.set	macro
	.set	reorder

	slt	$2,$16,304
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L78
	li	$5,303			# 0x0000012f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L78
	move	$5,$16
	.set	macro
	.set	reorder

$L77:
	li	$5,19			# 0x00000013
$L78:
	move	$16,$5
	addu	$5,$16,2
	slt	$2,$18,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L99
	slt	$2,$18,306
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L103
	li	$5,305			# 0x00000131
	.set	macro
	.set	reorder

$L68:
	slt	$2,$4,500
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L86
	li	$5,500			# 0x000001f4
	.set	macro
	.set	reorder

	slt	$2,$4,3251
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L87
	li	$5,3250			# 0x00000cb2
	.set	macro
	.set	reorder

	move	$5,$4
$L86:
$L87:
	lbu	$2,_disp_mult($6)
	move	$4,$5
	sll	$2,$2,2
	addu	$5,$4,$2
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L105
	slt	$2,$16,16
	.set	macro
	.set	reorder

	slt	$2,$3,3291
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L91
	li	$5,3290			# 0x00000cda
	.set	macro
	.set	reorder

	move	$5,$3
$L91:
	slt	$2,$16,16
$L105:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L94
	move	$3,$5
	.set	macro
	.set	reorder

	slt	$2,$16,258
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L95
	li	$5,257			# 0x00000101
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L95
	move	$5,$16
	.set	macro
	.set	reorder

$L94:
	li	$5,16			# 0x00000010
$L95:
	move	$16,$5
	addu	$5,$16,2
	slt	$2,$18,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L99
	slt	$2,$18,259
	.set	macro
	.set	reorder

	li	$5,258			# 0x00000102
$L103:
	beq	$2,$0,$L99
	move	$5,$18
$L99:
	move	$18,$5
	andi	$2,$3,0x0fff
	sll	$2,$2,12
	andi	$4,$4,0x0fff
	li	$3,100663296			# 0x06000000
	lw	$5,GEnv_drv
	or	$4,$4,$3
	lw	$3,16($5)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	or	$4,$4,$2
	.set	macro
	.set	reorder

	andi	$2,$18,0x03ff
	sll	$2,$2,10
	andi	$4,$16,0x03ff
	li	$3,117440512			# 0x07000000
	lw	$5,GEnv_drv
	or	$4,$4,$3
	lw	$3,16($5)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	or	$4,$4,$2
	.set	macro
	.set	reorder

$L61:
	la	$4,GEnv+108
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	memcpy
	li	$6,20			# 0x00000014
	.set	macro
	.set	reorder

	move	$2,$17
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

	.end	PutDispEnv
	.align	2
	.globl	SetTexWindow
	.ent	SetTexWindow
SetTexWindow:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
	move	$16,$4
	li	$2,2			# 0x00000002
	sb	$2,3($16)
	.set	noreorder
	.set	nomacro
	jal	_get_tw
	move	$4,$5
	.set	macro
	.set	reorder

	sw	$2,4($16)
	sw	$0,8($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	SetTexWindow
	.align	2
	.globl	SetDrawArea
	.ent	SetDrawArea
SetDrawArea:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$17,$4
	move	$16,$5
	li	$2,2			# 0x00000002
	sb	$2,3($17)
	lh	$4,0($16)
	lh	$5,2($16)
	jal	_set_clip_tl
	sw	$2,4($17)
	lhu	$4,0($16)
	lhu	$2,4($16)
	#nop
	addu	$4,$4,$2
	addu	$4,$4,-1
	sll	$4,$4,16
	lhu	$5,2($16)
	lhu	$2,6($16)
	sra	$4,$4,16
	addu	$5,$5,$2
	addu	$5,$5,-1
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	_set_clip_br
	sra	$5,$5,16
	.set	macro
	.set	reorder

	sw	$2,8($17)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	SetDrawArea
	.align	2
	.globl	SetDrawStp
	.ent	SetDrawStp
SetDrawStp:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L109
	sb	$2,3($4)
	.set	macro
	.set	reorder

	li	$2,-436207616			# 0xe6000000
	.set	noreorder
	.set	nomacro
	j	$L111
	ori	$2,$2,0x0001
	.set	macro
	.set	reorder

$L109:
	li	$2,-436207616			# 0xe6000000
$L111:
	sw	$2,4($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,8($4)
	.set	macro
	.set	reorder

	.end	SetDrawStp
	.align	2
	.globl	SetDrawMode
	.ent	SetDrawMode
SetDrawMode:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$16,$4
	move	$4,$5
	lw	$17,48($sp)
	li	$2,2			# 0x00000002
	sb	$2,3($16)
	move	$5,$6
	.set	noreorder
	.set	nomacro
	jal	_set_draw_mode
	andi	$6,$7,0xffff
	.set	macro
	.set	reorder

	sw	$2,4($16)
	.set	noreorder
	.set	nomacro
	jal	_get_tw
	move	$4,$17
	.set	macro
	.set	reorder

	sw	$2,8($16)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	SetDrawMode
	.align	2
	.globl	SetDrawEnv
	.ent	SetDrawEnv
SetDrawEnv:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	move	$16,$5
	move	$17,$4
	lh	$4,0($16)
	lh	$5,2($16)
	jal	_set_clip_tl
	sw	$2,4($17)
	lhu	$4,4($16)
	lhu	$2,0($16)
	#nop
	addu	$4,$4,$2
	addu	$4,$4,-1
	sll	$4,$4,16
	lhu	$5,2($16)
	lhu	$2,6($16)
	sra	$4,$4,16
	addu	$5,$5,$2
	addu	$5,$5,-1
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	_set_clip_br
	sra	$5,$5,16
	.set	macro
	.set	reorder

	sw	$2,8($17)
	lh	$4,8($16)
	lh	$5,10($16)
	jal	_set_draw_offset
	sw	$2,12($17)
	lbu	$4,23($16)
	lbu	$5,22($16)
	lhu	$6,20($16)
	jal	_set_draw_mode
	addu	$4,$16,12
	.set	noreorder
	.set	nomacro
	jal	_get_tw
	sw	$2,16($17)
	.set	macro
	.set	reorder

	sw	$2,20($17)
	li	$2,-436207616			# 0xe6000000
	sw	$2,24($17)
	lbu	$2,24($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L114
	li	$8,7			# 0x00000007
	.set	macro
	.set	reorder

	lhu	$2,0($16)
	#nop
	sh	$2,16($sp)
	lhu	$2,2($16)
	#nop
	sh	$2,18($sp)
	lhu	$4,4($16)
	#nop
	sh	$4,20($sp)
	lhu	$2,6($16)
	#nop
	sh	$2,22($sp)
	sll	$2,$4,16
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	bltz	$3,$L115
	move	$2,$0
	.set	macro
	.set	reorder

	lh	$2,GEnv+4
	#nop
	addu	$2,$2,-1
	slt	$2,$2,$3
	lhu	$3,GEnv+4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L118
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	move	$2,$4
$L115:
$L118:
	sh	$2,20($sp)
	lh	$3,22($sp)
	lhu	$4,22($sp)
	.set	noreorder
	.set	nomacro
	bltz	$3,$L119
	move	$2,$0
	.set	macro
	.set	reorder

	lh	$2,GEnv+6
	#nop
	addu	$2,$2,-1
	slt	$2,$2,$3
	lhu	$3,GEnv+6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L122
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	move	$2,$4
$L119:
$L122:
	sll	$6,$8,2
	addu	$8,$8,1
	sll	$7,$8,2
	addu	$8,$8,1
	sh	$2,22($sp)
	lhu	$2,16($sp)
	lhu	$3,8($16)
	sll	$5,$8,2
	subu	$2,$2,$3
	sh	$2,16($sp)
	lhu	$2,18($sp)
	lhu	$3,10($16)
	addu	$8,$8,1
	subu	$2,$2,$3
	sh	$2,18($sp)
	addu	$6,$6,$17
	lbu	$2,27($16)
	lbu	$3,26($16)
	sll	$2,$2,16
	sll	$3,$3,8
	li	$4,1610612736			# 0x60000000
	or	$3,$3,$4
	lbu	$4,25($16)
	or	$2,$2,$3
	or	$2,$2,$4
	sw	$2,0($6)
	lw	$2,16($sp)
	addu	$7,$7,$17
	sw	$2,0($7)
	lw	$2,20($sp)
	addu	$5,$5,$17
	sw	$2,0($5)
$L114:
	addu	$2,$8,-1
	sb	$2,3($17)
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	SetDrawEnv
	.align	2
	.globl	_set_drawenv
	.ent	_set_drawenv
_set_drawenv:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	move	$16,$5
	move	$17,$4
	lh	$4,0($16)
	lh	$5,2($16)
	jal	_set_clip_tl
	sw	$2,4($17)
	lhu	$4,4($16)
	lhu	$2,0($16)
	#nop
	addu	$4,$4,$2
	addu	$4,$4,-1
	sll	$4,$4,16
	lhu	$5,2($16)
	lhu	$2,6($16)
	sra	$4,$4,16
	addu	$5,$5,$2
	addu	$5,$5,-1
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	_set_clip_br
	sra	$5,$5,16
	.set	macro
	.set	reorder

	sw	$2,8($17)
	lh	$4,8($16)
	lh	$5,10($16)
	jal	_set_draw_offset
	sw	$2,12($17)
	lbu	$4,23($16)
	lbu	$5,22($16)
	lhu	$6,20($16)
	jal	_set_draw_mode
	addu	$4,$16,12
	.set	noreorder
	.set	nomacro
	jal	_get_tw
	sw	$2,16($17)
	.set	macro
	.set	reorder

	sw	$2,20($17)
	li	$2,-436207616			# 0xe6000000
	sw	$2,24($17)
	lbu	$2,24($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L124
	li	$8,7			# 0x00000007
	.set	macro
	.set	reorder

	lhu	$2,0($16)
	#nop
	sh	$2,16($sp)
	lhu	$2,2($16)
	#nop
	sh	$2,18($sp)
	lhu	$4,4($16)
	#nop
	sh	$4,20($sp)
	lhu	$2,6($16)
	#nop
	sh	$2,22($sp)
	sll	$2,$4,16
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	bltz	$3,$L125
	move	$2,$0
	.set	macro
	.set	reorder

	lh	$2,GEnv+4
	#nop
	addu	$2,$2,-1
	slt	$2,$2,$3
	lhu	$3,GEnv+4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L128
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	move	$2,$4
$L125:
$L128:
	sh	$2,20($sp)
	lh	$3,22($sp)
	lhu	$4,22($sp)
	.set	noreorder
	.set	nomacro
	bltz	$3,$L129
	move	$2,$0
	.set	macro
	.set	reorder

	lh	$2,GEnv+6
	#nop
	addu	$2,$2,-1
	slt	$2,$2,$3
	lhu	$3,GEnv+6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L132
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	move	$2,$4
$L129:
$L132:
	lhu	$3,16($sp)
	sh	$2,22($sp)
	andi	$2,$3,0x003f
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L136
	sll	$6,$8,2
	.set	macro
	.set	reorder

	lhu	$2,20($sp)
	#nop
	andi	$2,$2,0x003f
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L133
	sll	$5,$8,2
	.set	macro
	.set	reorder

$L136:
	addu	$8,$8,1
	lhu	$2,8($16)
	sll	$7,$8,2
	addu	$8,$8,1
	subu	$2,$3,$2
	sh	$2,16($sp)
	lhu	$2,18($sp)
	lhu	$3,10($16)
	sll	$5,$8,2
	addu	$8,$8,1
	subu	$2,$2,$3
	sh	$2,18($sp)
	addu	$6,$6,$17
	lbu	$2,27($16)
	lbu	$3,26($16)
	sll	$2,$2,16
	sll	$3,$3,8
	li	$4,1610612736			# 0x60000000
	or	$3,$3,$4
	lbu	$4,25($16)
	or	$2,$2,$3
	or	$2,$2,$4
	sw	$2,0($6)
	lw	$2,16($sp)
	addu	$7,$7,$17
	sw	$2,0($7)
	lw	$2,20($sp)
	addu	$5,$5,$17
	.set	noreorder
	.set	nomacro
	j	$L124
	sw	$2,0($5)
	.set	macro
	.set	reorder

$L133:
	addu	$8,$8,1
	sll	$6,$8,2
	addu	$8,$8,1
	sll	$7,$8,2
	addu	$8,$8,1
	addu	$5,$5,$17
	lbu	$2,27($16)
	lbu	$3,26($16)
	sll	$2,$2,16
	sll	$3,$3,8
	li	$4,33554432			# 0x02000000
	or	$3,$3,$4
	lbu	$4,25($16)
	or	$2,$2,$3
	or	$2,$2,$4
	sw	$2,0($5)
	lw	$2,16($sp)
	addu	$6,$6,$17
	sw	$2,0($6)
	lw	$2,20($sp)
	addu	$7,$7,$17
	sw	$2,0($7)
$L124:
	addu	$2,$8,-1
	sb	$2,3($17)
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	_set_drawenv
	.align	2
	.globl	_set_draw_mode
	.ent	_set_draw_mode
_set_draw_mode:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L138
	li	$3,-520093696			# 0xe1000000
	.set	macro
	.set	reorder

	ori	$3,$3,0x0200
$L138:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L139
	andi	$2,$6,0x09ff
	.set	macro
	.set	reorder

	ori	$2,$2,0x0400
$L139:
	.set	noreorder
	.set	nomacro
	j	$31
	or	$2,$2,$3
	.set	macro
	.set	reorder

	.end	_set_draw_mode
	.align	2
	.globl	_set_clip_tl
	.ent	_set_clip_tl
_set_clip_tl:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$2,$4,16
	sra	$6,$2,16
	.set	noreorder
	.set	nomacro
	bltz	$6,$L141
	move	$2,$0
	.set	macro
	.set	reorder

	lh	$2,GEnv+4
	#nop
	addu	$2,$2,-1
	slt	$2,$2,$6
	lhu	$6,GEnv+4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L142
	addu	$2,$6,-1
	.set	macro
	.set	reorder

	move	$2,$4
$L141:
$L142:
	move	$4,$2
	sll	$2,$5,16
	sra	$6,$2,16
	bltz	$6,$L145
	lh	$2,GEnv+6
	#nop
	addu	$2,$2,-1
	slt	$2,$2,$6
	lhu	$6,GEnv+6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L149
	andi	$3,$5,0x03ff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L146
	addu	$5,$6,-1
	.set	macro
	.set	reorder

$L145:
	move	$5,$0
$L146:
	andi	$3,$5,0x03ff
$L149:
	sll	$3,$3,10
	andi	$2,$4,0x03ff
	li	$4,-486539264			# 0xe3000000
	or	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	or	$2,$3,$2
	.set	macro
	.set	reorder

	.end	_set_clip_tl
	.align	2
	.globl	_set_clip_br
	.ent	_set_clip_br
_set_clip_br:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$2,$4,16
	sra	$6,$2,16
	.set	noreorder
	.set	nomacro
	bltz	$6,$L151
	move	$2,$0
	.set	macro
	.set	reorder

	lh	$2,GEnv+4
	#nop
	addu	$2,$2,-1
	slt	$2,$2,$6
	lhu	$6,GEnv+4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L152
	addu	$2,$6,-1
	.set	macro
	.set	reorder

	move	$2,$4
$L151:
$L152:
	move	$4,$2
	sll	$2,$5,16
	sra	$6,$2,16
	bltz	$6,$L155
	lh	$2,GEnv+6
	#nop
	addu	$2,$2,-1
	slt	$2,$2,$6
	lhu	$6,GEnv+6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L159
	andi	$3,$5,0x03ff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L156
	addu	$5,$6,-1
	.set	macro
	.set	reorder

$L155:
	move	$5,$0
$L156:
	andi	$3,$5,0x03ff
$L159:
	sll	$3,$3,10
	andi	$2,$4,0x03ff
	li	$4,-469762048			# 0xe4000000
	or	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	or	$2,$3,$2
	.set	macro
	.set	reorder

	.end	_set_clip_br
	.align	2
	.globl	_set_draw_offset
	.ent	_set_draw_offset
_set_draw_offset:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	andi	$5,$5,0x07ff
	sll	$5,$5,11
	andi	$2,$4,0x07ff
	li	$3,-452984832			# 0xe5000000
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	or	$2,$5,$2
	.set	macro
	.set	reorder

	.end	_set_draw_offset
	.align	2
	.globl	_get_tw
	.ent	_get_tw
_get_tw:
	.frame	$sp,16,$31		# vars= 16, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L162
	subu	$sp,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L163
	move	$2,$0
	.set	macro
	.set	reorder

$L162:
	lbu	$5,0($4)
	#nop
	srl	$5,$5,3
	sw	$5,0($sp)
	lh	$6,4($4)
	#nop
	subu	$6,$0,$6
	andi	$6,$6,0x00ff
	sra	$6,$6,3
	sw	$6,8($sp)
	lbu	$2,2($4)
	#nop
	srl	$2,$2,3
	sw	$2,4($sp)
	lh	$3,6($4)
	#nop
	subu	$3,$0,$3
	andi	$3,$3,0x00ff
	sra	$3,$3,3
	sll	$2,$2,15
	sll	$5,$5,10
	li	$4,-503316480			# 0xe2000000
	or	$5,$5,$4
	or	$2,$2,$5
	sll	$4,$3,5
	or	$2,$2,$4
	or	$2,$2,$6
	sw	$3,12($sp)
$L163:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,16
	.set	macro
	.set	reorder

	.end	_get_tw
	.align	2
	.globl	_get_status
	.ent	_get_status
_get_status:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,GPU_GP1
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	j	$31
	.end	_get_status
	.align	2
	.globl	_clearOTagR_dma
	.ent	_clearOTagR_dma
_clearOTagR_dma:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$16,$5
	lw	$5,DMA_DPCR
	#nop
	#.set	volatile
	lw	$2,0($5)
	#.set	novolatile
	li	$3,134217728			# 0x08000000
	or	$2,$2,$3
	#.set	volatile
	sw	$2,0($5)
	#.set	novolatile
	lw	$2,D6_CHCR
	#nop
	#.set	volatile
	sw	$0,0($2)
	#.set	novolatile
	sll	$2,$16,2
	addu	$2,$2,-4
	lw	$3,D6_MADR
	addu	$4,$4,$2
	#.set	volatile
	sw	$4,0($3)
	#.set	novolatile
	lw	$2,D6_BCR
	li	$3,285212672			# 0x11000000
	#.set	volatile
	sw	$16,0($2)
	#.set	novolatile
	lw	$2,D6_CHCR
	ori	$3,$3,0x0002
	#.set	volatile
	sw	$3,0($2)
	#.set	novolatile
	jal	_gpu_arm_timeout
	lw	$2,D6_CHCR
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,16777216			# 0x01000000
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L173
	li	$17,16777216			# 0x01000000
	.set	macro
	.set	reorder

$L167:
	jal	_gpu_check_timeout
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L169
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$2,D6_CHCR
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	and	$2,$2,$17
	bne	$2,$0,$L167
$L173:
	move	$2,$16
$L169:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	_clearOTagR_dma
	.align	2
	.globl	_BlitClear
	.ent	_BlitClear
_BlitClear:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$8,$4
	lh	$3,4($8)
	lhu	$4,4($8)
	.set	noreorder
	.set	nomacro
	bltz	$3,$L175
	move	$9,$5
	.set	macro
	.set	reorder

	lh	$2,GEnv+4
	#nop
	addu	$2,$2,-1
	slt	$2,$2,$3
	lhu	$3,GEnv+4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L186
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L176
	move	$2,$4
	.set	macro
	.set	reorder

$L175:
	move	$2,$0
$L176:
$L186:
	sh	$2,4($8)
	lh	$3,6($8)
	lhu	$4,6($8)
	bltz	$3,$L179
	lh	$2,GEnv+6
	#nop
	addu	$2,$2,-1
	slt	$2,$2,$3
	lhu	$3,GEnv+6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L180
	addu	$3,$3,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L180
	move	$3,$4
	.set	macro
	.set	reorder

$L179:
	move	$3,$0
$L180:
	lhu	$2,0($8)
	#nop
	andi	$2,$2,0x003f
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L184
	sh	$3,6($8)
	.set	macro
	.set	reorder

	lhu	$2,4($8)
	#nop
	andi	$2,$2,0x003f
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L183
	li	$2,100597760			# 0x05ff0000
	.set	macro
	.set	reorder

$L184:
	li	$6,16711680			# 0x00ff0000
	ori	$6,$6,0xffff
	li	$4,-453050368			# 0xe4ff0000
	ori	$4,$4,0xffff
	li	$7,67043328			# 0x03ff0000
	la	$5,_blit_buf
	la	$16,D_8013EAD8
	and	$2,$16,$6
	li	$3,134217728			# 0x08000000
	or	$2,$2,$3
	sw	$2,0($5)
	li	$17,-486539264			# 0xe3000000
	sw	$17,4($5)
	sw	$4,8($5)
	li	$18,-452984832			# 0xe5000000
	sw	$18,12($5)
	li	$2,-436207616			# 0xe6000000
	sw	$2,16($5)
	and	$6,$9,$6
	lw	$2,GPU_GP1
	li	$3,1610612736			# 0x60000000
	#.set	volatile
	lw	$4,0($2)
	#.set	novolatile
	or	$6,$6,$3
	sw	$6,24($5)
	andi	$4,$4,0x07ff
	srl	$2,$9,31
	sll	$2,$2,10
	li	$3,-520093696			# 0xe1000000
	or	$2,$2,$3
	or	$4,$4,$2
	sw	$4,20($5)
	lw	$2,0($8)
	ori	$7,$7,0xffff
	sw	$2,28($5)
	lw	$2,4($8)
	li	$4,3			# 0x00000003
	sw	$7,0($16)
	.set	noreorder
	.set	nomacro
	jal	_get_gpuinfo
	sw	$2,32($5)
	.set	macro
	.set	reorder

	li	$4,4			# 0x00000004
	or	$2,$2,$17
	.set	noreorder
	.set	nomacro
	jal	_get_gpuinfo
	sw	$2,4($16)
	.set	macro
	.set	reorder

	li	$4,5			# 0x00000005
	li	$3,-469762048			# 0xe4000000
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	_get_gpuinfo
	sw	$2,8($16)
	.set	macro
	.set	reorder

	or	$2,$2,$18
	.set	noreorder
	.set	nomacro
	j	$L185
	sw	$2,12($16)
	.set	macro
	.set	reorder

$L183:
	ori	$2,$2,0xffff
	li	$3,16711680			# 0x00ff0000
	ori	$3,$3,0xffff
	la	$4,_blit_buf
 #APP
 #NO_APP
	sw	$2,0($4)
	li	$2,-436207616			# 0xe6000000
	sw	$2,4($4)
	and	$3,$9,$3
	lw	$2,GPU_GP1
	li	$6,33554432			# 0x02000000
	#.set	volatile
	lw	$5,0($2)
	#.set	novolatile
	or	$3,$3,$6
	sw	$3,12($4)
	andi	$5,$5,0x07ff
	srl	$2,$9,31
	sll	$2,$2,10
	li	$3,-520093696			# 0xe1000000
	or	$2,$2,$3
	or	$5,$5,$2
	sw	$5,8($4)
	lw	$2,0($8)
	#nop
	sw	$2,16($4)
	lw	$2,4($8)
	#nop
	sw	$2,20($4)
$L185:
	la	$4,_blit_buf
	jal	_gpu_dma_chain
	move	$2,$0
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

	.end	_BlitClear
	.align	2
	.globl	_dws
	.ent	_dws
_dws:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$18,$5
	.set	noreorder
	.set	nomacro
	jal	_gpu_arm_timeout
	move	$17,$4
	.set	macro
	.set	reorder

	lh	$5,4($17)
	lhu	$3,4($17)
	.set	noreorder
	.set	nomacro
	bltz	$5,$L188
	move	$21,$0
	.set	macro
	.set	reorder

	lh	$2,GEnv+4
	move	$4,$3
	slt	$2,$2,$5
	lhu	$3,GEnv+4
	beq	$2,$0,$L189
	.set	noreorder
	.set	nomacro
	j	$L189
	move	$4,$3
	.set	macro
	.set	reorder

$L188:
	move	$4,$0
$L189:
	sh	$4,4($17)
	lh	$5,6($17)
	lhu	$3,6($17)
	.set	noreorder
	.set	nomacro
	bltz	$5,$L191
	move	$4,$3
	.set	macro
	.set	reorder

	lh	$2,GEnv+6
	#nop
	slt	$2,$2,$5
	lhu	$3,GEnv+6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L212
	sll	$2,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L192
	move	$4,$3
	.set	macro
	.set	reorder

$L191:
	move	$4,$0
$L192:
	sll	$2,$4,16
$L212:
	lh	$3,4($17)
	sra	$2,$2,16
	mult	$3,$2
	sh	$4,6($17)
	mflo	$6
	#nop
	#nop
	addu	$3,$6,1
	srl	$2,$3,31
	addu	$3,$3,$2
	sra	$4,$3,1
	.set	noreorder
	.set	nomacro
	bgtz	$4,$L194
	sra	$16,$3,5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L209
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L194:
 #APP
 #NO_APP
	move	$3,$16
	sll	$2,$3,4
	subu	$16,$4,$2
	lw	$2,GPU_GP1
	move	$20,$3
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,67108864			# 0x04000000
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L213
	li	$4,-1610612736			# 0xa0000000
	.set	macro
	.set	reorder

	move	$19,$3
$L196:
	jal	_gpu_check_timeout
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L209
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$2,GPU_GP1
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	and	$2,$2,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L196
	li	$4,-1610612736			# 0xa0000000
	.set	macro
	.set	reorder

$L213:
	lw	$3,GPU_GP1
	li	$2,67108864			# 0x04000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,GPU_GP0
	li	$2,16777216			# 0x01000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,GPU_GP0
	beq	$21,$0,$L201
	li	$4,-1342177280			# 0xb0000000
$L201:
	#.set	volatile
	sw	$4,0($2)
	#.set	novolatile
	lw	$3,GPU_GP0
	lw	$2,0($17)
	#nop
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,GPU_GP0
	lw	$2,4($17)
	addu	$16,$16,-1
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	li	$2,-1			# 0xffffffff
	beq	$16,$2,$L203
	move	$4,$2
$L204:
	lw	$3,0($18)
	addu	$18,$18,4
	lw	$2,GPU_GP0
	addu	$16,$16,-1
	#.set	volatile
	sw	$3,0($2)
	#.set	novolatile
	bne	$16,$4,$L204
$L203:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L208
	li	$3,67108864			# 0x04000000
	.set	macro
	.set	reorder

	lw	$2,GPU_GP1
	ori	$3,$3,0x0002
	#.set	volatile
	sw	$3,0($2)
	#.set	novolatile
	lw	$2,D2_MADR
	li	$4,16777216			# 0x01000000
	#.set	volatile
	sw	$18,0($2)
	#.set	novolatile
	sll	$2,$20,16
	lw	$3,D2_BCR
	ori	$2,$2,0x0010
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,D2_CHCR
	ori	$4,$4,0x0201
	#.set	volatile
	sw	$4,0($2)
	#.set	novolatile
$L208:
	move	$2,$0
$L209:
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	_dws
	.align	2
	.globl	_drs
	.ent	_drs
_drs:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$18,$5
	.set	noreorder
	.set	nomacro
	jal	_gpu_arm_timeout
	move	$17,$4
	.set	macro
	.set	reorder

	lh	$5,4($17)
	lhu	$3,4($17)
	.set	noreorder
	.set	nomacro
	bltz	$5,$L215
	move	$4,$3
	.set	macro
	.set	reorder

	lh	$2,GEnv+4
	#nop
	slt	$2,$2,$5
	lhu	$3,GEnv+4
	beq	$2,$0,$L216
	.set	noreorder
	.set	nomacro
	j	$L216
	move	$4,$3
	.set	macro
	.set	reorder

$L215:
	move	$4,$0
$L216:
	sh	$4,4($17)
	lh	$5,6($17)
	lhu	$3,6($17)
	.set	noreorder
	.set	nomacro
	bltz	$5,$L218
	move	$4,$3
	.set	macro
	.set	reorder

	lh	$2,GEnv+6
	#nop
	slt	$2,$2,$5
	lhu	$3,GEnv+6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L244
	sll	$2,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L219
	move	$4,$3
	.set	macro
	.set	reorder

$L218:
	move	$4,$0
$L219:
	sll	$2,$4,16
$L244:
	lh	$3,4($17)
	sra	$2,$2,16
	mult	$3,$2
	sh	$4,6($17)
	mflo	$6
	#nop
	#nop
	addu	$3,$6,1
	srl	$2,$3,31
	addu	$3,$3,$2
	sra	$4,$3,1
	.set	noreorder
	.set	nomacro
	bgtz	$4,$L221
	sra	$16,$3,5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L240
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L221:
 #APP
 #NO_APP
	move	$3,$16
	sll	$2,$3,4
	subu	$16,$4,$2
	lw	$2,GPU_GP1
	move	$20,$3
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,67108864			# 0x04000000
	and	$2,$2,$3
	bne	$2,$0,$L222
	move	$19,$3
$L223:
	jal	_gpu_check_timeout
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L240
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$2,GPU_GP1
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	and	$2,$2,$19
	beq	$2,$0,$L223
$L222:
	lw	$3,GPU_GP1
	li	$2,67108864			# 0x04000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,GPU_GP0
	li	$2,16777216			# 0x01000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,GPU_GP0
	li	$2,-1073741824			# 0xc0000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,GPU_GP0
	lw	$2,0($17)
	#nop
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,GPU_GP0
	lw	$2,4($17)
	#nop
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,GPU_GP1
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,134217728			# 0x08000000
	and	$2,$2,$3
	bne	$2,$0,$L228
	move	$17,$3
$L229:
	jal	_gpu_check_timeout
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L240
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$2,GPU_GP1
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	and	$2,$2,$17
	beq	$2,$0,$L229
$L228:
	addu	$16,$16,-1
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L234
	move	$3,$2
	.set	macro
	.set	reorder

$L235:
	lw	$2,GPU_GP0
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	addu	$16,$16,-1
	sw	$2,0($18)
	.set	noreorder
	.set	nomacro
	bne	$16,$3,$L235
	addu	$18,$18,4
	.set	macro
	.set	reorder

$L234:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L239
	li	$3,67108864			# 0x04000000
	.set	macro
	.set	reorder

	lw	$2,GPU_GP1
	ori	$3,$3,0x0003
	#.set	volatile
	sw	$3,0($2)
	#.set	novolatile
	lw	$2,D2_MADR
	li	$4,16777216			# 0x01000000
	#.set	volatile
	sw	$18,0($2)
	#.set	novolatile
	sll	$2,$20,16
	lw	$3,D2_BCR
	ori	$2,$2,0x0010
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,D2_CHCR
	ori	$4,$4,0x0200
	#.set	volatile
	sw	$4,0($2)
	#.set	novolatile
$L239:
	move	$2,$0
$L240:
	lw	$31,36($sp)
	lw	$20,32($sp)
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

	.end	_drs
	.align	2
	.globl	_send_gp1
	.ent	_send_gp1
_send_gp1:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,GPU_GP1
	#nop
	#.set	volatile
	sw	$4,0($2)
	#.set	novolatile
	srl	$2,$4,24
	sb	$4,_gp1_shadow($2)
	j	$31
	.end	_send_gp1
	.align	2
	.globl	_get_gp1
	.ent	_get_gp1
_get_gp1:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,_gp1_shadow($4)
	j	$31
	.end	_get_gp1
	.align	2
	.globl	_send_gp0
	.ent	_send_gp0
_send_gp0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$6,$5,-1
	lw	$3,GPU_GP1
	li	$2,67108864			# 0x04000000
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L248
	sw	$2,0($3)
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
$L249:
	lw	$3,0($4)
	addu	$4,$4,4
	lw	$2,GPU_GP0
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bne	$6,$5,$L249
	sw	$3,0($2)
	.set	macro
	.set	reorder

$L248:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	_send_gp0
	.align	2
	.globl	_gpu_dma_chain
	.ent	_gpu_dma_chain
_gpu_dma_chain:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,67108864			# 0x04000000
	lw	$2,GPU_GP1
	ori	$3,$3,0x0002
	#.set	volatile
	sw	$3,0($2)
	#.set	novolatile
	lw	$2,D2_MADR
	#nop
	#.set	volatile
	sw	$4,0($2)
	#.set	novolatile
	lw	$2,D2_BCR
	li	$3,16777216			# 0x01000000
	#.set	volatile
	sw	$0,0($2)
	#.set	novolatile
	lw	$2,D2_CHCR
	ori	$3,$3,0x0401
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,0($2)
	.set	macro
	.set	reorder

	.end	_gpu_dma_chain
	.align	2
	.globl	_get_gpuinfo
	.ent	_get_gpuinfo
_get_gpuinfo:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,268435456			# 0x10000000
	lw	$3,GPU_GP1
	or	$4,$4,$2
	#.set	volatile
	sw	$4,0($3)
	#.set	novolatile
	lw	$2,GPU_GP0
	li	$3,16711680			# 0x00ff0000
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	ori	$3,$3,0xffff
	.set	noreorder
	.set	nomacro
	j	$31
	and	$2,$2,$3
	.set	macro
	.set	reorder

	.end	_get_gpuinfo
	.align	2
	.globl	_que_ref
	.ent	_que_ref
_que_ref:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	move	$7,$6
	.set	noreorder
	.set	nomacro
	jal	_gpu_que_push
	move	$6,$0
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

	.end	_que_ref
	.align	2
	.globl	_gpu_que_push
	.ent	_gpu_que_push
_gpu_que_push:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$19,$4
	move	$16,$5
	move	$17,$6
	.set	noreorder
	.set	nomacro
	jal	_gpu_arm_timeout
	move	$18,$7
	.set	macro
	.set	reorder

	j	$L280
$L259:
	jal	_gpu_check_timeout
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L278
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	jal	_gpu_que_drain
$L280:
	#.set	volatile
	lw	$2,_qin
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	lw	$3,_qout
	#.set	novolatile
	andi	$2,$2,0x003f
	beq	$2,$3,$L259
	.set	noreorder
	.set	nomacro
	jal	SetIntrMask
	move	$4,$0
	.set	macro
	.set	reorder

	sw	$2,_q_saved_mask
	la	$4,GEnv
 #APP
 #NO_APP
	lbu	$3,1($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L264
	sw	$2,8($4)
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$3,_qin
	#.set	novolatile
	#.set	volatile
	lw	$2,_qout
	#.set	novolatile
	#nop
	bne	$3,$2,$L262
	lw	$2,D2_CHCR
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,16777216			# 0x01000000
	and	$2,$2,$3
	bne	$2,$0,$L262
	lw	$2,12($4)
	#nop
	bne	$2,$0,$L262
$L264:
	lw	$3,GPU_GP1
	li	$4,67108864			# 0x04000000
$L269:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	and	$2,$2,$4
	beq	$2,$0,$L269
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	$31,$19
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,_q_saved_mask
	jal	SetIntrMask
	.set	noreorder
	.set	nomacro
	j	$L278
	move	$2,$0
	.set	macro
	.set	reorder

$L262:
	la	$5,_gpu_que_drain
	.set	noreorder
	.set	nomacro
	jal	DMACallback
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L272
	move	$6,$0
	.set	macro
	.set	reorder

	la	$8,_que+12
	move	$7,$16
	move	$2,$17
$L281:
	bgez	$2,$L276
	addu	$2,$2,3
$L276:
	sra	$2,$2,2
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L274
	sll	$4,$6,2
	.set	macro
	.set	reorder

	lw	$5,0($7)
	addu	$7,$7,4
	#.set	volatile
	lw	$3,_qin
	#.set	novolatile
	addu	$6,$6,1
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,5
	addu	$2,$2,$8
	addu	$4,$4,$2
	#.set	volatile
	sw	$5,0($4)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L281
	move	$2,$17
	.set	macro
	.set	reorder

$L274:
	#.set	volatile
	lw	$2,_qin
	#.set	novolatile
	#nop
	sll	$4,$2,1
	addu	$4,$4,$2
	#.set	volatile
	lw	$3,_qin
	#.set	novolatile
	sll	$4,$4,5
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,5
	la	$3,_que+12
	addu	$2,$2,$3
	#.set	volatile
	sw	$2,_que+4($4)
	#.set	novolatile
	j	$L277
$L272:
	#.set	volatile
	lw	$3,_qin
	#.set	novolatile
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,5
	#.set	volatile
	sw	$16,_que+4($2)
	#.set	novolatile
$L277:
	#.set	volatile
	lw	$3,_qin
	#.set	novolatile
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,5
	#.set	volatile
	sw	$18,_que+8($2)
	#.set	novolatile
	#.set	volatile
	lw	$3,_qin
	#.set	novolatile
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,5
	#.set	volatile
	sw	$19,_que($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,_qin
	#.set	novolatile
	lw	$4,_q_saved_mask
	addu	$2,$2,1
	andi	$2,$2,0x003f
	#.set	volatile
	sw	$2,_qin
	#.set	novolatile
	jal	SetIntrMask
	jal	_gpu_que_drain
	#.set	volatile
	lw	$2,_qin
	#.set	novolatile
	#.set	volatile
	lw	$3,_qout
	#.set	novolatile
	#nop
	subu	$2,$2,$3
	andi	$2,$2,0x003f
$L278:
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

	.end	_gpu_que_push
	.align	2
	.globl	_gpu_que_drain
	.ent	_gpu_que_drain
_gpu_que_drain:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,D2_CHCR
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$16,16777216			# 0x01000000
	and	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L299
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetIntrMask
	move	$4,$0
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$4,_qin
	#.set	novolatile
	#.set	volatile
	lw	$3,_qout
	#.set	novolatile
	sw	$2,_drain_saved_mask
	beq	$4,$3,$L284
	lw	$2,D2_CHCR
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	and	$2,$2,$16
	bne	$2,$0,$L284
	li	$17,67108864			# 0x04000000
	li	$16,16777216			# 0x01000000
$L285:
	#.set	volatile
	lw	$2,_qout
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	lw	$3,_qin
	#.set	novolatile
	andi	$2,$2,0x003f
	bne	$2,$3,$L288
	lw	$2,GEnv+12
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L288
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DMACallback
	move	$5,$0
	.set	macro
	.set	reorder

$L288:
	lw	$3,GPU_GP1
	#nop
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	and	$2,$2,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L289
	li	$4,67108864			# 0x04000000
	.set	macro
	.set	reorder

$L292:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	and	$2,$2,$4
	beq	$2,$0,$L292
$L289:
	#.set	volatile
	lw	$5,_qout
	#.set	novolatile
	#.set	volatile
	lw	$3,_qout
	#.set	novolatile
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,5
	lw	$4,_que+4($2)
	sll	$2,$5,1
	addu	$2,$2,$5
	sll	$2,$2,5
	#.set	volatile
	lw	$3,_qout
	#.set	novolatile
	lw	$5,_que+8($2)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,5
	lw	$2,_que($2)
	#nop
	jal	$31,$2
	#.set	volatile
	lw	$2,_qout
	#.set	novolatile
	#nop
	addu	$2,$2,1
	andi	$2,$2,0x003f
	#.set	volatile
	sw	$2,_qout
	#.set	novolatile
	#.set	volatile
	lw	$3,_qin
	#.set	novolatile
	#.set	volatile
	lw	$2,_qout
	#.set	novolatile
	#nop
	beq	$3,$2,$L284
	lw	$2,D2_CHCR
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	and	$2,$2,$16
	beq	$2,$0,$L285
$L284:
	lw	$4,_drain_saved_mask
	jal	SetIntrMask
	#.set	volatile
	lw	$3,_qin
	#.set	novolatile
	#.set	volatile
	lw	$2,_qout
	#.set	novolatile
	#nop
	bne	$3,$2,$L296
	lw	$2,D2_CHCR
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,16777216			# 0x01000000
	and	$2,$2,$3
	bne	$2,$0,$L296
	la	$3,GEnv+8
	lw	$2,0($3)
	#nop
	beq	$2,$0,$L296
	lw	$4,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L296
	addu	$2,$3,-8
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$0,8($2)
	#.set	novolatile
	jal	$31,$4
$L296:
	#.set	volatile
	lw	$2,_qin
	#.set	novolatile
	#.set	volatile
	lw	$3,_qout
	#.set	novolatile
	#nop
	subu	$2,$2,$3
	andi	$2,$2,0x003f
$L299:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	_gpu_que_drain
	.align	2
	.globl	_reset
	.ent	_reset
_reset:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	jal	SetIntrMask
	move	$4,$0
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$0,_qout
	#.set	novolatile
	#.set	volatile
	lw	$3,_qout
	#.set	novolatile
	sw	$2,_q_reset_mask
	#.set	volatile
	sw	$3,_qin
	#.set	novolatile
	andi	$3,$16,0x0007
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L305
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L308
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	beq	$3,$0,$L303
	j	$L301
$L308:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L305
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$3,$2,$L301
$L303:
	lw	$3,D2_CHCR
	li	$2,1025			# 0x00000401
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,DMA_DPCR
	la	$4,_gp1_shadow
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	move	$5,$0
	ori	$2,$2,0x0800
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,GPU_GP1
	li	$6,256			# 0x00000100
	#.set	volatile
	sw	$0,0($2)
	#.set	novolatile
	jal	_memset
	la	$4,_que
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	_memset
	li	$6,6144			# 0x00001800
	.set	macro
	.set	reorder

	j	$L301
$L305:
	lw	$3,D2_CHCR
	li	$2,1025			# 0x00000401
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,DMA_DPCR
	#nop
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	ori	$2,$2,0x0800
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,GPU_GP1
	li	$2,33554432			# 0x02000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,GPU_GP1
	li	$2,16777216			# 0x01000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
$L301:
	lw	$4,_q_reset_mask
	jal	SetIntrMask
	andi	$2,$16,0x0007
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L310
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	_gpu_init_videomode
	move	$4,$16
	.set	macro
	.set	reorder

$L310:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_reset
	.align	2
	.globl	_sync
	.ent	_sync
_sync:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L312
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	jal	_gpu_arm_timeout
	j	$L333
$L315:
	jal	_gpu_que_drain
	jal	_gpu_check_timeout
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L329
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L333:
	#.set	volatile
	lw	$3,_qin
	#.set	novolatile
	#.set	volatile
	lw	$2,_qout
	#.set	novolatile
	#nop
	beq	$3,$2,$L334
	j	$L315
$L320:
	jal	_gpu_check_timeout
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L329
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L334:
	lw	$2,D2_CHCR
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,16777216			# 0x01000000
	and	$2,$2,$3
	bne	$2,$0,$L320
	lw	$2,GPU_GP1
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,67108864			# 0x04000000
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L320
	move	$2,$0
	.set	macro
	.set	reorder

	j	$L329
$L312:
	#.set	volatile
	lw	$2,_qin
	#.set	novolatile
	#.set	volatile
	lw	$3,_qout
	#.set	novolatile
	#nop
	subu	$2,$2,$3
	andi	$16,$2,0x003f
	beq	$16,$0,$L323
	jal	_gpu_que_drain
$L323:
	lw	$2,D2_CHCR
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,16777216			# 0x01000000
	and	$2,$2,$3
	bne	$2,$0,$L325
	lw	$2,GPU_GP1
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,67108864			# 0x04000000
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L327
	move	$2,$16
	.set	macro
	.set	reorder

$L325:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L329
	move	$2,$16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L327:
$L329:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_sync
	.align	2
	.globl	_gpu_arm_timeout
	.ent	_gpu_arm_timeout
_gpu_arm_timeout:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	addu	$2,$2,240
	sw	$2,_gpu_timeout_target
	sw	$0,_gpu_timeout_count
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_gpu_arm_timeout
	.rdata
	.align	2
$LC16:
	.ascii	"GPU timeout:que=%d,stat=%08x,chcr=%08x,madr=%08x\n\000"
	.text
	.align	2
	.globl	_gpu_check_timeout
	.ent	_gpu_check_timeout
_gpu_check_timeout:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,_gpu_timeout_target
	#nop
	slt	$3,$3,$2
	bne	$3,$0,$L339
	la	$3,_gpu_timeout_count
	lw	$2,0($3)
	#nop
	move	$4,$2
	addu	$2,$2,1
	sw	$2,0($3)
	li	$2,983040			# 0x000f0000
	slt	$2,$2,$4
	beq	$2,$0,$L337
$L339:
	lw	$6,GPU_GP1
	#nop
	#.set	volatile
	lw	$2,0($6)
	#.set	novolatile
	#.set	volatile
	lw	$5,_qin
	#.set	novolatile
	lw	$2,D2_MADR
	#.set	volatile
	lw	$3,_qout
	#.set	novolatile
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	la	$4,$LC16
	sw	$2,16($sp)
	subu	$5,$5,$3
	lw	$2,D2_CHCR
	#.set	volatile
	lw	$6,0($6)
	#.set	novolatile
	#.set	volatile
	lw	$7,0($2)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	printf
	andi	$5,$5,0x003f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetIntrMask
	move	$4,$0
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$0,_qout
	#.set	novolatile
	#.set	volatile
	lw	$3,_qout
	#.set	novolatile
	sw	$2,_q_reset_mask
	#.set	volatile
	sw	$3,_qin
	#.set	novolatile
	lw	$3,D2_CHCR
	li	$2,1025			# 0x00000401
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,DMA_DPCR
	#nop
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	ori	$2,$2,0x0800
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,GPU_GP1
	li	$2,33554432			# 0x02000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,GPU_GP1
	li	$2,16777216			# 0x01000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$4,_q_reset_mask
	jal	SetIntrMask
	.set	noreorder
	.set	nomacro
	j	$L342
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L337:
	move	$2,$0
$L342:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	_gpu_check_timeout
	.align	2
	.globl	_gpu_init_videomode
	.ent	_gpu_init_videomode
_gpu_init_videomode:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,268435456			# 0x10000000
	lw	$2,GPU_GP1
	ori	$3,$3,0x0007
	#.set	volatile
	sw	$3,0($2)
	#.set	novolatile
	lw	$5,GPU_GP0
	li	$3,16711680			# 0x00ff0000
	#.set	volatile
	lw	$2,0($5)
	#.set	novolatile
	ori	$3,$3,0xffff
	and	$2,$2,$3
	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L344
	andi	$2,$4,0x0008
	.set	macro
	.set	reorder

	lw	$2,GPU_GP1
	li	$3,-520093696			# 0xe1000000
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	ori	$3,$3,0x1000
	andi	$2,$2,0x3fff
	or	$2,$2,$3
	#.set	volatile
	sw	$2,0($5)
	#.set	novolatile
	lw	$3,GPU_GP0
	move	$2,$0
	#.set	volatile
	lw	$3,0($3)
	#.set	novolatile
	j	$31
$L344:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L345
	li	$4,150994944			# 0x09000000
	.set	macro
	.set	reorder

	ori	$4,$4,0x0001
	lw	$3,GPU_GP1
	li	$2,2			# 0x00000002
	#.set	volatile
	sw	$4,0($3)
	#.set	novolatile
	j	$31
$L345:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	_gpu_init_videomode
	.align	2
	.globl	DrawOTag2
	.ent	DrawOTag2
DrawOTag2:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
	lbu	$2,GEnv+2
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L348
	move	$16,$4
	.set	macro
	.set	reorder

	la	$4,$LC13
	lw	$2,GPU_printf
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$16
	.set	macro
	.set	reorder

$L348:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,D2_CHCR
	addu	$2,$2,240
	sw	$2,_gpu_timeout_target
	sw	$0,_gpu_timeout_count
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L356
	li	$3,16777216			# 0x01000000
	.set	macro
	.set	reorder

$L351:
	jal	_gpu_check_timeout
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L354
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$2,D2_CHCR
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,16777216			# 0x01000000
$L356:
	and	$2,$2,$3
	bne	$2,$0,$L351
	lw	$2,GPU_GP1
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,67108864			# 0x04000000
	and	$2,$2,$3
	beq	$2,$0,$L351
	la	$5,_install_drain_cb
	.set	noreorder
	.set	nomacro
	jal	DMACallback
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,GEnv_drv
	#nop
	lw	$2,24($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

	move	$2,$0
$L354:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DrawOTag2
	.align	2
	.globl	_install_drain_cb
	.ent	_install_drain_cb
_install_drain_cb:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	la	$5,_gpu_que_drain
	.set	noreorder
	.set	nomacro
	jal	DMACallback
	li	$4,2			# 0x00000002
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

	.end	_install_drain_cb
	.align	2
	.globl	_memset
	.ent	_memset
_memset:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L364
	addu	$2,$6,-1
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
$L360:
	sb	$5,0($4)
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L360
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L364:
	j	$31
	.end	_memset
	.section .bss,"aw",@progbits
	.align	2
GPU_GP0:
	.space	4
	.align	2
GPU_GP1:
	.space	4
	.align	2
D2_MADR:
	.space	4
	.align	2
D2_BCR:
	.space	4
	.align	2
D2_CHCR:
	.space	4
	.align	2
D6_MADR:
	.space	4
	.align	2
D6_BCR:
	.space	4
	.align	2
D6_CHCR:
	.space	4
	.align	2
DMA_DPCR:
	.space	4

	.lcomm	_que,6144
	.align	2
_qin:
	.space	4
	.align	2
_qout:
	.space	4
	.align	2
_q_saved_mask:
	.space	4
	.align	2
_drain_saved_mask:
	.space	4
	.align	2
_q_reset_mask:
	.space	4
	.align	2
_gpu_timeout_target:
	.space	4
	.align	2
_gpu_timeout_count:
	.space	4
	.align	2
GEnv:
	.space	128

	.lcomm	_blit_buf,72

	.lcomm	_otc_link,4
