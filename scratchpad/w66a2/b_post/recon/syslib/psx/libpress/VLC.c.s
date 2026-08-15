	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpress\\VLC.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.section .data,"aw",@progbits
	.text
	.section .data,"aw",@progbits
	.align	2
_vlc_blksize:
	.word	16777215
 #APP
	.text
	.set push
	.set noat
	.set noreorder
	.set	noreorder
.globl DecDCTvlcSize
DecDCTvlcSize:
	lui        $t0, %hi(_vlc_blksize)
	addiu      $t0, $t0, %lo(_vlc_blksize)
	addi       $at, $a0, -1
	blez       $at, .L800F7420
	lw        $v0, 0($t0)
	sll        $at, $a0, 1
	jr         $ra
	sw        $at, 0($t0)
.L800F7420:
	lui        $at, (16777215 >> 16)
	ori        $at, $at, (16777215 & 65535)
	jr         $ra
	sw        $at, 0($t0)
.set pop

	.text
	.set push
	.set noat
	.set noreorder
	.set	noreorder
.globl DecDCTvlc
DecDCTvlc:
	lui        $t0, %hi(_vlc_blksize)
	addiu      $t0, $t0, %lo(_vlc_blksize)
	lui        $a2, %hi(CF_DVLC)
	addiu      $a2, $a2, %lo(CF_DVLC)
	lui        $a3, %hi(CF2_DVLC)
	addiu      $a3, $a3, %lo(CF2_DVLC)
	bnez       $a0, .L800F7488
	lw        $t1, 0($t0)
	lui        $t0, %hi(_vlc_state)
	addiu      $t0, $t0, %lo(_vlc_state)
	lw         $a0, 0($t0)
	lw         $a1, 4($t0)
	lw         $v0, 8($t0)
	lw         $v1, 12($t0)
	lw         $t4, 16($t0)
	lw         $t5, 20($t0)
	lw         $t7, 24($t0)
	lw         $t8, 28($t0)
	lw         $t9, 32($t0)
	add        $t1, $t1, $t1
	b          .L800F7614
	add       $t6, $a1, $t1
.L800F7488:
	add        $t5, $zero, $zero
	add        $t7, $zero, $zero
	add        $t8, $zero, $zero
	add        $t9, $zero, $zero
	add        $t1, $t1, $t1
	add        $t6, $a1, $t1
	lw         $t1, 0($a0)
	lhu        $t4, 4($a0)
	lhu        $t2, 6($a0)
	lhu        $v0, 8($a0)
	lhu        $v1, 10($a0)
	addi       $t2, $t2, -3
	bltz       $t2, .L800F74C4
	sll       $t4, $t4, 10
	addi       $t5, $zero, 1
.L800F74C4:
	addi       $a0, $a0, 12
	sll        $v0, $v0, 16
	or         $v0, $v0, $v1
	or         $v1, $zero, $zero
	sw         $t1, 0($a1)
	andi       $t1, $t1, 65535
	sll        $t1, $t1, 2
	addiu      $t1, $t1, 4
	add        $t1, $t1, $a1
	lui        $t0, %hi(_vlc_end)
	addiu      $t0, $t0, %lo(_vlc_end)
	sw         $t1, 0($t0)
	addi       $a1, $a1, 2
.L800F74F8:
	beqz       $t5, .L800F75D0
	srl       $t0, $v0, 22
	xori       $at, $t0, 1023
	beqz       $at, .L800F771C
	addi      $a1, $a1, 2
	addi       $at, $t5, -3
	bltz       $at, .L800F751C
	addi      $at, $a2, -1024
	addi       $at, $at, -1024
.L800F751C:
	srl        $t0, $v0, 24
	sll        $t0, $t0, 2
	add        $t0, $t0, $at
	lhu        $t1, 0($t0)
	lhu        $t2, 2($t0)
	and        $t0, $zero, $zero
	beqz       $t2, .L800F7560
	sllv      $v0, $v0, $t1
	addi       $at, $zero, 32
	sub        $at, $at, $t2
	srlv       $t0, $v0, $at
	bltz       $v0, .L800F755C
	sllv      $v0, $v0, $t2
	addi       $t3, $zero, -1
	srlv       $t3, $t3, $at
	sub        $t0, $t0, $t3
.L800F755C:
	add        $v1, $v1, $t2
.L800F7560:
	add        $v1, $v1, $t1
	andi       $at, $v1, 16
	beqz       $at, .L800F7580
	andi      $v1, $v1, 15
	lhu        $t1, 0($a0)
	addi       $a0, $a0, 2
	sllv       $t1, $t1, $v1
	or         $v0, $v0, $t1
.L800F7580:
	addi       $at, $t5, -2
	bgtz       $at, .L800F75A8
	add       $t1, $t9, $t0
	beqz       $at, .L800F75A0
	add       $t1, $t8, $t0
	add        $t1, $t7, $t0
	b          .L800F75AC
	add       $t7, $t7, $t0
.L800F75A0:
	b          .L800F75AC
	add       $t8, $t8, $t0
.L800F75A8:
	add        $t9, $t9, $t0
.L800F75AC:
	sll        $t1, $t1, 2
	andi       $t1, $t1, 1023
	or         $t1, $t4, $t1
	addi       $t5, $t5, 1
	addi       $at, $t5, -7
	bnez       $at, .L800F7608
	sh        $t1, 0($a1)
	b          .L800F7608
	addi      $t5, $t5, -6
