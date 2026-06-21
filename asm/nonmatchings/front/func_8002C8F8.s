.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8002C8F8, 0x68

glabel func_8002C8F8
    /* 1D0F8 8002C8F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1D0FC 8002C8FC 21308000 */  addu       $a2, $a0, $zero
    /* 1D100 8002C900 03000524 */  addiu      $a1, $zero, 0x3
    /* 1D104 8002C904 0580023C */  lui        $v0, %hi(screenCarSelect)
    /* 1D108 8002C908 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1D10C 8002C90C 0580103C */  lui        $s0, %hi(menuDefs)
    /* 1D110 8002C910 3C20448C */  lw         $a0, %lo(screenCarSelect)($v0)
    /* 1D114 8002C914 581A028E */  lw         $v0, %lo(menuDefs)($s0)
    /* 1D118 8002C918 01000324 */  addiu      $v1, $zero, 0x1
    /* 1D11C 8002C91C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1D120 8002C920 0000C3AC */  sw         $v1, 0x0($a2)
    /* 1D124 8002C924 341E4224 */  addiu      $v0, $v0, 0x1E34
    /* 1D128 8002C928 67ED000C */  jal        SetState__16tScreenCarSelecti
    /* 1D12C 8002C92C 0400C2AC */   sw        $v0, 0x4($a2)
    /* 1D130 8002C930 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1D134 8002C934 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1D138 8002C938 2D60000C */  jal        Decrement__16tListIteratorCar7tPlayer
    /* 1D13C 8002C93C C41D8424 */   addiu     $a0, $a0, 0x1DC4
    /* 1D140 8002C940 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1D144 8002C944 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1D148 8002C948 2560000C */  jal        Increment__16tListIteratorCar7tPlayer
    /* 1D14C 8002C94C C41D8424 */   addiu     $a0, $a0, 0x1DC4
    /* 1D150 8002C950 1400BF8F */  lw         $ra, 0x14($sp)
    /* 1D154 8002C954 1000B08F */  lw         $s0, 0x10($sp)
    /* 1D158 8002C958 0800E003 */  jr         $ra
    /* 1D15C 8002C95C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_8002C8F8
