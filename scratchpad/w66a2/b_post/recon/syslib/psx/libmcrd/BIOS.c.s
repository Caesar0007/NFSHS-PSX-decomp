	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmcrd\\BIOS.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.section .data,"aw",@progbits
	.align	2
_card_evhandle0:
	.word	0
	.align	2
_card_evhandle1:
	.word	0
	.align	2
_card_evhandle2:
	.word	0
	.align	2
_card_evhandle3:
	.word	0
	.align	2
_card_evhandle4:
	.word	0
	.align	2
_card_evhandle5:
	.word	0
	.align	2
_card_evhandle6:
	.word	0
	.align	2
_card_evhandle7:
	.word	0
	.align	2
_card_evflag0:
	.word	0
	.align	2
_card_evflag1:
	.word	0
	.align	2
_card_evflag2:
	.word	0
	.align	2
_card_evflag3:
	.word	0
	.align	2
_card_evflag4:
	.word	0
	.align	2
_card_evflag5:
	.word	0
	.align	2
_card_evflag6:
	.word	0
	.align	2
_card_evflag7:
	.word	0
	.text
	.align	2
	.globl	funcEvSpIOE
	.ent	funcEvSpIOE
funcEvSpIOE:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,0x00000001		# 1
	#.set	volatile
	sw	$2,_card_evflag0
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.end	funcEvSpIOE
	.align	2
	.globl	funcEvSpError
	.ent	funcEvSpError
funcEvSpError:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,0x00000001		# 1
	#.set	volatile
	sw	$2,_card_evflag1
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.end	funcEvSpError
	.align	2
	.globl	funcEvSpTimeout
	.ent	funcEvSpTimeout
funcEvSpTimeout:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,0x00000001		# 1
	#.set	volatile
	sw	$2,_card_evflag2
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.end	funcEvSpTimeout
	.align	2
	.globl	funcEvSpNewcard
	.ent	funcEvSpNewcard
funcEvSpNewcard:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,0x00000001		# 1
	#.set	volatile
	sw	$2,_card_evflag3
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.end	funcEvSpNewcard
	.align	2
	.globl	funcEvSpIOEx
	.ent	funcEvSpIOEx
funcEvSpIOEx:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,0x00000001		# 1
	#.set	volatile
	sw	$2,_card_evflag4
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.end	funcEvSpIOEx
	.align	2
	.globl	funcEvSpErrorx
	.ent	funcEvSpErrorx
funcEvSpErrorx:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,0x00000001		# 1
	#.set	volatile
	sw	$2,_card_evflag5
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.end	funcEvSpErrorx
	.align	2
	.globl	funcEvSpTimeoutx
	.ent	funcEvSpTimeoutx
funcEvSpTimeoutx:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,0x00000001		# 1
	#.set	volatile
	sw	$2,_card_evflag6
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.end	funcEvSpTimeoutx
	.align	2
	.globl	funcEvSpNewcardx
	.ent	funcEvSpNewcardx
funcEvSpNewcardx:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,0x00000001		# 1
	#.set	volatile
	sw	$2,_card_evflag7
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.end	funcEvSpNewcardx
	.align	2
	.globl	_card_open
	.ent	_card_open
_card_open:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	InitCARD
	jal	StartCARD
	jal	_bu_init
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_card_open
	.align	2
	.globl	_card_start
	.ent	_card_start
_card_start:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	EnterCriticalSection
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	li	$4,-201326592			# 0xf4000000
	ori	$4,$4,0x0001
	li	$5,0x00000004		# 4
	li	$6,0x00001000		# 4096
	la	$7,funcEvSpIOE
	.set	noreorder
	.set	nomacro
	jal	OpenEvent
	addu	$16,$2,$0
	.set	macro
	.set	reorder

	li	$4,-201326592			# 0xf4000000
	ori	$4,$4,0x0001
	li	$5,0x00008000		# 32768
	la	$7,funcEvSpError
	sw	$2,_card_evhandle0
	.set	noreorder
	.set	nomacro
	jal	OpenEvent
	li	$6,0x00001000		# 4096
	.set	macro
	.set	reorder

	li	$4,-201326592			# 0xf4000000
	ori	$4,$4,0x0001
	li	$5,0x00000100		# 256
	la	$7,funcEvSpTimeout
	sw	$2,_card_evhandle1
	.set	noreorder
	.set	nomacro
	jal	OpenEvent
	li	$6,0x00001000		# 4096
	.set	macro
	.set	reorder

	li	$4,-201326592			# 0xf4000000
	ori	$4,$4,0x0001
	li	$5,0x00002000		# 8192
	la	$7,funcEvSpNewcard
	sw	$2,_card_evhandle2
	.set	noreorder
	.set	nomacro
	jal	OpenEvent
	li	$6,0x00001000		# 4096
	.set	macro
	.set	reorder

	li	$4,-268435456			# 0xf0000000
	ori	$4,$4,0x0011
	li	$5,0x00000004		# 4
	la	$7,funcEvSpIOEx
	sw	$2,_card_evhandle3
	.set	noreorder
	.set	nomacro
	jal	OpenEvent
	li	$6,0x00001000		# 4096
	.set	macro
	.set	reorder

	li	$4,-268435456			# 0xf0000000
	ori	$4,$4,0x0011
	li	$5,0x00008000		# 32768
	la	$7,funcEvSpErrorx
	sw	$2,_card_evhandle4
	.set	noreorder
	.set	nomacro
	jal	OpenEvent
	li	$6,0x00001000		# 4096
	.set	macro
	.set	reorder

	li	$4,-268435456			# 0xf0000000
	ori	$4,$4,0x0011
	li	$5,0x00000100		# 256
	la	$7,funcEvSpTimeoutx
	sw	$2,_card_evhandle5
	.set	noreorder
	.set	nomacro
	jal	OpenEvent
	li	$6,0x00001000		# 4096
	.set	macro
	.set	reorder

	li	$4,-268435456			# 0xf0000000
	ori	$4,$4,0x0011
	li	$5,0x00002000		# 8192
	la	$7,funcEvSpNewcardx
	sw	$2,_card_evhandle6
	.set	noreorder
	.set	nomacro
	jal	OpenEvent
	li	$6,0x00001000		# 4096
	.set	macro
	.set	reorder

	lw	$4,_card_evhandle0
	sw	$2,_card_evhandle7
	jal	EnableEvent
	lw	$4,_card_evhandle1
	jal	EnableEvent
	lw	$4,_card_evhandle2
	jal	EnableEvent
	lw	$4,_card_evhandle3
	jal	EnableEvent
	lw	$4,_card_evhandle4
	jal	EnableEvent
	lw	$4,_card_evhandle5
	jal	EnableEvent
	lw	$4,_card_evhandle6
	jal	EnableEvent
	lw	$4,_card_evhandle7
	jal	EnableEvent
	jal	_clr_card_event
	li	$2,0x00000001		# 1
	bne	$16,$2,$L11
	jal	ExitCriticalSection
$L11:
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_card_start
	.align	2
	.globl	_card_close
	.ent	_card_close
_card_close:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	StopCARD
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_card_close
	.align	2
	.globl	_card_stop
	.ent	_card_stop
_card_stop:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	EnterCriticalSection
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$4,_card_evhandle0
	.set	noreorder
	.set	nomacro
	jal	CloseEvent
	addu	$16,$2,$0
	.set	macro
	.set	reorder

	lw	$4,_card_evhandle1
	jal	CloseEvent
	lw	$4,_card_evhandle2
	jal	CloseEvent
	lw	$4,_card_evhandle3
	jal	CloseEvent
	lw	$4,_card_evhandle4
	jal	CloseEvent
	lw	$4,_card_evhandle5
	jal	CloseEvent
	lw	$4,_card_evhandle6
	jal	CloseEvent
	lw	$4,_card_evhandle7
	jal	CloseEvent
	li	$2,0x00000001		# 1
	bne	$16,$2,$L14
	jal	ExitCriticalSection
$L14:
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_card_stop
	.align	2
	.globl	_clr_card_event
	.ent	_clr_card_event
_clr_card_event:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,_card_evhandle0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	TestEvent
	lw	$4,_card_evhandle1
	jal	TestEvent
	lw	$4,_card_evhandle2
	jal	TestEvent
	lw	$4,_card_evhandle3
	jal	TestEvent
	lw	$4,_card_evhandle4
	jal	TestEvent
	lw	$4,_card_evhandle5
	jal	TestEvent
	lw	$4,_card_evhandle6
	jal	TestEvent
	lw	$4,_card_evhandle7
	jal	TestEvent
	#.set	volatile
	sw	$0,_card_evflag3
	#.set	novolatile
	#.set	volatile
	lw	$2,_card_evflag3
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,_card_evflag2
	#.set	novolatile
	#.set	volatile
	lw	$2,_card_evflag2
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,_card_evflag1
	#.set	novolatile
	#.set	volatile
	lw	$2,_card_evflag1
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,_card_evflag0
	#.set	novolatile
	#.set	volatile
	sw	$0,_card_evflag7
	#.set	novolatile
	#.set	volatile
	lw	$2,_card_evflag7
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,_card_evflag6
	#.set	novolatile
	#.set	volatile
	lw	$2,_card_evflag6
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,_card_evflag5
	#.set	novolatile
	#.set	volatile
	lw	$2,_card_evflag5
	#.set	novolatile
 #APP
 #NO_APP
	#nop
	#.set	volatile
	sw	$2,_card_evflag4
	#.set	novolatile
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_clr_card_event
	.align	2
	.globl	_get_card_event
	.ent	_get_card_event
_get_card_event:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
$L17:
	#.set	volatile
	lw	$2,_card_evflag1
	#.set	novolatile
	#.set	volatile
	lw	$4,_card_evflag0
	#.set	novolatile
	#.set	volatile
	lw	$3,_card_evflag2
	#.set	novolatile
	sll	$2,$2,1
	addu	$4,$4,$2
	sll	$3,$3,2
	#.set	volatile
	lw	$2,_card_evflag3
	#.set	novolatile
	addu	$4,$4,$3
	sll	$2,$2,3
	addu	$16,$4,$2
	beq	$16,$0,$L17
	lw	$4,_card_evhandle4
	jal	TestEvent
	lw	$4,_card_evhandle5
	jal	TestEvent
	lw	$4,_card_evhandle6
	jal	TestEvent
	lw	$4,_card_evhandle7
	jal	TestEvent
	#.set	volatile
	sw	$0,_card_evflag3
	#.set	novolatile
	#.set	volatile
	lw	$2,_card_evflag3
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,_card_evflag2
	#.set	novolatile
	#.set	volatile
	lw	$2,_card_evflag2
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,_card_evflag1
	#.set	novolatile
	#.set	volatile
	lw	$3,_card_evflag1
	#.set	novolatile
	sra	$2,$16,1
	#.set	volatile
	sw	$3,_card_evflag0
	#.set	novolatile
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_get_card_event
	.align	2
	.globl	_get_card_event_x
	.ent	_get_card_event_x
_get_card_event_x:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
$L22:
	#.set	volatile
	lw	$2,_card_evflag5
	#.set	novolatile
	#.set	volatile
	lw	$4,_card_evflag4
	#.set	novolatile
	#.set	volatile
	lw	$3,_card_evflag6
	#.set	novolatile
	sll	$2,$2,1
	addu	$4,$4,$2
	sll	$3,$3,2
	#.set	volatile
	lw	$2,_card_evflag7
	#.set	novolatile
	addu	$4,$4,$3
	sll	$2,$2,3
	addu	$16,$4,$2
	beq	$16,$0,$L22
	lw	$4,_card_evhandle0
	jal	TestEvent
	lw	$4,_card_evhandle1
	jal	TestEvent
	lw	$4,_card_evhandle2
	jal	TestEvent
	lw	$4,_card_evhandle3
	jal	TestEvent
	#.set	volatile
	sw	$0,_card_evflag7
	#.set	novolatile
	#.set	volatile
	lw	$2,_card_evflag7
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,_card_evflag6
	#.set	novolatile
	#.set	volatile
	lw	$2,_card_evflag6
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,_card_evflag5
	#.set	novolatile
	#.set	volatile
	lw	$3,_card_evflag5
	#.set	novolatile
	sra	$2,$16,1
	#.set	volatile
	sw	$3,_card_evflag4
	#.set	novolatile
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_get_card_event_x
	.align	2
	.globl	_chk_card_event
	.ent	_chk_card_event
_chk_card_event:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	#.set	volatile
	lw	$2,_card_evflag1
	#.set	novolatile
	#.set	volatile
	lw	$4,_card_evflag0
	#.set	novolatile
	#.set	volatile
	lw	$3,_card_evflag2
	#.set	novolatile
	sll	$2,$2,1
	addu	$4,$4,$2
	sll	$3,$3,2
	#.set	volatile
	lw	$2,_card_evflag3
	#.set	novolatile
	addu	$4,$4,$3
	sll	$2,$2,3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder

	.end	_chk_card_event
	.align	2
	.globl	_chk_card_event_x
	.ent	_chk_card_event_x
_chk_card_event_x:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	#.set	volatile
	lw	$2,_card_evflag5
	#.set	novolatile
	#.set	volatile
	lw	$4,_card_evflag4
	#.set	novolatile
	#.set	volatile
	lw	$3,_card_evflag6
	#.set	novolatile
	sll	$2,$2,1
	addu	$4,$4,$2
	sll	$3,$3,2
	#.set	volatile
	lw	$2,_card_evflag7
	#.set	novolatile
	addu	$4,$4,$3
	sll	$2,$2,3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder

	.end	_chk_card_event_x