.L800F75D0:
	xori       $at, $t0, 511
	beqz       $at, .L800F771C
	addi      $a1, $a1, 2
	sll        $v0, $v0, 10
	addi       $v1, $v1, 10
	andi       $at, $v1, 16
	beqz       $at, .L800F7600
	andi      $v1, $v1, 15
	lhu        $t1, 0($a0)
	addi       $a0, $a0, 2
	sllv       $t1, $t1, $v1
	or         $v0, $v0, $t1
.L800F7600:
	or         $t0, $t4, $t0
	sh         $t0, 0($a1)
.L800F7608:
	subu       $at, $a1, $t6
	bgez       $at, .L800F774C
	addi      $a1, $a1, 2
.L800F7614:
	srl        $t0, $v0, 19
	sll        $t0, $t0, 3
	add        $t0, $t0, $a2
	lw         $t1, 0($t0)
	nop
	bnez       $t1, .L800F7670
	andi      $at, $t1, 255
	sll        $v0, $v0, 8
	addi       $v1, $v1, 8
	andi       $at, $v1, 16
	beqz       $at, .L800F7654
	andi      $v1, $v1, 15
	lhu        $t0, 0($a0)
	addi       $a0, $a0, 2
	sllv       $t0, $t0, $v1
	or         $v0, $v0, $t0
.L800F7654:
	srl        $t0, $v0, 23
	sll        $t0, $t0, 2
	add        $t0, $t0, $a3
	lw         $t1, 0($t0)
	add        $t3, $zero, $zero
	b          .L800F7674
	andi      $at, $t1, 255
.L800F7670:
	lw         $t3, 4($t0)
.L800F7674:
	sllv       $v0, $v0, $at
	add        $v1, $v1, $at
	andi       $at, $v1, 16
	beqz       $at, .L800F7698
	andi      $v1, $v1, 15
	lhu        $t0, 0($a0)
	addi       $a0, $a0, 2
	sllv       $t0, $t0, $v1
	or         $v0, $v0, $t0
.L800F7698:
	srl        $t1, $t1, 16
	xori       $at, $t1, 31775
	beqz       $at, .L800F76F8
	xori      $at, $t1, 65024
	beqz       $at, .L800F74F8
	sh        $t1, 0($a1)
	beqz       $t3, .L800F7614
	addi      $a1, $a1, 2
	andi       $t2, $t3, 65535
	xori       $at, $t2, 31775
	beqz       $at, .L800F76F8
	xori      $at, $t2, 65024
	beqz       $at, .L800F74F8
	sh        $t2, 0($a1)
	srl        $t2, $t3, 16
	beqz       $t2, .L800F7614
	addi      $a1, $a1, 2
	xori       $at, $t2, 31775
	beqz       $at, .L800F76F8
	xori      $at, $t2, 65024
	beqz       $at, .L800F74F8
	sh        $t2, 0($a1)
	b          .L800F7614
	addi      $a1, $a1, 2
.L800F76F8:
	srl        $t0, $v0, 16
	sh         $t0, 0($a1)
	addi       $a1, $a1, 2
	lhu        $t0, 0($a0)
	addi       $a0, $a0, 2
	sll        $v0, $v0, 16
	sllv       $t0, $t0, $v1
	b          .L800F7614
	or        $v0, $v0, $t0
.L800F771C:
	lui        $t0, %hi(_vlc_end)
	addiu      $t0, $t0, %lo(_vlc_end)
	lw         $t1, 0($t0)
	ori        $t0, $zero, 65024
.L800F772C:
	subu       $at, $a1, $t1
	bgez       $at, .L800F7744
	nop
	sh         $t0, 0($a1)
	b          .L800F772C
	addi      $a1, $a1, 2
.L800F7744:
	jr         $ra
	add       $v0, $zero, $zero
.L800F774C:
	lui        $t0, %hi(_vlc_state)
	addiu      $t0, $t0, %lo(_vlc_state)
	sw         $a0, 0($t0)
	sw         $a1, 4($t0)
	sw         $v0, 8($t0)
	sw         $v1, 12($t0)
	sw         $t4, 16($t0)
	sw         $t5, 20($t0)
	sw         $t7, 24($t0)
	sw         $t8, 28($t0)
	sw         $t9, 32($t0)
	jr         $ra
	addi      $v0, $zero, 1
.set pop

 #NO_APP
	.section .bss,"aw",@progbits
	.text
	.section .bss,"aw",@progbits
	.align	2
_vlc_state:
	.space	36
	.text
	.section .bss,"aw",@progbits
	.align	2
_vlc_end:
	.space	4

	.text
	.def	u_long;	.scl	13;	.type	0xf;	.endef
	.def	u_int;	.scl	13;	.type	0xe;	.endef
	.def	u_short;	.scl	13;	.type	0xd;	.endef
	.def	_vlc_state;	.val	_vlc_state;	.scl	3;	.dim	9;	.size	36;	.type	0x3e;	.endef
	.def	_vlc_end;	.val	_vlc_end;	.scl	3;	.type	0x1d;	.endef
	.def	_vlc_blksize;	.val	_vlc_blksize;	.scl	3;	.type	0x4;	.endef
