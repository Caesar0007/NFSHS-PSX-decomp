.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___25tScreenCarSelectTwoPlayer, 0x44

glabel ___25tScreenCarSelectTwoPlayer
    /* 2FF14 8003F714 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2FF18 8003F718 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2FF1C 8003F71C 21808000 */  addu       $s0, $a0, $zero
    /* 2FF20 8003F720 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2FF24 8003F724 2188A000 */  addu       $s1, $a1, $zero
    /* 2FF28 8003F728 A0030426 */  addiu      $a0, $s0, 0x3A0
    /* 2FF2C 8003F72C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 2FF30 8003F730 1E98000C */  jal        ___7tScreen
    /* 2FF34 8003F734 02000524 */   addiu     $a1, $zero, 0x2
    /* 2FF38 8003F738 21200002 */  addu       $a0, $s0, $zero
    /* 2FF3C 8003F73C 24EB000C */  jal        ___16tScreenCarSelect
    /* 2FF40 8003F740 21282002 */   addu      $a1, $s1, $zero
    /* 2FF44 8003F744 1800BF8F */  lw         $ra, 0x18($sp)
    /* 2FF48 8003F748 1400B18F */  lw         $s1, 0x14($sp)
    /* 2FF4C 8003F74C 1000B08F */  lw         $s0, 0x10($sp)
    /* 2FF50 8003F750 0800E003 */  jr         $ra
    /* 2FF54 8003F754 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ___25tScreenCarSelectTwoPlayer
