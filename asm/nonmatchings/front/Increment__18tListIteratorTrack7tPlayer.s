.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Increment__18tListIteratorTrack7tPlayer, 0xAC

glabel Increment__18tListIteratorTrack7tPlayer
    /* 12614 80021E14 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 12618 80021E18 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1261C 80021E1C 21808000 */  addu       $s0, $a0, $zero
    /* 12620 80021E20 1400BFAF */  sw         $ra, 0x14($sp)
  .L80021E24:
    /* 12624 80021E24 1000028E */  lw         $v0, 0x10($s0)
    /* 12628 80021E28 0400038E */  lw         $v1, 0x4($s0)
    /* 1262C 80021E2C 00004290 */  lbu        $v0, 0x0($v0)
    /* 12630 80021E30 00000000 */  nop
    /* 12634 80021E34 21186200 */  addu       $v1, $v1, $v0
    /* 12638 80021E38 00006290 */  lbu        $v0, 0x0($v1)
    /* 1263C 80021E3C 00000000 */  nop
    /* 12640 80021E40 01004224 */  addiu      $v0, $v0, 0x1
    /* 12644 80021E44 000062A0 */  sb         $v0, 0x0($v1)
    /* 12648 80021E48 1000028E */  lw         $v0, 0x10($s0)
    /* 1264C 80021E4C 00000000 */  nop
    /* 12650 80021E50 00004390 */  lbu        $v1, 0x0($v0)
    /* 12654 80021E54 0400028E */  lw         $v0, 0x4($s0)
    /* 12658 80021E58 00000000 */  nop
    /* 1265C 80021E5C 21204300 */  addu       $a0, $v0, $v1
    /* 12660 80021E60 1400038E */  lw         $v1, 0x14($s0)
    /* 12664 80021E64 00008290 */  lbu        $v0, 0x0($a0)
    /* 12668 80021E68 0000638C */  lw         $v1, 0x0($v1)
    /* 1266C 80021E6C 00000000 */  nop
    /* 12670 80021E70 2B104300 */  sltu       $v0, $v0, $v1
    /* 12674 80021E74 02004014 */  bnez       $v0, .L80021E80
    /* 12678 80021E78 00000000 */   nop
    /* 1267C 80021E7C 000080A0 */  sb         $zero, 0x0($a0)
  .L80021E80:
    /* 12680 80021E80 1000028E */  lw         $v0, 0x10($s0)
    /* 12684 80021E84 00000000 */  nop
    /* 12688 80021E88 00004390 */  lbu        $v1, 0x0($v0)
    /* 1268C 80021E8C 0400028E */  lw         $v0, 0x4($s0)
    /* 12690 80021E90 00000000 */  nop
    /* 12694 80021E94 21104300 */  addu       $v0, $v0, $v1
    /* 12698 80021E98 00004590 */  lbu        $a1, 0x0($v0)
    /* 1269C 80021E9C D487000C */  jal        ValidTrack__18tListIteratorTrackc
    /* 126A0 80021EA0 21200002 */   addu      $a0, $s0, $zero
    /* 126A4 80021EA4 01004238 */  xori       $v0, $v0, 0x1
    /* 126A8 80021EA8 DEFF4014 */  bnez       $v0, .L80021E24
    /* 126AC 80021EAC 00000000 */   nop
    /* 126B0 80021EB0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 126B4 80021EB4 1000B08F */  lw         $s0, 0x10($sp)
    /* 126B8 80021EB8 0800E003 */  jr         $ra
    /* 126BC 80021EBC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Increment__18tListIteratorTrack7tPlayer
