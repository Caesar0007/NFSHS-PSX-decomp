	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\DBSHIFT.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noat
	.set	noreorder
	.set noreorder
	.globl _dbl_shift
_dbl_shift:
	sw	$a2,8($sp)
	lw	$a2,16($sp)
	addu	$t0,$a0,$zero
	bnez	$a1,.L80106EA0
	 sw	$a3,12($sp)
	blez	$a2,.L80106EE4
	 addu	$a0,$zero,$zero
	lui	$a3,32768
.L80106E60:
	lw	$v0,12($sp)
	lw	$a1,8($sp)
	sll	$v1,$v0,1
	and	$v0,$a1,$a3
	beqz	$v0,.L80106E80
	 sw	$v1,12($sp)
	ori	$v0,$v1,1
	sw	$v0,12($sp)
.L80106E80:
	sll	$v0,$a1,1
	sw	$v0,8($sp)
	addiu	$a0,$a0,1
	slt	$v0,$a0,$a2
	beqz	$v0,.L80106EE4
	 nop
	j	.L80106E60
	 nop
.L80106EA0:
	blez	$a2,.L80106EE4
	 addu	$a0,$zero,$zero
	lui	$a3,32768
.L80106EAC:
	lw	$v0,8($sp)
	lw	$a1,12($sp)
	srl	$v1,$v0,1
	andi	$v0,$a1,1
	beqz	$v0,.L80106ECC
	 sw	$v1,8($sp)
	or	$v0,$v1,$a3
	sw	$v0,8($sp)
.L80106ECC:
	sra	$v0,$a1,1
	sw	$v0,12($sp)
	addiu	$a0,$a0,1
	slt	$v0,$a0,$a2
	bnez	$v0,.L80106EAC
	 nop
.L80106EE4:
	lw	$v0,8($sp)
	lw	$v1,12($sp)
	sw	$v0,0($t0)
	sw	$v1,4($t0)
	jr	$ra
	 addu	$v0,$t0,$zero
	.set pop


	.text
