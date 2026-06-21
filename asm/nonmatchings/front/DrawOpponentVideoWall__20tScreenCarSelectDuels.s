.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawOpponentVideoWall__20tScreenCarSelectDuels, 0x124

glabel DrawOpponentVideoWall__20tScreenCarSelectDuels
    /* 2DCBC 8003D4BC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 2DCC0 8003D4C0 2400B1AF */  sw         $s1, 0x24($sp)
    /* 2DCC4 8003D4C4 21888000 */  addu       $s1, $a0, $zero
    /* 2DCC8 8003D4C8 2000B0AF */  sw         $s0, 0x20($sp)
    /* 2DCCC 8003D4CC 21800000 */  addu       $s0, $zero, $zero
    /* 2DCD0 8003D4D0 002C0500 */  sll        $a1, $a1, 16
    /* 2DCD4 8003D4D4 2800B2AF */  sw         $s2, 0x28($sp)
    /* 2DCD8 8003D4D8 03940500 */  sra        $s2, $a1, 16
    /* 2DCDC 8003D4DC 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 2DCE0 8003D4E0 00241000 */  sll        $a0, $s0, 16
  .L8003D4E4:
    /* 2DCE4 8003D4E4 03240400 */  sra        $a0, $a0, 16
    /* 2DCE8 8003D4E8 21280000 */  addu       $a1, $zero, $zero
    /* 2DCEC 8003D4EC 2130A000 */  addu       $a2, $a1, $zero
    /* 2DCF0 8003D4F0 5C002286 */  lh         $v0, 0x5C($s1)
    /* 2DCF4 8003D4F4 23381200 */  negu       $a3, $s2
    /* 2DCF8 8003D4F8 1400A0AF */  sw         $zero, 0x14($sp)
    /* 2DCFC 8003D4FC 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2DD00 8003D500 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2DD04 8003D504 1000A2AF */   sw        $v0, 0x10($sp)
    /* 2DD08 8003D508 01000226 */  addiu      $v0, $s0, 0x1
    /* 2DD0C 8003D50C 21804000 */  addu       $s0, $v0, $zero
    /* 2DD10 8003D510 00140200 */  sll        $v0, $v0, 16
    /* 2DD14 8003D514 03140200 */  sra        $v0, $v0, 16
    /* 2DD18 8003D518 0C004228 */  slti       $v0, $v0, 0xC
    /* 2DD1C 8003D51C F1FF4014 */  bnez       $v0, .L8003D4E4
    /* 2DD20 8003D520 00241000 */   sll       $a0, $s0, 16
    /* 2DD24 8003D524 5C002286 */  lh         $v0, 0x5C($s1)
    /* 2DD28 8003D528 00000000 */  nop
    /* 2DD2C 8003D52C 0B004018 */  blez       $v0, .L8003D55C
    /* 2DD30 8003D530 00000000 */   nop
    /* 2DD34 8003D534 5400228E */  lw         $v0, 0x54($s1)
    /* 2DD38 8003D538 00000000 */  nop
    /* 2DD3C 8003D53C 07004010 */  beqz       $v0, .L8003D55C
    /* 2DD40 8003D540 00000000 */   nop
    /* 2DD44 8003D544 9FDB000C */  jal        TurnOffInstant__10tVideoWall
    /* 2DD48 8003D548 3C032426 */   addiu     $a0, $s1, 0x33C
    /* 2DD4C 8003D54C 21202002 */  addu       $a0, $s1, $zero
    /* 2DD50 8003D550 21280000 */  addu       $a1, $zero, $zero
    /* 2DD54 8003D554 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2DD58 8003D558 01000624 */   addiu     $a2, $zero, 0x1
  .L8003D55C:
    /* 2DD5C 8003D55C 3A002296 */  lhu        $v0, 0x3A($s1)
    /* 2DD60 8003D560 00000000 */  nop
    /* 2DD64 8003D564 01004230 */  andi       $v0, $v0, 0x1
    /* 2DD68 8003D568 0D004010 */  beqz       $v0, .L8003D5A0
    /* 2DD6C 8003D56C 3C033026 */   addiu     $s0, $s1, 0x33C
    /* 2DD70 8003D570 A403228E */  lw         $v0, 0x3A4($s1)
    /* 2DD74 8003D574 00000000 */  nop
    /* 2DD78 8003D578 09004014 */  bnez       $v0, .L8003D5A0
    /* 2DD7C 8003D57C 06000524 */   addiu     $a1, $zero, 0x6
    /* 2DD80 8003D580 21200002 */  addu       $a0, $s0, $zero
    /* 2DD84 8003D584 72DA000C */  jal        SetOffset__10tVideoWallss
    /* 2DD88 8003D588 69000624 */   addiu     $a2, $zero, 0x69
    /* 2DD8C 8003D58C 10DA000C */  jal        UpdateImages__10tVideoWall
    /* 2DD90 8003D590 21200002 */   addu      $a0, $s0, $zero
    /* 2DD94 8003D594 01000224 */  addiu      $v0, $zero, 0x1
    /* 2DD98 8003D598 A40322AE */  sw         $v0, 0x3A4($s1)
    /* 2DD9C 8003D59C 3C033026 */  addiu      $s0, $s1, 0x33C
  .L8003D5A0:
    /* 2DDA0 8003D5A0 79DA000C */  jal        UpdateTransition__10tVideoWall
    /* 2DDA4 8003D5A4 21200002 */   addu      $a0, $s0, $zero
    /* 2DDA8 8003D5A8 21200002 */  addu       $a0, $s0, $zero
    /* 2DDAC 8003D5AC 77DA000C */  jal        SetValid__10tVideoWalls
    /* 2DDB0 8003D5B0 01000524 */   addiu     $a1, $zero, 0x1
    /* 2DDB4 8003D5B4 21200002 */  addu       $a0, $s0, $zero
    /* 2DDB8 8003D5B8 75DA000C */  jal        SetAvailable__10tVideoWalls
    /* 2DDBC 8003D5BC 01000524 */   addiu     $a1, $zero, 0x1
    /* 2DDC0 8003D5C0 EDDA000C */  jal        Draw__10tVideoWall
    /* 2DDC4 8003D5C4 21200002 */   addu      $a0, $s0, $zero
    /* 2DDC8 8003D5C8 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 2DDCC 8003D5CC 2800B28F */  lw         $s2, 0x28($sp)
    /* 2DDD0 8003D5D0 2400B18F */  lw         $s1, 0x24($sp)
    /* 2DDD4 8003D5D4 2000B08F */  lw         $s0, 0x20($sp)
    /* 2DDD8 8003D5D8 0800E003 */  jr         $ra
    /* 2DDDC 8003D5DC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel DrawOpponentVideoWall__20tScreenCarSelectDuels
