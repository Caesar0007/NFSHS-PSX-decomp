	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libetc\\INTR_VB.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	startIntrVSync
	.ent	startIntrVSync
startIntrVSync:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$4,D_80137CF0
	lw	$3,D_80137D14
	li	$2,0x00000100		# 256
	sw	$31,16($sp)
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	sw	$0,Vcount
	.set	noreorder
	.set	nomacro
	jal	startIntrVSync_helper_3
	li	$5,0x00000008		# 8
	.set	macro
	.set	reorder

	la	$5,startIntrVSync_helper_1
	.set	noreorder
	.set	nomacro
	jal	InterruptCallback
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	la	$2,startIntrVSync_helper_2
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	startIntrVSync
	.align	2
	.globl	startIntrVSync_helper_1
	.ent	startIntrVSync_helper_1
startIntrVSync_helper_1:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lw	$2,Vcount
	subu	$sp,$sp,32
	sw	$17,20($sp)
	addu	$17,$0,$0
	sw	$16,16($sp)
	la	$16,D_80137CF0
	sw	$31,24($sp)
	addu	$2,$2,1
	sw	$2,Vcount
$L3:
	lw	$2,0($16)
	#nop
	beq	$2,$0,$L6
	jal	$31,$2
$L6:
	addu	$17,$17,1
	slt	$2,$17,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	startIntrVSync_helper_1
	.align	2
	.globl	startIntrVSync_helper_2
	.ent	startIntrVSync_helper_2
startIntrVSync_helper_2:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	la	$2,D_80137CF0
	sll	$4,$4,2
	addu	$4,$4,$2
	lw	$2,0($4)
	#nop
	beq	$5,$2,$L9
	sw	$5,0($4)
$L9:
	j	$31
	.end	startIntrVSync_helper_2
	.align	2
	.globl	startIntrVSync_helper_3
	.ent	startIntrVSync_helper_3
startIntrVSync_helper_3:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L11
	addu	$2,$5,-1
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
$L12:
	sw	$0,0($4)
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L12
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L11:
	j	$31
	.end	startIntrVSync_helper_3
