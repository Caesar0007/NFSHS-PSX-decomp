	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\shpdepth.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl shapedepth
shapedepth:
	lbu	$2,0($4)
	ori	$3,$0,0x41
	andi	$2,$2,0x77
	beq	$3,$2,.L800F4438
	 ori	$3,$0,0x40
	beq	$3,$2,.L800F4430
	 ori	$3,$0,0x42
	beq	$3,$2,.L800F4440
	 ori	$3,$0,0x23
	beq	$3,$2,.L800F4440
	 ori	$3,$0,0x44
	beq	$3,$2,.L800F4428
	 ori	$3,$0,0x43
	beq	$3,$2,.L800F4448
	 ori	$3,$0,0x72
	beq	$3,$2,.L800F4438
	 nop
.L800F4428:
	jr	$31
	 ori	$2,$0,0x1
.L800F4430:
	jr	$31
	 ori	$2,$0,0x4
.L800F4438:
	jr	$31
	 ori	$2,$0,0x8
.L800F4440:
	jr	$31
	 ori	$2,$0,0x10
.L800F4448:
	jr	$31
	 ori	$2,$0,0x18
	.set at
	.set reorder


	.text
