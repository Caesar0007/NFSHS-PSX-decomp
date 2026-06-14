.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__25tPMenuItemLeftRightChoiceb, 0x1D8

glabel Draw__25tPMenuItemLeftRightChoiceb
    /* 97E50 800A7650 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 97E54 800A7654 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 97E58 800A7658 21888000 */  addu       $s1, $a0, $zero
    /* 97E5C 800A765C 3800BFAF */  sw         $ra, 0x38($sp)
    /* 97E60 800A7660 3400B7AF */  sw         $s7, 0x34($sp)
    /* 97E64 800A7664 3000B6AF */  sw         $s6, 0x30($sp)
    /* 97E68 800A7668 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 97E6C 800A766C 2800B4AF */  sw         $s4, 0x28($sp)
    /* 97E70 800A7670 2400B3AF */  sw         $s3, 0x24($sp)
    /* 97E74 800A7674 2000B2AF */  sw         $s2, 0x20($sp)
    /* 97E78 800A7678 1800B0AF */  sw         $s0, 0x18($sp)
    /* 97E7C 800A767C 0400248E */  lw         $a0, 0x4($s1)
    /* 97E80 800A7680 A4E4020C */  jal        TextSys_WordX__Fi
    /* 97E84 800A7684 2190A000 */   addu      $s2, $a1, $zero
    /* 97E88 800A7688 00841200 */  sll        $s0, $s2, 16
    /* 97E8C 800A768C 03841000 */  sra        $s0, $s0, 16
    /* 97E90 800A7690 21280002 */  addu       $a1, $s0, $zero
    /* 97E94 800A7694 00140200 */  sll        $v0, $v0, 16
    /* 97E98 800A7698 033C0200 */  sra        $a3, $v0, 16
    /* 97E9C 800A769C 0000268E */  lw         $a2, 0x0($s1)
    /* 97EA0 800A76A0 04002486 */  lh         $a0, 0x4($s1)
    /* 97EA4 800A76A4 C59B020C */  jal        PauseMenu_MenuTextPositioned__Fssss
    /* 97EA8 800A76A8 0100C630 */   andi      $a2, $a2, 0x1
    /* 97EAC 800A76AC 0C00238E */  lw         $v1, 0xC($s1)
    /* 97EB0 800A76B0 00000000 */  nop
    /* 97EB4 800A76B4 0800628C */  lw         $v0, 0x8($v1)
    /* 97EB8 800A76B8 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 97EBC 800A76BC 18004484 */  lh         $a0, 0x18($v0)
    /* 97EC0 800A76C0 1C00428C */  lw         $v0, 0x1C($v0)
    /* 97EC4 800A76C4 00000000 */  nop
    /* 97EC8 800A76C8 09F84000 */  jalr       $v0
    /* 97ECC 800A76CC 21206400 */   addu      $a0, $v1, $a0
    /* 97ED0 800A76D0 00140200 */  sll        $v0, $v0, 16
    /* 97ED4 800A76D4 039C0200 */  sra        $s3, $v0, 16
    /* 97ED8 800A76D8 A4E4020C */  jal        TextSys_WordX__Fi
    /* 97EDC 800A76DC 21206002 */   addu      $a0, $s3, $zero
    /* 97EE0 800A76E0 21206002 */  addu       $a0, $s3, $zero
    /* 97EE4 800A76E4 21280002 */  addu       $a1, $s0, $zero
    /* 97EE8 800A76E8 00140200 */  sll        $v0, $v0, 16
    /* 97EEC 800A76EC 03BC0200 */  sra        $s7, $v0, 16
    /* 97EF0 800A76F0 0000268E */  lw         $a2, 0x0($s1)
    /* 97EF4 800A76F4 2138E002 */  addu       $a3, $s7, $zero
    /* 97EF8 800A76F8 C59B020C */  jal        PauseMenu_MenuTextPositioned__Fssss
    /* 97EFC 800A76FC 0100C630 */   andi      $a2, $a2, 0x1
    /* 97F00 800A7700 7818918F */  lw         $s1, %gp_rel(D_8013DDC4)($gp)
    /* 97F04 800A7704 3D004012 */  beqz       $s2, .L800A77FC
    /* 97F08 800A7708 1180023C */   lui       $v0, %hi(D_801132CC)
    /* 97F0C 800A770C CC32428C */  lw         $v0, %lo(D_801132CC)($v0)
    /* 97F10 800A7710 00000000 */  nop
    /* 97F14 800A7714 39004014 */  bnez       $v0, .L800A77FC
    /* 97F18 800A7718 801F143C */   lui       $s4, (0x1F800004 >> 16)
    /* 97F1C 800A771C 04009436 */  ori        $s4, $s4, (0x1F800004 & 0xFFFF)
    /* 97F20 800A7720 FF00123C */  lui        $s2, (0xFFFFFF >> 16)
    /* 97F24 800A7724 FFFF5236 */  ori        $s2, $s2, (0xFFFFFF & 0xFFFF)
    /* 97F28 800A7728 21206002 */  addu       $a0, $s3, $zero
    /* 97F2C 800A772C 801F163C */  lui        $s6, (0x1F800000 >> 16)
    /* 97F30 800A7730 00FF133C */  lui        $s3, (0xFF000000 >> 16)
    /* 97F34 800A7734 0000908E */  lw         $s0, 0x0($s4)
    /* 97F38 800A7738 0000C58E */  lw         $a1, (0x1F800000 & 0xFFFF)($s6)
    /* 97F3C 800A773C 0000038E */  lw         $v1, 0x0($s0)
    /* 97F40 800A7740 0000A28C */  lw         $v0, 0x0($a1)
    /* 97F44 800A7744 24187300 */  and        $v1, $v1, $s3
    /* 97F48 800A7748 24105200 */  and        $v0, $v0, $s2
    /* 97F4C 800A774C 25186200 */  or         $v1, $v1, $v0
    /* 97F50 800A7750 000003AE */  sw         $v1, 0x0($s0)
    /* 97F54 800A7754 0000A28C */  lw         $v0, 0x0($a1)
    /* 97F58 800A7758 34000326 */  addiu      $v1, $s0, 0x34
    /* 97F5C 800A775C 000083AE */  sw         $v1, 0x0($s4)
    /* 97F60 800A7760 24181202 */  and        $v1, $s0, $s2
    /* 97F64 800A7764 24105300 */  and        $v0, $v0, $s3
    /* 97F68 800A7768 25104300 */  or         $v0, $v0, $v1
    /* 97F6C 800A776C 94E4020C */  jal        TextSys_Word__Fi
    /* 97F70 800A7770 0000A2AC */   sw        $v0, 0x0($a1)
    /* 97F74 800A7774 888F030C */  jal        textpixels
    /* 97F78 800A7778 21204000 */   addu      $a0, $v0, $zero
    /* 97F7C 800A777C 21200002 */  addu       $a0, $s0, $zero
    /* 97F80 800A7780 1180103C */  lui        $s0, %hi(D_80110E00)
    /* 97F84 800A7784 000E1026 */  addiu      $s0, $s0, %lo(D_80110E00)
    /* 97F88 800A7788 21280002 */  addu       $a1, $s0, $zero
    /* 97F8C 800A778C 2310E202 */  subu       $v0, $s7, $v0
    /* 97F90 800A7790 F8FF4624 */  addiu      $a2, $v0, -0x8
    /* 97F94 800A7794 05003126 */  addiu      $s1, $s1, 0x5
    /* 97F98 800A7798 21382002 */  addu       $a3, $s1, $zero
    /* 97F9C 800A779C BEBE1534 */  ori        $s5, $zero, 0xBEBE
    /* 97FA0 800A77A0 A248030C */  jal        Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
    /* 97FA4 800A77A4 1000B5AF */   sw        $s5, 0x10($sp)
    /* 97FA8 800A77A8 14000526 */  addiu      $a1, $s0, 0x14
    /* 97FAC 800A77AC 0400E626 */  addiu      $a2, $s7, 0x4
    /* 97FB0 800A77B0 21382002 */  addu       $a3, $s1, $zero
    /* 97FB4 800A77B4 0000908E */  lw         $s0, 0x0($s4)
    /* 97FB8 800A77B8 0000C88E */  lw         $t0, (0x1F800000 & 0xFFFF)($s6)
    /* 97FBC 800A77BC 21200002 */  addu       $a0, $s0, $zero
    /* 97FC0 800A77C0 0000838C */  lw         $v1, 0x0($a0)
    /* 97FC4 800A77C4 0000028D */  lw         $v0, 0x0($t0)
    /* 97FC8 800A77C8 24187300 */  and        $v1, $v1, $s3
    /* 97FCC 800A77CC 24105200 */  and        $v0, $v0, $s2
    /* 97FD0 800A77D0 25186200 */  or         $v1, $v1, $v0
    /* 97FD4 800A77D4 000083AC */  sw         $v1, 0x0($a0)
    /* 97FD8 800A77D8 0000028D */  lw         $v0, 0x0($t0)
    /* 97FDC 800A77DC 34008324 */  addiu      $v1, $a0, 0x34
    /* 97FE0 800A77E0 000083AE */  sw         $v1, 0x0($s4)
    /* 97FE4 800A77E4 24189200 */  and        $v1, $a0, $s2
    /* 97FE8 800A77E8 24105300 */  and        $v0, $v0, $s3
    /* 97FEC 800A77EC 25104300 */  or         $v0, $v0, $v1
    /* 97FF0 800A77F0 000002AD */  sw         $v0, 0x0($t0)
    /* 97FF4 800A77F4 A248030C */  jal        Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
    /* 97FF8 800A77F8 1000B5AF */   sw        $s5, 0x10($sp)
  .L800A77FC:
    /* 97FFC 800A77FC 3800BF8F */  lw         $ra, 0x38($sp)
    /* 98000 800A7800 3400B78F */  lw         $s7, 0x34($sp)
    /* 98004 800A7804 3000B68F */  lw         $s6, 0x30($sp)
    /* 98008 800A7808 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 9800C 800A780C 2800B48F */  lw         $s4, 0x28($sp)
    /* 98010 800A7810 2400B38F */  lw         $s3, 0x24($sp)
    /* 98014 800A7814 2000B28F */  lw         $s2, 0x20($sp)
    /* 98018 800A7818 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 9801C 800A781C 1800B08F */  lw         $s0, 0x18($sp)
    /* 98020 800A7820 0800E003 */  jr         $ra
    /* 98024 800A7824 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Draw__25tPMenuItemLeftRightChoiceb
