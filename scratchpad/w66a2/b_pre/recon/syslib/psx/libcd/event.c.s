	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\event.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.rdata
	.align	2
$LC0:
	.ascii	"CdInit: Init failed\n\000"
	.text
	.align	2
	.globl	CdInit
	.ent	CdInit
CdInit:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	li	$16,0x00000004		# 4
	sw	$31,20($sp)
$L2:
	jal	_cd_event_init
	li	$3,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L3
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	la	$3,_cd_event_sync
	sw	$3,CD_cbsync
	la	$3,_cd_event_ready
	sw	$3,CD_cbready
	la	$3,_cd_event_read
	sw	$3,CD_cbread
	sw	$0,CD_read_dma_mode
	j	$L5
$L3:
 #APP
 #NO_APP
	addu	$16,$16,-1
	li	$2,-1			# 0xffffffff
	bne	$16,$2,$L2
	la	$4,$LC0
	jal	printf
	addu	$2,$0,$0
$L5:
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	CdInit
	.align	2
	.globl	_cd_event_init
	.ent	_cd_event_init
_cd_event_init:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	CD_init
	bne	$2,$0,$L7
	jal	CD_initvol
	.set	noreorder
	.set	nomacro
	j	$L8
	sltu	$2,$2,1
	.set	macro
	.set	reorder

$L7:
	addu	$2,$0,$0
$L8:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_cd_event_init
	.align	2
	.globl	_cd_event_sync
	.ent	_cd_event_sync
_cd_event_sync:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	li	$4,-268435456			# 0xf0000000
	ori	$4,$4,0x0003
	.set	noreorder
	.set	nomacro
	jal	DeliverEvent
	li	$5,0x00000020		# 32
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_cd_event_sync
	.align	2
	.globl	_cd_event_ready
	.ent	_cd_event_ready
_cd_event_ready:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	li	$4,-268435456			# 0xf0000000
	ori	$4,$4,0x0003
	.set	noreorder
	.set	nomacro
	jal	DeliverEvent
	li	$5,0x00000040		# 64
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_cd_event_ready
	.align	2
	.globl	_cd_event_read
	.ent	_cd_event_read
_cd_event_read:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	li	$4,-268435456			# 0xf0000000
	ori	$4,$4,0x0003
	.set	noreorder
	.set	nomacro
	jal	DeliverEvent
	li	$5,0x00000040		# 64
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_cd_event_read
