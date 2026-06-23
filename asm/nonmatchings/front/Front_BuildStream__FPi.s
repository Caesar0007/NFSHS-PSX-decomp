.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_BuildStream__FPi, 0xFA0

glabel Front_BuildStream__FPi
    /* 1AF38 8002A738 F0FCBD27 */  addiu      $sp, $sp, -0x310
    /* 1AF3C 8002A73C 0403B3AF */  sw         $s3, 0x304($sp)
    /* 1AF40 8002A740 21988000 */  addu       $s3, $a0, $zero
    /* 1AF44 8002A744 1000A427 */  addiu      $a0, $sp, 0x10
    /* 1AF48 8002A748 0C03BFAF */  sw         $ra, 0x30C($sp)
    /* 1AF4C 8002A74C 0803B4AF */  sw         $s4, 0x308($sp)
    /* 1AF50 8002A750 0003B2AF */  sw         $s2, 0x300($sp)
    /* 1AF54 8002A754 FC02B1AF */  sw         $s1, 0x2FC($sp)
    /* 1AF58 8002A758 1AA0000C */  jal        Front_InitStream__FR9tFEStream
    /* 1AF5C 8002A75C F802B0AF */   sw        $s0, 0x2F8($sp)
    /* 1AF60 8002A760 26A0000C */  jal        Front_InitPlayerCars__FR9tFEStream
    /* 1AF64 8002A764 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1AF68 8002A768 87A4000C */  jal        Front_InitTrack__FR9tFEStream
    /* 1AF6C 8002A76C 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1AF70 8002A770 17A1000C */  jal        Front_InitTourneyTraffic__FR9tFEStream
    /* 1AF74 8002A774 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1AF78 8002A778 74A1000C */  jal        Front_InitOpponentCars__FR9tFEStream
    /* 1AF7C 8002A77C 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1AF80 8002A780 D9A2000C */  jal        Front_InitMissions__FR9tFEStream
    /* 1AF84 8002A784 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1AF88 8002A788 25A3000C */  jal        Front_InitCopCars__FR9tFEStream
    /* 1AF8C 8002A78C 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1AF90 8002A790 15A4000C */  jal        Front_InitPerps__FR9tFEStream
    /* 1AF94 8002A794 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1AF98 8002A798 F8A4000C */  jal        Front_InitTraffic__FR9tFEStream
    /* 1AF9C 8002A79C 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1AFA0 8002A7A0 1480023C */  lui        $v0, %hi(ticks)
    /* 1AFA4 8002A7A4 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 1AFA8 8002A7A8 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1AFAC 8002A7AC 00240300 */  sll        $a0, $v1, 16
    /* 1AFB0 8002A7B0 03240400 */  sra        $a0, $a0, 16
    /* 1AFB4 8002A7B4 1E9E030C */  jal        seedrandom
    /* 1AFB8 8002A7B8 004643A4 */   sh        $v1, %lo(frontEnd)($v0)
    /* 1AFBC 8002A7BC 07000324 */  addiu      $v1, $zero, 0x7
    /* 1AFC0 8002A7C0 0580023C */  lui        $v0, %hi(colourChosen)
    /* 1AFC4 8002A7C4 14194224 */  addiu      $v0, $v0, %lo(colourChosen)
    /* 1AFC8 8002A7C8 1C004224 */  addiu      $v0, $v0, 0x1C
  .L8002A7CC:
    /* 1AFCC 8002A7CC 000040AC */  sw         $zero, 0x0($v0)
    /* 1AFD0 8002A7D0 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 1AFD4 8002A7D4 FDFF6104 */  bgez       $v1, .L8002A7CC
    /* 1AFD8 8002A7D8 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 1AFDC 8002A7DC 940C010C */  jal        Controller_SetRamp__Fv
    /* 1AFE0 8002A7E0 D4007026 */   addiu     $s0, $s3, 0xD4
    /* 1AFE4 8002A7E4 21206002 */  addu       $a0, $s3, $zero
    /* 1AFE8 8002A7E8 54C6030C */  jal        resizememadr
    /* 1AFEC 8002A7EC 0100053C */   lui       $a1, (0x10000 >> 16)
    /* 1AFF0 8002A7F0 34000224 */  addiu      $v0, $zero, 0x34
    /* 1AFF4 8002A7F4 1180053C */  lui        $a1, %hi(frontEnd)
    /* 1AFF8 8002A7F8 0046A324 */  addiu      $v1, $a1, %lo(frontEnd)
    /* 1AFFC 8002A7FC 000062AE */  sw         $v0, 0x0($s3)
    /* 1B000 8002A800 62036490 */  lbu        $a0, 0x362($v1)
    /* 1B004 8002A804 35000224 */  addiu      $v0, $zero, 0x35
    /* 1B008 8002A808 080062AE */  sw         $v0, 0x8($s3)
    /* 1B00C 8002A80C 040064AE */  sw         $a0, 0x4($s3)
    /* 1B010 8002A810 4B036490 */  lbu        $a0, 0x34B($v1)
    /* 1B014 8002A814 36000224 */  addiu      $v0, $zero, 0x36
    /* 1B018 8002A818 100062AE */  sw         $v0, 0x10($s3)
    /* 1B01C 8002A81C 0C0064AE */  sw         $a0, 0xC($s3)
    /* 1B020 8002A820 49036490 */  lbu        $a0, 0x349($v1)
    /* 1B024 8002A824 37000224 */  addiu      $v0, $zero, 0x37
    /* 1B028 8002A828 180062AE */  sw         $v0, 0x18($s3)
    /* 1B02C 8002A82C 140064AE */  sw         $a0, 0x14($s3)
    /* 1B030 8002A830 4F036490 */  lbu        $a0, 0x34F($v1)
    /* 1B034 8002A834 38000224 */  addiu      $v0, $zero, 0x38
    /* 1B038 8002A838 200062AE */  sw         $v0, 0x20($s3)
    /* 1B03C 8002A83C 1C0064AE */  sw         $a0, 0x1C($s3)
    /* 1B040 8002A840 4D036490 */  lbu        $a0, 0x34D($v1)
    /* 1B044 8002A844 39000224 */  addiu      $v0, $zero, 0x39
    /* 1B048 8002A848 280062AE */  sw         $v0, 0x28($s3)
    /* 1B04C 8002A84C 240064AE */  sw         $a0, 0x24($s3)
    /* 1B050 8002A850 51036490 */  lbu        $a0, 0x351($v1)
    /* 1B054 8002A854 3A000224 */  addiu      $v0, $zero, 0x3A
    /* 1B058 8002A858 300062AE */  sw         $v0, 0x30($s3)
    /* 1B05C 8002A85C 2C0064AE */  sw         $a0, 0x2C($s3)
    /* 1B060 8002A860 53036490 */  lbu        $a0, 0x353($v1)
    /* 1B064 8002A864 3B000224 */  addiu      $v0, $zero, 0x3B
    /* 1B068 8002A868 380062AE */  sw         $v0, 0x38($s3)
    /* 1B06C 8002A86C 340064AE */  sw         $a0, 0x34($s3)
    /* 1B070 8002A870 55036490 */  lbu        $a0, 0x355($v1)
    /* 1B074 8002A874 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 1B078 8002A878 400062AE */  sw         $v0, 0x40($s3)
    /* 1B07C 8002A87C 3C0064AE */  sw         $a0, 0x3C($s3)
    /* 1B080 8002A880 57036490 */  lbu        $a0, 0x357($v1)
    /* 1B084 8002A884 3D000224 */  addiu      $v0, $zero, 0x3D
    /* 1B088 8002A888 480062AE */  sw         $v0, 0x48($s3)
    /* 1B08C 8002A88C 440064AE */  sw         $a0, 0x44($s3)
    /* 1B090 8002A890 59036490 */  lbu        $a0, 0x359($v1)
    /* 1B094 8002A894 3E000224 */  addiu      $v0, $zero, 0x3E
    /* 1B098 8002A898 500062AE */  sw         $v0, 0x50($s3)
    /* 1B09C 8002A89C 4C0064AE */  sw         $a0, 0x4C($s3)
    /* 1B0A0 8002A8A0 5B036290 */  lbu        $v0, 0x35B($v1)
    /* 1B0A4 8002A8A4 00000000 */  nop
    /* 1B0A8 8002A8A8 540062AE */  sw         $v0, 0x54($s3)
    /* 1B0AC 8002A8AC 3F000224 */  addiu      $v0, $zero, 0x3F
    /* 1B0B0 8002A8B0 580062AE */  sw         $v0, 0x58($s3)
    /* 1B0B4 8002A8B4 63036490 */  lbu        $a0, 0x363($v1)
    /* 1B0B8 8002A8B8 40000224 */  addiu      $v0, $zero, 0x40
    /* 1B0BC 8002A8BC 600062AE */  sw         $v0, 0x60($s3)
    /* 1B0C0 8002A8C0 5C0064AE */  sw         $a0, 0x5C($s3)
    /* 1B0C4 8002A8C4 4C036490 */  lbu        $a0, 0x34C($v1)
    /* 1B0C8 8002A8C8 41000224 */  addiu      $v0, $zero, 0x41
    /* 1B0CC 8002A8CC 680062AE */  sw         $v0, 0x68($s3)
    /* 1B0D0 8002A8D0 640064AE */  sw         $a0, 0x64($s3)
    /* 1B0D4 8002A8D4 4A036490 */  lbu        $a0, 0x34A($v1)
    /* 1B0D8 8002A8D8 42000224 */  addiu      $v0, $zero, 0x42
    /* 1B0DC 8002A8DC 700062AE */  sw         $v0, 0x70($s3)
    /* 1B0E0 8002A8E0 6C0064AE */  sw         $a0, 0x6C($s3)
    /* 1B0E4 8002A8E4 50036490 */  lbu        $a0, 0x350($v1)
    /* 1B0E8 8002A8E8 43000224 */  addiu      $v0, $zero, 0x43
    /* 1B0EC 8002A8EC 780062AE */  sw         $v0, 0x78($s3)
    /* 1B0F0 8002A8F0 740064AE */  sw         $a0, 0x74($s3)
    /* 1B0F4 8002A8F4 4E036490 */  lbu        $a0, 0x34E($v1)
    /* 1B0F8 8002A8F8 44000224 */  addiu      $v0, $zero, 0x44
    /* 1B0FC 8002A8FC 800062AE */  sw         $v0, 0x80($s3)
    /* 1B100 8002A900 7C0064AE */  sw         $a0, 0x7C($s3)
    /* 1B104 8002A904 52036490 */  lbu        $a0, 0x352($v1)
    /* 1B108 8002A908 45000224 */  addiu      $v0, $zero, 0x45
    /* 1B10C 8002A90C 880062AE */  sw         $v0, 0x88($s3)
    /* 1B110 8002A910 840064AE */  sw         $a0, 0x84($s3)
    /* 1B114 8002A914 54036490 */  lbu        $a0, 0x354($v1)
    /* 1B118 8002A918 46000224 */  addiu      $v0, $zero, 0x46
    /* 1B11C 8002A91C 900062AE */  sw         $v0, 0x90($s3)
    /* 1B120 8002A920 8C0064AE */  sw         $a0, 0x8C($s3)
    /* 1B124 8002A924 56036490 */  lbu        $a0, 0x356($v1)
    /* 1B128 8002A928 47000224 */  addiu      $v0, $zero, 0x47
    /* 1B12C 8002A92C 980062AE */  sw         $v0, 0x98($s3)
    /* 1B130 8002A930 940064AE */  sw         $a0, 0x94($s3)
    /* 1B134 8002A934 58036490 */  lbu        $a0, 0x358($v1)
    /* 1B138 8002A938 48000224 */  addiu      $v0, $zero, 0x48
    /* 1B13C 8002A93C A00062AE */  sw         $v0, 0xA0($s3)
    /* 1B140 8002A940 9C0064AE */  sw         $a0, 0x9C($s3)
    /* 1B144 8002A944 5A036490 */  lbu        $a0, 0x35A($v1)
    /* 1B148 8002A948 49000224 */  addiu      $v0, $zero, 0x49
    /* 1B14C 8002A94C A80062AE */  sw         $v0, 0xA8($s3)
    /* 1B150 8002A950 A40064AE */  sw         $a0, 0xA4($s3)
    /* 1B154 8002A954 5C036490 */  lbu        $a0, 0x35C($v1)
    /* 1B158 8002A958 21000224 */  addiu      $v0, $zero, 0x21
    /* 1B15C 8002A95C B00062AE */  sw         $v0, 0xB0($s3)
    /* 1B160 8002A960 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 1B164 8002A964 AC0064AE */  sw         $a0, 0xAC($s3)
    /* 1B168 8002A968 B40062AE */  sw         $v0, 0xB4($s3)
    /* 1B16C 8002A96C 03000224 */  addiu      $v0, $zero, 0x3
    /* 1B170 8002A970 B80062AE */  sw         $v0, 0xB8($s3)
    /* 1B174 8002A974 01000224 */  addiu      $v0, $zero, 0x1
    /* 1B178 8002A978 BC0062AE */  sw         $v0, 0xBC($s3)
    /* 1B17C 8002A97C 1B000224 */  addiu      $v0, $zero, 0x1B
    /* 1B180 8002A980 C00062AE */  sw         $v0, 0xC0($s3)
    /* 1B184 8002A984 0046A484 */  lh         $a0, %lo(frontEnd)($a1)
    /* 1B188 8002A988 4A000224 */  addiu      $v0, $zero, 0x4A
    /* 1B18C 8002A98C C80062AE */  sw         $v0, 0xC8($s3)
    /* 1B190 8002A990 24000224 */  addiu      $v0, $zero, 0x24
    /* 1B194 8002A994 CC0060AE */  sw         $zero, 0xCC($s3)
    /* 1B198 8002A998 D00062AE */  sw         $v0, 0xD0($s3)
    /* 1B19C 8002A99C C40064AE */  sw         $a0, 0xC4($s3)
    /* 1B1A0 8002A9A0 40037290 */  lbu        $s2, 0x340($v1)
    /* 1B1A4 8002A9A4 21006290 */  lbu        $v0, 0x21($v1)
    /* 1B1A8 8002A9A8 BB02B193 */  lbu        $s1, 0x2BB($sp)
    /* 1B1AC 8002A9AC 08004010 */  beqz       $v0, .L8002A9D0
    /* 1B1B0 8002A9B0 00000000 */   nop
    /* 1B1B4 8002A9B4 ABA9000C */  jal        Front_EnableLocalSpeech__Fv
    /* 1B1B8 8002A9B8 00000000 */   nop
    /* 1B1BC 8002A9BC 04004010 */  beqz       $v0, .L8002A9D0
    /* 1B1C0 8002A9C0 00000000 */   nop
    /* 1B1C4 8002A9C4 D40071AE */  sw         $s1, 0xD4($s3)
    /* 1B1C8 8002A9C8 76AA0008 */  j          .L8002A9D8
    /* 1B1CC 8002A9CC D8007026 */   addiu     $s0, $s3, 0xD8
  .L8002A9D0:
    /* 1B1D0 8002A9D0 000012AE */  sw         $s2, 0x0($s0)
    /* 1B1D4 8002A9D4 04001026 */  addiu      $s0, $s0, 0x4
  .L8002A9D8:
    /* 1B1D8 8002A9D8 27000224 */  addiu      $v0, $zero, 0x27
    /* 1B1DC 8002A9DC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B1E0 8002A9E0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B1E4 8002A9E4 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1B1E8 8002A9E8 00465124 */  addiu      $s1, $v0, %lo(frontEnd)
    /* 1B1EC 8002A9EC 40032292 */  lbu        $v0, 0x340($s1)
    /* 1B1F0 8002A9F0 1000A527 */  addiu      $a1, $sp, 0x10
    /* 1B1F4 8002A9F4 000002AE */  sw         $v0, 0x0($s0)
    /* 1B1F8 8002A9F8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B1FC 8002A9FC 28000224 */  addiu      $v0, $zero, 0x28
    /* 1B200 8002AA00 000002AE */  sw         $v0, 0x0($s0)
    /* 1B204 8002AA04 1F032292 */  lbu        $v0, 0x31F($s1)
    /* 1B208 8002AA08 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B20C 8002AA0C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B210 8002AA10 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B214 8002AA14 11000224 */  addiu      $v0, $zero, 0x11
    /* 1B218 8002AA18 000002AE */  sw         $v0, 0x0($s0)
    /* 1B21C 8002AA1C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B220 8002AA20 000000AE */  sw         $zero, 0x0($s0)
    /* 1B224 8002AA24 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B228 8002AA28 09000224 */  addiu      $v0, $zero, 0x9
    /* 1B22C 8002AA2C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B230 8002AA30 06002292 */  lbu        $v0, 0x6($s1)
    /* 1B234 8002AA34 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B238 8002AA38 000002AE */  sw         $v0, 0x0($s0)
    /* 1B23C 8002AA3C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B240 8002AA40 0A000224 */  addiu      $v0, $zero, 0xA
    /* 1B244 8002AA44 000002AE */  sw         $v0, 0x0($s0)
    /* 1B248 8002AA48 03002292 */  lbu        $v0, 0x3($s1)
    /* 1B24C 8002AA4C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B250 8002AA50 000002AE */  sw         $v0, 0x0($s0)
    /* 1B254 8002AA54 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B258 8002AA58 07000224 */  addiu      $v0, $zero, 0x7
    /* 1B25C 8002AA5C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B260 8002AA60 04002292 */  lbu        $v0, 0x4($s1)
    /* 1B264 8002AA64 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B268 8002AA68 000002AE */  sw         $v0, 0x0($s0)
    /* 1B26C 8002AA6C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B270 8002AA70 15010224 */  addiu      $v0, $zero, 0x115
    /* 1B274 8002AA74 000002AE */  sw         $v0, 0x0($s0)
    /* 1B278 8002AA78 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B27C 8002AA7C 000000AE */  sw         $zero, 0x0($s0)
    /* 1B280 8002AA80 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B284 8002AA84 000000AE */  sw         $zero, 0x0($s0)
    /* 1B288 8002AA88 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B28C 8002AA8C 17010224 */  addiu      $v0, $zero, 0x117
    /* 1B290 8002AA90 000002AE */  sw         $v0, 0x0($s0)
    /* 1B294 8002AA94 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B298 8002AA98 000000AE */  sw         $zero, 0x0($s0)
    /* 1B29C 8002AA9C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B2A0 8002AAA0 000000AE */  sw         $zero, 0x0($s0)
    /* 1B2A4 8002AAA4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B2A8 8002AAA8 0F000224 */  addiu      $v0, $zero, 0xF
    /* 1B2AC 8002AAAC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B2B0 8002AAB0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B2B4 8002AAB4 07002292 */  lbu        $v0, 0x7($s1)
    /* 1B2B8 8002AAB8 04000426 */  addiu      $a0, $s0, 0x4
    /* 1B2BC 8002AABC 5BA9000C */  jal        Front_AppendTrackData__FPiR9tFEStream
    /* 1B2C0 8002AAC0 000002AE */   sw        $v0, 0x0($s0)
    /* 1B2C4 8002AAC4 21804000 */  addu       $s0, $v0, $zero
    /* 1B2C8 8002AAC8 13000224 */  addiu      $v0, $zero, 0x13
    /* 1B2CC 8002AACC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B2D0 8002AAD0 47032292 */  lbu        $v0, 0x347($s1)
    /* 1B2D4 8002AAD4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B2D8 8002AAD8 000002AE */  sw         $v0, 0x0($s0)
    /* 1B2DC 8002AADC 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B2E0 8002AAE0 2A000224 */  addiu      $v0, $zero, 0x2A
    /* 1B2E4 8002AAE4 000002AE */  sw         $v0, 0x0($s0)
    /* 1B2E8 8002AAE8 46032292 */  lbu        $v0, 0x346($s1)
    /* 1B2EC 8002AAEC 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B2F0 8002AAF0 000002AE */  sw         $v0, 0x0($s0)
    /* 1B2F4 8002AAF4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B2F8 8002AAF8 2B000224 */  addiu      $v0, $zero, 0x2B
    /* 1B2FC 8002AAFC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B300 8002AB00 41032292 */  lbu        $v0, 0x341($s1)
    /* 1B304 8002AB04 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B308 8002AB08 000002AE */  sw         $v0, 0x0($s0)
    /* 1B30C 8002AB0C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B310 8002AB10 2C000224 */  addiu      $v0, $zero, 0x2C
    /* 1B314 8002AB14 000002AE */  sw         $v0, 0x0($s0)
    /* 1B318 8002AB18 42032292 */  lbu        $v0, 0x342($s1)
    /* 1B31C 8002AB1C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B320 8002AB20 000002AE */  sw         $v0, 0x0($s0)
    /* 1B324 8002AB24 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B328 8002AB28 2D000224 */  addiu      $v0, $zero, 0x2D
    /* 1B32C 8002AB2C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B330 8002AB30 44032292 */  lbu        $v0, 0x344($s1)
    /* 1B334 8002AB34 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B338 8002AB38 000002AE */  sw         $v0, 0x0($s0)
    /* 1B33C 8002AB3C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B340 8002AB40 2E000224 */  addiu      $v0, $zero, 0x2E
    /* 1B344 8002AB44 000002AE */  sw         $v0, 0x0($s0)
    /* 1B348 8002AB48 43032292 */  lbu        $v0, 0x343($s1)
    /* 1B34C 8002AB4C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B350 8002AB50 000002AE */  sw         $v0, 0x0($s0)
    /* 1B354 8002AB54 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B358 8002AB58 2F000224 */  addiu      $v0, $zero, 0x2F
    /* 1B35C 8002AB5C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B360 8002AB60 45032292 */  lbu        $v0, 0x345($s1)
    /* 1B364 8002AB64 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B368 8002AB68 000002AE */  sw         $v0, 0x0($s0)
    /* 1B36C 8002AB6C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B370 8002AB70 16000224 */  addiu      $v0, $zero, 0x16
    /* 1B374 8002AB74 000002AE */  sw         $v0, 0x0($s0)
    /* 1B378 8002AB78 1800A383 */  lb         $v1, 0x18($sp)
    /* 1B37C 8002AB7C 1C000224 */  addiu      $v0, $zero, 0x1C
    /* 1B380 8002AB80 03006214 */  bne        $v1, $v0, .L8002AB90
    /* 1B384 8002AB84 04001026 */   addiu     $s0, $s0, 0x4
    /* 1B388 8002AB88 ECAA0008 */  j          .L8002ABB0
    /* 1B38C 8002AB8C 000000AE */   sw        $zero, 0x0($s0)
  .L8002AB90:
    /* 1B390 8002AB90 04002392 */  lbu        $v1, 0x4($s1)
    /* 1B394 8002AB94 02000224 */  addiu      $v0, $zero, 0x2
    /* 1B398 8002AB98 04006210 */  beq        $v1, $v0, .L8002ABAC
    /* 1B39C 8002AB9C 01000224 */   addiu     $v0, $zero, 0x1
    /* 1B3A0 8002ABA0 16032292 */  lbu        $v0, 0x316($s1)
    /* 1B3A4 8002ABA4 ECAA0008 */  j          .L8002ABB0
    /* 1B3A8 8002ABA8 000002AE */   sw        $v0, 0x0($s0)
  .L8002ABAC:
    /* 1B3AC 8002ABAC 000002AE */  sw         $v0, 0x0($s0)
  .L8002ABB0:
    /* 1B3B0 8002ABB0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B3B4 8002ABB4 21280000 */  addu       $a1, $zero, $zero
    /* 1B3B8 8002ABB8 2118A000 */  addu       $v1, $a1, $zero
    /* 1B3BC 8002ABBC 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1B3C0 8002ABC0 00464424 */  addiu      $a0, $v0, %lo(frontEnd)
  .L8002ABC4:
    /* 1B3C4 8002ABC4 9C03828C */  lw         $v0, 0x39C($a0)
    /* 1B3C8 8002ABC8 00000000 */  nop
    /* 1B3CC 8002ABCC 02004010 */  beqz       $v0, .L8002ABD8
    /* 1B3D0 8002ABD0 00000000 */   nop
    /* 1B3D4 8002ABD4 0100A524 */  addiu      $a1, $a1, 0x1
  .L8002ABD8:
    /* 1B3D8 8002ABD8 01006324 */  addiu      $v1, $v1, 0x1
    /* 1B3DC 8002ABDC 28006228 */  slti       $v0, $v1, 0x28
    /* 1B3E0 8002ABE0 F8FF4014 */  bnez       $v0, .L8002ABC4
    /* 1B3E4 8002ABE4 04008424 */   addiu     $a0, $a0, 0x4
    /* 1B3E8 8002ABE8 30000224 */  addiu      $v0, $zero, 0x30
    /* 1B3EC 8002ABEC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B3F0 8002ABF0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B3F4 8002ABF4 000005AE */  sw         $a1, 0x0($s0)
    /* 1B3F8 8002ABF8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B3FC 8002ABFC 4C000224 */  addiu      $v0, $zero, 0x4C
    /* 1B400 8002AC00 000002AE */  sw         $v0, 0x0($s0)
    /* 1B404 8002AC04 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B408 8002AC08 000005AE */  sw         $a1, 0x0($s0)
    /* 1B40C 8002AC0C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B410 8002AC10 21180000 */  addu       $v1, $zero, $zero
    /* 1B414 8002AC14 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1B418 8002AC18 00464424 */  addiu      $a0, $v0, %lo(frontEnd)
  .L8002AC1C:
    /* 1B41C 8002AC1C 9C03828C */  lw         $v0, 0x39C($a0)
    /* 1B420 8002AC20 00000000 */  nop
    /* 1B424 8002AC24 03004010 */  beqz       $v0, .L8002AC34
    /* 1B428 8002AC28 00000000 */   nop
    /* 1B42C 8002AC2C 000003AE */  sw         $v1, 0x0($s0)
    /* 1B430 8002AC30 04001026 */  addiu      $s0, $s0, 0x4
  .L8002AC34:
    /* 1B434 8002AC34 01006324 */  addiu      $v1, $v1, 0x1
    /* 1B438 8002AC38 28006228 */  slti       $v0, $v1, 0x28
    /* 1B43C 8002AC3C F7FF4014 */  bnez       $v0, .L8002AC1C
    /* 1B440 8002AC40 04008424 */   addiu     $a0, $a0, 0x4
    /* 1B444 8002AC44 29000224 */  addiu      $v0, $zero, 0x29
    /* 1B448 8002AC48 000002AE */  sw         $v0, 0x0($s0)
    /* 1B44C 8002AC4C D002A483 */  lb         $a0, 0x2D0($sp)
    /* 1B450 8002AC50 982B010C */  jal        Stattool_ReturnRecordLapTime__Fs
    /* 1B454 8002AC54 04001026 */   addiu     $s0, $s0, 0x4
    /* 1B458 8002AC58 000002AE */  sw         $v0, 0x0($s0)
    /* 1B45C 8002AC5C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B460 8002AC60 08000224 */  addiu      $v0, $zero, 0x8
    /* 1B464 8002AC64 000002AE */  sw         $v0, 0x0($s0)
    /* 1B468 8002AC68 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1B46C 8002AC6C 00464324 */  addiu      $v1, $v0, %lo(frontEnd)
    /* 1B470 8002AC70 04006290 */  lbu        $v0, 0x4($v1)
    /* 1B474 8002AC74 00000000 */  nop
    /* 1B478 8002AC78 05004014 */  bnez       $v0, .L8002AC90
    /* 1B47C 8002AC7C 04001026 */   addiu     $s0, $s0, 0x4
    /* 1B480 8002AC80 2A016290 */  lbu        $v0, 0x12A($v1)
    /* 1B484 8002AC84 00000000 */  nop
    /* 1B488 8002AC88 03004010 */  beqz       $v0, .L8002AC98
    /* 1B48C 8002AC8C 01000224 */   addiu     $v0, $zero, 0x1
  .L8002AC90:
    /* 1B490 8002AC90 F09F000C */  jal        Front_GetLapsForType__Fv
    /* 1B494 8002AC94 00000000 */   nop
  .L8002AC98:
    /* 1B498 8002AC98 000002AE */  sw         $v0, 0x0($s0)
    /* 1B49C 8002AC9C 1A00A293 */  lbu        $v0, 0x1A($sp)
    /* 1B4A0 8002ACA0 07000324 */  addiu      $v1, $zero, 0x7
    /* 1B4A4 8002ACA4 12004310 */  beq        $v0, $v1, .L8002ACF0
    /* 1B4A8 8002ACA8 04001026 */   addiu     $s0, $s0, 0x4
    /* 1B4AC 8002ACAC E600A293 */  lbu        $v0, 0xE6($sp)
    /* 1B4B0 8002ACB0 00000000 */  nop
    /* 1B4B4 8002ACB4 0E004310 */  beq        $v0, $v1, .L8002ACF0
    /* 1B4B8 8002ACB8 1180023C */   lui       $v0, %hi(frontEnd)
    /* 1B4BC 8002ACBC 00464324 */  addiu      $v1, $v0, %lo(frontEnd)
    /* 1B4C0 8002ACC0 04006290 */  lbu        $v0, 0x4($v1)
    /* 1B4C4 8002ACC4 00000000 */  nop
    /* 1B4C8 8002ACC8 19004014 */  bnez       $v0, .L8002AD30
    /* 1B4CC 8002ACCC 20000224 */   addiu     $v0, $zero, 0x20
    /* 1B4D0 8002ACD0 1E036290 */  lbu        $v0, 0x31E($v1)
    /* 1B4D4 8002ACD4 00000000 */  nop
    /* 1B4D8 8002ACD8 15004014 */  bnez       $v0, .L8002AD30
    /* 1B4DC 8002ACDC 20000224 */   addiu     $v0, $zero, 0x20
    /* 1B4E0 8002ACE0 03006290 */  lbu        $v0, 0x3($v1)
    /* 1B4E4 8002ACE4 00000000 */  nop
    /* 1B4E8 8002ACE8 11004014 */  bnez       $v0, .L8002AD30
    /* 1B4EC 8002ACEC 20000224 */   addiu     $v0, $zero, 0x20
  .L8002ACF0:
    /* 1B4F0 8002ACF0 20000224 */  addiu      $v0, $zero, 0x20
    /* 1B4F4 8002ACF4 000002AE */  sw         $v0, 0x0($s0)
    /* 1B4F8 8002ACF8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B4FC 8002ACFC 000000AE */  sw         $zero, 0x0($s0)
    /* 1B500 8002AD00 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B504 8002AD04 32000224 */  addiu      $v0, $zero, 0x32
    /* 1B508 8002AD08 000002AE */  sw         $v0, 0x0($s0)
    /* 1B50C 8002AD0C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B510 8002AD10 000000AE */  sw         $zero, 0x0($s0)
    /* 1B514 8002AD14 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B518 8002AD18 33000224 */  addiu      $v0, $zero, 0x33
    /* 1B51C 8002AD1C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B520 8002AD20 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B524 8002AD24 000000AE */  sw         $zero, 0x0($s0)
    /* 1B528 8002AD28 7EAB0008 */  j          .L8002ADF8
    /* 1B52C 8002AD2C 04001026 */   addiu     $s0, $s0, 0x4
  .L8002AD30:
    /* 1B530 8002AD30 1180033C */  lui        $v1, %hi(frontEnd)
    /* 1B534 8002AD34 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* 1B538 8002AD38 000002AE */  sw         $v0, 0x0($s0)
    /* 1B53C 8002AD3C 96036290 */  lbu        $v0, 0x396($v1)
    /* 1B540 8002AD40 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B544 8002AD44 000002AE */  sw         $v0, 0x0($s0)
    /* 1B548 8002AD48 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B54C 8002AD4C 32000224 */  addiu      $v0, $zero, 0x32
    /* 1B550 8002AD50 000002AE */  sw         $v0, 0x0($s0)
    /* 1B554 8002AD54 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B558 8002AD58 21200002 */  addu       $a0, $s0, $zero
    /* 1B55C 8002AD5C 97036390 */  lbu        $v1, 0x397($v1)
    /* 1B560 8002AD60 01000224 */  addiu      $v0, $zero, 0x1
    /* 1B564 8002AD64 0C006214 */  bne        $v1, $v0, .L8002AD98
    /* 1B568 8002AD68 04001026 */   addiu     $s0, $s0, 0x4
    /* 1B56C 8002AD6C 0580023C */  lui        $v0, %hi(CountryMeasurement)
    /* 1B570 8002AD70 CA02A393 */  lbu        $v1, 0x2CA($sp)
    /* 1B574 8002AD74 10164224 */  addiu      $v0, $v0, %lo(CountryMeasurement)
    /* 1B578 8002AD78 40180300 */  sll        $v1, $v1, 1
    /* 1B57C 8002AD7C 21186200 */  addu       $v1, $v1, $v0
    /* 1B580 8002AD80 00006284 */  lh         $v0, 0x0($v1)
    /* 1B584 8002AD84 00000000 */  nop
    /* 1B588 8002AD88 04004010 */  beqz       $v0, .L8002AD9C
    /* 1B58C 8002AD8C 02000324 */   addiu     $v1, $zero, 0x2
    /* 1B590 8002AD90 67AB0008 */  j          .L8002AD9C
    /* 1B594 8002AD94 01000324 */   addiu     $v1, $zero, 0x1
  .L8002AD98:
    /* 1B598 8002AD98 21180000 */  addu       $v1, $zero, $zero
  .L8002AD9C:
    /* 1B59C 8002AD9C 33000224 */  addiu      $v0, $zero, 0x33
    /* 1B5A0 8002ADA0 000083AC */  sw         $v1, 0x0($a0)
    /* 1B5A4 8002ADA4 000002AE */  sw         $v0, 0x0($s0)
    /* 1B5A8 8002ADA8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B5AC 8002ADAC 21200002 */  addu       $a0, $s0, $zero
    /* 1B5B0 8002ADB0 1180023C */  lui        $v0, %hi(D_80114998)
    /* 1B5B4 8002ADB4 98494390 */  lbu        $v1, %lo(D_80114998)($v0)
    /* 1B5B8 8002ADB8 01000224 */  addiu      $v0, $zero, 0x1
    /* 1B5BC 8002ADBC 0C006214 */  bne        $v1, $v0, .L8002ADF0
    /* 1B5C0 8002ADC0 04001026 */   addiu     $s0, $s0, 0x4
    /* 1B5C4 8002ADC4 0580023C */  lui        $v0, %hi(CountryMeasurement)
    /* 1B5C8 8002ADC8 CA02A393 */  lbu        $v1, 0x2CA($sp)
    /* 1B5CC 8002ADCC 10164224 */  addiu      $v0, $v0, %lo(CountryMeasurement)
    /* 1B5D0 8002ADD0 40180300 */  sll        $v1, $v1, 1
    /* 1B5D4 8002ADD4 21186200 */  addu       $v1, $v1, $v0
    /* 1B5D8 8002ADD8 00006284 */  lh         $v0, 0x0($v1)
    /* 1B5DC 8002ADDC 00000000 */  nop
    /* 1B5E0 8002ADE0 04004010 */  beqz       $v0, .L8002ADF4
    /* 1B5E4 8002ADE4 02000324 */   addiu     $v1, $zero, 0x2
    /* 1B5E8 8002ADE8 7DAB0008 */  j          .L8002ADF4
    /* 1B5EC 8002ADEC 01000324 */   addiu     $v1, $zero, 0x1
  .L8002ADF0:
    /* 1B5F0 8002ADF0 21180000 */  addu       $v1, $zero, $zero
  .L8002ADF4:
    /* 1B5F4 8002ADF4 000083AC */  sw         $v1, 0x0($a0)
  .L8002ADF8:
    /* 1B5F8 8002ADF8 21200002 */  addu       $a0, $s0, $zero
    /* 1B5FC 8002ADFC 86A5000C */  jal        Front_AppendPlayerCarData__FPiR9tFEStream
    /* 1B600 8002AE00 1000A527 */   addiu     $a1, $sp, 0x10
    /* 1B604 8002AE04 21204000 */  addu       $a0, $v0, $zero
    /* 1B608 8002AE08 BFA6000C */  jal        Front_AppendOpponentData__FPiR9tFEStream
    /* 1B60C 8002AE0C 1000A527 */   addiu     $a1, $sp, 0x10
    /* 1B610 8002AE10 21204000 */  addu       $a0, $v0, $zero
    /* 1B614 8002AE14 21A8000C */  jal        Front_AppendPerpData__FPiR9tFEStream
    /* 1B618 8002AE18 1000A527 */   addiu     $a1, $sp, 0x10
    /* 1B61C 8002AE1C 21204000 */  addu       $a0, $v0, $zero
    /* 1B620 8002AE20 8CA7000C */  jal        Front_AppendCopData__FPiR9tFEStream
    /* 1B624 8002AE24 1000A527 */   addiu     $a1, $sp, 0x10
    /* 1B628 8002AE28 21204000 */  addu       $a0, $v0, $zero
    /* 1B62C 8002AE2C C7A8000C */  jal        Front_AppendTrafficData__FPiR9tFEStream
    /* 1B630 8002AE30 1000A527 */   addiu     $a1, $sp, 0x10
    /* 1B634 8002AE34 21804000 */  addu       $s0, $v0, $zero
    /* 1B638 8002AE38 1C000224 */  addiu      $v0, $zero, 0x1C
    /* 1B63C 8002AE3C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B640 8002AE40 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B644 8002AE44 01000424 */  addiu      $a0, $zero, 0x1
    /* 1B648 8002AE48 1600A287 */  lh         $v0, 0x16($sp)
    /* 1B64C 8002AE4C B001A387 */  lh         $v1, 0x1B0($sp)
    /* 1B650 8002AE50 21280000 */  addu       $a1, $zero, $zero
    /* 1B654 8002AE54 21104300 */  addu       $v0, $v0, $v1
    /* 1B658 8002AE58 2C02A387 */  lh         $v1, 0x22C($sp)
    /* 1B65C 8002AE5C 2E02A687 */  lh         $a2, 0x22E($sp)
    /* 1B660 8002AE60 21104300 */  addu       $v0, $v0, $v1
    /* 1B664 8002AE64 21104600 */  addu       $v0, $v0, $a2
    /* 1B668 8002AE68 6202A387 */  lh         $v1, 0x262($sp)
    /* 1B66C 8002AE6C 5402A687 */  lh         $a2, 0x254($sp)
    /* 1B670 8002AE70 21104300 */  addu       $v0, $v0, $v1
    /* 1B674 8002AE74 21104600 */  addu       $v0, $v0, $a2
    /* 1B678 8002AE78 000002AE */  sw         $v0, 0x0($s0)
    /* 1B67C 8002AE7C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B680 8002AE80 E5000224 */  addiu      $v0, $zero, 0xE5
    /* 1B684 8002AE84 000002AE */  sw         $v0, 0x0($s0)
    /* 1B688 8002AE88 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B68C 8002AE8C 04001026 */   addiu     $s0, $s0, 0x4
    /* 1B690 8002AE90 000002AE */  sw         $v0, 0x0($s0)
    /* 1B694 8002AE94 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B698 8002AE98 EB000224 */  addiu      $v0, $zero, 0xEB
    /* 1B69C 8002AE9C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B6A0 8002AEA0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B6A4 8002AEA4 08000424 */  addiu      $a0, $zero, 0x8
    /* 1B6A8 8002AEA8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B6AC 8002AEAC 21280000 */   addu      $a1, $zero, $zero
    /* 1B6B0 8002AEB0 000002AE */  sw         $v0, 0x0($s0)
    /* 1B6B4 8002AEB4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B6B8 8002AEB8 E8000224 */  addiu      $v0, $zero, 0xE8
    /* 1B6BC 8002AEBC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B6C0 8002AEC0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B6C4 8002AEC4 80000424 */  addiu      $a0, $zero, 0x80
    /* 1B6C8 8002AEC8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B6CC 8002AECC 21280000 */   addu      $a1, $zero, $zero
    /* 1B6D0 8002AED0 000002AE */  sw         $v0, 0x0($s0)
    /* 1B6D4 8002AED4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B6D8 8002AED8 E9000224 */  addiu      $v0, $zero, 0xE9
    /* 1B6DC 8002AEDC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B6E0 8002AEE0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B6E4 8002AEE4 20000424 */  addiu      $a0, $zero, 0x20
    /* 1B6E8 8002AEE8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B6EC 8002AEEC 21280000 */   addu      $a1, $zero, $zero
    /* 1B6F0 8002AEF0 000002AE */  sw         $v0, 0x0($s0)
    /* 1B6F4 8002AEF4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B6F8 8002AEF8 E6000224 */  addiu      $v0, $zero, 0xE6
    /* 1B6FC 8002AEFC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B700 8002AF00 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B704 8002AF04 10000424 */  addiu      $a0, $zero, 0x10
    /* 1B708 8002AF08 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B70C 8002AF0C 21280000 */   addu      $a1, $zero, $zero
    /* 1B710 8002AF10 000002AE */  sw         $v0, 0x0($s0)
    /* 1B714 8002AF14 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B718 8002AF18 E7000224 */  addiu      $v0, $zero, 0xE7
    /* 1B71C 8002AF1C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B720 8002AF20 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B724 8002AF24 40000424 */  addiu      $a0, $zero, 0x40
    /* 1B728 8002AF28 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B72C 8002AF2C 21280000 */   addu      $a1, $zero, $zero
    /* 1B730 8002AF30 000002AE */  sw         $v0, 0x0($s0)
    /* 1B734 8002AF34 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B738 8002AF38 EA000224 */  addiu      $v0, $zero, 0xEA
    /* 1B73C 8002AF3C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B740 8002AF40 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B744 8002AF44 00400424 */  addiu      $a0, $zero, 0x4000
    /* 1B748 8002AF48 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B74C 8002AF4C 21280000 */   addu      $a1, $zero, $zero
    /* 1B750 8002AF50 000002AE */  sw         $v0, 0x0($s0)
    /* 1B754 8002AF54 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1B758 8002AF58 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1B75C 8002AF5C 62035490 */  lbu        $s4, 0x362($v0)
    /* 1B760 8002AF60 5E035284 */  lh         $s2, 0x35E($v0)
    /* 1B764 8002AF64 23000224 */  addiu      $v0, $zero, 0x23
    /* 1B768 8002AF68 08004212 */  beq        $s2, $v0, .L8002AF8C
    /* 1B76C 8002AF6C 04001026 */   addiu     $s0, $s0, 0x4
    /* 1B770 8002AF70 53000224 */  addiu      $v0, $zero, 0x53
    /* 1B774 8002AF74 03004212 */  beq        $s2, $v0, .L8002AF84
    /* 1B778 8002AF78 73000224 */   addiu     $v0, $zero, 0x73
    /* 1B77C 8002AF7C 04004216 */  bne        $s2, $v0, .L8002AF90
    /* 1B780 8002AF80 02000224 */   addiu     $v0, $zero, 0x2
  .L8002AF84:
    /* 1B784 8002AF84 E4AB0008 */  j          .L8002AF90
    /* 1B788 8002AF88 01000224 */   addiu     $v0, $zero, 0x1
  .L8002AF8C:
    /* 1B78C 8002AF8C 21100000 */  addu       $v0, $zero, $zero
  .L8002AF90:
    /* 1B790 8002AF90 21904000 */  addu       $s2, $v0, $zero
    /* 1B794 8002AF94 4F000224 */  addiu      $v0, $zero, 0x4F
    /* 1B798 8002AF98 000002AE */  sw         $v0, 0x0($s0)
    /* 1B79C 8002AF9C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B7A0 8002AFA0 1280033C */  lui        $v1, %hi(mappings)
    /* 1B7A4 8002AFA4 FC0D6324 */  addiu      $v1, $v1, %lo(mappings)
    /* 1B7A8 8002AFA8 80101400 */  sll        $v0, $s4, 2
    /* 1B7AC 8002AFAC 21105400 */  addu       $v0, $v0, $s4
    /* 1B7B0 8002AFB0 C0100200 */  sll        $v0, $v0, 3
    /* 1B7B4 8002AFB4 23105400 */  subu       $v0, $v0, $s4
    /* 1B7B8 8002AFB8 21105200 */  addu       $v0, $v0, $s2
    /* 1B7BC 8002AFBC 80100200 */  sll        $v0, $v0, 2
    /* 1B7C0 8002AFC0 21884300 */  addu       $s1, $v0, $v1
    /* 1B7C4 8002AFC4 0000248E */  lw         $a0, 0x0($s1)
    /* 1B7C8 8002AFC8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B7CC 8002AFCC 21280000 */   addu      $a1, $zero, $zero
    /* 1B7D0 8002AFD0 000002AE */  sw         $v0, 0x0($s0)
    /* 1B7D4 8002AFD4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B7D8 8002AFD8 50000224 */  addiu      $v0, $zero, 0x50
    /* 1B7DC 8002AFDC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B7E0 8002AFE0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B7E4 8002AFE4 0C00248E */  lw         $a0, 0xC($s1)
    /* 1B7E8 8002AFE8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B7EC 8002AFEC 21280000 */   addu      $a1, $zero, $zero
    /* 1B7F0 8002AFF0 000002AE */  sw         $v0, 0x0($s0)
    /* 1B7F4 8002AFF4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B7F8 8002AFF8 51000224 */  addiu      $v0, $zero, 0x51
    /* 1B7FC 8002AFFC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B800 8002B000 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B804 8002B004 1800248E */  lw         $a0, 0x18($s1)
    /* 1B808 8002B008 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B80C 8002B00C 21280000 */   addu      $a1, $zero, $zero
    /* 1B810 8002B010 000002AE */  sw         $v0, 0x0($s0)
    /* 1B814 8002B014 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B818 8002B018 52000224 */  addiu      $v0, $zero, 0x52
    /* 1B81C 8002B01C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B820 8002B020 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B824 8002B024 2400248E */  lw         $a0, 0x24($s1)
    /* 1B828 8002B028 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B82C 8002B02C 21280000 */   addu      $a1, $zero, $zero
    /* 1B830 8002B030 000002AE */  sw         $v0, 0x0($s0)
    /* 1B834 8002B034 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B838 8002B038 FB000224 */  addiu      $v0, $zero, 0xFB
    /* 1B83C 8002B03C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B840 8002B040 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B844 8002B044 6000248E */  lw         $a0, 0x60($s1)
    /* 1B848 8002B048 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B84C 8002B04C 21280000 */   addu      $a1, $zero, $zero
    /* 1B850 8002B050 000002AE */  sw         $v0, 0x0($s0)
    /* 1B854 8002B054 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B858 8002B058 53000224 */  addiu      $v0, $zero, 0x53
    /* 1B85C 8002B05C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B860 8002B060 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B864 8002B064 3000248E */  lw         $a0, 0x30($s1)
    /* 1B868 8002B068 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B86C 8002B06C 21280000 */   addu      $a1, $zero, $zero
    /* 1B870 8002B070 000002AE */  sw         $v0, 0x0($s0)
    /* 1B874 8002B074 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B878 8002B078 66000224 */  addiu      $v0, $zero, 0x66
    /* 1B87C 8002B07C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B880 8002B080 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B884 8002B084 3C00248E */  lw         $a0, 0x3C($s1)
    /* 1B888 8002B088 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B88C 8002B08C 21280000 */   addu      $a1, $zero, $zero
    /* 1B890 8002B090 000002AE */  sw         $v0, 0x0($s0)
    /* 1B894 8002B094 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B898 8002B098 67000224 */  addiu      $v0, $zero, 0x67
    /* 1B89C 8002B09C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B8A0 8002B0A0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B8A4 8002B0A4 4800248E */  lw         $a0, 0x48($s1)
    /* 1B8A8 8002B0A8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B8AC 8002B0AC 21280000 */   addu      $a1, $zero, $zero
    /* 1B8B0 8002B0B0 000002AE */  sw         $v0, 0x0($s0)
    /* 1B8B4 8002B0B4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B8B8 8002B0B8 68000224 */  addiu      $v0, $zero, 0x68
    /* 1B8BC 8002B0BC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B8C0 8002B0C0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B8C4 8002B0C4 9000248E */  lw         $a0, 0x90($s1)
    /* 1B8C8 8002B0C8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B8CC 8002B0CC 21280000 */   addu      $a1, $zero, $zero
    /* 1B8D0 8002B0D0 000002AE */  sw         $v0, 0x0($s0)
    /* 1B8D4 8002B0D4 D302A293 */  lbu        $v0, 0x2D3($sp)
    /* 1B8D8 8002B0D8 00000000 */  nop
    /* 1B8DC 8002B0DC 11004010 */  beqz       $v0, .L8002B124
    /* 1B8E0 8002B0E0 04001026 */   addiu     $s0, $s0, 0x4
    /* 1B8E4 8002B0E4 73000224 */  addiu      $v0, $zero, 0x73
    /* 1B8E8 8002B0E8 000002AE */  sw         $v0, 0x0($s0)
    /* 1B8EC 8002B0EC 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B8F0 8002B0F0 6C00248E */  lw         $a0, 0x6C($s1)
    /* 1B8F4 8002B0F4 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B8F8 8002B0F8 21280000 */   addu      $a1, $zero, $zero
    /* 1B8FC 8002B0FC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B900 8002B100 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B904 8002B104 54000224 */  addiu      $v0, $zero, 0x54
    /* 1B908 8002B108 000002AE */  sw         $v0, 0x0($s0)
    /* 1B90C 8002B10C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B910 8002B110 01000224 */  addiu      $v0, $zero, 0x1
    /* 1B914 8002B114 0F004216 */  bne        $s2, $v0, .L8002B154
    /* 1B918 8002B118 21200000 */   addu      $a0, $zero, $zero
    /* 1B91C 8002B11C 55AC0008 */  j          .L8002B154
    /* 1B920 8002B120 06000424 */   addiu     $a0, $zero, 0x6
  .L8002B124:
    /* 1B924 8002B124 73000224 */  addiu      $v0, $zero, 0x73
    /* 1B928 8002B128 000002AE */  sw         $v0, 0x0($s0)
    /* 1B92C 8002B12C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B930 8002B130 000000AE */  sw         $zero, 0x0($s0)
    /* 1B934 8002B134 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B938 8002B138 54000224 */  addiu      $v0, $zero, 0x54
    /* 1B93C 8002B13C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B940 8002B140 01000224 */  addiu      $v0, $zero, 0x1
    /* 1B944 8002B144 6C00248E */  lw         $a0, 0x6C($s1)
    /* 1B948 8002B148 02004216 */  bne        $s2, $v0, .L8002B154
    /* 1B94C 8002B14C 04001026 */   addiu     $s0, $s0, 0x4
    /* 1B950 8002B150 06008434 */  ori        $a0, $a0, 0x6
  .L8002B154:
    /* 1B954 8002B154 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B958 8002B158 21280000 */   addu      $a1, $zero, $zero
    /* 1B95C 8002B15C 000002AE */  sw         $v0, 0x0($s0)
    /* 1B960 8002B160 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B964 8002B164 4D000224 */  addiu      $v0, $zero, 0x4D
    /* 1B968 8002B168 000002AE */  sw         $v0, 0x0($s0)
    /* 1B96C 8002B16C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B970 8002B170 1280033C */  lui        $v1, %hi(mappings)
    /* 1B974 8002B174 FC0D6324 */  addiu      $v1, $v1, %lo(mappings)
    /* 1B978 8002B178 80101400 */  sll        $v0, $s4, 2
    /* 1B97C 8002B17C 21105400 */  addu       $v0, $v0, $s4
    /* 1B980 8002B180 C0100200 */  sll        $v0, $v0, 3
    /* 1B984 8002B184 23105400 */  subu       $v0, $v0, $s4
    /* 1B988 8002B188 21105200 */  addu       $v0, $v0, $s2
    /* 1B98C 8002B18C 80100200 */  sll        $v0, $v0, 2
    /* 1B990 8002B190 21884300 */  addu       $s1, $v0, $v1
    /* 1B994 8002B194 8400248E */  lw         $a0, 0x84($s1)
    /* 1B998 8002B198 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B99C 8002B19C 21280000 */   addu      $a1, $zero, $zero
    /* 1B9A0 8002B1A0 000002AE */  sw         $v0, 0x0($s0)
    /* 1B9A4 8002B1A4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B9A8 8002B1A8 75000224 */  addiu      $v0, $zero, 0x75
    /* 1B9AC 8002B1AC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B9B0 8002B1B0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B9B4 8002B1B4 5400248E */  lw         $a0, 0x54($s1)
    /* 1B9B8 8002B1B8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B9BC 8002B1BC 21280000 */   addu      $a1, $zero, $zero
    /* 1B9C0 8002B1C0 000002AE */  sw         $v0, 0x0($s0)
    /* 1B9C4 8002B1C4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B9C8 8002B1C8 65000224 */  addiu      $v0, $zero, 0x65
    /* 1B9CC 8002B1CC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B9D0 8002B1D0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B9D4 8002B1D4 5400248E */  lw         $a0, 0x54($s1)
    /* 1B9D8 8002B1D8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B9DC 8002B1DC 21280000 */   addu      $a1, $zero, $zero
    /* 1B9E0 8002B1E0 000002AE */  sw         $v0, 0x0($s0)
    /* 1B9E4 8002B1E4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B9E8 8002B1E8 85000224 */  addiu      $v0, $zero, 0x85
    /* 1B9EC 8002B1EC 000002AE */  sw         $v0, 0x0($s0)
    /* 1B9F0 8002B1F0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1B9F4 8002B1F4 00080424 */  addiu      $a0, $zero, 0x800
    /* 1B9F8 8002B1F8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1B9FC 8002B1FC 21280000 */   addu      $a1, $zero, $zero
    /* 1BA00 8002B200 000002AE */  sw         $v0, 0x0($s0)
    /* 1BA04 8002B204 1A00A393 */  lbu        $v1, 0x1A($sp)
    /* 1BA08 8002B208 07000224 */  addiu      $v0, $zero, 0x7
    /* 1BA0C 8002B20C 24006214 */  bne        $v1, $v0, .L8002B2A0
    /* 1BA10 8002B210 04001026 */   addiu     $s0, $s0, 0x4
    /* 1BA14 8002B214 1180023C */  lui        $v0, %hi(D_80114603)
    /* 1BA18 8002B218 03464290 */  lbu        $v0, %lo(D_80114603)($v0)
    /* 1BA1C 8002B21C 01001424 */  addiu      $s4, $zero, 0x1
    /* 1BA20 8002B220 18005410 */  beq        $v0, $s4, .L8002B284
    /* 1BA24 8002B224 7A000224 */   addiu     $v0, $zero, 0x7A
    /* 1BA28 8002B228 000002AE */  sw         $v0, 0x0($s0)
    /* 1BA2C 8002B22C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BA30 8002B230 00800434 */  ori        $a0, $zero, 0x8000
    /* 1BA34 8002B234 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BA38 8002B238 21280000 */   addu      $a1, $zero, $zero
    /* 1BA3C 8002B23C 000002AE */  sw         $v0, 0x0($s0)
    /* 1BA40 8002B240 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BA44 8002B244 7B000224 */  addiu      $v0, $zero, 0x7B
    /* 1BA48 8002B248 000002AE */  sw         $v0, 0x0($s0)
    /* 1BA4C 8002B24C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BA50 8002B250 00200424 */  addiu      $a0, $zero, 0x2000
    /* 1BA54 8002B254 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BA58 8002B258 21280000 */   addu      $a1, $zero, $zero
    /* 1BA5C 8002B25C 000002AE */  sw         $v0, 0x0($s0)
    /* 1BA60 8002B260 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BA64 8002B264 7C000224 */  addiu      $v0, $zero, 0x7C
    /* 1BA68 8002B268 000002AE */  sw         $v0, 0x0($s0)
    /* 1BA6C 8002B26C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BA70 8002B270 00100424 */  addiu      $a0, $zero, 0x1000
    /* 1BA74 8002B274 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BA78 8002B278 21280000 */   addu      $a1, $zero, $zero
    /* 1BA7C 8002B27C 000002AE */  sw         $v0, 0x0($s0)
    /* 1BA80 8002B280 04001026 */  addiu      $s0, $s0, 0x4
  .L8002B284:
    /* 1BA84 8002B284 81000224 */  addiu      $v0, $zero, 0x81
    /* 1BA88 8002B288 000002AE */  sw         $v0, 0x0($s0)
    /* 1BA8C 8002B28C 7800248E */  lw         $a0, 0x78($s1)
    /* 1BA90 8002B290 22005416 */  bne        $s2, $s4, .L8002B31C
    /* 1BA94 8002B294 04001026 */   addiu     $s0, $s0, 0x4
    /* 1BA98 8002B298 C7AC0008 */  j          .L8002B31C
    /* 1BA9C 8002B29C 06008434 */   ori       $a0, $a0, 0x6
  .L8002B2A0:
    /* 1BAA0 8002B2A0 82000224 */  addiu      $v0, $zero, 0x82
    /* 1BAA4 8002B2A4 000002AE */  sw         $v0, 0x0($s0)
    /* 1BAA8 8002B2A8 01000224 */  addiu      $v0, $zero, 0x1
    /* 1BAAC 8002B2AC 7800248E */  lw         $a0, 0x78($s1)
    /* 1BAB0 8002B2B0 02004216 */  bne        $s2, $v0, .L8002B2BC
    /* 1BAB4 8002B2B4 04001026 */   addiu     $s0, $s0, 0x4
    /* 1BAB8 8002B2B8 06008434 */  ori        $a0, $a0, 0x6
  .L8002B2BC:
    /* 1BABC 8002B2BC 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BAC0 8002B2C0 21280000 */   addu      $a1, $zero, $zero
    /* 1BAC4 8002B2C4 000002AE */  sw         $v0, 0x0($s0)
    /* 1BAC8 8002B2C8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BACC 8002B2CC 7D000224 */  addiu      $v0, $zero, 0x7D
    /* 1BAD0 8002B2D0 000002AE */  sw         $v0, 0x0($s0)
    /* 1BAD4 8002B2D4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BAD8 8002B2D8 0000248E */  lw         $a0, 0x0($s1)
    /* 1BADC 8002B2DC 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BAE0 8002B2E0 21280000 */   addu      $a1, $zero, $zero
    /* 1BAE4 8002B2E4 000002AE */  sw         $v0, 0x0($s0)
    /* 1BAE8 8002B2E8 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BAEC 8002B2EC 7E000224 */  addiu      $v0, $zero, 0x7E
    /* 1BAF0 8002B2F0 000002AE */  sw         $v0, 0x0($s0)
    /* 1BAF4 8002B2F4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BAF8 8002B2F8 0C00248E */  lw         $a0, 0xC($s1)
    /* 1BAFC 8002B2FC 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BB00 8002B300 21280000 */   addu      $a1, $zero, $zero
    /* 1BB04 8002B304 000002AE */  sw         $v0, 0x0($s0)
    /* 1BB08 8002B308 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BB0C 8002B30C 81000224 */  addiu      $v0, $zero, 0x81
    /* 1BB10 8002B310 000002AE */  sw         $v0, 0x0($s0)
    /* 1BB14 8002B314 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BB18 8002B318 40000424 */  addiu      $a0, $zero, 0x40
  .L8002B31C:
    /* 1BB1C 8002B31C 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BB20 8002B320 21280000 */   addu      $a1, $zero, $zero
    /* 1BB24 8002B324 000002AE */  sw         $v0, 0x0($s0)
    /* 1BB28 8002B328 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1BB2C 8002B32C 00464424 */  addiu      $a0, $v0, %lo(frontEnd)
    /* 1BB30 8002B330 03008390 */  lbu        $v1, 0x3($a0)
    /* 1BB34 8002B334 01000224 */  addiu      $v0, $zero, 0x1
    /* 1BB38 8002B338 D9006214 */  bne        $v1, $v0, .L8002B6A0
    /* 1BB3C 8002B33C 04001026 */   addiu     $s0, $s0, 0x4
    /* 1BB40 8002B340 23000224 */  addiu      $v0, $zero, 0x23
    /* 1BB44 8002B344 60039284 */  lh         $s2, 0x360($a0)
    /* 1BB48 8002B348 63039490 */  lbu        $s4, 0x363($a0)
    /* 1BB4C 8002B34C 07004212 */  beq        $s2, $v0, .L8002B36C
    /* 1BB50 8002B350 53000224 */   addiu     $v0, $zero, 0x53
    /* 1BB54 8002B354 03004212 */  beq        $s2, $v0, .L8002B364
    /* 1BB58 8002B358 73000224 */   addiu     $v0, $zero, 0x73
    /* 1BB5C 8002B35C 04004216 */  bne        $s2, $v0, .L8002B370
    /* 1BB60 8002B360 02000224 */   addiu     $v0, $zero, 0x2
  .L8002B364:
    /* 1BB64 8002B364 DCAC0008 */  j          .L8002B370
    /* 1BB68 8002B368 01000224 */   addiu     $v0, $zero, 0x1
  .L8002B36C:
    /* 1BB6C 8002B36C 21100000 */  addu       $v0, $zero, $zero
  .L8002B370:
    /* 1BB70 8002B370 21904000 */  addu       $s2, $v0, $zero
    /* 1BB74 8002B374 9B000224 */  addiu      $v0, $zero, 0x9B
    /* 1BB78 8002B378 000002AE */  sw         $v0, 0x0($s0)
    /* 1BB7C 8002B37C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BB80 8002B380 1280033C */  lui        $v1, %hi(mappings)
    /* 1BB84 8002B384 FC0D6324 */  addiu      $v1, $v1, %lo(mappings)
    /* 1BB88 8002B388 80101400 */  sll        $v0, $s4, 2
    /* 1BB8C 8002B38C 21105400 */  addu       $v0, $v0, $s4
    /* 1BB90 8002B390 C0100200 */  sll        $v0, $v0, 3
    /* 1BB94 8002B394 23105400 */  subu       $v0, $v0, $s4
    /* 1BB98 8002B398 21105200 */  addu       $v0, $v0, $s2
    /* 1BB9C 8002B39C 80100200 */  sll        $v0, $v0, 2
    /* 1BBA0 8002B3A0 21884300 */  addu       $s1, $v0, $v1
    /* 1BBA4 8002B3A4 0000248E */  lw         $a0, 0x0($s1)
    /* 1BBA8 8002B3A8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BBAC 8002B3AC 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BBB0 8002B3B0 000002AE */  sw         $v0, 0x0($s0)
    /* 1BBB4 8002B3B4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BBB8 8002B3B8 9C000224 */  addiu      $v0, $zero, 0x9C
    /* 1BBBC 8002B3BC 000002AE */  sw         $v0, 0x0($s0)
    /* 1BBC0 8002B3C0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BBC4 8002B3C4 0C00248E */  lw         $a0, 0xC($s1)
    /* 1BBC8 8002B3C8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BBCC 8002B3CC 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BBD0 8002B3D0 000002AE */  sw         $v0, 0x0($s0)
    /* 1BBD4 8002B3D4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BBD8 8002B3D8 9D000224 */  addiu      $v0, $zero, 0x9D
    /* 1BBDC 8002B3DC 000002AE */  sw         $v0, 0x0($s0)
    /* 1BBE0 8002B3E0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BBE4 8002B3E4 1800248E */  lw         $a0, 0x18($s1)
    /* 1BBE8 8002B3E8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BBEC 8002B3EC 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BBF0 8002B3F0 000002AE */  sw         $v0, 0x0($s0)
    /* 1BBF4 8002B3F4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BBF8 8002B3F8 9E000224 */  addiu      $v0, $zero, 0x9E
    /* 1BBFC 8002B3FC 000002AE */  sw         $v0, 0x0($s0)
    /* 1BC00 8002B400 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BC04 8002B404 2400248E */  lw         $a0, 0x24($s1)
    /* 1BC08 8002B408 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BC0C 8002B40C 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BC10 8002B410 000002AE */  sw         $v0, 0x0($s0)
    /* 1BC14 8002B414 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BC18 8002B418 FC000224 */  addiu      $v0, $zero, 0xFC
    /* 1BC1C 8002B41C 000002AE */  sw         $v0, 0x0($s0)
    /* 1BC20 8002B420 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BC24 8002B424 6000248E */  lw         $a0, 0x60($s1)
    /* 1BC28 8002B428 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BC2C 8002B42C 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BC30 8002B430 000002AE */  sw         $v0, 0x0($s0)
    /* 1BC34 8002B434 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BC38 8002B438 9F000224 */  addiu      $v0, $zero, 0x9F
    /* 1BC3C 8002B43C 000002AE */  sw         $v0, 0x0($s0)
    /* 1BC40 8002B440 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BC44 8002B444 3000248E */  lw         $a0, 0x30($s1)
    /* 1BC48 8002B448 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BC4C 8002B44C 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BC50 8002B450 000002AE */  sw         $v0, 0x0($s0)
    /* 1BC54 8002B454 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BC58 8002B458 B2000224 */  addiu      $v0, $zero, 0xB2
    /* 1BC5C 8002B45C 000002AE */  sw         $v0, 0x0($s0)
    /* 1BC60 8002B460 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BC64 8002B464 3C00248E */  lw         $a0, 0x3C($s1)
    /* 1BC68 8002B468 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BC6C 8002B46C 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BC70 8002B470 000002AE */  sw         $v0, 0x0($s0)
    /* 1BC74 8002B474 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BC78 8002B478 B3000224 */  addiu      $v0, $zero, 0xB3
    /* 1BC7C 8002B47C 000002AE */  sw         $v0, 0x0($s0)
    /* 1BC80 8002B480 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BC84 8002B484 4800248E */  lw         $a0, 0x48($s1)
    /* 1BC88 8002B488 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BC8C 8002B48C 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BC90 8002B490 000002AE */  sw         $v0, 0x0($s0)
    /* 1BC94 8002B494 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BC98 8002B498 B4000224 */  addiu      $v0, $zero, 0xB4
    /* 1BC9C 8002B49C 000002AE */  sw         $v0, 0x0($s0)
    /* 1BCA0 8002B4A0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BCA4 8002B4A4 9000248E */  lw         $a0, 0x90($s1)
    /* 1BCA8 8002B4A8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BCAC 8002B4AC 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BCB0 8002B4B0 000002AE */  sw         $v0, 0x0($s0)
    /* 1BCB4 8002B4B4 D302A293 */  lbu        $v0, 0x2D3($sp)
    /* 1BCB8 8002B4B8 00000000 */  nop
    /* 1BCBC 8002B4BC 11004010 */  beqz       $v0, .L8002B504
    /* 1BCC0 8002B4C0 04001026 */   addiu     $s0, $s0, 0x4
    /* 1BCC4 8002B4C4 BF000224 */  addiu      $v0, $zero, 0xBF
    /* 1BCC8 8002B4C8 000002AE */  sw         $v0, 0x0($s0)
    /* 1BCCC 8002B4CC 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BCD0 8002B4D0 6C00248E */  lw         $a0, 0x6C($s1)
    /* 1BCD4 8002B4D4 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BCD8 8002B4D8 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BCDC 8002B4DC 000002AE */  sw         $v0, 0x0($s0)
    /* 1BCE0 8002B4E0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BCE4 8002B4E4 A0000224 */  addiu      $v0, $zero, 0xA0
    /* 1BCE8 8002B4E8 000002AE */  sw         $v0, 0x0($s0)
    /* 1BCEC 8002B4EC 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BCF0 8002B4F0 01000224 */  addiu      $v0, $zero, 0x1
    /* 1BCF4 8002B4F4 0F004216 */  bne        $s2, $v0, .L8002B534
    /* 1BCF8 8002B4F8 21200000 */   addu      $a0, $zero, $zero
    /* 1BCFC 8002B4FC 4DAD0008 */  j          .L8002B534
    /* 1BD00 8002B500 06000424 */   addiu     $a0, $zero, 0x6
  .L8002B504:
    /* 1BD04 8002B504 BF000224 */  addiu      $v0, $zero, 0xBF
    /* 1BD08 8002B508 000002AE */  sw         $v0, 0x0($s0)
    /* 1BD0C 8002B50C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BD10 8002B510 000000AE */  sw         $zero, 0x0($s0)
    /* 1BD14 8002B514 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BD18 8002B518 A0000224 */  addiu      $v0, $zero, 0xA0
    /* 1BD1C 8002B51C 000002AE */  sw         $v0, 0x0($s0)
    /* 1BD20 8002B520 01000224 */  addiu      $v0, $zero, 0x1
    /* 1BD24 8002B524 6C00248E */  lw         $a0, 0x6C($s1)
    /* 1BD28 8002B528 02004216 */  bne        $s2, $v0, .L8002B534
    /* 1BD2C 8002B52C 04001026 */   addiu     $s0, $s0, 0x4
    /* 1BD30 8002B530 06008434 */  ori        $a0, $a0, 0x6
  .L8002B534:
    /* 1BD34 8002B534 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BD38 8002B538 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BD3C 8002B53C 000002AE */  sw         $v0, 0x0($s0)
    /* 1BD40 8002B540 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BD44 8002B544 99000224 */  addiu      $v0, $zero, 0x99
    /* 1BD48 8002B548 000002AE */  sw         $v0, 0x0($s0)
    /* 1BD4C 8002B54C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BD50 8002B550 1280033C */  lui        $v1, %hi(mappings)
    /* 1BD54 8002B554 FC0D6324 */  addiu      $v1, $v1, %lo(mappings)
    /* 1BD58 8002B558 80101400 */  sll        $v0, $s4, 2
    /* 1BD5C 8002B55C 21105400 */  addu       $v0, $v0, $s4
    /* 1BD60 8002B560 C0100200 */  sll        $v0, $v0, 3
    /* 1BD64 8002B564 23105400 */  subu       $v0, $v0, $s4
    /* 1BD68 8002B568 21105200 */  addu       $v0, $v0, $s2
    /* 1BD6C 8002B56C 80100200 */  sll        $v0, $v0, 2
    /* 1BD70 8002B570 21884300 */  addu       $s1, $v0, $v1
    /* 1BD74 8002B574 8400248E */  lw         $a0, 0x84($s1)
    /* 1BD78 8002B578 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BD7C 8002B57C 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BD80 8002B580 000002AE */  sw         $v0, 0x0($s0)
    /* 1BD84 8002B584 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BD88 8002B588 C1000224 */  addiu      $v0, $zero, 0xC1
    /* 1BD8C 8002B58C 000002AE */  sw         $v0, 0x0($s0)
    /* 1BD90 8002B590 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BD94 8002B594 5400248E */  lw         $a0, 0x54($s1)
    /* 1BD98 8002B598 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BD9C 8002B59C 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BDA0 8002B5A0 000002AE */  sw         $v0, 0x0($s0)
    /* 1BDA4 8002B5A4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BDA8 8002B5A8 B1000224 */  addiu      $v0, $zero, 0xB1
    /* 1BDAC 8002B5AC 000002AE */  sw         $v0, 0x0($s0)
    /* 1BDB0 8002B5B0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BDB4 8002B5B4 5400248E */  lw         $a0, 0x54($s1)
    /* 1BDB8 8002B5B8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BDBC 8002B5BC 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BDC0 8002B5C0 000002AE */  sw         $v0, 0x0($s0)
    /* 1BDC4 8002B5C4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BDC8 8002B5C8 D1000224 */  addiu      $v0, $zero, 0xD1
    /* 1BDCC 8002B5CC 000002AE */  sw         $v0, 0x0($s0)
    /* 1BDD0 8002B5D0 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BDD4 8002B5D4 00080424 */  addiu      $a0, $zero, 0x800
    /* 1BDD8 8002B5D8 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BDDC 8002B5DC 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BDE0 8002B5E0 000002AE */  sw         $v0, 0x0($s0)
    /* 1BDE4 8002B5E4 E600A393 */  lbu        $v1, 0xE6($sp)
    /* 1BDE8 8002B5E8 07000224 */  addiu      $v0, $zero, 0x7
    /* 1BDEC 8002B5EC 09006214 */  bne        $v1, $v0, .L8002B614
    /* 1BDF0 8002B5F0 04001026 */   addiu     $s0, $s0, 0x4
    /* 1BDF4 8002B5F4 CD000224 */  addiu      $v0, $zero, 0xCD
    /* 1BDF8 8002B5F8 000002AE */  sw         $v0, 0x0($s0)
    /* 1BDFC 8002B5FC 01000224 */  addiu      $v0, $zero, 0x1
    /* 1BE00 8002B600 7800248E */  lw         $a0, 0x78($s1)
    /* 1BE04 8002B604 22004216 */  bne        $s2, $v0, .L8002B690
    /* 1BE08 8002B608 04001026 */   addiu     $s0, $s0, 0x4
    /* 1BE0C 8002B60C A4AD0008 */  j          .L8002B690
    /* 1BE10 8002B610 06008434 */   ori       $a0, $a0, 0x6
  .L8002B614:
    /* 1BE14 8002B614 CE000224 */  addiu      $v0, $zero, 0xCE
    /* 1BE18 8002B618 000002AE */  sw         $v0, 0x0($s0)
    /* 1BE1C 8002B61C 01000224 */  addiu      $v0, $zero, 0x1
    /* 1BE20 8002B620 7800248E */  lw         $a0, 0x78($s1)
    /* 1BE24 8002B624 02004216 */  bne        $s2, $v0, .L8002B630
    /* 1BE28 8002B628 04001026 */   addiu     $s0, $s0, 0x4
    /* 1BE2C 8002B62C 06008434 */  ori        $a0, $a0, 0x6
  .L8002B630:
    /* 1BE30 8002B630 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BE34 8002B634 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BE38 8002B638 000002AE */  sw         $v0, 0x0($s0)
    /* 1BE3C 8002B63C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BE40 8002B640 C9000224 */  addiu      $v0, $zero, 0xC9
    /* 1BE44 8002B644 000002AE */  sw         $v0, 0x0($s0)
    /* 1BE48 8002B648 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BE4C 8002B64C 0000248E */  lw         $a0, 0x0($s1)
    /* 1BE50 8002B650 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BE54 8002B654 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BE58 8002B658 000002AE */  sw         $v0, 0x0($s0)
    /* 1BE5C 8002B65C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BE60 8002B660 CA000224 */  addiu      $v0, $zero, 0xCA
    /* 1BE64 8002B664 000002AE */  sw         $v0, 0x0($s0)
    /* 1BE68 8002B668 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BE6C 8002B66C 0C00248E */  lw         $a0, 0xC($s1)
    /* 1BE70 8002B670 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BE74 8002B674 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BE78 8002B678 000002AE */  sw         $v0, 0x0($s0)
    /* 1BE7C 8002B67C 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BE80 8002B680 CD000224 */  addiu      $v0, $zero, 0xCD
    /* 1BE84 8002B684 000002AE */  sw         $v0, 0x0($s0)
    /* 1BE88 8002B688 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BE8C 8002B68C 40000424 */  addiu      $a0, $zero, 0x40
  .L8002B690:
    /* 1BE90 8002B690 659C000C */  jal        GetPSXPadValue__Fii
    /* 1BE94 8002B694 01000524 */   addiu     $a1, $zero, 0x1
    /* 1BE98 8002B698 000002AE */  sw         $v0, 0x0($s0)
    /* 1BE9C 8002B69C 04001026 */  addiu      $s0, $s0, 0x4
  .L8002B6A0:
    /* 1BEA0 8002B6A0 000000AE */  sw         $zero, 0x0($s0)
    /* 1BEA4 8002B6A4 04001026 */  addiu      $s0, $s0, 0x4
    /* 1BEA8 8002B6A8 21206002 */  addu       $a0, $s3, $zero
    /* 1BEAC 8002B6AC 54C6030C */  jal        resizememadr
    /* 1BEB0 8002B6B0 23281302 */   subu      $a1, $s0, $s3
    /* 1BEB4 8002B6B4 21106002 */  addu       $v0, $s3, $zero
    /* 1BEB8 8002B6B8 0C03BF8F */  lw         $ra, 0x30C($sp)
    /* 1BEBC 8002B6BC 0803B48F */  lw         $s4, 0x308($sp)
    /* 1BEC0 8002B6C0 0403B38F */  lw         $s3, 0x304($sp)
    /* 1BEC4 8002B6C4 0003B28F */  lw         $s2, 0x300($sp)
    /* 1BEC8 8002B6C8 FC02B18F */  lw         $s1, 0x2FC($sp)
    /* 1BECC 8002B6CC F802B08F */  lw         $s0, 0x2F8($sp)
    /* 1BED0 8002B6D0 0800E003 */  jr         $ra
    /* 1BED4 8002B6D4 1003BD27 */   addiu     $sp, $sp, 0x310
endlabel Front_BuildStream__FPi
