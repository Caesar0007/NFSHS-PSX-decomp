	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\toc.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -dl -dg -dL -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	CdGetToc
	.ent	CdGetToc
CdGetToc:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CdGetToc2
	li	$4,0x00000001		# 1
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	CdGetToc
	.rdata
	.align	2
$LC0:
	.ascii	"track=%d,%d\n\000"
	.align	2
$LC1:
	.ascii	"CdGetToc2: %02x:%02x:00\n\000"
	.align	2
$LC2:
	.ascii	"CdGetToc2: error\n\000"
	.text
	.align	2
	.globl	CdGetToc2
	.ent	CdGetToc2
CdGetToc2:
	.frame	$sp,64,$31		# vars= 16, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$20,48($sp)
	move	$20,$5
	li	$2,0x00000001		# 1
	move	$4,$0
	sw	$31,60($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	.set	noreorder
	.set	nomacro
	jal	CdSyncCallback
	sb	$2,16($sp)
	.set	macro
	.set	reorder

	li	$4,0x00000013		# 19
	move	$5,$0
	addu	$17,$sp,24
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	move	$22,$2
	.set	macro
	.set	reorder

	beq	$2,$0,$L4
	lbu	$4,25($sp)
	lbu	$5,26($sp)
	srl	$3,$4,4
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	andi	$4,$4,0x000f
	addu	$16,$2,$4
	srl	$2,$5,4
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$3,$3,1
	andi	$5,$5,0x000f
	lw	$2,CD_debug
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$19,$3,$5
	.set	macro
	.set	reorder

	la	$4,$LC0
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	printf
	move	$6,$19
	.set	macro
	.set	reorder

$L5:
	sb	$0,16($sp)
	li	$4,0x00000014		# 20
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	move	$6,$17
	.set	macro
	.set	reorder

	beq	$2,$0,$L4
	lbu	$2,25($sp)
	#nop
	sb	$2,0($20)
	lbu	$2,26($sp)
	sb	$0,2($20)
	sb	$2,1($20)
	slt	$2,$19,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L7
	li	$18,0x00000001		# 1
	.set	macro
	.set	reorder

	li	$21,0x66660000		# 1717960704
	ori	$21,$21,0x6667
	addu	$17,$20,4
$L8:
	li	$2,0x66660000		# 1717960704
	ori	$2,$2,0x6667
	mult	$16,$2
 #APP
 #NO_APP
	li	$4,0x00000014		# 20
	addu	$5,$sp,16
	addu	$6,$sp,24
	sra	$2,$16,31
	mfhi	$8
	#nop
	#nop
	sra	$3,$8,2
	subu	$3,$3,$2
	sll	$7,$3,4
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	subu	$2,$16,$2
	addu	$7,$7,$2
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	sb	$7,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	addu	$18,$18,1
	.set	macro
	.set	reorder

	lbu	$2,25($sp)
	#nop
	sb	$2,0($17)
	lbu	$2,26($sp)
	addu	$16,$16,1
	sb	$0,2($17)
	sb	$2,1($17)
	slt	$2,$19,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	addu	$17,$17,4
	.set	macro
	.set	reorder

$L7:
	lw	$2,CD_debug
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L13
	addu	$17,$18,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$17,$L13
	move	$18,$0
	.set	macro
	.set	reorder

	move	$16,$20
$L17:
	la	$4,$LC1
	lbu	$5,0($16)
	lbu	$6,1($16)
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	jal	printf
	addu	$18,$18,1
	.set	macro
	.set	reorder

	slt	$2,$17,$18
	beq	$2,$0,$L17
$L13:
	.set	noreorder
	.set	nomacro
	jal	CdSyncCallback
	move	$4,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L20
	move	$2,$17
	.set	macro
	.set	reorder

$L4:
	lw	$2,CD_debug
	#nop
	beq	$2,$0,$L19
	la	$4,$LC2
	jal	printf
$L19:
	.set	noreorder
	.set	nomacro
	jal	CdSyncCallback
	move	$4,$22
	.set	macro
	.set	reorder

	move	$2,$0
$L20:
	lw	$31,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	addu	$sp,$sp,64
	j	$31
	.end	CdGetToc2
