	.file	1 "pO3.i"

 # -G value = 8, Cpu = R3000, ISA = 1
 # GNU C version 2.8.0 SN32 Build 4.0.0007 (SonyPlayStation) compiled by CC.
 # options passed:  -O3 -fverbose-asm
 # options enabled:  -fdefer-pop -fomit-frame-pointer -fcse-follow-jumps
 # -fcse-skip-blocks -fexpensive-optimizations -fthread-jumps
 # -fstrength-reduce -fpeephole -fforce-mem -ffunction-cse
 # -finline-functions -finline -fkeep-static-consts -fcaller-saves
 # -fpcc-struct-return -fdelayed-branch -frerun-cse-after-loop
 # -fschedule-insns -fschedule-insns2 -fcommon -fverbose-asm -fgnu-linker
 # -msplit-addresses -mgas -mgpOPT -mgpopt -msoft-float -mcpu=R3000

gcc2_compiled.:
__gnu_compiled_c:

	.comm	g4,4

	.comm	c8,8

	.comm	big,256
	.text
	.align	2
	.globl	f

	.text
	.text
	.ent	f
f:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(big) # high
	lbu	$4,c8
	lw	$2,g4
	lw	$3,%lo(big)($3)
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

	.end	f
