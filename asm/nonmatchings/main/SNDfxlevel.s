.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDfxlevel, 0x128

glabel SNDfxlevel
    /* F0DE8 801005E8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* F0DEC 801005EC 1800B0AF */  sw         $s0, 0x18($sp)
    /* F0DF0 801005F0 21808000 */  addu       $s0, $a0, $zero
    /* F0DF4 801005F4 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* F0DF8 801005F8 2188A000 */  addu       $s1, $a1, $zero
    /* F0DFC 801005FC 1480023C */  lui        $v0, %hi(sndgs)
    /* F0E00 80100600 2000B2AF */  sw         $s2, 0x20($sp)
    /* F0E04 80100604 60785224 */  addiu      $s2, $v0, %lo(sndgs)
    /* F0E08 80100608 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* F0E0C 8010060C 2800B4AF */  sw         $s4, 0x28($sp)
    /* F0E10 80100610 2400B3AF */  sw         $s3, 0x24($sp)
    /* F0E14 80100614 3C004282 */  lb         $v0, 0x3C($s2)
    /* F0E18 80100618 00000000 */  nop
    /* F0E1C 8010061C 03004014 */  bnez       $v0, .L8010062C
    /* F0E20 80100620 2198C000 */   addu      $s3, $a2, $zero
    /* F0E24 80100624 BC010408 */  j          .L801006F0
    /* F0E28 80100628 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L8010062C:
    /* F0E2C 8010062C 4DA9030C */  jal        iSNDenteraudio
    /* F0E30 80100630 00000000 */   nop
    /* F0E34 80100634 71FB030C */  jal        iSNDgetchan
    /* F0E38 80100638 21200002 */   addu      $a0, $s0, $zero
    /* F0E3C 8010063C 21804000 */  addu       $s0, $v0, $zero
    /* F0E40 80100640 28000006 */  bltz       $s0, .L801006E4
    /* F0E44 80100644 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* F0E48 80100648 1000A2AF */  sw         $v0, 0x10($sp)
    /* F0E4C 8010064C 00111100 */  sll        $v0, $s1, 4
    /* F0E50 80100650 21A05200 */  addu       $s4, $v0, $s2
    /* F0E54 80100654 21200002 */  addu       $a0, $s0, $zero
  .L80100658:
    /* F0E58 80100658 D3FB030C */  jal        iSNDpatchkey
    /* F0E5C 8010065C 1000A527 */   addiu     $a1, $sp, 0x10
    /* F0E60 80100660 20004010 */  beqz       $v0, .L801006E4
    /* F0E64 80100664 21282002 */   addu      $a1, $s1, $zero
    /* F0E68 80100668 1000A38F */  lw         $v1, 0x10($sp)
    /* F0E6C 8010066C 00000000 */  nop
    /* F0E70 80100670 40100300 */  sll        $v0, $v1, 1
    /* F0E74 80100674 21104300 */  addu       $v0, $v0, $v1
    /* F0E78 80100678 C0100200 */  sll        $v0, $v0, 3
    /* F0E7C 8010067C 21104300 */  addu       $v0, $v0, $v1
    /* F0E80 80100680 9400438E */  lw         $v1, 0x94($s2)
    /* F0E84 80100684 80100200 */  sll        $v0, $v0, 2
    /* F0E88 80100688 21186200 */  addu       $v1, $v1, $v0
    /* F0E8C 8010068C 21187100 */  addu       $v1, $v1, $s1
    /* F0E90 80100690 34006280 */  lb         $v0, 0x34($v1)
    /* F0E94 80100694 00000000 */  nop
    /* F0E98 80100698 18006202 */  mult       $s3, $v0
    /* F0E9C 8010069C 350073A0 */  sb         $s3, 0x35($v1)
    /* F0EA0 801006A0 12400000 */  mflo       $t0
    /* F0EA4 801006A4 A000828E */  lw         $v0, 0xA0($s4)
    /* F0EA8 801006A8 00000000 */  nop
    /* F0EAC 801006AC 18000201 */  mult       $t0, $v0
    /* F0EB0 801006B0 12100000 */  mflo       $v0
    /* F0EB4 801006B4 0682033C */  lui        $v1, (0x82061029 >> 16)
    /* F0EB8 801006B8 29106334 */  ori        $v1, $v1, (0x82061029 & 0xFFFF)
    /* F0EBC 801006BC 18004300 */  mult       $v0, $v1
    /* F0EC0 801006C0 1000A48F */  lw         $a0, 0x10($sp)
    /* F0EC4 801006C4 10180000 */  mfhi       $v1
    /* F0EC8 801006C8 21306200 */  addu       $a2, $v1, $v0
    /* F0ECC 801006CC 43330600 */  sra        $a2, $a2, 13
    /* F0ED0 801006D0 C3170200 */  sra        $v0, $v0, 31
    /* F0ED4 801006D4 1600040C */  jal        iSNDplatformfxlevel
    /* F0ED8 801006D8 2330C200 */   subu      $a2, $a2, $v0
    /* F0EDC 801006DC 96010408 */  j          .L80100658
    /* F0EE0 801006E0 21200002 */   addu      $a0, $s0, $zero
  .L801006E4:
    /* F0EE4 801006E4 5BA9030C */  jal        iSNDleaveaudio
    /* F0EE8 801006E8 00000000 */   nop
    /* F0EEC 801006EC 21100002 */  addu       $v0, $s0, $zero
  .L801006F0:
    /* F0EF0 801006F0 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* F0EF4 801006F4 2800B48F */  lw         $s4, 0x28($sp)
    /* F0EF8 801006F8 2400B38F */  lw         $s3, 0x24($sp)
    /* F0EFC 801006FC 2000B28F */  lw         $s2, 0x20($sp)
    /* F0F00 80100700 1C00B18F */  lw         $s1, 0x1C($sp)
    /* F0F04 80100704 1800B08F */  lw         $s0, 0x18($sp)
    /* F0F08 80100708 0800E003 */  jr         $ra
    /* F0F0C 8010070C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel SNDfxlevel
