.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__18tScreenTournSelect, 0x67C

glabel DrawBackground__18tScreenTournSelect
    /* 3065C 8003FE5C 10FFBD27 */  addiu      $sp, $sp, -0xF0
    /* 30660 8003FE60 1180023C */  lui        $v0, %hi(frontEnd)
    /* 30664 8003FE64 00464324 */  addiu      $v1, $v0, %lo(frontEnd)
    /* 30668 8003FE68 EC00BFAF */  sw         $ra, 0xEC($sp)
    /* 3066C 8003FE6C E800BEAF */  sw         $fp, 0xE8($sp)
    /* 30670 8003FE70 E400B7AF */  sw         $s7, 0xE4($sp)
    /* 30674 8003FE74 E000B6AF */  sw         $s6, 0xE0($sp)
    /* 30678 8003FE78 DC00B5AF */  sw         $s5, 0xDC($sp)
    /* 3067C 8003FE7C D800B4AF */  sw         $s4, 0xD8($sp)
    /* 30680 8003FE80 D400B3AF */  sw         $s3, 0xD4($sp)
    /* 30684 8003FE84 D000B2AF */  sw         $s2, 0xD0($sp)
    /* 30688 8003FE88 CC00B1AF */  sw         $s1, 0xCC($sp)
    /* 3068C 8003FE8C C800B0AF */  sw         $s0, 0xC8($sp)
    /* 30690 8003FE90 22016290 */  lbu        $v0, 0x122($v1)
    /* 30694 8003FE94 00000000 */  nop
    /* 30698 8003FE98 04004010 */  beqz       $v0, .L8003FEAC
    /* 3069C 8003FE9C 21A08000 */   addu      $s4, $a0, $zero
    /* 306A0 8003FEA0 21016790 */  lbu        $a3, 0x121($v1)
    /* 306A4 8003FEA4 ADFF0008 */  j          .L8003FEB4
    /* 306A8 8003FEA8 BEBE0434 */   ori       $a0, $zero, 0xBEBE
  .L8003FEAC:
    /* 306AC 8003FEAC 20016790 */  lbu        $a3, 0x120($v1)
    /* 306B0 8003FEB0 BEBE0434 */  ori        $a0, $zero, 0xBEBE
  .L8003FEB4:
    /* 306B4 8003FEB4 21900000 */  addu       $s2, $zero, $zero
    /* 306B8 8003FEB8 1180103C */  lui        $s0, %hi(tournamentManager)
    /* 306BC 8003FEBC D84A1026 */  addiu      $s0, $s0, %lo(tournamentManager)
    /* 306C0 8003FEC0 22016390 */  lbu        $v1, 0x122($v1)
    /* 306C4 8003FEC4 1800068E */  lw         $a2, 0x18($s0)
    /* 306C8 8003FEC8 40100300 */  sll        $v0, $v1, 1
    /* 306CC 8003FECC 21104300 */  addu       $v0, $v0, $v1
    /* 306D0 8003FED0 80100200 */  sll        $v0, $v0, 2
    /* 306D4 8003FED4 2110C200 */  addu       $v0, $a2, $v0
    /* 306D8 8003FED8 02004390 */  lbu        $v1, 0x2($v0)
    /* 306DC 8003FEDC 5C008586 */  lh         $a1, 0x5C($s4)
    /* 306E0 8003FEE0 2118E300 */  addu       $v1, $a3, $v1
    /* 306E4 8003FEE4 80100300 */  sll        $v0, $v1, 2
    /* 306E8 8003FEE8 21104300 */  addu       $v0, $v0, $v1
    /* 306EC 8003FEEC 80100200 */  sll        $v0, $v0, 2
    /* 306F0 8003FEF0 21104300 */  addu       $v0, $v0, $v1
    /* 306F4 8003FEF4 80100200 */  sll        $v0, $v0, 2
    /* 306F8 8003FEF8 24004224 */  addiu      $v0, $v0, 0x24
    /* 306FC 8003FEFC 222E010C */  jal        CalcFadeVal__Fii
    /* 30700 8003FF00 21B8C200 */   addu      $s7, $a2, $v0
    /* 30704 8003FF04 2300043C */  lui        $a0, (0x232323 >> 16)
    /* 30708 8003FF08 23238434 */  ori        $a0, $a0, (0x232323 & 0xFFFF)
    /* 3070C 8003FF0C 5C008586 */  lh         $a1, 0x5C($s4)
    /* 30710 8003FF10 222E010C */  jal        CalcFadeVal__Fii
    /* 30714 8003FF14 21B04000 */   addu      $s6, $v0, $zero
    /* 30718 8003FF18 5000043C */  lui        $a0, (0x505050 >> 16)
    /* 3071C 8003FF1C 50508434 */  ori        $a0, $a0, (0x505050 & 0xFFFF)
    /* 30720 8003FF20 5C008586 */  lh         $a1, 0x5C($s4)
    /* 30724 8003FF24 222E010C */  jal        CalcFadeVal__Fii
    /* 30728 8003FF28 21A84000 */   addu      $s5, $v0, $zero
    /* 3072C 8003FF2C 7B000524 */  addiu      $a1, $zero, 0x7B
    /* 30730 8003FF30 01000624 */  addiu      $a2, $zero, 0x1
    /* 30734 8003FF34 04000724 */  addiu      $a3, $zero, 0x4
    /* 30738 8003FF38 5C008486 */  lh         $a0, 0x5C($s4)
    /* 3073C 8003FF3C 1400118E */  lw         $s1, 0x14($s0)
    /* 30740 8003FF40 2D84000C */  jal        FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
    /* 30744 8003FF44 21F04000 */   addu      $fp, $v0, $zero
    /* 30748 8003FF48 A4E4020C */  jal        TextSys_WordX__Fi
    /* 3074C 8003FF4C 7B000424 */   addiu     $a0, $zero, 0x7B
    /* 30750 8003FF50 7B000424 */  addiu      $a0, $zero, 0x7B
    /* 30754 8003FF54 ACE4020C */  jal        TextSys_WordY__Fi
    /* 30758 8003FF58 8C005024 */   addiu     $s0, $v0, 0x8C
    /* 3075C 8003FF5C 21200002 */  addu       $a0, $s0, $zero
    /* 30760 8003FF60 09004524 */  addiu      $a1, $v0, 0x9
    /* 30764 8003FF64 06000624 */  addiu      $a2, $zero, 0x6
    /* 30768 8003FF68 21382002 */  addu       $a3, $s1, $zero
    /* 3076C 8003FF6C 1000B6AF */  sw         $s6, 0x10($sp)
    /* 30770 8003FF70 FCE5000C */  jal        DrawMoney__Fiiilii
    /* 30774 8003FF74 1400B5AF */   sw        $s5, 0x14($sp)
    /* 30778 8003FF78 99000524 */  addiu      $a1, $zero, 0x99
    /* 3077C 8003FF7C 01000624 */  addiu      $a2, $zero, 0x1
    /* 30780 8003FF80 5C008486 */  lh         $a0, 0x5C($s4)
    /* 30784 8003FF84 2D84000C */  jal        FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
    /* 30788 8003FF88 0E000724 */   addiu     $a3, $zero, 0xE
    /* 3078C 8003FF8C A4E4020C */  jal        TextSys_WordX__Fi
    /* 30790 8003FF90 99000424 */   addiu     $a0, $zero, 0x99
    /* 30794 8003FF94 99000424 */  addiu      $a0, $zero, 0x99
    /* 30798 8003FF98 ACE4020C */  jal        TextSys_WordY__Fi
    /* 3079C 8003FF9C 8C005024 */   addiu     $s0, $v0, 0x8C
    /* 307A0 8003FFA0 21200002 */  addu       $a0, $s0, $zero
    /* 307A4 8003FFA4 09004524 */  addiu      $a1, $v0, 0x9
    /* 307A8 8003FFA8 1000B6AF */  sw         $s6, 0x10($sp)
    /* 307AC 8003FFAC 1400B5AF */  sw         $s5, 0x14($sp)
    /* 307B0 8003FFB0 3000E78E */  lw         $a3, 0x30($s7)
    /* 307B4 8003FFB4 FCE5000C */  jal        DrawMoney__Fiiilii
    /* 307B8 8003FFB8 06000624 */   addiu     $a2, $zero, 0x6
    /* 307BC 8003FFBC 9A000524 */  addiu      $a1, $zero, 0x9A
    /* 307C0 8003FFC0 01000624 */  addiu      $a2, $zero, 0x1
    /* 307C4 8003FFC4 5C008486 */  lh         $a0, 0x5C($s4)
    /* 307C8 8003FFC8 2D84000C */  jal        FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
    /* 307CC 8003FFCC 0E000724 */   addiu     $a3, $zero, 0xE
    /* 307D0 8003FFD0 ACE4020C */  jal        TextSys_WordY__Fi
    /* 307D4 8003FFD4 9A000424 */   addiu     $a0, $zero, 0x9A
    /* 307D8 8003FFD8 09005324 */  addiu      $s3, $v0, 0x9
  .L8003FFDC:
    /* 307DC 8003FFDC 008C1200 */  sll        $s1, $s2, 16
    /* 307E0 8003FFE0 038C1100 */  sra        $s1, $s1, 16
    /* 307E4 8003FFE4 94E4020C */  jal        TextSys_Word__Fi
    /* 307E8 8003FFE8 D4022426 */   addiu     $a0, $s1, 0x2D4
    /* 307EC 8003FFEC 9A000424 */  addiu      $a0, $zero, 0x9A
    /* 307F0 8003FFF0 A4E4020C */  jal        TextSys_WordX__Fi
    /* 307F4 8003FFF4 21804000 */   addu      $s0, $v0, $zero
    /* 307F8 8003FFF8 21200002 */  addu       $a0, $s0, $zero
    /* 307FC 8003FFFC 00140200 */  sll        $v0, $v0, 16
    /* 30800 80040000 032C0200 */  sra        $a1, $v0, 16
    /* 30804 80040004 00841300 */  sll        $s0, $s3, 16
    /* 30808 80040008 03841000 */  sra        $s0, $s0, 16
    /* 3080C 8004000C 21300002 */  addu       $a2, $s0, $zero
    /* 30810 80040010 2138C003 */  addu       $a3, $fp, $zero
    /* 30814 80040014 1000A0AF */  sw         $zero, 0x10($sp)
    /* 30818 80040018 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 3081C 8004001C 1400A0AF */   sw        $zero, 0x14($sp)
    /* 30820 80040020 A4E4020C */  jal        TextSys_WordX__Fi
    /* 30824 80040024 99000424 */   addiu     $a0, $zero, 0x99
    /* 30828 80040028 8C004424 */  addiu      $a0, $v0, 0x8C
    /* 3082C 8004002C 21280002 */  addu       $a1, $s0, $zero
    /* 30830 80040030 06000624 */  addiu      $a2, $zero, 0x6
    /* 30834 80040034 80881100 */  sll        $s1, $s1, 2
    /* 30838 80040038 2188F102 */  addu       $s1, $s7, $s1
    /* 3083C 8004003C 1000B6AF */  sw         $s6, 0x10($sp)
    /* 30840 80040040 1400B5AF */  sw         $s5, 0x14($sp)
    /* 30844 80040044 1800278E */  lw         $a3, 0x18($s1)
    /* 30848 80040048 FCE5000C */  jal        DrawMoney__Fiiilii
    /* 3084C 8004004C 09007326 */   addiu     $s3, $s3, 0x9
    /* 30850 80040050 01004226 */  addiu      $v0, $s2, 0x1
    /* 30854 80040054 21904000 */  addu       $s2, $v0, $zero
    /* 30858 80040058 00140200 */  sll        $v0, $v0, 16
    /* 3085C 8004005C 03140200 */  sra        $v0, $v0, 16
    /* 30860 80040060 03004228 */  slti       $v0, $v0, 0x3
    /* 30864 80040064 DDFF4014 */  bnez       $v0, .L8003FFDC
    /* 30868 80040068 00000000 */   nop
    /* 3086C 8004006C 21208002 */  addu       $a0, $s4, $zero
    /* 30870 80040070 CAFE000C */  jal        UpdateVideoWall__18tScreenTournSelectP12tTourneyInfo
    /* 30874 80040074 2128E002 */   addu      $a1, $s7, $zero
    /* 30878 80040078 21208002 */  addu       $a0, $s4, $zero
    /* 3087C 8004007C 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 30880 80040080 28008526 */   addiu     $a1, $s4, 0x28
    /* 30884 80040084 2C00828E */  lw         $v0, 0x2C($s4)
    /* 30888 80040088 00000000 */  nop
    /* 3088C 8004008C 0C004010 */  beqz       $v0, .L800400C0
    /* 30890 80040090 00000000 */   nop
    /* 30894 80040094 B8028286 */  lh         $v0, 0x2B8($s4)
    /* 30898 80040098 00000000 */  nop
    /* 3089C 8004009C 08004004 */  bltz       $v0, .L800400C0
    /* 308A0 800400A0 21208002 */   addu      $a0, $s4, $zero
    /* 308A4 800400A4 F497000C */  jal        UploadSwapShapes__7tScreeni
    /* 308A8 800400A8 20000524 */   addiu     $a1, $zero, 0x20
    /* 308AC 800400AC 1480023C */  lui        $v0, %hi(ticks)
    /* 308B0 800400B0 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 308B4 800400B4 01000224 */  addiu      $v0, $zero, 0x1
    /* 308B8 800400B8 B80282A6 */  sh         $v0, 0x2B8($s4)
    /* 308BC 800400BC B40283AE */  sw         $v1, 0x2B4($s4)
  .L800400C0:
    /* 308C0 800400C0 F3FE000C */  jal        DrawVideoWall__18tScreenTournSelect
    /* 308C4 800400C4 21208002 */   addu      $a0, $s4, $zero
    /* 308C8 800400C8 6800828E */  lw         $v0, 0x68($s4)
    /* 308CC 800400CC 00000000 */  nop
    /* 308D0 800400D0 01004230 */  andi       $v0, $v0, 0x1
    /* 308D4 800400D4 02004014 */  bnez       $v0, .L800400E0
    /* 308D8 800400D8 21400000 */   addu      $t0, $zero, $zero
    /* 308DC 800400DC 50000824 */  addiu      $t0, $zero, 0x50
  .L800400E0:
    /* 308E0 800400E0 2C000A3C */  lui        $t2, (0x2C1E1E >> 16)
    /* 308E4 800400E4 1E1E4A35 */  ori        $t2, $t2, (0x2C1E1E & 0xFFFF)
    /* 308E8 800400E8 B800AAAF */  sw         $t2, 0xB8($sp)
    /* 308EC 800400EC 21900000 */  addu       $s2, $zero, $zero
    /* 308F0 800400F0 80000924 */  addiu      $t1, $zero, 0x80
  .L800400F4:
    /* 308F4 800400F4 21880000 */  addu       $s1, $zero, $zero
    /* 308F8 800400F8 001C1200 */  sll        $v1, $s2, 16
    /* 308FC 800400FC 031C0300 */  sra        $v1, $v1, 16
    /* 30900 80040100 40100300 */  sll        $v0, $v1, 1
    /* 30904 80040104 21104300 */  addu       $v0, $v0, $v1
    /* 30908 80040108 00110200 */  sll        $v0, $v0, 4
    /* 3090C 8004010C 29005E24 */  addiu      $fp, $v0, 0x29
    /* 30910 80040110 80980300 */  sll        $s3, $v1, 2
    /* 30914 80040114 21186302 */  addu       $v1, $s3, $v1
    /* 30918 80040118 C0B80300 */  sll        $s7, $v1, 3
    /* 3091C 8004011C 02000424 */  addiu      $a0, $zero, 0x2
  .L80040120:
    /* 30920 80040120 21280000 */  addu       $a1, $zero, $zero
    /* 30924 80040124 00020A24 */  addiu      $t2, $zero, 0x200
    /* 30928 80040128 00B40A00 */  sll        $s6, $t2, 16
    /* 3092C 8004012C 03341600 */  sra        $a2, $s6, 16
    /* 30930 80040130 00AC0800 */  sll        $s5, $t0, 16
    /* 30934 80040134 033C1500 */  sra        $a3, $s5, 16
    /* 30938 80040138 21103302 */  addu       $v0, $s1, $s3
    /* 3093C 8004013C 00140200 */  sll        $v0, $v0, 16
    /* 30940 80040140 03140200 */  sra        $v0, $v0, 16
    /* 30944 80040144 40800200 */  sll        $s0, $v0, 1
    /* 30948 80040148 21800202 */  addu       $s0, $s0, $v0
    /* 3094C 8004014C 00811000 */  sll        $s0, $s0, 4
    /* 30950 80040150 21809002 */  addu       $s0, $s4, $s0
    /* 30954 80040154 00141100 */  sll        $v0, $s1, 16
    /* 30958 80040158 03140200 */  sra        $v0, $v0, 16
    /* 3095C 8004015C 04188200 */  sllv       $v1, $v0, $a0
    /* 30960 80040160 21186200 */  addu       $v1, $v1, $v0
    /* 30964 80040164 00110300 */  sll        $v0, $v1, 4
    /* 30968 80040168 A5004224 */  addiu      $v0, $v0, 0xA5
    /* 3096C 8004016C 800002A6 */  sh         $v0, 0x80($s0)
    /* 30970 80040170 50000224 */  addiu      $v0, $zero, 0x50
    /* 30974 80040174 840002A6 */  sh         $v0, 0x84($s0)
    /* 30978 80040178 30000224 */  addiu      $v0, $zero, 0x30
    /* 3097C 8004017C 04188300 */  sllv       $v1, $v1, $a0
    /* 30980 80040180 860002A6 */  sh         $v0, 0x86($s0)
    /* 30984 80040184 14000224 */  addiu      $v0, $zero, 0x14
    /* 30988 80040188 8A0002A2 */  sb         $v0, 0x8A($s0)
    /* 3098C 8004018C 28000224 */  addiu      $v0, $zero, 0x28
    /* 30990 80040190 82001EA6 */  sh         $fp, 0x82($s0)
    /* 30994 80040194 880003A2 */  sb         $v1, 0x88($s0)
    /* 30998 80040198 890017A2 */  sb         $s7, 0x89($s0)
    /* 3099C 8004019C 8B0002A2 */  sb         $v0, 0x8B($s0)
    /* 309A0 800401A0 C000A8AF */  sw         $t0, 0xC0($sp)
    /* 309A4 800401A4 FFC6030C */  jal        GetTPage
    /* 309A8 800401A8 C400A9AF */   sw        $t1, 0xC4($sp)
    /* 309AC 800401AC 01002326 */  addiu      $v1, $s1, 0x1
    /* 309B0 800401B0 21886000 */  addu       $s1, $v1, $zero
    /* 309B4 800401B4 900002A6 */  sh         $v0, 0x90($s0)
    /* 309B8 800401B8 01000224 */  addiu      $v0, $zero, 0x1
    /* 309BC 800401BC 6C0002AE */  sw         $v0, 0x6C($s0)
    /* 309C0 800401C0 22000224 */  addiu      $v0, $zero, 0x22
    /* 309C4 800401C4 001C0300 */  sll        $v1, $v1, 16
    /* 309C8 800401C8 8E0000A6 */  sh         $zero, 0x8E($s0)
    /* 309CC 800401CC 740002A6 */  sh         $v0, 0x74($s0)
    /* 309D0 800401D0 B800AA8F */  lw         $t2, 0xB8($sp)
    /* 309D4 800401D4 031C0300 */  sra        $v1, $v1, 16
    /* 309D8 800401D8 7C000AAE */  sw         $t2, 0x7C($s0)
    /* 309DC 800401DC C400A98F */  lw         $t1, 0xC4($sp)
    /* 309E0 800401E0 04006328 */  slti       $v1, $v1, 0x4
    /* 309E4 800401E4 720009A6 */  sh         $t1, 0x72($s0)
    /* 309E8 800401E8 700009A6 */  sh         $t1, 0x70($s0)
    /* 309EC 800401EC C000A88F */  lw         $t0, 0xC0($sp)
    /* 309F0 800401F0 CBFF6014 */  bnez       $v1, .L80040120
    /* 309F4 800401F4 02000424 */   addiu     $a0, $zero, 0x2
    /* 309F8 800401F8 01004226 */  addiu      $v0, $s2, 0x1
    /* 309FC 800401FC 21904000 */  addu       $s2, $v0, $zero
    /* 30A00 80040200 00140200 */  sll        $v0, $v0, 16
    /* 30A04 80040204 03140200 */  sra        $v0, $v0, 16
    /* 30A08 80040208 02004228 */  slti       $v0, $v0, 0x2
    /* 30A0C 8004020C B9FF4014 */  bnez       $v0, .L800400F4
    /* 30A10 80040210 00000000 */   nop
    /* 30A14 80040214 6400848E */  lw         $a0, 0x64($s4)
    /* 30A18 80040218 E643010C */  jal        VIDEO_state__Fi
    /* 30A1C 8004021C 00000000 */   nop
    /* 30A20 80040220 0C004010 */  beqz       $v0, .L80040254
    /* 30A24 80040224 1180023C */   lui       $v0, %hi(D_8011650C)
    /* 30A28 80040228 6400848E */  lw         $a0, 0x64($s4)
    /* 30A2C 8004022C 022C1600 */  srl        $a1, $s6, 16
    /* 30A30 80040230 1044010C */  jal        VIDEO_updateframexy__Fiii
    /* 30A34 80040234 02341500 */   srl       $a2, $s5, 16
    /* 30A38 80040238 13004010 */  beqz       $v0, .L80040288
    /* 30A3C 8004023C 21900000 */   addu      $s2, $zero, $zero
    /* 30A40 80040240 6800828E */  lw         $v0, 0x68($s4)
    /* 30A44 80040244 00000000 */  nop
    /* 30A48 80040248 01004224 */  addiu      $v0, $v0, 0x1
    /* 30A4C 8004024C A2000108 */  j          .L80040288
    /* 30A50 80040250 680082AE */   sw        $v0, 0x68($s4)
  .L80040254:
    /* 30A54 80040254 6800B027 */  addiu      $s0, $sp, 0x68
    /* 30A58 80040258 21200002 */  addu       $a0, $s0, $zero
    /* 30A5C 8004025C 0180053C */  lui        $a1, %hi(D_80011D9C)
    /* 30A60 80040260 AE0280A6 */  sh         $zero, 0x2AE($s4)
    /* 30A64 80040264 0C65468C */  lw         $a2, %lo(D_8011650C)($v0)
    /* 30A68 80040268 2F91030C */  jal        sprintf
    /* 30A6C 8004026C 9C1DA524 */   addiu     $a1, $a1, %lo(D_80011D9C)
    /* 30A70 80040270 6400848E */  lw         $a0, 0x64($s4)
    /* 30A74 80040274 A643010C */  jal        VIDEO_spoolfile__FiPc
    /* 30A78 80040278 21280002 */   addu      $a1, $s0, $zero
    /* 30A7C 8004027C 6400848E */  lw         $a0, 0x64($s4)
    /* 30A80 80040280 BD43010C */  jal        VIDEO_startplayback__Fi
    /* 30A84 80040284 21900000 */   addu      $s2, $zero, $zero
  .L80040288:
    /* 30A88 80040288 00141200 */  sll        $v0, $s2, 16
  .L8004028C:
    /* 30A8C 8004028C 03140200 */  sra        $v0, $v0, 16
    /* 30A90 80040290 40200200 */  sll        $a0, $v0, 1
    /* 30A94 80040294 21208200 */  addu       $a0, $a0, $v0
    /* 30A98 80040298 00210400 */  sll        $a0, $a0, 4
    /* 30A9C 8004029C 6C008424 */  addiu      $a0, $a0, 0x6C
    /* 30AA0 800402A0 FE87000C */  jal        DrawTVLines__FR9tTVConfig
    /* 30AA4 800402A4 21208402 */   addu      $a0, $s4, $a0
    /* 30AA8 800402A8 01004226 */  addiu      $v0, $s2, 0x1
    /* 30AAC 800402AC 21904000 */  addu       $s2, $v0, $zero
    /* 30AB0 800402B0 00140200 */  sll        $v0, $v0, 16
    /* 30AB4 800402B4 03140200 */  sra        $v0, $v0, 16
    /* 30AB8 800402B8 08004228 */  slti       $v0, $v0, 0x8
    /* 30ABC 800402BC F3FF4014 */  bnez       $v0, .L8004028C
    /* 30AC0 800402C0 00141200 */   sll       $v0, $s2, 16
    /* 30AC4 800402C4 45010224 */  addiu      $v0, $zero, 0x145
    /* 30AC8 800402C8 6000A2A7 */  sh         $v0, 0x60($sp)
    /* 30ACC 800402CC 2B000224 */  addiu      $v0, $zero, 0x2B
    /* 30AD0 800402D0 6200A2A7 */  sh         $v0, 0x62($sp)
    /* 30AD4 800402D4 3A010224 */  addiu      $v0, $zero, 0x13A
    /* 30AD8 800402D8 6400A2A7 */  sh         $v0, 0x64($sp)
    /* 30ADC 800402DC 1180023C */  lui        $v0, %hi(D_80114722)
    /* 30AE0 800402E0 22474390 */  lbu        $v1, %lo(D_80114722)($v0)
    /* 30AE4 800402E4 0A000224 */  addiu      $v0, $zero, 0xA
    /* 30AE8 800402E8 06006010 */  beqz       $v1, .L80040304
    /* 30AEC 800402EC 6600A2A7 */   sh        $v0, 0x66($sp)
    /* 30AF0 800402F0 0580023C */  lui        $v0, %hi(menuDefs)
    /* 30AF4 800402F4 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 30AF8 800402F8 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 30AFC 800402FC C5000108 */  j          .L80040314
    /* 30B00 80040300 8C078424 */   addiu     $a0, $a0, 0x78C
  .L80040304:
    /* 30B04 80040304 0580023C */  lui        $v0, %hi(menuDefs)
    /* 30B08 80040308 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 30B0C 8004030C FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 30B10 80040310 A8068424 */  addiu      $a0, $a0, 0x6A8
  .L80040314:
    /* 30B14 80040314 8ACF000C */  jal        TextValue__23tListIteratorTournament7tPlayer
    /* 30B18 80040318 00000000 */   nop
    /* 30B1C 8004031C 00140200 */  sll        $v0, $v0, 16
    /* 30B20 80040320 032C0200 */  sra        $a1, $v0, 16
    /* 30B24 80040324 6000A627 */  addiu      $a2, $sp, 0x60
    /* 30B28 80040328 02000724 */  addiu      $a3, $zero, 0x2
    /* 30B2C 8004032C 5C008486 */  lh         $a0, 0x5C($s4)
    /* 30B30 80040330 0D000224 */  addiu      $v0, $zero, 0xD
    /* 30B34 80040334 0986000C */  jal        FETextRender_WordWrapFade__FisR4RECT14tMenuTextState13tMenuTextType
    /* 30B38 80040338 1000A2AF */   sw        $v0, 0x10($sp)
    /* 30B3C 8004033C AA000224 */  addiu      $v0, $zero, 0xAA
    /* 30B40 80040340 1180033C */  lui        $v1, %hi(D_80114722)
    /* 30B44 80040344 6000A2A7 */  sh         $v0, 0x60($sp)
    /* 30B48 80040348 6400A297 */  lhu        $v0, 0x64($sp)
    /* 30B4C 8004034C 22476390 */  lbu        $v1, %lo(D_80114722)($v1)
    /* 30B50 80040350 F6FF4224 */  addiu      $v0, $v0, -0xA
    /* 30B54 80040354 06006010 */  beqz       $v1, .L80040370
    /* 30B58 80040358 6400A2A7 */   sh        $v0, 0x64($sp)
    /* 30B5C 8004035C 0580023C */  lui        $v0, %hi(menuDefs)
    /* 30B60 80040360 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 30B64 80040364 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 30B68 80040368 E0000108 */  j          .L80040380
    /* 30B6C 8004036C 8C078424 */   addiu     $a0, $a0, 0x78C
  .L80040370:
    /* 30B70 80040370 0580023C */  lui        $v0, %hi(menuDefs)
    /* 30B74 80040374 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 30B78 80040378 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 30B7C 8004037C A8068424 */  addiu      $a0, $a0, 0x6A8
  .L80040380:
    /* 30B80 80040380 8ACF000C */  jal        TextValue__23tListIteratorTournament7tPlayer
    /* 30B84 80040384 00000000 */   nop
    /* 30B88 80040388 21904000 */  addu       $s2, $v0, $zero
    /* 30B8C 8004038C 26004226 */  addiu      $v0, $s2, 0x26
    /* 30B90 80040390 21904000 */  addu       $s2, $v0, $zero
    /* 30B94 80040394 00140200 */  sll        $v0, $v0, 16
    /* 30B98 80040398 C402838E */  lw         $v1, 0x2C4($s4)
    /* 30B9C 8004039C 03240200 */  sra        $a0, $v0, 16
    /* 30BA0 800403A0 05008314 */  bne        $a0, $v1, .L800403B8
    /* 30BA4 800403A4 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 30BA8 800403A8 C002838E */  lw         $v1, 0x2C0($s4)
    /* 30BAC 800403AC 00000000 */  nop
    /* 30BB0 800403B0 09006214 */  bne        $v1, $v0, .L800403D8
    /* 30BB4 800403B4 00000000 */   nop
  .L800403B8:
    /* 30BB8 800403B8 94E4020C */  jal        TextSys_Word__Fi
    /* 30BBC 800403BC C40284AE */   sw        $a0, 0x2C4($s4)
    /* 30BC0 800403C0 6400A487 */  lh         $a0, 0x64($sp)
    /* 30BC4 800403C4 3286000C */  jal        FETextRender_WordWrapHeight__FsPc
    /* 30BC8 800403C8 21284000 */   addu      $a1, $v0, $zero
    /* 30BCC 800403CC 75000324 */  addiu      $v1, $zero, 0x75
    /* 30BD0 800403D0 23186200 */  subu       $v1, $v1, $v0
    /* 30BD4 800403D4 C00283AE */  sw         $v1, 0x2C0($s4)
  .L800403D8:
    /* 30BD8 800403D8 00241200 */  sll        $a0, $s2, 16
    /* 30BDC 800403DC 03240400 */  sra        $a0, $a0, 16
    /* 30BE0 800403E0 99FC5126 */  addiu      $s1, $s2, -0x367
    /* 30BE4 800403E4 C0028296 */  lhu        $v0, 0x2C0($s4)
    /* 30BE8 800403E8 21900000 */  addu       $s2, $zero, $zero
    /* 30BEC 800403EC 94E4020C */  jal        TextSys_Word__Fi
    /* 30BF0 800403F0 6200A2A7 */   sh        $v0, 0x62($sp)
    /* 30BF4 800403F4 5000043C */  lui        $a0, (0x505050 >> 16)
    /* 30BF8 800403F8 50508434 */  ori        $a0, $a0, (0x505050 & 0xFFFF)
    /* 30BFC 800403FC 5C008586 */  lh         $a1, 0x5C($s4)
    /* 30C00 80040400 222E010C */  jal        CalcFadeVal__Fii
    /* 30C04 80040404 21804000 */   addu      $s0, $v0, $zero
    /* 30C08 80040408 21200002 */  addu       $a0, $s0, $zero
    /* 30C0C 8004040C 6000A527 */  addiu      $a1, $sp, 0x60
    /* 30C10 80040410 C685000C */  jal        FETextRender_WordWrapTextRGB__FPcR4RECTi
    /* 30C14 80040414 21304000 */   addu      $a2, $v0, $zero
    /* 30C18 80040418 DB030524 */  addiu      $a1, $zero, 0x3DB
    /* 30C1C 8004041C AA000624 */  addiu      $a2, $zero, 0xAA
    /* 30C20 80040420 75000724 */  addiu      $a3, $zero, 0x75
    /* 30C24 80040424 01000224 */  addiu      $v0, $zero, 0x1
    /* 30C28 80040428 5C008486 */  lh         $a0, 0x5C($s4)
    /* 30C2C 8004042C 04001024 */  addiu      $s0, $zero, 0x4
    /* 30C30 80040430 1000A0AF */  sw         $zero, 0x10($sp)
    /* 30C34 80040434 1400A2AF */  sw         $v0, 0x14($sp)
    /* 30C38 80040438 7584000C */  jal        FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
    /* 30C3C 8004043C 1800B0AF */   sw        $s0, 0x18($sp)
    /* 30C40 80040440 7A033126 */  addiu      $s1, $s1, 0x37A
    /* 30C44 80040444 008C1100 */  sll        $s1, $s1, 16
    /* 30C48 80040448 032C1100 */  sra        $a1, $s1, 16
    /* 30C4C 8004044C AA000624 */  addiu      $a2, $zero, 0xAA
    /* 30C50 80040450 7D000724 */  addiu      $a3, $zero, 0x7D
    /* 30C54 80040454 5C008486 */  lh         $a0, 0x5C($s4)
    /* 30C58 80040458 02000224 */  addiu      $v0, $zero, 0x2
    /* 30C5C 8004045C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 30C60 80040460 1400A2AF */  sw         $v0, 0x14($sp)
    /* 30C64 80040464 7584000C */  jal        FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
    /* 30C68 80040468 1800B0AF */   sw        $s0, 0x18($sp)
  .L8004046C:
    /* 30C6C 8004046C 00141200 */  sll        $v0, $s2, 16
    /* 30C70 80040470 03140200 */  sra        $v0, $v0, 16
    /* 30C74 80040474 40200200 */  sll        $a0, $v0, 1
    /* 30C78 80040478 21208200 */  addu       $a0, $a0, $v0
    /* 30C7C 8004047C 00210400 */  sll        $a0, $a0, 4
    /* 30C80 80040480 6C008424 */  addiu      $a0, $a0, 0x6C
    /* 30C84 80040484 D388000C */  jal        DrawTV__FR9tTVConfig
    /* 30C88 80040488 21208402 */   addu      $a0, $s4, $a0
    /* 30C8C 8004048C 01004226 */  addiu      $v0, $s2, 0x1
    /* 30C90 80040490 21904000 */  addu       $s2, $v0, $zero
    /* 30C94 80040494 00140200 */  sll        $v0, $v0, 16
    /* 30C98 80040498 03140200 */  sra        $v0, $v0, 16
    /* 30C9C 8004049C 08004228 */  slti       $v0, $v0, 0x8
    /* 30CA0 800404A0 F2FF4014 */  bnez       $v0, .L8004046C
    /* 30CA4 800404A4 00000000 */   nop
    /* 30CA8 800404A8 EC00BF8F */  lw         $ra, 0xEC($sp)
    /* 30CAC 800404AC E800BE8F */  lw         $fp, 0xE8($sp)
    /* 30CB0 800404B0 E400B78F */  lw         $s7, 0xE4($sp)
    /* 30CB4 800404B4 E000B68F */  lw         $s6, 0xE0($sp)
    /* 30CB8 800404B8 DC00B58F */  lw         $s5, 0xDC($sp)
    /* 30CBC 800404BC D800B48F */  lw         $s4, 0xD8($sp)
    /* 30CC0 800404C0 D400B38F */  lw         $s3, 0xD4($sp)
    /* 30CC4 800404C4 D000B28F */  lw         $s2, 0xD0($sp)
    /* 30CC8 800404C8 CC00B18F */  lw         $s1, 0xCC($sp)
    /* 30CCC 800404CC C800B08F */  lw         $s0, 0xC8($sp)
    /* 30CD0 800404D0 0800E003 */  jr         $ra
    /* 30CD4 800404D4 F000BD27 */   addiu     $sp, $sp, 0xF0
endlabel DrawBackground__18tScreenTournSelect
