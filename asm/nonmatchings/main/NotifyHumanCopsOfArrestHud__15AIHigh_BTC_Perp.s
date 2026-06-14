.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp, 0xB8

glabel NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp
    /* 50658 8005FE58 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 5065C 8005FE5C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 50660 8005FE60 21908000 */  addu       $s2, $a0, $zero
    /* 50664 8005FE64 1400B1AF */  sw         $s1, 0x14($sp)
    /* 50668 8005FE68 21880000 */  addu       $s1, $zero, $zero
    /* 5066C 8005FE6C 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 50670 8005FE70 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 50674 8005FE74 38CD5324 */  addiu      $s3, $v0, %lo(highLevelAIObjs)
    /* 50678 8005FE78 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 5067C 8005FE7C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 50680 8005FE80 DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
    /* 50684 8005FE84 2000BFAF */  sw         $ra, 0x20($sp)
  .L8005FE88:
    /* 50688 8005FE88 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 5068C 8005FE8C F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 50690 8005FE90 00000000 */  nop
    /* 50694 8005FE94 2A102202 */  slt        $v0, $s1, $v0
    /* 50698 8005FE98 16004010 */  beqz       $v0, .L8005FEF4
    /* 5069C 8005FE9C 00000000 */   nop
    /* 506A0 8005FEA0 0000038E */  lw         $v1, 0x0($s0)
    /* 506A4 8005FEA4 00000000 */  nop
    /* 506A8 8005FEA8 6002628C */  lw         $v0, 0x260($v1)
    /* 506AC 8005FEAC 00000000 */  nop
    /* 506B0 8005FEB0 00024230 */  andi       $v0, $v0, 0x200
    /* 506B4 8005FEB4 0C004010 */  beqz       $v0, .L8005FEE8
    /* 506B8 8005FEB8 00000000 */   nop
    /* 506BC 8005FEBC 91006290 */  lbu        $v0, 0x91($v1)
    /* 506C0 8005FEC0 00000000 */  nop
    /* 506C4 8005FEC4 08004010 */  beqz       $v0, .L8005FEE8
    /* 506C8 8005FEC8 21284002 */   addu      $a1, $s2, $zero
    /* 506CC 8005FECC 5402628C */  lw         $v0, 0x254($v1)
    /* 506D0 8005FED0 6C00478E */  lw         $a3, 0x6C($s2)
    /* 506D4 8005FED4 80100200 */  sll        $v0, $v0, 2
    /* 506D8 8005FED8 21105300 */  addu       $v0, $v0, $s3
    /* 506DC 8005FEDC 0000448C */  lw         $a0, 0x0($v0)
    /* 506E0 8005FEE0 A178010C */  jal        HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj
    /* 506E4 8005FEE4 21300000 */   addu      $a2, $zero, $zero
  .L8005FEE8:
    /* 506E8 8005FEE8 04001026 */  addiu      $s0, $s0, 0x4
    /* 506EC 8005FEEC A27F0108 */  j          .L8005FE88
    /* 506F0 8005FEF0 01003126 */   addiu     $s1, $s1, 0x1
  .L8005FEF4:
    /* 506F4 8005FEF4 2000BF8F */  lw         $ra, 0x20($sp)
    /* 506F8 8005FEF8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 506FC 8005FEFC 1800B28F */  lw         $s2, 0x18($sp)
    /* 50700 8005FF00 1400B18F */  lw         $s1, 0x14($sp)
    /* 50704 8005FF04 1000B08F */  lw         $s0, 0x10($sp)
    /* 50708 8005FF08 0800E003 */  jr         $ra
    /* 5070C 8005FF0C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp
