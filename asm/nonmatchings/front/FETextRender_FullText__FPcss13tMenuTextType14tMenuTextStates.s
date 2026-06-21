.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates, 0x84

glabel FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
    /* 116C0 80020EC0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 116C4 80020EC4 0580093C */  lui        $t1, %hi(kRGBVals)
    /* 116C8 80020EC8 0580083C */  lui        $t0, %hi(textDefinitions)
    /* 116CC 80020ECC B8150825 */  addiu      $t0, $t0, %lo(textDefinitions)
    /* 116D0 80020ED0 40180700 */  sll        $v1, $a3, 1
    /* 116D4 80020ED4 21186700 */  addu       $v1, $v1, $a3
    /* 116D8 80020ED8 40180300 */  sll        $v1, $v1, 1
    /* 116DC 80020EDC 03006724 */  addiu      $a3, $v1, 0x3
    /* 116E0 80020EE0 C8162925 */  addiu      $t1, $t1, %lo(kRGBVals)
    /* 116E4 80020EE4 21186800 */  addu       $v1, $v1, $t0
    /* 116E8 80020EE8 002C0500 */  sll        $a1, $a1, 16
    /* 116EC 80020EEC 00340600 */  sll        $a2, $a2, 16
    /* 116F0 80020EF0 032C0500 */  sra        $a1, $a1, 16
    /* 116F4 80020EF4 3000A28F */  lw         $v0, 0x30($sp)
    /* 116F8 80020EF8 03340600 */  sra        $a2, $a2, 16
    /* 116FC 80020EFC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 11700 80020F00 00006390 */  lbu        $v1, 0x0($v1)
    /* 11704 80020F04 21104700 */  addu       $v0, $v0, $a3
    /* 11708 80020F08 21104800 */  addu       $v0, $v0, $t0
    /* 1170C 80020F0C 00004790 */  lbu        $a3, 0x0($v0)
    /* 11710 80020F10 3400A28F */  lw         $v0, 0x34($sp)
    /* 11714 80020F14 80380700 */  sll        $a3, $a3, 2
    /* 11718 80020F18 2138E900 */  addu       $a3, $a3, $t1
    /* 1171C 80020F1C 00140200 */  sll        $v0, $v0, 16
    /* 11720 80020F20 0000E78C */  lw         $a3, 0x0($a3)
    /* 11724 80020F24 03140200 */  sra        $v0, $v0, 16
    /* 11728 80020F28 1000A3AF */  sw         $v1, 0x10($sp)
    /* 1172C 80020F2C 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 11730 80020F30 1400A2AF */   sw        $v0, 0x14($sp)
    /* 11734 80020F34 1800BF8F */  lw         $ra, 0x18($sp)
    /* 11738 80020F38 00000000 */  nop
    /* 1173C 80020F3C 0800E003 */  jr         $ra
    /* 11740 80020F40 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
