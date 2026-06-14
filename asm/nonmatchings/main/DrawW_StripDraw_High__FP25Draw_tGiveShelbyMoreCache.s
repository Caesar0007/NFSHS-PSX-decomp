.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache, 0xE8

glabel DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache
    /* B76B8 800C6EB8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* B76BC 800C6EBC 2400B3AF */  sw         $s3, 0x24($sp)
    /* B76C0 800C6EC0 21988000 */  addu       $s3, $a0, $zero
    /* B76C4 800C6EC4 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* B76C8 800C6EC8 2800B4AF */  sw         $s4, 0x28($sp)
    /* B76CC 800C6ECC 2000B2AF */  sw         $s2, 0x20($sp)
    /* B76D0 800C6ED0 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* B76D4 800C6ED4 1800B0AF */  sw         $s0, 0x18($sp)
    /* B76D8 800C6ED8 0001718E */  lw         $s1, 0x100($s3)
    /* B76DC 800C6EDC 01000224 */  addiu      $v0, $zero, 0x1
    /* B76E0 800C6EE0 DA0062A6 */  sh         $v0, 0xDA($s3)
  .L800C6EE4:
    /* B76E4 800C6EE4 04016296 */  lhu        $v0, 0x104($s3)
    /* B76E8 800C6EE8 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* B76EC 800C6EEC FFFF4224 */  addiu      $v0, $v0, -0x1
    /* B76F0 800C6EF0 040162A6 */  sh         $v0, 0x104($s3)
    /* B76F4 800C6EF4 00140200 */  sll        $v0, $v0, 16
    /* B76F8 800C6EF8 03140200 */  sra        $v0, $v0, 16
    /* B76FC 800C6EFC 20004310 */  beq        $v0, $v1, .L800C6F80
    /* B7700 800C6F00 21800000 */   addu      $s0, $zero, $zero
    /* B7704 800C6F04 02003492 */  lbu        $s4, 0x2($s1)
    /* B7708 800C6F08 04003226 */  addiu      $s2, $s1, 0x4
  .L800C6F0C:
    /* B770C 800C6F0C 2A101402 */  slt        $v0, $s0, $s4
    /* B7710 800C6F10 18004010 */  beqz       $v0, .L800C6F74
    /* B7714 800C6F14 00000000 */   nop
    /* B7718 800C6F18 0400628E */  lw         $v0, 0x4($s3)
    /* B771C 800C6F1C 0800638E */  lw         $v1, 0x8($s3)
    /* B7720 800C6F20 00000000 */  nop
    /* B7724 800C6F24 2B104300 */  sltu       $v0, $v0, $v1
    /* B7728 800C6F28 0F004010 */  beqz       $v0, .L800C6F68
    /* B772C 800C6F2C 21206002 */   addu      $a0, $s3, $zero
    /* B7730 800C6F30 00004296 */  lhu        $v0, 0x0($s2)
    /* B7734 800C6F34 1000A527 */  addiu      $a1, $sp, 0x10
    /* B7738 800C6F38 1000A2A7 */  sh         $v0, 0x10($sp)
    /* B773C 800C6F3C 00002292 */  lbu        $v0, 0x0($s1)
    /* B7740 800C6F40 01002392 */  lbu        $v1, 0x1($s1)
    /* B7744 800C6F44 21105000 */  addu       $v0, $v0, $s0
    /* B7748 800C6F48 1300A2A3 */  sb         $v0, 0x13($sp)
    /* B774C 800C6F4C 01004224 */  addiu      $v0, $v0, 0x1
    /* B7750 800C6F50 21187000 */  addu       $v1, $v1, $s0
    /* B7754 800C6F54 1400A3A3 */  sb         $v1, 0x14($sp)
    /* B7758 800C6F58 01006324 */  addiu      $v1, $v1, 0x1
    /* B775C 800C6F5C 1200A2A3 */  sb         $v0, 0x12($sp)
    /* B7760 800C6F60 3E19030C */  jal        DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad
    /* B7764 800C6F64 1500A3A3 */   sb        $v1, 0x15($sp)
  .L800C6F68:
    /* B7768 800C6F68 02005226 */  addiu      $s2, $s2, 0x2
    /* B776C 800C6F6C C31B0308 */  j          .L800C6F0C
    /* B7770 800C6F70 01001026 */   addiu     $s0, $s0, 0x1
  .L800C6F74:
    /* B7774 800C6F74 03002292 */  lbu        $v0, 0x3($s1)
    /* B7778 800C6F78 B91B0308 */  j          .L800C6EE4
    /* B777C 800C6F7C 21882202 */   addu      $s1, $s1, $v0
  .L800C6F80:
    /* B7780 800C6F80 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* B7784 800C6F84 2800B48F */  lw         $s4, 0x28($sp)
    /* B7788 800C6F88 2400B38F */  lw         $s3, 0x24($sp)
    /* B778C 800C6F8C 2000B28F */  lw         $s2, 0x20($sp)
    /* B7790 800C6F90 1C00B18F */  lw         $s1, 0x1C($sp)
    /* B7794 800C6F94 1800B08F */  lw         $s0, 0x18($sp)
    /* B7798 800C6F98 0800E003 */  jr         $ra
    /* B779C 800C6F9C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache
