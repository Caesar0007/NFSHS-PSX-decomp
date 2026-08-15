	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\ADDMANT.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noat
	.set	noreorder
	.set noreorder
	.globl _add_mant_d
_add_mant_d:
	addiu	$sp,$sp,-16
	addu	$t1,$a0,$zero
	srl	$t0,$a1,16
	sw	$a1,20($sp)
	andi	$a1,$a1,0xFFFF
	srl	$v1,$a3,16
	sw	$a3,28($sp)
	andi	$a3,$a3,0xFFFF
	addu	$a0,$a1,$a3
	sw	$a1,0($sp)
	lui	$a1,1
	and	$v0,$a0,$a1
	sw	$a2,24($sp)
	sw	$t0,4($sp)
	sw	$v1,12($sp)
	sw	$a3,8($sp)
	beqz	$v0,.L80106FC0
	 sw	$a0,0($sp)
	addiu	$v0,$t0,1
	sw	$v0,4($sp)
.L80106FC0:
	lw	$v0,4($sp)
	nop
	addu	$a3,$v0,$v1
	and	$v0,$a3,$a1
	beqz	$v0,.L80106FE0
	 sw	$a3,4($sp)
	addiu	$a2,$a2,1
	sw	$a2,24($sp)
.L80106FE0:
	sll	$v0,$a3,16
	andi	$a0,$a0,0xFFFF
	lw	$v1,24($sp)
	lw	$a1,32($sp)
	or	$v0,$v0,$a0
	sw	$v0,20($sp)
	addu	$v1,$v1,$a1
	sw	$v1,24($sp)
	lw	$v0,20($sp)
	lw	$v1,24($sp)
	sw	$v0,0($t1)
	sw	$v1,4($t1)
	addu	$v0,$t1,$zero
	jr	$ra
	 addiu	$sp,$sp,16
	.set pop


	.text
