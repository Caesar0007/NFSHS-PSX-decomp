.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MCRD_loadfile, 0xEC

glabel MCRD_loadfile
    /* 3FEB8 8004F6B8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 3FEBC 8004F6BC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 3FEC0 8004F6C0 21908000 */  addu       $s2, $a0, $zero
    /* 3FEC4 8004F6C4 2000B4AF */  sw         $s4, 0x20($sp)
    /* 3FEC8 8004F6C8 21A0A000 */  addu       $s4, $a1, $zero
    /* 3FECC 8004F6CC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3FED0 8004F6D0 2188C000 */  addu       $s1, $a2, $zero
    /* 3FED4 8004F6D4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3FED8 8004F6D8 0580103C */  lui        $s0, %hi(D_80052FC8)
    /* 3FEDC 8004F6DC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 3FEE0 8004F6E0 C82F1326 */  addiu      $s3, $s0, %lo(D_80052FC8)
    /* 3FEE4 8004F6E4 21206002 */  addu       $a0, $s3, $zero
    /* 3FEE8 8004F6E8 2400BFAF */  sw         $ra, 0x24($sp)
    /* 3FEEC 8004F6EC E8C5030C */  jal        blockclear
    /* 3FEF0 8004F6F0 3C020524 */   addiu     $a1, $zero, 0x23C
    /* 3FEF4 8004F6F4 04002016 */  bnez       $s1, .L8004F708
    /* 3FEF8 8004F6F8 C82F12AE */   sw        $s2, %lo(D_80052FC8)($s0)
    /* 3FEFC 8004F6FC 04006426 */  addiu      $a0, $s3, 0x4
    /* 3FF00 8004F700 CA96030C */  jal        strcpy
    /* 3FF04 8004F704 A4FD6526 */   addiu     $a1, $s3, -0x25C
  .L8004F708:
    /* 3FF08 8004F708 0000858E */  lw         $a1, 0x0($s4)
    /* 3FF0C 8004F70C 3A9E030C */  jal        strcat
    /* 3FF10 8004F710 04006426 */   addiu     $a0, $s3, 0x4
    /* 3FF14 8004F714 0400828E */  lw         $v0, 0x4($s4)
    /* 3FF18 8004F718 00000000 */  nop
    /* 3FF1C 8004F71C 1C0062AE */  sw         $v0, 0x1C($s3)
    /* 3FF20 8004F720 0800828E */  lw         $v0, 0x8($s4)
    /* 3FF24 8004F724 00000000 */  nop
    /* 3FF28 8004F728 200062AE */  sw         $v0, 0x20($s3)
    /* 3FF2C 8004F72C 0C00828E */  lw         $v0, 0xC($s4)
    /* 3FF30 8004F730 00000000 */  nop
    /* 3FF34 8004F734 240062AE */  sw         $v0, 0x24($s3)
    /* 3FF38 8004F738 1800828E */  lw         $v0, 0x18($s4)
    /* 3FF3C 8004F73C 00000000 */  nop
    /* 3FF40 8004F740 300262AE */  sw         $v0, 0x230($s3)
    /* 3FF44 8004F744 1C00828E */  lw         $v0, 0x1C($s4)
    /* 3FF48 8004F748 00000000 */  nop
    /* 3FF4C 8004F74C 340262AE */  sw         $v0, 0x234($s3)
    /* 3FF50 8004F750 2000828E */  lw         $v0, 0x20($s4)
    /* 3FF54 8004F754 00000000 */  nop
    /* 3FF58 8004F758 380262AE */  sw         $v0, 0x238($s3)
    /* 3FF5C 8004F75C 1400828E */  lw         $v0, 0x14($s4)
    /* 3FF60 8004F760 A0FD6326 */  addiu      $v1, $s3, -0x260
    /* 3FF64 8004F764 2C0262AE */  sw         $v0, 0x22C($s3)
    /* 3FF68 8004F768 2E006226 */  addiu      $v0, $s3, 0x2E
    /* 3FF6C 8004F76C 240082AE */  sw         $v0, 0x24($s4)
    /* 3FF70 8004F770 2F006226 */  addiu      $v0, $s3, 0x2F
    /* 3FF74 8004F774 280082AE */  sw         $v0, 0x28($s4)
    /* 3FF78 8004F778 03000224 */  addiu      $v0, $zero, 0x3
    /* 3FF7C 8004F77C 300062AC */  sw         $v0, 0x30($v1)
    /* 3FF80 8004F780 340060AC */  sw         $zero, 0x34($v1)
    /* 3FF84 8004F784 2400BF8F */  lw         $ra, 0x24($sp)
    /* 3FF88 8004F788 2000B48F */  lw         $s4, 0x20($sp)
    /* 3FF8C 8004F78C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 3FF90 8004F790 1800B28F */  lw         $s2, 0x18($sp)
    /* 3FF94 8004F794 1400B18F */  lw         $s1, 0x14($sp)
    /* 3FF98 8004F798 1000B08F */  lw         $s0, 0x10($sp)
    /* 3FF9C 8004F79C 0800E003 */  jr         $ra
    /* 3FFA0 8004F7A0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel MCRD_loadfile
