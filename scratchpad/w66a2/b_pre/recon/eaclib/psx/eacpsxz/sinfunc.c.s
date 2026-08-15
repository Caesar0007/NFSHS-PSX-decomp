	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\sinfunc.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl intcos
intcos:
fastintcos:
	addiu	$4,$4,256
	.globl intsin
intsin:
fastintsin:
	lui	$12,%hi(sintbl)
	addiu	$12,$12,%lo(sintbl)
	andi	$9,$4,512
	andi	$10,$4,256
	bnez	$9,.L800F1928
	 andi	$8,$4,255
	bnez	$10,.L800F1918
	 sll	$11,$8,2
	addu	$13,$12,$11
	lw	$2,0($13)
	jr	$31
	 nop
.L800F1918:
	subu	$13,$12,$11
	lw	$2,1024($13)
	jr	$31
	 nop
.L800F1928:
	bnez	$10,.L800F1940
	 sll	$11,$8,2
	addu	$13,$12,$11
	lw	$2,0($13)
	jr	$31
	 negu	$2,$2
.L800F1940:
	subu	$13,$12,$11
	lw	$2,1024($13)
	jr	$31
	 negu	$2,$2
	.set at
	.set reorder

		.globl fastintcos
	.globl fastintsin


	.text
