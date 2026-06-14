.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource, 0x16C

glabel Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource
    /* AA52C 800B9D2C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* AA530 800B9D30 2400B1AF */  sw         $s1, 0x24($sp)
    /* AA534 800B9D34 21888000 */  addu       $s1, $a0, $zero
    /* AA538 800B9D38 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* AA53C 800B9D3C 2198A000 */  addu       $s3, $a1, $zero
    /* AA540 800B9D40 2800B2AF */  sw         $s2, 0x28($sp)
    /* AA544 800B9D44 2190C000 */  addu       $s2, $a2, $zero
    /* AA548 800B9D48 3000BFAF */  sw         $ra, 0x30($sp)
    /* AA54C 800B9D4C 2000B0AF */  sw         $s0, 0x20($sp)
    /* AA550 800B9D50 02002292 */  lbu        $v0, 0x2($s1)
    /* AA554 800B9D54 21800000 */  addu       $s0, $zero, $zero
    /* AA558 800B9D58 000062A2 */  sb         $v0, 0x0($s3)
  .L800B9D5C:
    /* AA55C 800B9D5C 0600001A */  blez       $s0, .L800B9D78
    /* AA560 800B9D60 00000000 */   nop
    /* AA564 800B9D64 07002292 */  lbu        $v0, 0x7($s1)
    /* AA568 800B9D68 00000000 */  nop
    /* AA56C 800B9D6C 2A100202 */  slt        $v0, $s0, $v0
    /* AA570 800B9D70 42004010 */  beqz       $v0, .L800B9E7C
    /* AA574 800B9D74 00000000 */   nop
  .L800B9D78:
    /* AA578 800B9D78 03002292 */  lbu        $v0, 0x3($s1)
    /* AA57C 800B9D7C 00000000 */  nop
    /* AA580 800B9D80 5E004230 */  andi       $v0, $v0, 0x5E
    /* AA584 800B9D84 2F004010 */  beqz       $v0, .L800B9E44
    /* AA588 800B9D88 00000000 */   nop
    /* AA58C 800B9D8C 02002292 */  lbu        $v0, 0x2($s1)
    /* AA590 800B9D90 00002486 */  lh         $a0, 0x0($s1)
    /* AA594 800B9D94 02004230 */  andi       $v0, $v0, 0x2
    /* AA598 800B9D98 06004010 */  beqz       $v0, .L800B9DB4
    /* AA59C 800B9D9C 1000A527 */   addiu     $a1, $sp, 0x10
    /* AA5A0 800B9DA0 08002592 */  lbu        $a1, 0x8($s1)
    /* AA5A4 800B9DA4 DDE6020C */  jal        Track_GetProperMultiPalShapeIndex__Fii
    /* AA5A8 800B9DA8 00000000 */   nop
    /* AA5AC 800B9DAC 21204000 */  addu       $a0, $v0, $zero
    /* AA5B0 800B9DB0 1000A527 */  addiu      $a1, $sp, 0x10
  .L800B9DB4:
    /* AA5B4 800B9DB4 21109000 */  addu       $v0, $a0, $s0
    /* AA5B8 800B9DB8 0C00438E */  lw         $v1, 0xC($s2)
    /* AA5BC 800B9DBC 00110200 */  sll        $v0, $v0, 4
    /* AA5C0 800B9DC0 21104300 */  addu       $v0, $v0, $v1
    /* AA5C4 800B9DC4 03004788 */  lwl        $a3, 0x3($v0)
    /* AA5C8 800B9DC8 00004798 */  lwr        $a3, 0x0($v0)
    /* AA5CC 800B9DCC 07004888 */  lwl        $t0, 0x7($v0)
    /* AA5D0 800B9DD0 04004898 */  lwr        $t0, 0x4($v0)
    /* AA5D4 800B9DD4 0B004988 */  lwl        $t1, 0xB($v0)
    /* AA5D8 800B9DD8 08004998 */  lwr        $t1, 0x8($v0)
    /* AA5DC 800B9DDC 0F004A88 */  lwl        $t2, 0xF($v0)
    /* AA5E0 800B9DE0 0C004A98 */  lwr        $t2, 0xC($v0)
    /* AA5E4 800B9DE4 1300A7AB */  swl        $a3, 0x13($sp)
    /* AA5E8 800B9DE8 1000A7BB */  swr        $a3, 0x10($sp)
    /* AA5EC 800B9DEC 1700A8AB */  swl        $t0, 0x17($sp)
    /* AA5F0 800B9DF0 1400A8BB */  swr        $t0, 0x14($sp)
    /* AA5F4 800B9DF4 1B00A9AB */  swl        $t1, 0x1B($sp)
    /* AA5F8 800B9DF8 1800A9BB */  swr        $t1, 0x18($sp)
    /* AA5FC 800B9DFC 1F00AAAB */  swl        $t2, 0x1F($sp)
    /* AA600 800B9E00 1C00AABB */  swr        $t2, 0x1C($sp)
    /* AA604 800B9E04 03002492 */  lbu        $a0, 0x3($s1)
    /* AA608 800B9E08 1000468E */  lw         $a2, 0x10($s2)
    /* AA60C 800B9E0C 0C00428E */  lw         $v0, 0xC($s2)
    /* AA610 800B9E10 00310600 */  sll        $a2, $a2, 4
    /* AA614 800B9E14 F1E6020C */  jal        Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1
    /* AA618 800B9E18 21304600 */   addu      $a2, $v0, $a2
    /* AA61C 800B9E1C 04000016 */  bnez       $s0, .L800B9E30
    /* AA620 800B9E20 00000000 */   nop
    /* AA624 800B9E24 10004296 */  lhu        $v0, 0x10($s2)
    /* AA628 800B9E28 00000000 */  nop
    /* AA62C 800B9E2C 020062A6 */  sh         $v0, 0x2($s3)
  .L800B9E30:
    /* AA630 800B9E30 1000428E */  lw         $v0, 0x10($s2)
    /* AA634 800B9E34 00000000 */  nop
    /* AA638 800B9E38 01004224 */  addiu      $v0, $v0, 0x1
    /* AA63C 800B9E3C 9DE70208 */  j          .L800B9E74
    /* AA640 800B9E40 100042AE */   sw        $v0, 0x10($s2)
  .L800B9E44:
    /* AA644 800B9E44 02002292 */  lbu        $v0, 0x2($s1)
    /* AA648 800B9E48 00002486 */  lh         $a0, 0x0($s1)
    /* AA64C 800B9E4C 02004230 */  andi       $v0, $v0, 0x2
    /* AA650 800B9E50 05004010 */  beqz       $v0, .L800B9E68
    /* AA654 800B9E54 00000000 */   nop
    /* AA658 800B9E58 08002592 */  lbu        $a1, 0x8($s1)
    /* AA65C 800B9E5C DDE6020C */  jal        Track_GetProperMultiPalShapeIndex__Fii
    /* AA660 800B9E60 00000000 */   nop
    /* AA664 800B9E64 21204000 */  addu       $a0, $v0, $zero
  .L800B9E68:
    /* AA668 800B9E68 02000016 */  bnez       $s0, .L800B9E74
    /* AA66C 800B9E6C 00000000 */   nop
    /* AA670 800B9E70 020064A6 */  sh         $a0, 0x2($s3)
  .L800B9E74:
    /* AA674 800B9E74 57E70208 */  j          .L800B9D5C
    /* AA678 800B9E78 01001026 */   addiu     $s0, $s0, 0x1
  .L800B9E7C:
    /* AA67C 800B9E7C 3000BF8F */  lw         $ra, 0x30($sp)
    /* AA680 800B9E80 2C00B38F */  lw         $s3, 0x2C($sp)
    /* AA684 800B9E84 2800B28F */  lw         $s2, 0x28($sp)
    /* AA688 800B9E88 2400B18F */  lw         $s1, 0x24($sp)
    /* AA68C 800B9E8C 2000B08F */  lw         $s0, 0x20($sp)
    /* AA690 800B9E90 0800E003 */  jr         $ra
    /* AA694 800B9E94 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource
