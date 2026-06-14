.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_InitAICar2__FP8Car_tObj, 0x68

glabel AIInit_InitAICar2__FP8Car_tObj
    /* 57D68 80067568 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 57D6C 8006756C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 57D70 80067570 21808000 */  addu       $s0, $a0, $zero
    /* 57D74 80067574 1400BFAF */  sw         $ra, 0x14($sp)
    /* 57D78 80067578 6002028E */  lw         $v0, 0x260($s0)
    /* 57D7C 8006757C 00000000 */  nop
    /* 57D80 80067580 08004230 */  andi       $v0, $v0, 0x8
    /* 57D84 80067584 07004010 */  beqz       $v0, .L800675A4
    /* 57D88 80067588 00000000 */   nop
    /* 57D8C 8006758C 5402048E */  lw         $a0, 0x254($s0)
    /* 57D90 80067590 A1BC010C */  jal        AISpeeds_GetUpgradeHandlingMult__Fi
    /* 57D94 80067594 00000000 */   nop
    /* 57D98 80067598 B406048E */  lw         $a0, 0x6B4($s0)
    /* 57D9C 8006759C 20B5010C */  jal        Upgrade__30AIDataRecord_CurveSpeedTable_ti
    /* 57DA0 800675A0 21284000 */   addu      $a1, $v0, $zero
  .L800675A4:
    /* 57DA4 800675A4 5402048E */  lw         $a0, 0x254($s0)
    /* 57DA8 800675A8 43BC010C */  jal        AISpeeds_GetUpgradeAccMult__Fi
    /* 57DAC 800675AC 00000000 */   nop
    /* 57DB0 800675B0 5402048E */  lw         $a0, 0x254($s0)
    /* 57DB4 800675B4 D0BC010C */  jal        AISpeeds_GetUpgradeTopSpeedMult__Fi
    /* 57DB8 800675B8 800702AE */   sw        $v0, 0x780($s0)
    /* 57DBC 800675BC 7C0702AE */  sw         $v0, 0x77C($s0)
    /* 57DC0 800675C0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 57DC4 800675C4 1000B08F */  lw         $s0, 0x10($sp)
    /* 57DC8 800675C8 0800E003 */  jr         $ra
    /* 57DCC 800675CC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIInit_InitAICar2__FP8Car_tObj
