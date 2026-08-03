	.file	1 "pO0.i"

 # -G value = 8, Cpu = R3000, ISA = 1
 # GNU C version 2.8.0 SN32 Build 4.0.0007 (SonyPlayStation) compiled by CC.
 # options passed:  -O0 -fverbose-asm
 # options enabled:  -fpeephole -ffunction-cse -fkeep-static-consts
 # -fpcc-struct-return -fcommon -fverbose-asm -fgnu-linker
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
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	lbu	$2,c8
	lw	$4,g4
	addu	$3,$2,$4
	lw	$2,big
	addu	$3,$3,$2
	move	$2,$3
	j	$L1
$L1:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	f
