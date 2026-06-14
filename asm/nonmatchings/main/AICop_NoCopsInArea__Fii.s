.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AICop_NoCopsInArea__Fii, 0xA8

glabel AICop_NoCopsInArea__Fii
    /* 57308 80066B08 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 5730C 80066B0C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 57310 80066B10 21908000 */  addu       $s2, $a0, $zero
    /* 57314 80066B14 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 57318 80066B18 2198A000 */  addu       $s3, $a1, $zero
    /* 5731C 80066B1C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 57320 80066B20 21880000 */  addu       $s1, $zero, $zero
    /* 57324 80066B24 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* 57328 80066B28 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5732C 80066B2C B4FA5024 */  addiu      $s0, $v0, %lo(Cars_gCopCarList)
    /* 57330 80066B30 2000BFAF */  sw         $ra, 0x20($sp)
  .L80066B34:
    /* 57334 80066B34 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* 57338 80066B38 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* 5733C 80066B3C 00000000 */  nop
    /* 57340 80066B40 2A102202 */  slt        $v0, $s1, $v0
    /* 57344 80066B44 13004010 */  beqz       $v0, .L80066B94
    /* 57348 80066B48 01000224 */   addiu     $v0, $zero, 0x1
    /* 5734C 80066B4C 0000048E */  lw         $a0, 0x0($s0)
    /* 57350 80066B50 00000000 */  nop
    /* 57354 80066B54 7005828C */  lw         $v0, 0x570($a0)
    /* 57358 80066B58 00000000 */  nop
    /* 5735C 80066B5C 04004230 */  andi       $v0, $v0, 0x4
    /* 57360 80066B60 09004014 */  bnez       $v0, .L80066B88
    /* 57364 80066B64 00000000 */   nop
    /* 57368 80066B68 4ACC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObji
    /* 5736C 80066B6C 21284002 */   addu      $a1, $s2, $zero
    /* 57370 80066B70 02004104 */  bgez       $v0, .L80066B7C
    /* 57374 80066B74 00000000 */   nop
    /* 57378 80066B78 23100200 */  negu       $v0, $v0
  .L80066B7C:
    /* 5737C 80066B7C 2A105300 */  slt        $v0, $v0, $s3
    /* 57380 80066B80 04004014 */  bnez       $v0, .L80066B94
    /* 57384 80066B84 21100000 */   addu      $v0, $zero, $zero
  .L80066B88:
    /* 57388 80066B88 04001026 */  addiu      $s0, $s0, 0x4
    /* 5738C 80066B8C CD9A0108 */  j          .L80066B34
    /* 57390 80066B90 01003126 */   addiu     $s1, $s1, 0x1
  .L80066B94:
    /* 57394 80066B94 2000BF8F */  lw         $ra, 0x20($sp)
    /* 57398 80066B98 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5739C 80066B9C 1800B28F */  lw         $s2, 0x18($sp)
    /* 573A0 80066BA0 1400B18F */  lw         $s1, 0x14($sp)
    /* 573A4 80066BA4 1000B08F */  lw         $s0, 0x10($sp)
    /* 573A8 80066BA8 0800E003 */  jr         $ra
    /* 573AC 80066BAC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AICop_NoCopsInArea__Fii
