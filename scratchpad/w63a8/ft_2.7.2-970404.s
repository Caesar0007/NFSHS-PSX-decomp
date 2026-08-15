	.file	1 "C:\\Temp\\nfs4-decomp\\scratchpad\\w63a8\\flagtest.i"

 # -G value = 0, Cpu = 3000, ISA = 1
 # GNU C version cygnus-2.7.2-970404 SN32.3.7.0004 (SonyPSX) compiled by CC.
 # options passed:  -O2 -G0 -mgas -mno-split-addresses
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
	.globl	f
	.ent	f
f:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$2,$4
	lui	$3,%hi(g) # high
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,%lo(g)($3)
	.set	macro
	.set	reorder

	.end	f

	.comm	g,4
