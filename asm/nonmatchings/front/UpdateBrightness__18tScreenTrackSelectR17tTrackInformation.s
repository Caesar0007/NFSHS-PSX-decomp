.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateBrightness__18tScreenTrackSelectR17tTrackInformation, 0xF0

glabel UpdateBrightness__18tScreenTrackSelectR17tTrackInformation
    /* 32598 80041D98 1480023C */  lui        $v0, %hi(ticks)
    /* 3259C 80041D9C ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 325A0 80041DA0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 325A4 80041DA4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 325A8 80041DA8 21808000 */  addu       $s0, $a0, $zero
    /* 325AC 80041DAC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 325B0 80041DB0 2188A000 */  addu       $s1, $a1, $zero
    /* 325B4 80041DB4 1800BFAF */  sw         $ra, 0x18($sp)
    /* 325B8 80041DB8 7800028E */  lw         $v0, 0x78($s0)
    /* 325BC 80041DBC 72000586 */  lh         $a1, 0x72($s0)
    /* 325C0 80041DC0 23186200 */  subu       $v1, $v1, $v0
    /* 325C4 80041DC4 70000286 */  lh         $v0, 0x70($s0)
    /* 325C8 80041DC8 72000496 */  lhu        $a0, 0x72($s0)
    /* 325CC 80041DCC 1500A210 */  beq        $a1, $v0, .L80041E24
    /* 325D0 80041DD0 80006228 */   slti      $v0, $v1, 0x80
    /* 325D4 80041DD4 03004014 */  bnez       $v0, .L80041DE4
    /* 325D8 80041DD8 00000000 */   nop
    /* 325DC 80041DDC 89070108 */  j          .L80041E24
    /* 325E0 80041DE0 700004A6 */   sh        $a0, 0x70($s0)
  .L80041DE4:
    /* 325E4 80041DE4 0E006004 */  bltz       $v1, .L80041E20
    /* 325E8 80041DE8 00000000 */   nop
    /* 325EC 80041DEC 74000286 */  lh         $v0, 0x74($s0)
    /* 325F0 80041DF0 00000000 */  nop
    /* 325F4 80041DF4 2310A200 */  subu       $v0, $a1, $v0
    /* 325F8 80041DF8 18004300 */  mult       $v0, $v1
    /* 325FC 80041DFC 74000396 */  lhu        $v1, 0x74($s0)
    /* 32600 80041E00 12100000 */  mflo       $v0
    /* 32604 80041E04 02004104 */  bgez       $v0, .L80041E10
    /* 32608 80041E08 00000000 */   nop
    /* 3260C 80041E0C 7F004224 */  addiu      $v0, $v0, 0x7F
  .L80041E10:
    /* 32610 80041E10 C3110200 */  sra        $v0, $v0, 7
    /* 32614 80041E14 21106200 */  addu       $v0, $v1, $v0
    /* 32618 80041E18 89070108 */  j          .L80041E24
    /* 3261C 80041E1C 700002A6 */   sh        $v0, 0x70($s0)
  .L80041E20:
    /* 32620 80041E20 700000A6 */  sh         $zero, 0x70($s0)
  .L80041E24:
    /* 32624 80041E24 7000028E */  lw         $v0, 0x70($s0)
    /* 32628 80041E28 00000000 */  nop
    /* 3262C 80041E2C 11004014 */  bnez       $v0, .L80041E74
    /* 32630 80041E30 00000000 */   nop
    /* 32634 80041E34 6400048E */  lw         $a0, 0x64($s0)
    /* 32638 80041E38 D543010C */  jal        VIDEO_abortplayback__Fi
    /* 3263C 80041E3C 00000000 */   nop
    /* 32640 80041E40 7C00028E */  lw         $v0, 0x7C($s0)
    /* 32644 80041E44 00000000 */  nop
    /* 32648 80041E48 0A004014 */  bnez       $v0, .L80041E74
    /* 3264C 80041E4C 1480023C */   lui       $v0, %hi(ticks)
    /* 32650 80041E50 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 32654 80041E54 01000224 */  addiu      $v0, $zero, 0x1
    /* 32658 80041E58 7C0002AE */  sw         $v0, 0x7C($s0)
    /* 3265C 80041E5C 9C0203AE */  sw         $v1, 0x29C($s0)
    /* 32660 80041E60 00002292 */  lbu        $v0, 0x0($s1)
    /* 32664 80041E64 00000000 */  nop
    /* 32668 80041E68 00160200 */  sll        $v0, $v0, 24
    /* 3266C 80041E6C 03160200 */  sra        $v0, $v0, 24
    /* 32670 80041E70 6E0002A6 */  sh         $v0, 0x6E($s0)
  .L80041E74:
    /* 32674 80041E74 1800BF8F */  lw         $ra, 0x18($sp)
    /* 32678 80041E78 1400B18F */  lw         $s1, 0x14($sp)
    /* 3267C 80041E7C 1000B08F */  lw         $s0, 0x10($sp)
    /* 32680 80041E80 0800E003 */  jr         $ra
    /* 32684 80041E84 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateBrightness__18tScreenTrackSelectR17tTrackInformation
