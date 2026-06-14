.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_GetSongList__FPci, 0x1D4

glabel AudioMus_GetSongList__FPci
    /* 6B080 8007A880 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B084 8007A884 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 6B088 8007A888 3400B5AF */  sw         $s5, 0x34($sp)
    /* 6B08C 8007A88C 21A88000 */  addu       $s5, $a0, $zero
    /* 6B090 8007A890 2800B2AF */  sw         $s2, 0x28($sp)
    /* 6B094 8007A894 2190A000 */  addu       $s2, $a1, $zero
    /* 6B098 8007A898 2400B1AF */  sw         $s1, 0x24($sp)
    /* 6B09C 8007A89C 21880000 */  addu       $s1, $zero, $zero
    /* 6B0A0 8007A8A0 3800BFAF */  sw         $ra, 0x38($sp)
    /* 6B0A4 8007A8A4 3000B4AF */  sw         $s4, 0x30($sp)
    /* 6B0A8 8007A8A8 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 6B0AC 8007A8AC 56006010 */  beqz       $v1, .L8007AA08
    /* 6B0B0 8007A8B0 2000B0AF */   sw        $s0, 0x20($sp)
    /* 6B0B4 8007A8B4 0400628C */  lw         $v0, 0x4($v1)
    /* 6B0B8 8007A8B8 00000000 */  nop
    /* 6B0BC 8007A8BC 2A102202 */  slt        $v0, $s1, $v0
    /* 6B0C0 8007A8C0 14004010 */  beqz       $v0, .L8007A914
    /* 6B0C4 8007A8C4 21802002 */   addu      $s0, $s1, $zero
    /* 6B0C8 8007A8C8 21280000 */  addu       $a1, $zero, $zero
  .L8007A8CC:
    /* 6B0CC 8007A8CC 21300002 */  addu       $a2, $s0, $zero
    /* 6B0D0 8007A8D0 1000A0AF */  sw         $zero, 0x10($sp)
    /* 6B0D4 8007A8D4 8C00648C */  lw         $a0, 0x8C($v1)
    /* 6B0D8 8007A8D8 6E98030C */  jal        locatebigentry
    /* 6B0DC 8007A8DC 2138A000 */   addu      $a3, $a1, $zero
    /* 6B0E0 8007A8E0 21204000 */  addu       $a0, $v0, $zero
    /* 6B0E4 8007A8E4 6FA2030C */  jal        wildcard
    /* 6B0E8 8007A8E8 2128A002 */   addu      $a1, $s5, $zero
    /* 6B0EC 8007A8EC 02004010 */  beqz       $v0, .L8007A8F8
    /* 6B0F0 8007A8F0 00000000 */   nop
    /* 6B0F4 8007A8F4 01003126 */  addiu      $s1, $s1, 0x1
  .L8007A8F8:
    /* 6B0F8 8007A8F8 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B0FC 8007A8FC 00000000 */  nop
    /* 6B100 8007A900 0400628C */  lw         $v0, 0x4($v1)
    /* 6B104 8007A904 01001026 */  addiu      $s0, $s0, 0x1
    /* 6B108 8007A908 2A100202 */  slt        $v0, $s0, $v0
    /* 6B10C 8007A90C EFFF4014 */  bnez       $v0, .L8007A8CC
    /* 6B110 8007A910 21280000 */   addu      $a1, $zero, $zero
  .L8007A914:
    /* 6B114 8007A914 0580043C */  lui        $a0, %hi(D_800557A4)
    /* 6B118 8007A918 A4578424 */  addiu      $a0, $a0, %lo(D_800557A4)
    /* 6B11C 8007A91C 80291100 */  sll        $a1, $s1, 6
    /* 6B120 8007A920 0800A534 */  ori        $a1, $a1, 0x8
    /* 6B124 8007A924 CF94030C */  jal        reservememadr
    /* 6B128 8007A928 21304002 */   addu      $a2, $s2, $zero
    /* 6B12C 8007A92C 21884000 */  addu       $s1, $v0, $zero
    /* 6B130 8007A930 08003426 */  addiu      $s4, $s1, 0x8
    /* 6B134 8007A934 21900000 */  addu       $s2, $zero, $zero
    /* 6B138 8007A938 24003326 */  addiu      $s3, $s1, 0x24
    /* 6B13C 8007A93C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6B140 8007A940 000020AE */  sw         $zero, 0x0($s1)
    /* 6B144 8007A944 040022AE */  sw         $v0, 0x4($s1)
  .L8007A948:
    /* 6B148 8007A948 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B14C 8007A94C 00000000 */  nop
    /* 6B150 8007A950 0400628C */  lw         $v0, 0x4($v1)
    /* 6B154 8007A954 00000000 */  nop
    /* 6B158 8007A958 2A104202 */  slt        $v0, $s2, $v0
    /* 6B15C 8007A95C 33004010 */  beqz       $v0, .L8007AA2C
    /* 6B160 8007A960 21280000 */   addu      $a1, $zero, $zero
    /* 6B164 8007A964 21304002 */  addu       $a2, $s2, $zero
    /* 6B168 8007A968 1800A227 */  addiu      $v0, $sp, 0x18
    /* 6B16C 8007A96C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 6B170 8007A970 8C00648C */  lw         $a0, 0x8C($v1)
    /* 6B174 8007A974 6E98030C */  jal        locatebigentry
    /* 6B178 8007A978 2138A000 */   addu      $a3, $a1, $zero
    /* 6B17C 8007A97C 21804000 */  addu       $s0, $v0, $zero
    /* 6B180 8007A980 21200002 */  addu       $a0, $s0, $zero
    /* 6B184 8007A984 6FA2030C */  jal        wildcard
    /* 6B188 8007A988 2128A002 */   addu      $a1, $s5, $zero
    /* 6B18C 8007A98C 1C004010 */  beqz       $v0, .L8007AA00
    /* 6B190 8007A990 21208002 */   addu      $a0, $s4, $zero
    /* 6B194 8007A994 C2E8010C */  jal        AudioMus_SetEntry__FP19AudioMus_tSongEntry
    /* 6B198 8007A998 000090AE */   sw        $s0, 0x0($s4)
    /* 6B19C 8007A99C 0882043C */  lui        $a0, (0x82082083 >> 16)
    /* 6B1A0 8007A9A0 1800A38F */  lw         $v1, 0x18($sp)
    /* 6B1A4 8007A9A4 83208434 */  ori        $a0, $a0, (0x82082083 & 0xFFFF)
    /* 6B1A8 8007A9A8 80100300 */  sll        $v0, $v1, 2
    /* 6B1AC 8007A9AC 21104300 */  addu       $v0, $v0, $v1
    /* 6B1B0 8007A9B0 40100200 */  sll        $v0, $v0, 1
    /* 6B1B4 8007A9B4 18004400 */  mult       $v0, $a0
    /* 6B1B8 8007A9B8 000072AE */  sw         $s2, 0x0($s3)
    /* 6B1BC 8007A9BC D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6B1C0 8007A9C0 10400000 */  mfhi       $t0
    /* 6B1C4 8007A9C4 21180201 */  addu       $v1, $t0, $v0
    /* 6B1C8 8007A9C8 C3190300 */  sra        $v1, $v1, 7
    /* 6B1CC 8007A9CC C3170200 */  sra        $v0, $v0, 31
    /* 6B1D0 8007A9D0 23186200 */  subu       $v1, $v1, $v0
    /* 6B1D4 8007A9D4 FCFF63AE */  sw         $v1, -0x4($s3)
    /* 6B1D8 8007A9D8 2C00828C */  lw         $v0, 0x2C($a0)
    /* 6B1DC 8007A9DC 00000000 */  nop
    /* 6B1E0 8007A9E0 02000216 */  bne        $s0, $v0, .L8007A9EC
    /* 6B1E4 8007A9E4 00000000 */   nop
    /* 6B1E8 8007A9E8 040032AE */  sw         $s2, 0x4($s1)
  .L8007A9EC:
    /* 6B1EC 8007A9EC 40007326 */  addiu      $s3, $s3, 0x40
    /* 6B1F0 8007A9F0 0000228E */  lw         $v0, 0x0($s1)
    /* 6B1F4 8007A9F4 40009426 */  addiu      $s4, $s4, 0x40
    /* 6B1F8 8007A9F8 01004224 */  addiu      $v0, $v0, 0x1
    /* 6B1FC 8007A9FC 000022AE */  sw         $v0, 0x0($s1)
  .L8007AA00:
    /* 6B200 8007AA00 52EA0108 */  j          .L8007A948
    /* 6B204 8007AA04 01005226 */   addiu     $s2, $s2, 0x1
  .L8007AA08:
    /* 6B208 8007AA08 0580043C */  lui        $a0, %hi(D_800557A4)
    /* 6B20C 8007AA0C A4578424 */  addiu      $a0, $a0, %lo(D_800557A4)
    /* 6B210 8007AA10 08000524 */  addiu      $a1, $zero, 0x8
    /* 6B214 8007AA14 CF94030C */  jal        reservememadr
    /* 6B218 8007AA18 21304002 */   addu      $a2, $s2, $zero
    /* 6B21C 8007AA1C 21884000 */  addu       $s1, $v0, $zero
    /* 6B220 8007AA20 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6B224 8007AA24 000020AE */  sw         $zero, 0x0($s1)
    /* 6B228 8007AA28 040022AE */  sw         $v0, 0x4($s1)
  .L8007AA2C:
    /* 6B22C 8007AA2C 21102002 */  addu       $v0, $s1, $zero
    /* 6B230 8007AA30 3800BF8F */  lw         $ra, 0x38($sp)
    /* 6B234 8007AA34 3400B58F */  lw         $s5, 0x34($sp)
    /* 6B238 8007AA38 3000B48F */  lw         $s4, 0x30($sp)
    /* 6B23C 8007AA3C 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 6B240 8007AA40 2800B28F */  lw         $s2, 0x28($sp)
    /* 6B244 8007AA44 2400B18F */  lw         $s1, 0x24($sp)
    /* 6B248 8007AA48 2000B08F */  lw         $s0, 0x20($sp)
    /* 6B24C 8007AA4C 0800E003 */  jr         $ra
    /* 6B250 8007AA50 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel AudioMus_GetSongList__FPci
