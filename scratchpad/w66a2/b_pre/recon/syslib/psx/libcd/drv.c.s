	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -fno-strength-reduce -o

gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	D_8014899C
	.globl	D_801489A4
	.globl	D_801489AC
	.globl	D_801489B4
	.globl	D_801489B8
	.globl	D_801489BC
	.section	.bss
	.align	2
D_8014899C:
	.space	8
D_801489A4:
	.space	8
D_801489AC:
	.space	8
D_801489B4:
	.space	4
D_801489B8:
	.space	4
D_801489BC:
	.space	4
	.text
 #NO_APP
	.rdata
	.align	2
_cd_int3_ack:
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1
	.word	1
	.word	1
	.word	1
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	1
	.word	1
	.word	0
	.word	0
	.word	0
	.word	1
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.align	2
_cd_status_ok:
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	0
	.word	0
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.word	1
	.align	2
$LC0:
	.ascii	"DiskError: \000"
	.align	2
$LC1:
	.ascii	"com=%s,code=(%02x:%02x)\n\000"
	.align	2
$LC2:
	.ascii	"CDROM: unknown intr\000"
	.align	2
$LC3:
	.ascii	"(%d)\n\000"
	.text
	.align	2
	.globl	CD_get_intr
	.ent	CD_get_intr
CD_get_intr:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	lw	$3,D_8013C20C
	li	$2,0x00000001		# 1
	sw	$31,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$4,D_8013C218
	#nop
	#.set	volatile
	lbu	$2,0($4)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0007
	#.set	volatile
	sb	$2,16($sp)
	#.set	novolatile
	#.set	volatile
	lbu	$2,16($sp)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L100
	addu	$17,$0,$0
	.set	macro
	.set	reorder

	j	$L101
$L11:
	#.set	volatile
	lbu	$2,0($4)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0007
	#.set	volatile
	sb	$2,16($sp)
	#.set	novolatile
$L101:
	#.set	volatile
	lbu	$2,0($4)
	#.set	novolatile
	#.set	volatile
	lbu	$3,16($sp)
	#.set	novolatile
	andi	$2,$2,0x0007
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L11
	addu	$16,$0,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,24
$L16:
	lw	$2,D_8013C20C
	#nop
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	addu	$3,$4,$16
	.set	macro
	.set	reorder

	lw	$2,D_8013C210
	#nop
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	addu	$16,$16,1
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	slt	$2,$16,8
	bne	$2,$0,$L16
$L14:
 #APP
 #NO_APP
	slt	$2,$16,8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L20
	addu	$3,$16,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	addu	$2,$4,$3
$L102:
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	addu	$3,$3,1
	slt	$2,$3,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L102
	addu	$2,$4,$3
	.set	macro
	.set	reorder

$L20:
	lw	$3,D_8013C20C
	li	$2,0x00000001		# 1
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$2,D_8013C218
	li	$3,0x00000007		# 7
	#.set	volatile
	sb	$3,0($2)
	#.set	novolatile
	lw	$2,D_8013C214
	#nop
	#.set	volatile
	sb	$3,0($2)
	#.set	novolatile
	lbu	$3,16($sp)
	li	$2,0x00000003		# 3
	bne	$3,$2,$L25
	lbu	$2,CD_com
	#nop
	sll	$2,$2,2
	lw	$2,_cd_status_ok($2)
	#nop
	beq	$2,$0,$L24
$L25:
	lw	$2,CD_status
	#nop
	andi	$2,$2,0x0010
	bne	$2,$0,$L26
	#.set	volatile
	lbu	$2,24($sp)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0010
	beq	$2,$0,$L26
	lw	$2,CD_nopen
	#nop
	addu	$2,$2,1
	sw	$2,CD_nopen
$L26:
	#.set	volatile
	lbu	$2,24($sp)
	#.set	novolatile
	#.set	volatile
	lbu	$3,25($sp)
	#.set	novolatile
	andi	$2,$2,0x00ff
	andi	$17,$2,0x001d
	sw	$2,CD_status
	sw	$3,CD_status1
$L24:
 #APP
 #NO_APP
	lbu	$3,16($sp)
	li	$2,0x00000005		# 5
	bne	$3,$2,$L27
	lw	$2,CD_debug
	#nop
	blez	$2,$L27
	la	$4,$LC0
	jal	printf
	lw	$2,CD_debug
	#nop
	blez	$2,$L27
	lbu	$2,CD_com
	lw	$6,CD_status
	lw	$7,CD_status1
	sll	$2,$2,2
	lw	$5,CD_comstr($2)
	la	$4,$LC1
	jal	printf
$L27:
	#.set	volatile
	lbu	$2,16($sp)
	#.set	novolatile
	#nop
	addu	$3,$2,-1
	sltu	$2,$3,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L97
	sll	$2,$3,2
	.set	macro
	.set	reorder

	lw	$2,$L98($2)
	#nop
	j	$2
	.rdata
	.align	3
$L98:
	.word	$L61
	.word	$L52
	.word	$L31
	.word	$L71
	.word	$L84
	.text
