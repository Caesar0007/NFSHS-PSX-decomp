.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcTextFadeSelToHi__F13tMenuTextTypess, 0x84

glabel CalcTextFadeSelToHi__F13tMenuTextTypess
    /* 3C150 8004B950 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3C154 8004B954 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3C158 8004B958 2180C000 */  addu       $s0, $a2, $zero
    /* 3C15C 8004B95C 0580073C */  lui        $a3, %hi(kRGBVals)
    /* 3C160 8004B960 0580063C */  lui        $a2, %hi(textDefinitions)
    /* 3C164 8004B964 B815C624 */  addiu      $a2, $a2, %lo(textDefinitions)
    /* 3C168 8004B968 40100400 */  sll        $v0, $a0, 1
    /* 3C16C 8004B96C 21104400 */  addu       $v0, $v0, $a0
    /* 3C170 8004B970 40100200 */  sll        $v0, $v0, 1
    /* 3C174 8004B974 21184600 */  addu       $v1, $v0, $a2
    /* 3C178 8004B978 C816E724 */  addiu      $a3, $a3, %lo(kRGBVals)
    /* 3C17C 8004B97C 21104600 */  addu       $v0, $v0, $a2
    /* 3C180 8004B980 00340500 */  sll        $a2, $a1, 16
    /* 3C184 8004B984 1400BFAF */  sw         $ra, 0x14($sp)
    /* 3C188 8004B988 04006390 */  lbu        $v1, 0x4($v1)
    /* 3C18C 8004B98C 05004290 */  lbu        $v0, 0x5($v0)
    /* 3C190 8004B990 80180300 */  sll        $v1, $v1, 2
    /* 3C194 8004B994 21186700 */  addu       $v1, $v1, $a3
    /* 3C198 8004B998 80100200 */  sll        $v0, $v0, 2
    /* 3C19C 8004B99C 21104700 */  addu       $v0, $v0, $a3
    /* 3C1A0 8004B9A0 0000648C */  lw         $a0, 0x0($v1)
    /* 3C1A4 8004B9A4 0000458C */  lw         $a1, 0x0($v0)
    /* 3C1A8 8004B9A8 FE2D010C */  jal        CalcFadeVal__Fiii
    /* 3C1AC 8004B9AC 03340600 */   sra       $a2, $a2, 16
    /* 3C1B0 8004B9B0 21204000 */  addu       $a0, $v0, $zero
    /* 3C1B4 8004B9B4 21280000 */  addu       $a1, $zero, $zero
    /* 3C1B8 8004B9B8 00841000 */  sll        $s0, $s0, 16
    /* 3C1BC 8004B9BC FE2D010C */  jal        CalcFadeVal__Fiii
    /* 3C1C0 8004B9C0 03341000 */   sra       $a2, $s0, 16
    /* 3C1C4 8004B9C4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3C1C8 8004B9C8 1000B08F */  lw         $s0, 0x10($sp)
    /* 3C1CC 8004B9CC 0800E003 */  jr         $ra
    /* 3C1D0 8004B9D0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CalcTextFadeSelToHi__F13tMenuTextTypess
