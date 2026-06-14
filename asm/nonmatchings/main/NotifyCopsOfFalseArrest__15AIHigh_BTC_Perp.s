.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp, 0xB8

glabel NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp
    /* 505A0 8005FDA0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 505A4 8005FDA4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 505A8 8005FDA8 21988000 */  addu       $s3, $a0, $zero
    /* 505AC 8005FDAC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 505B0 8005FDB0 21880000 */  addu       $s1, $zero, $zero
    /* 505B4 8005FDB4 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 505B8 8005FDB8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 505BC 8005FDBC 38CD5224 */  addiu      $s2, $v0, %lo(highLevelAIObjs)
    /* 505C0 8005FDC0 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 505C4 8005FDC4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 505C8 8005FDC8 DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
    /* 505CC 8005FDCC 2000BFAF */  sw         $ra, 0x20($sp)
  .L8005FDD0:
    /* 505D0 8005FDD0 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 505D4 8005FDD4 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 505D8 8005FDD8 00000000 */  nop
    /* 505DC 8005FDDC 2A102202 */  slt        $v0, $s1, $v0
    /* 505E0 8005FDE0 16004010 */  beqz       $v0, .L8005FE3C
    /* 505E4 8005FDE4 00000000 */   nop
    /* 505E8 8005FDE8 0000038E */  lw         $v1, 0x0($s0)
    /* 505EC 8005FDEC 00000000 */  nop
    /* 505F0 8005FDF0 6002628C */  lw         $v0, 0x260($v1)
    /* 505F4 8005FDF4 00000000 */  nop
    /* 505F8 8005FDF8 20024230 */  andi       $v0, $v0, 0x220
    /* 505FC 8005FDFC 0C004010 */  beqz       $v0, .L8005FE30
    /* 50600 8005FE00 00000000 */   nop
    /* 50604 8005FE04 91006290 */  lbu        $v0, 0x91($v1)
    /* 50608 8005FE08 00000000 */  nop
    /* 5060C 8005FE0C 08004010 */  beqz       $v0, .L8005FE30
    /* 50610 8005FE10 00000000 */   nop
    /* 50614 8005FE14 5402628C */  lw         $v0, 0x254($v1)
    /* 50618 8005FE18 00000000 */  nop
    /* 5061C 8005FE1C 80100200 */  sll        $v0, $v0, 2
    /* 50620 8005FE20 21105200 */  addu       $v0, $v0, $s2
    /* 50624 8005FE24 0000448C */  lw         $a0, 0x0($v0)
    /* 50628 8005FE28 B873010C */  jal        FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 5062C 8005FE2C 21286002 */   addu      $a1, $s3, $zero
  .L8005FE30:
    /* 50630 8005FE30 04001026 */  addiu      $s0, $s0, 0x4
    /* 50634 8005FE34 747F0108 */  j          .L8005FDD0
    /* 50638 8005FE38 01003126 */   addiu     $s1, $s1, 0x1
  .L8005FE3C:
    /* 5063C 8005FE3C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 50640 8005FE40 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 50644 8005FE44 1800B28F */  lw         $s2, 0x18($sp)
    /* 50648 8005FE48 1400B18F */  lw         $s1, 0x14($sp)
    /* 5064C 8005FE4C 1000B08F */  lw         $s0, 0x10($sp)
    /* 50650 8005FE50 0800E003 */  jr         $ra
    /* 50654 8005FE54 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp
