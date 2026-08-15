	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmcrd\\LIBMCRD.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -fno-delayed-branch -o

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
	sw	$3,16($2)
	jal	_card_start
	li	$4,0x00000007		# 7
	la	$5,MemCardStart_cb
	jal	VSyncCallbacks
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
	bne	$2,$0,$L9
	li	$4,0x00000007		# 7
	move	$5,$0
	jal	VSyncCallbacks
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
	move	$5,$4
	bgtz	$2,$L11
 #APP
 #NO_APP
	la	$4,MemCardExist_cb
	li	$2,0x00000001		# 1
	sw	$2,0($3)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$5,12($3)
	jal	UserFuncOpen
	li	$2,0x00000001		# 1
	j	$L12
$L11:
	la	$4,$LC0
	jal	printf
	move	$2,$0
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
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$3,0($16)
	#nop
	beq	$3,$0,$L15
	bltz	$3,$L17
	li	$17,0x0000000a		# 10
	beq	$3,$17,$L16
	li	$2,0x0000000b		# 11
	beq	$3,$2,$L18
	j	$L17
$L15:
	li	$2,0x0000000a		# 10
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
	sw	$2,0($16)
	j	$L17
$L18:
	jal	_chk_card_event
	beq	$2,$0,$L17
	jal	_get_card_event
	move	$3,$2
	sw	$3,_mc_exrslt
	slt	$2,$3,3
	beq	$2,$0,$L20
	bgtz	$3,$L22
	beq	$3,$0,$L24
	j	$L25
$L20:
	li	$2,0x00000004		# 4
	bne	$3,$2,$L25
	li	$4,0x00000004		# 4
	jal	MemCardEventToRslt
	la	$3,mc
 #APP
 #NO_APP
	sw	$2,4($3)
	li	$2,0x00000001		# 1
	j	$L31
$L24:
	li	$2,0x00000001		# 1
 #APP
 #NO_APP
	la	$16,mc+12
 #APP
 #NO_APP
	lw	$4,0($16)
	lw	$3,_mc_present
	sll	$2,$2,$4
	and	$3,$3,$2
	bne	$3,$0,$L27
	li	$2,0x00000004		# 4
	sw	$2,_mc_exrslt
$L27:
	lw	$4,_mc_exrslt
	jal	MemCardEventToRslt
	move	$4,$2
	addu	$3,$16,-12
 #APP
 #NO_APP
	li	$2,0x00000001		# 1
	sw	$4,4($3)
	j	$L31
$L22:
	lw	$2,_mc_exretry
	#nop
	addu	$2,$2,1
	sw	$2,_mc_exretry
	slt	$2,$2,5
	beq	$2,$0,$L25
	sw	$17,0($16)
	j	$L17
$L25:
	la	$16,mc+12
 #APP
 #NO_APP
	lw	$3,0($16)
	addu	$16,$16,-12
	li	$2,0x00000001		# 1
	lw	$4,_mc_exrslt
	sll	$2,$2,$3
	lw	$3,_mc_present
	nor	$2,$0,$2
	and	$3,$3,$2
	sw	$3,_mc_present
	jal	MemCardEventToRslt
	move	$3,$2
 #APP
 #NO_APP
	li	$2,0x00000001		# 1
	sw	$3,4($16)
	j	$L31
$L17:
	move	$2,$0
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
	move	$5,$4
	bgtz	$2,$L33
 #APP
 #NO_APP
	la	$4,MemCardCmd_cb
	li	$2,0x00000002		# 2
	sw	$2,0($3)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$5,12($3)
	jal	UserFuncOpen
	li	$2,0x00000001		# 1
	j	$L34
$L33:
	la	$4,$LC0
	jal	printf
	move	$2,$0
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
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$3,0($16)
 #APP
 #NO_APP
	#nop
	sltu	$2,$3,32
	beq	$2,$0,$L38
	sll	$2,$3,2
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
	sw	$2,0($16)
	j	$L38
$L39:
	la	$17,mc+4
 #APP
 #NO_APP
	lw	$3,0($17)
	#nop
	beq	$3,$0,$L41
	li	$2,0x00000003		# 3
	beq	$3,$2,$L42
	li	$2,0x00000001		# 1
	j	$L61
$L42:
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
	sw	$2,0($16)
	j	$L38
$L43:
	jal	_chk_card_event_x
	beq	$2,$0,$L38
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
	sw	$2,0($16)
	j	$L38
$L46:
	jal	_chk_card_event
	beq	$2,$0,$L38
	jal	_get_card_event
	move	$3,$2
	sw	$3,_mc_evrslt
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
	beq	$2,$0,$L55
 #APP
 #NO_APP
	li	$3,0x00000003		# 3
 #APP
 #NO_APP
	j	$L56
$L55:
	move	$3,$0
$L56:
	la	$2,mc
 #APP
 #NO_APP
	sw	$3,4($2)
	li	$2,0x00000001		# 1
	j	$L61
$L50:
	lw	$2,_mc_retry
	#nop
	addu	$2,$2,1
	sw	$2,_mc_retry
	slt	$2,$2,5
	beq	$2,$0,$L53
$L41:
	li	$2,0x0000001e		# 30
	sw	$2,0($16)
	j	$L38
$L53:
	lw	$4,_mc_evrslt
	li	$2,0x00000004		# 4
	bne	$4,$2,$L58
	la	$2,mc
 #APP
 #NO_APP
	sw	$4,4($2)
	li	$2,0x00000001		# 1
	j	$L61
$L58:
	jal	MemCardEventToRslt
	la	$3,mc
 #APP
 #NO_APP
	sw	$2,4($3)
	li	$2,0x00000001		# 1
	j	$L61
$L38:
	move	$2,$0
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
	.ascii	"Access Denied. : file not open.\n\000"
	.align	2
$LC2:
	.ascii	"Access Denied. : invalid data size align\n\000"
	.align	2
$LC3:
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
	bgez	$2,$L63
	la	$4,$LC1
	j	$L64
$L63:
	move	$8,$4
 #APP
 #NO_APP
	lw	$2,-16($7)
	#nop
	blez	$2,$L65
	la	$4,$LC0
	j	$L64
$L65:
	addu	$3,$7,-16
 #APP
 #NO_APP
	andi	$2,$6,0x007f
	beq	$2,$0,$L67
	la	$4,$LC2
	j	$L64
$L67:
	andi	$2,$5,0x007f
	bne	$2,$0,$L69
	la	$4,MemCardReadData_cb
	li	$2,0x00000005		# 5
	sw	$2,-16($7)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$5,20($3)
	sw	$8,28($3)
	sw	$6,24($3)
	jal	UserFuncOpen
	li	$2,0x00000001		# 1
	j	$L71
$L69:
	la	$4,$LC3
$L64:
	jal	printf
	move	$2,$0
$L71:
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
	move	$17,$4
 #APP
 #NO_APP
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$3,0($17)
	li	$16,0x0000000a		# 10
	beq	$3,$16,$L75
	slt	$2,$3,11
	beq	$2,$0,$L90
	beq	$3,$0,$L74
	j	$L88
$L90:
	li	$2,0x0000001e		# 30
	beq	$3,$2,$L84
	j	$L88
$L74:
	sw	$0,_mc_rd_retry
	sw	$16,0($17)
$L75:
	la	$16,mc+16
$L76:
	lw	$4,0($16)
	lw	$5,4($16)
	move	$6,$0
	jal	lseek
	lw	$3,4($16)
	#nop
	bne	$2,$3,$L76
	jal	_clr_card_event
	la	$16,mc+16
$L80:
	lw	$4,0($16)
	lw	$5,12($16)
	lw	$6,8($16)
	jal	read
	bne	$2,$0,$L80
	li	$2,0x0000001e		# 30
	sw	$2,0($17)
	j	$L88
$L84:
	jal	_chk_card_event
	beq	$2,$0,$L88
	jal	_get_card_event
	move	$4,$2
	beq	$4,$0,$L86
	lw	$2,_mc_rd_retry
	#nop
	addu	$2,$2,1
	sw	$2,_mc_rd_retry
	slt	$2,$2,4
	beq	$2,$0,$L92
	sw	$16,0($17)
	j	$L88
$L86:
	move	$4,$0
$L92:
	jal	MemCardEventToRslt
	la	$3,mc
 #APP
 #NO_APP
	sw	$2,4($3)
	li	$2,0x00000001		# 1
	j	$L91
$L88:
	move	$2,$0
$L91:
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
	bgez	$2,$L94
	la	$4,$LC1
	j	$L95
$L94:
	move	$8,$4
 #APP
 #NO_APP
	lw	$2,-16($7)
	#nop
	blez	$2,$L96
	la	$4,$LC0
	j	$L95
$L96:
	addu	$3,$7,-16
 #APP
 #NO_APP
	andi	$2,$6,0x007f
	beq	$2,$0,$L98
	la	$4,$LC2
	j	$L95
$L98:
	andi	$2,$5,0x007f
	bne	$2,$0,$L100
	la	$4,MemCardWriteData_cb
	li	$2,0x00000006		# 6
	sw	$2,-16($7)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$5,20($3)
	sw	$8,28($3)
	sw	$6,24($3)
	jal	UserFuncOpen
	li	$2,0x00000001		# 1
	j	$L102
$L100:
	la	$4,$LC3
$L95:
	jal	printf
	move	$2,$0
$L102:
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
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$3,0($17)
	li	$16,0x0000000a		# 10
	beq	$3,$16,$L110
	slt	$2,$3,11
	beq	$2,$0,$L121
	beq	$3,$0,$L105
	j	$L119
$L121:
	li	$2,0x0000001e		# 30
	beq	$3,$2,$L106
	j	$L119
$L105:
	move	$2,$0
	sw	$0,_mc_wr_retry
	sw	$16,0($17)
	j	$L122
$L106:
	jal	_chk_card_event
	beq	$2,$0,$L119
	jal	_get_card_event
	move	$4,$2
	beq	$4,$0,$L108
	lw	$2,_mc_wr_retry
	#nop
	addu	$2,$2,1
	sw	$2,_mc_wr_retry
	slt	$2,$2,4
	beq	$2,$0,$L123
	sw	$16,0($17)
	j	$L119
$L108:
	move	$4,$0
$L123:
	jal	MemCardEventToRslt
	la	$3,mc
 #APP
 #NO_APP
	sw	$2,4($3)
	li	$2,0x00000001		# 1
	j	$L122
$L110:
	la	$16,mc+16
$L111:
	lw	$4,0($16)
	lw	$5,4($16)
	move	$6,$0
	jal	lseek
	lw	$3,4($16)
	#nop
	bne	$2,$3,$L111
	jal	_clr_card_event
	la	$16,mc+16
$L115:
	lw	$4,0($16)
	lw	$5,12($16)
	lw	$6,8($16)
	jal	write
	bne	$2,$0,$L115
	li	$2,0x0000001e		# 30
	sw	$2,0($17)
$L119:
	move	$2,$0
$L122:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	MemCardWriteData_cb
	.rdata
	.align	2
$LC4:
	.ascii	"Access Denied. : system busy\n\000"
	.align	2
$LC5:
	.ascii	"Access Denied. : file already open.\n\000"
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
	move	$20,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$21,36($sp)
	move	$21,$6
	sw	$18,24($sp)
	move	$18,$7
	sw	$17,20($sp)
	la	$17,mc
 #APP
 #NO_APP
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$16,16($sp)
	lw	$2,0($17)
	lw	$22,64($sp)
	blez	$2,$L125
	la	$4,$LC4
	j	$L126
$L125:
	lw	$2,16($17)
	#nop
	bltz	$2,$L127
	la	$4,$LC5
	j	$L126
$L127:
	andi	$2,$22,0x007f
	beq	$2,$0,$L129
	la	$4,$LC2
	j	$L126
$L129:
	andi	$2,$18,0x007f
	bne	$2,$0,$L131
	move	$4,$20
	addu	$16,$17,32
	move	$5,$16
	jal	MemCardMakeDevname
	move	$4,$16
	move	$5,$19
	jal	strcat
	la	$4,MemCardReadFile_cb
	li	$2,0x00000003		# 3
	sw	$2,0($17)
	sw	$0,4($17)
	sw	$0,8($17)
	sw	$18,20($17)
	sw	$21,28($17)
	sw	$22,24($17)
	sw	$20,12($17)
	jal	UserFuncOpen
	li	$2,0x00000001		# 1
	j	$L133
$L131:
	la	$4,$LC3
$L126:
	jal	printf
	move	$2,$0
$L133:
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
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$3,0($17)
	li	$16,0x0000000a		# 10
	beq	$3,$16,$L138
	slt	$2,$3,11
	beq	$2,$0,$L145
	beq	$3,$0,$L136
	j	$L137
$L145:
	li	$2,0x0000000b		# 11
	beq	$3,$2,$L141
	li	$2,0x00000014		# 20
	beq	$3,$2,$L142
	j	$L137
$L136:
	la	$4,MemCardExist_cb
	sw	$0,_mc_rf_retry
	jal	UserFuncOpen
	sw	$16,0($17)
	j	$L137
$L138:
	la	$16,mc+4
 #APP
 #NO_APP
	lw	$2,0($16)
	#nop
	beq	$2,$0,$L139
	li	$2,0x00000001		# 1
	j	$L146
$L139:
	addu	$4,$16,28
	li	$5,0x00008001		# 32769
	jal	open
	sw	$2,12($16)
	bgez	$2,$L141
	addu	$3,$16,-4
 #APP
 #NO_APP
	li	$2,0x00000005		# 5
 #APP
 #NO_APP
	sw	$2,4($3)
	li	$2,0x00000001		# 1
	j	$L146
$L141:
	li	$2,0x00000014		# 20
	sw	$2,0($17)
	la	$4,MemCardReadData_cb
	jal	UserFuncOpen
	j	$L137
$L142:
	la	$16,mc+16
	lw	$4,0($16)
	jal	close
	li	$2,0x00000001		# 1
	li	$3,-1			# 0xffffffff
	sw	$3,0($16)
	j	$L146
$L137:
	move	$2,$0
$L146:
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
	move	$20,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$21,36($sp)
	move	$21,$6
	sw	$18,24($sp)
	move	$18,$7
	sw	$17,20($sp)
	la	$17,mc
 #APP
 #NO_APP
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$16,16($sp)
	lw	$2,0($17)
	lw	$22,64($sp)
	blez	$2,$L148
	la	$4,$LC4
	j	$L149
$L148:
	lw	$2,16($17)
	#nop
	bltz	$2,$L150
	la	$4,$LC5
	j	$L149
$L150:
	andi	$2,$22,0x007f
	beq	$2,$0,$L152
	la	$4,$LC2
	j	$L149
$L152:
	andi	$2,$18,0x007f
	bne	$2,$0,$L154
	move	$4,$20
	addu	$16,$17,32
	move	$5,$16
	jal	MemCardMakeDevname
	move	$4,$16
	move	$5,$19
	jal	strcat
	la	$4,MemCardWriteFile_cb
	li	$2,0x00000004		# 4
	sw	$2,0($17)
	sw	$0,4($17)
	sw	$0,8($17)
	sw	$18,20($17)
	sw	$21,28($17)
	sw	$22,24($17)
	sw	$20,12($17)
	jal	UserFuncOpen
	li	$2,0x00000001		# 1
	j	$L156
$L154:
	la	$4,$LC3
$L149:
	jal	printf
	move	$2,$0
$L156:
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
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$3,0($17)
	li	$16,0x0000000a		# 10
	beq	$3,$16,$L161
	slt	$2,$3,11
	beq	$2,$0,$L168
	beq	$3,$0,$L159
	j	$L160
$L168:
	li	$2,0x0000000b		# 11
	beq	$3,$2,$L164
	li	$2,0x00000014		# 20
	beq	$3,$2,$L165
	j	$L160
$L159:
	la	$4,MemCardExist_cb
	sw	$0,_mc_wf_retry
	jal	UserFuncOpen
	sw	$16,0($17)
	j	$L160
$L161:
	la	$16,mc+4
 #APP
 #NO_APP
	lw	$2,0($16)
	#nop
	beq	$2,$0,$L162
	li	$2,0x00000001		# 1
	j	$L169
$L162:
	addu	$4,$16,28
	li	$5,0x00008001		# 32769
	jal	open
	sw	$2,12($16)
	bgez	$2,$L164
	addu	$3,$16,-4
 #APP
 #NO_APP
	li	$2,0x00000005		# 5
 #APP
 #NO_APP
	sw	$2,4($3)
	li	$2,0x00000001		# 1
	j	$L169
$L164:
	li	$2,0x00000014		# 20
	sw	$2,0($17)
	la	$4,MemCardWriteData_cb
	jal	UserFuncOpen
	j	$L160
$L165:
	la	$16,mc+16
	lw	$4,0($16)
	jal	close
	li	$2,0x00000001		# 1
	li	$3,-1			# 0xffffffff
	sw	$3,0($16)
	j	$L169
$L160:
	move	$2,$0
$L169:
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
	move	$23,$4
	sw	$16,104($sp)
	move	$16,$5
	sw	$22,128($sp)
	move	$22,$6
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
	sw	$7,96($sp)
	lw	$2,0($19)
	lw	$fp,160($sp)
	beq	$2,$0,$L171
	la	$4,$LC4
	jal	printf
	li	$2,-1			# 0xffffffff
	j	$L193
$L171:
	move	$4,$23
	addu	$5,$sp,16
	jal	MemCardMakeDevname
	addu	$4,$sp,16
	move	$5,$16
	jal	strcat
	move	$17,$0
 #APP
 #NO_APP
	move	$21,$0
	move	$18,$0
 #APP
 #NO_APP
	move	$2,$19
 #APP
 #NO_APP
	li	$3,0x00000001		# 1
	sw	$0,88($sp)
	lw	$4,12($2)
	lw	$2,_mc_present
	lw	$9,164($sp)
	sll	$3,$3,$4
	or	$2,$2,$3
	sw	$2,_mc_present
	addu	$2,$fp,$9
	blez	$2,$L172
	move	$20,$0
$L173:
	bne	$17,$0,$L176
$L179:
	jal	_clr_card_event
	addu	$4,$sp,16
	addu	$5,$sp,48
	jal	firstfile
	move	$16,$2
	bne	$16,$0,$L187
	jal	_get_card_event_x
	move	$4,$2
	jal	MemCardEventToRslt
	sw	$2,88($sp)
	beq	$2,$0,$L182
	addu	$18,$18,1
	slt	$2,$18,4
	bne	$2,$0,$L179
	move	$4,$0
	jal	MemCardCallback
	lw	$3,0($19)
	sw	$2,_mc_save_cb
	blez	$3,$L184
	la	$4,$LC0
	jal	printf
	j	$L185
$L184:
	la	$4,MemCardCmd_cb
	li	$2,0x00000002		# 2
	sw	$2,0($19)
	sw	$0,4($19)
	sw	$0,8($19)
	sw	$23,12($19)
	jal	UserFuncOpen
