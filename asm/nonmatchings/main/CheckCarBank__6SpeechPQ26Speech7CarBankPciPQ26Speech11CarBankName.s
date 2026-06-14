.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName, 0xB4

glabel CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName
    /* 84D24 80094524 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 84D28 80094528 2000B4AF */  sw         $s4, 0x20($sp)
    /* 84D2C 8009452C 21A08000 */  addu       $s4, $a0, $zero
    /* 84D30 80094530 2120A000 */  addu       $a0, $a1, $zero
    /* 84D34 80094534 2400B5AF */  sw         $s5, 0x24($sp)
    /* 84D38 80094538 21A8C000 */  addu       $s5, $a2, $zero
    /* 84D3C 8009453C 2800B6AF */  sw         $s6, 0x28($sp)
    /* 84D40 80094540 21B0E000 */  addu       $s6, $a3, $zero
    /* 84D44 80094544 1800B2AF */  sw         $s2, 0x18($sp)
    /* 84D48 80094548 21900000 */  addu       $s2, $zero, $zero
    /* 84D4C 8009454C 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 84D50 80094550 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 84D54 80094554 1400B1AF */  sw         $s1, 0x14($sp)
    /* 84D58 80094558 1000B0AF */  sw         $s0, 0x10($sp)
    /* 84D5C 8009455C 7C03828E */  lw         $v0, 0x37C($s4)
    /* 84D60 80094560 00000000 */  nop
    /* 84D64 80094564 11004018 */  blez       $v0, .L800945AC
    /* 84D68 80094568 21984002 */   addu      $s3, $s2, $zero
    /* 84D6C 8009456C 4000B18F */  lw         $s1, 0x40($sp)
    /* 84D70 80094570 21808000 */  addu       $s0, $a0, $zero
  .L80094574:
    /* 84D74 80094574 21200002 */  addu       $a0, $s0, $zero
    /* 84D78 80094578 2128A002 */  addu       $a1, $s5, $zero
    /* 84D7C 8009457C 2130C002 */  addu       $a2, $s6, $zero
    /* 84D80 80094580 0751020C */  jal        Check__Q26Speech7CarBankPciPQ26Speech11CarBankName
    /* 84D84 80094584 21382002 */   addu      $a3, $s1, $zero
    /* 84D88 80094588 02004010 */  beqz       $v0, .L80094594
    /* 84D8C 8009458C 00000000 */   nop
    /* 84D90 80094590 01001324 */  addiu      $s3, $zero, 0x1
  .L80094594:
    /* 84D94 80094594 0C003126 */  addiu      $s1, $s1, 0xC
    /* 84D98 80094598 7C03828E */  lw         $v0, 0x37C($s4)
    /* 84D9C 8009459C 01005226 */  addiu      $s2, $s2, 0x1
    /* 84DA0 800945A0 2A104202 */  slt        $v0, $s2, $v0
    /* 84DA4 800945A4 F3FF4014 */  bnez       $v0, .L80094574
    /* 84DA8 800945A8 0C001026 */   addiu     $s0, $s0, 0xC
  .L800945AC:
    /* 84DAC 800945AC 21106002 */  addu       $v0, $s3, $zero
    /* 84DB0 800945B0 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 84DB4 800945B4 2800B68F */  lw         $s6, 0x28($sp)
    /* 84DB8 800945B8 2400B58F */  lw         $s5, 0x24($sp)
    /* 84DBC 800945BC 2000B48F */  lw         $s4, 0x20($sp)
    /* 84DC0 800945C0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 84DC4 800945C4 1800B28F */  lw         $s2, 0x18($sp)
    /* 84DC8 800945C8 1400B18F */  lw         $s1, 0x14($sp)
    /* 84DCC 800945CC 1000B08F */  lw         $s0, 0x10($sp)
    /* 84DD0 800945D0 0800E003 */  jr         $ra
    /* 84DD4 800945D4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName
