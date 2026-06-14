.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_PlaySong__FPc, 0x280

glabel AudioMus_PlaySong__FPc
    /* 6B830 8007B030 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B834 8007B034 58FFBD27 */  addiu      $sp, $sp, -0xA8
    /* 6B838 8007B038 9C00B3AF */  sw         $s3, 0x9C($sp)
    /* 6B83C 8007B03C 21988000 */  addu       $s3, $a0, $zero
    /* 6B840 8007B040 A000BFAF */  sw         $ra, 0xA0($sp)
    /* 6B844 8007B044 9800B2AF */  sw         $s2, 0x98($sp)
    /* 6B848 8007B048 9400B1AF */  sw         $s1, 0x94($sp)
    /* 6B84C 8007B04C 90004010 */  beqz       $v0, .L8007B290
    /* 6B850 8007B050 9000B0AF */   sw        $s0, 0x90($sp)
    /* 6B854 8007B054 14006012 */  beqz       $s3, .L8007B0A8
    /* 6B858 8007B058 00000000 */   nop
    /* 6B85C 8007B05C D8EB010C */  jal        AudioMus_BuildPattern__FPc
    /* 6B860 8007B060 00000000 */   nop
    /* 6B864 8007B064 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B868 8007B068 00000000 */  nop
    /* 6B86C 8007B06C 0800428C */  lw         $v0, 0x8($v0)
    /* 6B870 8007B070 00000000 */  nop
    /* 6B874 8007B074 0C004014 */  bnez       $v0, .L8007B0A8
    /* 6B878 8007B078 00000000 */   nop
    /* 6B87C 8007B07C DDA7030C */  jal        strlen
    /* 6B880 8007B080 21206002 */   addu      $a0, $s3, $zero
    /* 6B884 8007B084 3D00422C */  sltiu      $v0, $v0, 0x3D
    /* 6B888 8007B088 07004010 */  beqz       $v0, .L8007B0A8
    /* 6B88C 8007B08C 1480053C */   lui       $a1, %hi(D_8013C724)
    /* 6B890 8007B090 1000A427 */  addiu      $a0, $sp, 0x10
    /* 6B894 8007B094 24C7A524 */  addiu      $a1, $a1, %lo(D_8013C724)
    /* 6B898 8007B098 2F91030C */  jal        sprintf
    /* 6B89C 8007B09C 21306002 */   addu      $a2, $s3, $zero
    /* 6B8A0 8007B0A0 D8EB010C */  jal        AudioMus_BuildPattern__FPc
    /* 6B8A4 8007B0A4 1000A427 */   addiu     $a0, $sp, 0x10
  .L8007B0A8:
    /* 6B8A8 8007B0A8 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B8AC 8007B0AC 00000000 */  nop
    /* 6B8B0 8007B0B0 0000628C */  lw         $v0, 0x0($v1)
    /* 6B8B4 8007B0B4 00000000 */  nop
    /* 6B8B8 8007B0B8 76004010 */  beqz       $v0, .L8007B294
    /* 6B8BC 8007B0BC 21100000 */   addu      $v0, $zero, $zero
    /* 6B8C0 8007B0C0 0800628C */  lw         $v0, 0x8($v1)
    /* 6B8C4 8007B0C4 00000000 */  nop
    /* 6B8C8 8007B0C8 6C004010 */  beqz       $v0, .L8007B27C
    /* 6B8CC 8007B0CC 21804000 */   addu      $s0, $v0, $zero
    /* 6B8D0 8007B0D0 01000224 */  addiu      $v0, $zero, 0x1
    /* 6B8D4 8007B0D4 03000216 */  bne        $s0, $v0, .L8007B0E4
    /* 6B8D8 8007B0D8 280062AC */   sw        $v0, 0x28($v1)
    /* 6B8DC 8007B0DC 7AEC0108 */  j          .L8007B1E8
    /* 6B8E0 8007B0E0 21800000 */   addu      $s0, $zero, $zero
  .L8007B0E4:
    /* 6B8E4 8007B0E4 19006012 */  beqz       $s3, .L8007B14C
    /* 6B8E8 8007B0E8 21200000 */   addu      $a0, $zero, $zero
    /* 6B8EC 8007B0EC C3A7030C */  jal        GetRCnt
    /* 6B8F0 8007B0F0 21200000 */   addu      $a0, $zero, $zero
    /* 6B8F4 8007B0F4 05004018 */  blez       $v0, .L8007B10C
    /* 6B8F8 8007B0F8 00000000 */   nop
    /* 6B8FC 8007B0FC C3A7030C */  jal        GetRCnt
    /* 6B900 8007B100 21200000 */   addu      $a0, $zero, $zero
    /* 6B904 8007B104 46EC0108 */  j          .L8007B118
    /* 6B908 8007B108 00000000 */   nop
  .L8007B10C:
    /* 6B90C 8007B10C C3A7030C */  jal        GetRCnt
    /* 6B910 8007B110 21200000 */   addu      $a0, $zero, $zero
    /* 6B914 8007B114 23100200 */  negu       $v0, $v0
  .L8007B118:
    /* 6B918 8007B118 1A005000 */  div        $zero, $v0, $s0
    /* 6B91C 8007B11C 02000016 */  bnez       $s0, .L8007B128
    /* 6B920 8007B120 00000000 */   nop
    /* 6B924 8007B124 0D000700 */  break      7
  .L8007B128:
    /* 6B928 8007B128 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6B92C 8007B12C 04000116 */  bne        $s0, $at, .L8007B140
    /* 6B930 8007B130 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6B934 8007B134 02004114 */  bne        $v0, $at, .L8007B140
    /* 6B938 8007B138 00000000 */   nop
    /* 6B93C 8007B13C 0D000600 */  break      6
  .L8007B140:
    /* 6B940 8007B140 10180000 */  mfhi       $v1
    /* 6B944 8007B144 7AEC0108 */  j          .L8007B1E8
    /* 6B948 8007B148 21806000 */   addu      $s0, $v1, $zero
  .L8007B14C:
    /* 6B94C 8007B14C 0C00628C */  lw         $v0, 0xC($v1)
    /* 6B950 8007B150 FFFF1126 */  addiu      $s1, $s0, -0x1
    /* 6B954 8007B154 C3A7030C */  jal        GetRCnt
    /* 6B958 8007B158 01005224 */   addiu     $s2, $v0, 0x1
    /* 6B95C 8007B15C 05004018 */  blez       $v0, .L8007B174
    /* 6B960 8007B160 00000000 */   nop
    /* 6B964 8007B164 C3A7030C */  jal        GetRCnt
    /* 6B968 8007B168 21200000 */   addu      $a0, $zero, $zero
    /* 6B96C 8007B16C 60EC0108 */  j          .L8007B180
    /* 6B970 8007B170 00000000 */   nop
  .L8007B174:
    /* 6B974 8007B174 C3A7030C */  jal        GetRCnt
    /* 6B978 8007B178 21200000 */   addu      $a0, $zero, $zero
    /* 6B97C 8007B17C 23100200 */  negu       $v0, $v0
  .L8007B180:
    /* 6B980 8007B180 1A005100 */  div        $zero, $v0, $s1
    /* 6B984 8007B184 02002016 */  bnez       $s1, .L8007B190
    /* 6B988 8007B188 00000000 */   nop
    /* 6B98C 8007B18C 0D000700 */  break      7
  .L8007B190:
    /* 6B990 8007B190 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6B994 8007B194 04002116 */  bne        $s1, $at, .L8007B1A8
    /* 6B998 8007B198 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6B99C 8007B19C 02004114 */  bne        $v0, $at, .L8007B1A8
    /* 6B9A0 8007B1A0 00000000 */   nop
    /* 6B9A4 8007B1A4 0D000600 */  break      6
  .L8007B1A8:
    /* 6B9A8 8007B1A8 10180000 */  mfhi       $v1
    /* 6B9AC 8007B1AC 00000000 */  nop
    /* 6B9B0 8007B1B0 21184302 */  addu       $v1, $s2, $v1
    /* 6B9B4 8007B1B4 1A007000 */  div        $zero, $v1, $s0
    /* 6B9B8 8007B1B8 02000016 */  bnez       $s0, .L8007B1C4
    /* 6B9BC 8007B1BC 00000000 */   nop
    /* 6B9C0 8007B1C0 0D000700 */  break      7
  .L8007B1C4:
    /* 6B9C4 8007B1C4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6B9C8 8007B1C8 04000116 */  bne        $s0, $at, .L8007B1DC
    /* 6B9CC 8007B1CC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6B9D0 8007B1D0 02006114 */  bne        $v1, $at, .L8007B1DC
    /* 6B9D4 8007B1D4 00000000 */   nop
    /* 6B9D8 8007B1D8 0D000600 */  break      6
  .L8007B1DC:
    /* 6B9DC 8007B1DC 10100000 */  mfhi       $v0
    /* 6B9E0 8007B1E0 00000000 */  nop
    /* 6B9E4 8007B1E4 21804000 */  addu       $s0, $v0, $zero
  .L8007B1E8:
    /* 6B9E8 8007B1E8 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B9EC 8007B1EC 00000000 */  nop
    /* 6B9F0 8007B1F0 1400628C */  lw         $v0, 0x14($v1)
    /* 6B9F4 8007B1F4 00000000 */  nop
    /* 6B9F8 8007B1F8 04004010 */  beqz       $v0, .L8007B20C
    /* 6B9FC 8007B1FC 01000224 */   addiu     $v0, $zero, 0x1
    /* 6BA00 8007B200 140062AC */  sw         $v0, 0x14($v1)
    /* 6BA04 8007B204 99EC0108 */  j          .L8007B264
    /* 6BA08 8007B208 0C0070AC */   sw        $s0, 0xC($v1)
  .L8007B20C:
    /* 6BA0C 8007B20C 0C00628C */  lw         $v0, 0xC($v1)
    /* 6BA10 8007B210 00000000 */  nop
    /* 6BA14 8007B214 0C004004 */  bltz       $v0, .L8007B248
    /* 6BA18 8007B218 D0070524 */   addiu     $a1, $zero, 0x7D0
    /* 6BA1C 8007B21C 7400648C */  lw         $a0, 0x74($v1)
    /* 6BA20 8007B220 7AA7030C */  jal        SNDSTRM_autovol
    /* 6BA24 8007B224 21300000 */   addu      $a2, $zero, $zero
    /* 6BA28 8007B228 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6BA2C 8007B22C D0070324 */  addiu      $v1, $zero, 0x7D0
    /* 6BA30 8007B230 240043AC */  sw         $v1, 0x24($v0)
    /* 6BA34 8007B234 01000324 */  addiu      $v1, $zero, 0x1
    /* 6BA38 8007B238 140043AC */  sw         $v1, 0x14($v0)
    /* 6BA3C 8007B23C 0C0050AC */  sw         $s0, 0xC($v0)
    /* 6BA40 8007B240 99EC0108 */  j          .L8007B264
    /* 6BA44 8007B244 2C0040AC */   sw        $zero, 0x2C($v0)
  .L8007B248:
    /* 6BA48 8007B248 7400648C */  lw         $a0, 0x74($v1)
    /* 6BA4C 8007B24C 21280000 */  addu       $a1, $zero, $zero
    /* 6BA50 8007B250 36A8030C */  jal        SNDSTRM_vol
    /* 6BA54 8007B254 240060AC */   sw        $zero, 0x24($v1)
    /* 6BA58 8007B258 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6BA5C 8007B25C 96E8010C */  jal        AudioMus_QueueRequestedSong__Fv
    /* 6BA60 8007B260 0C0050AC */   sw        $s0, 0xC($v0)
  .L8007B264:
    /* 6BA64 8007B264 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6BA68 8007B268 01000324 */  addiu      $v1, $zero, 0x1
    /* 6BA6C 8007B26C 100043AC */  sw         $v1, 0x10($v0)
    /* 6BA70 8007B270 02006012 */  beqz       $s3, .L8007B27C
    /* 6BA74 8007B274 200040AC */   sw        $zero, 0x20($v0)
    /* 6BA78 8007B278 180043AC */  sw         $v1, 0x18($v0)
  .L8007B27C:
    /* 6BA7C 8007B27C D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6BA80 8007B280 00000000 */  nop
    /* 6BA84 8007B284 0800428C */  lw         $v0, 0x8($v0)
    /* 6BA88 8007B288 A5EC0108 */  j          .L8007B294
    /* 6BA8C 8007B28C 00000000 */   nop
  .L8007B290:
    /* 6BA90 8007B290 21100000 */  addu       $v0, $zero, $zero
  .L8007B294:
    /* 6BA94 8007B294 A000BF8F */  lw         $ra, 0xA0($sp)
    /* 6BA98 8007B298 9C00B38F */  lw         $s3, 0x9C($sp)
    /* 6BA9C 8007B29C 9800B28F */  lw         $s2, 0x98($sp)
    /* 6BAA0 8007B2A0 9400B18F */  lw         $s1, 0x94($sp)
    /* 6BAA4 8007B2A4 9000B08F */  lw         $s0, 0x90($sp)
    /* 6BAA8 8007B2A8 0800E003 */  jr         $ra
    /* 6BAAC 8007B2AC A800BD27 */   addiu     $sp, $sp, 0xA8
endlabel AudioMus_PlaySong__FPc
