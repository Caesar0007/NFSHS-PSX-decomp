.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Math_QDNormalizeVector__FP8coorddef, 0x10C

glabel Math_QDNormalizeVector__FP8coorddef
    /* 8E480 8009DC80 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 8E484 8009DC84 2000B0AF */  sw         $s0, 0x20($sp)
    /* 8E488 8009DC88 21808000 */  addu       $s0, $a0, $zero
    /* 8E48C 8009DC8C 2400BFAF */  sw         $ra, 0x24($sp)
    /* 8E490 8009DC90 0000068E */  lw         $a2, 0x0($s0)
    /* 8E494 8009DC94 0400078E */  lw         $a3, 0x4($s0)
    /* 8E498 8009DC98 0800088E */  lw         $t0, 0x8($s0)
    /* 8E49C 8009DC9C 1000A6AF */  sw         $a2, 0x10($sp)
    /* 8E4A0 8009DCA0 1400A7AF */  sw         $a3, 0x14($sp)
    /* 8E4A4 8009DCA4 1800A8AF */  sw         $t0, 0x18($sp)
    /* 8E4A8 8009DCA8 1000A28F */  lw         $v0, 0x10($sp)
    /* 8E4AC 8009DCAC 00000000 */  nop
    /* 8E4B0 8009DCB0 02004104 */  bgez       $v0, .L8009DCBC
    /* 8E4B4 8009DCB4 23100200 */   negu      $v0, $v0
    /* 8E4B8 8009DCB8 1000A2AF */  sw         $v0, 0x10($sp)
  .L8009DCBC:
    /* 8E4BC 8009DCBC 1400A28F */  lw         $v0, 0x14($sp)
    /* 8E4C0 8009DCC0 00000000 */  nop
    /* 8E4C4 8009DCC4 02004104 */  bgez       $v0, .L8009DCD0
    /* 8E4C8 8009DCC8 23100200 */   negu      $v0, $v0
    /* 8E4CC 8009DCCC 1400A2AF */  sw         $v0, 0x14($sp)
  .L8009DCD0:
    /* 8E4D0 8009DCD0 1800A28F */  lw         $v0, 0x18($sp)
    /* 8E4D4 8009DCD4 00000000 */  nop
    /* 8E4D8 8009DCD8 02004104 */  bgez       $v0, .L8009DCE4
    /* 8E4DC 8009DCDC 23100200 */   negu      $v0, $v0
    /* 8E4E0 8009DCE0 1800A2AF */  sw         $v0, 0x18($sp)
  .L8009DCE4:
    /* 8E4E4 8009DCE4 1000A48F */  lw         $a0, 0x10($sp)
    /* 8E4E8 8009DCE8 1400A58F */  lw         $a1, 0x14($sp)
    /* 8E4EC 8009DCEC 3275020C */  jal        Math_BetterDist__Fii
    /* 8E4F0 8009DCF0 00000000 */   nop
    /* 8E4F4 8009DCF4 1800A58F */  lw         $a1, 0x18($sp)
    /* 8E4F8 8009DCF8 3275020C */  jal        Math_BetterDist__Fii
    /* 8E4FC 8009DCFC 21204000 */   addu      $a0, $v0, $zero
    /* 8E500 8009DD00 1E004010 */  beqz       $v0, .L8009DD7C
    /* 8E504 8009DD04 00000000 */   nop
    /* 8E508 8009DD08 FBB4030C */  jal        fixedinverse
    /* 8E50C 8009DD0C 21204000 */   addu      $a0, $v0, $zero
    /* 8E510 8009DD10 0000038E */  lw         $v1, 0x0($s0)
    /* 8E514 8009DD14 00000000 */  nop
    /* 8E518 8009DD18 02006104 */  bgez       $v1, .L8009DD24
    /* 8E51C 8009DD1C 21204000 */   addu      $a0, $v0, $zero
    /* 8E520 8009DD20 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8009DD24:
    /* 8E524 8009DD24 21108000 */  addu       $v0, $a0, $zero
    /* 8E528 8009DD28 02008104 */  bgez       $a0, .L8009DD34
    /* 8E52C 8009DD2C 032A0300 */   sra       $a1, $v1, 8
    /* 8E530 8009DD30 FF008224 */  addiu      $v0, $a0, 0xFF
  .L8009DD34:
    /* 8E534 8009DD34 031A0200 */  sra        $v1, $v0, 8
    /* 8E538 8009DD38 1800A300 */  mult       $a1, $v1
    /* 8E53C 8009DD3C 0400028E */  lw         $v0, 0x4($s0)
    /* 8E540 8009DD40 12300000 */  mflo       $a2
    /* 8E544 8009DD44 02004104 */  bgez       $v0, .L8009DD50
    /* 8E548 8009DD48 000006AE */   sw        $a2, 0x0($s0)
    /* 8E54C 8009DD4C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8009DD50:
    /* 8E550 8009DD50 03120200 */  sra        $v0, $v0, 8
    /* 8E554 8009DD54 18004300 */  mult       $v0, $v1
    /* 8E558 8009DD58 0800028E */  lw         $v0, 0x8($s0)
    /* 8E55C 8009DD5C 12300000 */  mflo       $a2
    /* 8E560 8009DD60 02004104 */  bgez       $v0, .L8009DD6C
    /* 8E564 8009DD64 040006AE */   sw        $a2, 0x4($s0)
    /* 8E568 8009DD68 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8009DD6C:
    /* 8E56C 8009DD6C 03120200 */  sra        $v0, $v0, 8
    /* 8E570 8009DD70 18004300 */  mult       $v0, $v1
    /* 8E574 8009DD74 12300000 */  mflo       $a2
    /* 8E578 8009DD78 080006AE */  sw         $a2, 0x8($s0)
  .L8009DD7C:
    /* 8E57C 8009DD7C 2400BF8F */  lw         $ra, 0x24($sp)
    /* 8E580 8009DD80 2000B08F */  lw         $s0, 0x20($sp)
    /* 8E584 8009DD84 0800E003 */  jr         $ra
    /* 8E588 8009DD88 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Math_QDNormalizeVector__FP8coorddef
