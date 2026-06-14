.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForNewTarget__10AIHigh_Cop, 0x260

glabel CheckForNewTarget__10AIHigh_Cop
    /* 55DA8 800655A8 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 55DAC 800655AC 2000B4AF */  sw         $s4, 0x20($sp)
    /* 55DB0 800655B0 21A08000 */  addu       $s4, $a0, $zero
    /* 55DB4 800655B4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 55DB8 800655B8 21980000 */  addu       $s3, $zero, $zero
    /* 55DBC 800655BC 2400B5AF */  sw         $s5, 0x24($sp)
    /* 55DC0 800655C0 1027153C */  lui        $s5, (0x27100000 >> 16)
    /* 55DC4 800655C4 01000224 */  addiu      $v0, $zero, 0x1
    /* 55DC8 800655C8 3000BFAF */  sw         $ra, 0x30($sp)
    /* 55DCC 800655CC 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 55DD0 800655D0 2800B6AF */  sw         $s6, 0x28($sp)
    /* 55DD4 800655D4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 55DD8 800655D8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 55DDC 800655DC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 55DE0 800655E0 2000838E */  lw         $v1, 0x20($s4)
    /* 55DE4 800655E4 5800978E */  lw         $s7, 0x58($s4)
    /* 55DE8 800655E8 06006210 */  beq        $v1, $v0, .L80065604
    /* 55DEC 800655EC 21206002 */   addu      $a0, $s3, $zero
    /* 55DF0 800655F0 04000224 */  addiu      $v0, $zero, 0x4
    /* 55DF4 800655F4 03006210 */  beq        $v1, $v0, .L80065604
    /* 55DF8 800655F8 02000224 */   addiu     $v0, $zero, 0x2
    /* 55DFC 800655FC 02006214 */  bne        $v1, $v0, .L80065608
    /* 55E00 80065600 00000000 */   nop
  .L80065604:
    /* 55E04 80065604 01000424 */  addiu      $a0, $zero, 0x1
  .L80065608:
    /* 55E08 80065608 74008014 */  bnez       $a0, .L800657DC
    /* 55E0C 8006560C 21100000 */   addu      $v0, $zero, $zero
    /* 55E10 80065610 21900000 */  addu       $s2, $zero, $zero
    /* 55E14 80065614 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 55E18 80065618 38CD5624 */  addiu      $s6, $v0, %lo(highLevelAIObjs)
    /* 55E1C 8006561C 1180023C */  lui        $v0, %hi(Cars_gRaceCarList)
    /* 55E20 80065620 00FA5124 */  addiu      $s1, $v0, %lo(Cars_gRaceCarList)
  .L80065624:
    /* 55E24 80065624 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* 55E28 80065628 F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* 55E2C 8006562C 00000000 */  nop
    /* 55E30 80065630 2A104202 */  slt        $v0, $s2, $v0
    /* 55E34 80065634 2E004010 */  beqz       $v0, .L800656F0
    /* 55E38 80065638 00000000 */   nop
    /* 55E3C 8006563C 0000228E */  lw         $v0, 0x0($s1)
    /* 55E40 80065640 00000000 */  nop
    /* 55E44 80065644 5402428C */  lw         $v0, 0x254($v0)
    /* 55E48 80065648 00000000 */  nop
    /* 55E4C 8006564C 80100200 */  sll        $v0, $v0, 2
    /* 55E50 80065650 21105600 */  addu       $v0, $v0, $s6
    /* 55E54 80065654 0000508C */  lw         $s0, 0x0($v0)
    /* 55E58 80065658 00000000 */  nop
    /* 55E5C 8006565C 7800028E */  lw         $v0, 0x78($s0)
    /* 55E60 80065660 00000000 */  nop
    /* 55E64 80065664 06004010 */  beqz       $v0, .L80065680
    /* 55E68 80065668 21180000 */   addu      $v1, $zero, $zero
    /* 55E6C 8006566C 1800828E */  lw         $v0, 0x18($s4)
    /* 55E70 80065670 9C00038E */  lw         $v1, 0x9C($s0)
    /* 55E74 80065674 80100200 */  sll        $v0, $v0, 2
    /* 55E78 80065678 21186200 */  addu       $v1, $v1, $v0
    /* 55E7C 8006567C 0000638C */  lw         $v1, 0x0($v1)
  .L80065680:
    /* 55E80 80065680 1800828E */  lw         $v0, 0x18($s4)
    /* 55E84 80065684 5800848E */  lw         $a0, 0x58($s4)
    /* 55E88 80065688 80100200 */  sll        $v0, $v0, 2
    /* 55E8C 8006568C 21100202 */  addu       $v0, $s0, $v0
    /* 55E90 80065690 7000428C */  lw         $v0, 0x70($v0)
    /* 55E94 80065694 04008010 */  beqz       $a0, .L800656A8
    /* 55E98 80065698 00000000 */   nop
    /* 55E9C 8006569C 02009014 */  bne        $a0, $s0, .L800656A8
    /* 55EA0 800656A0 00000000 */   nop
    /* 55EA4 800656A4 FFFF4224 */  addiu      $v0, $v0, -0x1
  .L800656A8:
    /* 55EA8 800656A8 2A104300 */  slt        $v0, $v0, $v1
    /* 55EAC 800656AC 0D004010 */  beqz       $v0, .L800656E4
    /* 55EB0 800656B0 00000000 */   nop
    /* 55EB4 800656B4 0000848E */  lw         $a0, 0x0($s4)
    /* 55EB8 800656B8 0000058E */  lw         $a1, 0x0($s0)
    /* 55EBC 800656BC 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 55EC0 800656C0 00000000 */   nop
    /* 55EC4 800656C4 02004104 */  bgez       $v0, .L800656D0
    /* 55EC8 800656C8 21184000 */   addu      $v1, $v0, $zero
    /* 55ECC 800656CC 23180300 */  negu       $v1, $v1
  .L800656D0:
    /* 55ED0 800656D0 2A107500 */  slt        $v0, $v1, $s5
    /* 55ED4 800656D4 03004010 */  beqz       $v0, .L800656E4
    /* 55ED8 800656D8 00000000 */   nop
    /* 55EDC 800656DC 21A86000 */  addu       $s5, $v1, $zero
    /* 55EE0 800656E0 21980002 */  addu       $s3, $s0, $zero
  .L800656E4:
    /* 55EE4 800656E4 04003126 */  addiu      $s1, $s1, 0x4
    /* 55EE8 800656E8 89950108 */  j          .L80065624
    /* 55EEC 800656EC 01005226 */   addiu     $s2, $s2, 0x1
  .L800656F0:
    /* 55EF0 800656F0 27006016 */  bnez       $s3, .L80065790
    /* 55EF4 800656F4 21900000 */   addu      $s2, $zero, $zero
    /* 55EF8 800656F8 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 55EFC 800656FC 38CD5624 */  addiu      $s6, $v0, %lo(highLevelAIObjs)
    /* 55F00 80065700 1180023C */  lui        $v0, %hi(Cars_gRaceCarList)
    /* 55F04 80065704 00FA5124 */  addiu      $s1, $v0, %lo(Cars_gRaceCarList)
  .L80065708:
    /* 55F08 80065708 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* 55F0C 8006570C F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* 55F10 80065710 00000000 */  nop
    /* 55F14 80065714 2A104202 */  slt        $v0, $s2, $v0
    /* 55F18 80065718 1B004010 */  beqz       $v0, .L80065788
    /* 55F1C 8006571C 00000000 */   nop
    /* 55F20 80065720 0000228E */  lw         $v0, 0x0($s1)
    /* 55F24 80065724 00000000 */  nop
    /* 55F28 80065728 5402428C */  lw         $v0, 0x254($v0)
    /* 55F2C 8006572C 00000000 */  nop
    /* 55F30 80065730 80100200 */  sll        $v0, $v0, 2
    /* 55F34 80065734 21105600 */  addu       $v0, $v0, $s6
    /* 55F38 80065738 0000508C */  lw         $s0, 0x0($v0)
    /* 55F3C 8006573C 0000848E */  lw         $a0, 0x0($s4)
    /* 55F40 80065740 0000058E */  lw         $a1, 0x0($s0)
    /* 55F44 80065744 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 55F48 80065748 00000000 */   nop
    /* 55F4C 8006574C 02004104 */  bgez       $v0, .L80065758
    /* 55F50 80065750 21184000 */   addu      $v1, $v0, $zero
    /* 55F54 80065754 23180300 */  negu       $v1, $v1
  .L80065758:
    /* 55F58 80065758 2A107500 */  slt        $v0, $v1, $s5
    /* 55F5C 8006575C 07004010 */  beqz       $v0, .L8006577C
    /* 55F60 80065760 00000000 */   nop
    /* 55F64 80065764 7800028E */  lw         $v0, 0x78($s0)
    /* 55F68 80065768 00000000 */  nop
    /* 55F6C 8006576C 03004010 */  beqz       $v0, .L8006577C
    /* 55F70 80065770 00000000 */   nop
    /* 55F74 80065774 21A86000 */  addu       $s5, $v1, $zero
    /* 55F78 80065778 21980002 */  addu       $s3, $s0, $zero
  .L8006577C:
    /* 55F7C 8006577C 04003126 */  addiu      $s1, $s1, 0x4
    /* 55F80 80065780 C2950108 */  j          .L80065708
    /* 55F84 80065784 01005226 */   addiu     $s2, $s2, 0x1
  .L80065788:
    /* 55F88 80065788 0D006012 */  beqz       $s3, .L800657C0
    /* 55F8C 8006578C 00000000 */   nop
  .L80065790:
    /* 55F90 80065790 0B007712 */  beq        $s3, $s7, .L800657C0
    /* 55F94 80065794 21208002 */   addu      $a0, $s4, $zero
    /* 55F98 80065798 0296010C */  jal        AssignToPlayer__10AIHigh_CopP13AIHigh_Player
    /* 55F9C 8006579C 21286002 */   addu      $a1, $s3, $zero
    /* 55FA0 800657A0 1800828E */  lw         $v0, 0x18($s4)
    /* 55FA4 800657A4 9C00638E */  lw         $v1, 0x9C($s3)
    /* 55FA8 800657A8 80100200 */  sll        $v0, $v0, 2
    /* 55FAC 800657AC 21186200 */  addu       $v1, $v1, $v0
    /* 55FB0 800657B0 1800638C */  lw         $v1, 0x18($v1)
    /* 55FB4 800657B4 01000224 */  addiu      $v0, $zero, 0x1
    /* 55FB8 800657B8 F7950108 */  j          .L800657DC
    /* 55FBC 800657BC 680083AE */   sw        $v1, 0x68($s4)
  .L800657C0:
    /* 55FC0 800657C0 0600E012 */  beqz       $s7, .L800657DC
    /* 55FC4 800657C4 21100000 */   addu      $v0, $zero, $zero
    /* 55FC8 800657C8 04006016 */  bnez       $s3, .L800657DC
    /* 55FCC 800657CC 21208002 */   addu      $a0, $s4, $zero
    /* 55FD0 800657D0 0296010C */  jal        AssignToPlayer__10AIHigh_CopP13AIHigh_Player
    /* 55FD4 800657D4 21280000 */   addu      $a1, $zero, $zero
    /* 55FD8 800657D8 21100000 */  addu       $v0, $zero, $zero
  .L800657DC:
    /* 55FDC 800657DC 3000BF8F */  lw         $ra, 0x30($sp)
    /* 55FE0 800657E0 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 55FE4 800657E4 2800B68F */  lw         $s6, 0x28($sp)
    /* 55FE8 800657E8 2400B58F */  lw         $s5, 0x24($sp)
    /* 55FEC 800657EC 2000B48F */  lw         $s4, 0x20($sp)
    /* 55FF0 800657F0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 55FF4 800657F4 1800B28F */  lw         $s2, 0x18($sp)
    /* 55FF8 800657F8 1400B18F */  lw         $s1, 0x14($sp)
    /* 55FFC 800657FC 1000B08F */  lw         $s0, 0x10($sp)
    /* 56000 80065800 0800E003 */  jr         $ra
    /* 56004 80065804 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CheckForNewTarget__10AIHigh_Cop
