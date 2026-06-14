.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _mainasu, 0x70

glabel _mainasu
    /* F7700 80106F00 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F7704 80106F04 2000B0AF */  sw         $s0, 0x20($sp)
    /* F7708 80106F08 21808000 */  addu       $s0, $a0, $zero
    /* F770C 80106F0C 01000224 */  addiu      $v0, $zero, 0x1
    /* F7710 80106F10 3000A6AF */  sw         $a2, 0x30($sp)
    /* F7714 80106F14 27300600 */  nor        $a2, $zero, $a2
    /* F7718 80106F18 2C00A5AF */  sw         $a1, 0x2C($sp)
    /* F771C 80106F1C 27280500 */  nor        $a1, $zero, $a1
    /* F7720 80106F20 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* F7724 80106F24 1800A2AF */  sw         $v0, 0x18($sp)
    /* F7728 80106F28 3000A6AF */  sw         $a2, 0x30($sp)
    /* F772C 80106F2C 2C00A5AF */  sw         $a1, 0x2C($sp)
    /* F7730 80106F30 1000A0AF */  sw         $zero, 0x10($sp)
    /* F7734 80106F34 1800A78F */  lw         $a3, 0x18($sp)
    /* F7738 80106F38 2C00A58F */  lw         $a1, 0x2C($sp)
    /* F773C 80106F3C 3000A68F */  lw         $a2, 0x30($sp)
    /* F7740 80106F40 2400BFAF */  sw         $ra, 0x24($sp)
    /* F7744 80106F44 DC1B040C */  jal        _add_mant_d
    /* F7748 80106F48 2C00A427 */   addiu     $a0, $sp, 0x2C
    /* F774C 80106F4C 2C00A28F */  lw         $v0, 0x2C($sp)
    /* F7750 80106F50 3000A38F */  lw         $v1, 0x30($sp)
    /* F7754 80106F54 000002AE */  sw         $v0, 0x0($s0)
    /* F7758 80106F58 040003AE */  sw         $v1, 0x4($s0)
    /* F775C 80106F5C 21100002 */  addu       $v0, $s0, $zero
    /* F7760 80106F60 2400BF8F */  lw         $ra, 0x24($sp)
    /* F7764 80106F64 2000B08F */  lw         $s0, 0x20($sp)
    /* F7768 80106F68 0800E003 */  jr         $ra
    /* F776C 80106F6C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel _mainasu
