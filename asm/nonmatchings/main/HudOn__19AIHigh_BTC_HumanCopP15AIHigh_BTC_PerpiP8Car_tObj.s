.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj, 0x6C

glabel HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj
    /* 4EA84 8005E284 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4EA88 8005E288 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4EA8C 8005E28C 6002E28C */  lw         $v0, 0x260($a3)
    /* 4EA90 8005E290 00000000 */  nop
    /* 4EA94 8005E294 02004230 */  andi       $v0, $v0, 0x2
    /* 4EA98 8005E298 02004010 */  beqz       $v0, .L8005E2A4
    /* 4EA9C 8005E29C 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* 4EAA0 8005E2A0 48FA478C */  lw         $a3, %lo(Cars_gHumanRaceCarList)($v0)
  .L8005E2A4:
    /* 4EAA4 8005E2A4 1C00828C */  lw         $v0, 0x1C($a0)
    /* 4EAA8 8005E2A8 00000000 */  nop
    /* 4EAAC 8005E2AC 03004010 */  beqz       $v0, .L8005E2BC
    /* 4EAB0 8005E2B0 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 4EAB4 8005E2B4 0A00C010 */  beqz       $a2, .L8005E2E0
    /* 4EAB8 8005E2B8 00000000 */   nop
  .L8005E2BC:
    /* 4EABC 8005E2BC 0100C62C */  sltiu      $a2, $a2, 0x1
    /* 4EAC0 8005E2C0 0000A38C */  lw         $v1, 0x0($a1)
    /* 4EAC4 8005E2C4 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 4EAC8 8005E2C8 7400848C */  lw         $a0, 0x74($a0)
    /* 4EACC 8005E2CC 5402E784 */  lh         $a3, 0x254($a3)
    /* 4EAD0 8005E2D0 8802658C */  lw         $a1, 0x288($v1)
    /* 4EAD4 8005E2D4 23204400 */  subu       $a0, $v0, $a0
    /* 4EAD8 8005E2D8 8B65030C */  jal        Hud_BustedOverlayOn__FiPcbs
    /* 4EADC 8005E2DC 5C00A524 */   addiu     $a1, $a1, 0x5C
  .L8005E2E0:
    /* 4EAE0 8005E2E0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4EAE4 8005E2E4 00000000 */  nop
    /* 4EAE8 8005E2E8 0800E003 */  jr         $ra
    /* 4EAEC 8005E2EC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj
