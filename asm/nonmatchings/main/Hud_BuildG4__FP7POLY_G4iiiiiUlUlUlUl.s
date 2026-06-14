.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl, 0xBC

glabel Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl
    /* C2ED8 800D26D8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* C2EDC 800D26DC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C2EE0 800D26E0 4000B38F */  lw         $s3, 0x40($sp)
    /* C2EE4 800D26E4 1400B1AF */  sw         $s1, 0x14($sp)
    /* C2EE8 800D26E8 21888000 */  addu       $s1, $a0, $zero
    /* C2EEC 800D26EC 2000B4AF */  sw         $s4, 0x20($sp)
    /* C2EF0 800D26F0 21A0A000 */  addu       $s4, $a1, $zero
    /* C2EF4 800D26F4 1800B2AF */  sw         $s2, 0x18($sp)
    /* C2EF8 800D26F8 2190C000 */  addu       $s2, $a2, $zero
    /* C2EFC 800D26FC 1000B0AF */  sw         $s0, 0x10($sp)
    /* C2F00 800D2700 2180E000 */  addu       $s0, $a3, $zero
    /* C2F04 800D2704 2400B5AF */  sw         $s5, 0x24($sp)
    /* C2F08 800D2708 4400B58F */  lw         $s5, 0x44($sp)
    /* C2F0C 800D270C 4800A28F */  lw         $v0, 0x48($sp)
    /* C2F10 800D2710 4C00A38F */  lw         $v1, 0x4C($sp)
    /* C2F14 800D2714 5000A58F */  lw         $a1, 0x50($sp)
    /* C2F18 800D2718 5400A68F */  lw         $a2, 0x54($sp)
    /* C2F1C 800D271C 2800BFAF */  sw         $ra, 0x28($sp)
    /* C2F20 800D2720 040022AE */  sw         $v0, 0x4($s1)
    /* C2F24 800D2724 0C0023AE */  sw         $v1, 0xC($s1)
    /* C2F28 800D2728 140025AE */  sw         $a1, 0x14($s1)
    /* C2F2C 800D272C 8CCD030C */  jal        SetPolyG4
    /* C2F30 800D2730 1C0026AE */   sw        $a2, 0x1C($s1)
    /* C2F34 800D2734 21202002 */  addu       $a0, $s1, $zero
    /* C2F38 800D2738 3FCC030C */  jal        SetSemiTrans
    /* C2F3C 800D273C 21288002 */   addu      $a1, $s4, $zero
    /* C2F40 800D2740 00141000 */  sll        $v0, $s0, 16
    /* C2F44 800D2744 25185200 */  or         $v1, $v0, $s2
    /* C2F48 800D2748 21985302 */  addu       $s3, $s2, $s3
    /* C2F4C 800D274C 25105300 */  or         $v0, $v0, $s3
    /* C2F50 800D2750 21801502 */  addu       $s0, $s0, $s5
    /* C2F54 800D2754 00841000 */  sll        $s0, $s0, 16
    /* C2F58 800D2758 25901202 */  or         $s2, $s0, $s2
    /* C2F5C 800D275C 25801302 */  or         $s0, $s0, $s3
    /* C2F60 800D2760 080023AE */  sw         $v1, 0x8($s1)
    /* C2F64 800D2764 100022AE */  sw         $v0, 0x10($s1)
    /* C2F68 800D2768 180032AE */  sw         $s2, 0x18($s1)
    /* C2F6C 800D276C 200030AE */  sw         $s0, 0x20($s1)
    /* C2F70 800D2770 2800BF8F */  lw         $ra, 0x28($sp)
    /* C2F74 800D2774 2400B58F */  lw         $s5, 0x24($sp)
    /* C2F78 800D2778 2000B48F */  lw         $s4, 0x20($sp)
    /* C2F7C 800D277C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C2F80 800D2780 1800B28F */  lw         $s2, 0x18($sp)
    /* C2F84 800D2784 1400B18F */  lw         $s1, 0x14($sp)
    /* C2F88 800D2788 1000B08F */  lw         $s0, 0x10($sp)
    /* C2F8C 800D278C 0800E003 */  jr         $ra
    /* C2F90 800D2790 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl
