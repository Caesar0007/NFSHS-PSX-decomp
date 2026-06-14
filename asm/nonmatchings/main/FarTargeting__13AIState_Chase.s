.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FarTargeting__13AIState_Chase, 0xAC

glabel FarTargeting__13AIState_Chase
    /* 60AD0 800702D0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 60AD4 800702D4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 60AD8 800702D8 21808000 */  addu       $s0, $a0, $zero
    /* 60ADC 800702DC 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 60AE0 800702E0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 60AE4 800702E4 780000AE */  sw         $zero, 0x78($s0)
    /* 60AE8 800702E8 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* 60AEC 800702EC 4400028E */  lw         $v0, 0x44($s0)
    /* 60AF0 800702F0 00000000 */  nop
    /* 60AF4 800702F4 2A104300 */  slt        $v0, $v0, $v1
    /* 60AF8 800702F8 0B004010 */  beqz       $v0, .L80070328
    /* 60AFC 800702FC 00000000 */   nop
    /* 60B00 80070300 6800028E */  lw         $v0, 0x68($s0)
    /* 60B04 80070304 00000000 */  nop
    /* 60B08 80070308 04004018 */  blez       $v0, .L8007031C
    /* 60B0C 8007030C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 60B10 80070310 0000038E */  lw         $v1, 0x0($s0)
    /* 60B14 80070314 CAC00108 */  j          .L80070328
    /* 60B18 80070318 500562AC */   sw        $v0, 0x550($v1)
  .L8007031C:
    /* 60B1C 8007031C 0000038E */  lw         $v1, 0x0($s0)
    /* 60B20 80070320 01000224 */  addiu      $v0, $zero, 0x1
    /* 60B24 80070324 500562AC */  sw         $v0, 0x550($v1)
  .L80070328:
    /* 60B28 80070328 21200002 */  addu       $a0, $s0, $zero
    /* 60B2C 8007032C 04C0010C */  jal        DoNitrous__13AIState_Chasei
    /* 60B30 80070330 01000524 */   addiu     $a1, $zero, 0x1
    /* 60B34 80070334 0000048E */  lw         $a0, 0x0($s0)
    /* 60B38 80070338 77BB010C */  jal        AISpeeds_CalcDesiredSpeed__FP8Car_tObj
    /* 60B3C 8007033C 00000000 */   nop
    /* 60B40 80070340 0000048E */  lw         $a0, 0x0($s0)
    /* 60B44 80070344 9B5E010C */  jal        AI_GenericBeginCycle__FP8Car_tObj
    /* 60B48 80070348 00000000 */   nop
    /* 60B4C 8007034C F1C2010C */  jal        CheckForBarriersAndTargetAroundThem__13AIState_Chase
    /* 60B50 80070350 21200002 */   addu      $a0, $s0, $zero
    /* 60B54 80070354 0000048E */  lw         $a0, 0x0($s0)
    /* 60B58 80070358 A55E010C */  jal        AI_GenericCycle__FP8Car_tObj
    /* 60B5C 8007035C 00000000 */   nop
    /* 60B60 80070360 0000048E */  lw         $a0, 0x0($s0)
    /* 60B64 80070364 BA5E010C */  jal        AI_GenericEndCycle__FP8Car_tObj
    /* 60B68 80070368 00000000 */   nop
    /* 60B6C 8007036C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 60B70 80070370 1000B08F */  lw         $s0, 0x10($sp)
    /* 60B74 80070374 0800E003 */  jr         $ra
    /* 60B78 80070378 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FarTargeting__13AIState_Chase
