.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_SearchEventDat, 0x88

glabel iSPCH_SearchEventDat
    /* D76C4 800E6EC4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D76C8 800E6EC8 1800B2AF */  sw         $s2, 0x18($sp)
    /* D76CC 800E6ECC 21908000 */  addu       $s2, $a0, $zero
    /* D76D0 800E6ED0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D76D4 800E6ED4 2198A000 */  addu       $s3, $a1, $zero
    /* D76D8 800E6ED8 2000BFAF */  sw         $ra, 0x20($sp)
    /* D76DC 800E6EDC 1400B1AF */  sw         $s1, 0x14($sp)
    /* D76E0 800E6EE0 1000B0AF */  sw         $s0, 0x10($sp)
    /* D76E4 800E6EE4 02005196 */  lhu        $s1, 0x2($s2)
    /* D76E8 800E6EE8 00000000 */  nop
    /* D76EC 800E6EEC 0F002012 */  beqz       $s1, .L800E6F2C
    /* D76F0 800E6EF0 21800000 */   addu      $s0, $zero, $zero
    /* D76F4 800E6EF4 21204002 */  addu       $a0, $s2, $zero
  .L800E6EF8:
    /* D76F8 800E6EF8 0C004526 */  addiu      $a1, $s2, 0xC
    /* D76FC 800E6EFC AA9B030C */  jal        func_800E6EA8
    /* D7700 800E6F00 21300002 */   addu      $a2, $s0, $zero
    /* D7704 800E6F04 21184000 */  addu       $v1, $v0, $zero
    /* D7708 800E6F08 00006294 */  lhu        $v0, 0x0($v1)
    /* D770C 800E6F0C 00000000 */  nop
    /* D7710 800E6F10 03005314 */  bne        $v0, $s3, .L800E6F20
    /* D7714 800E6F14 01001026 */   addiu     $s0, $s0, 0x1
    /* D7718 800E6F18 CC9B0308 */  j          .L800E6F30
    /* D771C 800E6F1C 21106000 */   addu      $v0, $v1, $zero
  .L800E6F20:
    /* D7720 800E6F20 2A101102 */  slt        $v0, $s0, $s1
    /* D7724 800E6F24 F4FF4014 */  bnez       $v0, .L800E6EF8
    /* D7728 800E6F28 21204002 */   addu      $a0, $s2, $zero
  .L800E6F2C:
    /* D772C 800E6F2C 21100000 */  addu       $v0, $zero, $zero
  .L800E6F30:
    /* D7730 800E6F30 2000BF8F */  lw         $ra, 0x20($sp)
    /* D7734 800E6F34 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D7738 800E6F38 1800B28F */  lw         $s2, 0x18($sp)
    /* D773C 800E6F3C 1400B18F */  lw         $s1, 0x14($sp)
    /* D7740 800E6F40 1000B08F */  lw         $s0, 0x10($sp)
    /* D7744 800E6F44 0800E003 */  jr         $ra
    /* D7748 800E6F48 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSPCH_SearchEventDat
