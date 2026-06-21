.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuNFS4_DrawTextBox__FiR4RECTissbT5, 0x494

glabel MenuNFS4_DrawTextBox__FiR4RECTissbT5
    /* A818 8001A018 58FFBD27 */  addiu      $sp, $sp, -0xA8
    /* A81C 8001A01C 8400B1AF */  sw         $s1, 0x84($sp)
    /* A820 8001A020 21888000 */  addu       $s1, $a0, $zero
    /* A824 8001A024 8C00B3AF */  sw         $s3, 0x8C($sp)
    /* A828 8001A028 2198A000 */  addu       $s3, $a1, $zero
    /* A82C 8001A02C 1480023C */  lui        $v0, %hi(Draw_gPlayer1View)
    /* A830 8001A030 CCD3448C */  lw         $a0, %lo(Draw_gPlayer1View)($v0)
    /* A834 8001A034 1480023C */  lui        $v0, %hi(gFlip)
    /* A838 8001A038 B4D7458C */  lw         $a1, %lo(gFlip)($v0)
    /* A83C 8001A03C 8000B0AF */  sw         $s0, 0x80($sp)
    /* A840 8001A040 B800B08F */  lw         $s0, 0xB8($sp)
    /* A844 8001A044 9C00B7AF */  sw         $s7, 0x9C($sp)
    /* A848 8001A048 C000B78F */  lw         $s7, 0xC0($sp)
    /* A84C 8001A04C 9400B5AF */  sw         $s5, 0x94($sp)
    /* A850 8001A050 21A8C000 */  addu       $s5, $a2, $zero
    /* A854 8001A054 9800B6AF */  sw         $s6, 0x98($sp)
    /* A858 8001A058 21B0E000 */  addu       $s6, $a3, $zero
    /* A85C 8001A05C A400BFAF */  sw         $ra, 0xA4($sp)
    /* A860 8001A060 A000BEAF */  sw         $fp, 0xA0($sp)
    /* A864 8001A064 9000B4AF */  sw         $s4, 0x90($sp)
    /* A868 8001A068 67F7020C */  jal        Draw_GetDRAWENV__Fii
    /* A86C 8001A06C 8800B2AF */   sw        $s2, 0x88($sp)
    /* A870 8001A070 B500043C */  lui        $a0, (0xB54200 >> 16)
    /* A874 8001A074 00428434 */  ori        $a0, $a0, (0xB54200 & 0xFFFF)
    /* A878 8001A078 BEBE0534 */  ori        $a1, $zero, 0xBEBE
    /* A87C 8001A07C 00841000 */  sll        $s0, $s0, 16
    /* A880 8001A080 03941000 */  sra        $s2, $s0, 16
    /* A884 8001A084 21304002 */  addu       $a2, $s2, $zero
    /* A888 8001A088 FE2D010C */  jal        CalcFadeVal__Fiii
    /* A88C 8001A08C 21F04000 */   addu      $fp, $v0, $zero
    /* A890 8001A090 0800E012 */  beqz       $s7, .L8001A0B4
    /* A894 8001A094 2C00A2AF */   sw        $v0, 0x2C($sp)
    /* A898 8001A098 21200000 */  addu       $a0, $zero, $zero
    /* A89C 8001A09C 21284000 */  addu       $a1, $v0, $zero
    /* A8A0 8001A0A0 02006286 */  lh         $v0, 0x2($s3)
    /* A8A4 8001A0A4 E0000624 */  addiu      $a2, $zero, 0xE0
    /* A8A8 8001A0A8 FE2D010C */  jal        CalcFadeVal__Fiii
    /* A8AC 8001A0AC 2330C200 */   subu      $a2, $a2, $v0
    /* A8B0 8001A0B0 2C00A2AF */  sw         $v0, 0x2C($sp)
  .L8001A0B4:
    /* A8B4 8001A0B4 802F010C */  jal        DrawShape_SubtractNFS4RectEdges__FR4RECT
    /* A8B8 8001A0B8 21206002 */   addu      $a0, $s3, $zero
    /* A8BC 8001A0BC C4002006 */  bltz       $s1, .L8001A3D0
    /* A8C0 8001A0C0 801F093C */   lui       $t1, (0x1F800004 >> 16)
    /* A8C4 8001A0C4 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* A8C8 8001A0C8 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* A8CC 8001A0CC FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* A8D0 8001A0D0 0000248D */  lw         $a0, 0x0($t1)
    /* A8D4 8001A0D4 2000A527 */  addiu      $a1, $sp, 0x20
    /* A8D8 8001A0D8 2000A0A7 */  sh         $zero, 0x20($sp)
    /* A8DC 8001A0DC 0200C397 */  lhu        $v1, 0x2($fp)
    /* A8E0 8001A0E0 00020224 */  addiu      $v0, $zero, 0x200
    /* A8E4 8001A0E4 2400A2A7 */  sh         $v0, 0x24($sp)
    /* A8E8 8001A0E8 F0000224 */  addiu      $v0, $zero, 0xF0
    /* A8EC 8001A0EC 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* A8F0 8001A0F0 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* A8F4 8001A0F4 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* A8F8 8001A0F8 2600A2A7 */  sh         $v0, 0x26($sp)
    /* A8FC 8001A0FC 2200A3A7 */  sh         $v1, 0x22($sp)
    /* A900 8001A100 0000838C */  lw         $v1, 0x0($a0)
    /* A904 8001A104 0000C28C */  lw         $v0, 0x0($a2)
    /* A908 8001A108 24186800 */  and        $v1, $v1, $t0
    /* A90C 8001A10C 24104700 */  and        $v0, $v0, $a3
    /* A910 8001A110 25186200 */  or         $v1, $v1, $v0
    /* A914 8001A114 000083AC */  sw         $v1, 0x0($a0)
    /* A918 8001A118 0000C28C */  lw         $v0, 0x0($a2)
    /* A91C 8001A11C 0C008324 */  addiu      $v1, $a0, 0xC
    /* A920 8001A120 000023AD */  sw         $v1, 0x0($t1)
    /* A924 8001A124 24188700 */  and        $v1, $a0, $a3
    /* A928 8001A128 24104800 */  and        $v0, $v0, $t0
    /* A92C 8001A12C 25104300 */  or         $v0, $v0, $v1
    /* A930 8001A130 C5B8030C */  jal        SetDrawArea
    /* A934 8001A134 0000C2AC */   sw        $v0, 0x0($a2)
    /* A938 8001A138 3683000C */  jal        FETextRender_SetFont__Fi
    /* A93C 8001A13C 21200000 */   addu      $a0, $zero, $zero
    /* A940 8001A140 94E4020C */  jal        TextSys_Word__Fi
    /* A944 8001A144 21202002 */   addu      $a0, $s1, $zero
    /* A948 8001A148 4000B027 */  addiu      $s0, $sp, 0x40
    /* A94C 8001A14C 21200002 */  addu       $a0, $s0, $zero
    /* A950 8001A150 0180053C */  lui        $a1, %hi(D_8001061C)
    /* A954 8001A154 1C06A524 */  addiu      $a1, $a1, %lo(D_8001061C)
    /* A958 8001A158 2F91030C */  jal        sprintf
    /* A95C 8001A15C 21304000 */   addu      $a2, $v0, $zero
    /* A960 8001A160 3C9A000C */  jal        s_upper__FPc
    /* A964 8001A164 21200002 */   addu      $a0, $s0, $zero
    /* A968 8001A168 888F030C */  jal        textpixels
    /* A96C 8001A16C 21200002 */   addu      $a0, $s0, $zero
    /* A970 8001A170 21200002 */  addu       $a0, $s0, $zero
    /* A974 8001A174 DDA7030C */  jal        strlen
    /* A978 8001A178 21804000 */   addu      $s0, $v0, $zero
    /* A97C 8001A17C 23A00202 */  subu       $s4, $s0, $v0
    /* A980 8001A180 2A109502 */  slt        $v0, $s4, $s5
    /* A984 8001A184 02004010 */  beqz       $v0, .L8001A190
    /* A988 8001A188 21188002 */   addu      $v1, $s4, $zero
    /* A98C 8001A18C 2118A002 */  addu       $v1, $s5, $zero
  .L8001A190:
    /* A990 8001A190 01000424 */  addiu      $a0, $zero, 0x1
    /* A994 8001A194 21284002 */  addu       $a1, $s2, $zero
    /* A998 8001A198 21300000 */  addu       $a2, $zero, $zero
    /* A99C 8001A19C 542E010C */  jal        CalcTextFadeSelToHi__F13tMenuTextTypess
    /* A9A0 8001A1A0 19007524 */   addiu     $s5, $v1, 0x19
    /* A9A4 8001A1A4 0800E012 */  beqz       $s7, .L8001A1C8
    /* A9A8 8001A1A8 21804000 */   addu      $s0, $v0, $zero
    /* A9AC 8001A1AC 21200000 */  addu       $a0, $zero, $zero
    /* A9B0 8001A1B0 21280002 */  addu       $a1, $s0, $zero
    /* A9B4 8001A1B4 02006286 */  lh         $v0, 0x2($s3)
    /* A9B8 8001A1B8 F0000624 */  addiu      $a2, $zero, 0xF0
    /* A9BC 8001A1BC FE2D010C */  jal        CalcFadeVal__Fiii
    /* A9C0 8001A1C0 2330C200 */   subu      $a2, $a2, $v0
    /* A9C4 8001A1C4 21804000 */  addu       $s0, $v0, $zero
  .L8001A1C8:
    /* A9C8 8001A1C8 94E4020C */  jal        TextSys_Word__Fi
    /* A9CC 8001A1CC 21202002 */   addu      $a0, $s1, $zero
    /* A9D0 8001A1D0 21204000 */  addu       $a0, $v0, $zero
    /* A9D4 8001A1D4 00006596 */  lhu        $a1, 0x0($s3)
    /* A9D8 8001A1D8 02006696 */  lhu        $a2, 0x2($s3)
    /* A9DC 8001A1DC 21380002 */  addu       $a3, $s0, $zero
    /* A9E0 8001A1E0 1000A0AF */  sw         $zero, 0x10($sp)
    /* A9E4 8001A1E4 1400A0AF */  sw         $zero, 0x14($sp)
    /* A9E8 8001A1E8 2128B600 */  addu       $a1, $a1, $s6
    /* A9EC 8001A1EC 002C0500 */  sll        $a1, $a1, 16
    /* A9F0 8001A1F0 032C0500 */  sra        $a1, $a1, 16
    /* A9F4 8001A1F4 0400C624 */  addiu      $a2, $a2, 0x4
    /* A9F8 8001A1F8 00340600 */  sll        $a2, $a2, 16
    /* A9FC 8001A1FC 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* AA00 8001A200 03340600 */   sra       $a2, $a2, 16
    /* AA04 8001A204 94E4020C */  jal        TextSys_Word__Fi
    /* AA08 8001A208 21202002 */   addu      $a0, $s1, $zero
    /* AA0C 8001A20C 21204000 */  addu       $a0, $v0, $zero
    /* AA10 8001A210 00006596 */  lhu        $a1, 0x0($s3)
    /* AA14 8001A214 02006696 */  lhu        $a2, 0x2($s3)
    /* AA18 8001A218 21380002 */  addu       $a3, $s0, $zero
    /* AA1C 8001A21C 1000A0AF */  sw         $zero, 0x10($sp)
    /* AA20 8001A220 1400A0AF */  sw         $zero, 0x14($sp)
    /* AA24 8001A224 2128B600 */  addu       $a1, $a1, $s6
    /* AA28 8001A228 2328B500 */  subu       $a1, $a1, $s5
    /* AA2C 8001A22C 002C0500 */  sll        $a1, $a1, 16
    /* AA30 8001A230 032C0500 */  sra        $a1, $a1, 16
    /* AA34 8001A234 0400C624 */  addiu      $a2, $a2, 0x4
    /* AA38 8001A238 00340600 */  sll        $a2, $a2, 16
    /* AA3C 8001A23C 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* AA40 8001A240 03340600 */   sra       $a2, $a2, 16
    /* AA44 8001A244 BC00AA8F */  lw         $t2, 0xBC($sp)
    /* AA48 8001A248 00000000 */  nop
    /* AA4C 8001A24C 38004011 */  beqz       $t2, .L8001A330
    /* AA50 8001A250 801F093C */   lui       $t1, (0x1F800004 >> 16)
    /* AA54 8001A254 06006296 */  lhu        $v0, 0x6($s3)
    /* AA58 8001A258 02006386 */  lh         $v1, 0x2($s3)
    /* AA5C 8001A25C 00140200 */  sll        $v0, $v0, 16
    /* AA60 8001A260 43140200 */  sra        $v0, $v0, 17
    /* AA64 8001A264 0200E016 */  bnez       $s7, .L8001A270
    /* AA68 8001A268 21906200 */   addu      $s2, $v1, $v0
    /* AA6C 8001A26C 02005226 */  addiu      $s2, $s2, 0x2
  .L8001A270:
    /* AA70 8001A270 0A000424 */  addiu      $a0, $zero, 0xA
    /* AA74 8001A274 18010524 */  addiu      $a1, $zero, 0x118
    /* AA78 8001A278 21384002 */  addu       $a3, $s2, $zero
    /* AA7C 8001A27C 2800B127 */  addiu      $s1, $sp, 0x28
    /* AA80 8001A280 00841600 */  sll        $s0, $s6, 16
    /* AA84 8001A284 00006686 */  lh         $a2, 0x0($s3)
    /* AA88 8001A288 03841000 */  sra        $s0, $s0, 16
    /* AA8C 8001A28C 1000A0AF */  sw         $zero, 0x10($sp)
    /* AA90 8001A290 1400A0AF */  sw         $zero, 0x14($sp)
    /* AA94 8001A294 1800B1AF */  sw         $s1, 0x18($sp)
    /* AA98 8001A298 2130D000 */  addu       $a2, $a2, $s0
    /* AA9C 8001A29C 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* AAA0 8001A2A0 F6FFC624 */   addiu     $a2, $a2, -0xA
    /* AAA4 8001A2A4 0B000424 */  addiu      $a0, $zero, 0xB
    /* AAA8 8001A2A8 18010524 */  addiu      $a1, $zero, 0x118
    /* AAAC 8001A2AC 00006686 */  lh         $a2, 0x0($s3)
    /* AAB0 8001A2B0 21384002 */  addu       $a3, $s2, $zero
    /* AAB4 8001A2B4 1000A0AF */  sw         $zero, 0x10($sp)
    /* AAB8 8001A2B8 1400A0AF */  sw         $zero, 0x14($sp)
    /* AABC 8001A2BC 1800B1AF */  sw         $s1, 0x18($sp)
    /* AAC0 8001A2C0 2130D000 */  addu       $a2, $a2, $s0
    /* AAC4 8001A2C4 2130D400 */  addu       $a2, $a2, $s4
    /* AAC8 8001A2C8 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* AACC 8001A2CC 0800C624 */   addiu     $a2, $a2, 0x8
    /* AAD0 8001A2D0 0A000424 */  addiu      $a0, $zero, 0xA
    /* AAD4 8001A2D4 18010524 */  addiu      $a1, $zero, 0x118
    /* AAD8 8001A2D8 00006686 */  lh         $a2, 0x0($s3)
    /* AADC 8001A2DC 21384002 */  addu       $a3, $s2, $zero
    /* AAE0 8001A2E0 1000A0AF */  sw         $zero, 0x10($sp)
    /* AAE4 8001A2E4 1400A0AF */  sw         $zero, 0x14($sp)
    /* AAE8 8001A2E8 1800B1AF */  sw         $s1, 0x18($sp)
    /* AAEC 8001A2EC 2130D000 */  addu       $a2, $a2, $s0
    /* AAF0 8001A2F0 2330D500 */  subu       $a2, $a2, $s5
    /* AAF4 8001A2F4 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* AAF8 8001A2F8 F6FFC624 */   addiu     $a2, $a2, -0xA
    /* AAFC 8001A2FC 0B000424 */  addiu      $a0, $zero, 0xB
    /* AB00 8001A300 18010524 */  addiu      $a1, $zero, 0x118
    /* AB04 8001A304 00006686 */  lh         $a2, 0x0($s3)
    /* AB08 8001A308 21384002 */  addu       $a3, $s2, $zero
    /* AB0C 8001A30C 1000A0AF */  sw         $zero, 0x10($sp)
    /* AB10 8001A310 1400A0AF */  sw         $zero, 0x14($sp)
    /* AB14 8001A314 1800B1AF */  sw         $s1, 0x18($sp)
    /* AB18 8001A318 2130D000 */  addu       $a2, $a2, $s0
    /* AB1C 8001A31C 2330D500 */  subu       $a2, $a2, $s5
    /* AB20 8001A320 2130D400 */  addu       $a2, $a2, $s4
    /* AB24 8001A324 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* AB28 8001A328 0800C624 */   addiu     $a2, $a2, 0x8
    /* AB2C 8001A32C 801F093C */  lui        $t1, (0x1F800004 >> 16)
  .L8001A330:
    /* AB30 8001A330 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* AB34 8001A334 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* AB38 8001A338 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* AB3C 8001A33C 2000A527 */  addiu      $a1, $sp, 0x20
    /* AB40 8001A340 0000248D */  lw         $a0, 0x0($t1)
    /* AB44 8001A344 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* AB48 8001A348 03006B8A */  lwl        $t3, 0x3($s3)
    /* AB4C 8001A34C 00006B9A */  lwr        $t3, 0x0($s3)
    /* AB50 8001A350 07006C8A */  lwl        $t4, 0x7($s3)
    /* AB54 8001A354 04006C9A */  lwr        $t4, 0x4($s3)
    /* AB58 8001A358 2300ABAB */  swl        $t3, 0x23($sp)
    /* AB5C 8001A35C 2000ABBB */  swr        $t3, 0x20($sp)
    /* AB60 8001A360 2700ACAB */  swl        $t4, 0x27($sp)
    /* AB64 8001A364 2400ACBB */  swr        $t4, 0x24($sp)
    /* AB68 8001A368 2200A297 */  lhu        $v0, 0x22($sp)
    /* AB6C 8001A36C 0200C397 */  lhu        $v1, 0x2($fp)
    /* AB70 8001A370 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* AB74 8001A374 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* AB78 8001A378 21104300 */  addu       $v0, $v0, $v1
    /* AB7C 8001A37C 2200A2A7 */  sh         $v0, 0x22($sp)
    /* AB80 8001A380 2000A297 */  lhu        $v0, 0x20($sp)
    /* AB84 8001A384 2400A397 */  lhu        $v1, 0x24($sp)
    /* AB88 8001A388 02004224 */  addiu      $v0, $v0, 0x2
    /* AB8C 8001A38C FCFF6324 */  addiu      $v1, $v1, -0x4
    /* AB90 8001A390 2000A2A7 */  sh         $v0, 0x20($sp)
    /* AB94 8001A394 2400A3A7 */  sh         $v1, 0x24($sp)
    /* AB98 8001A398 0000838C */  lw         $v1, 0x0($a0)
    /* AB9C 8001A39C 0000C28C */  lw         $v0, 0x0($a2)
    /* ABA0 8001A3A0 24186800 */  and        $v1, $v1, $t0
    /* ABA4 8001A3A4 24104700 */  and        $v0, $v0, $a3
    /* ABA8 8001A3A8 25186200 */  or         $v1, $v1, $v0
    /* ABAC 8001A3AC 000083AC */  sw         $v1, 0x0($a0)
    /* ABB0 8001A3B0 0000C28C */  lw         $v0, 0x0($a2)
    /* ABB4 8001A3B4 0C008324 */  addiu      $v1, $a0, 0xC
    /* ABB8 8001A3B8 000023AD */  sw         $v1, 0x0($t1)
    /* ABBC 8001A3BC 24188700 */  and        $v1, $a0, $a3
    /* ABC0 8001A3C0 24104800 */  and        $v0, $v0, $t0
    /* ABC4 8001A3C4 25104300 */  or         $v0, $v0, $v1
    /* ABC8 8001A3C8 C5B8030C */  jal        SetDrawArea
    /* ABCC 8001A3CC 0000C2AC */   sw        $v0, 0x0($a2)
  .L8001A3D0:
    /* ABD0 8001A3D0 1E000424 */  addiu      $a0, $zero, 0x1E
    /* ABD4 8001A3D4 08000524 */  addiu      $a1, $zero, 0x8
    /* ABD8 8001A3D8 0580033C */  lui        $v1, %hi(gHelpShapes)
    /* ABDC 8001A3DC 03006B8A */  lwl        $t3, 0x3($s3)
    /* ABE0 8001A3E0 00006B9A */  lwr        $t3, 0x0($s3)
    /* ABE4 8001A3E4 07006C8A */  lwl        $t4, 0x7($s3)
    /* ABE8 8001A3E8 04006C9A */  lwr        $t4, 0x4($s3)
    /* ABEC 8001A3EC 2300ABAB */  swl        $t3, 0x23($sp)
    /* ABF0 8001A3F0 2000ABBB */  swr        $t3, 0x20($sp)
    /* ABF4 8001A3F4 2700ACAB */  swl        $t4, 0x27($sp)
    /* ABF8 8001A3F8 2400ACBB */  swr        $t4, 0x24($sp)
    /* ABFC 8001A3FC 2200A297 */  lhu        $v0, 0x22($sp)
    /* AC00 8001A400 642A708C */  lw         $s0, %lo(gHelpShapes)($v1)
    /* AC04 8001A404 2400A397 */  lhu        $v1, 0x24($sp)
    /* AC08 8001A408 01004224 */  addiu      $v0, $v0, 0x1
    /* AC0C 8001A40C 003C0200 */  sll        $a3, $v0, 16
    /* AC10 8001A410 033C0700 */  sra        $a3, $a3, 16
    /* AC14 8001A414 2200A2A7 */  sh         $v0, 0x22($sp)
    /* AC18 8001A418 2600A297 */  lhu        $v0, 0x26($sp)
    /* AC1C 8001A41C C0031026 */  addiu      $s0, $s0, 0x3C0
    /* AC20 8001A420 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* AC24 8001A424 2600A2A7 */  sh         $v0, 0x26($sp)
    /* AC28 8001A428 10000296 */  lhu        $v0, 0x10($s0)
    /* AC2C 8001A42C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* AC30 8001A430 00140200 */  sll        $v0, $v0, 16
    /* AC34 8001A434 43140200 */  sra        $v0, $v0, 17
    /* AC38 8001A438 23186200 */  subu       $v1, $v1, $v0
    /* AC3C 8001A43C 00340300 */  sll        $a2, $v1, 16
    /* AC40 8001A440 2000A287 */  lh         $v0, 0x20($sp)
    /* AC44 8001A444 03340600 */  sra        $a2, $a2, 16
    /* AC48 8001A448 2400A3A7 */  sh         $v1, 0x24($sp)
    /* AC4C 8001A44C 1000A0AF */  sw         $zero, 0x10($sp)
    /* AC50 8001A450 1400A0AF */  sw         $zero, 0x14($sp)
    /* AC54 8001A454 1800A0AF */  sw         $zero, 0x18($sp)
    /* AC58 8001A458 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* AC5C 8001A45C 21304600 */   addu      $a2, $v0, $a2
    /* AC60 8001A460 2000A587 */  lh         $a1, 0x20($sp)
    /* AC64 8001A464 2200A687 */  lh         $a2, 0x22($sp)
    /* AC68 8001A468 2400A787 */  lh         $a3, 0x24($sp)
    /* AC6C 8001A46C 12000286 */  lh         $v0, 0x12($s0)
    /* AC70 8001A470 21200000 */  addu       $a0, $zero, $zero
    /* AC74 8001A474 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* AC78 8001A478 1000A2AF */   sw        $v0, 0x10($sp)
    /* AC7C 8001A47C A400BF8F */  lw         $ra, 0xA4($sp)
    /* AC80 8001A480 A000BE8F */  lw         $fp, 0xA0($sp)
    /* AC84 8001A484 9C00B78F */  lw         $s7, 0x9C($sp)
    /* AC88 8001A488 9800B68F */  lw         $s6, 0x98($sp)
    /* AC8C 8001A48C 9400B58F */  lw         $s5, 0x94($sp)
    /* AC90 8001A490 9000B48F */  lw         $s4, 0x90($sp)
    /* AC94 8001A494 8C00B38F */  lw         $s3, 0x8C($sp)
    /* AC98 8001A498 8800B28F */  lw         $s2, 0x88($sp)
    /* AC9C 8001A49C 8400B18F */  lw         $s1, 0x84($sp)
    /* ACA0 8001A4A0 8000B08F */  lw         $s0, 0x80($sp)
    /* ACA4 8001A4A4 0800E003 */  jr         $ra
    /* ACA8 8001A4A8 A800BD27 */   addiu     $sp, $sp, 0xA8
endlabel MenuNFS4_DrawTextBox__FiR4RECTissbT5
