	.file	1 "pO1.i"

 # -G value = 8, Cpu = R3000, ISA = 1
 # GNU C version 2.8.0 SN32 Build 4.0.0007 (SonyPlayStation) compiled by CC.
 # options passed:  -O1 -fverbose-asm
 # options enabled:  -fdefer-pop -fomit-frame-pointer -fthread-jumps
 # -fpeephole -ffunction-cse -finline -fkeep-static-consts
 # -fpcc-struct-return -fdelayed-branch -fcommon -fverbose-asm -fgnu-linker
 # -msplit-addresses -mgas -mgpOPT -mgpopt -msoft-float -mcpu=R3000

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	f

	.comm	g4,4

	.comm	c8,8

	.comm	big,256

	.text
	.text
	.ent	f
f:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,c8
	lw	$3,g4
	#nop
	addu	$2,$2,$3
	lui	$3,%hi(big) # high
	lw	$3,%lo(big)($3)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

	.end	f
