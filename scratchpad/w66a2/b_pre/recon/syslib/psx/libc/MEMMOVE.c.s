	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libc\\MEMMOVE.c"

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
	.globl	memmove
	.ent	memmove
memmove:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$7,$4,$0
	sltu	$2,$7,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	addu	$2,$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$2,$L7
	addu	$6,$6,-1
	.set	macro
	.set	reorder

$L5:
	addu	$4,$7,$6
	addu	$2,$5,$6
	addu	$3,$6,$0
	lbu	$2,0($2)
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L5
	sb	$2,0($4)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L12
	addu	$2,$7,$0
	.set	macro
	.set	reorder

$L2:
	.set	noreorder
	.set	nomacro
	blez	$2,$L7
	addu	$6,$6,-1
	.set	macro
	.set	reorder

$L10:
	lbu	$2,0($5)
	addu	$5,$5,1
	addu	$3,$6,$0
	addu	$6,$6,-1
	sb	$2,0($7)
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L10
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L7:
	addu	$2,$7,$0
$L12:
	j	$31
	.end	memmove
