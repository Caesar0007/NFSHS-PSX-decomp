.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_OrderSentences, 0x14C

glabel iSPCH_OrderSentences
    /* F1594 80100D94 68FFBD27 */  addiu      $sp, $sp, -0x98
    /* F1598 80100D98 8C00B5AF */  sw         $s5, 0x8C($sp)
    /* F159C 80100D9C 21A88000 */  addu       $s5, $a0, $zero
    /* F15A0 80100DA0 9000B6AF */  sw         $s6, 0x90($sp)
    /* F15A4 80100DA4 21B0A000 */  addu       $s6, $a1, $zero
    /* F15A8 80100DA8 8000B2AF */  sw         $s2, 0x80($sp)
    /* F15AC 80100DAC 21900000 */  addu       $s2, $zero, $zero
    /* F15B0 80100DB0 9400BFAF */  sw         $ra, 0x94($sp)
    /* F15B4 80100DB4 8800B4AF */  sw         $s4, 0x88($sp)
    /* F15B8 80100DB8 8400B3AF */  sw         $s3, 0x84($sp)
    /* F15BC 80100DBC 7C00B1AF */  sw         $s1, 0x7C($sp)
    /* F15C0 80100DC0 7800B0AF */  sw         $s0, 0x78($sp)
    /* F15C4 80100DC4 0600B392 */  lbu        $s3, 0x6($s5)
    /* F15C8 80100DC8 00000000 */  nop
    /* F15CC 80100DCC 10006012 */  beqz       $s3, .L80100E10
    /* F15D0 80100DD0 21804002 */   addu      $s0, $s2, $zero
    /* F15D4 80100DD4 1000B127 */  addiu      $s1, $sp, 0x10
    /* F15D8 80100DD8 2120A002 */  addu       $a0, $s5, $zero
  .L80100DDC:
    /* F15DC 80100DDC 0C00A526 */  addiu      $a1, $s5, 0xC
    /* F15E0 80100DE0 D801040C */  jal        func_80100760
    /* F15E4 80100DE4 21300002 */   addu      $a2, $s0, $zero
    /* F15E8 80100DE8 21204000 */  addu       $a0, $v0, $zero
    /* F15EC 80100DEC 00008390 */  lbu        $v1, 0x0($a0)
    /* F15F0 80100DF0 21103002 */  addu       $v0, $s1, $s0
    /* F15F4 80100DF4 000043A0 */  sb         $v1, 0x0($v0)
    /* F15F8 80100DF8 00008290 */  lbu        $v0, 0x0($a0)
    /* F15FC 80100DFC 01001026 */  addiu      $s0, $s0, 0x1
    /* F1600 80100E00 21904202 */  addu       $s2, $s2, $v0
    /* F1604 80100E04 2A101302 */  slt        $v0, $s0, $s3
    /* F1608 80100E08 F4FF4014 */  bnez       $v0, .L80100DDC
    /* F160C 80100E0C 2120A002 */   addu      $a0, $s5, $zero
  .L80100E10:
    /* F1610 80100E10 1900401A */  blez       $s2, .L80100E78
    /* F1614 80100E14 21880000 */   addu      $s1, $zero, $zero
    /* F1618 80100E18 1000B427 */  addiu      $s4, $sp, 0x10
  .L80100E1C:
    /* F161C 80100E1C CCAE030C */  jal        iSPCH_Rand
    /* F1620 80100E20 21204002 */   addu      $a0, $s2, $zero
    /* F1624 80100E24 21184000 */  addu       $v1, $v0, $zero
    /* F1628 80100E28 0B006012 */  beqz       $s3, .L80100E58
    /* F162C 80100E2C 21800000 */   addu      $s0, $zero, $zero
    /* F1630 80100E30 21109002 */  addu       $v0, $s4, $s0
  .L80100E34:
    /* F1634 80100E34 00004290 */  lbu        $v0, 0x0($v0)
    /* F1638 80100E38 00000000 */  nop
    /* F163C 80100E3C 23186200 */  subu       $v1, $v1, $v0
    /* F1640 80100E40 06006004 */  bltz       $v1, .L80100E5C
    /* F1644 80100E44 2110D102 */   addu      $v0, $s6, $s1
    /* F1648 80100E48 01001026 */  addiu      $s0, $s0, 0x1
    /* F164C 80100E4C 2A101302 */  slt        $v0, $s0, $s3
    /* F1650 80100E50 F8FF4014 */  bnez       $v0, .L80100E34
    /* F1654 80100E54 21109002 */   addu      $v0, $s4, $s0
  .L80100E58:
    /* F1658 80100E58 2110D102 */  addu       $v0, $s6, $s1
  .L80100E5C:
    /* F165C 80100E5C 000050A0 */  sb         $s0, 0x0($v0)
    /* F1660 80100E60 21109002 */  addu       $v0, $s4, $s0
    /* F1664 80100E64 00004390 */  lbu        $v1, 0x0($v0)
    /* F1668 80100E68 01003126 */  addiu      $s1, $s1, 0x1
    /* F166C 80100E6C 23904302 */  subu       $s2, $s2, $v1
    /* F1670 80100E70 EAFF401E */  bgtz       $s2, .L80100E1C
    /* F1674 80100E74 000040A0 */   sb        $zero, 0x0($v0)
  .L80100E78:
    /* F1678 80100E78 0F006012 */  beqz       $s3, .L80100EB8
    /* F167C 80100E7C 21800000 */   addu      $s0, $zero, $zero
    /* F1680 80100E80 2120A002 */  addu       $a0, $s5, $zero
  .L80100E84:
    /* F1684 80100E84 0C00A526 */  addiu      $a1, $s5, 0xC
    /* F1688 80100E88 D801040C */  jal        func_80100760
    /* F168C 80100E8C 21300002 */   addu      $a2, $s0, $zero
    /* F1690 80100E90 00004290 */  lbu        $v0, 0x0($v0)
    /* F1694 80100E94 00000000 */  nop
    /* F1698 80100E98 03004014 */  bnez       $v0, .L80100EA8
    /* F169C 80100E9C 2110D102 */   addu      $v0, $s6, $s1
    /* F16A0 80100EA0 000050A0 */  sb         $s0, 0x0($v0)
    /* F16A4 80100EA4 01003126 */  addiu      $s1, $s1, 0x1
  .L80100EA8:
    /* F16A8 80100EA8 01001026 */  addiu      $s0, $s0, 0x1
    /* F16AC 80100EAC 2A101302 */  slt        $v0, $s0, $s3
    /* F16B0 80100EB0 F4FF4014 */  bnez       $v0, .L80100E84
    /* F16B4 80100EB4 2120A002 */   addu      $a0, $s5, $zero
  .L80100EB8:
    /* F16B8 80100EB8 9400BF8F */  lw         $ra, 0x94($sp)
    /* F16BC 80100EBC 9000B68F */  lw         $s6, 0x90($sp)
    /* F16C0 80100EC0 8C00B58F */  lw         $s5, 0x8C($sp)
    /* F16C4 80100EC4 8800B48F */  lw         $s4, 0x88($sp)
    /* F16C8 80100EC8 8400B38F */  lw         $s3, 0x84($sp)
    /* F16CC 80100ECC 8000B28F */  lw         $s2, 0x80($sp)
    /* F16D0 80100ED0 7C00B18F */  lw         $s1, 0x7C($sp)
    /* F16D4 80100ED4 7800B08F */  lw         $s0, 0x78($sp)
    /* F16D8 80100ED8 0800E003 */  jr         $ra
    /* F16DC 80100EDC 9800BD27 */   addiu     $sp, $sp, 0x98
endlabel iSPCH_OrderSentences
