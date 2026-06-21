.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates, 0xD0

glabel FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 11744 80020F44 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 11748 80020F48 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 1174C 80020F4C 21A8A000 */  addu       $s5, $a1, $zero
    /* 11750 80020F50 2400B3AF */  sw         $s3, 0x24($sp)
    /* 11754 80020F54 2198C000 */  addu       $s3, $a2, $zero
    /* 11758 80020F58 2800B4AF */  sw         $s4, 0x28($sp)
    /* 1175C 80020F5C 21288000 */  addu       $a1, $a0, $zero
    /* 11760 80020F60 0580043C */  lui        $a0, %hi(kRGBVals)
    /* 11764 80020F64 2000B2AF */  sw         $s2, 0x20($sp)
    /* 11768 80020F68 0580123C */  lui        $s2, %hi(textDefinitions)
    /* 1176C 80020F6C 4800A28F */  lw         $v0, 0x48($sp)
    /* 11770 80020F70 B8155226 */  addiu      $s2, $s2, %lo(textDefinitions)
    /* 11774 80020F74 3000BFAF */  sw         $ra, 0x30($sp)
    /* 11778 80020F78 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 1177C 80020F7C 1800B0AF */  sw         $s0, 0x18($sp)
    /* 11780 80020F80 40800200 */  sll        $s0, $v0, 1
    /* 11784 80020F84 21800202 */  addu       $s0, $s0, $v0
    /* 11788 80020F88 40801000 */  sll        $s0, $s0, 1
    /* 1178C 80020F8C 4C00A28F */  lw         $v0, 0x4C($sp)
    /* 11790 80020F90 03000326 */  addiu      $v1, $s0, 0x3
    /* 11794 80020F94 21104300 */  addu       $v0, $v0, $v1
    /* 11798 80020F98 21105200 */  addu       $v0, $v0, $s2
    /* 1179C 80020F9C 00004290 */  lbu        $v0, 0x0($v0)
    /* 117A0 80020FA0 C8168424 */  addiu      $a0, $a0, %lo(kRGBVals)
    /* 117A4 80020FA4 80100200 */  sll        $v0, $v0, 2
    /* 117A8 80020FA8 21104400 */  addu       $v0, $v0, $a0
    /* 117AC 80020FAC 0000448C */  lw         $a0, 0x0($v0)
    /* 117B0 80020FB0 5000B18F */  lw         $s1, 0x50($sp)
    /* 117B4 80020FB4 222E010C */  jal        CalcFadeVal__Fii
    /* 117B8 80020FB8 21A0E000 */   addu      $s4, $a3, $zero
    /* 117BC 80020FBC 2120A002 */  addu       $a0, $s5, $zero
    /* 117C0 80020FC0 009C1300 */  sll        $s3, $s3, 16
    /* 117C4 80020FC4 032C1300 */  sra        $a1, $s3, 16
    /* 117C8 80020FC8 21801202 */  addu       $s0, $s0, $s2
    /* 117CC 80020FCC 008C1100 */  sll        $s1, $s1, 16
    /* 117D0 80020FD0 038C1100 */  sra        $s1, $s1, 16
    /* 117D4 80020FD4 00A41400 */  sll        $s4, $s4, 16
    /* 117D8 80020FD8 03341400 */  sra        $a2, $s4, 16
    /* 117DC 80020FDC 00000392 */  lbu        $v1, 0x0($s0)
    /* 117E0 80020FE0 21384000 */  addu       $a3, $v0, $zero
    /* 117E4 80020FE4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 117E8 80020FE8 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 117EC 80020FEC 1000A3AF */   sw        $v1, 0x10($sp)
    /* 117F0 80020FF0 3000BF8F */  lw         $ra, 0x30($sp)
    /* 117F4 80020FF4 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 117F8 80020FF8 2800B48F */  lw         $s4, 0x28($sp)
    /* 117FC 80020FFC 2400B38F */  lw         $s3, 0x24($sp)
    /* 11800 80021000 2000B28F */  lw         $s2, 0x20($sp)
    /* 11804 80021004 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 11808 80021008 1800B08F */  lw         $s0, 0x18($sp)
    /* 1180C 8002100C 0800E003 */  jr         $ra
    /* 11810 80021010 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
