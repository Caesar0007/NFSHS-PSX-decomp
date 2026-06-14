.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_GetCurrentSong__Fv, 0xBC

glabel AudioMus_GetCurrentSong__Fv
    /* 6A828 8007A028 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6A82C 8007A02C 00000000 */  nop
    /* 6A830 8007A030 03006014 */  bnez       $v1, .L8007A040
    /* 6A834 8007A034 0C016424 */   addiu     $a0, $v1, 0x10C
    /* 6A838 8007A038 0800E003 */  jr         $ra
    /* 6A83C 8007A03C 21100000 */   addu      $v0, $zero, $zero
  .L8007A040:
    /* 6A840 8007A040 A400628C */  lw         $v0, 0xA4($v1)
    /* 6A844 8007A044 00000000 */  nop
    /* 6A848 8007A048 080082AC */  sw         $v0, 0x8($a0)
    /* 6A84C 8007A04C 2000628C */  lw         $v0, 0x20($v1)
    /* 6A850 8007A050 00000000 */  nop
    /* 6A854 8007A054 04004014 */  bnez       $v0, .L8007A068
    /* 6A858 8007A058 00000000 */   nop
    /* 6A85C 8007A05C 0C00628C */  lw         $v0, 0xC($v1)
    /* 6A860 8007A060 00000000 */  nop
    /* 6A864 8007A064 01004224 */  addiu      $v0, $v0, 0x1
  .L8007A068:
    /* 6A868 8007A068 040082AC */  sw         $v0, 0x4($a0)
    /* 6A86C 8007A06C D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6A870 8007A070 00000000 */  nop
    /* 6A874 8007A074 2000438C */  lw         $v1, 0x20($v0)
    /* 6A878 8007A078 FCFF0224 */  addiu      $v0, $zero, -0x4
    /* 6A87C 8007A07C 06006210 */  beq        $v1, $v0, .L8007A098
    /* 6A880 8007A080 0C008424 */   addiu     $a0, $a0, 0xC
    /* 6A884 8007A084 FDFF0224 */  addiu      $v0, $zero, -0x3
    /* 6A888 8007A088 06006210 */  beq        $v1, $v0, .L8007A0A4
    /* 6A88C 8007A08C 0580023C */   lui       $v0, %hi(D_80055790)
    /* 6A890 8007A090 2BE80108 */  j          .L8007A0AC
    /* 6A894 8007A094 00000000 */   nop
  .L8007A098:
    /* 6A898 8007A098 0580023C */  lui        $v0, %hi(D_80055778)
    /* 6A89C 8007A09C 2AE80108 */  j          .L8007A0A8
    /* 6A8A0 8007A0A0 78574224 */   addiu     $v0, $v0, %lo(D_80055778)
  .L8007A0A4:
    /* 6A8A4 8007A0A4 90574224 */  addiu      $v0, $v0, %lo(D_80055790)
  .L8007A0A8:
    /* 6A8A8 8007A0A8 040082AC */  sw         $v0, 0x4($a0)
  .L8007A0AC:
    /* 6A8AC 8007A0AC D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6A8B0 8007A0B0 00000000 */  nop
    /* 6A8B4 8007A0B4 1800628C */  lw         $v0, 0x18($v1)
    /* 6A8B8 8007A0B8 00000000 */  nop
    /* 6A8BC 8007A0BC 05004010 */  beqz       $v0, .L8007A0D4
    /* 6A8C0 8007A0C0 00000000 */   nop
    /* 6A8C4 8007A0C4 01000224 */  addiu      $v0, $zero, 0x1
    /* 6A8C8 8007A0C8 180060AC */  sw         $zero, 0x18($v1)
    /* 6A8CC 8007A0CC 36E80108 */  j          .L8007A0D8
    /* 6A8D0 8007A0D0 0C0162AC */   sw        $v0, 0x10C($v1)
  .L8007A0D4:
    /* 6A8D4 8007A0D4 0C0160AC */  sw         $zero, 0x10C($v1)
  .L8007A0D8:
    /* 6A8D8 8007A0D8 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6A8DC 8007A0DC 0800E003 */  jr         $ra
    /* 6A8E0 8007A0E0 0C014224 */   addiu     $v0, $v0, 0x10C
endlabel AudioMus_GetCurrentSong__Fv
