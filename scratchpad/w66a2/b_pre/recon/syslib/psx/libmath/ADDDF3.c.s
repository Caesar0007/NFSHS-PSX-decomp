	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\ADDDF3.c"

 # -G value = 0, Cpu = 3000, ISA = 1
 # GNU C version cygnus-2.7.2-970404 SN32.3.7.0004 (SonyPSX) compiled by CC.
 # options passed:  -O2 -G0 -mgas
 # options enabled:  -fdefer-pop -fomit-frame-pointer -fcse-follow-jumps
 # -fcse-skip-blocks -fexpensive-optimizations -fthread-jumps
 # -fstrength-reduce -fpeephole -fforce-mem -ffunction-cse -finline
 # -fkeep-static-consts -fcaller-saves -fpcc-struct-return -fdelayed-branch
 # -frerun-cse-after-loop -fschedule-insns -fschedule-insns2 -fcommon
 # -fverbose-asm -fgnu-linker -mgas -msoft-float -mcpu=3000

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__adddf3
	.ent	__adddf3
__adddf3:
	.frame	$sp,96,$31		# vars= 32, regs= 9/0, args= 24, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$0,48($sp)
	sw	$23,84($sp)
	addu	$23,$0,$0
	sw	$19,68($sp)
	sw	$18,64($sp)
	addu	$18,$4,$0
	addu	$19,$5,$0
	sw	$17,60($sp)
	sw	$16,56($sp)
	addu	$16,$6,$0
	addu	$17,$7,$0
	li	$2,2147418112			# 0x7fff0000
	ori	$2,$2,0xffff
	and	$2,$19,$2
	sw	$31,88($sp)
	sw	$22,80($sp)
	sw	$21,76($sp)
	sw	$20,72($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$0,52($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L26
	li	$2,2147418112			# 0x7fff0000
	.set	macro
	.set	reorder

	addu	$2,$6,$0
	.set	noreorder
	.set	nomacro
	j	$L24
	addu	$3,$7,$0
	.set	macro
	.set	reorder

$L2:
	li	$2,2147418112			# 0x7fff0000
$L26:
	ori	$2,$2,0xffff
	and	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L27
	sra	$2,$19,20
	.set	macro
	.set	reorder

	beq	$16,$0,$L23
$L27:
	andi	$20,$2,0x07ff
	sra	$2,$17,20
	andi	$22,$2,0x07ff
	addu	$2,$22,54
	slt	$2,$2,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L23
	addu	$2,$20,54
	.set	macro
	.set	reorder

	slt	$2,$2,$22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	li	$2,983040			# 0x000f0000
	.set	macro
	.set	reorder

	addu	$2,$16,$0
	addu	$3,$17,$0
	j	$L24
$L5:
	ori	$2,$2,0xffff
	and	$3,$19,$2
	li	$4,1048576			# 0x00100000
	or	$6,$3,$4
	and	$2,$17,$2
	or	$2,$2,$4
	li	$21,-2147483648			# 0x80000000
	sw	$6,28($sp)
	sw	$18,24($sp)
	sw	$2,36($sp)
	.set	noreorder
	.set	nomacro
	bgez	$19,$L6
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	_mainasu
	addu	$5,$18,$0
	.set	macro
	.set	reorder

$L6:
	and	$2,$17,$21
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L28
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lw	$5,32($sp)
	lw	$6,36($sp)
	.set	noreorder
	.set	nomacro
	jal	_mainasu
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	addu	$4,$sp,24
$L28:
	li	$16,9			# 0x00000009
	sw	$16,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	addu	$17,$sp,32
	addu	$4,$17,$0
	sw	$16,16($sp)
	lw	$6,32($sp)
	lw	$7,36($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	slt	$2,$22,$20
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	subu	$2,$20,$22
	.set	macro
	.set	reorder

	addu	$4,$17,$0
	sw	$2,16($sp)
	lw	$6,32($sp)
	lw	$7,36($sp)
	.set	noreorder
	.set	nomacro
	j	$L25
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L8:
	addu	$4,$sp,24
	li	$5,1			# 0x00000001
	subu	$2,$22,$20
	sw	$2,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	addu	$20,$22,$0
$L25:
	jal	_dbl_shift
	lw	$2,36($sp)
	#nop
	sw	$2,16($sp)
	lw	$7,32($sp)
	lw	$5,24($sp)
	lw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_add_mant_d
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lw	$6,28($sp)
	#nop
	bltz	$6,$L10
	bne	$6,$0,$L11
	lw	$2,24($sp)
	#nop
	bne	$2,$0,$L11
	lw	$2,48($sp)
	lw	$3,52($sp)
	j	$L24
$L10:
	addu	$4,$sp,24
	lw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	_mainasu
	li	$23,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

$L11:
	lw	$2,28($sp)
	li	$3,-536870912			# 0xe0000000
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	addu	$16,$3,$0
	.set	macro
	.set	reorder

	li	$17,1			# 0x00000001
$L15:
	addu	$4,$sp,24
	sw	$17,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	lw	$2,28($sp)
	#nop
	and	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L15
	addu	$20,$20,-1
	.set	macro
	.set	reorder

$L14:
	lw	$2,28($sp)
	li	$16,1073741824			# 0x40000000
	and	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L17
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	addu	$2,$5,$0
	sw	$2,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L17:
	lw	$2,24($sp)
	li	$3,255			# 0x000000ff
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L18
	sw	$0,44($sp)
	.set	macro
	.set	reorder

	li	$3,256			# 0x00000100
$L18:
	sw	$3,40($sp)
	sw	$0,16($sp)
	addu	$7,$3,$0
	lw	$5,24($sp)
	lw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_add_mant_d
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lw	$2,28($sp)
	#nop
	and	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L19
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	addu	$2,$5,$0
	sw	$2,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L19:
	addu	$4,$sp,24
	li	$2,9			# 0x00000009
	sw	$2,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$3,-1114112			# 0xffef0000
	lw	$2,28($sp)
	ori	$3,$3,0xffff
	and	$3,$2,$3
	slt	$2,$20,2047
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L20
	sw	$3,28($sp)
	.set	macro
	.set	reorder

	li	$4,34			# 0x00000022
	.set	noreorder
	.set	nomacro
	jal	_err_math
	li	$5,11			# 0x0000000b
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L21
	li	$2,2146435072			# 0x7ff00000
	.set	macro
	.set	reorder

	li	$2,-1048576			# 0xfff00000
$L21:
	addu	$19,$2,$0
	.set	noreorder
	.set	nomacro
	j	$L23
	addu	$18,$0,$0
	.set	macro
	.set	reorder

$L20:
	sll	$2,$20,20
	or	$2,$23,$2
	or	$19,$2,$3
	lw	$18,24($sp)
$L23:
	addu	$2,$18,$0
	addu	$3,$19,$0
$L24:
	lw	$31,88($sp)
	lw	$23,84($sp)
	lw	$22,80($sp)
	lw	$21,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	addu	$sp,$sp,96
	j	$31
	.end	__adddf3
