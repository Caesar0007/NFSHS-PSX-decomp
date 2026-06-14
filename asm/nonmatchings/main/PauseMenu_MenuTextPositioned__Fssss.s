.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PauseMenu_MenuTextPositioned__Fssss, 0x78

glabel PauseMenu_MenuTextPositioned__Fssss
    /* 97714 800A6F14 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 97718 800A6F18 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9771C 800A6F1C 2188A000 */  addu       $s1, $a1, $zero
    /* 97720 800A6F20 1800B2AF */  sw         $s2, 0x18($sp)
    /* 97724 800A6F24 2190E000 */  addu       $s2, $a3, $zero
    /* 97728 800A6F28 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9772C 800A6F2C 00840400 */  sll        $s0, $a0, 16
    /* 97730 800A6F30 03841000 */  sra        $s0, $s0, 16
    /* 97734 800A6F34 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 97738 800A6F38 9CE4020C */  jal        TextSys_WordFlags__Fi
    /* 9773C 800A6F3C 21200002 */   addu      $a0, $s0, $zero
    /* 97740 800A6F40 21200002 */  addu       $a0, $s0, $zero
    /* 97744 800A6F44 94E4020C */  jal        TextSys_Word__Fi
    /* 97748 800A6F48 21804000 */   addu      $s0, $v0, $zero
    /* 9774C 800A6F4C 008C1100 */  sll        $s1, $s1, 16
    /* 97750 800A6F50 02002012 */  beqz       $s1, .L800A6F5C
    /* 97754 800A6F54 04000724 */   addiu     $a3, $zero, 0x4
    /* 97758 800A6F58 03000724 */  addiu      $a3, $zero, 0x3
  .L800A6F5C:
    /* 9775C 800A6F5C 21204000 */  addu       $a0, $v0, $zero
    /* 97760 800A6F60 002C1200 */  sll        $a1, $s2, 16
    /* 97764 800A6F64 00341000 */  sll        $a2, $s0, 16
    /* 97768 800A6F68 032C0500 */  sra        $a1, $a1, 16
    /* 9776C 800A6F6C 989B020C */  jal        PauseMenu_FullText__FPcsss
    /* 97770 800A6F70 03340600 */   sra       $a2, $a2, 16
    /* 97774 800A6F74 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 97778 800A6F78 1800B28F */  lw         $s2, 0x18($sp)
    /* 9777C 800A6F7C 1400B18F */  lw         $s1, 0x14($sp)
    /* 97780 800A6F80 1000B08F */  lw         $s0, 0x10($sp)
    /* 97784 800A6F84 0800E003 */  jr         $ra
    /* 97788 800A6F88 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PauseMenu_MenuTextPositioned__Fssss
