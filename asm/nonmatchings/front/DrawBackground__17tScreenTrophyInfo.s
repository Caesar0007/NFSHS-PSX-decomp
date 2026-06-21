.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__17tScreenTrophyInfo, 0x4A8

glabel DrawBackground__17tScreenTrophyInfo
    /* 31938 80041138 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* 3193C 8004113C 7000B6AF */  sw         $s6, 0x70($sp)
    /* 31940 80041140 21B08000 */  addu       $s6, $a0, $zero
    /* 31944 80041144 7400BFAF */  sw         $ra, 0x74($sp)
    /* 31948 80041148 6C00B5AF */  sw         $s5, 0x6C($sp)
    /* 3194C 8004114C 6800B4AF */  sw         $s4, 0x68($sp)
    /* 31950 80041150 6400B3AF */  sw         $s3, 0x64($sp)
    /* 31954 80041154 6000B2AF */  sw         $s2, 0x60($sp)
    /* 31958 80041158 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* 3195C 8004115C 5800B0AF */  sw         $s0, 0x58($sp)
    /* 31960 80041160 5C00C286 */  lh         $v0, 0x5C($s6)
    /* 31964 80041164 00000000 */  nop
    /* 31968 80041168 C0FF4424 */  addiu      $a0, $v0, -0x40
    /* 3196C 8004116C 02008104 */  bgez       $a0, .L80041178
    /* 31970 80041170 40A00200 */   sll       $s4, $v0, 1
    /* 31974 80041174 21200000 */  addu       $a0, $zero, $zero
  .L80041178:
    /* 31978 80041178 02008106 */  bgez       $s4, .L80041184
    /* 3197C 8004117C 40980400 */   sll       $s3, $a0, 1
    /* 31980 80041180 21A00000 */  addu       $s4, $zero, $zero
  .L80041184:
    /* 31984 80041184 8100822A */  slti       $v0, $s4, 0x81
    /* 31988 80041188 02004014 */  bnez       $v0, .L80041194
    /* 3198C 8004118C 0580023C */   lui       $v0, %hi(screenTrophyRoom)
    /* 31990 80041190 80001424 */  addiu      $s4, $zero, 0x80
  .L80041194:
    /* 31994 80041194 1180033C */  lui        $v1, %hi(D_80114722)
    /* 31998 80041198 1180043C */  lui        $a0, %hi(D_80114AF0)
    /* 3199C 8004119C F04A908C */  lw         $s0, %lo(D_80114AF0)($a0)
    /* 319A0 800411A0 0580043C */  lui        $a0, %hi(kRGBVals)
    /* 319A4 800411A4 6020478C */  lw         $a3, %lo(screenTrophyRoom)($v0)
    /* 319A8 800411A8 C8168424 */  addiu      $a0, $a0, %lo(kRGBVals)
    /* 319AC 800411AC D000E28C */  lw         $v0, 0xD0($a3)
    /* 319B0 800411B0 22476390 */  lbu        $v1, %lo(D_80114722)($v1)
    /* 319B4 800411B4 40100200 */  sll        $v0, $v0, 1
    /* 319B8 800411B8 2138E200 */  addu       $a3, $a3, $v0
    /* 319BC 800411BC 40100300 */  sll        $v0, $v1, 1
    /* 319C0 800411C0 21104300 */  addu       $v0, $v0, $v1
    /* 319C4 800411C4 80100200 */  sll        $v0, $v0, 2
    /* 319C8 800411C8 21100202 */  addu       $v0, $s0, $v0
    /* 319CC 800411CC 0580033C */  lui        $v1, %hi(D_800515D5)
    /* 319D0 800411D0 D5156390 */  lbu        $v1, %lo(D_800515D5)($v1)
    /* 319D4 800411D4 02004690 */  lbu        $a2, 0x2($v0)
    /* 319D8 800411D8 D400E290 */  lbu        $v0, 0xD4($a3)
    /* 319DC 800411DC 80180300 */  sll        $v1, $v1, 2
    /* 319E0 800411E0 21186400 */  addu       $v1, $v1, $a0
    /* 319E4 800411E4 2130C200 */  addu       $a2, $a2, $v0
    /* 319E8 800411E8 80100600 */  sll        $v0, $a2, 2
    /* 319EC 800411EC 21104600 */  addu       $v0, $v0, $a2
    /* 319F0 800411F0 80100200 */  sll        $v0, $v0, 2
    /* 319F4 800411F4 21104600 */  addu       $v0, $v0, $a2
    /* 319F8 800411F8 80100200 */  sll        $v0, $v0, 2
    /* 319FC 800411FC 24004224 */  addiu      $v0, $v0, 0x24
    /* 31A00 80041200 21800202 */  addu       $s0, $s0, $v0
    /* 31A04 80041204 0000648C */  lw         $a0, 0x0($v1)
    /* 31A08 80041208 00001582 */  lb         $s5, 0x0($s0)
    /* 31A0C 8004120C 222E010C */  jal        CalcFadeVal__Fii
    /* 31A10 80041210 21286002 */   addu      $a1, $s3, $zero
    /* 31A14 80041214 AF001124 */  addiu      $s1, $zero, 0xAF
    /* 31A18 80041218 00000482 */  lb         $a0, 0x0($s0)
    /* 31A1C 8004121C 21804000 */  addu       $s0, $v0, $zero
    /* 31A20 80041220 94E4020C */  jal        TextSys_Word__Fi
    /* 31A24 80041224 41038424 */   addiu     $a0, $a0, 0x341
    /* 31A28 80041228 21204000 */  addu       $a0, $v0, $zero
    /* 31A2C 8004122C 1E000524 */  addiu      $a1, $zero, 0x1E
    /* 31A30 80041230 19000624 */  addiu      $a2, $zero, 0x19
    /* 31A34 80041234 21380002 */  addu       $a3, $s0, $zero
    /* 31A38 80041238 03000224 */  addiu      $v0, $zero, 0x3
    /* 31A3C 8004123C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 31A40 80041240 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 31A44 80041244 1400A2AF */   sw        $v0, 0x14($sp)
    /* 31A48 80041248 7A03B026 */  addiu      $s0, $s5, 0x37A
    /* 31A4C 8004124C 94E4020C */  jal        TextSys_Word__Fi
    /* 31A50 80041250 21200002 */   addu      $a0, $s0, $zero
    /* 31A54 80041254 DDA7030C */  jal        strlen
    /* 31A58 80041258 21204000 */   addu      $a0, $v0, $zero
    /* 31A5C 8004125C 1A004010 */  beqz       $v0, .L800412C8
    /* 31A60 80041260 21206002 */   addu      $a0, $s3, $zero
    /* 31A64 80041264 DB030524 */  addiu      $a1, $zero, 0x3DB
    /* 31A68 80041268 8C000624 */  addiu      $a2, $zero, 0x8C
    /* 31A6C 8004126C 21382002 */  addu       $a3, $s1, $zero
    /* 31A70 80041270 01000224 */  addiu      $v0, $zero, 0x1
    /* 31A74 80041274 1000A2AF */  sw         $v0, 0x10($sp)
    /* 31A78 80041278 02000224 */  addiu      $v0, $zero, 0x2
    /* 31A7C 8004127C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 31A80 80041280 04000224 */  addiu      $v0, $zero, 0x4
    /* 31A84 80041284 7584000C */  jal        FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
    /* 31A88 80041288 1800A2AF */   sw        $v0, 0x18($sp)
    /* 31A8C 8004128C 94E4020C */  jal        TextSys_Word__Fi
    /* 31A90 80041290 21200002 */   addu      $a0, $s0, $zero
    /* 31A94 80041294 5000043C */  lui        $a0, (0x505050 >> 16)
    /* 31A98 80041298 50508434 */  ori        $a0, $a0, (0x505050 & 0xFFFF)
    /* 31A9C 8004129C 21286002 */  addu       $a1, $s3, $zero
    /* 31AA0 800412A0 222E010C */  jal        CalcFadeVal__Fii
    /* 31AA4 800412A4 21804000 */   addu      $s0, $v0, $zero
    /* 31AA8 800412A8 21200002 */  addu       $a0, $s0, $zero
    /* 31AAC 800412AC 91000524 */  addiu      $a1, $zero, 0x91
    /* 31AB0 800412B0 21302002 */  addu       $a2, $s1, $zero
    /* 31AB4 800412B4 21384000 */  addu       $a3, $v0, $zero
    /* 31AB8 800412B8 1000A0AF */  sw         $zero, 0x10($sp)
    /* 31ABC 800412BC 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 31AC0 800412C0 1400A0AF */   sw        $zero, 0x14($sp)
    /* 31AC4 800412C4 B7001124 */  addiu      $s1, $zero, 0xB7
  .L800412C8:
    /* 31AC8 800412C8 A003B226 */  addiu      $s2, $s5, 0x3A0
    /* 31ACC 800412CC 94E4020C */  jal        TextSys_Word__Fi
    /* 31AD0 800412D0 21204002 */   addu      $a0, $s2, $zero
    /* 31AD4 800412D4 DDA7030C */  jal        strlen
    /* 31AD8 800412D8 21204000 */   addu      $a0, $v0, $zero
    /* 31ADC 800412DC 24004010 */  beqz       $v0, .L80041370
    /* 31AE0 800412E0 21206002 */   addu      $a0, $s3, $zero
    /* 31AE4 800412E4 DD030524 */  addiu      $a1, $zero, 0x3DD
    /* 31AE8 800412E8 8C000624 */  addiu      $a2, $zero, 0x8C
    /* 31AEC 800412EC 003C1100 */  sll        $a3, $s1, 16
    /* 31AF0 800412F0 033C0700 */  sra        $a3, $a3, 16
    /* 31AF4 800412F4 01000224 */  addiu      $v0, $zero, 0x1
    /* 31AF8 800412F8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 31AFC 800412FC 02000224 */  addiu      $v0, $zero, 0x2
    /* 31B00 80041300 1400A2AF */  sw         $v0, 0x14($sp)
    /* 31B04 80041304 04000224 */  addiu      $v0, $zero, 0x4
    /* 31B08 80041308 7584000C */  jal        FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
    /* 31B0C 8004130C 1800A2AF */   sw        $v0, 0x18($sp)
    /* 31B10 80041310 21204002 */  addu       $a0, $s2, $zero
    /* 31B14 80041314 91000224 */  addiu      $v0, $zero, 0x91
    /* 31B18 80041318 2000A2A7 */  sh         $v0, 0x20($sp)
    /* 31B1C 8004131C 5B010224 */  addiu      $v0, $zero, 0x15B
    /* 31B20 80041320 2400A2A7 */  sh         $v0, 0x24($sp)
    /* 31B24 80041324 64000224 */  addiu      $v0, $zero, 0x64
    /* 31B28 80041328 2200B1A7 */  sh         $s1, 0x22($sp)
    /* 31B2C 8004132C 94E4020C */  jal        TextSys_Word__Fi
    /* 31B30 80041330 2600A2A7 */   sh        $v0, 0x26($sp)
    /* 31B34 80041334 5000043C */  lui        $a0, (0x505050 >> 16)
    /* 31B38 80041338 50508434 */  ori        $a0, $a0, (0x505050 & 0xFFFF)
    /* 31B3C 8004133C 21286002 */  addu       $a1, $s3, $zero
    /* 31B40 80041340 222E010C */  jal        CalcFadeVal__Fii
    /* 31B44 80041344 21804000 */   addu      $s0, $v0, $zero
    /* 31B48 80041348 21200002 */  addu       $a0, $s0, $zero
    /* 31B4C 8004134C 2000A527 */  addiu      $a1, $sp, 0x20
    /* 31B50 80041350 C685000C */  jal        FETextRender_WordWrapTextRGB__FPcR4RECTi
    /* 31B54 80041354 21304000 */   addu      $a2, $v0, $zero
    /* 31B58 80041358 94E4020C */  jal        TextSys_Word__Fi
    /* 31B5C 8004135C 21204002 */   addu      $a0, $s2, $zero
    /* 31B60 80041360 5B010424 */  addiu      $a0, $zero, 0x15B
    /* 31B64 80041364 3286000C */  jal        FETextRender_WordWrapHeight__FsPc
    /* 31B68 80041368 21284000 */   addu      $a1, $v0, $zero
    /* 31B6C 8004136C 21882202 */  addu       $s1, $s1, $v0
  .L80041370:
    /* 31B70 80041370 8D03B226 */  addiu      $s2, $s5, 0x38D
    /* 31B74 80041374 94E4020C */  jal        TextSys_Word__Fi
    /* 31B78 80041378 21204002 */   addu      $a0, $s2, $zero
    /* 31B7C 8004137C DDA7030C */  jal        strlen
    /* 31B80 80041380 21204000 */   addu      $a0, $v0, $zero
    /* 31B84 80041384 23004010 */  beqz       $v0, .L80041414
    /* 31B88 80041388 21206002 */   addu      $a0, $s3, $zero
    /* 31B8C 8004138C DC030524 */  addiu      $a1, $zero, 0x3DC
    /* 31B90 80041390 8C000624 */  addiu      $a2, $zero, 0x8C
    /* 31B94 80041394 003C1100 */  sll        $a3, $s1, 16
    /* 31B98 80041398 033C0700 */  sra        $a3, $a3, 16
    /* 31B9C 8004139C 01000224 */  addiu      $v0, $zero, 0x1
    /* 31BA0 800413A0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 31BA4 800413A4 02000224 */  addiu      $v0, $zero, 0x2
    /* 31BA8 800413A8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 31BAC 800413AC 04000224 */  addiu      $v0, $zero, 0x4
    /* 31BB0 800413B0 7584000C */  jal        FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
    /* 31BB4 800413B4 1800A2AF */   sw        $v0, 0x18($sp)
    /* 31BB8 800413B8 21204002 */  addu       $a0, $s2, $zero
    /* 31BBC 800413BC 91000224 */  addiu      $v0, $zero, 0x91
    /* 31BC0 800413C0 2000A2A7 */  sh         $v0, 0x20($sp)
    /* 31BC4 800413C4 5B010224 */  addiu      $v0, $zero, 0x15B
    /* 31BC8 800413C8 2400A2A7 */  sh         $v0, 0x24($sp)
    /* 31BCC 800413CC 64000224 */  addiu      $v0, $zero, 0x64
    /* 31BD0 800413D0 2200B1A7 */  sh         $s1, 0x22($sp)
    /* 31BD4 800413D4 94E4020C */  jal        TextSys_Word__Fi
    /* 31BD8 800413D8 2600A2A7 */   sh        $v0, 0x26($sp)
    /* 31BDC 800413DC 5000043C */  lui        $a0, (0x505050 >> 16)
    /* 31BE0 800413E0 50508434 */  ori        $a0, $a0, (0x505050 & 0xFFFF)
    /* 31BE4 800413E4 21286002 */  addu       $a1, $s3, $zero
    /* 31BE8 800413E8 222E010C */  jal        CalcFadeVal__Fii
    /* 31BEC 800413EC 21804000 */   addu      $s0, $v0, $zero
    /* 31BF0 800413F0 21200002 */  addu       $a0, $s0, $zero
    /* 31BF4 800413F4 2000A527 */  addiu      $a1, $sp, 0x20
    /* 31BF8 800413F8 C685000C */  jal        FETextRender_WordWrapTextRGB__FPcR4RECTi
    /* 31BFC 800413FC 21304000 */   addu      $a2, $v0, $zero
    /* 31C00 80041400 94E4020C */  jal        TextSys_Word__Fi
    /* 31C04 80041404 21204002 */   addu      $a0, $s2, $zero
    /* 31C08 80041408 5B010424 */  addiu      $a0, $zero, 0x15B
    /* 31C0C 8004140C 3286000C */  jal        FETextRender_WordWrapHeight__FsPc
    /* 31C10 80041410 21284000 */   addu      $a1, $v0, $zero
  .L80041414:
    /* 31C14 80041414 2120C002 */  addu       $a0, $s6, $zero
    /* 31C18 80041418 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 31C1C 8004141C 2800C526 */   addiu     $a1, $s6, 0x28
    /* 31C20 80041420 2C00C28E */  lw         $v0, 0x2C($s6)
    /* 31C24 80041424 00000000 */  nop
    /* 31C28 80041428 04004010 */  beqz       $v0, .L8004143C
    /* 31C2C 8004142C 00000000 */   nop
    /* 31C30 80041430 2120C002 */  addu       $a0, $s6, $zero
    /* 31C34 80041434 F497000C */  jal        UploadSwapShapes__7tScreeni
    /* 31C38 80041438 20000524 */   addiu     $a1, $zero, 0x20
  .L8004143C:
    /* 31C3C 8004143C 6703A426 */  addiu      $a0, $s5, 0x367
    /* 31C40 80041440 23000224 */  addiu      $v0, $zero, 0x23
    /* 31C44 80041444 2000A2A7 */  sh         $v0, 0x20($sp)
    /* 31C48 80041448 2D000224 */  addiu      $v0, $zero, 0x2D
    /* 31C4C 8004144C 2200A2A7 */  sh         $v0, 0x22($sp)
    /* 31C50 80041450 C4010224 */  addiu      $v0, $zero, 0x1C4
    /* 31C54 80041454 2400A2A7 */  sh         $v0, 0x24($sp)
    /* 31C58 80041458 64000224 */  addiu      $v0, $zero, 0x64
    /* 31C5C 8004145C 94E4020C */  jal        TextSys_Word__Fi
    /* 31C60 80041460 2600A2A7 */   sh        $v0, 0x26($sp)
    /* 31C64 80041464 5000043C */  lui        $a0, (0x505050 >> 16)
    /* 31C68 80041468 50508434 */  ori        $a0, $a0, (0x505050 & 0xFFFF)
    /* 31C6C 8004146C 21286002 */  addu       $a1, $s3, $zero
    /* 31C70 80041470 222E010C */  jal        CalcFadeVal__Fii
    /* 31C74 80041474 21804000 */   addu      $s0, $v0, $zero
    /* 31C78 80041478 21200002 */  addu       $a0, $s0, $zero
    /* 31C7C 8004147C 2000A527 */  addiu      $a1, $sp, 0x20
    /* 31C80 80041480 21304000 */  addu       $a2, $v0, $zero
    /* 31C84 80041484 03000724 */  addiu      $a3, $zero, 0x3
    /* 31C88 80041488 1000A0AF */  sw         $zero, 0x10($sp)
    /* 31C8C 8004148C A984000C */  jal        FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
    /* 31C90 80041490 1400A0AF */   sw        $zero, 0x14($sp)
    /* 31C94 80041494 AA2A043C */  lui        $a0, (0x2AAAAAAB >> 16)
    /* 31C98 80041498 1480023C */  lui        $v0, %hi(ticks)
    /* 31C9C 8004149C ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 31CA0 800414A0 ABAA8434 */  ori        $a0, $a0, (0x2AAAAAAB & 0xFFFF)
    /* 31CA4 800414A4 18006400 */  mult       $v1, $a0
    /* 31CA8 800414A8 2800C28E */  lw         $v0, 0x28($s6)
    /* 31CAC 800414AC C31F0300 */  sra        $v1, $v1, 31
    /* 31CB0 800414B0 3C00A2AF */  sw         $v0, 0x3C($sp)
    /* 31CB4 800414B4 10400000 */  mfhi       $t0
    /* 31CB8 800414B8 43100800 */  sra        $v0, $t0, 1
    /* 31CBC 800414BC 23104300 */  subu       $v0, $v0, $v1
    /* 31CC0 800414C0 02004104 */  bgez       $v0, .L800414CC
    /* 31CC4 800414C4 21204000 */   addu      $a0, $v0, $zero
    /* 31CC8 800414C8 1F004424 */  addiu      $a0, $v0, 0x1F
  .L800414CC:
    /* 31CCC 800414CC 43210400 */  sra        $a0, $a0, 5
    /* 31CD0 800414D0 40210400 */  sll        $a0, $a0, 5
    /* 31CD4 800414D4 23204400 */  subu       $a0, $v0, $a0
    /* 31CD8 800414D8 00060524 */  addiu      $a1, $zero, 0x600
    /* 31CDC 800414DC 46000624 */  addiu      $a2, $zero, 0x46
    /* 31CE0 800414E0 FBFF0724 */  addiu      $a3, $zero, -0x5
    /* 31CE4 800414E4 2800A227 */  addiu      $v0, $sp, 0x28
    /* 31CE8 800414E8 1000B3AF */  sw         $s3, 0x10($sp)
    /* 31CEC 800414EC 1400A0AF */  sw         $zero, 0x14($sp)
    /* 31CF0 800414F0 A23A010C */  jal        ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 31CF4 800414F4 1800A2AF */   sw        $v0, 0x18($sp)
    /* 31CF8 800414F8 01001024 */  addiu      $s0, $zero, 0x1
    /* 31CFC 800414FC 5555123C */  lui        $s2, (0x55555556 >> 16)
    /* 31D00 80041500 56555236 */  ori        $s2, $s2, (0x55555556 & 0xFFFF)
    /* 31D04 80041504 6400C28E */  lw         $v0, 0x64($s6)
    /* 31D08 80041508 4000B127 */  addiu      $s1, $sp, 0x40
    /* 31D0C 8004150C 4400A2AF */  sw         $v0, 0x44($sp)
    /* 31D10 80041510 18001202 */  mult       $s0, $s2
  .L80041514:
    /* 31D14 80041514 C31F1000 */  sra        $v1, $s0, 31
    /* 31D18 80041518 10400000 */  mfhi       $t0
    /* 31D1C 8004151C 23180301 */  subu       $v1, $t0, $v1
    /* 31D20 80041520 40100300 */  sll        $v0, $v1, 1
    /* 31D24 80041524 21104300 */  addu       $v0, $v0, $v1
    /* 31D28 80041528 08000212 */  beq        $s0, $v0, .L8004154C
    /* 31D2C 8004152C 21200000 */   addu      $a0, $zero, $zero
    /* 31D30 80041530 10040524 */  addiu      $a1, $zero, 0x410
    /* 31D34 80041534 40301000 */  sll        $a2, $s0, 1
    /* 31D38 80041538 21388000 */  addu       $a3, $a0, $zero
    /* 31D3C 8004153C 1000B4AF */  sw         $s4, 0x10($sp)
    /* 31D40 80041540 1400A0AF */  sw         $zero, 0x14($sp)
    /* 31D44 80041544 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 31D48 80041548 1800B1AF */   sw        $s1, 0x18($sp)
  .L8004154C:
    /* 31D4C 8004154C 01001026 */  addiu      $s0, $s0, 0x1
    /* 31D50 80041550 1E00022A */  slti       $v0, $s0, 0x1E
    /* 31D54 80041554 EFFF4014 */  bnez       $v0, .L80041514
    /* 31D58 80041558 18001202 */   mult      $s0, $s2
    /* 31D5C 8004155C 22001024 */  addiu      $s0, $zero, 0x22
    /* 31D60 80041560 5555123C */  lui        $s2, (0x55555556 >> 16)
    /* 31D64 80041564 56555236 */  ori        $s2, $s2, (0x55555556 & 0xFFFF)
    /* 31D68 80041568 4000B127 */  addiu      $s1, $sp, 0x40
    /* 31D6C 8004156C 18001202 */  mult       $s0, $s2
  .L80041570:
    /* 31D70 80041570 C31F1000 */  sra        $v1, $s0, 31
    /* 31D74 80041574 10400000 */  mfhi       $t0
    /* 31D78 80041578 23180301 */  subu       $v1, $t0, $v1
    /* 31D7C 8004157C 40100300 */  sll        $v0, $v1, 1
    /* 31D80 80041580 21104300 */  addu       $v0, $v0, $v1
    /* 31D84 80041584 08000212 */  beq        $s0, $v0, .L800415A8
    /* 31D88 80041588 21200000 */   addu      $a0, $zero, $zero
    /* 31D8C 8004158C 10040524 */  addiu      $a1, $zero, 0x410
    /* 31D90 80041590 40301000 */  sll        $a2, $s0, 1
    /* 31D94 80041594 21388000 */  addu       $a3, $a0, $zero
    /* 31D98 80041598 1000B4AF */  sw         $s4, 0x10($sp)
    /* 31D9C 8004159C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 31DA0 800415A0 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 31DA4 800415A4 1800B1AF */   sw        $s1, 0x18($sp)
  .L800415A8:
    /* 31DA8 800415A8 01001026 */  addiu      $s0, $s0, 0x1
    /* 31DAC 800415AC 3F00022A */  slti       $v0, $s0, 0x3F
    /* 31DB0 800415B0 EFFF4014 */  bnez       $v0, .L80041570
    /* 31DB4 800415B4 18001202 */   mult      $s0, $s2
    /* 31DB8 800415B8 7400BF8F */  lw         $ra, 0x74($sp)
    /* 31DBC 800415BC 7000B68F */  lw         $s6, 0x70($sp)
    /* 31DC0 800415C0 6C00B58F */  lw         $s5, 0x6C($sp)
    /* 31DC4 800415C4 6800B48F */  lw         $s4, 0x68($sp)
    /* 31DC8 800415C8 6400B38F */  lw         $s3, 0x64($sp)
    /* 31DCC 800415CC 6000B28F */  lw         $s2, 0x60($sp)
    /* 31DD0 800415D0 5C00B18F */  lw         $s1, 0x5C($sp)
    /* 31DD4 800415D4 5800B08F */  lw         $s0, 0x58($sp)
    /* 31DD8 800415D8 0800E003 */  jr         $ra
    /* 31DDC 800415DC 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel DrawBackground__17tScreenTrophyInfo