$L185:
	move	$4,$0
	move	$5,$0
	addu	$6,$sp,88
	jal	MemCardSync
	lw	$4,_mc_save_cb
	jal	MemCardCallback
	lw	$2,88($sp)
	j	$L193
$L176:
	addu	$4,$sp,48
	jal	nextfile
	move	$16,$2
$L182:
	beq	$16,$0,$L172
$L187:
	slt	$2,$17,$fp
	bne	$2,$0,$L189
	beq	$22,$0,$L189
	addu	$7,$20,$22
	addu	$6,$sp,48
	addu	$8,$sp,80
$L190:
	lw	$2,0($6)
	lw	$3,4($6)
	lw	$4,8($6)
	lw	$5,12($6)
	sw	$2,0($7)
	sw	$3,4($7)
	sw	$4,8($7)
	sw	$5,12($7)
	addu	$6,$6,16
	addu	$7,$7,16
	bne	$6,$8,$L190
	lw	$2,0($6)
	lw	$3,4($6)
	sw	$2,0($7)
	sw	$3,4($7)
	addu	$20,$20,40
	addu	$21,$21,1
$L189:
	lw	$9,164($sp)
	addu	$17,$17,1
	addu	$2,$fp,$9
	slt	$2,$17,$2
	bne	$2,$0,$L173
$L172:
	lw	$9,96($sp)
	#nop
	beq	$9,$0,$L192
	sw	$21,0($9)
$L192:
	move	$2,$0
$L193:
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
 #APP
 #NO_APP
	lw	$2,0($3)
	sw	$4,0($3)
	j	$31
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
	bne	$2,$0,$L226
	lw	$2,8($3)
	#nop
	bne	$2,$0,$L226
	li	$2,-1			# 0xffffffff
	j	$L240
$L226:
	lw	$8,0($3)
	lw	$7,4($3)
	bne	$4,$0,$L227
	lw	$2,8($3)
	#nop
	bne	$2,$0,$L228
	addu	$3,$3,8
$L231:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	beq	$2,$0,$L231
$L228:
	beq	$6,$0,$L233
	la	$2,_mc_sync+4
 #APP
 #NO_APP
	lw	$2,0($2)
	#nop
	sw	$2,0($6)
$L233:
	beq	$5,$0,$L234
	la	$2,_mc_sync
 #APP
 #NO_APP
	lw	$2,0($2)
	#nop
	sw	$2,0($5)
$L234:
	la	$2,mc
 #APP
 #NO_APP
	sw	$0,8($2)
	li	$2,0x00000001		# 1
 #APP
 #NO_APP
	j	$L240
$L227:
	lw	$2,8($3)
	#nop
	bne	$2,$0,$L235
	beq	$6,$0,$L236
	sw	$7,0($6)
$L236:
	beq	$5,$0,$L237
	sw	$8,0($5)
$L237:
	move	$2,$0
	j	$L240
$L235:
	beq	$6,$0,$L238
	la	$2,_mc_sync+4
 #APP
 #NO_APP
	lw	$2,0($2)
	#nop
	sw	$2,0($6)
$L238:
	beq	$5,$0,$L239
	la	$2,_mc_sync
 #APP
 #NO_APP
	lw	$2,0($2)
	#nop
	sw	$2,0($5)
$L239:
	sw	$0,8($3)
	li	$2,0x00000001		# 1
$L240:
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
	move	$19,$4
	sw	$16,56($sp)
	move	$16,$5
	sw	$20,72($sp)
	move	$20,$6
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
	beq	$2,$0,$L242
	la	$4,$LC4
	jal	printf
	li	$2,-1			# 0xffffffff
	j	$L274
