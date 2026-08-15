	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\GTDF2.c"

 # -G value = 0, Cpu = 3000, ISA = 1
 # GNU C version cygnus-2.7.2-970404 SN32.3.7.0004 (SonyPSX) compiled by CC.
 # options passed:  -O2 -G0 -mgas
 # options enabled:  -fdefer-pop -fomit-frame-pointer -fcse-follow-jumps
 # -fcse-skip-blocks -fexpensive-optimizations -fthread-jumps
 # -fstrength-reduce -fpeephole -fforce-mem -ffunction-cse -finline
 # -fkeep-static-consts -fcaller-saves -fpcc-struct-return -fdelayed-branch
 # -frerun-cse-after-loop -fschedule-insns -fschedule-insns2 -fcommon
 # -fverbose-asm -fgnu-linker -mgas -msoft-float -mcpu=3000

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__gtdf2
	.ent	__gtdf2
__gtdf2:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$8,$4,$0
	addu	$9,$5,$0
	.set	noreorder
	.set	nomacro
	bne	$9,$7,$L16
	li	$3,2147418112			# 0x7fff0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$8,$6,$L17
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L16:
	ori	$3,$3,0xffff
	and	$2,$9,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L18
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

	bne	$8,$0,$L18
	and	$2,$7,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L18
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L19
	and	$3,$9,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L14
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L18:
	and	$3,$9,$2
$L19:
	and	$2,$7,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L14
	sltu	$2,$3,1
	.set	macro
	.set	reorder

	sra	$2,$9,20
	andi	$4,$2,0x07ff
	sra	$2,$7,20
	andi	$3,$2,0x07ff
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L20
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L17
	slt	$2,$9,0
	.set	macro
	.set	reorder

	li	$2,983040			# 0x000f0000
	ori	$2,$2,0xffff
	and	$3,$9,$2
	li	$4,1048576			# 0x00100000
	or	$3,$3,$4
	and	$2,$7,$2
	or	$4,$2,$4
	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L20
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L17
	slt	$2,$9,0
	.set	macro
	.set	reorder

	sltu	$2,$6,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L12
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

$L20:
	and	$2,$9,$2
	.set	noreorder
	.set	nomacro
	j	$L14
	sltu	$2,$2,1
	.set	macro
	.set	reorder

$L12:
	slt	$2,$9,0
$L14:
$L17:
	j	$31
	.end	__gtdf2
