	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\isqrt.c"
gcc2_compiled.:
__gnu_compiled_c:
	.globl	isqrttbl
	.data
	.align	2
isqrttbl:
	.byte	16
	.byte	22
	.byte	27
	.byte	32
	.byte	35
	.byte	39
	.byte	42
	.byte	45
	.byte	48
	.byte	50
	.byte	53
	.byte	55
	.byte	57
	.byte	59
	.byte	61
	.byte	64
	.byte	65
	.byte	67
	.byte	69
	.byte	71
	.byte	73
	.byte	75
	.byte	76
	.byte	78
	.byte	80
	.byte	81
	.byte	83
	.byte	84
	.byte	86
	.byte	87
	.byte	89
	.byte	90
	.byte	91
	.byte	93
	.byte	94
	.byte	96
	.byte	97
	.byte	98
	.byte	99
	.byte	101
	.byte	102
	.byte	103
	.byte	104
	.byte	106
	.byte	107
	.byte	108
	.byte	109
	.byte	110
	.byte	112
	.byte	113
	.byte	114
	.byte	115
	.byte	116
	.byte	117
	.byte	118
	.byte	119
	.byte	120
	.byte	121
	.byte	122
	.byte	123
	.byte	124
	.byte	125
	.byte	126
	.byte	128
	.byte	128
	.byte	129
	.byte	130
	.byte	131
	.byte	132
	.byte	133
	.byte	134
	.byte	135
	.byte	136
	.byte	137
	.byte	138
	.byte	139
	.byte	140
	.byte	141
	.byte	142
	.byte	143
	.byte	144
	.byte	144
	.byte	145
	.byte	146
	.byte	147
	.byte	148
	.byte	149
	.byte	150
	.byte	150
	.byte	151
	.byte	152
	.byte	153
	.byte	154
	.byte	155
	.byte	155
	.byte	156
	.byte	157
	.byte	158
	.byte	159
	.byte	160
	.byte	160
	.byte	161
	.byte	162
	.byte	163
	.byte	163
	.byte	164
	.byte	165
	.byte	166
	.byte	167
	.byte	167
	.byte	168
	.byte	169
	.byte	170
	.byte	170
	.byte	171
	.byte	172
	.byte	173
	.byte	173
	.byte	174
	.byte	175
	.byte	176
	.byte	176
	.byte	177
	.byte	178
	.byte	178
	.byte	179
	.byte	180
	.byte	181
	.byte	181
	.byte	182
	.byte	183
	.byte	183
	.byte	184
	.byte	185
	.byte	185
	.byte	186
	.byte	187
	.byte	187
	.byte	188
	.byte	189
	.byte	189
	.byte	190
	.byte	191
	.byte	192
	.byte	192
	.byte	193
	.byte	193
	.byte	194
	.byte	195
	.byte	195
	.byte	196
	.byte	197
	.byte	197
	.byte	198
	.byte	199
	.byte	199
	.byte	200
	.byte	201
	.byte	201
	.byte	202
	.byte	203
	.byte	203
	.byte	204
	.byte	204
	.byte	205
	.byte	206
	.byte	206
	.byte	207
	.byte	208
	.byte	208
	.byte	209
	.byte	209
	.byte	210
	.byte	211
	.byte	211
	.byte	212
	.byte	212
	.byte	213
	.byte	214
	.byte	214
	.byte	215
	.byte	215
	.byte	216
	.byte	217
	.byte	217
	.byte	218
	.byte	218
	.byte	219
	.byte	219
	.byte	220
	.byte	221
	.byte	221
	.byte	222
	.byte	222
	.byte	223
	.byte	224
	.byte	224
	.byte	225
	.byte	225
	.byte	226
	.byte	226
	.byte	227
	.byte	227
	.byte	228
	.byte	229
	.byte	229
	.byte	230
	.byte	230
	.byte	231
	.byte	231
	.byte	232
	.byte	232
	.byte	233
	.byte	234
	.byte	234
	.byte	235
	.byte	235
	.byte	236
	.byte	236
	.byte	237
	.byte	237
	.byte	238
	.byte	238
	.byte	239
	.byte	240
	.byte	240
	.byte	241
	.byte	241
	.byte	242
	.byte	242
	.byte	243
	.byte	243
	.byte	244
	.byte	244
	.byte	245
	.byte	245
	.byte	246
	.byte	246
	.byte	247
	.byte	247
	.byte	248
	.byte	248
	.byte	249
	.byte	249
	.byte	250
	.byte	250
	.byte	251
	.byte	251
	.byte	252
	.byte	252
	.byte	253
	.byte	253
	.byte	254
	.byte	254
	.byte	255
	.byte	255
	.text
	.align	2
	.globl	isqrt

	.text
	.def	isqrt;	.val	isqrt;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	isqrt