$L31:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L32
	li	$2,0x00000005		# 5
	.set	macro
	.set	reorder

	la	$3,D_8013C224
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	la	$3,D_8014899C
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L55
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	li	$4,0x00000007		# 7
	li	$6,-1			# 0xffffffff
$L35:
	lbu	$2,0($5)
	addu	$5,$5,1
	addu	$4,$4,-1
	sb	$2,0($3)
	.set	noreorder
	.set	nomacro
	bne	$4,$6,$L35
	addu	$3,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L99
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

$L32:
	lbu	$2,CD_com
	#nop
	sll	$2,$2,2
	lw	$2,_cd_int3_ack($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L39
	li	$2,0x00000003		# 3
	.set	macro
	.set	reorder

	la	$3,D_8013C224
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	la	$3,D_8014899C
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L40
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	li	$4,0x00000007		# 7
	li	$6,-1			# 0xffffffff
$L42:
	lbu	$2,0($5)
	addu	$5,$5,1
	addu	$4,$4,-1
	sb	$2,0($3)
	.set	noreorder
	.set	nomacro
	bne	$4,$6,$L42
	addu	$3,$3,1
	.set	macro
	.set	reorder

$L40:
	.set	noreorder
	.set	nomacro
	j	$L99
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L39:
	la	$3,D_8013C224
	li	$2,0x00000002		# 2
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	la	$3,D_8014899C
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L55
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	li	$4,0x00000007		# 7
	li	$6,-1			# 0xffffffff
$L48:
	lbu	$2,0($5)
	addu	$5,$5,1
	addu	$4,$4,-1
	sb	$2,0($3)
	.set	noreorder
	.set	nomacro
	bne	$4,$6,$L48
	addu	$3,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L99
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

$L52:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L53
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

	li	$2,0x00000005		# 5
$L53:
	#.set	volatile
	sb	$2,D_8013C224
	#.set	novolatile
	la	$3,D_8014899C
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L55
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	li	$4,0x00000007		# 7
	li	$6,-1			# 0xffffffff
$L57:
	lbu	$2,0($5)
	addu	$5,$5,1
	addu	$4,$4,-1
	sb	$2,0($3)
	.set	noreorder
	.set	nomacro
	bne	$4,$6,$L57
	addu	$3,$3,1
	.set	macro
	.set	reorder

$L55:
	.set	noreorder
	.set	nomacro
	j	$L99
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

$L61:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L62
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	bne	$16,$2,$L62
	addu	$17,$0,$0
$L62:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L63
	li	$3,0x00000001		# 1
	.set	macro
	.set	reorder

	li	$3,0x00000005		# 5
$L63:
	la	$2,D_8013C224
 #APP
 #NO_APP
	#.set	volatile
	sb	$3,1($2)
	#.set	novolatile
	la	$3,D_801489A4
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L65
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	li	$4,0x00000007		# 7
	li	$6,-1			# 0xffffffff
$L67:
	lbu	$2,0($5)
	addu	$5,$5,1
	addu	$4,$4,-1
	sb	$2,0($3)
	.set	noreorder
	.set	nomacro
	bne	$4,$6,$L67
	addu	$3,$3,1
	.set	macro
	.set	reorder

$L65:
	lw	$2,D_8013C20C
	#nop
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$3,D_8013C218
	li	$2,0x00000004		# 4
	#.set	volatile
	sb	$0,0($3)
	#.set	novolatile
	j	$L99
$L71:
 #APP
 #NO_APP
	la	$4,D_801489AC
	la	$2,D_8013C224
	li	$3,0x00000004		# 4
	#.set	volatile
	sb	$3,2($2)
	#.set	novolatile
	#.set	volatile
	lbu	$3,2($2)
	#.set	novolatile
	addu	$5,$sp,24
	#.set	volatile
	sb	$3,1($2)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L72
	li	$3,0x00000007		# 7
	.set	macro
	.set	reorder

	li	$6,-1			# 0xffffffff
$L74:
	lbu	$2,0($5)
	addu	$5,$5,1
	addu	$3,$3,-1
	sb	$2,0($4)
	.set	noreorder
	.set	nomacro
	bne	$3,$6,$L74
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L72:
	la	$3,D_801489A4
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L78
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	li	$4,0x00000007		# 7
	li	$6,-1			# 0xffffffff
$L80:
	lbu	$2,0($5)
	addu	$5,$5,1
	addu	$4,$4,-1
	sb	$2,0($3)
	.set	noreorder
	.set	nomacro
	bne	$4,$6,$L80
	addu	$3,$3,1
	.set	macro
	.set	reorder

$L78:
	.set	noreorder
	.set	nomacro
	j	$L99
	li	$2,0x00000004		# 4
	.set	macro
	.set	reorder

$L84:
 #APP
 #NO_APP
	la	$4,D_8014899C
	la	$2,D_8013C224
	li	$3,0x00000005		# 5
	#.set	volatile
	sb	$3,1($2)
	#.set	novolatile
	#.set	volatile
	lbu	$3,1($2)
	#.set	novolatile
	addu	$5,$sp,24
	#.set	volatile
	sb	$3,0($2)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L85
	li	$3,0x00000007		# 7
	.set	macro
	.set	reorder

	li	$6,-1			# 0xffffffff
$L87:
	lbu	$2,0($5)
	addu	$5,$5,1
	addu	$3,$3,-1
	sb	$2,0($4)
	.set	noreorder
	.set	nomacro
	bne	$3,$6,$L87
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L85:
	la	$3,D_801489A4
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L91
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	li	$4,0x00000007		# 7
	li	$6,-1			# 0xffffffff
$L93:
	lbu	$2,0($5)
	addu	$5,$5,1
	addu	$4,$4,-1
	sb	$2,0($3)
	.set	noreorder
	.set	nomacro
	bne	$4,$6,$L93
	addu	$3,$3,1
	.set	macro
	.set	reorder

$L91:
	.set	noreorder
	.set	nomacro
	j	$L99
	li	$2,0x00000006		# 6
	.set	macro
	.set	reorder

$L97:
	la	$4,$LC2
	jal	puts
	#.set	volatile
	lbu	$5,16($sp)
	#.set	novolatile
	la	$4,$LC3
	jal	printf
$L100:
	addu	$2,$0,$0
$L99:
	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	addu	$sp,$sp,48
	j	$31
	.end	CD_get_intr
	.rdata
	.align	2
$LC4:
	.ascii	"CD timeout: \000"
	.align	2
$LC5:
	.ascii	"%s:(%s) Sync=%s, Ready=%s\n\000"
	.align	2
$LC6:
	.ascii	"CD_sync\000"
	.text
	.align	2
	.globl	CD_sync
	.ent	CD_sync
CD_sync:
	.frame	$sp,64,$31		# vars= 0, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$22,48($sp)
	addu	$22,$4,$0
	sw	$23,52($sp)
	addu	$23,$5,$0
	li	$4,-1			# 0xffffffff
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	VSync
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	la	$fp,CD_comstr
	la	$20,CD_intstr
	la	$18,D_8013C224
	addu	$21,$18,1
	li	$19,0x00000002		# 2
	addu	$2,$2,960
	sw	$2,D_801489B4
	la	$2,$LC6
	sw	$0,D_801489B4+4
	sw	$2,D_801489B4+8
$L117:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,D_801489B4
	#nop
	slt	$3,$3,$2
	bne	$3,$0,$L121
	lw	$2,D_801489B4+4
	#nop
	addu	$3,$2,$0
	addu	$2,$2,1
	sw	$2,D_801489B4+4
	li	$2,0x003c0000		# 3932160
	slt	$2,$2,$3
	beq	$2,$0,$L120
$L121:
	la	$4,$LC4
	jal	puts
	#.set	volatile
	lbu	$4,0($18)
	#.set	novolatile
	#.set	volatile
	lbu	$2,1($18)
	#.set	novolatile
	lw	$5,D_801489B4+8
	sll	$2,$2,2
	addu	$2,$2,$20
	sll	$4,$4,2
	lw	$3,0($2)
	lbu	$2,CD_com
	addu	$4,$4,$20
	sll	$2,$2,2
	addu	$2,$2,$fp
	sw	$3,16($sp)
	lw	$6,0($2)
	lw	$7,0($4)
	la	$4,$LC5
	jal	printf
	jal	CD_flush
	.set	noreorder
	.set	nomacro
	j	$L123
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L120:
	addu	$2,$0,$0
$L123:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L141
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	jal	CheckCallback
	beq	$2,$0,$L125
	lw	$2,D_8013C20C
	#nop
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	#nop
	andi	$17,$2,0x0003
$L126:
	jal	CD_get_intr
	addu	$16,$2,$0
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L127
	andi	$2,$16,0x0004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L142
	andi	$2,$16,0x0002
	.set	macro
	.set	reorder

	lw	$2,CD_cbready
	#nop
	beq	$2,$0,$L130
	#.set	volatile
	lbu	$4,0($21)
	#.set	novolatile
	la	$5,D_801489A4
	jal	$31,$2
$L130:
	andi	$2,$16,0x0002
$L142:
	beq	$2,$0,$L126
	lw	$2,CD_cbsync
	#nop
	beq	$2,$0,$L126
	#.set	volatile
	lbu	$4,0($18)
	#.set	novolatile
	la	$5,D_8014899C
	jal	$31,$2
	j	$L126
$L127:
	lw	$2,D_8013C20C
	#nop
	#.set	volatile
	sb	$17,0($2)
	#.set	novolatile
$L125:
	#.set	volatile
	lbu	$2,0($18)
	#.set	novolatile
	#nop
	andi	$6,$2,0x00ff
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	beq	$6,$19,$L133
	li	$2,0x00000005		# 5
	.set	macro
	.set	reorder

	bne	$6,$2,$L132
$L133:
	#.set	volatile
	sb	$19,0($18)
	#.set	novolatile
	addu	$5,$23,$0
	la	$4,D_8014899C
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L134
	li	$3,0x00000007		# 7
	.set	macro
	.set	reorder

	li	$7,-1			# 0xffffffff
$L136:
	lbu	$2,0($4)
	addu	$4,$4,1
	addu	$3,$3,-1
	sb	$2,0($5)
	.set	noreorder
	.set	nomacro
	bne	$3,$7,$L136
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L134:
	.set	noreorder
	.set	nomacro
	j	$L141
	addu	$2,$6,$0
	.set	macro
	.set	reorder

$L132:
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L117
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L141:
	lw	$31,60($sp)
	lw	$fp,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,64
	j	$31
	.end	CD_sync
	.rdata
	.align	2
$LC7:
	.ascii	"CD_ready\000"
	.text
	.align	2
	.globl	CD_ready
	.ent	CD_ready
CD_ready:
	.frame	$sp,64,$31		# vars= 0, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$23,52($sp)
	addu	$23,$4,$0
	sw	$19,36($sp)
	addu	$19,$5,$0
	li	$4,-1			# 0xffffffff
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	VSync
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	la	$fp,CD_comstr
	la	$21,CD_intstr
	la	$18,D_8013C224
	addu	$22,$18,1
	addu	$20,$18,2
	addu	$2,$2,960
	sw	$2,D_801489B4
	la	$2,$LC7
	sw	$0,D_801489B4+4
	sw	$2,D_801489B4+8
$L144:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,D_801489B4
	#nop
	slt	$3,$3,$2
	bne	$3,$0,$L148
	lw	$2,D_801489B4+4
	#nop
	addu	$3,$2,$0
	addu	$2,$2,1
	sw	$2,D_801489B4+4
	li	$2,0x003c0000		# 3932160
	slt	$2,$2,$3
	beq	$2,$0,$L147
$L148:
	la	$4,$LC4
	jal	puts
	#.set	volatile
	lbu	$4,0($18)
	#.set	novolatile
	#.set	volatile
	lbu	$2,1($18)
	#.set	novolatile
	lw	$5,D_801489B4+8
	sll	$2,$2,2
	addu	$2,$2,$21
	sll	$4,$4,2
	lw	$3,0($2)
	lbu	$2,CD_com
	addu	$4,$4,$21
	sll	$2,$2,2
	addu	$2,$2,$fp
	sw	$3,16($sp)
	lw	$6,0($2)
	lw	$7,0($4)
	la	$4,$LC5
	jal	printf
	jal	CD_flush
	.set	noreorder
	.set	nomacro
	j	$L150
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L147:
	addu	$2,$0,$0
$L150:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L174
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	jal	CheckCallback
	beq	$2,$0,$L152
	lw	$2,D_8013C20C
	#nop
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	#nop
	andi	$17,$2,0x0003
$L153:
	jal	CD_get_intr
	addu	$16,$2,$0
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L154
	andi	$2,$16,0x0004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L175
	andi	$2,$16,0x0002
	.set	macro
	.set	reorder

	lw	$2,CD_cbready
	#nop
	beq	$2,$0,$L157
	#.set	volatile
	lbu	$4,0($22)
	#.set	novolatile
	la	$5,D_801489A4
	jal	$31,$2
$L157:
	andi	$2,$16,0x0002
$L175:
	beq	$2,$0,$L153
	lw	$2,CD_cbsync
	#nop
	beq	$2,$0,$L153
	#.set	volatile
	lbu	$4,0($18)
	#.set	novolatile
	la	$5,D_8014899C
	jal	$31,$2
	j	$L153
$L154:
	lw	$2,D_8013C20C
	#nop
	#.set	volatile
	sb	$17,0($2)
	#.set	novolatile
$L152:
	#.set	volatile
	lbu	$2,0($20)
	#.set	novolatile
	#nop
	andi	$6,$2,0x00ff
	beq	$6,$0,$L159
	#.set	volatile
	sb	$0,2($18)
	#.set	novolatile
	la	$4,D_801489AC
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L167
	addu	$5,$19,$0
	.set	macro
	.set	reorder

	li	$3,0x00000007		# 7
	li	$7,-1			# 0xffffffff
$L162:
	lbu	$2,0($4)
	addu	$4,$4,1
	addu	$3,$3,-1
	sb	$2,0($5)
	.set	noreorder
	.set	nomacro
	bne	$3,$7,$L162
	addu	$5,$5,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L174
	addu	$2,$6,$0
	.set	macro
	.set	reorder

$L159:
	#.set	volatile
	lbu	$2,-1($20)
	#.set	novolatile
	#nop
	andi	$6,$2,0x00ff
	beq	$6,$0,$L166
	#.set	volatile
	sb	$0,1($18)
	#.set	novolatile
	addu	$5,$19,$0
	la	$4,D_801489A4
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L167
	li	$3,0x00000007		# 7
	.set	macro
	.set	reorder

	li	$7,-1			# 0xffffffff
$L169:
	lbu	$2,0($4)
	addu	$4,$4,1
	addu	$3,$3,-1
	sb	$2,0($5)
	.set	noreorder
	.set	nomacro
	bne	$3,$7,$L169
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L167:
	.set	noreorder
	.set	nomacro
	j	$L174
	addu	$2,$6,$0
	.set	macro
	.set	reorder

$L166:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L144
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L174:
	lw	$31,60($sp)
	lw	$fp,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,64
	j	$31
	.end	CD_ready
	.rdata
	.align	2
$LC8:
	.ascii	"%s...\n\000"
	.align	2
$LC9:
	.ascii	"%s: no param\n\000"
	.align	2
$LC10:
	.ascii	"CD_cw\000"
	.text
	.align	2
	.globl	CD_cw
	.ent	CD_cw
CD_cw:
	.frame	$sp,56,$31		# vars= 0, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	lw	$2,CD_debug
	subu	$sp,$sp,56
	sw	$16,24($sp)
	addu	$16,$5,$0
	sw	$22,48($sp)
	addu	$22,$6,$0
	sw	$18,32($sp)
	addu	$18,$7,$0
	sw	$17,28($sp)
	addu	$17,$4,$0
	sw	$31,52($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L177
	sw	$19,36($sp)
	.set	macro
	.set	reorder

	andi	$2,$17,0x00ff
	sll	$2,$2,2
	lw	$5,CD_comstr($2)
	la	$4,$LC8
	jal	printf
$L177:
	andi	$2,$17,0x00ff
	sll	$3,$2,2
	lw	$2,_cd_param_count($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L220
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	bne	$16,$0,$L220
	lw	$2,CD_debug
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L218
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	lw	$5,CD_comstr($3)
	la	$4,$LC9
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L218
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

$L220:
	.set	noreorder
	.set	nomacro
	jal	CD_sync
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	andi	$3,$17,0x00ff
	li	$2,0x00000002		# 2
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L221
	li	$2,0x0000000e		# 14
	.set	macro
	.set	reorder

	addu	$4,$0,$0
	addu	$2,$16,$4
$L222:
	lbu	$2,0($2)
	#nop
	sb	$2,CD_pos($4)
	addu	$4,$4,1
	slt	$2,$4,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L222
	addu	$2,$16,$4
	.set	macro
	.set	reorder

	andi	$3,$17,0x00ff
	li	$2,0x0000000e		# 14
$L221:
	bne	$3,$2,$L186
	lbu	$2,0($16)
	#nop
	sb	$2,CD_mode
$L186:
	la	$5,D_8013C224
 #APP
 #NO_APP
	sll	$4,$3,2
	#.set	volatile
	sb	$0,0($5)
	#.set	novolatile
	lw	$2,_cd_result_flag($4)
	la	$3,_cd_result_flag
	beq	$2,$0,$L187
	#.set	volatile
	sb	$0,1($5)
	#.set	novolatile
$L187:
	lw	$2,D_8013C20C
 #APP
 #NO_APP
	#nop
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	addu	$2,$3,256
	addu	$3,$4,$2
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L188
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	addu	$6,$3,$0
	addu	$2,$16,$4
$L223:
	lw	$3,D_8013C214
	lbu	$2,0($2)
	#nop
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$2,0($6)
	addu	$4,$4,1
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L223
	addu	$2,$16,$4
	.set	macro
	.set	reorder

$L188:
	lw	$2,D_8013C210
 #APP
 #NO_APP
	sb	$17,CD_com
	#.set	volatile
	sb	$17,0($2)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L218
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	addu	$2,$2,960
	sw	$2,D_801489B4
	la	$2,$LC10
	la	$4,D_8013C224
	sw	$0,D_801489B4+4
	sw	$2,D_801489B4+8
	#.set	volatile
	lbu	$2,0($4)
	#.set	novolatile
	la	$21,CD_comstr
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L224
	addu	$6,$22,$0
	.set	macro
	.set	reorder

	la	$19,CD_intstr
	addu	$18,$4,$0
	addu	$20,$18,1
$L196:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,D_801489B4
	#nop
	slt	$3,$3,$2
	bne	$3,$0,$L198
	lw	$2,D_801489B4+4
	#nop
	addu	$3,$2,$0
	addu	$2,$2,1
	sw	$2,D_801489B4+4
	li	$2,0x003c0000		# 3932160
	slt	$2,$2,$3
	beq	$2,$0,$L197
$L198:
	la	$4,$LC4
	jal	puts
	#.set	volatile
	lbu	$4,0($18)
	#.set	novolatile
	#.set	volatile
	lbu	$2,1($18)
	#.set	novolatile
	lw	$5,D_801489B4+8
	sll	$2,$2,2
	addu	$2,$2,$19
	sll	$4,$4,2
	lw	$3,0($2)
	lbu	$2,CD_com
	addu	$4,$4,$19
	sll	$2,$2,2
	addu	$2,$2,$21
	sw	$3,16($sp)
	lw	$6,0($2)
	lw	$7,0($4)
	la	$4,$LC5
	jal	printf
	jal	CD_flush
	.set	noreorder
	.set	nomacro
	j	$L200
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L197:
	addu	$2,$0,$0
$L200:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L218
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	jal	CheckCallback
	beq	$2,$0,$L194
	lw	$2,D_8013C20C
	#nop
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	#nop
	andi	$17,$2,0x0003
$L204:
	jal	CD_get_intr
	addu	$16,$2,$0
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L205
	andi	$2,$16,0x0004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L225
	andi	$2,$16,0x0002
	.set	macro
	.set	reorder

	lw	$2,CD_cbready
	#nop
	beq	$2,$0,$L208
	#.set	volatile
	lbu	$4,0($20)
	#.set	novolatile
	la	$5,D_801489A4
	jal	$31,$2
$L208:
	andi	$2,$16,0x0002
$L225:
	beq	$2,$0,$L204
	lw	$2,CD_cbsync
	#nop
	beq	$2,$0,$L204
	#.set	volatile
	lbu	$4,0($18)
	#.set	novolatile
	la	$5,D_8014899C
	jal	$31,$2
	j	$L204
$L205:
	lw	$2,D_8013C20C
	#nop
	#.set	volatile
	sb	$17,0($2)
	#.set	novolatile
$L194:
	#.set	volatile
	lbu	$2,0($18)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L196
	addu	$6,$22,$0
	.set	macro
	.set	reorder

$L224:
	la	$4,D_8014899C
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L211
	li	$3,0x00000007		# 7
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
$L213:
	lbu	$2,0($4)
	addu	$4,$4,1
	addu	$3,$3,-1
	sb	$2,0($6)
	.set	noreorder
	.set	nomacro
	bne	$3,$5,$L213
	addu	$6,$6,1
	.set	macro
	.set	reorder

$L211:
	addu	$4,$0,$0
	la	$2,D_8013C224
 #APP
 #NO_APP
	lbu	$3,0($2)
	li	$2,0x00000005		# 5
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L218
	addu	$2,$4,$0
	.set	macro
	.set	reorder

	li	$4,-1			# 0xffffffff
 #APP
 #NO_APP
	addu	$2,$4,$0
$L218:
	lw	$31,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,56
	j	$31
	.end	CD_cw
	.align	2
	.globl	CD_flush
	.ent	CD_flush
CD_flush:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,D_8013C20C
	li	$2,0x00000001		# 1
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$2,D_8013C218
	#nop
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0007
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L228
	li	$4,0x00000001		# 1
	.set	macro
	.set	reorder

	li	$3,0x00000007		# 7
$L229:
	lw	$2,D_8013C20C
	#nop
	#.set	volatile
	sb	$4,0($2)
	#.set	novolatile
	lw	$2,D_8013C218
	#nop
	#.set	volatile
	sb	$3,0($2)
	#.set	novolatile
	lw	$2,D_8013C214
	#nop
	#.set	volatile
	sb	$3,0($2)
	#.set	novolatile
	lw	$2,D_8013C218
	#nop
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0007
	bne	$2,$0,$L229
$L228:
	la	$3,D_8013C224
 #APP
 #NO_APP
	#.set	volatile
	sb	$0,2($3)
	#.set	novolatile
	#.set	volatile
	lbu	$2,2($3)
	#.set	novolatile
 #APP
 #NO_APP
	#nop
	#.set	volatile
	sb	$2,1($3)
	#.set	novolatile
	lw	$4,D_8013C20C
	li	$2,0x00000002		# 2
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	#.set	volatile
	sb	$0,0($4)
	#.set	novolatile
	lw	$2,D_8013C218
	#nop
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$3,D_8013C21C
	li	$2,0x00001325		# 4901
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	j	$31
	.end	CD_flush
	.align	2
	.globl	CD_initvol
	.ent	CD_initvol
CD_initvol:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,D_8013C220
	#nop
	#.set	volatile
	lhu	$2,440($3)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L235
	subu	$sp,$sp,8
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,442($3)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L234
	li	$2,0x00003fff		# 16383
	.set	macro
	.set	reorder

	#.set	volatile
	sh	$2,384($3)
	#.set	novolatile
	#.set	volatile
	sh	$2,386($3)
	#.set	novolatile
	lw	$3,D_8013C220
$L235:
	li	$2,0x00003fff		# 16383
$L234:
	#.set	volatile
	sh	$2,432($3)
	#.set	novolatile
	#.set	volatile
	sh	$2,434($3)
	#.set	novolatile
	li	$2,0x0000c001		# 49153
	#.set	volatile
	sh	$2,426($3)
	#.set	novolatile
	lw	$3,D_8013C20C
	li	$2,0x00000080		# 128
	sb	$2,2($sp)
	sb	$2,0($sp)
	li	$2,0x00000002		# 2
	sb	$0,3($sp)
	sb	$0,1($sp)
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$3,D_8013C214
	lbu	$2,0($sp)
	#nop
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$3,D_8013C218
	lbu	$2,1($sp)
	#nop
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$3,D_8013C20C
	li	$2,0x00000003		# 3
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$3,D_8013C210
	lbu	$2,2($sp)
	#nop
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$3,D_8013C214
	lbu	$2,3($sp)
	#nop
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$3,D_8013C218
	li	$2,0x00000020		# 32
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	addu	$2,$0,$0
	addu	$sp,$sp,8
	j	$31
	.end	CD_initvol
	.align	2
	.globl	CD_initintr
	.ent	CD_initintr
CD_initintr:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	sw	$0,CD_cbready
	sw	$0,CD_cbsync
	sw	$0,CD_status1
	sw	$0,CD_status
	jal	ResetCallback
	la	$5,_cd_intr_dispatch
	.set	noreorder
	.set	nomacro
	jal	InterruptCallback
	li	$4,0x00000002		# 2
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	CD_initintr
	.rdata
	.align	2
$LC11:
	.ascii	"CD_init:\000"
	.align	2
$LC12:
	.ascii	"addr=%08x\n\000"
	.text
	.align	2
	.globl	CD_init_80108140
	.ent	CD_init_80108140
CD_init_80108140:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$4,$LC11
	sw	$31,16($sp)
	jal	puts
	la	$4,$LC12
	la	$5,D_8013C228
	jal	printf
	sb	$0,CD_com
	sb	$0,CD_mode
	sw	$0,CD_cbready
	sw	$0,CD_cbsync
	sw	$0,CD_status1
	sw	$0,CD_status
	jal	ResetCallback
	la	$5,_cd_intr_dispatch
	.set	noreorder
	.set	nomacro
	jal	InterruptCallback
	li	$4,0x00000002		# 2
	.set	macro
	.set	reorder

	lw	$3,D_8013C20C
	li	$2,0x00000001		# 1
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$2,D_8013C218
	#nop
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0007
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L239
	li	$4,0x00000001		# 1
	.set	macro
	.set	reorder

	li	$3,0x00000007		# 7
$L240:
	lw	$2,D_8013C20C
	#nop
	#.set	volatile
	sb	$4,0($2)
	#.set	novolatile
	lw	$2,D_8013C218
	#nop
	#.set	volatile
	sb	$3,0($2)
	#.set	novolatile
	lw	$2,D_8013C214
	#nop
	#.set	volatile
	sb	$3,0($2)
	#.set	novolatile
	lw	$2,D_8013C218
	#nop
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0007
	bne	$2,$0,$L240
$L239:
	la	$3,D_8013C224
 #APP
 #NO_APP
	#.set	volatile
	sb	$0,2($3)
	#.set	novolatile
	#.set	volatile
	lbu	$2,2($3)
	#.set	novolatile
 #APP
 #NO_APP
	li	$4,0x00000001		# 1
	addu	$5,$0,$0
	addu	$6,$0,$0
	#.set	volatile
	sb	$2,1($3)
	#.set	novolatile
	lw	$7,D_8013C20C
	li	$2,0x00000002		# 2
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	#.set	volatile
	sb	$0,0($7)
	#.set	novolatile
	lw	$2,D_8013C218
	addu	$7,$0,$0
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$3,D_8013C21C
	li	$2,0x00001325		# 4901
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	jal	CD_cw
	lw	$2,CD_status
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L242
	li	$4,0x00000001		# 1
	.set	macro
	.set	reorder

	addu	$5,$0,$0
	addu	$6,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	addu	$7,$0,$0
	.set	macro
	.set	reorder

$L242:
	li	$4,0x0000000a		# 10
	addu	$5,$0,$0
	addu	$6,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	addu	$7,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L246
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$4,0x0000000c		# 12
	addu	$5,$0,$0
	addu	$6,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	addu	$7,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L246
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	addu	$4,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CD_sync
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	li	$3,0x00000002		# 2
	bne	$2,$3,$L245
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L246
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L245:
 #APP
 #NO_APP
	li	$2,-1			# 0xffffffff
$L246:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	CD_init_80108140
	.rdata
	.align	2
$LC13:
	.ascii	"CD_datasync\000"
	.text
	.align	2
	.globl	CD_datasync
	.ent	CD_datasync
CD_datasync:
	.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,32($sp)
	addu	$18,$4,$0
	li	$4,-1			# 0xffffffff
	sw	$31,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	VSync
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	li	$20,0x003c0000		# 3932160
	la	$19,CD_comstr
	la	$17,D_8013C224
	la	$16,CD_intstr
	addu	$2,$2,960
	sw	$2,D_801489B4
	la	$2,$LC13
	sw	$0,D_801489B4+4
	sw	$2,D_801489B4+8
$L249:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,D_801489B4
	#nop
	slt	$3,$3,$2
	bne	$3,$0,$L253
	lw	$2,D_801489B4+4
	#nop
	addu	$3,$2,$0
	addu	$2,$2,1
	slt	$3,$20,$3
	sw	$2,D_801489B4+4
	beq	$3,$0,$L252
$L253:
	la	$4,$LC4
	jal	puts
	#.set	volatile
	lbu	$4,0($17)
	#.set	novolatile
	#.set	volatile
	lbu	$2,1($17)
	#.set	novolatile
	lw	$5,D_801489B4+8
	sll	$2,$2,2
	addu	$2,$2,$16
	sll	$4,$4,2
	lw	$3,0($2)
	lbu	$2,CD_com
	addu	$4,$4,$16
	sll	$2,$2,2
	addu	$2,$2,$19
	sw	$3,16($sp)
	lw	$6,0($2)
	lw	$7,0($4)
	la	$4,$LC5
	jal	printf
	jal	CD_flush
	.set	noreorder
	.set	nomacro
	j	$L255
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L252:
	addu	$2,$0,$0
$L255:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L260
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$2,D_8013C250
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	li	$3,0x01000000		# 16777216
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L260
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L249
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L260:
	lw	$31,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,48
	j	$31
	.end	CD_datasync
	.align	2
	.globl	CD_getsector
	.ent	CD_getsector
CD_getsector:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,D_8013C20C
	li	$6,0x00020000		# 131072
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$3,D_8013C218
	li	$2,0x00000080		# 128
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$2,D_8013C240
	ori	$6,$6,0x0943
	#.set	volatile
	sw	$6,0($2)
	#.set	novolatile
	lw	$3,D_8013C21C
	li	$2,0x00001323		# 4899
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,D_8013C244
	#nop
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	ori	$2,$2,0x8000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,D_8013C248
	#nop
	#.set	volatile
	sw	$4,0($2)
	#.set	novolatile
	li	$2,0x00010000		# 65536
	lw	$3,D_8013C24C
	or	$5,$5,$2
	#.set	volatile
	sw	$5,0($3)
	#.set	novolatile
	lw	$3,D_8013C20C
$L262:
	#.set	volatile
	lbu	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L262
	li	$2,0x11000000		# 285212672
	.set	macro
	.set	reorder

	lw	$3,D_8013C250
	#nop
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$4,D_8013C250
	#nop
	#.set	volatile
	lw	$2,0($4)
	#.set	novolatile
	li	$3,0x01000000		# 16777216
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L267
	addu	$3,$4,$0
	.set	macro
	.set	reorder

	li	$4,0x01000000		# 16777216
$L266:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	and	$2,$2,$4
	bne	$2,$0,$L266
$L267:
	lw	$3,D_8013C21C
	li	$2,0x00001325		# 4901
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.end	CD_getsector
	.align	2
	.globl	CD_getsector2
	.ent	CD_getsector2
CD_getsector2:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,D_8013C20C
	li	$6,0x21020000		# 553779200
	#.set	volatile
	sb	$0,0($2)
	#.set	novolatile
	lw	$3,D_8013C218
	li	$2,0x00000080		# 128
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	lw	$2,D_8013C240
	ori	$6,$6,0x0843
	#.set	volatile
	sw	$6,0($2)
	#.set	novolatile
	lw	$3,D_8013C21C
	li	$2,0x00001325		# 4901
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$3,D_8013C244
	#nop
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	ori	$2,$2,0x8000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lw	$2,D_8013C248
	#nop
	#.set	volatile
	sw	$4,0($2)
	#.set	novolatile
	li	$2,0x00010000		# 65536
	lw	$3,D_8013C24C
	or	$5,$5,$2
	#.set	volatile
	sw	$5,0($3)
	#.set	novolatile
	lw	$3,D_8013C20C
	#nop
	#.set	volatile
	lbu	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L272
	subu	$sp,$sp,8
	.set	macro
	.set	reorder

$L271:
	#.set	volatile
	lbu	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0040
	beq	$2,$0,$L271
$L272:
	li	$3,0x11400000		# 289406976
	lw	$2,D_8013C250
	ori	$3,$3,0x0100
	#.set	volatile
	sw	$3,0($2)
	#.set	novolatile
	lw	$2,D_8013C250
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,0($sp)
	#.set	novolatile
	addu	$2,$0,$0
	addu	$sp,$sp,8
	j	$31
	.end	CD_getsector2
	.align	2
	.globl	CD_set_test_parmnum
	.ent	CD_set_test_parmnum
CD_set_test_parmnum:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$4,D_8013C1F0
	j	$31
	.end	CD_set_test_parmnum
	.align	2
	.globl	_cd_intr_dispatch
	.ent	_cd_intr_dispatch
_cd_intr_dispatch:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	lw	$2,D_8013C20C
	subu	$sp,$sp,40
	sw	$17,20($sp)
	la	$17,D_8013C224+1
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	addu	$19,$17,-1
	andi	$18,$2,0x0003
$L278:
	jal	CD_get_intr
	addu	$16,$2,$0
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L279
	andi	$2,$16,0x0004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L284
	andi	$2,$16,0x0002
	.set	macro
	.set	reorder

	lw	$2,CD_cbready
	#nop
	beq	$2,$0,$L282
	#.set	volatile
	lbu	$4,0($17)
	#.set	novolatile
	la	$5,D_801489A4
	jal	$31,$2
$L282:
	andi	$2,$16,0x0002
$L284:
	beq	$2,$0,$L278
	lw	$2,CD_cbsync
	#nop
	beq	$2,$0,$L278
	#.set	volatile
	lbu	$4,0($19)
	#.set	novolatile
	la	$5,D_8014899C
	jal	$31,$2
	j	$L278
$L279:
	lw	$2,D_8013C20C
	#nop
	#.set	volatile
	sb	$18,0($2)
	#.set	novolatile
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,40
	j	$31
	.end	_cd_intr_dispatch
