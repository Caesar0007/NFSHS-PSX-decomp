	.file	1 "C:\\Temp\\nfs4-decomp\\scratchpad\\w84\\C3_LIBMCRD.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	MemCardInit
	.ent	MemCardInit
MemCardInit:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	sw	$0,_mc_present
	sw	$0,mc+64
	jal	_card_open
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	MemCardInit
	.align	2
	.globl	MemCardEnd
	.ent	MemCardEnd
MemCardEnd:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	_card_close
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	MemCardEnd
	.align	2
	.globl	MemCardStart
	.ent	MemCardStart
MemCardStart:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	UserFuncInit
	la	$2,mc
 #APP
 #NO_APP
	li	$3,-1			# 0xffffffff
	sw	$0,0($2)
	sw	$0,4($2)
	sw	$0,8($2)
	.set	noreorder
	.set	nomacro
	jal	_card_start
	sw	$3,16($2)
	.set	macro
	.set	reorder

	la	$5,MemCardStart_cb
	.set	noreorder
	.set	nomacro
	jal	VSyncCallbacks
	li	$4,0x00000007		# 7
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	MemCardStart
	.align	2
	.globl	MemCardStop
	.ent	MemCardStop
MemCardStop:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$3,mc
	sw	$31,16($sp)
$L9:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L9
	li	$4,0x00000007		# 7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSyncCallbacks
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	jal	_card_stop
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	MemCardStop
	.rdata
	.align	2
$LC0:
	.ascii	"Access Denied. : event multiple open\n\000"
	.text
	.align	2
	.globl	MemCardExist
	.ent	MemCardExist
