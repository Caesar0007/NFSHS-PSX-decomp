	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\udff.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"udffhandle\000"
	.text
	.align	2
	.globl	Udff_Opena__FPcT0i
	.align	2
	.globl	Udff_Close__FP10Udff_tInfo
	.align	2
	.globl	Udff_GetInt__FP10Udff_tInfo
	.align	2
	.globl	Udff_GetBuffer__FP10Udff_tInfoPci

	.text
	.text
	.ent	Udff_Opena__FPcT0i
Udff_Opena__FPcT0i:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$5
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,12			# 0x0000000c
	li	$6,16			# 0x00000010
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L612
	move	$2,$0
	.set	macro
	.set	reorder

	bne	$18,$0,$L603
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L605
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L606
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L603:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L608
	move	$4,$18
	.set	macro
	.set	reorder

$L605:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L612
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L612
	move	$2,$0
	.set	macro
	.set	reorder

$L606:
	sw	$0,4($16)
	.set	noreorder
	.set	nomacro
	j	$L610
	sw	$17,8($16)
	.set	macro
	.set	reorder

$L608:
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	loadfileadrz
	sw	$0,0($16)
	.set	macro
	.set	reorder

	sw	$2,8($16)
	move	$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L610
	sw	$2,4($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L612
	move	$2,$0
	.set	macro
	.set	reorder

$L610:
	move	$2,$16
$L612:
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

	.end	Udff_Opena__FPcT0i
	.text
	.ent	Udff_Close__FP10Udff_tInfo
Udff_Close__FP10Udff_tInfo:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L615
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	bne	$2,$0,$L617
	lw	$4,4($16)
	#nop
	beq	$4,$0,$L617
	jal	purgememadr
$L617:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

$L615:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Udff_Close__FP10Udff_tInfo
	.text
	.ent	Udff_GetInt__FP10Udff_tInfo
Udff_GetInt__FP10Udff_tInfo:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,8($4)
	#nop
	lw	$2,0($3)
	addu	$3,$3,4
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,8($4)
	.set	macro
	.set	reorder

	.end	Udff_GetInt__FP10Udff_tInfo
	.text
	.ent	Udff_GetBuffer__FP10Udff_tInfoPci
Udff_GetBuffer__FP10Udff_tInfoPci:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$4,$5
	sw	$31,24($sp)
	lw	$5,8($16)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	move	$17,$6
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	addu	$2,$2,$17
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

	.end	Udff_GetBuffer__FP10Udff_tInfoPci