isqrt:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	a;	.val	6;	.scl	17;	.type	0xe;	.endef
	move	$6,$4
	li	$2,-65536			# 0xffff0000
	and	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	li	$2,-16777216			# 0xff000000
	.set	macro
	.set	reorder

	and	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	lui	$2,%hi(isqrttbl) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(isqrttbl) # low
	srl	$3,$6,24
	addu	$4,$3,$2
	move	$3,$4
	lbu	$4,-1($4)
	lbu	$2,0($3)
	sll	$4,$4,8
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L5
	sll	$5,$2,8
	.set	macro
	.set	reorder

$L3:
	addiu	$2,$2,%lo(isqrttbl) # low
	srl	$3,$6,16
	addu	$4,$3,$2
	move	$3,$4
	lbu	$4,-1($4)
	lbu	$2,0($3)
	sll	$4,$4,4
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L5
	sll	$5,$2,4
	.set	macro
	.set	reorder

$L7:
	srl	$3,$2,1
	mult	$3,$3
	mflo	$7
	#nop
	#nop
	sltu	$2,$6,$7
	beq	$2,$0,$L8
	.set	noreorder
	.set	nomacro
	j	$L5
	move	$5,$3
	.set	macro
	.set	reorder

$L8:
	move	$4,$3
$L5:
	subu	$2,$5,$4
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L7
	addu	$2,$4,$5
	.set	macro
	.set	reorder

$L23:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

$L2:
	andi	$2,$6,0xff00
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L11
	andi	$2,$6,0xf000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L12
	andi	$2,$6,0xc000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L13
	lui	$3,%hi(isqrttbl) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(isqrttbl) # low
	srl	$2,$6,8
	addu	$4,$2,$3
	move	$2,$4
	lbu	$2,0($2)
	lbu	$4,-1($4)
	.set	noreorder
	.set	nomacro
	j	$L24
	addu	$5,$2,1
	.set	macro
	.set	reorder

$L13:
	lui	$2,%hi(isqrttbl) # high
	addiu	$2,$2,%lo(isqrttbl) # low
	srl	$3,$6,6
	addu	$4,$3,$2
	move	$3,$4
	lbu	$4,-1($4)
	lbu	$2,0($3)
	srl	$4,$4,1
	.set	noreorder
	.set	nomacro
	j	$L22
	srl	$2,$2,1
	.set	macro
	.set	reorder

$L12:
	andi	$2,$6,0x0c00
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L16
	lui	$2,%hi(isqrttbl) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(isqrttbl) # low
	srl	$3,$6,4
	addu	$4,$3,$2
	move	$3,$4
	lbu	$4,-1($4)
	lbu	$2,0($3)
	srl	$4,$4,2
	.set	noreorder
	.set	nomacro
	j	$L22
	srl	$2,$2,2
	.set	macro
	.set	reorder

$L16:
	addiu	$2,$2,%lo(isqrttbl) # low
	srl	$3,$6,2
	addu	$4,$3,$2
	move	$3,$4
	lbu	$4,-1($4)
	lbu	$2,0($3)
	srl	$4,$4,3
	srl	$2,$2,3
$L22:
	addu	$5,$2,1
$L24:
	subu	$2,$5,$4
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L23
	addu	$2,$4,$5
	.set	macro
	.set	reorder

	srl	$3,$2,1
	mult	$3,$3
	move	$2,$3
	mflo	$7
	#nop
	#nop
	sltu	$3,$6,$7
	beq	$3,$0,$L25
	j	$L23
$L11:
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L20
	lui	$2,%hi(isqrttbl) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L20:
	addiu	$2,$2,%lo(isqrttbl) # low
	addu	$2,$6,$2
	lbu	$2,-1($2)
	#nop
	srl	$2,$2,4
$L25:
	j	$31

	.loc	1 0
LM1:
	.end	isqrt
	.def	isqrttbl;	.val	isqrttbl;	.scl	2;	.dim	256;	.size	256;	.type	0x3c;	.endef
