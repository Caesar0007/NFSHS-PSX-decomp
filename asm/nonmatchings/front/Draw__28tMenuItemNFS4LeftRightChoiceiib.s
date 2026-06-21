.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__28tMenuItemNFS4LeftRightChoiceiib, 0x294

glabel Draw__28tMenuItemNFS4LeftRightChoiceiib
    /* B0C8 8001A8C8 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* B0CC 8001A8CC 2800B0AF */  sw         $s0, 0x28($sp)
    /* B0D0 8001A8D0 21808000 */  addu       $s0, $a0, $zero
    /* B0D4 8001A8D4 3000B2AF */  sw         $s2, 0x30($sp)
    /* B0D8 8001A8D8 2190A000 */  addu       $s2, $a1, $zero
    /* B0DC 8001A8DC 3400B3AF */  sw         $s3, 0x34($sp)
    /* B0E0 8001A8E0 2198C000 */  addu       $s3, $a2, $zero
    /* B0E4 8001A8E4 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* B0E8 8001A8E8 2188E000 */  addu       $s1, $a3, $zero
    /* B0EC 8001A8EC 07002016 */  bnez       $s1, .L8001A90C
    /* B0F0 8001A8F0 3800BFAF */   sw        $ra, 0x38($sp)
    /* B0F4 8001A8F4 20000286 */  lh         $v0, 0x20($s0)
    /* B0F8 8001A8F8 00000000 */  nop
    /* B0FC 8001A8FC F2FF4224 */  addiu      $v0, $v0, -0xE
    /* B100 8001A900 02004228 */  slti       $v0, $v0, 0x2
    /* B104 8001A904 1A004014 */  bnez       $v0, .L8001A970
    /* B108 8001A908 0E000224 */   addiu     $v0, $zero, 0xE
  .L8001A90C:
    /* B10C 8001A90C 3683000C */  jal        FETextRender_SetFont__Fi
    /* B110 8001A910 21200000 */   addu      $a0, $zero, $zero
    /* B114 8001A914 0400048E */  lw         $a0, 0x4($s0)
    /* B118 8001A918 94E4020C */  jal        TextSys_Word__Fi
    /* B11C 8001A91C 00000000 */   nop
    /* B120 8001A920 888F030C */  jal        textpixels
    /* B124 8001A924 21204000 */   addu      $a0, $v0, $zero
    /* B128 8001A928 21184000 */  addu       $v1, $v0, $zero
    /* B12C 8001A92C 00140300 */  sll        $v0, $v1, 16
    /* B130 8001A930 03140200 */  sra        $v0, $v0, 16
    /* B134 8001A934 8C004228 */  slti       $v0, $v0, 0x8C
    /* B138 8001A938 02004014 */  bnez       $v0, .L8001A944
    /* B13C 8001A93C A5000424 */   addiu     $a0, $zero, 0xA5
    /* B140 8001A940 19006424 */  addiu      $a0, $v1, 0x19
  .L8001A944:
    /* B144 8001A944 20000396 */  lhu        $v1, 0x20($s0)
    /* B148 8001A948 00000000 */  nop
    /* B14C 8001A94C FEFF6224 */  addiu      $v0, $v1, -0x2
    /* B150 8001A950 03002016 */  bnez       $s1, .L8001A960
    /* B154 8001A954 200002A6 */   sh        $v0, 0x20($s0)
    /* B158 8001A958 FCFF6224 */  addiu      $v0, $v1, -0x4
    /* B15C 8001A95C 200002A6 */  sh         $v0, 0x20($s0)
  .L8001A960:
    /* B160 8001A960 20000286 */  lh         $v0, 0x20($s0)
    /* B164 8001A964 20000396 */  lhu        $v1, 0x20($s0)
    /* B168 8001A968 02004104 */  bgez       $v0, .L8001A974
    /* B16C 8001A96C 21106400 */   addu      $v0, $v1, $a0
  .L8001A970:
    /* B170 8001A970 200002A6 */  sh         $v0, 0x20($s0)
  .L8001A974:
    /* B174 8001A974 0000028E */  lw         $v0, 0x0($s0)
    /* B178 8001A978 00000000 */  nop
    /* B17C 8001A97C 01004238 */  xori       $v0, $v0, 0x1
    /* B180 8001A980 01004230 */  andi       $v0, $v0, 0x1
    /* B184 8001A984 04004010 */  beqz       $v0, .L8001A998
    /* B188 8001A988 00000000 */   nop
    /* B18C 8001A98C 26000296 */  lhu        $v0, 0x26($s0)
    /* B190 8001A990 696A0008 */  j          .L8001A9A4
    /* B194 8001A994 0C004224 */   addiu     $v0, $v0, 0xC
  .L8001A998:
    /* B198 8001A998 26000296 */  lhu        $v0, 0x26($s0)
    /* B19C 8001A99C 00000000 */  nop
    /* B1A0 8001A9A0 F4FF4224 */  addiu      $v0, $v0, -0xC
  .L8001A9A4:
    /* B1A4 8001A9A4 260002A6 */  sh         $v0, 0x26($s0)
    /* B1A8 8001A9A8 26000286 */  lh         $v0, 0x26($s0)
    /* B1AC 8001A9AC 00000000 */  nop
    /* B1B0 8001A9B0 03004104 */  bgez       $v0, .L8001A9C0
    /* B1B4 8001A9B4 81004228 */   slti      $v0, $v0, 0x81
    /* B1B8 8001A9B8 746A0008 */  j          .L8001A9D0
    /* B1BC 8001A9BC 260000A6 */   sh        $zero, 0x26($s0)
  .L8001A9C0:
    /* B1C0 8001A9C0 04004014 */  bnez       $v0, .L8001A9D4
    /* B1C4 8001A9C4 73000224 */   addiu     $v0, $zero, 0x73
    /* B1C8 8001A9C8 80000224 */  addiu      $v0, $zero, 0x80
    /* B1CC 8001A9CC 260002A6 */  sh         $v0, 0x26($s0)
  .L8001A9D0:
    /* B1D0 8001A9D0 73000224 */  addiu      $v0, $zero, 0x73
  .L8001A9D4:
    /* B1D4 8001A9D4 2400A2A7 */  sh         $v0, 0x24($sp)
    /* B1D8 8001A9D8 0B000224 */  addiu      $v0, $zero, 0xB
    /* B1DC 8001A9DC 2000B2A7 */  sh         $s2, 0x20($sp)
    /* B1E0 8001A9E0 2200B3A7 */  sh         $s3, 0x22($sp)
    /* B1E4 8001A9E4 2600A2A7 */  sh         $v0, 0x26($sp)
    /* B1E8 8001A9E8 26000386 */  lh         $v1, 0x26($s0)
    /* B1EC 8001A9EC 22000286 */  lh         $v0, 0x22($s0)
    /* B1F0 8001A9F0 26000496 */  lhu        $a0, 0x26($s0)
    /* B1F4 8001A9F4 2A104300 */  slt        $v0, $v0, $v1
    /* B1F8 8001A9F8 22000396 */  lhu        $v1, 0x22($s0)
    /* B1FC 8001A9FC 03004010 */  beqz       $v0, .L8001AA0C
    /* B200 8001AA00 00140400 */   sll       $v0, $a0, 16
    /* B204 8001AA04 21206000 */  addu       $a0, $v1, $zero
    /* B208 8001AA08 00140400 */  sll        $v0, $a0, 16
  .L8001AA0C:
    /* B20C 8001AA0C 03140200 */  sra        $v0, $v0, 16
    /* B210 8001AA10 73000324 */  addiu      $v1, $zero, 0x73
    /* B214 8001AA14 18004300 */  mult       $v0, $v1
    /* B218 8001AA18 12100000 */  mflo       $v0
    /* B21C 8001AA1C 02004104 */  bgez       $v0, .L8001AA28
    /* B220 8001AA20 00000000 */   nop
    /* B224 8001AA24 7F004224 */  addiu      $v0, $v0, 0x7F
  .L8001AA28:
    /* B228 8001AA28 C3110200 */  sra        $v0, $v0, 7
    /* B22C 8001AA2C 2400A2A7 */  sh         $v0, 0x24($sp)
    /* B230 8001AA30 20000786 */  lh         $a3, 0x20($s0)
    /* B234 8001AA34 08000286 */  lh         $v0, 0x8($s0)
    /* B238 8001AA38 21200000 */  addu       $a0, $zero, $zero
    /* B23C 8001AA3C 05002016 */  bnez       $s1, .L8001AA54
    /* B240 8001AA40 1000A2AF */   sw        $v0, 0x10($sp)
    /* B244 8001AA44 20000386 */  lh         $v1, 0x20($s0)
    /* B248 8001AA48 0E000224 */  addiu      $v0, $zero, 0xE
    /* B24C 8001AA4C 03006210 */  beq        $v1, $v0, .L8001AA5C
    /* B250 8001AA50 2000A527 */   addiu     $a1, $sp, 0x20
  .L8001AA54:
    /* B254 8001AA54 01000424 */  addiu      $a0, $zero, 0x1
    /* B258 8001AA58 2000A527 */  addiu      $a1, $sp, 0x20
  .L8001AA5C:
    /* B25C 8001AA5C 1400A4AF */  sw         $a0, 0x14($sp)
    /* B260 8001AA60 1800A0AF */  sw         $zero, 0x18($sp)
    /* B264 8001AA64 0400048E */  lw         $a0, 0x4($s0)
    /* B268 8001AA68 0668000C */  jal        MenuNFS4_DrawTextBox__FiR4RECTissbT5
    /* B26C 8001AA6C 8C000624 */   addiu     $a2, $zero, 0x8C
    /* B270 8001AA70 0000028E */  lw         $v0, 0x0($s0)
    /* B274 8001AA74 00000000 */  nop
    /* B278 8001AA78 00024230 */  andi       $v0, $v0, 0x200
    /* B27C 8001AA7C 30004010 */  beqz       $v0, .L8001AB40
    /* B280 8001AA80 0580043C */   lui       $a0, %hi(FontUpsideDownBlit__FiiPviiP12charactertbli)
    /* B284 8001AA84 F32D030C */  jal        Font_SetBlitter__FPFiiPviiP12charactertbli_v
    /* B288 8001AA88 B4EF8424 */   addiu     $a0, $a0, %lo(FontUpsideDownBlit__FiiPviiP12charactertbli)
    /* B28C 8001AA8C 18010224 */  addiu      $v0, $zero, 0x118
    /* B290 8001AA90 23105300 */  subu       $v0, $v0, $s3
    /* B294 8001AA94 2200A2A7 */  sh         $v0, 0x22($sp)
    /* B298 8001AA98 73000224 */  addiu      $v0, $zero, 0x73
    /* B29C 8001AA9C 2400A2A7 */  sh         $v0, 0x24($sp)
    /* B2A0 8001AAA0 0B000224 */  addiu      $v0, $zero, 0xB
    /* B2A4 8001AAA4 2000B2A7 */  sh         $s2, 0x20($sp)
    /* B2A8 8001AAA8 2600A2A7 */  sh         $v0, 0x26($sp)
    /* B2AC 8001AAAC 22000386 */  lh         $v1, 0x22($s0)
    /* B2B0 8001AAB0 26000286 */  lh         $v0, 0x26($s0)
    /* B2B4 8001AAB4 22000496 */  lhu        $a0, 0x22($s0)
    /* B2B8 8001AAB8 2A104300 */  slt        $v0, $v0, $v1
    /* B2BC 8001AABC 26000396 */  lhu        $v1, 0x26($s0)
    /* B2C0 8001AAC0 03004010 */  beqz       $v0, .L8001AAD0
    /* B2C4 8001AAC4 00140400 */   sll       $v0, $a0, 16
    /* B2C8 8001AAC8 21206000 */  addu       $a0, $v1, $zero
    /* B2CC 8001AACC 00140400 */  sll        $v0, $a0, 16
  .L8001AAD0:
    /* B2D0 8001AAD0 03140200 */  sra        $v0, $v0, 16
    /* B2D4 8001AAD4 73000324 */  addiu      $v1, $zero, 0x73
    /* B2D8 8001AAD8 18004300 */  mult       $v0, $v1
    /* B2DC 8001AADC 12100000 */  mflo       $v0
    /* B2E0 8001AAE0 02004104 */  bgez       $v0, .L8001AAEC
    /* B2E4 8001AAE4 00000000 */   nop
    /* B2E8 8001AAE8 7F004224 */  addiu      $v0, $v0, 0x7F
  .L8001AAEC:
    /* B2EC 8001AAEC C3110200 */  sra        $v0, $v0, 7
    /* B2F0 8001AAF0 2400A2A7 */  sh         $v0, 0x24($sp)
    /* B2F4 8001AAF4 20000786 */  lh         $a3, 0x20($s0)
    /* B2F8 8001AAF8 08000286 */  lh         $v0, 0x8($s0)
    /* B2FC 8001AAFC 21200000 */  addu       $a0, $zero, $zero
    /* B300 8001AB00 05002016 */  bnez       $s1, .L8001AB18
    /* B304 8001AB04 1000A2AF */   sw        $v0, 0x10($sp)
    /* B308 8001AB08 20000386 */  lh         $v1, 0x20($s0)
    /* B30C 8001AB0C 0E000224 */  addiu      $v0, $zero, 0xE
    /* B310 8001AB10 03006210 */  beq        $v1, $v0, .L8001AB20
    /* B314 8001AB14 2000A527 */   addiu     $a1, $sp, 0x20
  .L8001AB18:
    /* B318 8001AB18 01000424 */  addiu      $a0, $zero, 0x1
    /* B31C 8001AB1C 2000A527 */  addiu      $a1, $sp, 0x20
  .L8001AB20:
    /* B320 8001AB20 01000224 */  addiu      $v0, $zero, 0x1
    /* B324 8001AB24 1400A4AF */  sw         $a0, 0x14($sp)
    /* B328 8001AB28 1800A2AF */  sw         $v0, 0x18($sp)
    /* B32C 8001AB2C 0400048E */  lw         $a0, 0x4($s0)
    /* B330 8001AB30 0668000C */  jal        MenuNFS4_DrawTextBox__FiR4RECTissbT5
    /* B334 8001AB34 8C000624 */   addiu     $a2, $zero, 0x8C
    /* B338 8001AB38 F62D030C */  jal        Font_ReSetBlitter__Fv
    /* B33C 8001AB3C 00000000 */   nop
  .L8001AB40:
    /* B340 8001AB40 3800BF8F */  lw         $ra, 0x38($sp)
    /* B344 8001AB44 3400B38F */  lw         $s3, 0x34($sp)
    /* B348 8001AB48 3000B28F */  lw         $s2, 0x30($sp)
    /* B34C 8001AB4C 2C00B18F */  lw         $s1, 0x2C($sp)
    /* B350 8001AB50 2800B08F */  lw         $s0, 0x28($sp)
    /* B354 8001AB54 0800E003 */  jr         $ra
    /* B358 8001AB58 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Draw__28tMenuItemNFS4LeftRightChoiceiib
