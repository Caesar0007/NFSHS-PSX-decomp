.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SaveCars__11tCarManagerR12tSaveCarInfo, 0x78

glabel SaveCars__11tCarManagerR12tSaveCarInfo
    /* 72F0 80016AF0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 72F4 80016AF4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 72F8 80016AF8 21808000 */  addu       $s0, $a0, $zero
    /* 72FC 80016AFC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7300 80016B00 2188A000 */  addu       $s1, $a1, $zero
    /* 7304 80016B04 08000426 */  addiu      $a0, $s0, 0x8
    /* 7308 80016B08 1800BFAF */  sw         $ra, 0x18($sp)
    /* 730C 80016B0C B798030C */  jal        blockmove
    /* 7310 80016B10 80000624 */   addiu     $a2, $zero, 0x80
    /* 7314 80016B14 0000028E */  lw         $v0, 0x0($s0)
    /* 7318 80016B18 00000000 */  nop
    /* 731C 80016B1C 0D004010 */  beqz       $v0, .L80016B54
    /* 7320 80016B20 21280000 */   addu      $a1, $zero, $zero
    /* 7324 80016B24 21200502 */  addu       $a0, $s0, $a1
  .L80016B28:
    /* 7328 80016B28 08028290 */  lbu        $v0, 0x208($a0)
    /* 732C 80016B2C 21182502 */  addu       $v1, $s1, $a1
    /* 7330 80016B30 800062A0 */  sb         $v0, 0x80($v1)
    /* 7334 80016B34 38028290 */  lbu        $v0, 0x238($a0)
    /* 7338 80016B38 00000000 */  nop
    /* 733C 80016B3C B00062A0 */  sb         $v0, 0xB0($v1)
    /* 7340 80016B40 0000028E */  lw         $v0, 0x0($s0)
    /* 7344 80016B44 0100A524 */  addiu      $a1, $a1, 0x1
    /* 7348 80016B48 2B10A200 */  sltu       $v0, $a1, $v0
    /* 734C 80016B4C F6FF4014 */  bnez       $v0, .L80016B28
    /* 7350 80016B50 21200502 */   addu      $a0, $s0, $a1
  .L80016B54:
    /* 7354 80016B54 1800BF8F */  lw         $ra, 0x18($sp)
    /* 7358 80016B58 1400B18F */  lw         $s1, 0x14($sp)
    /* 735C 80016B5C 1000B08F */  lw         $s0, 0x10($sp)
    /* 7360 80016B60 0800E003 */  jr         $ra
    /* 7364 80016B64 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SaveCars__11tCarManagerR12tSaveCarInfo
