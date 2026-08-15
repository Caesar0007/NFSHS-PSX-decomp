	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmcrd\\USERFUNC.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.section .data,"aw",@progbits
	.align	2
_uf_top:
	.word	-1
	.text
	.align	2
	.globl	UserFuncInit
	.ent	UserFuncInit
UserFuncInit:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-1			# 0xffffffff
	sw	$2,_uf_top
	j	$31
	.end	UserFuncInit
	.rdata
	.align	2
$LC0:
	.ascii	"libmcrd: event overflow\n\000"
	.text
	.align	2
	.globl	UserFuncOpen
	.ent	UserFuncOpen
UserFuncOpen:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,_uf_top
	subu	$sp,$sp,24
	addu	$6,$2,1
	slt	$2,$6,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	la	$4,$LC0
	jal	printf
	j	$L2
$L3:
	li	$5,0x00000003		# 3
	sll	$2,$6,4
	la	$3,_uf_arg+12
	addu	$3,$2,$3
	sll	$2,$6,2
	sw	$6,_uf_top
	sw	$4,_uf_func($2)
$L7:
	sw	$0,0($3)
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L7
	addu	$3,$3,-4
	.set	macro
	.set	reorder

$L2:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	UserFuncOpen
	.align	2
	.globl	UserFuncExecute
	.ent	UserFuncExecute
UserFuncExecute:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$3,_uf_top
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	bltz	$3,$L10
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	sll	$2,$3,2
	sll	$3,$3,4
	la	$4,_uf_arg
	lw	$2,_uf_func($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L10
	lw	$2,_uf_top
	#nop
	addu	$2,$2,-1
	sw	$2,_uf_top
$L10:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	UserFuncExecute
	.align	2
	.globl	UserFuncComplete
	.ent	UserFuncComplete
UserFuncComplete:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,_uf_top
	.set	noreorder
	.set	nomacro
	j	$31
	srl	$2,$2,31
	.set	macro
	.set	reorder

	.end	UserFuncComplete

	.lcomm	_uf_arg,64

	.lcomm	_uf_func,16
