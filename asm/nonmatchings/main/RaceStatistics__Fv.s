.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RaceStatistics__Fv, 0x76C

glabel RaceStatistics__Fv
    /* CA7BC 800D9FBC 50FFBD27 */  addiu      $sp, $sp, -0xB0
    /* CA7C0 800D9FC0 1180093C */  lui        $t1, %hi(GameSetup_gData)
    /* CA7C4 800D9FC4 EC312925 */  addiu      $t1, $t1, %lo(GameSetup_gData)
    /* CA7C8 800D9FC8 96000524 */  addiu      $a1, $zero, 0x96
    /* CA7CC 800D9FCC A400B7AF */  sw         $s7, 0xA4($sp)
    /* CA7D0 800D9FD0 A0001724 */  addiu      $s7, $zero, 0xA0
    /* CA7D4 800D9FD4 9000B2AF */  sw         $s2, 0x90($sp)
    /* CA7D8 800D9FD8 01001224 */  addiu      $s2, $zero, 0x1
    /* CA7DC 800D9FDC AC00BFAF */  sw         $ra, 0xAC($sp)
    /* CA7E0 800D9FE0 A800BEAF */  sw         $fp, 0xA8($sp)
    /* CA7E4 800D9FE4 A000B6AF */  sw         $s6, 0xA0($sp)
    /* CA7E8 800D9FE8 9C00B5AF */  sw         $s5, 0x9C($sp)
    /* CA7EC 800D9FEC 9800B4AF */  sw         $s4, 0x98($sp)
    /* CA7F0 800D9FF0 9400B3AF */  sw         $s3, 0x94($sp)
    /* CA7F4 800D9FF4 8C00B1AF */  sw         $s1, 0x8C($sp)
    /* CA7F8 800D9FF8 8800B0AF */  sw         $s0, 0x88($sp)
    /* CA7FC 800D9FFC 0400268D */  lw         $a2, 0x4($t1)
    /* CA800 800DA000 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* CA804 800DA004 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* CA808 800DA008 0100C424 */  addiu      $a0, $a2, 0x1
    /* CA80C 800DA00C 18006500 */  mult       $v1, $a1
    /* CA810 800DA010 40100400 */  sll        $v0, $a0, 1
    /* CA814 800DA014 21104400 */  addu       $v0, $v0, $a0
    /* CA818 800DA018 80200200 */  sll        $a0, $v0, 2
    /* CA81C 800DA01C 28008924 */  addiu      $t1, $a0, 0x28
    /* CA820 800DA020 80100300 */  sll        $v0, $v1, 2
    /* CA824 800DA024 21104300 */  addu       $v0, $v0, $v1
    /* CA828 800DA028 00190200 */  sll        $v1, $v0, 4
    /* CA82C 800DA02C 23186200 */  subu       $v1, $v1, $v0
    /* CA830 800DA030 23A0E302 */  subu       $s4, $s7, $v1
    /* CA834 800DA034 5800A9A7 */  sh         $t1, 0x58($sp)
    /* CA838 800DA038 4800B4A7 */  sh         $s4, 0x48($sp)
    /* CA83C 800DA03C 12980000 */  mflo       $s3
    /* CA840 800DA040 0300D214 */  bne        $a2, $s2, .L800DA050
    /* CA844 800DA044 5000B3A7 */   sh        $s3, 0x50($sp)
    /* CA848 800DA048 1C008424 */  addiu      $a0, $a0, 0x1C
    /* CA84C 800DA04C 5800A4A7 */  sh         $a0, 0x58($sp)
  .L800DA050:
    /* CA850 800DA050 1180093C */  lui        $t1, %hi(GameSetup_gData)
    /* CA854 800DA054 EC31228D */  lw         $v0, %lo(GameSetup_gData)($t1)
    /* CA858 800DA058 00000000 */  nop
    /* CA85C 800DA05C 05005214 */  bne        $v0, $s2, .L800DA074
    /* CA860 800DA060 00000000 */   nop
    /* CA864 800DA064 5800A997 */  lhu        $t1, 0x58($sp)
    /* CA868 800DA068 00000000 */  nop
    /* CA86C 800DA06C 1B002925 */  addiu      $t1, $t1, 0x1B
    /* CA870 800DA070 5800A9A7 */  sh         $t1, 0x58($sp)
  .L800DA074:
    /* CA874 800DA074 39000424 */  addiu      $a0, $zero, 0x39
    /* CA878 800DA078 5800A997 */  lhu        $t1, 0x58($sp)
    /* CA87C 800DA07C 78000224 */  addiu      $v0, $zero, 0x78
    /* CA880 800DA080 004C0900 */  sll        $t1, $t1, 16
    /* CA884 800DA084 43840900 */  sra        $s0, $t1, 17
    /* CA888 800DA088 23105000 */  subu       $v0, $v0, $s0
    /* CA88C 800DA08C 6800A9AF */  sw         $t1, 0x68($sp)
    /* CA890 800DA090 94E4020C */  jal        TextSys_Word__Fi
    /* CA894 800DA094 6C00A2AF */   sw        $v0, 0x6C($sp)
    /* CA898 800DA098 888F030C */  jal        textpixels
    /* CA89C 800DA09C 21204000 */   addu      $a0, $v0, $zero
    /* CA8A0 800DA0A0 0A008326 */  addiu      $v1, $s4, 0xA
    /* CA8A4 800DA0A4 21B06000 */  addu       $s6, $v1, $zero
    /* CA8A8 800DA0A8 A0001524 */  addiu      $s5, $zero, 0xA0
    /* CA8AC 800DA0AC 43100200 */  sra        $v0, $v0, 1
    /* CA8B0 800DA0B0 23B8E202 */  subu       $s7, $s7, $v0
    /* CA8B4 800DA0B4 6C00A997 */  lhu        $t1, 0x6C($sp)
    /* CA8B8 800DA0B8 76000224 */  addiu      $v0, $zero, 0x76
    /* CA8BC 800DA0BC 6000A9A7 */  sh         $t1, 0x60($sp)
    /* CA8C0 800DA0C0 1180093C */  lui        $t1, %hi(GameSetup_gData)
    /* CA8C4 800DA0C4 EC312925 */  addiu      $t1, $t1, %lo(GameSetup_gData)
    /* CA8C8 800DA0C8 0400238D */  lw         $v1, 0x4($t1)
    /* CA8CC 800DA0CC 23805000 */  subu       $s0, $v0, $s0
    /* CA8D0 800DA0D0 02006324 */  addiu      $v1, $v1, 0x2
    /* CA8D4 800DA0D4 40100300 */  sll        $v0, $v1, 1
    /* CA8D8 800DA0D8 21104300 */  addu       $v0, $v0, $v1
    /* CA8DC 800DA0DC 80100200 */  sll        $v0, $v0, 2
    /* CA8E0 800DA0E0 21100202 */  addu       $v0, $s0, $v0
    /* CA8E4 800DA0E4 13005E24 */  addiu      $fp, $v0, 0x13
    /* CA8E8 800DA0E8 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* CA8EC 800DA0EC 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* CA8F0 800DA0F0 00000000 */  nop
    /* CA8F4 800DA0F4 02004228 */  slti       $v0, $v0, 0x2
    /* CA8F8 800DA0F8 02004014 */  bnez       $v0, .L800DA104
    /* CA8FC 800DA0FC 7000BEA7 */   sh        $fp, 0x70($sp)
    /* CA900 800DA100 55001524 */  addiu      $s5, $zero, 0x55
  .L800DA104:
    /* CA904 800DA104 832C030C */  jal        Font_TextColor__Fi
    /* CA908 800DA108 06000424 */   addiu     $a0, $zero, 0x6
    /* CA90C 800DA10C 94E4020C */  jal        TextSys_Word__Fi
    /* CA910 800DA110 39000424 */   addiu     $a0, $zero, 0x39
    /* CA914 800DA114 21204000 */  addu       $a0, $v0, $zero
    /* CA918 800DA118 002C1700 */  sll        $a1, $s7, 16
    /* CA91C 800DA11C 032C0500 */  sra        $a1, $a1, 16
    /* CA920 800DA120 A42E030C */  jal        Font_TextXY__FPcii
    /* CA924 800DA124 21300002 */   addu      $a2, $s0, $zero
    /* CA928 800DA128 21200000 */  addu       $a0, $zero, $zero
    /* CA92C 800DA12C 00141400 */  sll        $v0, $s4, 16
    /* CA930 800DA130 03A40200 */  sra        $s4, $v0, 16
    /* CA934 800DA134 21288002 */  addu       $a1, $s4, $zero
    /* CA938 800DA138 11000226 */  addiu      $v0, $s0, 0x11
    /* CA93C 800DA13C 00140200 */  sll        $v0, $v0, 16
    /* CA940 800DA140 038C0200 */  sra        $s1, $v0, 16
    /* CA944 800DA144 0B002626 */  addiu      $a2, $s1, 0xB
    /* CA948 800DA148 00141300 */  sll        $v0, $s3, 16
    /* CA94C 800DA14C 03840200 */  sra        $s0, $v0, 16
    /* CA950 800DA150 21380002 */  addu       $a3, $s0, $zero
    /* CA954 800DA154 1000B2AF */  sw         $s2, 0x10($sp)
    /* CA958 800DA158 1400A0AF */  sw         $zero, 0x14($sp)
    /* CA95C 800DA15C 1800A0AF */  sw         $zero, 0x18($sp)
    /* CA960 800DA160 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CA964 800DA164 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* CA968 800DA168 1180093C */  lui        $t1, %hi(GameSetup_gData)
    /* CA96C 800DA16C EC31228D */  lw         $v0, %lo(GameSetup_gData)($t1)
    /* CA970 800DA170 00000000 */  nop
    /* CA974 800DA174 0C005214 */  bne        $v0, $s2, .L800DA1A8
    /* CA978 800DA178 21B80000 */   addu      $s7, $zero, $zero
    /* CA97C 800DA17C 21200000 */  addu       $a0, $zero, $zero
    /* CA980 800DA180 21288002 */  addu       $a1, $s4, $zero
    /* CA984 800DA184 00341E00 */  sll        $a2, $fp, 16
    /* CA988 800DA188 03340600 */  sra        $a2, $a2, 16
    /* CA98C 800DA18C 21380002 */  addu       $a3, $s0, $zero
    /* CA990 800DA190 1000A2AF */  sw         $v0, 0x10($sp)
    /* CA994 800DA194 1400A0AF */  sw         $zero, 0x14($sp)
    /* CA998 800DA198 1800A0AF */  sw         $zero, 0x18($sp)
    /* CA99C 800DA19C 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CA9A0 800DA1A0 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* CA9A4 800DA1A4 21B80000 */  addu       $s7, $zero, $zero
  .L800DA1A8:
    /* CA9A8 800DA1A8 6C00A98F */  lw         $t1, 0x6C($sp)
    /* CA9AC 800DA1AC 21982002 */  addu       $s3, $s1, $zero
    /* CA9B0 800DA1B0 7C00A9AF */  sw         $t1, 0x7C($sp)
    /* CA9B4 800DA1B4 6800A98F */  lw         $t1, 0x68($sp)
    /* CA9B8 800DA1B8 11801E3C */  lui        $fp, %hi(GameSetup_gData)
    /* CA9BC 800DA1BC EC31DE27 */  addiu      $fp, $fp, %lo(GameSetup_gData)
    /* CA9C0 800DA1C0 034C0900 */  sra        $t1, $t1, 16
    /* CA9C4 800DA1C4 7800A9AF */  sw         $t1, 0x78($sp)
    /* CA9C8 800DA1C8 F8FF2925 */  addiu      $t1, $t1, -0x8
    /* CA9CC 800DA1CC 8000A9AF */  sw         $t1, 0x80($sp)
  .L800DA1D0:
    /* CA9D0 800DA1D0 001C1700 */  sll        $v1, $s7, 16
    /* CA9D4 800DA1D4 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* CA9D8 800DA1D8 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* CA9DC 800DA1DC 03840300 */  sra        $s0, $v1, 16
    /* CA9E0 800DA1E0 2A100202 */  slt        $v0, $s0, $v0
    /* CA9E4 800DA1E4 2D014010 */  beqz       $v0, .L800DA69C
    /* CA9E8 800DA1E8 1180023C */   lui       $v0, %hi(Cars_gRaceCarList)
    /* CA9EC 800DA1EC 00FA4224 */  addiu      $v0, $v0, %lo(Cars_gRaceCarList)
    /* CA9F0 800DA1F0 80A01000 */  sll        $s4, $s0, 2
    /* CA9F4 800DA1F4 21888202 */  addu       $s1, $s4, $v0
    /* CA9F8 800DA1F8 0000228E */  lw         $v0, 0x0($s1)
    /* CA9FC 800DA1FC 00000000 */  nop
    /* CAA00 800DA200 8802448C */  lw         $a0, 0x288($v0)
    /* CAA04 800DA204 888F030C */  jal        textpixels
    /* CAA08 800DA208 5C008424 */   addiu     $a0, $a0, 0x5C
    /* CAA0C 800DA20C 21200000 */  addu       $a0, $zero, $zero
    /* CAA10 800DA210 00441500 */  sll        $t0, $s5, 16
    /* CAA14 800DA214 03440800 */  sra        $t0, $t0, 16
    /* CAA18 800DA218 FEFF0525 */  addiu      $a1, $t0, -0x2
    /* CAA1C 800DA21C 0B006626 */  addiu      $a2, $s3, 0xB
    /* CAA20 800DA220 01000724 */  addiu      $a3, $zero, 0x1
    /* CAA24 800DA224 0710E200 */  srav       $v0, $v0, $a3
    /* CAA28 800DA228 02004224 */  addiu      $v0, $v0, 0x2
    /* CAA2C 800DA22C 7C00A98F */  lw         $t1, 0x7C($sp)
    /* CAA30 800DA230 23900201 */  subu       $s2, $t0, $v0
    /* CAA34 800DA234 1400A0AF */  sw         $zero, 0x14($sp)
    /* CAA38 800DA238 1800A0AF */  sw         $zero, 0x18($sp)
    /* CAA3C 800DA23C 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* CAA40 800DA240 23186902 */  subu       $v1, $s3, $t1
    /* CAA44 800DA244 7800A98F */  lw         $t1, 0x78($sp)
    /* CAA48 800DA248 13006324 */  addiu      $v1, $v1, 0x13
    /* CAA4C 800DA24C 23182301 */  subu       $v1, $t1, $v1
    /* CAA50 800DA250 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CAA54 800DA254 1000A3AF */   sw        $v1, 0x10($sp)
    /* CAA58 800DA258 0C00001A */  blez       $s0, .L800DA28C
    /* CAA5C 800DA25C 21200000 */   addu      $a0, $zero, $zero
    /* CAA60 800DA260 002C1600 */  sll        $a1, $s6, 16
    /* CAA64 800DA264 032C0500 */  sra        $a1, $a1, 16
    /* CAA68 800DA268 FEFFA524 */  addiu      $a1, $a1, -0x2
    /* CAA6C 800DA26C 7C00A68F */  lw         $a2, 0x7C($sp)
    /* CAA70 800DA270 8000A98F */  lw         $t1, 0x80($sp)
    /* CAA74 800DA274 01000724 */  addiu      $a3, $zero, 0x1
    /* CAA78 800DA278 1400A0AF */  sw         $zero, 0x14($sp)
    /* CAA7C 800DA27C 1800A0AF */  sw         $zero, 0x18($sp)
    /* CAA80 800DA280 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* CAA84 800DA284 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CAA88 800DA288 1000A9AF */   sw        $t1, 0x10($sp)
  .L800DA28C:
    /* CAA8C 800DA28C 5014828F */  lw         $v0, %gp_rel(D_8013D99C)($gp)
    /* CAA90 800DA290 00000000 */  nop
    /* CAA94 800DA294 03004228 */  slti       $v0, $v0, 0x3
    /* CAA98 800DA298 0E004014 */  bnez       $v0, .L800DA2D4
    /* CAA9C 800DA29C 00000000 */   nop
    /* CAAA0 800DA2A0 832C030C */  jal        Font_TextColor__Fi
    /* CAAA4 800DA2A4 03000424 */   addiu     $a0, $zero, 0x3
    /* CAAA8 800DA2A8 2000A427 */  addiu      $a0, $sp, 0x20
    /* CAAAC 800DA2AC 0000228E */  lw         $v0, 0x0($s1)
    /* CAAB0 800DA2B0 1480053C */  lui        $a1, %hi(D_8013D990)
    /* CAAB4 800DA2B4 8802468C */  lw         $a2, 0x288($v0)
    /* CAAB8 800DA2B8 90D9A524 */  addiu      $a1, $a1, %lo(D_8013D990)
    /* CAABC 800DA2BC 2F91030C */  jal        sprintf
    /* CAAC0 800DA2C0 5C00C624 */   addiu     $a2, $a2, 0x5C
    /* CAAC4 800DA2C4 2000A427 */  addiu      $a0, $sp, 0x20
    /* CAAC8 800DA2C8 21284002 */  addu       $a1, $s2, $zero
    /* CAACC 800DA2CC A42E030C */  jal        Font_TextXY__FPcii
    /* CAAD0 800DA2D0 FCFF6626 */   addiu     $a2, $s3, -0x4
  .L800DA2D4:
    /* CAAD4 800DA2D4 0400C28F */  lw         $v0, 0x4($fp)
    /* CAAD8 800DA2D8 01000924 */  addiu      $t1, $zero, 0x1
    /* CAADC 800DA2DC 4B004910 */  beq        $v0, $t1, .L800DA40C
    /* CAAE0 800DA2E0 00000000 */   nop
    /* CAAE4 800DA2E4 49004018 */  blez       $v0, .L800DA40C
    /* CAAE8 800DA2E8 21880000 */   addu      $s1, $zero, $zero
    /* CAAEC 800DA2EC 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* CAAF0 800DA2F0 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* CAAF4 800DA2F4 21908202 */  addu       $s2, $s4, $v0
    /* CAAF8 800DA2F8 00141100 */  sll        $v0, $s1, 16
  .L800DA2FC:
    /* CAAFC 800DA2FC 032C0200 */  sra        $a1, $v0, 16
    /* CAB00 800DA300 40100500 */  sll        $v0, $a1, 1
    /* CAB04 800DA304 5014838F */  lw         $v1, %gp_rel(D_8013D99C)($gp)
    /* CAB08 800DA308 04004224 */  addiu      $v0, $v0, 0x4
    /* CAB0C 800DA30C 2A104300 */  slt        $v0, $v0, $v1
    /* CAB10 800DA310 35004010 */  beqz       $v0, .L800DA3E8
    /* CAB14 800DA314 80100500 */   sll       $v0, $a1, 2
    /* CAB18 800DA318 0000448E */  lw         $a0, 0x0($s2)
    /* CAB1C 800DA31C 00000000 */  nop
    /* CAB20 800DA320 21108200 */  addu       $v0, $a0, $v0
    /* CAB24 800DA324 D803438C */  lw         $v1, 0x3D8($v0)
    /* CAB28 800DA328 00000000 */  nop
    /* CAB2C 800DA32C 05006010 */  beqz       $v1, .L800DA344
    /* CAB30 800DA330 00000000 */   nop
    /* CAB34 800DA334 E803828C */  lw         $v0, 0x3E8($a0)
    /* CAB38 800DA338 00000000 */  nop
    /* CAB3C 800DA33C 02006210 */  beq        $v1, $v0, .L800DA348
    /* CAB40 800DA340 03000424 */   addiu     $a0, $zero, 0x3
  .L800DA344:
    /* CAB44 800DA344 04000424 */  addiu      $a0, $zero, 0x4
  .L800DA348:
    /* CAB48 800DA348 832C030C */  jal        Font_TextColor__Fi
    /* CAB4C 800DA34C 00841100 */   sll       $s0, $s1, 16
    /* CAB50 800DA350 94E4020C */  jal        TextSys_Word__Fi
    /* CAB54 800DA354 34000424 */   addiu     $a0, $zero, 0x34
    /* CAB58 800DA358 2000A427 */  addiu      $a0, $sp, 0x20
    /* CAB5C 800DA35C 21284000 */  addu       $a1, $v0, $zero
    /* CAB60 800DA360 03841000 */  sra        $s0, $s0, 16
    /* CAB64 800DA364 2F91030C */  jal        sprintf
    /* CAB68 800DA368 01000626 */   addiu     $a2, $s0, 0x1
    /* CAB6C 800DA36C 2000A427 */  addiu      $a0, $sp, 0x20
    /* CAB70 800DA370 002C1600 */  sll        $a1, $s6, 16
    /* CAB74 800DA374 032C0500 */  sra        $a1, $a1, 16
    /* CAB78 800DA378 40301000 */  sll        $a2, $s0, 1
    /* CAB7C 800DA37C 2130D000 */  addu       $a2, $a2, $s0
    /* CAB80 800DA380 80300600 */  sll        $a2, $a2, 2
    /* CAB84 800DA384 21306602 */  addu       $a2, $s3, $a2
    /* CAB88 800DA388 A42E030C */  jal        Font_TextXY__FPcii
    /* CAB8C 800DA38C 0C00C624 */   addiu     $a2, $a2, 0xC
    /* CAB90 800DA390 0000428E */  lw         $v0, 0x0($s2)
    /* CAB94 800DA394 80801000 */  sll        $s0, $s0, 2
    /* CAB98 800DA398 21105000 */  addu       $v0, $v0, $s0
    /* CAB9C 800DA39C D803448C */  lw         $a0, 0x3D8($v0)
    /* CABA0 800DA3A0 00000000 */  nop
    /* CABA4 800DA3A4 02008014 */  bnez       $a0, .L800DA3B0
    /* CABA8 800DA3A8 00000000 */   nop
    /* CABAC 800DA3AC 21200000 */  addu       $a0, $zero, $zero
  .L800DA3B0:
    /* CABB0 800DA3B0 5963030C */  jal        Hud_ParseTime__FiPc
    /* CABB4 800DA3B4 2000A527 */   addiu     $a1, $sp, 0x20
    /* CABB8 800DA3B8 2000A427 */  addiu      $a0, $sp, 0x20
    /* CABBC 800DA3BC 002C1500 */  sll        $a1, $s5, 16
    /* CABC0 800DA3C0 032C0500 */  sra        $a1, $a1, 16
    /* CABC4 800DA3C4 0500A524 */  addiu      $a1, $a1, 0x5
    /* CABC8 800DA3C8 00141100 */  sll        $v0, $s1, 16
    /* CABCC 800DA3CC 03140200 */  sra        $v0, $v0, 16
    /* CABD0 800DA3D0 40300200 */  sll        $a2, $v0, 1
    /* CABD4 800DA3D4 2130C200 */  addu       $a2, $a2, $v0
    /* CABD8 800DA3D8 80300600 */  sll        $a2, $a2, 2
    /* CABDC 800DA3DC 21306602 */  addu       $a2, $s3, $a2
    /* CABE0 800DA3E0 A42E030C */  jal        Font_TextXY__FPcii
    /* CABE4 800DA3E4 0C00C624 */   addiu     $a2, $a2, 0xC
  .L800DA3E8:
    /* CABE8 800DA3E8 01002226 */  addiu      $v0, $s1, 0x1
    /* CABEC 800DA3EC 21884000 */  addu       $s1, $v0, $zero
    /* CABF0 800DA3F0 00140200 */  sll        $v0, $v0, 16
    /* CABF4 800DA3F4 0400C38F */  lw         $v1, 0x4($fp)
    /* CABF8 800DA3F8 03140200 */  sra        $v0, $v0, 16
    /* CABFC 800DA3FC 2A104300 */  slt        $v0, $v0, $v1
    /* CAC00 800DA400 BEFF4014 */  bnez       $v0, .L800DA2FC
    /* CAC04 800DA404 00141100 */   sll       $v0, $s1, 16
    /* CAC08 800DA408 0400C28F */  lw         $v0, 0x4($fp)
  .L800DA40C:
    /* CAC0C 800DA40C 5014838F */  lw         $v1, %gp_rel(D_8013D99C)($gp)
    /* CAC10 800DA410 40100200 */  sll        $v0, $v0, 1
    /* CAC14 800DA414 04004224 */  addiu      $v0, $v0, 0x4
    /* CAC18 800DA418 2A104300 */  slt        $v0, $v0, $v1
    /* CAC1C 800DA41C 47004010 */  beqz       $v0, .L800DA53C
    /* CAC20 800DA420 1180093C */   lui       $t1, %hi(GameSetup_gData)
    /* CAC24 800DA424 94E4020C */  jal        TextSys_Word__Fi
    /* CAC28 800DA428 37000424 */   addiu     $a0, $zero, 0x37
    /* CAC2C 800DA42C 2000A427 */  addiu      $a0, $sp, 0x20
    /* CAC30 800DA430 2F91030C */  jal        sprintf
    /* CAC34 800DA434 21284000 */   addu      $a1, $v0, $zero
    /* CAC38 800DA438 832C030C */  jal        Font_TextColor__Fi
    /* CAC3C 800DA43C 03000424 */   addiu     $a0, $zero, 0x3
    /* CAC40 800DA440 0400C28F */  lw         $v0, 0x4($fp)
    /* CAC44 800DA444 01000924 */  addiu      $t1, $zero, 0x1
    /* CAC48 800DA448 40180200 */  sll        $v1, $v0, 1
    /* CAC4C 800DA44C 21186200 */  addu       $v1, $v1, $v0
    /* CAC50 800DA450 80180300 */  sll        $v1, $v1, 2
    /* CAC54 800DA454 21306302 */  addu       $a2, $s3, $v1
    /* CAC58 800DA458 001C1600 */  sll        $v1, $s6, 16
    /* CAC5C 800DA45C 02004910 */  beq        $v0, $t1, .L800DA468
    /* CAC60 800DA460 032C0300 */   sra       $a1, $v1, 16
    /* CAC64 800DA464 0C00C624 */  addiu      $a2, $a2, 0xC
  .L800DA468:
    /* CAC68 800DA468 A42E030C */  jal        Font_TextXY__FPcii
    /* CAC6C 800DA46C 2000A427 */   addiu     $a0, $sp, 0x20
    /* CAC70 800DA470 00141700 */  sll        $v0, $s7, 16
    /* CAC74 800DA474 B800C38F */  lw         $v1, 0xB8($fp)
    /* CAC78 800DA478 03140200 */  sra        $v0, $v0, 16
    /* CAC7C 800DA47C 03006214 */  bne        $v1, $v0, .L800DA48C
    /* CAC80 800DA480 1180033C */   lui       $v1, %hi(Cars_gHumanRaceCarList)
    /* CAC84 800DA484 3A690308 */  j          .L800DA4E8
    /* CAC88 800DA488 36000424 */   addiu     $a0, $zero, 0x36
  .L800DA48C:
    /* CAC8C 800DA48C 48FA6324 */  addiu      $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* CAC90 800DA490 80100200 */  sll        $v0, $v0, 2
    /* CAC94 800DA494 21104300 */  addu       $v0, $v0, $v1
    /* CAC98 800DA498 0000448C */  lw         $a0, 0x0($v0)
    /* CAC9C 800DA49C 00000000 */  nop
    /* CACA0 800DA4A0 CC03838C */  lw         $v1, 0x3CC($a0)
    /* CACA4 800DA4A4 02000224 */  addiu      $v0, $zero, 0x2
    /* CACA8 800DA4A8 06006214 */  bne        $v1, $v0, .L800DA4C4
    /* CACAC 800DA4AC 1180093C */   lui       $t1, %hi(GameSetup_gData)
    /* CACB0 800DA4B0 D403848C */  lw         $a0, 0x3D4($a0)
    /* CACB4 800DA4B4 5963030C */  jal        Hud_ParseTime__FiPc
    /* CACB8 800DA4B8 2000A527 */   addiu     $a1, $sp, 0x20
    /* CACBC 800DA4BC 40690308 */  j          .L800DA500
    /* CACC0 800DA4C0 00141500 */   sll       $v0, $s5, 16
  .L800DA4C4:
    /* CACC4 800DA4C4 EC31228D */  lw         $v0, %lo(GameSetup_gData)($t1)
    /* CACC8 800DA4C8 01000924 */  addiu      $t1, $zero, 0x1
    /* CACCC 800DA4CC 05004914 */  bne        $v0, $t1, .L800DA4E4
    /* CACD0 800DA4D0 00000000 */   nop
    /* CACD4 800DA4D4 C803828C */  lw         $v0, 0x3C8($a0)
    /* CACD8 800DA4D8 00000000 */  nop
    /* CACDC 800DA4DC 02004014 */  bnez       $v0, .L800DA4E8
    /* CACE0 800DA4E0 3D000424 */   addiu     $a0, $zero, 0x3D
  .L800DA4E4:
    /* CACE4 800DA4E4 35000424 */  addiu      $a0, $zero, 0x35
  .L800DA4E8:
    /* CACE8 800DA4E8 94E4020C */  jal        TextSys_Word__Fi
    /* CACEC 800DA4EC 00000000 */   nop
    /* CACF0 800DA4F0 2000A427 */  addiu      $a0, $sp, 0x20
    /* CACF4 800DA4F4 2F91030C */  jal        sprintf
    /* CACF8 800DA4F8 21284000 */   addu      $a1, $v0, $zero
    /* CACFC 800DA4FC 00141500 */  sll        $v0, $s5, 16
  .L800DA500:
    /* CAD00 800DA500 03140200 */  sra        $v0, $v0, 16
    /* CAD04 800DA504 0400C38F */  lw         $v1, 0x4($fp)
    /* CAD08 800DA508 01000924 */  addiu      $t1, $zero, 0x1
    /* CAD0C 800DA50C 07006910 */  beq        $v1, $t1, .L800DA52C
    /* CAD10 800DA510 05004524 */   addiu     $a1, $v0, 0x5
    /* CAD14 800DA514 04102301 */  sllv       $v0, $v1, $t1
    /* CAD18 800DA518 21104300 */  addu       $v0, $v0, $v1
    /* CAD1C 800DA51C 80100200 */  sll        $v0, $v0, 2
    /* CAD20 800DA520 21106202 */  addu       $v0, $s3, $v0
    /* CAD24 800DA524 4C690308 */  j          .L800DA530
    /* CAD28 800DA528 0C004624 */   addiu     $a2, $v0, 0xC
  .L800DA52C:
    /* CAD2C 800DA52C 0C006626 */  addiu      $a2, $s3, 0xC
  .L800DA530:
    /* CAD30 800DA530 A42E030C */  jal        Font_TextXY__FPcii
    /* CAD34 800DA534 2000A427 */   addiu     $a0, $sp, 0x20
    /* CAD38 800DA538 1180093C */  lui        $t1, %hi(GameSetup_gData)
  .L800DA53C:
    /* CAD3C 800DA53C EC31228D */  lw         $v0, %lo(GameSetup_gData)($t1)
    /* CAD40 800DA540 01000924 */  addiu      $t1, $zero, 0x1
    /* CAD44 800DA544 51004914 */  bne        $v0, $t1, .L800DA68C
    /* CAD48 800DA548 00000000 */   nop
    /* CAD4C 800DA54C 0400C28F */  lw         $v0, 0x4($fp)
    /* CAD50 800DA550 5014838F */  lw         $v1, %gp_rel(D_8013D99C)($gp)
    /* CAD54 800DA554 04102201 */  sllv       $v0, $v0, $t1
    /* CAD58 800DA558 06004224 */  addiu      $v0, $v0, 0x6
    /* CAD5C 800DA55C 2A104300 */  slt        $v0, $v0, $v1
    /* CAD60 800DA560 22004010 */  beqz       $v0, .L800DA5EC
    /* CAD64 800DA564 00000000 */   nop
    /* CAD68 800DA568 94E4020C */  jal        TextSys_Word__Fi
    /* CAD6C 800DA56C 3E000424 */   addiu     $a0, $zero, 0x3E
    /* CAD70 800DA570 2000A427 */  addiu      $a0, $sp, 0x20
    /* CAD74 800DA574 2F91030C */  jal        sprintf
    /* CAD78 800DA578 21284000 */   addu      $a1, $v0, $zero
    /* CAD7C 800DA57C 832C030C */  jal        Font_TextColor__Fi
    /* CAD80 800DA580 03000424 */   addiu     $a0, $zero, 0x3
    /* CAD84 800DA584 2000A427 */  addiu      $a0, $sp, 0x20
    /* CAD88 800DA588 002C1600 */  sll        $a1, $s6, 16
    /* CAD8C 800DA58C 7000A997 */  lhu        $t1, 0x70($sp)
    /* CAD90 800DA590 032C0500 */  sra        $a1, $a1, 16
    /* CAD94 800DA594 00840900 */  sll        $s0, $t1, 16
    /* CAD98 800DA598 03841000 */  sra        $s0, $s0, 16
    /* CAD9C 800DA59C 01001026 */  addiu      $s0, $s0, 0x1
    /* CADA0 800DA5A0 A42E030C */  jal        Font_TextXY__FPcii
    /* CADA4 800DA5A4 21300002 */   addu      $a2, $s0, $zero
    /* CADA8 800DA5A8 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* CADAC 800DA5AC 48FA6324 */  addiu      $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* CADB0 800DA5B0 00141700 */  sll        $v0, $s7, 16
    /* CADB4 800DA5B4 83130200 */  sra        $v0, $v0, 14
    /* CADB8 800DA5B8 21104300 */  addu       $v0, $v0, $v1
    /* CADBC 800DA5BC 2000A427 */  addiu      $a0, $sp, 0x20
    /* CADC0 800DA5C0 0000428C */  lw         $v0, 0x0($v0)
    /* CADC4 800DA5C4 1480053C */  lui        $a1, %hi(D_8013D98C)
    /* CADC8 800DA5C8 C003468C */  lw         $a2, 0x3C0($v0)
    /* CADCC 800DA5CC 2F91030C */  jal        sprintf
    /* CADD0 800DA5D0 8CD9A524 */   addiu     $a1, $a1, %lo(D_8013D98C)
    /* CADD4 800DA5D4 2000A427 */  addiu      $a0, $sp, 0x20
    /* CADD8 800DA5D8 002C1500 */  sll        $a1, $s5, 16
    /* CADDC 800DA5DC 032C0500 */  sra        $a1, $a1, 16
    /* CADE0 800DA5E0 0500A524 */  addiu      $a1, $a1, 0x5
    /* CADE4 800DA5E4 A42E030C */  jal        Font_TextXY__FPcii
    /* CADE8 800DA5E8 21300002 */   addu      $a2, $s0, $zero
  .L800DA5EC:
    /* CADEC 800DA5EC 0400C28F */  lw         $v0, 0x4($fp)
    /* CADF0 800DA5F0 5014838F */  lw         $v1, %gp_rel(D_8013D99C)($gp)
    /* CADF4 800DA5F4 40100200 */  sll        $v0, $v0, 1
    /* CADF8 800DA5F8 08004224 */  addiu      $v0, $v0, 0x8
    /* CADFC 800DA5FC 2A104300 */  slt        $v0, $v0, $v1
    /* CAE00 800DA600 22004010 */  beqz       $v0, .L800DA68C
    /* CAE04 800DA604 00000000 */   nop
    /* CAE08 800DA608 94E4020C */  jal        TextSys_Word__Fi
    /* CAE0C 800DA60C 3F000424 */   addiu     $a0, $zero, 0x3F
    /* CAE10 800DA610 2000A427 */  addiu      $a0, $sp, 0x20
    /* CAE14 800DA614 2F91030C */  jal        sprintf
    /* CAE18 800DA618 21284000 */   addu      $a1, $v0, $zero
    /* CAE1C 800DA61C 832C030C */  jal        Font_TextColor__Fi
    /* CAE20 800DA620 03000424 */   addiu     $a0, $zero, 0x3
    /* CAE24 800DA624 2000A427 */  addiu      $a0, $sp, 0x20
    /* CAE28 800DA628 002C1600 */  sll        $a1, $s6, 16
    /* CAE2C 800DA62C 7000A997 */  lhu        $t1, 0x70($sp)
    /* CAE30 800DA630 032C0500 */  sra        $a1, $a1, 16
    /* CAE34 800DA634 00840900 */  sll        $s0, $t1, 16
    /* CAE38 800DA638 03841000 */  sra        $s0, $s0, 16
    /* CAE3C 800DA63C 0D001026 */  addiu      $s0, $s0, 0xD
    /* CAE40 800DA640 A42E030C */  jal        Font_TextXY__FPcii
    /* CAE44 800DA644 21300002 */   addu      $a2, $s0, $zero
    /* CAE48 800DA648 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* CAE4C 800DA64C 48FA6324 */  addiu      $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* CAE50 800DA650 00141700 */  sll        $v0, $s7, 16
    /* CAE54 800DA654 83130200 */  sra        $v0, $v0, 14
    /* CAE58 800DA658 21104300 */  addu       $v0, $v0, $v1
    /* CAE5C 800DA65C 2000A427 */  addiu      $a0, $sp, 0x20
    /* CAE60 800DA660 0000428C */  lw         $v0, 0x0($v0)
    /* CAE64 800DA664 1480053C */  lui        $a1, %hi(D_8013D98C)
    /* CAE68 800DA668 C403468C */  lw         $a2, 0x3C4($v0)
    /* CAE6C 800DA66C 2F91030C */  jal        sprintf
    /* CAE70 800DA670 8CD9A524 */   addiu     $a1, $a1, %lo(D_8013D98C)
    /* CAE74 800DA674 2000A427 */  addiu      $a0, $sp, 0x20
    /* CAE78 800DA678 002C1500 */  sll        $a1, $s5, 16
    /* CAE7C 800DA67C 032C0500 */  sra        $a1, $a1, 16
    /* CAE80 800DA680 0500A524 */  addiu      $a1, $a1, 0x5
    /* CAE84 800DA684 A42E030C */  jal        Font_TextXY__FPcii
    /* CAE88 800DA688 21300002 */   addu      $a2, $s0, $zero
  .L800DA68C:
    /* CAE8C 800DA68C 9600D626 */  addiu      $s6, $s6, 0x96
    /* CAE90 800DA690 9600B526 */  addiu      $s5, $s5, 0x96
    /* CAE94 800DA694 74680308 */  j          .L800DA1D0
    /* CAE98 800DA698 0100F726 */   addiu     $s7, $s7, 0x1
  .L800DA69C:
    /* CAE9C 800DA69C 4800A997 */  lhu        $t1, 0x48($sp)
    /* CAEA0 800DA6A0 00000000 */  nop
    /* CAEA4 800DA6A4 009C0900 */  sll        $s3, $t1, 16
    /* CAEA8 800DA6A8 039C1300 */  sra        $s3, $s3, 16
    /* CAEAC 800DA6AC 6000A997 */  lhu        $t1, 0x60($sp)
    /* CAEB0 800DA6B0 21206002 */  addu       $a0, $s3, $zero
    /* CAEB4 800DA6B4 00940900 */  sll        $s2, $t1, 16
    /* CAEB8 800DA6B8 03941200 */  sra        $s2, $s2, 16
    /* CAEBC 800DA6BC 5000A997 */  lhu        $t1, 0x50($sp)
    /* CAEC0 800DA6C0 21284002 */  addu       $a1, $s2, $zero
    /* CAEC4 800DA6C4 008C0900 */  sll        $s1, $t1, 16
    /* CAEC8 800DA6C8 038C1100 */  sra        $s1, $s1, 16
    /* CAECC 800DA6CC 5800A997 */  lhu        $t1, 0x58($sp)
    /* CAED0 800DA6D0 21302002 */  addu       $a2, $s1, $zero
    /* CAED4 800DA6D4 00840900 */  sll        $s0, $t1, 16
    /* CAED8 800DA6D8 03841000 */  sra        $s0, $s0, 16
    /* CAEDC 800DA6DC 5A66030C */  jal        OptionsBarThing__Fiiii
    /* CAEE0 800DA6E0 21380002 */   addu      $a3, $s0, $zero
    /* CAEE4 800DA6E4 21206002 */  addu       $a0, $s3, $zero
    /* CAEE8 800DA6E8 21284002 */  addu       $a1, $s2, $zero
    /* CAEEC 800DA6EC 21302002 */  addu       $a2, $s1, $zero
    /* CAEF0 800DA6F0 B463030C */  jal        Hud_RenderPauseBox__Fiiii
    /* CAEF4 800DA6F4 21380002 */   addu      $a3, $s0, $zero
    /* CAEF8 800DA6F8 AC00BF8F */  lw         $ra, 0xAC($sp)
    /* CAEFC 800DA6FC A800BE8F */  lw         $fp, 0xA8($sp)
    /* CAF00 800DA700 A400B78F */  lw         $s7, 0xA4($sp)
    /* CAF04 800DA704 A000B68F */  lw         $s6, 0xA0($sp)
    /* CAF08 800DA708 9C00B58F */  lw         $s5, 0x9C($sp)
    /* CAF0C 800DA70C 9800B48F */  lw         $s4, 0x98($sp)
    /* CAF10 800DA710 9400B38F */  lw         $s3, 0x94($sp)
    /* CAF14 800DA714 9000B28F */  lw         $s2, 0x90($sp)
    /* CAF18 800DA718 8C00B18F */  lw         $s1, 0x8C($sp)
    /* CAF1C 800DA71C 8800B08F */  lw         $s0, 0x88($sp)
    /* CAF20 800DA720 0800E003 */  jr         $ra
    /* CAF24 800DA724 B000BD27 */   addiu     $sp, $sp, 0xB0
endlabel RaceStatistics__Fv
