.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpatchtohdr, 0x150

glabel iSNDpatchtohdr
    /* F3DE4 801035E4 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* F3DE8 801035E8 2000B0AF */  sw         $s0, 0x20($sp)
    /* F3DEC 801035EC 21808000 */  addu       $s0, $a0, $zero
    /* F3DF0 801035F0 2800B2AF */  sw         $s2, 0x28($sp)
    /* F3DF4 801035F4 2190A000 */  addu       $s2, $a1, $zero
    /* F3DF8 801035F8 2400B1AF */  sw         $s1, 0x24($sp)
    /* F3DFC 801035FC 2188C000 */  addu       $s1, $a2, $zero
    /* F3E00 80103600 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* F3E04 80103604 2198E000 */  addu       $s3, $a3, $zero
    /* F3E08 80103608 3000BFAF */  sw         $ra, 0x30($sp)
    /* F3E0C 8010360C 6C0D040C */  jal        SNDattributessetdef
    /* F3E10 80103610 21202002 */   addu      $a0, $s1, $zero
    /* F3E14 80103614 1000B0AF */  sw         $s0, 0x10($sp)
    /* F3E18 80103618 03000292 */  lbu        $v0, 0x3($s0)
    /* F3E1C 8010361C 00000000 */  nop
    /* F3E20 80103620 02004230 */  andi       $v0, $v0, 0x2
    /* F3E24 80103624 02004014 */  bnez       $v0, .L80103630
    /* F3E28 80103628 08000226 */   addiu     $v0, $s0, 0x8
    /* F3E2C 8010362C 04000226 */  addiu      $v0, $s0, 0x4
  .L80103630:
    /* F3E30 80103630 1000A2AF */  sw         $v0, 0x10($sp)
    /* F3E34 80103634 22560224 */  addiu      $v0, $zero, 0x5622
    /* F3E38 80103638 000042A6 */  sh         $v0, 0x0($s2)
    /* F3E3C 8010363C 01000224 */  addiu      $v0, $zero, 0x1
    /* F3E40 80103640 020042A2 */  sb         $v0, 0x2($s2)
    /* F3E44 80103644 05000224 */  addiu      $v0, $zero, 0x5
    /* F3E48 80103648 030042A2 */  sb         $v0, 0x3($s2)
    /* F3E4C 8010364C 000060AE */  sw         $zero, 0x0($s3)
  .L80103650:
    /* F3E50 80103650 1000A427 */  addiu      $a0, $sp, 0x10
  .L80103654:
    /* F3E54 80103654 1400A527 */  addiu      $a1, $sp, 0x14
    /* F3E58 80103658 1800A627 */  addiu      $a2, $sp, 0x18
    /* F3E5C 8010365C 542F040C */  jal        iSNDgettag
    /* F3E60 80103660 1C00A727 */   addiu     $a3, $sp, 0x1C
    /* F3E64 80103664 2B004010 */  beqz       $v0, .L80103714
    /* F3E68 80103668 80000224 */   addiu     $v0, $zero, 0x80
    /* F3E6C 8010366C 1400A38F */  lw         $v1, 0x14($sp)
    /* F3E70 80103670 00000000 */  nop
    /* F3E74 80103674 04006214 */  bne        $v1, $v0, .L80103688
    /* F3E78 80103678 82000224 */   addiu     $v0, $zero, 0x82
    /* F3E7C 8010367C 1800A293 */  lbu        $v0, 0x18($sp)
    /* F3E80 80103680 940D0408 */  j          .L80103650
    /* F3E84 80103684 0B0022A2 */   sb        $v0, 0xB($s1)
  .L80103688:
    /* F3E88 80103688 04006214 */  bne        $v1, $v0, .L8010369C
    /* F3E8C 8010368C 84000224 */   addiu     $v0, $zero, 0x84
    /* F3E90 80103690 1800A293 */  lbu        $v0, 0x18($sp)
    /* F3E94 80103694 940D0408 */  j          .L80103650
    /* F3E98 80103698 020042A2 */   sb        $v0, 0x2($s2)
  .L8010369C:
    /* F3E9C 8010369C 04006214 */  bne        $v1, $v0, .L801036B0
    /* F3EA0 801036A0 85000224 */   addiu     $v0, $zero, 0x85
    /* F3EA4 801036A4 1800A297 */  lhu        $v0, 0x18($sp)
    /* F3EA8 801036A8 940D0408 */  j          .L80103650
    /* F3EAC 801036AC 000042A6 */   sh        $v0, 0x0($s2)
  .L801036B0:
    /* F3EB0 801036B0 04006214 */  bne        $v1, $v0, .L801036C4
    /* F3EB4 801036B4 13000224 */   addiu     $v0, $zero, 0x13
    /* F3EB8 801036B8 1800A28F */  lw         $v0, 0x18($sp)
    /* F3EBC 801036BC 940D0408 */  j          .L80103650
    /* F3EC0 801036C0 000062AE */   sw        $v0, 0x0($s3)
  .L801036C4:
    /* F3EC4 801036C4 04006214 */  bne        $v1, $v0, .L801036D8
    /* F3EC8 801036C8 0A000224 */   addiu     $v0, $zero, 0xA
    /* F3ECC 801036CC 1800A293 */  lbu        $v0, 0x18($sp)
    /* F3ED0 801036D0 940D0408 */  j          .L80103650
    /* F3ED4 801036D4 090022A2 */   sb        $v0, 0x9($s1)
  .L801036D8:
    /* F3ED8 801036D8 04006214 */  bne        $v1, $v0, .L801036EC
    /* F3EDC 801036DC 05000224 */   addiu     $v0, $zero, 0x5
    /* F3EE0 801036E0 1800A293 */  lbu        $v0, 0x18($sp)
    /* F3EE4 801036E4 940D0408 */  j          .L80103650
    /* F3EE8 801036E8 0A0022A2 */   sb        $v0, 0xA($s1)
  .L801036EC:
    /* F3EEC 801036EC 04006214 */  bne        $v1, $v0, .L80103700
    /* F3EF0 801036F0 06000224 */   addiu     $v0, $zero, 0x6
    /* F3EF4 801036F4 1800A28F */  lw         $v0, 0x18($sp)
    /* F3EF8 801036F8 940D0408 */  j          .L80103650
    /* F3EFC 801036FC 000022AE */   sw        $v0, 0x0($s1)
  .L80103700:
    /* F3F00 80103700 D4FF6214 */  bne        $v1, $v0, .L80103654
    /* F3F04 80103704 1000A427 */   addiu     $a0, $sp, 0x10
    /* F3F08 80103708 1800A293 */  lbu        $v0, 0x18($sp)
    /* F3F0C 8010370C 950D0408 */  j          .L80103654
    /* F3F10 80103710 060022A2 */   sb        $v0, 0x6($s1)
  .L80103714:
    /* F3F14 80103714 3000BF8F */  lw         $ra, 0x30($sp)
    /* F3F18 80103718 2C00B38F */  lw         $s3, 0x2C($sp)
    /* F3F1C 8010371C 2800B28F */  lw         $s2, 0x28($sp)
    /* F3F20 80103720 2400B18F */  lw         $s1, 0x24($sp)
    /* F3F24 80103724 2000B08F */  lw         $s0, 0x20($sp)
    /* F3F28 80103728 21100000 */  addu       $v0, $zero, $zero
    /* F3F2C 8010372C 0800E003 */  jr         $ra
    /* F3F30 80103730 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iSNDpatchtohdr
