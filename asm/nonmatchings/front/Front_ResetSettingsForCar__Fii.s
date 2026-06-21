.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_ResetSettingsForCar__Fii, 0x50

glabel Front_ResetSettingsForCar__Fii
    /* 1784C 8002704C 1180073C */  lui        $a3, %hi(frontEnd)
    /* 17850 80027050 0046E724 */  addiu      $a3, $a3, %lo(frontEnd)
    /* 17854 80027054 40300400 */  sll        $a2, $a0, 1
    /* 17858 80027058 2140C700 */  addu       $t0, $a2, $a3
    /* 1785C 8002705C 01000224 */  addiu      $v0, $zero, 0x1
    /* 17860 80027060 0410A200 */  sllv       $v0, $v0, $a1
    /* 17864 80027064 27100200 */  nor        $v0, $zero, $v0
    /* 17868 80027068 2130C400 */  addu       $a2, $a2, $a0
    /* 1786C 8002706C 00310600 */  sll        $a2, $a2, 4
    /* 17870 80027070 2128A600 */  addu       $a1, $a1, $a2
    /* 17874 80027074 30010395 */  lhu        $v1, 0x130($t0)
    /* 17878 80027078 2128A700 */  addu       $a1, $a1, $a3
    /* 1787C 8002707C 24186200 */  and        $v1, $v1, $v0
    /* 17880 80027080 32000224 */  addiu      $v0, $zero, 0x32
    /* 17884 80027084 300103A5 */  sh         $v1, 0x130($t0)
    /* 17888 80027088 5402A2A0 */  sb         $v0, 0x254($a1)
    /* 1788C 8002708C F401A2A0 */  sb         $v0, 0x1F4($a1)
    /* 17890 80027090 03000224 */  addiu      $v0, $zero, 0x3
    /* 17894 80027094 0800E003 */  jr         $ra
    /* 17898 80027098 B402A2A0 */   sb        $v0, 0x2B4($a1)
endlabel Front_ResetSettingsForCar__Fii
