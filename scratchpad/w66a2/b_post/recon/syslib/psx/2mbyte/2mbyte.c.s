	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\2mbyte\\2mbyte.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
	.text
	.set push
	.set noat
	.set noreorder
	.set	noreorder
.globl __main
__main:
	jr         $ra
	nop
.set pop

	.text
	.set push
	.set noat
	.set noreorder
	.set	noreorder
.globl __SN_ENTRY_POINT
__SN_ENTRY_POINT:
.globl stup2
stup2:
	lui        $v0, %hi(_bss_obj)
	addiu      $v0, $v0, %lo(_bss_obj)
	lui        $v1, %hi(__last_org)
	addiu      $v1, $v1, %lo(__last_org)
.L800E403C:
	sw         $zero, 0($v0)
	addiu      $v0, $v0, 4
	sltu       $at,$v0,$v1
	bnez       $at, .L800E403C
	nop
.set pop

	.text
	.set push
	.set noat
	.set noreorder
	.set	noreorder
.globl stup1
stup1:
	addiu      $v0, $zero, 4
	nop
	nop
	nop
	nop
	lui        $a0, %hi(D_800E40D8)
	addiu      $a0, $a0, %lo(D_800E40D8)
	addu       $a0, $a0, $v0
	lw         $v0, 0($a0)
	lui        $t0, %hi(D_80000004)
	or         $sp, $v0, $t0
	lui        $a0, %hi(__last_org)
	addiu      $a0, $a0, %lo(__last_org)
	sll        $a0, $a0, 3
	srl        $a0, $a0, 3
	lui        $v1, %hi(_stacksize)
	lw         $v1, %lo(_stacksize)($v1)
	nop
	subu       $a1, $v0, $v1
	subu       $a1, $a1, $a0
	or         $a0, $a0, $t0
	lui        $at, %hi(D_8013DE5C)
	sw         $ra, %lo(D_8013DE5C)($at)
	lui        $gp, %hi(_gp)
	addiu      $gp, $gp, %lo(_gp)
	addu       $fp, $sp, $zero
	jal        InitHeap
	addi      $a0, $a0, %lo(D_80000004)
	lui        $ra, %hi(D_8013DE5C)
	lw         $ra, %lo(D_8013DE5C)($ra)
D_800E40C8:
	nop
.set pop

	.text
	.set push
	.set noat
	.set noreorder
	.set	noreorder
.globl stup0
stup0:
	jal        main
	nop
	break      1
	.type      stup0, @function
	.size      stup0, 0x1c
	.globl     D_800E40D8
D_800E40D8:
	.type      D_800E40D8, @function
	.size      D_800E40D8, 0x10
	.word      2097152
	.word      2097152
	.word      2097152
	.word      2097152
.set pop


	.text
