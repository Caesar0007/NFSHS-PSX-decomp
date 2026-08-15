	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libc\\MEMCMP.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	memcmp
	.ent	memcmp
memcmp:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$L2
$L3:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bgtz	$6,$L4
	addu	$5,$5,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L6
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L4:
$L2:
	lbu	$3,0($4)
	lbu	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L3
	addu	$4,$4,1
	.set	macro
	.set	reorder

	addu	$4,$4,-1
	#.set	volatile
	lbu	$3,0($4)
	#.set	novolatile
	#.set	volatile
	lbu	$2,0($5)
	#.set	novolatile
	#nop
	subu	$2,$3,$2
$L6:
	j	$31
	.end	memcmp
