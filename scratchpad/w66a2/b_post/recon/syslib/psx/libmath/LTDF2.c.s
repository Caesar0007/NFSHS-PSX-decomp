	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\LTDF2.c"

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
	.globl	__ltdf2
	.ent	__ltdf2
__ltdf2:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$8,$4,$0
	addu	$9,$5,$0
	.set	noreorder
	.set	nomacro
	bne	$9,$7,$L18
	li	$3,2147418112			# 0x7fff0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$8,$6,$L17
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L18:
	ori	$3,$3,0xffff
	and	$2,$9,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

	bne	$8,$0,$L19
	and	$2,$7,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

	beq	$6,$0,$L4
$L19:
	and	$3,$9,$2
	and	$2,$7,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L5
	sra	$2,$9,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L16
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L17
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L5:
	andi	$4,$2,0x07ff
	sra	$2,$7,20
	andi	$3,$2,0x07ff
	slt	$2,$4,$3
	bne	$2,$0,$L8
	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L10
	li	$2,983040			# 0x000f0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	and	$3,$9,$2
	li	$4,1048576			# 0x00100000
	or	$3,$3,$4
	and	$2,$7,$2
	or	$4,$2,$4
	slt	$2,$3,$4
	bne	$2,$0,$L8
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L10
	sltu	$2,$8,$6
	.set	macro
	.set	reorder

	beq	$2,$0,$L10
$L8:
	.set	noreorder
	.set	nomacro
	bltz	$9,$L16
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L16
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L10:
	.set	noreorder
	.set	nomacro
	bltz	$9,$L16
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L4:
	addu	$2,$0,$0
$L16:
$L17:
	j	$31
	.end	__ltdf2