$L242:
	move	$17,$0
	move	$4,$19
	addu	$5,$sp,16
	jal	MemCardMakeDevname
	addu	$4,$sp,16
	move	$5,$16
	jal	strcat
	addu	$4,$sp,16
	li	$5,0x00000001		# 1
	li	$2,0x00000001		# 1
	lw	$6,12($18)
	lw	$3,_mc_present
	sll	$2,$2,$6
	or	$3,$3,$2
	sw	$3,_mc_present
	jal	open
	bltz	$2,$L244
	move	$4,$2
	jal	close
	li	$2,0x00000006		# 6
	j	$L274
$L245:
	li	$2,0x00000007		# 7
	j	$L274
$L244:
	sll	$20,$20,16
	move	$16,$18
	li	$18,0x00000002		# 2
$L248:
	addu	$4,$sp,16
	ori	$5,$20,0x0200
	jal	open
	bgez	$2,$L250
	move	$4,$0
	jal	MemCardCallback
	sw	$2,_mc_save_cb
	lw	$2,0($16)
	#nop
	blez	$2,$L251
	la	$4,$LC0
	jal	printf
	j	$L252
$L251:
 #APP
 #NO_APP
	la	$4,MemCardCmd_cb
	sw	$18,0($16)
	sw	$0,4($16)
	sw	$0,8($16)
	sw	$19,mc+12
	jal	UserFuncOpen
$L252:
	lw	$2,0($16)
	#nop
	bne	$2,$0,$L254
	lw	$2,8($16)
	#nop
	beq	$2,$0,$L253
$L254:
	lw	$2,8($16)
	#nop
	bne	$2,$0,$L256
	la	$3,mc+8
$L259:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	beq	$2,$0,$L259
$L256:
	la	$2,_mc_sync+4
 #APP
 #NO_APP
	lw	$2,0($2)
	sw	$0,8($16)
	sw	$2,48($sp)
$L253:
	lw	$4,_mc_save_cb
	jal	MemCardCallback
	lw	$3,48($sp)
	#nop
	beq	$3,$0,$L245
	li	$2,0x00000003		# 3
	beq	$3,$2,$L248
	bne	$3,$18,$L247
	addu	$17,$17,1
 #APP
 #NO_APP
	slt	$2,$17,4
	bne	$2,$0,$L248
$L247:
	bne	$3,$0,$L273
	li	$2,0x00000005		# 5
	sw	$2,48($sp)
$L273:
	lw	$2,48($sp)
	j	$L274
$L250:
	move	$4,$2
	jal	close
	move	$2,$0
$L274:
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
	move	$18,$4
	sw	$16,56($sp)
	move	$16,$5
	sw	$19,68($sp)
	la	$19,mc
	sw	$31,72($sp)
	sw	$17,60($sp)
	lw	$2,0($19)
 #APP
 #NO_APP
	#nop
	beq	$2,$0,$L276
	la	$4,$LC4
	jal	printf
	li	$2,-1			# 0xffffffff
	j	$L304
$L276:
	move	$17,$0
	move	$4,$18
	addu	$5,$sp,16
	jal	MemCardMakeDevname
	addu	$4,$sp,16
	move	$5,$16
	jal	strcat
	move	$16,$19
	li	$19,0x00000002		# 2
	li	$2,0x00000001		# 1
	lw	$4,mc+12
	lw	$3,_mc_present
	sll	$2,$2,$4
	or	$3,$3,$2
	sw	$3,_mc_present
$L279:
	addu	$4,$sp,16
	jal	erase
	sw	$2,48($sp)
	bne	$2,$0,$L281
	move	$4,$0
	jal	MemCardCallback
	lw	$3,0($16)
	sw	$2,_mc_save_cb
	blez	$3,$L282
	la	$4,$LC0
	jal	printf
	j	$L283
$L282:
 #APP
 #NO_APP
	la	$4,MemCardCmd_cb
	sw	$19,0($16)
	sw	$0,4($16)
	sw	$0,8($16)
	sw	$18,mc+12
	jal	UserFuncOpen
$L283:
	lw	$2,0($16)
	#nop
	bne	$2,$0,$L285
	lw	$2,8($16)
	#nop
	beq	$2,$0,$L284
$L285:
	lw	$2,8($16)
	#nop
	bne	$2,$0,$L287
	la	$3,mc+8
$L290:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	beq	$2,$0,$L290
$L287:
	la	$2,_mc_sync+4
 #APP
 #NO_APP
	lw	$2,0($2)
	sw	$0,8($16)
	sw	$2,48($sp)
$L284:
	lw	$4,_mc_save_cb
	jal	MemCardCallback
	lw	$3,48($sp)
	li	$2,0x00000003		# 3
	beq	$3,$2,$L279
	bne	$3,$19,$L278
	addu	$17,$17,1
 #APP
 #NO_APP
	slt	$2,$17,4
	bne	$2,$0,$L279
$L278:
	bne	$3,$0,$L303
	li	$2,0x00000005		# 5
	sw	$2,48($sp)
$L303:
	lw	$2,48($sp)
	j	$L304
$L281:
	move	$2,$0
$L304:
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
 #APP
 #NO_APP
	lw	$2,0($3)
	#nop
	bne	$2,$0,$L306
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
	move	$4,$2
	jal	MemCardEventToRslt
	j	$L307
$L306:
	la	$4,$LC4
	jal	printf
	li	$2,-1			# 0xffffffff
$L307:
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
	beq	$2,$0,$L310
	la	$4,$LC4
	jal	printf
	li	$2,-1			# 0xffffffff
	j	$L322
$L311:
	move	$2,$0
	j	$L322
$L310:
	move	$17,$4
 #APP
 #NO_APP
	li	$3,-1			# 0xffffffff
	li	$16,0x0000007f		# 127
	addu	$2,$sp,143
$L315:
	sb	$3,0($2)
	addu	$2,$2,-1
	addu	$16,$16,-1
	bgez	$16,$L315
	move	$16,$0
$L317:
	jal	_clr_card_event
	jal	_new_card
	move	$4,$17
	move	$5,$16
	addu	$6,$sp,16
	jal	_card_write
	jal	_get_card_event_x
	bne	$2,$0,$L311
	addu	$16,$16,1
	slt	$2,$16,15
	bne	$2,$0,$L317
	li	$2,0x00000001		# 1
$L322:
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
	move	$3,$0
	li	$2,0x00000001		# 1
	beq	$4,$2,$L325
	slt	$2,$4,2
	beq	$2,$0,$L326
	beq	$4,$0,$L331
	ori	$3,$4,0x8000
	j	$L331
$L326:
	li	$3,0x00000001		# 1
	li	$2,0x00000002		# 2
	beq	$4,$2,$L331
	ori	$3,$4,0x8000
	li	$2,0x00000004		# 4
	bne	$4,$2,$L331
	li	$3,0x00000003		# 3
	j	$L331
$L325:
	li	$3,0x00000002		# 2
$L331:
	move	$2,$3
	j	$31
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
	bne	$2,$0,$L332
	jal	UserFuncExecute
	jal	UserFuncComplete
	beq	$2,$0,$L332
	li	$2,0x00000001		# 1
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
	sw	$0,4($3)
	beq	$6,$0,$L332
	lw	$4,0($5)
	lw	$5,4($5)
	jal	$31,$6
$L332:
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
	move	$6,$4
	move	$7,$5
	la	$5,$LC6
	lwl	$2,3($5)
	lwr	$2,0($5)
	lb	$3,4($5)
	lb	$4,5($5)
	swl	$2,3($7)
	swr	$2,0($7)
	sb	$3,4($7)
	sb	$4,5($7)
	move	$2,$6
	bgez	$6,$L337
	addu	$2,$6,15
$L337:
	sra	$2,$2,4
	addu	$3,$2,48
	sll	$2,$2,4
	subu	$2,$6,$2
	addu	$2,$2,48
	sb	$3,2($7)
	sb	$2,3($7)
	j	$31
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