MemCardExist:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$3,mc
	sw	$31,16($sp)
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L11
	addu	$5,$4,$0
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	la	$4,MemCardExist_cb
	li	$2,0x00000001		# 1
	sw	$2,0($3)
	sw	$0,4($3)
	sw	$0,8($3)
	.set	noreorder
	.set	nomacro
	jal	UserFuncOpen
	sw	$5,12($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L12
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L11:
	la	$4,$LC0
	jal	printf
	addu	$2,$0,$0
$L12:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	MemCardExist
	.align	2
	.ent	MemCardExist_cb
MemCardExist_cb:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	addu	$16,$4,$0
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$3,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L15
	li	$2,0x0000000a		# 10
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$3,$L17
	li	$17,0x0000000a		# 10
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$17,$L16
	li	$2,0x0000000b		# 11
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L18
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	j	$L31
$L15:
	sw	$0,_mc_exrslt
	sw	$0,_mc_exretry
	sw	$2,0($16)
$L16:
	jal	_clr_card_event
	lw	$4,mc+12
	jal	_card_info
	lw	$2,0($16)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L17
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L18:
	jal	_chk_card_event
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L31
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	jal	_get_card_event
	addu	$3,$2,$0
	sw	$2,_mc_exrslt
	slt	$2,$3,3
	beq	$2,$0,$L20
	bgtz	$3,$L22
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L24
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	j	$L25
$L20:
	li	$2,0x00000004		# 4
	bne	$3,$2,$L25
	.set	noreorder
	.set	nomacro
	jal	MemCardEventToRslt
	li	$4,0x00000004		# 4
	.set	macro
	.set	reorder

	la	$3,mc
 #APP
 #NO_APP
	sw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L31
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L24:
	la	$16,mc+12
	lw	$4,0($16)
	lw	$3,_mc_present
	sll	$2,$2,$4
	and	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L27
	li	$2,0x00000004		# 4
	.set	macro
	.set	reorder

	sw	$2,_mc_exrslt
$L27:
	lw	$4,_mc_exrslt
	jal	MemCardEventToRslt
	addu	$4,$2,$0
	li	$2,0x00000001		# 1
 #APP
 #NO_APP
	addu	$3,$16,-12
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L31
	sw	$4,4($3)
	.set	macro
	.set	reorder

$L22:
	lw	$2,_mc_exretry
	#nop
	addu	$2,$2,1
	sw	$2,_mc_exretry
	slt	$2,$2,5
	beq	$2,$0,$L25
	.set	noreorder
	.set	nomacro
	j	$L17
	sw	$17,0($16)
	.set	macro
	.set	reorder

$L25:
	la	$16,mc+12
 #APP
 #NO_APP
	li	$2,0x00000001		# 1
 #APP
 #NO_APP
	lw	$3,0($16)
	lw	$4,_mc_exrslt
	sll	$2,$2,$3
	lw	$3,_mc_present
	nor	$2,$0,$2
	and	$3,$3,$2
	sw	$3,_mc_present
	.set	noreorder
	.set	nomacro
	jal	MemCardEventToRslt
	addu	$16,$16,-12
	.set	macro
	.set	reorder

	addu	$3,$2,$0
 #APP
 #NO_APP
	li	$2,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	j	$L31
	sw	$3,4($16)
	.set	macro
	.set	reorder

$L17:
	addu	$2,$0,$0
$L31:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	MemCardExist_cb
	.align	2
	.globl	MemCardAccept
	.ent	MemCardAccept
MemCardAccept:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$3,mc
	sw	$31,16($sp)
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L33
	addu	$5,$4,$0
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	la	$4,MemCardCmd_cb
	li	$2,0x00000002		# 2
	sw	$2,0($3)
	sw	$0,4($3)
	sw	$0,8($3)
	.set	noreorder
	.set	nomacro
	jal	UserFuncOpen
	sw	$5,12($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L34
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L33:
	la	$4,$LC0
	jal	printf
	addu	$2,$0,$0
$L34:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	MemCardAccept
	.align	2
	.ent	MemCardCmd_cb
MemCardCmd_cb:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	addu	$16,$4,$0
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$3,0($16)
 #APP
 #NO_APP
	#nop
	sltu	$2,$3,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L38
	sll	$2,$3,2
	.set	macro
	.set	reorder

	lw	$2,$L60($2)
	#nop
	j	$2
	.rdata
	.align	3
$L60:
	.word	$L37
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L39
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L43
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L38
	.word	$L45
	.word	$L46
	.text
$L37:
	la	$4,MemCardExist_cb
	sw	$0,_mc_cleared
	sw	$0,_mc_evrslt
	sw	$0,_mc_retry
	jal	UserFuncOpen
	li	$2,0x0000000a		# 10
	.set	noreorder
	.set	nomacro
	j	$L38
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L39:
	la	$17,mc+4
 #APP
 #NO_APP
	lw	$3,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L41
	li	$2,0x00000003		# 3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L61
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	lw	$4,8($17)
	lw	$2,_mc_present
	li	$3,0x00000001		# 1
	sw	$3,_mc_cleared
	sll	$3,$3,$4
	or	$2,$2,$3
	sw	$2,_mc_present
	jal	_clr_card_event
	lw	$4,8($17)
	jal	_card_clear
	li	$2,0x00000015		# 21
	.set	noreorder
	.set	nomacro
	j	$L38
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L43:
	jal	_chk_card_event_x
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L61
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	jal	_get_card_event_x
	li	$2,0x0000001e		# 30
	sw	$2,0($16)
$L45:
	jal	_clr_card_event
	lw	$4,mc+12
	jal	_card_load
	lw	$2,0($16)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L38
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L46:
	jal	_chk_card_event
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L61
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	jal	_get_card_event
	addu	$3,$2,$0
	sw	$2,_mc_evrslt
	slt	$2,$3,3
	beq	$2,$0,$L48
	bgtz	$3,$L50
	beq	$3,$0,$L52
	j	$L53
$L48:
	li	$2,0x00000004		# 4
	beq	$3,$2,$L50
	j	$L53
$L52:
	lw	$2,_mc_cleared
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L55
	addu	$3,$0,$0
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	li	$3,0x00000003		# 3
$L55:
	la	$2,mc
 #APP
 #NO_APP
	sw	$3,4($2)
	.set	noreorder
	.set	nomacro
	j	$L61
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L50:
	lw	$2,_mc_retry
	#nop
	addu	$2,$2,1
	sw	$2,_mc_retry
	slt	$2,$2,5
	beq	$2,$0,$L53
$L41:
	li	$2,0x0000001e		# 30
	.set	noreorder
	.set	nomacro
	j	$L38
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L53:
	lw	$4,_mc_evrslt
	li	$2,0x00000004		# 4
	bne	$4,$2,$L58
	la	$2,mc
 #APP
 #NO_APP
	sw	$4,4($2)
	.set	noreorder
	.set	nomacro
	j	$L61
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L58:
	jal	MemCardEventToRslt
	la	$3,mc
 #APP
 #NO_APP
	sw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L61
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L38:
	addu	$2,$0,$0
$L61:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	MemCardCmd_cb
	.rdata
	.align	2
$LC1:
	.ascii	"Access Denied. : file already open.\n\000"
	.align	2
$LC2:
	.ascii	"Access Denied. : file not open.\n\000"
	.align	2
$LC3:
	.ascii	"Access Denied. : invalid data size align\n\000"
	.align	2
$LC4:
	.ascii	"Access Denied. : invalid offset value align\n\000"
	.text
	.align	2
	.globl	MemCardReadData
	.ent	MemCardReadData
MemCardReadData:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$7,mc+16
	sw	$31,16($sp)
 #APP
 #NO_APP
	lw	$2,0($7)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L64
	addu	$8,$4,$0
	.set	macro
	.set	reorder

	la	$4,$LC2
	j	$L65
$L64:
 #APP
 #NO_APP
	lw	$2,-16($7)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L66
	addu	$3,$7,-16
	.set	macro
	.set	reorder

	la	$4,$LC0
	j	$L65
$L66:
 #APP
 #NO_APP
	andi	$2,$6,0x007f
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L68
	andi	$2,$5,0x007f
	.set	macro
	.set	reorder

	la	$4,$LC3
	j	$L65
$L68:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L70
	li	$2,0x00000005		# 5
	.set	macro
	.set	reorder

	la	$4,MemCardReadData_cb
	sw	$2,-16($7)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$5,20($3)
	sw	$8,28($3)
	.set	noreorder
	.set	nomacro
	jal	UserFuncOpen
	sw	$6,24($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L72
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L70:
	la	$4,$LC4
$L65:
	jal	printf
	addu	$2,$0,$0
$L72:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	MemCardReadData
	.align	2
	.ent	MemCardReadData_cb
MemCardReadData_cb:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	addu	$17,$4,$0
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$3,0($17)
	li	$16,0x0000000a		# 10
	.set	noreorder
	.set	nomacro
	beq	$3,$16,$L75
	slt	$2,$3,11
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L79
	li	$2,0x0000001e		# 30
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L82
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	j	$L96
$L79:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L84
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	j	$L96
$L82:
	sw	$0,_mc_rd_retry
	sw	$16,0($17)
$L75:
	la	$16,mc+16
$L85:
	lw	$4,0($16)
	lw	$5,4($16)
	.set	noreorder
	.set	nomacro
	jal	lseek
	addu	$6,$0,$0
	.set	macro
	.set	reorder

	lw	$3,4($16)
	#nop
	bne	$2,$3,$L85
	jal	_clr_card_event
	la	$16,mc+16
$L89:
	lw	$4,0($16)
	lw	$5,12($16)
	lw	$6,8($16)
	jal	read
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L89
	li	$2,0x0000001e		# 30
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L80
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L84:
	jal	_chk_card_event
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L96
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	jal	_get_card_event
	addu	$4,$2,$0
	beq	$4,$0,$L94
	lw	$2,_mc_rd_retry
	#nop
	addu	$2,$2,1
	sw	$2,_mc_rd_retry
	slt	$2,$2,4
	beq	$2,$0,$L97
	.set	noreorder
	.set	nomacro
	j	$L80
	sw	$16,0($17)
	.set	macro
	.set	reorder

$L94:
	addu	$4,$0,$0
$L97:
	jal	MemCardEventToRslt
	la	$3,mc
 #APP
 #NO_APP
	sw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L96
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L80:
	addu	$2,$0,$0
$L96:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	MemCardReadData_cb
	.align	2
	.globl	MemCardWriteData
	.ent	MemCardWriteData
MemCardWriteData:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$7,mc+16
	sw	$31,16($sp)
 #APP
 #NO_APP
	lw	$2,0($7)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L99
	addu	$8,$4,$0
	.set	macro
	.set	reorder

	la	$4,$LC2
	j	$L100
$L99:
 #APP
 #NO_APP
	lw	$2,-16($7)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L101
	addu	$3,$7,-16
	.set	macro
	.set	reorder

	la	$4,$LC0
	j	$L100
$L101:
 #APP
 #NO_APP
	andi	$2,$6,0x007f
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L103
	andi	$2,$5,0x007f
	.set	macro
	.set	reorder

	la	$4,$LC3
	j	$L100
$L103:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L105
	li	$2,0x00000006		# 6
	.set	macro
	.set	reorder

	la	$4,MemCardWriteData_cb
	sw	$2,-16($7)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$5,20($3)
	sw	$8,28($3)
	.set	noreorder
	.set	nomacro
	jal	UserFuncOpen
	sw	$6,24($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L107
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L105:
	la	$4,$LC4
$L100:
	jal	printf
	addu	$2,$0,$0
$L107:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	MemCardWriteData
	.align	2
	.ent	MemCardWriteData_cb
MemCardWriteData_cb:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	addu	$17,$4,$0
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$3,0($17)
	li	$16,0x0000000a		# 10
	.set	noreorder
	.set	nomacro
	beq	$3,$16,$L110
	slt	$2,$3,11
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L114
	li	$2,0x0000001e		# 30
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L117
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	j	$L131
$L114:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L119
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	j	$L131
$L117:
	sw	$0,_mc_wr_retry
	.set	noreorder
	.set	nomacro
	j	$L115
	sw	$16,0($17)
	.set	macro
	.set	reorder

$L119:
	jal	_chk_card_event
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L131
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	jal	_get_card_event
	addu	$4,$2,$0
	beq	$4,$0,$L121
	lw	$2,_mc_wr_retry
	#nop
	addu	$2,$2,1
	sw	$2,_mc_wr_retry
	slt	$2,$2,4
	beq	$2,$0,$L132
	.set	noreorder
	.set	nomacro
	j	$L115
	sw	$16,0($17)
	.set	macro
	.set	reorder

$L121:
	addu	$4,$0,$0
$L132:
	jal	MemCardEventToRslt
	la	$3,mc
 #APP
 #NO_APP
	sw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L131
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L110:
	la	$16,mc+16
$L123:
	lw	$4,0($16)
	lw	$5,4($16)
	.set	noreorder
	.set	nomacro
	jal	lseek
	addu	$6,$0,$0
	.set	macro
	.set	reorder

	lw	$3,4($16)
	#nop
	bne	$2,$3,$L123
	jal	_clr_card_event
	la	$16,mc+16
$L127:
	lw	$4,0($16)
	lw	$5,12($16)
	lw	$6,8($16)
	jal	write
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L127
	li	$2,0x0000001e		# 30
	.set	macro
	.set	reorder

	sw	$2,0($17)
$L115:
	addu	$2,$0,$0
$L131:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	MemCardWriteData_cb
	.rdata
	.align	2
$LC5:
	.ascii	"Access Denied. : system busy\n\000"
	.text
	.align	2
	.globl	MemCardReadFile
	.ent	MemCardReadFile
MemCardReadFile:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$20,32($sp)
	addu	$20,$4,$0
	sw	$19,28($sp)
	addu	$19,$5,$0
	sw	$21,36($sp)
	addu	$21,$6,$0
	sw	$18,24($sp)
	addu	$18,$7,$0
	sw	$17,20($sp)
	la	$17,mc
 #APP
 #NO_APP
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$16,16($sp)
	lw	$2,0($17)
	lw	$22,64($sp)
	blez	$2,$L134
	la	$4,$LC5
	j	$L135
$L134:
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L136
	andi	$2,$22,0x007f
	.set	macro
	.set	reorder

	la	$4,$LC1
	j	$L135
$L136:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L139
	andi	$2,$18,0x007f
	.set	macro
	.set	reorder

	la	$4,$LC3
	j	$L135
$L139:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L141
	addu	$4,$20,$0
	.set	macro
	.set	reorder

	addu	$16,$17,32
	.set	noreorder
	.set	nomacro
	jal	MemCardMakeDevname
	addu	$5,$16,$0
	.set	macro
	.set	reorder

	addu	$4,$16,$0
	.set	noreorder
	.set	nomacro
	jal	strcat
	addu	$5,$19,$0
	.set	macro
	.set	reorder

	la	$4,MemCardReadFile_cb
	li	$2,0x00000003		# 3
	sw	$2,0($17)
	sw	$0,4($17)
	sw	$0,8($17)
	sw	$18,20($17)
	sw	$21,28($17)
	sw	$22,24($17)
	.set	noreorder
	.set	nomacro
	jal	UserFuncOpen
	sw	$20,12($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L143
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L141:
	la	$4,$LC4
$L135:
	jal	printf
	addu	$2,$0,$0
$L143:
	lw	$31,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,48
	j	$31
	.end	MemCardReadFile
	.align	2
	.ent	MemCardReadFile_cb
MemCardReadFile_cb:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	addu	$17,$4,$0
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$3,0($17)
	li	$16,0x0000000a		# 10
	.set	noreorder
	.set	nomacro
	beq	$3,$16,$L146
	slt	$2,$3,11
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L150
	li	$2,0x0000000b		# 11
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L153
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	j	$L160
$L150:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L155
	li	$2,0x00000014		# 20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L157
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	j	$L160
$L153:
	la	$4,MemCardExist_cb
	sw	$0,_mc_rf_retry
	jal	UserFuncOpen
	.set	noreorder
	.set	nomacro
	j	$L151
	sw	$16,0($17)
	.set	macro
	.set	reorder

$L146:
	la	$16,mc+4
	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L160
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	addu	$4,$16,28
	.set	noreorder
	.set	nomacro
	jal	open
	li	$5,0x00008001		# 32769
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$2,$L155
	sw	$2,12($16)
	.set	macro
	.set	reorder

	addu	$3,$16,-4
 #APP
 #NO_APP
	li	$2,0x00000005		# 5
 #APP
 #NO_APP
	sw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L160
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L155:
	li	$2,0x00000014		# 20
	la	$4,MemCardReadData_cb
	.set	noreorder
	.set	nomacro
	jal	UserFuncOpen
	sw	$2,0($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L160
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L157:
	la	$16,mc+16
	lw	$4,0($16)
	jal	close
	li	$2,0x00000001		# 1
	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	j	$L160
	sw	$3,0($16)
	.set	macro
	.set	reorder

$L151:
	addu	$2,$0,$0
$L160:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	MemCardReadFile_cb
	.align	2
	.globl	MemCardWriteFile
	.ent	MemCardWriteFile
MemCardWriteFile:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$20,32($sp)
	addu	$20,$4,$0
	sw	$19,28($sp)
	addu	$19,$5,$0
	sw	$21,36($sp)
	addu	$21,$6,$0
	sw	$18,24($sp)
	addu	$18,$7,$0
	sw	$17,20($sp)
	la	$17,mc
 #APP
 #NO_APP
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$16,16($sp)
	lw	$2,0($17)
	lw	$22,64($sp)
	blez	$2,$L162
	la	$4,$LC5
	j	$L163
$L162:
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L164
	andi	$2,$22,0x007f
	.set	macro
	.set	reorder

	la	$4,$LC1
	j	$L163
$L164:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L167
	andi	$2,$18,0x007f
	.set	macro
	.set	reorder

	la	$4,$LC3
	j	$L163
$L167:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L169
	addu	$4,$20,$0
	.set	macro
	.set	reorder

	addu	$16,$17,32
	.set	noreorder
	.set	nomacro
	jal	MemCardMakeDevname
	addu	$5,$16,$0
	.set	macro
	.set	reorder

	addu	$4,$16,$0
	.set	noreorder
	.set	nomacro
	jal	strcat
	addu	$5,$19,$0
	.set	macro
	.set	reorder

	la	$4,MemCardWriteFile_cb
	li	$2,0x00000004		# 4
	sw	$2,0($17)
	sw	$0,4($17)
	sw	$0,8($17)
	sw	$18,20($17)
	sw	$21,28($17)
	sw	$22,24($17)
	.set	noreorder
	.set	nomacro
	jal	UserFuncOpen
	sw	$20,12($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L171
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L169:
	la	$4,$LC4
$L163:
	jal	printf
	addu	$2,$0,$0
$L171:
	lw	$31,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,48
	j	$31
	.end	MemCardWriteFile
	.align	2
	.ent	MemCardWriteFile_cb
MemCardWriteFile_cb:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	addu	$17,$4,$0
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$3,0($17)
	li	$16,0x0000000a		# 10
	.set	noreorder
	.set	nomacro
	beq	$3,$16,$L174
	slt	$2,$3,11
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L178
	li	$2,0x0000000b		# 11
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L181
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	j	$L188
$L178:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L183
	li	$2,0x00000014		# 20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L185
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	j	$L188
$L181:
	la	$4,MemCardExist_cb
	sw	$0,_mc_wf_retry
	jal	UserFuncOpen
	.set	noreorder
	.set	nomacro
	j	$L179
	sw	$16,0($17)
	.set	macro
	.set	reorder

$L174:
	la	$16,mc+4
	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L188
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	addu	$4,$16,28
	.set	noreorder
	.set	nomacro
	jal	open
	li	$5,0x00008001		# 32769
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$2,$L183
	sw	$2,12($16)
	.set	macro
	.set	reorder

	addu	$3,$16,-4
 #APP
 #NO_APP
	li	$2,0x00000005		# 5
 #APP
 #NO_APP
	sw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L188
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L183:
	li	$2,0x00000014		# 20
	la	$4,MemCardWriteData_cb
	.set	noreorder
	.set	nomacro
	jal	UserFuncOpen
	sw	$2,0($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L188
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L185:
	la	$16,mc+16
	lw	$4,0($16)
	jal	close
	li	$2,0x00000001		# 1
	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	j	$L188
	sw	$3,0($16)
	.set	macro
	.set	reorder

$L179:
	addu	$2,$0,$0
$L188:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	MemCardWriteFile_cb
	.align	2
	.globl	MemCardGetDirentry
	.ent	MemCardGetDirentry
MemCardGetDirentry:
	.frame	$sp,144,$31		# vars= 88, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,144
	sw	$23,132($sp)
	addu	$23,$4,$0
	sw	$16,104($sp)
	addu	$16,$5,$0
	sw	$22,128($sp)
	addu	$22,$6,$0
 #APP
 #NO_APP
	sw	$19,116($sp)
	la	$19,mc
	sw	$31,140($sp)
	sw	$fp,136($sp)
	sw	$21,124($sp)
	sw	$20,120($sp)
	sw	$18,112($sp)
	sw	$17,108($sp)
	sw	$7,92($sp)
	lw	$2,0($19)
	#.set	volatile
	lw	$fp,160($sp)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L190
	addu	$4,$23,$0
	.set	macro
	.set	reorder

	la	$4,$LC5
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L210
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L190:
	.set	noreorder
	.set	nomacro
	jal	MemCardMakeDevname
	addu	$5,$sp,16
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	strcat
	addu	$5,$16,$0
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	addu	$18,$0,$0
	addu	$17,$0,$0
	li	$3,0x00000001		# 1
	sw	$0,88($sp)
	lw	$4,12($19)
	lw	$2,_mc_present
	lw	$8,164($sp)
	sll	$3,$3,$4
	or	$2,$2,$3
	sw	$2,_mc_present
	addu	$2,$fp,$8
	.set	noreorder
	.set	nomacro
	blez	$2,$L191
	addu	$21,$0,$0
	.set	macro
	.set	reorder

	addu	$8,$sp,80
	sw	$8,96($sp)
	addu	$20,$0,$0
$L192:
 #APP
 #NO_APP
	bne	$17,$0,$L195
$L196:
	jal	_clr_card_event
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	firstfile
	addu	$5,$sp,48
	.set	macro
	.set	reorder

	addu	$16,$2,$0
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L212
	slt	$2,$17,$fp
	.set	macro
	.set	reorder

	jal	_get_card_event_x
	.set	noreorder
	.set	nomacro
	jal	MemCardEventToRslt
	addu	$4,$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L204
	sw	$2,88($sp)
	.set	macro
	.set	reorder

	addu	$18,$18,1
	slt	$2,$18,4
	bne	$2,$0,$L196
	.set	noreorder
	.set	nomacro
	jal	MemCardCallback
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	lw	$3,0($19)
	sw	$2,_mc_save_cb
	.set	noreorder
	.set	nomacro
	blez	$3,$L202
	li	$8,0x00000002		# 2
	.set	macro
	.set	reorder

	la	$4,$LC0
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L213
	addu	$4,$0,$0
	.set	macro
	.set	reorder

$L202:
	la	$4,MemCardCmd_cb
	sw	$8,0($19)
	sw	$0,4($19)
	sw	$0,8($19)
	sw	$23,mc+12
	jal	UserFuncOpen
	addu	$4,$0,$0
$L213:
	addu	$5,$0,$0
	.set	noreorder
	.set	nomacro
	jal	MemCardSync
	addu	$6,$sp,88
	.set	macro
	.set	reorder

	lw	$4,_mc_save_cb
	jal	MemCardCallback
	lw	$2,88($sp)
	j	$L210
$L195:
	.set	noreorder
	.set	nomacro
	jal	nextfile
	addu	$4,$sp,48
	.set	macro
	.set	reorder

	addu	$16,$2,$0
$L204:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L191
	slt	$2,$17,$fp
	.set	macro
	.set	reorder

$L212:
	bne	$2,$0,$L206
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L206
	addu	$7,$20,$22
	.set	macro
	.set	reorder

	addu	$6,$sp,48
$L207:
	lw	$2,0($6)
	lw	$3,4($6)
	lw	$4,8($6)
	lw	$5,12($6)
	sw	$2,0($7)
	sw	$3,4($7)
	sw	$4,8($7)
	sw	$5,12($7)
	addu	$6,$6,16
	lw	$8,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$6,$8,$L207
	addu	$7,$7,16
	.set	macro
	.set	reorder

	lw	$2,0($6)
	lw	$3,4($6)
	sw	$2,0($7)
	sw	$3,4($7)
	addu	$20,$20,40
	addu	$21,$21,1
$L206:
	lw	$8,164($sp)
	addu	$17,$17,1
	addu	$2,$fp,$8
	slt	$2,$17,$2
	bne	$2,$0,$L192
$L191:
 #APP
 #NO_APP
	lw	$7,92($sp)
 #APP
 #NO_APP
	#nop
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L210
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	sw	$21,0($7)
$L210:
	lw	$31,140($sp)
	lw	$fp,136($sp)
	lw	$23,132($sp)
	lw	$22,128($sp)
	lw	$21,124($sp)
	lw	$20,120($sp)
	lw	$19,116($sp)
	lw	$18,112($sp)
	lw	$17,108($sp)
	lw	$16,104($sp)
	addu	$sp,$sp,144
	j	$31
	.end	MemCardGetDirentry
	.align	2
	.globl	MemCardCallback
	.ent	MemCardCallback
MemCardCallback:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	la	$3,mc+64
	lw	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,0($3)
	.set	macro
	.set	reorder

	.end	MemCardCallback
	.align	2
	.globl	MemCardSync
	.ent	MemCardSync
MemCardSync:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	la	$3,mc
 #APP
 #NO_APP
	lw	$2,0($3)
	#nop
	bne	$2,$0,$L246
	lw	$2,8($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L260
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L246:
	lw	$8,0($3)
	lw	$7,4($3)
	bne	$4,$0,$L247
	lw	$2,8($3)
	#nop
	bne	$2,$0,$L248
	addu	$3,$3,8
$L251:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	beq	$2,$0,$L251
$L248:
	beq	$6,$0,$L253
	la	$2,_mc_sync+4
 #APP
 #NO_APP
	lw	$2,0($2)
	#nop
	sw	$2,0($6)
$L253:
	beq	$5,$0,$L254
	la	$2,_mc_sync
 #APP
 #NO_APP
	lw	$2,0($2)
	#nop
	sw	$2,0($5)
$L254:
	la	$2,mc
 #APP
 #NO_APP
	sw	$0,8($2)
	li	$2,0x00000001		# 1
 #APP
 #NO_APP
	j	$L261
$L247:
	lw	$2,8($3)
	#nop
	bne	$2,$0,$L255
	beq	$6,$0,$L256
	sw	$7,0($6)
$L256:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L261
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L261
	sw	$8,0($5)
	.set	macro
	.set	reorder

$L255:
	beq	$6,$0,$L258
	la	$2,_mc_sync+4
 #APP
 #NO_APP
	lw	$2,0($2)
	#nop
	sw	$2,0($6)
$L258:
	beq	$5,$0,$L259
	la	$2,_mc_sync
 #APP
 #NO_APP
	lw	$2,0($2)
	#nop
	sw	$2,0($5)
$L259:
	sw	$0,8($3)
	li	$2,0x00000001		# 1
$L260:
$L261:
	j	$31
	.end	MemCardSync
	.align	2
	.globl	MemCardCreateFile
	.ent	MemCardCreateFile
MemCardCreateFile:
	.frame	$sp,80,$31		# vars= 40, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$19,68($sp)
	addu	$19,$4,$0
	sw	$16,56($sp)
	addu	$16,$5,$0
	sw	$20,72($sp)
	addu	$20,$6,$0
	sw	$18,64($sp)
	la	$18,mc
	sw	$31,76($sp)
	sw	$17,60($sp)
 #APP
 #NO_APP
	lw	$2,0($18)
 #APP
 #NO_APP
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L263
	addu	$17,$0,$0
	.set	macro
	.set	reorder

	la	$4,$LC5
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L295
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L263:
	addu	$4,$19,$0
	.set	noreorder
	.set	nomacro
	jal	MemCardMakeDevname
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	strcat
	addu	$5,$16,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	li	$5,0x00000001		# 1
 #APP
 #NO_APP
	li	$2,0x00000001		# 1
	lw	$6,12($18)
	lw	$3,_mc_present
	sll	$2,$2,$6
	or	$3,$3,$2
	sw	$3,_mc_present
	jal	open
	.set	noreorder
	.set	nomacro
	bltz	$2,$L265
	sll	$20,$20,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	close
	addu	$4,$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L295
	li	$2,0x00000006		# 6
	.set	macro
	.set	reorder

$L266:
	.set	noreorder
	.set	nomacro
	j	$L295
	li	$2,0x00000007		# 7
	.set	macro
	.set	reorder

$L265:
	addu	$16,$18,$0
	li	$18,0x00000002		# 2
$L269:
	addu	$4,$sp,16
$L296:
	.set	noreorder
	.set	nomacro
	jal	open
	ori	$5,$20,0x0200
	.set	macro
	.set	reorder

	bgez	$2,$L271
	.set	noreorder
	.set	nomacro
	jal	MemCardCallback
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	lw	$3,0($16)
	sw	$2,_mc_save_cb
	blez	$3,$L272
	la	$4,$LC0
	jal	printf
	j	$L273
$L272:
 #APP
 #NO_APP
	la	$4,MemCardCmd_cb
	sw	$18,0($16)
	sw	$0,4($16)
	sw	$0,8($16)
	sw	$19,mc+12
	jal	UserFuncOpen
$L273:
	lw	$2,0($16)
	#nop
	bne	$2,$0,$L275
	lw	$2,8($16)
	#nop
	beq	$2,$0,$L274
$L275:
	#.set	volatile
	lw	$2,0($16)
	#.set	novolatile
	#nop
	#.set	volatile
	lw	$2,4($16)
	#.set	novolatile
	#nop
	#.set	volatile
	lw	$2,8($16)
	#.set	novolatile
	#nop
	bne	$2,$0,$L277
	la	$3,mc+8
$L280:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	beq	$2,$0,$L280
$L277:
	la	$2,_mc_sync+4
 #APP
 #NO_APP
	lw	$2,0($2)
	sw	$0,8($16)
	sw	$2,48($sp)
$L274:
	lw	$4,_mc_save_cb
	jal	MemCardCallback
	lw	$3,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L266
	li	$2,0x00000003		# 3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L296
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	bne	$3,$18,$L268
	addu	$17,$17,1
 #APP
 #NO_APP
	slt	$2,$17,4
	bne	$2,$0,$L269
$L268:
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L294
	li	$2,0x00000005		# 5
	.set	macro
	.set	reorder

	sw	$2,48($sp)
$L294:
	lw	$2,48($sp)
	j	$L295
$L271:
	.set	noreorder
	.set	nomacro
	jal	close
	addu	$4,$2,$0
	.set	macro
	.set	reorder

	addu	$2,$0,$0
$L295:
	lw	$31,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	addu	$sp,$sp,80
	j	$31
	.end	MemCardCreateFile
	.align	2
	.globl	MemCardDeleteFile
	.ent	MemCardDeleteFile
MemCardDeleteFile:
	.frame	$sp,80,$31		# vars= 40, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$18,64($sp)
	addu	$18,$4,$0
	sw	$16,56($sp)
	addu	$16,$5,$0
	sw	$19,68($sp)
	la	$19,mc
	sw	$31,72($sp)
	sw	$17,60($sp)
	lw	$2,0($19)
 #APP
 #NO_APP
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L298
	addu	$17,$0,$0
	.set	macro
	.set	reorder

	la	$4,$LC5
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L326
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L298:
	addu	$4,$18,$0
	.set	noreorder
	.set	nomacro
	jal	MemCardMakeDevname
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	strcat
	addu	$5,$16,$0
	.set	macro
	.set	reorder

	addu	$16,$19,$0
 #APP
 #NO_APP
	li	$19,0x00000002		# 2
	li	$2,0x00000001		# 1
	lw	$4,12($16)
	lw	$3,_mc_present
	sll	$2,$2,$4
	or	$3,$3,$2
	sw	$3,_mc_present
$L301:
	.set	noreorder
	.set	nomacro
	jal	erase
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L303
	sw	$2,48($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	MemCardCallback
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	lw	$3,0($16)
	sw	$2,_mc_save_cb
	blez	$3,$L304
	la	$4,$LC0
	jal	printf
	j	$L305
$L304:
	la	$4,MemCardCmd_cb
	sw	$19,0($16)
	sw	$0,4($16)
	sw	$0,8($16)
	sw	$18,mc+12
	jal	UserFuncOpen
$L305:
	lw	$2,0($16)
	#nop
	bne	$2,$0,$L307
	lw	$2,8($16)
	#nop
	beq	$2,$0,$L306
$L307:
	#.set	volatile
	lw	$2,0($16)
	#.set	novolatile
	#nop
	#.set	volatile
	lw	$2,4($16)
	#.set	novolatile
	#nop
	#.set	volatile
	lw	$2,8($16)
	#.set	novolatile
	#nop
	bne	$2,$0,$L309
	la	$3,mc+8
$L312:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	beq	$2,$0,$L312
$L309:
	la	$2,_mc_sync+4
 #APP
 #NO_APP
	lw	$2,0($2)
	sw	$0,8($16)
	sw	$2,48($sp)
$L306:
	lw	$4,_mc_save_cb
	jal	MemCardCallback
	lw	$3,48($sp)
	li	$2,0x00000003		# 3
	beq	$3,$2,$L301
	bne	$3,$19,$L300
	addu	$17,$17,1
 #APP
 #NO_APP
	slt	$2,$17,4
	bne	$2,$0,$L301
$L300:
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L325
	li	$2,0x00000005		# 5
	.set	macro
	.set	reorder

	sw	$2,48($sp)
$L325:
	lw	$2,48($sp)
	j	$L326
$L303:
	addu	$2,$0,$0
$L326:
	lw	$31,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	addu	$sp,$sp,80
	j	$31
	.end	MemCardDeleteFile
	.align	2
	.globl	MemCardFormat
	.ent	MemCardFormat
MemCardFormat:
	.frame	$sp,88,$31		# vars= 64, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	la	$3,mc
	sw	$31,80($sp)
	lw	$2,0($3)
	#nop
	bne	$2,$0,$Lfs0_0_324
	li	$2,0x00000001		# 1
	lw	$5,12($3)
	lw	$3,_mc_present
	sll	$2,$2,$5
	or	$3,$3,$2
	addu	$5,$sp,16
	sw	$3,_mc_present
	jal	MemCardMakeDevname
	jal	_clr_card_event
	addu	$4,$sp,16
	jal	format
	jal	_get_card_event_x
	addu	$4,$2,$0
	jal	MemCardEventToRslt
	j	$Lfs0_0_325
$Lfs0_0_324:
	la	$4,$LC5
	jal	printf
	li	$2,-1			# 0xffffffff
$Lfs0_0_325:
	lw	$31,80($sp)
	addu	$sp,$sp,88
	j	$31
	.end	MemCardFormat
	.align	2
	.globl	MemCardUnformat
	.ent	MemCardUnformat
MemCardUnformat:
	.frame	$sp,160,$31		# vars= 128, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,160
	la	$2,mc
	sw	$31,152($sp)
	sw	$17,148($sp)
	sw	$16,144($sp)
 #APP
 #NO_APP
	lw	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L332
	addu	$17,$4,$0
	.set	macro
	.set	reorder

	la	$4,$LC5
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L344
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L333:
	.set	noreorder
	.set	nomacro
	j	$L344
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L332:
	li	$3,-1			# 0xffffffff
	li	$16,0x0000007f		# 127
	addu	$2,$sp,143
$L337:
	sb	$3,0($2)
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bgez	$16,$L337
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	addu	$16,$0,$0
$L339:
	jal	_clr_card_event
	jal	_new_card
	addu	$4,$17,$0
	addu	$5,$16,$0
	.set	noreorder
	.set	nomacro
	jal	_card_write
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	jal	_get_card_event_x
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L333
	addu	$16,$16,1
	.set	macro
	.set	reorder

	slt	$2,$16,15
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L339
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L344:
	lw	$31,152($sp)
	lw	$17,148($sp)
	lw	$16,144($sp)
	addu	$sp,$sp,160
	j	$31
	.end	MemCardUnformat
	.align	2
	.ent	MemCardEventToRslt
MemCardEventToRslt:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L347
	addu	$3,$0,$0
	.set	macro
	.set	reorder

	slt	$2,$4,2
	beq	$2,$0,$L348
	beq	$4,$0,$L353
	.set	noreorder
	.set	nomacro
	j	$L353
	ori	$3,$4,0x8000
	.set	macro
	.set	reorder

$L348:
	li	$2,0x00000002		# 2
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L353
	li	$3,0x00000001		# 1
	.set	macro
	.set	reorder

	li	$2,0x00000004		# 4
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L353
	ori	$3,$4,0x8000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L353
	li	$3,0x00000003		# 3
	.set	macro
	.set	reorder

$L347:
	li	$3,0x00000002		# 2
$L353:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$0
	.set	macro
	.set	reorder

	.end	MemCardEventToRslt
	.align	2
	.ent	MemCardStart_cb
MemCardStart_cb:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	UserFuncComplete
	bne	$2,$0,$L354
	jal	UserFuncExecute
	jal	UserFuncComplete
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L354
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	la	$3,mc
 #APP
 #NO_APP
	sw	$2,8($3)
	lw	$2,0($3)
 #APP
 #NO_APP
	la	$5,_mc_sync
 #APP
 #NO_APP
	sw	$2,0($5)
	lw	$2,4($3)
	lw	$6,64($3)
	sw	$2,4($5)
	sw	$0,0($3)
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L354
	sw	$0,4($3)
	.set	macro
	.set	reorder

	lw	$4,0($5)
	lw	$5,4($5)
	jal	$31,$6
$L354:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	MemCardStart_cb
	.rdata
	.align	2
$LC6:
	.ascii	"bu00:\000"
	.text
	.align	2
	.ent	MemCardMakeDevname
MemCardMakeDevname:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$6,$4,$0
	addu	$7,$5,$0
	la	$5,$LC6
	lwl	$2,3($5)
	lwr	$2,0($5)
	lb	$3,4($5)
	lb	$4,5($5)
	swl	$2,3($7)
	swr	$2,0($7)
	sb	$3,4($7)
	sb	$4,5($7)
	.set	noreorder
	.set	nomacro
	bgez	$6,$L359
	addu	$2,$6,$0
	.set	macro
	.set	reorder

	addu	$2,$6,15
$L359:
	sra	$2,$2,4
	addu	$3,$2,48
	sll	$2,$2,4
	subu	$2,$6,$2
	addu	$2,$2,48
	sb	$3,2($7)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,3($7)
	.set	macro
	.set	reorder

	.end	MemCardMakeDevname

	.lcomm	_mc_exretry,4

	.lcomm	_mc_exrslt,4

	.lcomm	_mc_retry,4

	.lcomm	_mc_evrslt,4

	.lcomm	_mc_cleared,4

	.lcomm	mc,72

	.lcomm	_mc_sync,8

	.lcomm	_mc_save_cb,4

	.lcomm	_mc_present,4

	.lcomm	_mc_rd_retry,4

	.lcomm	_mc_wr_retry,4

	.lcomm	_mc_rf_retry,4

	.lcomm	_mc_wf_retry,4
