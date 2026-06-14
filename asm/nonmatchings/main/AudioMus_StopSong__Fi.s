.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_StopSong__Fi, 0xD4

glabel AudioMus_StopSong__Fi
    /* 6B604 8007AE04 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6B608 8007AE08 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6B60C 8007AE0C 21808000 */  addu       $s0, $a0, $zero
    /* 6B610 8007AE10 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6B614 8007AE14 00000000 */  nop
    /* 6B618 8007AE18 2B008010 */  beqz       $a0, .L8007AEC8
    /* 6B61C 8007AE1C 1400BFAF */   sw        $ra, 0x14($sp)
    /* 6B620 8007AE20 0C00828C */  lw         $v0, 0xC($a0)
    /* 6B624 8007AE24 00000000 */  nop
    /* 6B628 8007AE28 27004004 */  bltz       $v0, .L8007AEC8
    /* 6B62C 8007AE2C 00000000 */   nop
    /* 6B630 8007AE30 0D000016 */  bnez       $s0, .L8007AE68
    /* 6B634 8007AE34 00000000 */   nop
    /* 6B638 8007AE38 7400848C */  lw         $a0, 0x74($a0)
    /* 6B63C 8007AE3C 00000000 */  nop
    /* 6B640 8007AE40 03008004 */  bltz       $a0, .L8007AE50
    /* 6B644 8007AE44 00000000 */   nop
    /* 6B648 8007AE48 16A7030C */  jal        SNDSTRM_purge
    /* 6B64C 8007AE4C 00000000 */   nop
  .L8007AE50:
    /* 6B650 8007AE50 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B654 8007AE54 00000000 */  nop
    /* 6B658 8007AE58 240040AC */  sw         $zero, 0x24($v0)
    /* 6B65C 8007AE5C 2C0040AC */  sw         $zero, 0x2C($v0)
    /* 6B660 8007AE60 AFEB0108 */  j          .L8007AEBC
    /* 6B664 8007AE64 140040AC */   sw        $zero, 0x14($v0)
  .L8007AE68:
    /* 6B668 8007AE68 1400828C */  lw         $v0, 0x14($a0)
    /* 6B66C 8007AE6C 00000000 */  nop
    /* 6B670 8007AE70 0F004014 */  bnez       $v0, .L8007AEB0
    /* 6B674 8007AE74 00000000 */   nop
    /* 6B678 8007AE78 7400828C */  lw         $v0, 0x74($a0)
    /* 6B67C 8007AE7C 00000000 */  nop
    /* 6B680 8007AE80 07004004 */  bltz       $v0, .L8007AEA0
    /* 6B684 8007AE84 21280002 */   addu      $a1, $s0, $zero
    /* 6B688 8007AE88 21204000 */  addu       $a0, $v0, $zero
    /* 6B68C 8007AE8C 7AA7030C */  jal        SNDSTRM_autovol
    /* 6B690 8007AE90 21300000 */   addu      $a2, $zero, $zero
    /* 6B694 8007AE94 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B698 8007AE98 A9EB0108 */  j          .L8007AEA4
    /* 6B69C 8007AE9C 240050AC */   sw        $s0, 0x24($v0)
  .L8007AEA0:
    /* 6B6A0 8007AEA0 240080AC */  sw         $zero, 0x24($a0)
  .L8007AEA4:
    /* 6B6A4 8007AEA4 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B6A8 8007AEA8 00000000 */  nop
    /* 6B6AC 8007AEAC 2C0040AC */  sw         $zero, 0x2C($v0)
  .L8007AEB0:
    /* 6B6B0 8007AEB0 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B6B4 8007AEB4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6B6B8 8007AEB8 140062AC */  sw         $v0, 0x14($v1)
  .L8007AEBC:
    /* 6B6BC 8007AEBC D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B6C0 8007AEC0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6B6C4 8007AEC4 0C0062AC */  sw         $v0, 0xC($v1)
  .L8007AEC8:
    /* 6B6C8 8007AEC8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 6B6CC 8007AECC 1000B08F */  lw         $s0, 0x10($sp)
    /* 6B6D0 8007AED0 0800E003 */  jr         $ra
    /* 6B6D4 8007AED4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioMus_StopSong__Fi
