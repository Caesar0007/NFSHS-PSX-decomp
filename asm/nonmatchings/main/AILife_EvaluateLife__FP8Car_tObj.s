.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_EvaluateLife__FP8Car_tObj, 0x64

glabel AILife_EvaluateLife__FP8Car_tObj
    /* 57E50 80067650 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 57E54 80067654 1000B0AF */  sw         $s0, 0x10($sp)
    /* 57E58 80067658 21808000 */  addu       $s0, $a0, $zero
    /* 57E5C 8006765C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 57E60 80067660 6002028E */  lw         $v0, 0x260($s0)
    /* 57E64 80067664 00000000 */  nop
    /* 57E68 80067668 00044230 */  andi       $v0, $v0, 0x400
    /* 57E6C 8006766C 0D004014 */  bnez       $v0, .L800676A4
    /* 57E70 80067670 21100000 */   addu      $v0, $zero, $zero
    /* 57E74 80067674 7805058E */  lw         $a1, 0x578($s0)
    /* 57E78 80067678 96A1010C */  jal        AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj
    /* 57E7C 8006767C A0000426 */   addiu     $a0, $s0, 0xA0
    /* 57E80 80067680 07004014 */  bnez       $v0, .L800676A0
    /* 57E84 80067684 00000000 */   nop
    /* 57E88 80067688 C1A1010C */  jal        AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj
    /* 57E8C 8006768C 21200002 */   addu      $a0, $s0, $zero
    /* 57E90 80067690 21184000 */  addu       $v1, $v0, $zero
    /* 57E94 80067694 780503AE */  sw         $v1, 0x578($s0)
    /* 57E98 80067698 02006010 */  beqz       $v1, .L800676A4
    /* 57E9C 8006769C 01000224 */   addiu     $v0, $zero, 0x1
  .L800676A0:
    /* 57EA0 800676A0 21100000 */  addu       $v0, $zero, $zero
  .L800676A4:
    /* 57EA4 800676A4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 57EA8 800676A8 1000B08F */  lw         $s0, 0x10($sp)
    /* 57EAC 800676AC 0800E003 */  jr         $ra
    /* 57EB0 800676B0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AILife_EvaluateLife__FP8Car_tObj
