.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache, 0x80

glabel DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
    /* B7638 800C6E38 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* B763C 800C6E3C 1800B2AF */  sw         $s2, 0x18($sp)
    /* B7640 800C6E40 21908000 */  addu       $s2, $a0, $zero
    /* B7644 800C6E44 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B7648 800C6E48 2000BFAF */  sw         $ra, 0x20($sp)
    /* B764C 800C6E4C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* B7650 800C6E50 1400B1AF */  sw         $s1, 0x14($sp)
    /* B7654 800C6E54 1000B0AF */  sw         $s0, 0x10($sp)
    /* B7658 800C6E58 E7005092 */  lbu        $s0, 0xE7($s2)
    /* B765C 800C6E5C E800518E */  lw         $s1, 0xE8($s2)
    /* B7660 800C6E60 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* B7664 800C6E64 0D000212 */  beq        $s0, $v0, .L800C6E9C
    /* B7668 800C6E68 21984000 */   addu      $s3, $v0, $zero
  .L800C6E6C:
    /* B766C 800C6E6C 0400428E */  lw         $v0, 0x4($s2)
    /* B7670 800C6E70 0800438E */  lw         $v1, 0x8($s2)
    /* B7674 800C6E74 00000000 */  nop
    /* B7678 800C6E78 2B104300 */  sltu       $v0, $v0, $v1
    /* B767C 800C6E7C 04004010 */  beqz       $v0, .L800C6E90
    /* B7680 800C6E80 21204002 */   addu      $a0, $s2, $zero
    /* B7684 800C6E84 3E19030C */  jal        DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad
    /* B7688 800C6E88 21282002 */   addu      $a1, $s1, $zero
    /* B768C 800C6E8C 06003126 */  addiu      $s1, $s1, 0x6
  .L800C6E90:
    /* B7690 800C6E90 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* B7694 800C6E94 F5FF1316 */  bne        $s0, $s3, .L800C6E6C
    /* B7698 800C6E98 00000000 */   nop
  .L800C6E9C:
    /* B769C 800C6E9C 2000BF8F */  lw         $ra, 0x20($sp)
    /* B76A0 800C6EA0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* B76A4 800C6EA4 1800B28F */  lw         $s2, 0x18($sp)
    /* B76A8 800C6EA8 1400B18F */  lw         $s1, 0x14($sp)
    /* B76AC 800C6EAC 1000B08F */  lw         $s0, 0x10($sp)
    /* B76B0 800C6EB0 0800E003 */  jr         $ra
    /* B76B4 800C6EB4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
