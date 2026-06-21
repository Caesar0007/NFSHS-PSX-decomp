.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Decrement__18tListIteratorTrack7tPlayer, 0x90

glabel Decrement__18tListIteratorTrack7tPlayer
    /* 126C0 80021EC0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 126C4 80021EC4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 126C8 80021EC8 21808000 */  addu       $s0, $a0, $zero
    /* 126CC 80021ECC 1400BFAF */  sw         $ra, 0x14($sp)
  .L80021ED0:
    /* 126D0 80021ED0 1000028E */  lw         $v0, 0x10($s0)
    /* 126D4 80021ED4 00000000 */  nop
    /* 126D8 80021ED8 00004390 */  lbu        $v1, 0x0($v0)
    /* 126DC 80021EDC 0400028E */  lw         $v0, 0x4($s0)
    /* 126E0 80021EE0 00000000 */  nop
    /* 126E4 80021EE4 21184300 */  addu       $v1, $v0, $v1
    /* 126E8 80021EE8 00006290 */  lbu        $v0, 0x0($v1)
    /* 126EC 80021EEC 00000000 */  nop
    /* 126F0 80021EF0 06004014 */  bnez       $v0, .L80021F0C
    /* 126F4 80021EF4 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* 126F8 80021EF8 1400028E */  lw         $v0, 0x14($s0)
    /* 126FC 80021EFC 00000000 */  nop
    /* 12700 80021F00 00004290 */  lbu        $v0, 0x0($v0)
    /* 12704 80021F04 00000000 */  nop
    /* 12708 80021F08 FFFF4224 */  addiu      $v0, $v0, -0x1
  .L80021F0C:
    /* 1270C 80021F0C 000062A0 */  sb         $v0, 0x0($v1)
    /* 12710 80021F10 1000028E */  lw         $v0, 0x10($s0)
    /* 12714 80021F14 00000000 */  nop
    /* 12718 80021F18 00004390 */  lbu        $v1, 0x0($v0)
    /* 1271C 80021F1C 0400028E */  lw         $v0, 0x4($s0)
    /* 12720 80021F20 00000000 */  nop
    /* 12724 80021F24 21104300 */  addu       $v0, $v0, $v1
    /* 12728 80021F28 00004590 */  lbu        $a1, 0x0($v0)
    /* 1272C 80021F2C D487000C */  jal        ValidTrack__18tListIteratorTrackc
    /* 12730 80021F30 21200002 */   addu      $a0, $s0, $zero
    /* 12734 80021F34 01004238 */  xori       $v0, $v0, 0x1
    /* 12738 80021F38 E5FF4014 */  bnez       $v0, .L80021ED0
    /* 1273C 80021F3C 00000000 */   nop
    /* 12740 80021F40 1400BF8F */  lw         $ra, 0x14($sp)
    /* 12744 80021F44 1000B08F */  lw         $s0, 0x10($sp)
    /* 12748 80021F48 0800E003 */  jr         $ra
    /* 1274C 80021F4C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Decrement__18tListIteratorTrack7tPlayer
