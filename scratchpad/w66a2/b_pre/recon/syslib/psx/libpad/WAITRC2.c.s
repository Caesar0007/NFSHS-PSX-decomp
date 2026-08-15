	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\WAITRC2.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	setRC2wait
	.ent	setRC2wait
setRC2wait:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,0x1f800000		# 528482304
	ori	$2,$2,0x1120
	#.set	volatile
	lhu	$2,0($2)
	#.set	novolatile
	sw	$4,_waitTime
	sw	$2,_startTime
	j	$31
	.end	setRC2wait
	.align	2
	.globl	chkRC2wait
	.ent	chkRC2wait
chkRC2wait:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,0x1f800000		# 528482304
	ori	$2,$2,0x1120
	#.set	volatile
	lhu	$3,0($2)
	#.set	novolatile
	lw	$2,_startTime
	andi	$4,$3,0xffff
	sltu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	li	$3,0x1f800000		# 528482304
	.set	macro
	.set	reorder

	ori	$3,$3,0x1128
	#.set	volatile
	lhu	$2,0($3)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	li	$2,0x00010000		# 65536
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,0($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L3
	addu	$4,$4,$2
	.set	macro
	.set	reorder

$L4:
	addu	$4,$4,$2
$L3:
	li	$2,0x1f800000		# 528482304
	ori	$2,$2,0x1124
	#.set	volatile
	lhu	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0200
	bne	$2,$0,$L6
	lw	$2,_startTime
	lw	$3,_waitTime
	subu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L9
	srl	$2,$2,3
	.set	macro
	.set	reorder

$L6:
	lw	$2,_startTime
	lw	$3,_waitTime
	subu	$2,$4,$2
$L9:
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	chkRC2wait
