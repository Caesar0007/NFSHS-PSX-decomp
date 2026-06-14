.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_AutoVolume__Fii, 0xC0

glabel AudioMus_AutoVolume__Fii
    /* 6BC6C 8007B46C D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6BC70 8007B470 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6BC74 8007B474 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6BC78 8007B478 21888000 */  addu       $s1, $a0, $zero
    /* 6BC7C 8007B47C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6BC80 8007B480 2180A000 */  addu       $s0, $a1, $zero
    /* 6BC84 8007B484 24004010 */  beqz       $v0, .L8007B518
    /* 6BC88 8007B488 1800BFAF */   sw        $ra, 0x18($sp)
    /* 6BC8C 8007B48C 0000438C */  lw         $v1, 0x0($v0)
    /* 6BC90 8007B490 00000000 */  nop
    /* 6BC94 8007B494 20007010 */  beq        $v1, $s0, .L8007B518
    /* 6BC98 8007B498 00000000 */   nop
    /* 6BC9C 8007B49C 06000016 */  bnez       $s0, .L8007B4B8
    /* 6BCA0 8007B4A0 00000000 */   nop
    /* 6BCA4 8007B4A4 000040AC */  sw         $zero, 0x0($v0)
    /* 6BCA8 8007B4A8 81EB010C */  jal        AudioMus_StopSong__Fi
    /* 6BCAC 8007B4AC 21200000 */   addu      $a0, $zero, $zero
    /* 6BCB0 8007B4B0 46ED0108 */  j          .L8007B518
    /* 6BCB4 8007B4B4 00000000 */   nop
  .L8007B4B8:
    /* 6BCB8 8007B4B8 06006014 */  bnez       $v1, .L8007B4D4
    /* 6BCBC 8007B4BC 00000000 */   nop
    /* 6BCC0 8007B4C0 000050AC */  sw         $s0, 0x0($v0)
    /* 6BCC4 8007B4C4 0CEC010C */  jal        AudioMus_PlaySong__FPc
    /* 6BCC8 8007B4C8 21200000 */   addu      $a0, $zero, $zero
    /* 6BCCC 8007B4CC 36ED0108 */  j          .L8007B4D8
    /* 6BCD0 8007B4D0 00000000 */   nop
  .L8007B4D4:
    /* 6BCD4 8007B4D4 000050AC */  sw         $s0, 0x0($v0)
  .L8007B4D8:
    /* 6BCD8 8007B4D8 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6BCDC 8007B4DC 00000000 */  nop
    /* 6BCE0 8007B4E0 1400838C */  lw         $v1, 0x14($a0)
    /* 6BCE4 8007B4E4 02000224 */  addiu      $v0, $zero, 0x2
    /* 6BCE8 8007B4E8 0B006210 */  beq        $v1, $v0, .L8007B518
    /* 6BCEC 8007B4EC 00000000 */   nop
    /* 6BCF0 8007B4F0 2400828C */  lw         $v0, 0x24($a0)
    /* 6BCF4 8007B4F4 00000000 */  nop
    /* 6BCF8 8007B4F8 07004014 */  bnez       $v0, .L8007B518
    /* 6BCFC 8007B4FC 00000000 */   nop
    /* 6BD00 8007B500 7400848C */  lw         $a0, 0x74($a0)
    /* 6BD04 8007B504 00000000 */  nop
    /* 6BD08 8007B508 03008004 */  bltz       $a0, .L8007B518
    /* 6BD0C 8007B50C 21282002 */   addu      $a1, $s1, $zero
    /* 6BD10 8007B510 7AA7030C */  jal        SNDSTRM_autovol
    /* 6BD14 8007B514 21300002 */   addu      $a2, $s0, $zero
  .L8007B518:
    /* 6BD18 8007B518 1800BF8F */  lw         $ra, 0x18($sp)
    /* 6BD1C 8007B51C 1400B18F */  lw         $s1, 0x14($sp)
    /* 6BD20 8007B520 1000B08F */  lw         $s0, 0x10($sp)
    /* 6BD24 8007B524 0800E003 */  jr         $ra
    /* 6BD28 8007B528 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioMus_AutoVolume__Fii
