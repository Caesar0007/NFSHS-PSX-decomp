.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_SwitchSong__Fv, 0xF8

glabel AudioMus_SwitchSong__Fv
    /* 6A8E4 8007A0E4 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6A8E8 8007A0E8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6A8EC 8007A0EC 37006010 */  beqz       $v1, .L8007A1CC
    /* 6A8F0 8007A0F0 1000BFAF */   sw        $ra, 0x10($sp)
    /* 6A8F4 8007A0F4 0800628C */  lw         $v0, 0x8($v1)
    /* 6A8F8 8007A0F8 00000000 */  nop
    /* 6A8FC 8007A0FC 33004010 */  beqz       $v0, .L8007A1CC
    /* 6A900 8007A100 00000000 */   nop
    /* 6A904 8007A104 0000628C */  lw         $v0, 0x0($v1)
    /* 6A908 8007A108 00000000 */  nop
    /* 6A90C 8007A10C 2F004018 */  blez       $v0, .L8007A1CC
    /* 6A910 8007A110 01000224 */   addiu     $v0, $zero, 0x1
    /* 6A914 8007A114 180062AC */  sw         $v0, 0x18($v1)
    /* 6A918 8007A118 18016224 */  addiu      $v0, $v1, 0x118
    /* 6A91C 8007A11C 2C0060AC */  sw         $zero, 0x2C($v1)
    /* 6A920 8007A120 200060AC */  sw         $zero, 0x20($v1)
    /* 6A924 8007A124 140160AC */  sw         $zero, 0x114($v1)
    /* 6A928 8007A128 180040AC */  sw         $zero, 0x18($v0)
    /* 6A92C 8007A12C 180160AC */  sw         $zero, 0x118($v1)
    /* 6A930 8007A130 040040AC */  sw         $zero, 0x4($v0)
    /* 6A934 8007A134 080040AC */  sw         $zero, 0x8($v0)
    /* 6A938 8007A138 0C0040AC */  sw         $zero, 0xC($v0)
    /* 6A93C 8007A13C 140040AC */  sw         $zero, 0x14($v0)
    /* 6A940 8007A140 1400628C */  lw         $v0, 0x14($v1)
    /* 6A944 8007A144 00000000 */  nop
    /* 6A948 8007A148 0B004014 */  bnez       $v0, .L8007A178
    /* 6A94C 8007A14C 00000000 */   nop
    /* 6A950 8007A150 0C00628C */  lw         $v0, 0xC($v1)
    /* 6A954 8007A154 00000000 */  nop
    /* 6A958 8007A158 07004004 */  bltz       $v0, .L8007A178
    /* 6A95C 8007A15C D0070524 */   addiu     $a1, $zero, 0x7D0
    /* 6A960 8007A160 7400648C */  lw         $a0, 0x74($v1)
    /* 6A964 8007A164 7AA7030C */  jal        SNDSTRM_autovol
    /* 6A968 8007A168 21300000 */   addu      $a2, $zero, $zero
    /* 6A96C 8007A16C D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6A970 8007A170 E8030224 */  addiu      $v0, $zero, 0x3E8
    /* 6A974 8007A174 240062AC */  sw         $v0, 0x24($v1)
  .L8007A178:
    /* 6A978 8007A178 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6A97C 8007A17C 00000000 */  nop
    /* 6A980 8007A180 0C00828C */  lw         $v0, 0xC($a0)
    /* 6A984 8007A184 1480033C */  lui        $v1, %hi(Hud_kTurnSongOffNext)
    /* 6A988 8007A188 40D9638C */  lw         $v1, %lo(Hud_kTurnSongOffNext)($v1)
    /* 6A98C 8007A18C 01004524 */  addiu      $a1, $v0, 0x1
    /* 6A990 8007A190 06006014 */  bnez       $v1, .L8007A1AC
    /* 6A994 8007A194 0C0085AC */   sw        $a1, 0xC($a0)
    /* 6A998 8007A198 0800828C */  lw         $v0, 0x8($a0)
    /* 6A99C 8007A19C 00000000 */  nop
    /* 6A9A0 8007A1A0 2A10A200 */  slt        $v0, $a1, $v0
    /* 6A9A4 8007A1A4 08004014 */  bnez       $v0, .L8007A1C8
    /* 6A9A8 8007A1A8 01000224 */   addiu     $v0, $zero, 0x1
  .L8007A1AC:
    /* 6A9AC 8007A1AC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6A9B0 8007A1B0 1480013C */  lui        $at, %hi(Hud_kTurnSongOffNext)
    /* 6A9B4 8007A1B4 40D920AC */  sw         $zero, %lo(Hud_kTurnSongOffNext)($at)
    /* 6A9B8 8007A1B8 100080AC */  sw         $zero, 0x10($a0)
    /* 6A9BC 8007A1BC 140082AC */  sw         $v0, 0x14($a0)
    /* 6A9C0 8007A1C0 73E80108 */  j          .L8007A1CC
    /* 6A9C4 8007A1C4 0C0082AC */   sw        $v0, 0xC($a0)
  .L8007A1C8:
    /* 6A9C8 8007A1C8 140082AC */  sw         $v0, 0x14($a0)
  .L8007A1CC:
    /* 6A9CC 8007A1CC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6A9D0 8007A1D0 00000000 */  nop
    /* 6A9D4 8007A1D4 0800E003 */  jr         $ra
    /* 6A9D8 8007A1D8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioMus_SwitchSong__Fv
