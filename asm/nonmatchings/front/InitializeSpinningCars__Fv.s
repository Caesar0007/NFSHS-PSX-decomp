.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitializeSpinningCars__Fv, 0x17C

glabel InitializeSpinningCars__Fv
    /* 3E050 8004D850 0580023C */  lui        $v0, %hi(D_80052A60)
    /* 3E054 8004D854 602A4290 */  lbu        $v0, %lo(D_80052A60)($v0)
    /* 3E058 8004D858 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3E05C 8004D85C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 3E060 8004D860 2400B5AF */  sw         $s5, 0x24($sp)
    /* 3E064 8004D864 2000B4AF */  sw         $s4, 0x20($sp)
    /* 3E068 8004D868 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 3E06C 8004D86C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 3E070 8004D870 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3E074 8004D874 4C004014 */  bnez       $v0, .L8004D9A8
    /* 3E078 8004D878 1000B0AF */   sw        $s0, 0x10($sp)
    /* 3E07C 8004D87C 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* 3E080 8004D880 01001124 */  addiu      $s1, $zero, 0x1
    /* 3E084 8004D884 2871030C */  jal        Platform_ResetDCTBuffer__Fv
    /* 3E088 8004D888 24D351AC */   sw        $s1, %lo(R3DCar_InMenu)($v0)
    /* 3E08C 8004D88C 8481030C */  jal        Texture_InitMenuTexture__Fv
    /* 3E090 8004D890 1480103C */   lui       $s0, %hi(inFrontEnd)
    /* 3E094 8004D894 C4EF020C */  jal        CarIO_StartUp__Fv
    /* 3E098 8004D898 58D711AE */   sw        $s1, %lo(inFrontEnd)($s0)
    /* 3E09C 8004D89C 45B7020C */  jal        R3DCar_StartUp__Fv
    /* 3E0A0 8004D8A0 21880000 */   addu      $s1, $zero, $zero
    /* 3E0A4 8004D8A4 3EFA020C */  jal        DrawC_ReadeMapData__Fv
    /* 3E0A8 8004D8A8 58D700AE */   sw        $zero, %lo(inFrontEnd)($s0)
    /* 3E0AC 8004D8AC 4E4A000C */  jal        Fe3D_InitShowroom__Fv
    /* 3E0B0 8004D8B0 01001424 */   addiu     $s4, $zero, 0x1
    /* 3E0B4 8004D8B4 1180023C */  lui        $v0, %hi(GameSetup_gCarNames)
    /* 3E0B8 8004D8B8 44305524 */  addiu      $s5, $v0, %lo(GameSetup_gCarNames)
    /* 3E0BC 8004D8BC 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 3E0C0 8004D8C0 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 3E0C4 8004D8C4 D4035224 */  addiu      $s2, $v0, 0x3D4
    /* 3E0C8 8004D8C8 0580033C */  lui        $v1, %hi(gCarObj)
    /* 3E0CC 8004D8CC 682A7324 */  addiu      $s3, $v1, %lo(gCarObj)
    /* 3E0D0 8004D8D0 480040AC */  sw         $zero, 0x48($v0)
  .L8004D8D4:
    /* 3E0D4 8004D8D4 0200222A */  slti       $v0, $s1, 0x2
    /* 3E0D8 8004D8D8 1D004010 */  beqz       $v0, .L8004D950
    /* 3E0DC 8004D8DC 0180043C */   lui       $a0, %hi(D_800127F4)
    /* 3E0E0 8004D8E0 F4278424 */  addiu      $a0, $a0, %lo(D_800127F4)
    /* 3E0E4 8004D8E4 DC080524 */  addiu      $a1, $zero, 0x8DC
    /* 3E0E8 8004D8E8 CF94030C */  jal        reservememadr
    /* 3E0EC 8004D8EC 21300000 */   addu      $a2, $zero, $zero
    /* 3E0F0 8004D8F0 21804000 */  addu       $s0, $v0, $zero
    /* 3E0F4 8004D8F4 21200002 */  addu       $a0, $s0, $zero
    /* 3E0F8 8004D8F8 DC080524 */  addiu      $a1, $zero, 0x8DC
    /* 3E0FC 8004D8FC E8C5030C */  jal        blockclear
    /* 3E100 8004D900 000070AE */   sw        $s0, 0x0($s3)
    /* 3E104 8004D904 40020426 */  addiu      $a0, $s0, 0x240
    /* 3E108 8004D908 880212AE */  sw         $s2, 0x288($s0)
    /* 3E10C 8004D90C 000054AE */  sw         $s4, 0x0($s2)
    /* 3E110 8004D910 8802028E */  lw         $v0, 0x288($s0)
    /* 3E114 8004D914 B4005226 */  addiu      $s2, $s2, 0xB4
    /* 3E118 8004D918 0000428C */  lw         $v0, 0x0($v0)
    /* 3E11C 8004D91C 04007326 */  addiu      $s3, $s3, 0x4
    /* 3E120 8004D920 80280200 */  sll        $a1, $v0, 2
    /* 3E124 8004D924 2128A200 */  addu       $a1, $a1, $v0
    /* 3E128 8004D928 CA96030C */  jal        strcpy
    /* 3E12C 8004D92C 2128B500 */   addu      $a1, $a1, $s5
    /* 3E130 8004D930 21200002 */  addu       $a0, $s0, $zero
    /* 3E134 8004D934 21282002 */  addu       $a1, $s1, $zero
    /* 3E138 8004D938 00012236 */  ori        $v0, $s1, 0x100
    /* 3E13C 8004D93C CBBB020C */  jal        R3DCar_Instantiate3DCar__FP8Car_tObji
    /* 3E140 8004D940 000002AE */   sw        $v0, 0x0($s0)
    /* 3E144 8004D944 01003126 */  addiu      $s1, $s1, 0x1
    /* 3E148 8004D948 35360108 */  j          .L8004D8D4
    /* 3E14C 8004D94C 910014A2 */   sb        $s4, 0x91($s0)
  .L8004D950:
    /* 3E150 8004D950 79B7020C */  jal        R3DCar_PostStartUp__Fv
    /* 3E154 8004D954 00000000 */   nop
    /* 3E158 8004D958 1180043C */  lui        $a0, %hi(gCView)
    /* 3E15C 8004D95C 7C6F8424 */  addiu      $a0, $a0, %lo(gCView)
    /* 3E160 8004D960 8C000524 */  addiu      $a1, $zero, 0x8C
    /* 3E164 8004D964 0580033C */  lui        $v1, %hi(gMenuRotate)
    /* 3E168 8004D968 64126224 */  addiu      $v0, $v1, %lo(gMenuRotate)
    /* 3E16C 8004D96C 040040AC */  sw         $zero, 0x4($v0)
    /* 3E170 8004D970 E8C5030C */  jal        blockclear
    /* 3E174 8004D974 641260AC */   sw        $zero, %lo(gMenuRotate)($v1)
    /* 3E178 8004D978 1480043C */  lui        $a0, %hi(DrawC_gMenuColor)
    /* 3E17C 8004D97C 00D88324 */  addiu      $v1, $a0, %lo(DrawC_gMenuColor)
    /* 3E180 8004D980 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 3E184 8004D984 040062AC */  sw         $v0, 0x4($v1)
    /* 3E188 8004D988 00D882AC */  sw         $v0, %lo(DrawC_gMenuColor)($a0)
    /* 3E18C 8004D98C 1480023C */  lui        $v0, %hi(DrawC_gMenuLights)
    /* 3E190 8004D990 08D840AC */  sw         $zero, %lo(DrawC_gMenuLights)($v0)
    /* 3E194 8004D994 1480023C */  lui        $v0, %hi(DrawC_gMenuLightsDirection)
    /* 3E198 8004D998 0580033C */  lui        $v1, %hi(D_80052A60)
    /* 3E19C 8004D99C 0CD840AC */  sw         $zero, %lo(DrawC_gMenuLightsDirection)($v0)
    /* 3E1A0 8004D9A0 01000224 */  addiu      $v0, $zero, 0x1
    /* 3E1A4 8004D9A4 602A62A0 */  sb         $v0, %lo(D_80052A60)($v1)
  .L8004D9A8:
    /* 3E1A8 8004D9A8 2800BF8F */  lw         $ra, 0x28($sp)
    /* 3E1AC 8004D9AC 2400B58F */  lw         $s5, 0x24($sp)
    /* 3E1B0 8004D9B0 2000B48F */  lw         $s4, 0x20($sp)
    /* 3E1B4 8004D9B4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 3E1B8 8004D9B8 1800B28F */  lw         $s2, 0x18($sp)
    /* 3E1BC 8004D9BC 1400B18F */  lw         $s1, 0x14($sp)
    /* 3E1C0 8004D9C0 1000B08F */  lw         $s0, 0x10($sp)
    /* 3E1C4 8004D9C4 0800E003 */  jr         $ra
    /* 3E1C8 8004D9C8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel InitializeSpinningCars__Fv
