	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libetc\\VSYNC.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	VSync
	.ent	VSync
VSync:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lw	$2,D_80134A88
	lw	$5,D_80134A8C
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	#.set	volatile
	lw	$16,0($2)
	#.set	novolatile
$L2:
	#.set	volatile
	lw	$2,0($5)
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,16($sp)
	#.set	novolatile
	#.set	volatile
	lw	$3,16($sp)
	#.set	novolatile
	#.set	volatile
	lw	$2,0($5)
	#.set	novolatile
	#nop
	bne	$3,$2,$L2
	#.set	volatile
	lw	$2,16($sp)
	#.set	novolatile
	#.set	volatile
	lw	$3,Hcount
	#.set	novolatile
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$4,$L6
	andi	$17,$2,0xffff
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,Vcount
	#.set	novolatile
	j	$L22
$L6:
	li	$2,0x00000001		# 1
	beq	$4,$2,$L23
	blez	$4,$L8
	lw	$2,D_80134A94
	#nop
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L9
	addu	$2,$2,$4
	.set	macro
	.set	reorder

$L8:
	lw	$2,D_80134A94
$L9:
	.set	noreorder
	.set	nomacro
	blez	$4,$L10
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	subu	$5,$4,1
$L10:
	.set	noreorder
	.set	nomacro
	jal	_VSync_wait
	addu	$4,$2,$0
	.set	macro
	.set	reorder

	lw	$2,D_80134A88
	#nop
	#.set	volatile
	lw	$16,0($2)
	#.set	novolatile
	#.set	volatile
	lw	$4,Vcount
	#.set	novolatile
	li	$5,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	jal	_VSync_wait
	addu	$4,$4,1
	.set	macro
	.set	reorder

	li	$2,0x00400000		# 4194304
	and	$2,$16,$2
	beq	$2,$0,$L12
	lw	$3,D_80134A88
	#nop
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	xor	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L12
	li	$4,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

$L16:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	xor	$2,$16,$2
	and	$2,$2,$4
	beq	$2,$0,$L16
$L12:
	#.set	volatile
	lw	$2,Vcount
	#.set	novolatile
	lw	$4,D_80134A8C
	sw	$2,D_80134A94
$L18:
	#.set	volatile
	lw	$2,0($4)
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,Hcount
	#.set	novolatile
	#.set	volatile
	lw	$3,Hcount
	#.set	novolatile
	#.set	volatile
	lw	$2,0($4)
	#.set	novolatile
	#nop
	bne	$3,$2,$L18
$L23:
	addu	$2,$17,$0
$L22:
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,40
	j	$31
	.end	VSync
	.rdata
	.align	2
$LC0:
	.ascii	"VSync: timeout\n\000"
	.text
	.align	2
	.ent	_VSync_wait
_VSync_wait:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sll	$5,$5,15
	#.set	volatile
	sw	$5,16($sp)
	#.set	novolatile
	#.set	volatile
	lw	$2,Vcount
	#.set	novolatile
	#nop
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L24
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
$L27:
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
	bne	$2,$3,$L25
	la	$4,$LC0
	jal	puts
	.set	noreorder
	.set	nomacro
	jal	ChangeClearPAD
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	li	$4,0x00000003		# 3
	.set	noreorder
	.set	nomacro
	jal	ChangeClearRCnt
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	j	$L24
$L25:
	#.set	volatile
	lw	$2,Vcount
	#.set	novolatile
	#nop
	slt	$2,$2,$4
	bne	$2,$0,$L27
$L24:
	lw	$31,24($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_VSync_wait
