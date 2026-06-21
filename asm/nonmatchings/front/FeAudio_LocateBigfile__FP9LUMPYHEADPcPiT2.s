.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeAudio_LocateBigfile__FP9LUMPYHEADPcPiT2, 0x158

glabel FeAudio_LocateBigfile__FP9LUMPYHEADPcPiT2
    /* 65CC 80015DCC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 65D0 80015DD0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 65D4 80015DD4 21988000 */  addu       $s3, $a0, $zero
    /* 65D8 80015DD8 3000BEAF */  sw         $fp, 0x30($sp)
    /* 65DC 80015DDC 21F0A000 */  addu       $fp, $a1, $zero
    /* 65E0 80015DE0 2800B6AF */  sw         $s6, 0x28($sp)
    /* 65E4 80015DE4 21B0C000 */  addu       $s6, $a2, $zero
    /* 65E8 80015DE8 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 65EC 80015DEC 21B8E000 */  addu       $s7, $a3, $zero
    /* 65F0 80015DF0 3400BFAF */  sw         $ra, 0x34($sp)
    /* 65F4 80015DF4 2400B5AF */  sw         $s5, 0x24($sp)
    /* 65F8 80015DF8 2000B4AF */  sw         $s4, 0x20($sp)
    /* 65FC 80015DFC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6600 80015E00 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6604 80015E04 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6608 80015E08 0000C0AE */  sw         $zero, 0x0($s6)
    /* 660C 80015E0C 39006012 */  beqz       $s3, .L80015EF4
    /* 6610 80015E10 0000E0AE */   sw        $zero, 0x0($s7)
    /* 6614 80015E14 10007126 */  addiu      $s1, $s3, 0x10
    /* 6618 80015E18 0800628E */  lw         $v0, 0x8($s3)
    /* 661C 80015E1C 00000000 */  nop
    /* 6620 80015E20 34004010 */  beqz       $v0, .L80015EF4
    /* 6624 80015E24 01001224 */   addiu     $s2, $zero, 0x1
    /* 6628 80015E28 FF00143C */  lui        $s4, (0xFF0000 >> 16)
    /* 662C 80015E2C 00FF153C */  lui        $s5, (0xFF000000 >> 16)
  .L80015E30:
    /* 6630 80015E30 08003026 */  addiu      $s0, $s1, 0x8
    /* 6634 80015E34 2120C003 */  addu       $a0, $fp, $zero
    /* 6638 80015E38 5F97030C */  jal        strcmp
    /* 663C 80015E3C 21280002 */   addu      $a1, $s0, $zero
    /* 6640 80015E40 1C004014 */  bnez       $v0, .L80015EB4
    /* 6644 80015E44 00000000 */   nop
    /* 6648 80015E48 0000238E */  lw         $v1, 0x0($s1)
    /* 664C 80015E4C 00000000 */  nop
    /* 6650 80015E50 00260300 */  sll        $a0, $v1, 24
    /* 6654 80015E54 00FF6230 */  andi       $v0, $v1, 0xFF00
    /* 6658 80015E58 00120200 */  sll        $v0, $v0, 8
    /* 665C 80015E5C 25208200 */  or         $a0, $a0, $v0
    /* 6660 80015E60 24107400 */  and        $v0, $v1, $s4
    /* 6664 80015E64 02120200 */  srl        $v0, $v0, 8
    /* 6668 80015E68 25208200 */  or         $a0, $a0, $v0
    /* 666C 80015E6C 24187500 */  and        $v1, $v1, $s5
    /* 6670 80015E70 021E0300 */  srl        $v1, $v1, 24
    /* 6674 80015E74 25208300 */  or         $a0, $a0, $v1
    /* 6678 80015E78 0000C4AE */  sw         $a0, 0x0($s6)
    /* 667C 80015E7C 0400238E */  lw         $v1, 0x4($s1)
    /* 6680 80015E80 00000000 */  nop
    /* 6684 80015E84 00260300 */  sll        $a0, $v1, 24
    /* 6688 80015E88 00FF6230 */  andi       $v0, $v1, 0xFF00
    /* 668C 80015E8C 00120200 */  sll        $v0, $v0, 8
    /* 6690 80015E90 25208200 */  or         $a0, $a0, $v0
    /* 6694 80015E94 24107400 */  and        $v0, $v1, $s4
    /* 6698 80015E98 02120200 */  srl        $v0, $v0, 8
    /* 669C 80015E9C 25208200 */  or         $a0, $a0, $v0
    /* 66A0 80015EA0 24187500 */  and        $v1, $v1, $s5
    /* 66A4 80015EA4 021E0300 */  srl        $v1, $v1, 24
    /* 66A8 80015EA8 25208300 */  or         $a0, $a0, $v1
    /* 66AC 80015EAC BD570008 */  j          .L80015EF4
    /* 66B0 80015EB0 0000E4AE */   sw        $a0, 0x0($s7)
  .L80015EB4:
    /* 66B4 80015EB4 08002292 */  lbu        $v0, 0x8($s1)
    /* 66B8 80015EB8 00000000 */  nop
    /* 66BC 80015EBC 07004010 */  beqz       $v0, .L80015EDC
    /* 66C0 80015EC0 21280002 */   addu      $a1, $s0, $zero
    /* 66C4 80015EC4 0100A524 */  addiu      $a1, $a1, 0x1
  .L80015EC8:
    /* 66C8 80015EC8 0000A290 */  lbu        $v0, 0x0($a1)
    /* 66CC 80015ECC 00000000 */  nop
    /* 66D0 80015ED0 FDFF4014 */  bnez       $v0, .L80015EC8
    /* 66D4 80015ED4 0100A524 */   addiu     $a1, $a1, 0x1
    /* 66D8 80015ED8 FFFFA524 */  addiu      $a1, $a1, -0x1
  .L80015EDC:
    /* 66DC 80015EDC 0100B124 */  addiu      $s1, $a1, 0x1
    /* 66E0 80015EE0 0800638E */  lw         $v1, 0x8($s3)
    /* 66E4 80015EE4 21104002 */  addu       $v0, $s2, $zero
    /* 66E8 80015EE8 2B104300 */  sltu       $v0, $v0, $v1
    /* 66EC 80015EEC D0FF4014 */  bnez       $v0, .L80015E30
    /* 66F0 80015EF0 01005226 */   addiu     $s2, $s2, 0x1
  .L80015EF4:
    /* 66F4 80015EF4 3400BF8F */  lw         $ra, 0x34($sp)
    /* 66F8 80015EF8 3000BE8F */  lw         $fp, 0x30($sp)
    /* 66FC 80015EFC 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 6700 80015F00 2800B68F */  lw         $s6, 0x28($sp)
    /* 6704 80015F04 2400B58F */  lw         $s5, 0x24($sp)
    /* 6708 80015F08 2000B48F */  lw         $s4, 0x20($sp)
    /* 670C 80015F0C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 6710 80015F10 1800B28F */  lw         $s2, 0x18($sp)
    /* 6714 80015F14 1400B18F */  lw         $s1, 0x14($sp)
    /* 6718 80015F18 1000B08F */  lw         $s0, 0x10($sp)
    /* 671C 80015F1C 0800E003 */  jr         $ra
    /* 6720 80015F20 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel FeAudio_LocateBigfile__FP9LUMPYHEADPcPiT2
