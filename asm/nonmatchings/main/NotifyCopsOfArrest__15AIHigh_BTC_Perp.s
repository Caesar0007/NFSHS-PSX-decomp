.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NotifyCopsOfArrest__15AIHigh_BTC_Perp, 0xB8

glabel NotifyCopsOfArrest__15AIHigh_BTC_Perp
    /* 50430 8005FC30 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 50434 8005FC34 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 50438 8005FC38 21988000 */  addu       $s3, $a0, $zero
    /* 5043C 8005FC3C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 50440 8005FC40 21880000 */  addu       $s1, $zero, $zero
    /* 50444 8005FC44 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 50448 8005FC48 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5044C 8005FC4C 38CD5224 */  addiu      $s2, $v0, %lo(highLevelAIObjs)
    /* 50450 8005FC50 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 50454 8005FC54 1000B0AF */  sw         $s0, 0x10($sp)
    /* 50458 8005FC58 DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
    /* 5045C 8005FC5C 2000BFAF */  sw         $ra, 0x20($sp)
  .L8005FC60:
    /* 50460 8005FC60 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 50464 8005FC64 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 50468 8005FC68 00000000 */  nop
    /* 5046C 8005FC6C 2A102202 */  slt        $v0, $s1, $v0
    /* 50470 8005FC70 16004010 */  beqz       $v0, .L8005FCCC
    /* 50474 8005FC74 00000000 */   nop
    /* 50478 8005FC78 0000038E */  lw         $v1, 0x0($s0)
    /* 5047C 8005FC7C 00000000 */  nop
    /* 50480 8005FC80 6002628C */  lw         $v0, 0x260($v1)
    /* 50484 8005FC84 00000000 */  nop
    /* 50488 8005FC88 20024230 */  andi       $v0, $v0, 0x220
    /* 5048C 8005FC8C 0C004010 */  beqz       $v0, .L8005FCC0
    /* 50490 8005FC90 00000000 */   nop
    /* 50494 8005FC94 91006290 */  lbu        $v0, 0x91($v1)
    /* 50498 8005FC98 00000000 */  nop
    /* 5049C 8005FC9C 08004010 */  beqz       $v0, .L8005FCC0
    /* 504A0 8005FCA0 00000000 */   nop
    /* 504A4 8005FCA4 5402628C */  lw         $v0, 0x254($v1)
    /* 504A8 8005FCA8 00000000 */  nop
    /* 504AC 8005FCAC 80100200 */  sll        $v0, $v0, 2
    /* 504B0 8005FCB0 21105200 */  addu       $v0, $v0, $s2
    /* 504B4 8005FCB4 0000448C */  lw         $a0, 0x0($v0)
    /* 504B8 8005FCB8 8473010C */  jal        StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 504BC 8005FCBC 21286002 */   addu      $a1, $s3, $zero
  .L8005FCC0:
    /* 504C0 8005FCC0 04001026 */  addiu      $s0, $s0, 0x4
    /* 504C4 8005FCC4 187F0108 */  j          .L8005FC60
    /* 504C8 8005FCC8 01003126 */   addiu     $s1, $s1, 0x1
  .L8005FCCC:
    /* 504CC 8005FCCC 2000BF8F */  lw         $ra, 0x20($sp)
    /* 504D0 8005FCD0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 504D4 8005FCD4 1800B28F */  lw         $s2, 0x18($sp)
    /* 504D8 8005FCD8 1400B18F */  lw         $s1, 0x14($sp)
    /* 504DC 8005FCDC 1000B08F */  lw         $s0, 0x10($sp)
    /* 504E0 8005FCE0 0800E003 */  jr         $ra
    /* 504E4 8005FCE4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel NotifyCopsOfArrest__15AIHigh_BTC_Perp
