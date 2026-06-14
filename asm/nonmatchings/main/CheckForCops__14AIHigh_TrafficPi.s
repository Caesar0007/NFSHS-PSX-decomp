.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForCops__14AIHigh_TrafficPi, 0xD4

glabel CheckForCops__14AIHigh_TrafficPi
    /* 5648C 80065C8C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 56490 80065C90 2400B5AF */  sw         $s5, 0x24($sp)
    /* 56494 80065C94 21A88000 */  addu       $s5, $a0, $zero
    /* 56498 80065C98 2000B4AF */  sw         $s4, 0x20($sp)
    /* 5649C 80065C9C 21A0A000 */  addu       $s4, $a1, $zero
    /* 564A0 80065CA0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 564A4 80065CA4 21980000 */  addu       $s3, $zero, $zero
    /* 564A8 80065CA8 204E023C */  lui        $v0, (0x4E200000 >> 16)
    /* 564AC 80065CAC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 564B0 80065CB0 21906002 */  addu       $s2, $s3, $zero
    /* 564B4 80065CB4 2800BFAF */  sw         $ra, 0x28($sp)
    /* 564B8 80065CB8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 564BC 80065CBC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 564C0 80065CC0 000082AE */  sw         $v0, 0x0($s4)
    /* 564C4 80065CC4 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* 564C8 80065CC8 B4FA5124 */  addiu      $s1, $v0, %lo(Cars_gCopCarList)
  .L80065CCC:
    /* 564CC 80065CCC 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* 564D0 80065CD0 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* 564D4 80065CD4 00000000 */  nop
    /* 564D8 80065CD8 2A104202 */  slt        $v0, $s2, $v0
    /* 564DC 80065CDC 17004010 */  beqz       $v0, .L80065D3C
    /* 564E0 80065CE0 21106002 */   addu      $v0, $s3, $zero
    /* 564E4 80065CE4 0000308E */  lw         $s0, 0x0($s1)
    /* 564E8 80065CE8 00000000 */  nop
    /* 564EC 80065CEC 7005028E */  lw         $v0, 0x570($s0)
    /* 564F0 80065CF0 00000000 */  nop
    /* 564F4 80065CF4 04004230 */  andi       $v0, $v0, 0x4
    /* 564F8 80065CF8 0D004014 */  bnez       $v0, .L80065D30
    /* 564FC 80065CFC 00000000 */   nop
    /* 56500 80065D00 0000A48E */  lw         $a0, 0x0($s5)
    /* 56504 80065D04 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 56508 80065D08 21280002 */   addu      $a1, $s0, $zero
    /* 5650C 80065D0C 0000838E */  lw         $v1, 0x0($s4)
    /* 56510 80065D10 02004104 */  bgez       $v0, .L80065D1C
    /* 56514 80065D14 00000000 */   nop
    /* 56518 80065D18 23100200 */  negu       $v0, $v0
  .L80065D1C:
    /* 5651C 80065D1C 2A184300 */  slt        $v1, $v0, $v1
    /* 56520 80065D20 03006010 */  beqz       $v1, .L80065D30
    /* 56524 80065D24 00000000 */   nop
    /* 56528 80065D28 21980002 */  addu       $s3, $s0, $zero
    /* 5652C 80065D2C 000082AE */  sw         $v0, 0x0($s4)
  .L80065D30:
    /* 56530 80065D30 04003126 */  addiu      $s1, $s1, 0x4
    /* 56534 80065D34 33970108 */  j          .L80065CCC
    /* 56538 80065D38 01005226 */   addiu     $s2, $s2, 0x1
  .L80065D3C:
    /* 5653C 80065D3C 2800BF8F */  lw         $ra, 0x28($sp)
    /* 56540 80065D40 2400B58F */  lw         $s5, 0x24($sp)
    /* 56544 80065D44 2000B48F */  lw         $s4, 0x20($sp)
    /* 56548 80065D48 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5654C 80065D4C 1800B28F */  lw         $s2, 0x18($sp)
    /* 56550 80065D50 1400B18F */  lw         $s1, 0x14($sp)
    /* 56554 80065D54 1000B08F */  lw         $s0, 0x10($sp)
    /* 56558 80065D58 0800E003 */  jr         $ra
    /* 5655C 80065D5C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CheckForCops__14AIHigh_TrafficPi
