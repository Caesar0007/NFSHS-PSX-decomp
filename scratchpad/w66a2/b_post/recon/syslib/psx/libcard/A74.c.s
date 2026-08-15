	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcard\\A74.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noreorder
	.set noat
	.globl InitCARD2
InitCARD2:
	addiu $t2, $zero, 0xB0
	jr    $t2
	 addiu $t1, $zero, 0x4A
	nop
	lhu   $t7, 10($v1)
	lui   $t0, 0
	or    $t8, $t7, $v0
	ori   $t9, $t8, 0x12
	sh    $t9, 10($v1)
	addiu $t0, $zero, 0x28
.LInitCARD2_spin:
	addiu $t0, $t0, -1
	bnez  $t0, .LInitCARD2_spin
	 nop
	jr    $ra
	 nop
	.globl func_8010C9FC
func_8010C9FC:
	lw    $v0, 4212($v1)
	nop
	andi  $v0, $v0, 0x80
	beqz  $v0, .Lcard_irq_ret
	 nop
.Lcard_irq_spin:
	lw    $v0, 4164($v1)
	nop
	andi  $v0, $v0, 0x80
	bnez  $v0, .Lcard_irq_spin
	 nop
	lui   $v0, 1
	lw    $v0, -8196($v0)
	nop
	jr    $v0
	 nop
.Lcard_irq_ret:
	jr    $ra
	 nop
	.set pop


	.text
