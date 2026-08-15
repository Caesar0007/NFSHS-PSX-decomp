	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\TYPE.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	CdDiskReady
	.ent	CdDiskReady
CdDiskReady:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,24($sp)
	addu	$16,$4,$0
	li	$4,0x00000001		# 1
	addu	$5,$0,$0
	addu	$6,$sp,16
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	lbu	$2,16($sp)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	li	$4,0x00000013		# 19
	.set	macro
	.set	reorder

$L24:
	.set	noreorder
	.set	nomacro
	j	$L18
	li	$2,0x00000010		# 16
	.set	macro
	.set	reorder

$L2:
	addu	$5,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	addu	$4,$2,$0
	li	$2,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L3
	li	$17,0x00000002		# 2
	.set	macro
	.set	reorder

	lbu	$3,16($sp)
	li	$2,0x00000002		# 2
	bne	$3,$2,$L22
	bne	$4,$0,$L18
	.set	noreorder
	.set	nomacro
	j	$L18
	li	$2,0x00000005		# 5
	.set	macro
	.set	reorder

$L3:
	addu	$16,$0,$0
$L9:
	lbu	$3,16($sp)
	#nop
	andi	$2,$3,0x0002
	beq	$2,$0,$L10
	bne	$3,$17,$L12
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L18
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

$L12:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,0x0000001e		# 30
	.set	macro
	.set	reorder

	li	$4,0x00000013		# 19
	addu	$5,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lbu	$3,16($sp)
	addu	$4,$2,$0
	andi	$2,$3,0x0010
	bne	$2,$0,$L24
	bne	$3,$17,$L12
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L12
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

	j	$L18
$L10:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,0x0000001e		# 30
	.set	macro
	.set	reorder

	li	$4,0x00000013		# 19
	addu	$5,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lbu	$3,16($sp)
	#nop
	andi	$3,$3,0x0010
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L24
	addu	$4,$2,$0
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,10
	bne	$2,$0,$L9
$L22:
	li	$2,0x00000005		# 5
$L18:
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,40
	j	$31
	.end	CdDiskReady
	.rdata
	.align	2
$LC0:
	.ascii	"Command Error: \000"
	.align	2
$LC1:
	.ascii	"CD001\000"
	.text
	.align	2
	.globl	CdGetDiskType
	.ent	CdGetDiskType
CdGetDiskType:
	.frame	$sp,2096,$31		# vars= 2064, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,2096
	li	$4,0x00000001		# 1
	addu	$5,$0,$0
	addu	$6,$sp,2072
	sw	$31,2088($sp)
	sw	$17,2084($sp)
	.set	noreorder
	.set	nomacro
	jal	CdControl
	sw	$16,2080($sp)
	.set	macro
	.set	reorder

	lbu	$2,2072($sp)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L35
	li	$2,0x00000010		# 16
	.set	macro
	.set	reorder

	li	$4,0x00000010		# 16
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	CdIntToPos
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	li	$4,0x0000001b		# 27
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	CdControl
	addu	$6,$0,$0
	.set	macro
	.set	reorder

	addu	$16,$0,$0
	li	$17,0x00000001		# 1
	addu	$4,$0,$0
$L37:
	.set	noreorder
	.set	nomacro
	jal	CdReady
	addu	$5,$sp,2072
	.set	macro
	.set	reorder

	addu	$3,$2,$0
	.set	noreorder
	.set	nomacro
	beq	$3,$17,$L28
	addu	$16,$16,1
	.set	macro
	.set	reorder

	slt	$2,$16,10
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L28
	li	$4,0x0000001b		# 27
	.set	macro
	.set	reorder

	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	CdControl
	addu	$6,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L37
	addu	$4,$0,$0
	.set	macro
	.set	reorder

$L28:
	li	$2,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L31
	li	$4,0x00000009		# 9
	.set	macro
	.set	reorder

	lbu	$3,2072($sp)
	#nop
	andi	$2,$3,0x0010
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L35
	li	$2,0x00000010		# 16
	.set	macro
	.set	reorder

	andi	$2,$3,0x0001
	beq	$2,$0,$L33
	lbu	$2,2073($sp)
	#nop
	andi	$2,$2,0x0040
	beq	$2,$0,$L33
	la	$4,$LC0
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L35
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L33:
	lbu	$2,2072($sp)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	j	$L35
	sltu	$2,$0,$2
	.set	macro
	.set	reorder

$L31:
	addu	$5,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CdControl
	addu	$6,$0,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	CdGetSector
	li	$5,0x00000200		# 512
	.set	macro
	.set	reorder

	addu	$4,$sp,25
	la	$5,$LC1
	.set	noreorder
	.set	nomacro
	jal	strncmp
	li	$6,0x00000005		# 5
	.set	macro
	.set	reorder

	addu	$3,$2,$0
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L35
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	li	$2,0x00000002		# 2
$L35:
	lw	$31,2088($sp)
	lw	$17,2084($sp)
	lw	$16,2080($sp)
	addu	$sp,$sp,2096
	j	$31
	.end	CdGetDiskType
