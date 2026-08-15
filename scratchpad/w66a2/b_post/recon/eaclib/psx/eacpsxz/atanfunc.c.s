	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\atanfunc.c"
gcc2_compiled.:
__gnu_compiled_c:
	.rdata
	.text
	.rdata
	.align	2
kAtanTable:
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	6
	.byte	6
	.byte	7
	.byte	8
	.byte	8
	.byte	9
	.byte	10
	.byte	10
	.byte	11
	.byte	11
	.byte	12
	.byte	13
	.byte	13
	.byte	14
	.byte	15
	.byte	15
	.byte	16
	.byte	16
	.byte	17
	.byte	18
	.byte	18
	.byte	19
	.byte	20
	.byte	20
	.byte	21
	.byte	22
	.byte	22
	.byte	23
	.byte	23
	.byte	24
	.byte	25
	.byte	25
	.byte	26
	.byte	27
	.byte	27
	.byte	28
	.byte	28
	.byte	29
	.byte	30
	.byte	30
	.byte	31
	.byte	31
	.byte	32
	.byte	33
	.byte	33
	.byte	34
	.byte	34
	.byte	35
	.byte	36
	.byte	36
	.byte	37
	.byte	38
	.byte	38
	.byte	39
	.byte	39
	.byte	40
	.byte	41
	.byte	41
	.byte	42
	.byte	42
	.byte	43
	.byte	44
	.byte	44
	.byte	45
	.byte	45
	.byte	46
	.byte	46
	.byte	47
	.byte	48
	.byte	48
	.byte	49
	.byte	49
	.byte	50
	.byte	51
	.byte	51
	.byte	52
	.byte	52
	.byte	53
	.byte	53
	.byte	54
	.byte	55
	.byte	55
	.byte	56
	.byte	56
	.byte	57
	.byte	57
	.byte	58
	.byte	58
	.byte	59
	.byte	60
	.byte	60
	.byte	61
	.byte	61
	.byte	62
	.byte	62
	.byte	63
	.byte	63
	.byte	64
	.byte	65
	.byte	65
	.byte	66
	.byte	66
	.byte	67
	.byte	67
	.byte	68
	.byte	68
	.byte	69
	.byte	69
	.byte	70
	.byte	70
	.byte	71
	.byte	71
	.byte	72
	.byte	72
	.byte	73
	.byte	74
	.byte	74
	.byte	75
	.byte	75
	.byte	76
	.byte	76
	.byte	77
	.byte	77
	.byte	78
	.byte	78
	.byte	79
	.byte	79
	.byte	80
	.byte	80
	.byte	81
	.byte	81
	.byte	82
	.byte	82
	.byte	83
	.byte	83
	.byte	84
	.byte	84
	.byte	84
	.byte	85
	.byte	85
	.byte	86
	.byte	86
	.byte	87
	.byte	87
	.byte	88
	.byte	88
	.byte	89
	.byte	89
	.byte	90
	.byte	90
	.byte	91
	.byte	91
	.byte	91
	.byte	92
	.byte	92
	.byte	93
	.byte	93
	.byte	94
	.byte	94
	.byte	95
	.byte	95
	.byte	96
	.byte	96
	.byte	96
	.byte	97
	.byte	97
	.byte	98
	.byte	98
	.byte	99
	.byte	99
	.byte	99
	.byte	100
	.byte	100
	.byte	101
	.byte	101
	.byte	102
	.byte	102
	.byte	102
	.byte	103
	.byte	103
	.byte	104
	.byte	104
	.byte	104
	.byte	105
	.byte	105
	.byte	106
	.byte	106
	.byte	106
	.byte	107
	.byte	107
	.byte	108
	.byte	108
	.byte	108
	.byte	109
	.byte	109
	.byte	110
	.byte	110
	.byte	110
	.byte	111
	.byte	111
	.byte	112
	.byte	112
	.byte	112
	.byte	113
	.byte	113
	.byte	113
	.byte	114
	.byte	114
	.byte	115
	.byte	115
	.byte	115
	.byte	116
	.byte	116
	.byte	116
	.byte	117
	.byte	117
	.byte	118
	.byte	118
	.byte	118
	.byte	119
	.byte	119
	.byte	119
	.byte	120
	.byte	120
	.byte	120
	.byte	121
	.byte	121
	.byte	121
	.byte	122
	.byte	122
	.byte	122
	.byte	123
	.byte	123
	.byte	123
	.byte	124
	.byte	124
	.byte	124
	.byte	125
	.byte	125
	.byte	125
	.byte	126
	.byte	126
	.byte	126
	.byte	127
	.byte	127
	.byte	127
	.byte	128
	.byte	128
	.text
	.align	2
	.globl	intatan

	.text
	.def	intatan;	.val	intatan;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	intatan
intatan:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	y;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	x;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	move	$3,$4
	sw	$16,24($sp)
	move	$16,$5
	sw	$18,32($sp)
	move	$18,$0
	sw	$17,28($sp)
	move	$17,$18
	.set	noreorder
	.set	nomacro
	bgez	$16,$L2
	sw	$31,36($sp)
	.set	macro
	.set	reorder

	subu	$16,$0,$16
	li	$18,1			# 0x00000001
	li	$17,512			# 0x00000200
$L2:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L15
	slt	$2,$16,$3
	.set	macro
	.set	reorder

	subu	$3,$0,$3
	li	$2,1			# 0x00000001
	subu	$18,$2,$18
	subu	$17,$0,$17
	slt	$2,$16,$3
$L15:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	move	$2,$3
	.set	macro
	.set	reorder

	move	$3,$16
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L5
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L6
	addu	$17,$17,-256
	.set	macro
	.set	reorder

$L5:
	addu	$17,$17,256
$L6:
	li	$2,1			# 0x00000001
	subu	$18,$2,$18
$L4:
	.set	noreorder
	.set	nomacro
	beq	$3,$16,$L8
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	li	$2,-8388608			# 0xff800000
	and	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	move	$5,$3
	.set	noreorder
	.set	nomacro
	jal	make64
	li	$6,32			# 0x00000020
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	divu64
	move	$6,$16
	.set	macro
	.set	reorder

	move	$3,$2
	li	$2,8388608			# 0x00800000
	and	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L10
	srl	$2,$3,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L12
	addu	$3,$2,1
	.set	macro
	.set	reorder

$L10:
	.set	noreorder
	.set	nomacro
	j	$L12
	srl	$3,$3,24
	.set	macro
	.set	reorder

$L9:
	sll	$3,$3,8
	sra	$2,$16,1
	addu	$3,$3,$2
	divu	$3,$3,$16
$L12:
	lui	$2,%hi(kAtanTable) # high
	addiu	$2,$2,%lo(kAtanTable) # low
	addu	$2,$3,$2
	lbu	$2,0($2)
$L8:
	bne	$18,$0,$L13
	.set	noreorder
	.set	nomacro
	j	$L14
	addu	$2,$17,$2
	.set	macro
	.set	reorder

$L13:
	subu	$2,$17,$2
$L14:
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	intatan
	.def	kAtanTable;	.val	kAtanTable;	.scl	3;	.dim	257;	.size	257;	.type	0x3c;	.endef
