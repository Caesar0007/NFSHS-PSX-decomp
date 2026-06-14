.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForNewTarget__14AIHigh_BTC_Cop, 0x158

glabel CheckForNewTarget__14AIHigh_BTC_Cop
    /* 4D4B8 8005CCB8 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 4D4BC 8005CCBC 2400B5AF */  sw         $s5, 0x24($sp)
    /* 4D4C0 8005CCC0 21A88000 */  addu       $s5, $a0, $zero
    /* 4D4C4 8005CCC4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 4D4C8 8005CCC8 21980000 */  addu       $s3, $zero, $zero
    /* 4D4CC 8005CCCC 2000B4AF */  sw         $s4, 0x20($sp)
    /* 4D4D0 8005CCD0 1027143C */  lui        $s4, (0x27100000 >> 16)
    /* 4D4D4 8005CCD4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4D4D8 8005CCD8 21906002 */  addu       $s2, $s3, $zero
    /* 4D4DC 8005CCDC 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 4D4E0 8005CCE0 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 4D4E4 8005CCE4 38CD5724 */  addiu      $s7, $v0, %lo(highLevelAIObjs)
    /* 4D4E8 8005CCE8 1180023C */  lui        $v0, %hi(Cars_gRaceCarList)
    /* 4D4EC 8005CCEC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4D4F0 8005CCF0 00FA5124 */  addiu      $s1, $v0, %lo(Cars_gRaceCarList)
    /* 4D4F4 8005CCF4 3000BFAF */  sw         $ra, 0x30($sp)
    /* 4D4F8 8005CCF8 2800B6AF */  sw         $s6, 0x28($sp)
    /* 4D4FC 8005CCFC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4D500 8005CD00 5800B68E */  lw         $s6, 0x58($s5)
  .L8005CD04:
    /* 4D504 8005CD04 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* 4D508 8005CD08 F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* 4D50C 8005CD0C 00000000 */  nop
    /* 4D510 8005CD10 2A104202 */  slt        $v0, $s2, $v0
    /* 4D514 8005CD14 24004010 */  beqz       $v0, .L8005CDA8
    /* 4D518 8005CD18 00000000 */   nop
    /* 4D51C 8005CD1C 0000258E */  lw         $a1, 0x0($s1)
    /* 4D520 8005CD20 00000000 */  nop
    /* 4D524 8005CD24 9100A290 */  lbu        $v0, 0x91($a1)
    /* 4D528 8005CD28 00000000 */  nop
    /* 4D52C 8005CD2C 1B004010 */  beqz       $v0, .L8005CD9C
    /* 4D530 8005CD30 00000000 */   nop
    /* 4D534 8005CD34 6002A28C */  lw         $v0, 0x260($a1)
    /* 4D538 8005CD38 00000000 */  nop
    /* 4D53C 8005CD3C 00024230 */  andi       $v0, $v0, 0x200
    /* 4D540 8005CD40 16004014 */  bnez       $v0, .L8005CD9C
    /* 4D544 8005CD44 00000000 */   nop
    /* 4D548 8005CD48 5402A28C */  lw         $v0, 0x254($a1)
    /* 4D54C 8005CD4C 00000000 */  nop
    /* 4D550 8005CD50 80100200 */  sll        $v0, $v0, 2
    /* 4D554 8005CD54 21105700 */  addu       $v0, $v0, $s7
    /* 4D558 8005CD58 0000508C */  lw         $s0, 0x0($v0)
    /* 4D55C 8005CD5C 00000000 */  nop
    /* 4D560 8005CD60 7800028E */  lw         $v0, 0x78($s0)
    /* 4D564 8005CD64 00000000 */  nop
    /* 4D568 8005CD68 0C004010 */  beqz       $v0, .L8005CD9C
    /* 4D56C 8005CD6C 00000000 */   nop
    /* 4D570 8005CD70 0000A48E */  lw         $a0, 0x0($s5)
    /* 4D574 8005CD74 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 4D578 8005CD78 00000000 */   nop
    /* 4D57C 8005CD7C 02004104 */  bgez       $v0, .L8005CD88
    /* 4D580 8005CD80 21184000 */   addu      $v1, $v0, $zero
    /* 4D584 8005CD84 23180300 */  negu       $v1, $v1
  .L8005CD88:
    /* 4D588 8005CD88 2A107400 */  slt        $v0, $v1, $s4
    /* 4D58C 8005CD8C 03004010 */  beqz       $v0, .L8005CD9C
    /* 4D590 8005CD90 00000000 */   nop
    /* 4D594 8005CD94 21A06000 */  addu       $s4, $v1, $zero
    /* 4D598 8005CD98 21980002 */  addu       $s3, $s0, $zero
  .L8005CD9C:
    /* 4D59C 8005CD9C 04003126 */  addiu      $s1, $s1, 0x4
    /* 4D5A0 8005CDA0 41730108 */  j          .L8005CD04
    /* 4D5A4 8005CDA4 01005226 */   addiu     $s2, $s2, 0x1
  .L8005CDA8:
    /* 4D5A8 8005CDA8 07006012 */  beqz       $s3, .L8005CDC8
    /* 4D5AC 8005CDAC 00000000 */   nop
    /* 4D5B0 8005CDB0 05007612 */  beq        $s3, $s6, .L8005CDC8
    /* 4D5B4 8005CDB4 2120A002 */   addu      $a0, $s5, $zero
    /* 4D5B8 8005CDB8 EB72010C */  jal        AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4D5BC 8005CDBC 21286002 */   addu      $a1, $s3, $zero
    /* 4D5C0 8005CDC0 79730108 */  j          .L8005CDE4
    /* 4D5C4 8005CDC4 01000224 */   addiu     $v0, $zero, 0x1
  .L8005CDC8:
    /* 4D5C8 8005CDC8 0600C012 */  beqz       $s6, .L8005CDE4
    /* 4D5CC 8005CDCC 21100000 */   addu      $v0, $zero, $zero
    /* 4D5D0 8005CDD0 04006016 */  bnez       $s3, .L8005CDE4
    /* 4D5D4 8005CDD4 2120A002 */   addu      $a0, $s5, $zero
    /* 4D5D8 8005CDD8 EB72010C */  jal        AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4D5DC 8005CDDC 21280000 */   addu      $a1, $zero, $zero
    /* 4D5E0 8005CDE0 21100000 */  addu       $v0, $zero, $zero
  .L8005CDE4:
    /* 4D5E4 8005CDE4 3000BF8F */  lw         $ra, 0x30($sp)
    /* 4D5E8 8005CDE8 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 4D5EC 8005CDEC 2800B68F */  lw         $s6, 0x28($sp)
    /* 4D5F0 8005CDF0 2400B58F */  lw         $s5, 0x24($sp)
    /* 4D5F4 8005CDF4 2000B48F */  lw         $s4, 0x20($sp)
    /* 4D5F8 8005CDF8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 4D5FC 8005CDFC 1800B28F */  lw         $s2, 0x18($sp)
    /* 4D600 8005CE00 1400B18F */  lw         $s1, 0x14($sp)
    /* 4D604 8005CE04 1000B08F */  lw         $s0, 0x10($sp)
    /* 4D608 8005CE08 0800E003 */  jr         $ra
    /* 4D60C 8005CE0C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CheckForNewTarget__14AIHigh_BTC_Cop
