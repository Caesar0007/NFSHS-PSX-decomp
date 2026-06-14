.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_Init__Fv, 0x9C0

glabel Hud_Init__Fv
    /* C382C 800D302C 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* C3830 800D3030 A000083C */  lui        $t0, (0xA0A0A0 >> 16)
    /* C3834 800D3034 A0A00835 */  ori        $t0, $t0, (0xA0A0A0 & 0xFFFF)
    /* C3838 800D3038 6000BEAF */  sw         $fp, 0x60($sp)
    /* C383C 800D303C 21F00000 */  addu       $fp, $zero, $zero
    /* C3840 800D3040 1480023C */  lui        $v0, %hi(D_8013E390)
    /* C3844 800D3044 5800B6AF */  sw         $s6, 0x58($sp)
    /* C3848 800D3048 90E35624 */  addiu      $s6, $v0, %lo(D_8013E390)
    /* C384C 800D304C 1480023C */  lui        $v0, %hi(D_8013E3F0)
    /* C3850 800D3050 5400B5AF */  sw         $s5, 0x54($sp)
    /* C3854 800D3054 F0E35524 */  addiu      $s5, $v0, %lo(D_8013E3F0)
    /* C3858 800D3058 5000B4AF */  sw         $s4, 0x50($sp)
    /* C385C 800D305C 21A0C003 */  addu       $s4, $fp, $zero
    /* C3860 800D3060 6400BFAF */  sw         $ra, 0x64($sp)
    /* C3864 800D3064 5C00B7AF */  sw         $s7, 0x5C($sp)
    /* C3868 800D3068 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* C386C 800D306C 4800B2AF */  sw         $s2, 0x48($sp)
    /* C3870 800D3070 4400B1AF */  sw         $s1, 0x44($sp)
    /* C3874 800D3074 4000B0AF */  sw         $s0, 0x40($sp)
    /* C3878 800D3078 2800A8AF */  sw         $t0, 0x28($sp)
  .L800D307C:
    /* C387C 800D307C 21900000 */  addu       $s2, $zero, $zero
    /* C3880 800D3080 21988002 */  addu       $s3, $s4, $zero
    /* C3884 800D3084 2188A002 */  addu       $s1, $s5, $zero
    /* C3888 800D3088 2180C002 */  addu       $s0, $s6, $zero
  .L800D308C:
    /* C388C 800D308C 21207002 */  addu       $a0, $s3, $s0
    /* C3890 800D3090 21280000 */  addu       $a1, $zero, $zero
    /* C3894 800D3094 2130A000 */  addu       $a2, $a1, $zero
    /* C3898 800D3098 02000724 */  addiu      $a3, $zero, 0x2
    /* C389C 800D309C EFB8030C */  jal        SetDrawMode
    /* C38A0 800D30A0 1000A0AF */   sw        $zero, 0x10($sp)
    /* C38A4 800D30A4 21207102 */  addu       $a0, $s3, $s1
    /* C38A8 800D30A8 21280000 */  addu       $a1, $zero, $zero
    /* C38AC 800D30AC 2130A000 */  addu       $a2, $a1, $zero
    /* C38B0 800D30B0 03000724 */  addiu      $a3, $zero, 0x3
    /* C38B4 800D30B4 EFB8030C */  jal        SetDrawMode
    /* C38B8 800D30B8 1000A0AF */   sw        $zero, 0x10($sp)
    /* C38BC 800D30BC 0C003126 */  addiu      $s1, $s1, 0xC
    /* C38C0 800D30C0 01005226 */  addiu      $s2, $s2, 0x1
    /* C38C4 800D30C4 0400422A */  slti       $v0, $s2, 0x4
    /* C38C8 800D30C8 F0FF4014 */  bnez       $v0, .L800D308C
    /* C38CC 800D30CC 0C001026 */   addiu     $s0, $s0, 0xC
    /* C38D0 800D30D0 0100DE27 */  addiu      $fp, $fp, 0x1
    /* C38D4 800D30D4 0200C22B */  slti       $v0, $fp, 0x2
    /* C38D8 800D30D8 E8FF4014 */  bnez       $v0, .L800D307C
    /* C38DC 800D30DC 30009426 */   addiu     $s4, $s4, 0x30
    /* C38E0 800D30E0 21F00000 */  addu       $fp, $zero, $zero
    /* C38E4 800D30E4 8000093C */  lui        $t1, (0x808080 >> 16)
    /* C38E8 800D30E8 80802935 */  ori        $t1, $t1, (0x808080 & 0xFFFF)
    /* C38EC 800D30EC 7000083C */  lui        $t0, (0x707070 >> 16)
    /* C38F0 800D30F0 70700835 */  ori        $t0, $t0, (0x707070 & 0xFFFF)
    /* C38F4 800D30F4 3000A9AF */  sw         $t1, 0x30($sp)
    /* C38F8 800D30F8 1180093C */  lui        $t1, %hi(GameSetup_gData)
    /* C38FC 800D30FC EC312925 */  addiu      $t1, $t1, %lo(GameSetup_gData)
    /* C3900 800D3100 3400A8AF */  sw         $t0, 0x34($sp)
    /* C3904 800D3104 3800A0AF */  sw         $zero, 0x38($sp)
    /* C3908 800D3108 3C00A9AF */  sw         $t1, 0x3C($sp)
  .L800D310C:
    /* C390C 800D310C 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
    /* C3910 800D3110 3027428C */  lw         $v0, %lo(DashHUD_gInfo)($v0)
    /* C3914 800D3114 00000000 */  nop
    /* C3918 800D3118 2A105E00 */  slt        $v0, $v0, $fp
    /* C391C 800D311C E5014014 */  bnez       $v0, .L800D38B4
    /* C3920 800D3120 8000023C */   lui       $v0, (0x808080 >> 16)
    /* C3924 800D3124 0400C013 */  beqz       $fp, .L800D3138
    /* C3928 800D3128 1480023C */   lui       $v0, %hi(D_8013E450)
    /* C392C 800D312C C018958F */  lw         $s5, %gp_rel(D_8013DE0C)($gp)
    /* C3930 800D3130 504C0308 */  j          .L800D3140
    /* C3934 800D3134 50E44224 */   addiu     $v0, $v0, %lo(D_8013E450)
  .L800D3138:
    /* C3938 800D3138 BC18958F */  lw         $s5, %gp_rel(D_8013DE08)($gp)
    /* C393C 800D313C 50E44224 */  addiu      $v0, $v0, %lo(D_8013E450)
  .L800D3140:
    /* C3940 800D3140 0400C013 */  beqz       $fp, .L800D3154
    /* C3944 800D3144 2C00A2AF */   sw        $v0, 0x2C($sp)
    /* C3948 800D3148 21404000 */  addu       $t0, $v0, $zero
    /* C394C 800D314C A8000825 */  addiu      $t0, $t0, 0xA8
    /* C3950 800D3150 2C00A8AF */  sw         $t0, 0x2C($sp)
  .L800D3154:
    /* C3954 800D3154 1480023C */  lui        $v0, %hi(D_8013E730)
    /* C3958 800D3158 0200C013 */  beqz       $fp, .L800D3164
    /* C395C 800D315C 30E75624 */   addiu     $s6, $v0, %lo(D_8013E730)
    /* C3960 800D3160 9000D626 */  addiu      $s6, $s6, 0x90
  .L800D3164:
    /* C3964 800D3164 0200C013 */  beqz       $fp, .L800D3170
    /* C3968 800D3168 21B80000 */   addu      $s7, $zero, $zero
    /* C396C 800D316C F1FF1724 */  addiu      $s7, $zero, -0xF
  .L800D3170:
    /* C3970 800D3170 3C00A98F */  lw         $t1, 0x3C($sp)
    /* C3974 800D3174 00000000 */  nop
    /* C3978 800D3178 5804228D */  lw         $v0, 0x458($t1)
    /* C397C 800D317C 5C04238D */  lw         $v1, 0x45C($t1)
    /* C3980 800D3180 0100422C */  sltiu      $v0, $v0, 0x1
    /* C3984 800D3184 02006014 */  bnez       $v1, .L800D3190
    /* C3988 800D3188 00910200 */   sll       $s2, $v0, 4
    /* C398C 800D318C 10005226 */  addiu      $s2, $s2, 0x10
  .L800D3190:
    /* C3990 800D3190 2120A002 */  addu       $a0, $s5, $zero
    /* C3994 800D3194 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3998 800D3198 68000524 */  addiu      $a1, $zero, 0x68
    /* C399C 800D319C 00004684 */  lh         $a2, 0x0($v0)
    /* C39A0 800D31A0 02004784 */  lh         $a3, 0x2($v0)
    /* C39A4 800D31A4 BEBE0234 */  ori        $v0, $zero, 0xBEBE
    /* C39A8 800D31A8 1000A2AF */  sw         $v0, 0x10($sp)
    /* C39AC 800D31AC 1400A0AF */  sw         $zero, 0x14($sp)
    /* C39B0 800D31B0 2138F700 */  addu       $a3, $a3, $s7
    /* C39B4 800D31B4 E647030C */  jal        Hud_BuildSprite__FP4SPRTiiiUli
    /* C39B8 800D31B8 2338F200 */   subu      $a3, $a3, $s2
    /* C39BC 800D31BC 1400A426 */  addiu      $a0, $s5, 0x14
    /* C39C0 800D31C0 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C39C4 800D31C4 3000A88F */  lw         $t0, 0x30($sp)
    /* C39C8 800D31C8 06004784 */  lh         $a3, 0x6($v0)
    /* C39CC 800D31CC 04004684 */  lh         $a2, 0x4($v0)
    /* C39D0 800D31D0 80000524 */  addiu      $a1, $zero, 0x80
    /* C39D4 800D31D4 C81888AF */  sw         $t0, %gp_rel(D_8013DE14)($gp)
    /* C39D8 800D31D8 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C39DC 800D31DC 2138F700 */   addu      $a3, $a3, $s7
    /* C39E0 800D31E0 81000524 */  addiu      $a1, $zero, 0x81
    /* C39E4 800D31E4 0200C013 */  beqz       $fp, .L800D31F0
    /* C39E8 800D31E8 2800A426 */   addiu     $a0, $s5, 0x28
    /* C39EC 800D31EC 83000524 */  addiu      $a1, $zero, 0x83
  .L800D31F0:
    /* C39F0 800D31F0 21300000 */  addu       $a2, $zero, $zero
    /* C39F4 800D31F4 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C39F8 800D31F8 2138C000 */   addu      $a3, $a2, $zero
    /* C39FC 800D31FC 1C00023C */  lui        $v0, (0x1C001C >> 16)
    /* C3A00 800D3200 1C004234 */  ori        $v0, $v0, (0x1C001C & 0xFFFF)
    /* C3A04 800D3204 1180093C */  lui        $t1, %hi(HudPmx_gShapes)
    /* C3A08 800D3208 980C2925 */  addiu      $t1, $t1, %lo(HudPmx_gShapes)
    /* C3A0C 800D320C 3800A2AE */  sw         $v0, 0x38($s5)
    /* C3A10 800D3210 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C3A14 800D3214 6C083485 */  lh         $s4, 0x86C($t1)
    /* C3A18 800D3218 02004010 */  beqz       $v0, .L800D3224
    /* C3A1C 800D321C 46001324 */   addiu     $s3, $zero, 0x46
    /* C3A20 800D3220 2E001324 */  addiu      $s3, $zero, 0x2E
  .L800D3224:
    /* C3A24 800D3224 5000A426 */  addiu      $a0, $s5, 0x50
    /* C3A28 800D3228 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3A2C 800D322C 69000524 */  addiu      $a1, $zero, 0x69
    /* C3A30 800D3230 0A004384 */  lh         $v1, 0xA($v0)
    /* C3A34 800D3234 08005084 */  lh         $s0, 0x8($v0)
    /* C3A38 800D3238 21887700 */  addu       $s1, $v1, $s7
    /* C3A3C 800D323C 21300002 */  addu       $a2, $s0, $zero
    /* C3A40 800D3240 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3A44 800D3244 21382002 */   addu      $a3, $s1, $zero
    /* C3A48 800D3248 21801402 */  addu       $s0, $s0, $s4
    /* C3A4C 800D324C 2120C002 */  addu       $a0, $s6, $zero
    /* C3A50 800D3250 01000524 */  addiu      $a1, $zero, 0x1
    /* C3A54 800D3254 21300002 */  addu       $a2, $s0, $zero
    /* C3A58 800D3258 21382002 */  addu       $a3, $s1, $zero
    /* C3A5C 800D325C 3400A98F */  lw         $t1, 0x34($sp)
    /* C3A60 800D3260 0A000824 */  addiu      $t0, $zero, 0xA
    /* C3A64 800D3264 1000B3AF */  sw         $s3, 0x10($sp)
    /* C3A68 800D3268 1400A8AF */  sw         $t0, 0x14($sp)
    /* C3A6C 800D326C 1800A0AF */  sw         $zero, 0x18($sp)
    /* C3A70 800D3270 2000A0AF */  sw         $zero, 0x20($sp)
    /* C3A74 800D3274 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* C3A78 800D3278 B649030C */  jal        Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl
    /* C3A7C 800D327C 2400A9AF */   sw        $t1, 0x24($sp)
    /* C3A80 800D3280 21801302 */  addu       $s0, $s0, $s3
    /* C3A84 800D3284 6400A426 */  addiu      $a0, $s5, 0x64
    /* C3A88 800D3288 7D000524 */  addiu      $a1, $zero, 0x7D
    /* C3A8C 800D328C 21300002 */  addu       $a2, $s0, $zero
    /* C3A90 800D3290 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3A94 800D3294 21382002 */   addu      $a3, $s1, $zero
    /* C3A98 800D3298 01000524 */  addiu      $a1, $zero, 0x1
    /* C3A9C 800D329C 21300002 */  addu       $a2, $s0, $zero
    /* C3AA0 800D32A0 07002726 */  addiu      $a3, $s1, 0x7
    /* C3AA4 800D32A4 2C00A48F */  lw         $a0, 0x2C($sp)
    /* C3AA8 800D32A8 07000824 */  addiu      $t0, $zero, 0x7
    /* C3AAC 800D32AC 1000A8AF */  sw         $t0, 0x10($sp)
    /* C3AB0 800D32B0 3400A88F */  lw         $t0, 0x34($sp)
    /* C3AB4 800D32B4 03000924 */  addiu      $t1, $zero, 0x3
    /* C3AB8 800D32B8 1400A9AF */  sw         $t1, 0x14($sp)
    /* C3ABC 800D32BC 8D49030C */  jal        Hud_BuildF4__FP7POLY_F4iiiiiUl
    /* C3AC0 800D32C0 1800A8AF */   sw        $t0, 0x18($sp)
    /* C3AC4 800D32C4 1D001324 */  addiu      $s3, $zero, 0x1D
    /* C3AC8 800D32C8 7800A426 */  addiu      $a0, $s5, 0x78
    /* C3ACC 800D32CC 6B000524 */  addiu      $a1, $zero, 0x6B
    /* C3AD0 800D32D0 1180083C */  lui        $t0, %hi(HudPmx_gShapes)
    /* C3AD4 800D32D4 980C0825 */  addiu      $t0, $t0, %lo(HudPmx_gShapes)
    /* C3AD8 800D32D8 3C00A98F */  lw         $t1, 0x3C($sp)
    /* C3ADC 800D32DC 6C081485 */  lh         $s4, 0x86C($t0)
    /* C3AE0 800D32E0 B818838F */  lw         $v1, %gp_rel(D_8013DE04)($gp)
    /* C3AE4 800D32E4 5804228D */  lw         $v0, 0x458($t1)
    /* C3AE8 800D32E8 0C007084 */  lh         $s0, 0xC($v1)
    /* C3AEC 800D32EC 0100422C */  sltiu      $v0, $v0, 0x1
    /* C3AF0 800D32F0 00910200 */  sll        $s2, $v0, 4
    /* C3AF4 800D32F4 0E006284 */  lh         $v0, 0xE($v1)
    /* C3AF8 800D32F8 21300002 */  addu       $a2, $s0, $zero
    /* C3AFC 800D32FC 21105700 */  addu       $v0, $v0, $s7
    /* C3B00 800D3300 23885200 */  subu       $s1, $v0, $s2
    /* C3B04 800D3304 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3B08 800D3308 21382002 */   addu      $a3, $s1, $zero
    /* C3B0C 800D330C 21801402 */  addu       $s0, $s0, $s4
    /* C3B10 800D3310 2400C426 */  addiu      $a0, $s6, 0x24
    /* C3B14 800D3314 01000524 */  addiu      $a1, $zero, 0x1
    /* C3B18 800D3318 21300002 */  addu       $a2, $s0, $zero
    /* C3B1C 800D331C 21382002 */  addu       $a3, $s1, $zero
    /* C3B20 800D3320 3400A88F */  lw         $t0, 0x34($sp)
    /* C3B24 800D3324 0A000924 */  addiu      $t1, $zero, 0xA
    /* C3B28 800D3328 1000B3AF */  sw         $s3, 0x10($sp)
    /* C3B2C 800D332C 1400A9AF */  sw         $t1, 0x14($sp)
    /* C3B30 800D3330 1800A0AF */  sw         $zero, 0x18($sp)
    /* C3B34 800D3334 2000A0AF */  sw         $zero, 0x20($sp)
    /* C3B38 800D3338 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* C3B3C 800D333C B649030C */  jal        Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl
    /* C3B40 800D3340 2400A8AF */   sw        $t0, 0x24($sp)
    /* C3B44 800D3344 21801302 */  addu       $s0, $s0, $s3
    /* C3B48 800D3348 01000524 */  addiu      $a1, $zero, 0x1
    /* C3B4C 800D334C 21300002 */  addu       $a2, $s0, $zero
    /* C3B50 800D3350 07002726 */  addiu      $a3, $s1, 0x7
    /* C3B54 800D3354 2C00A98F */  lw         $t1, 0x2C($sp)
    /* C3B58 800D3358 07000824 */  addiu      $t0, $zero, 0x7
    /* C3B5C 800D335C 1000A8AF */  sw         $t0, 0x10($sp)
    /* C3B60 800D3360 3400A88F */  lw         $t0, 0x34($sp)
    /* C3B64 800D3364 18002425 */  addiu      $a0, $t1, 0x18
    /* C3B68 800D3368 03000924 */  addiu      $t1, $zero, 0x3
    /* C3B6C 800D336C 1400A9AF */  sw         $t1, 0x14($sp)
    /* C3B70 800D3370 8D49030C */  jal        Hud_BuildF4__FP7POLY_F4iiiiiUl
    /* C3B74 800D3374 1800A8AF */   sw        $t0, 0x18($sp)
    /* C3B78 800D3378 8C00A426 */  addiu      $a0, $s5, 0x8C
    /* C3B7C 800D337C 7D000524 */  addiu      $a1, $zero, 0x7D
    /* C3B80 800D3380 21300002 */  addu       $a2, $s0, $zero
    /* C3B84 800D3384 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3B88 800D3388 21382002 */   addu      $a3, $s1, $zero
    /* C3B8C 800D338C 3C001324 */  addiu      $s3, $zero, 0x3C
    /* C3B90 800D3390 A000A426 */  addiu      $a0, $s5, 0xA0
    /* C3B94 800D3394 69000524 */  addiu      $a1, $zero, 0x69
    /* C3B98 800D3398 1180093C */  lui        $t1, %hi(HudPmx_gShapes)
    /* C3B9C 800D339C 980C2925 */  addiu      $t1, $t1, %lo(HudPmx_gShapes)
    /* C3BA0 800D33A0 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3BA4 800D33A4 6C083485 */  lh         $s4, 0x86C($t1)
    /* C3BA8 800D33A8 12004384 */  lh         $v1, 0x12($v0)
    /* C3BAC 800D33AC 10005084 */  lh         $s0, 0x10($v0)
    /* C3BB0 800D33B0 21887700 */  addu       $s1, $v1, $s7
    /* C3BB4 800D33B4 21300002 */  addu       $a2, $s0, $zero
    /* C3BB8 800D33B8 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3BBC 800D33BC 21382002 */   addu      $a3, $s1, $zero
    /* C3BC0 800D33C0 21801402 */  addu       $s0, $s0, $s4
    /* C3BC4 800D33C4 6C00C426 */  addiu      $a0, $s6, 0x6C
    /* C3BC8 800D33C8 01000524 */  addiu      $a1, $zero, 0x1
    /* C3BCC 800D33CC 21300002 */  addu       $a2, $s0, $zero
    /* C3BD0 800D33D0 21382002 */  addu       $a3, $s1, $zero
    /* C3BD4 800D33D4 3400A98F */  lw         $t1, 0x34($sp)
    /* C3BD8 800D33D8 0A000824 */  addiu      $t0, $zero, 0xA
    /* C3BDC 800D33DC 1000B3AF */  sw         $s3, 0x10($sp)
    /* C3BE0 800D33E0 1400A8AF */  sw         $t0, 0x14($sp)
    /* C3BE4 800D33E4 1800A0AF */  sw         $zero, 0x18($sp)
    /* C3BE8 800D33E8 2000A0AF */  sw         $zero, 0x20($sp)
    /* C3BEC 800D33EC 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* C3BF0 800D33F0 B649030C */  jal        Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl
    /* C3BF4 800D33F4 2400A9AF */   sw        $t1, 0x24($sp)
    /* C3BF8 800D33F8 21801302 */  addu       $s0, $s0, $s3
    /* C3BFC 800D33FC 01000524 */  addiu      $a1, $zero, 0x1
    /* C3C00 800D3400 21300002 */  addu       $a2, $s0, $zero
    /* C3C04 800D3404 07002726 */  addiu      $a3, $s1, 0x7
    /* C3C08 800D3408 2C00A88F */  lw         $t0, 0x2C($sp)
    /* C3C0C 800D340C 07000924 */  addiu      $t1, $zero, 0x7
    /* C3C10 800D3410 1000A9AF */  sw         $t1, 0x10($sp)
    /* C3C14 800D3414 3400A98F */  lw         $t1, 0x34($sp)
    /* C3C18 800D3418 30000425 */  addiu      $a0, $t0, 0x30
    /* C3C1C 800D341C 03000824 */  addiu      $t0, $zero, 0x3
    /* C3C20 800D3420 1400A8AF */  sw         $t0, 0x14($sp)
    /* C3C24 800D3424 8D49030C */  jal        Hud_BuildF4__FP7POLY_F4iiiiiUl
    /* C3C28 800D3428 1800A9AF */   sw        $t1, 0x18($sp)
    /* C3C2C 800D342C B400A426 */  addiu      $a0, $s5, 0xB4
    /* C3C30 800D3430 7D000524 */  addiu      $a1, $zero, 0x7D
    /* C3C34 800D3434 21300002 */  addu       $a2, $s0, $zero
    /* C3C38 800D3438 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3C3C 800D343C 21382002 */   addu      $a3, $s1, $zero
    /* C3C40 800D3440 1180083C */  lui        $t0, %hi(HudPmx_gShapes)
    /* C3C44 800D3444 980C0825 */  addiu      $t0, $t0, %lo(HudPmx_gShapes)
    /* C3C48 800D3448 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C3C4C 800D344C 48091485 */  lh         $s4, 0x948($t0)
    /* C3C50 800D3450 0B004014 */  bnez       $v0, .L800D3480
    /* C3C54 800D3454 26001324 */   addiu     $s3, $zero, 0x26
    /* C3C58 800D3458 1180083C */  lui        $t0, %hi(GameSetup_gData)
    /* C3C5C 800D345C 3800A98F */  lw         $t1, 0x38($sp)
    /* C3C60 800D3460 EC310825 */  addiu      $t0, $t0, %lo(GameSetup_gData)
    /* C3C64 800D3464 21102801 */  addu       $v0, $t1, $t0
    /* C3C68 800D3468 C000428C */  lw         $v0, 0xC0($v0)
    /* C3C6C 800D346C 00000000 */  nop
    /* C3C70 800D3470 02004014 */  bnez       $v0, .L800D347C
    /* C3C74 800D3474 32001324 */   addiu     $s3, $zero, 0x32
    /* C3C78 800D3478 3D001324 */  addiu      $s3, $zero, 0x3D
  .L800D347C:
    /* C3C7C 800D347C F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
  .L800D3480:
    /* C3C80 800D3480 00000000 */  nop
    /* C3C84 800D3484 06004010 */  beqz       $v0, .L800D34A0
    /* C3C88 800D3488 00000000 */   nop
    /* C3C8C 800D348C B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3C90 800D3490 00000000 */  nop
    /* C3C94 800D3494 08004284 */  lh         $v0, 0x8($v0)
    /* C3C98 800D3498 2B4D0308 */  j          .L800D34AC
    /* C3C9C 800D349C 0E005024 */   addiu     $s0, $v0, 0xE
  .L800D34A0:
    /* C3CA0 800D34A0 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3CA4 800D34A4 00000000 */  nop
    /* C3CA8 800D34A8 14005084 */  lh         $s0, 0x14($v0)
  .L800D34AC:
    /* C3CAC 800D34AC F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C3CB0 800D34B0 00000000 */  nop
    /* C3CB4 800D34B4 07004010 */  beqz       $v0, .L800D34D4
    /* C3CB8 800D34B8 00000000 */   nop
    /* C3CBC 800D34BC B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3CC0 800D34C0 00000000 */  nop
    /* C3CC4 800D34C4 0A004384 */  lh         $v1, 0xA($v0)
    /* C3CC8 800D34C8 0E00E226 */  addiu      $v0, $s7, 0xE
    /* C3CCC 800D34CC 3A4D0308 */  j          .L800D34E8
    /* C3CD0 800D34D0 21886200 */   addu      $s1, $v1, $v0
  .L800D34D4:
    /* C3CD4 800D34D4 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3CD8 800D34D8 00000000 */  nop
    /* C3CDC 800D34DC 16004284 */  lh         $v0, 0x16($v0)
    /* C3CE0 800D34E0 00000000 */  nop
    /* C3CE4 800D34E4 21885700 */  addu       $s1, $v0, $s7
  .L800D34E8:
    /* C3CE8 800D34E8 C800A426 */  addiu      $a0, $s5, 0xC8
    /* C3CEC 800D34EC 76000524 */  addiu      $a1, $zero, 0x76
    /* C3CF0 800D34F0 21300002 */  addu       $a2, $s0, $zero
    /* C3CF4 800D34F4 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3CF8 800D34F8 21382002 */   addu      $a3, $s1, $zero
    /* C3CFC 800D34FC 4800C426 */  addiu      $a0, $s6, 0x48
    /* C3D00 800D3500 01000524 */  addiu      $a1, $zero, 0x1
    /* C3D04 800D3504 21801402 */  addu       $s0, $s0, $s4
    /* C3D08 800D3508 21300002 */  addu       $a2, $s0, $zero
    /* C3D0C 800D350C 21382002 */  addu       $a3, $s1, $zero
    /* C3D10 800D3510 3400A88F */  lw         $t0, 0x34($sp)
    /* C3D14 800D3514 0A000924 */  addiu      $t1, $zero, 0xA
    /* C3D18 800D3518 1000B3AF */  sw         $s3, 0x10($sp)
    /* C3D1C 800D351C 1400A9AF */  sw         $t1, 0x14($sp)
    /* C3D20 800D3520 1800A0AF */  sw         $zero, 0x18($sp)
    /* C3D24 800D3524 2000A0AF */  sw         $zero, 0x20($sp)
    /* C3D28 800D3528 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* C3D2C 800D352C B649030C */  jal        Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl
    /* C3D30 800D3530 2400A8AF */   sw        $t0, 0x24($sp)
    /* C3D34 800D3534 01000524 */  addiu      $a1, $zero, 0x1
    /* C3D38 800D3538 21801302 */  addu       $s0, $s0, $s3
    /* C3D3C 800D353C 21300002 */  addu       $a2, $s0, $zero
    /* C3D40 800D3540 07002726 */  addiu      $a3, $s1, 0x7
    /* C3D44 800D3544 2C00A98F */  lw         $t1, 0x2C($sp)
    /* C3D48 800D3548 07000824 */  addiu      $t0, $zero, 0x7
    /* C3D4C 800D354C 1000A8AF */  sw         $t0, 0x10($sp)
    /* C3D50 800D3550 3400A88F */  lw         $t0, 0x34($sp)
    /* C3D54 800D3554 48002425 */  addiu      $a0, $t1, 0x48
    /* C3D58 800D3558 03000924 */  addiu      $t1, $zero, 0x3
    /* C3D5C 800D355C 1400A9AF */  sw         $t1, 0x14($sp)
    /* C3D60 800D3560 8D49030C */  jal        Hud_BuildF4__FP7POLY_F4iiiiiUl
    /* C3D64 800D3564 1800A8AF */   sw        $t0, 0x18($sp)
    /* C3D68 800D3568 DC00A426 */  addiu      $a0, $s5, 0xDC
    /* C3D6C 800D356C 7D000524 */  addiu      $a1, $zero, 0x7D
    /* C3D70 800D3570 21300002 */  addu       $a2, $s0, $zero
    /* C3D74 800D3574 3000A98F */  lw         $t1, 0x30($sp)
    /* C3D78 800D3578 21382002 */  addu       $a3, $s1, $zero
    /* C3D7C 800D357C 1400A0AF */  sw         $zero, 0x14($sp)
    /* C3D80 800D3580 E647030C */  jal        Hud_BuildSprite__FP4SPRTiiiUli
    /* C3D84 800D3584 1000A9AF */   sw        $t1, 0x10($sp)
    /* C3D88 800D3588 F000A426 */  addiu      $a0, $s5, 0xF0
    /* C3D8C 800D358C 0580053C */  lui        $a1, %hi(D_800568EC)
    /* C3D90 800D3590 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3D94 800D3594 2800A88F */  lw         $t0, 0x28($sp)
    /* C3D98 800D3598 08004384 */  lh         $v1, 0x8($v0)
    /* C3D9C 800D359C 18004684 */  lh         $a2, 0x18($v0)
    /* C3DA0 800D35A0 0A004784 */  lh         $a3, 0xA($v0)
    /* C3DA4 800D35A4 1A004284 */  lh         $v0, 0x1A($v0)
    /* C3DA8 800D35A8 EC68A524 */  addiu      $a1, $a1, %lo(D_800568EC)
    /* C3DAC 800D35AC C81888AF */  sw         $t0, %gp_rel(D_8013DE14)($gp)
    /* C3DB0 800D35B0 21306600 */  addu       $a2, $v1, $a2
    /* C3DB4 800D35B4 2138F700 */  addu       $a3, $a3, $s7
    /* C3DB8 800D35B8 BE4B030C */  jal        Hud_BuildTimeSprites__FP4SPRTPcii
    /* C3DBC 800D35BC 2138E200 */   addu      $a3, $a3, $v0
    /* C3DC0 800D35C0 9001A426 */  addiu      $a0, $s5, 0x190
    /* C3DC4 800D35C4 1480053C */  lui        $a1, %hi(D_8013D8EC)
    /* C3DC8 800D35C8 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3DCC 800D35CC ECD8A524 */  addiu      $a1, $a1, %lo(D_8013D8EC)
    /* C3DD0 800D35D0 0C004384 */  lh         $v1, 0xC($v0)
    /* C3DD4 800D35D4 1C004684 */  lh         $a2, 0x1C($v0)
    /* C3DD8 800D35D8 0E004784 */  lh         $a3, 0xE($v0)
    /* C3DDC 800D35DC 1E004284 */  lh         $v0, 0x1E($v0)
    /* C3DE0 800D35E0 21306600 */  addu       $a2, $v1, $a2
    /* C3DE4 800D35E4 2138E200 */  addu       $a3, $a3, $v0
    /* C3DE8 800D35E8 2138F700 */  addu       $a3, $a3, $s7
    /* C3DEC 800D35EC BE4B030C */  jal        Hud_BuildTimeSprites__FP4SPRTPcii
    /* C3DF0 800D35F0 2338F200 */   subu      $a3, $a3, $s2
    /* C3DF4 800D35F4 A000033C */  lui        $v1, (0xA0A0A0 >> 16)
    /* C3DF8 800D35F8 A0A06334 */  ori        $v1, $v1, (0xA0A0A0 & 0xFFFF)
    /* C3DFC 800D35FC CC01A426 */  addiu      $a0, $s5, 0x1CC
    /* C3E00 800D3600 1480053C */  lui        $a1, %hi(D_8013D8F0)
    /* C3E04 800D3604 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3E08 800D3608 F0D8A524 */  addiu      $a1, $a1, %lo(D_8013D8F0)
    /* C3E0C 800D360C C81883AF */  sw         $v1, %gp_rel(D_8013DE14)($gp)
    /* C3E10 800D3610 10004384 */  lh         $v1, 0x10($v0)
    /* C3E14 800D3614 20004684 */  lh         $a2, 0x20($v0)
    /* C3E18 800D3618 12004784 */  lh         $a3, 0x12($v0)
    /* C3E1C 800D361C 22004284 */  lh         $v0, 0x22($v0)
    /* C3E20 800D3620 21306600 */  addu       $a2, $v1, $a2
    /* C3E24 800D3624 2138E200 */  addu       $a3, $a3, $v0
    /* C3E28 800D3628 2138F700 */  addu       $a3, $a3, $s7
    /* C3E2C 800D362C BE4B030C */  jal        Hud_BuildTimeSprites__FP4SPRTPcii
    /* C3E30 800D3630 0100E724 */   addiu     $a3, $a3, 0x1
    /* C3E34 800D3634 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C3E38 800D3638 00000000 */  nop
    /* C3E3C 800D363C 06004010 */  beqz       $v0, .L800D3658
    /* C3E40 800D3640 00000000 */   nop
    /* C3E44 800D3644 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3E48 800D3648 00000000 */  nop
    /* C3E4C 800D364C 08004284 */  lh         $v0, 0x8($v0)
    /* C3E50 800D3650 9C4D0308 */  j          .L800D3670
    /* C3E54 800D3654 10005024 */   addiu     $s0, $v0, 0x10
  .L800D3658:
    /* C3E58 800D3658 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3E5C 800D365C 00000000 */  nop
    /* C3E60 800D3660 14004384 */  lh         $v1, 0x14($v0)
    /* C3E64 800D3664 24004284 */  lh         $v0, 0x24($v0)
    /* C3E68 800D3668 00000000 */  nop
    /* C3E6C 800D366C 21806200 */  addu       $s0, $v1, $v0
  .L800D3670:
    /* C3E70 800D3670 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C3E74 800D3674 00000000 */  nop
    /* C3E78 800D3678 07004010 */  beqz       $v0, .L800D3698
    /* C3E7C 800D367C 00000000 */   nop
    /* C3E80 800D3680 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3E84 800D3684 00000000 */  nop
    /* C3E88 800D3688 0A004384 */  lh         $v1, 0xA($v0)
    /* C3E8C 800D368C 0C00E226 */  addiu      $v0, $s7, 0xC
    /* C3E90 800D3690 AC4D0308 */  j          .L800D36B0
    /* C3E94 800D3694 21886200 */   addu      $s1, $v1, $v0
  .L800D3698:
    /* C3E98 800D3698 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3E9C 800D369C 00000000 */  nop
    /* C3EA0 800D36A0 16004284 */  lh         $v0, 0x16($v0)
    /* C3EA4 800D36A4 00000000 */  nop
    /* C3EA8 800D36A8 21105700 */  addu       $v0, $v0, $s7
    /* C3EAC 800D36AC 01005124 */  addiu      $s1, $v0, 0x1
  .L800D36B0:
    /* C3EB0 800D36B0 1180083C */  lui        $t0, %hi(GameSetup_gData)
    /* C3EB4 800D36B4 3800A98F */  lw         $t1, 0x38($sp)
    /* C3EB8 800D36B8 EC310825 */  addiu      $t0, $t0, %lo(GameSetup_gData)
    /* C3EBC 800D36BC 21102801 */  addu       $v0, $t1, $t0
    /* C3EC0 800D36C0 1180093C */  lui        $t1, %hi(HudPmx_gShapes)
    /* C3EC4 800D36C4 980C2925 */  addiu      $t1, $t1, %lo(HudPmx_gShapes)
    /* C3EC8 800D36C8 48092385 */  lh         $v1, 0x948($t1)
    /* C3ECC 800D36CC C000428C */  lw         $v0, 0xC0($v0)
    /* C3ED0 800D36D0 00000000 */  nop
    /* C3ED4 800D36D4 05004014 */  bnez       $v0, .L800D36EC
    /* C3ED8 800D36D8 21800302 */   addu      $s0, $s0, $v1
    /* C3EDC 800D36DC 5802A426 */  addiu      $a0, $s5, 0x258
    /* C3EE0 800D36E0 1480053C */  lui        $a1, %hi(D_8013D8F0)
    /* C3EE4 800D36E4 BE4D0308 */  j          .L800D36F8
    /* C3EE8 800D36E8 F0D8A524 */   addiu     $a1, $a1, %lo(D_8013D8F0)
  .L800D36EC:
    /* C3EEC 800D36EC 5802A426 */  addiu      $a0, $s5, 0x258
    /* C3EF0 800D36F0 1480053C */  lui        $a1, %hi(D_8013D8F8)
    /* C3EF4 800D36F4 F8D8A524 */  addiu      $a1, $a1, %lo(D_8013D8F8)
  .L800D36F8:
    /* C3EF8 800D36F8 21300002 */  addu       $a2, $s0, $zero
    /* C3EFC 800D36FC BE4B030C */  jal        Hud_BuildTimeSprites__FP4SPRTPcii
    /* C3F00 800D3700 21382002 */   addu      $a3, $s1, $zero
    /* C3F04 800D3704 1480033C */  lui        $v1, %hi(D_8013DE18)
    /* C3F08 800D3708 18DE6324 */  addiu      $v1, $v1, %lo(D_8013DE18)
    /* C3F0C 800D370C 2800A88F */  lw         $t0, 0x28($sp)
    /* C3F10 800D3710 7602A286 */  lh         $v0, 0x276($s5)
    /* C3F14 800D3714 3800A98F */  lw         $t1, 0x38($sp)
    /* C3F18 800D3718 6202A486 */  lh         $a0, 0x262($s5)
    /* C3F1C 800D371C 21182301 */  addu       $v1, $t1, $v1
    /* C3F20 800D3720 23104400 */  subu       $v0, $v0, $a0
    /* C3F24 800D3724 000062AC */  sw         $v0, 0x0($v1)
    /* C3F28 800D3728 1480033C */  lui        $v1, %hi(D_8013DE20)
    /* C3F2C 800D372C 20DE6324 */  addiu      $v1, $v1, %lo(D_8013DE20)
    /* C3F30 800D3730 B202A286 */  lh         $v0, 0x2B2($s5)
    /* C3F34 800D3734 6202A486 */  lh         $a0, 0x262($s5)
    /* C3F38 800D3738 21182301 */  addu       $v1, $t1, $v1
    /* C3F3C 800D373C C81888AF */  sw         $t0, %gp_rel(D_8013DE14)($gp)
    /* C3F40 800D3740 1180083C */  lui        $t0, %hi(HudPmx_gShapes)
    /* C3F44 800D3744 23104400 */  subu       $v0, $v0, $a0
    /* C3F48 800D3748 B818848F */  lw         $a0, %gp_rel(D_8013DE04)($gp)
    /* C3F4C 800D374C 980C0825 */  addiu      $t0, $t0, %lo(HudPmx_gShapes)
    /* C3F50 800D3750 000062AC */  sw         $v0, 0x0($v1)
    /* C3F54 800D3754 80031485 */  lh         $s4, 0x380($t0)
    /* C3F58 800D3758 38008384 */  lh         $v1, 0x38($a0)
    /* C3F5C 800D375C 28008284 */  lh         $v0, 0x28($a0)
    /* C3F60 800D3760 9C051385 */  lh         $s3, 0x59C($t0)
    /* C3F64 800D3764 21806200 */  addu       $s0, $v1, $v0
    /* C3F68 800D3768 3A008284 */  lh         $v0, 0x3A($a0)
    /* C3F6C 800D376C 2014838F */  lw         $v1, %gp_rel(HudMapOffsetY)($gp)
    /* C3F70 800D3770 2A008484 */  lh         $a0, 0x2A($a0)
    /* C3F74 800D3774 21104300 */  addu       $v0, $v0, $v1
    /* C3F78 800D3778 21104400 */  addu       $v0, $v0, $a0
    /* C3F7C 800D377C 0700C017 */  bnez       $fp, .L800D379C
    /* C3F80 800D3780 21885700 */   addu      $s1, $v0, $s7
    /* C3F84 800D3784 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
    /* C3F88 800D3788 3027428C */  lw         $v0, %lo(DashHUD_gInfo)($v0)
    /* C3F8C 800D378C 00000000 */  nop
    /* C3F90 800D3790 03004010 */  beqz       $v0, .L800D37A0
    /* C3F94 800D3794 2003A426 */   addiu     $a0, $s5, 0x320
    /* C3F98 800D3798 FEFF3126 */  addiu      $s1, $s1, -0x2
  .L800D379C:
    /* C3F9C 800D379C 2003A426 */  addiu      $a0, $s5, 0x320
  .L800D37A0:
    /* C3FA0 800D37A0 3E000524 */  addiu      $a1, $zero, 0x3E
    /* C3FA4 800D37A4 FFFF2726 */  addiu      $a3, $s1, -0x1
    /* C3FA8 800D37A8 21900000 */  addu       $s2, $zero, $zero
    /* C3FAC 800D37AC B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3FB0 800D37B0 3000A98F */  lw         $t1, 0x30($sp)
    /* C3FB4 800D37B4 38004684 */  lh         $a2, 0x38($v0)
    /* C3FB8 800D37B8 34031624 */  addiu      $s6, $zero, 0x334
    /* C3FBC 800D37BC 1000A9AF */  sw         $t1, 0x10($sp)
    /* C3FC0 800D37C0 1400A0AF */  sw         $zero, 0x14($sp)
    /* C3FC4 800D37C4 E647030C */  jal        Hud_BuildSprite__FP4SPRTiiiUli
    /* C3FC8 800D37C8 1300C624 */   addiu     $a2, $a2, 0x13
    /* C3FCC 800D37CC E402A426 */  addiu      $a0, $s5, 0x2E4
    /* C3FD0 800D37D0 2C000524 */  addiu      $a1, $zero, 0x2C
    /* C3FD4 800D37D4 21300002 */  addu       $a2, $s0, $zero
    /* C3FD8 800D37D8 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3FDC 800D37DC 21382002 */   addu      $a3, $s1, $zero
    /* C3FE0 800D37E0 21801402 */  addu       $s0, $s0, $s4
    /* C3FE4 800D37E4 F802A426 */  addiu      $a0, $s5, 0x2F8
    /* C3FE8 800D37E8 47000524 */  addiu      $a1, $zero, 0x47
    /* C3FEC 800D37EC 21300002 */  addu       $a2, $s0, $zero
    /* C3FF0 800D37F0 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3FF4 800D37F4 21382002 */   addu      $a3, $s1, $zero
    /* C3FF8 800D37F8 0C03A426 */  addiu      $a0, $s5, 0x30C
    /* C3FFC 800D37FC 36000524 */  addiu      $a1, $zero, 0x36
    /* C4000 800D3800 21301302 */  addu       $a2, $s0, $s3
    /* C4004 800D3804 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C4008 800D3808 21382002 */   addu      $a3, $s1, $zero
    /* C400C 800D380C D403A426 */  addiu      $a0, $s5, 0x3D4
    /* C4010 800D3810 B818838F */  lw         $v1, %gp_rel(D_8013DE04)($gp)
    /* C4014 800D3814 3000A88F */  lw         $t0, 0x30($sp)
    /* C4018 800D3818 04006784 */  lh         $a3, 0x4($v1)
    /* C401C 800D381C 2C006684 */  lh         $a2, 0x2C($v1)
    /* C4020 800D3820 06006284 */  lh         $v0, 0x6($v1)
    /* C4024 800D3824 2E006384 */  lh         $v1, 0x2E($v1)
    /* C4028 800D3828 1A000524 */  addiu      $a1, $zero, 0x1A
    /* C402C 800D382C C81888AF */  sw         $t0, %gp_rel(D_8013DE14)($gp)
    /* C4030 800D3830 2180E600 */  addu       $s0, $a3, $a2
    /* C4034 800D3834 21104300 */  addu       $v0, $v0, $v1
    /* C4038 800D3838 21885700 */  addu       $s1, $v0, $s7
    /* C403C 800D383C FFFF0626 */  addiu      $a2, $s0, -0x1
    /* C4040 800D3840 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C4044 800D3844 21382002 */   addu      $a3, $s1, $zero
    /* C4048 800D3848 E803A426 */  addiu      $a0, $s5, 0x3E8
    /* C404C 800D384C 1B000524 */  addiu      $a1, $zero, 0x1B
    /* C4050 800D3850 FEFF0626 */  addiu      $a2, $s0, -0x2
    /* C4054 800D3854 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C4058 800D3858 FFFF2726 */   addiu     $a3, $s1, -0x1
    /* C405C 800D385C 06003126 */  addiu      $s1, $s1, 0x6
    /* C4060 800D3860 02001026 */  addiu      $s0, $s0, 0x2
  .L800D3864:
    /* C4064 800D3864 2120B602 */  addu       $a0, $s5, $s6
    /* C4068 800D3868 1C004526 */  addiu      $a1, $s2, 0x1C
    /* C406C 800D386C 21300002 */  addu       $a2, $s0, $zero
    /* C4070 800D3870 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C4074 800D3874 21382002 */   addu      $a3, $s1, $zero
    /* C4078 800D3878 01005226 */  addiu      $s2, $s2, 0x1
    /* C407C 800D387C 0800422A */  slti       $v0, $s2, 0x8
    /* C4080 800D3880 F8FF4014 */  bnez       $v0, .L800D3864
    /* C4084 800D3884 1400D626 */   addiu     $s6, $s6, 0x14
    /* C4088 800D3888 2120C003 */  addu       $a0, $fp, $zero
    /* C408C 800D388C D34A030C */  jal        Hud_InitMapFrame__Fii
    /* C4090 800D3890 21280000 */   addu      $a1, $zero, $zero
    /* C4094 800D3894 0100DE27 */  addiu      $fp, $fp, 0x1
    /* C4098 800D3898 3800A98F */  lw         $t1, 0x38($sp)
    /* C409C 800D389C 3C00A88F */  lw         $t0, 0x3C($sp)
    /* C40A0 800D38A0 04002925 */  addiu      $t1, $t1, 0x4
    /* C40A4 800D38A4 B4000825 */  addiu      $t0, $t0, 0xB4
    /* C40A8 800D38A8 3800A9AF */  sw         $t1, 0x38($sp)
    /* C40AC 800D38AC 434C0308 */  j          .L800D310C
    /* C40B0 800D38B0 3C00A8AF */   sw        $t0, 0x3C($sp)
  .L800D38B4:
    /* C40B4 800D38B4 80804234 */  ori        $v0, $v0, (0x808080 & 0xFFFF)
    /* C40B8 800D38B8 6F000524 */  addiu      $a1, $zero, 0x6F
    /* C40BC 800D38BC BC18918F */  lw         $s1, %gp_rel(D_8013DE08)($gp)
    /* C40C0 800D38C0 21F00000 */  addu       $fp, $zero, $zero
    /* C40C4 800D38C4 C81882AF */  sw         $v0, %gp_rel(D_8013DE14)($gp)
    /* C40C8 800D38C8 01000224 */  addiu      $v0, $zero, 0x1
    /* C40CC 800D38CC C41882A3 */  sb         $v0, %gp_rel(D_8013DE10)($gp)
    /* C40D0 800D38D0 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C40D4 800D38D4 4C042426 */  addiu      $a0, $s1, 0x44C
    /* C40D8 800D38D8 34005284 */  lh         $s2, 0x34($v0)
    /* C40DC 800D38DC 36005084 */  lh         $s0, 0x36($v0)
    /* C40E0 800D38E0 21304002 */  addu       $a2, $s2, $zero
    /* C40E4 800D38E4 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C40E8 800D38E8 21380002 */   addu      $a3, $s0, $zero
    /* C40EC 800D38EC FC032426 */  addiu      $a0, $s1, 0x3FC
    /* C40F0 800D38F0 6C000524 */  addiu      $a1, $zero, 0x6C
    /* C40F4 800D38F4 12004626 */  addiu      $a2, $s2, 0x12
    /* C40F8 800D38F8 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C40FC 800D38FC 21380002 */   addu      $a3, $s0, $zero
    /* C4100 800D3900 10042426 */  addiu      $a0, $s1, 0x410
    /* C4104 800D3904 6E000524 */  addiu      $a1, $zero, 0x6E
    /* C4108 800D3908 25004626 */  addiu      $a2, $s2, 0x25
    /* C410C 800D390C 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C4110 800D3910 21380002 */   addu      $a3, $s0, $zero
    /* C4114 800D3914 24042426 */  addiu      $a0, $s1, 0x424
    /* C4118 800D3918 3F000524 */  addiu      $a1, $zero, 0x3F
    /* C411C 800D391C 3A004626 */  addiu      $a2, $s2, 0x3A
    /* C4120 800D3920 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C4124 800D3924 21380002 */   addu      $a3, $s0, $zero
    /* C4128 800D3928 60042426 */  addiu      $a0, $s1, 0x460
    /* C412C 800D392C 72000524 */  addiu      $a1, $zero, 0x72
    /* C4130 800D3930 4A004626 */  addiu      $a2, $s2, 0x4A
    /* C4134 800D3934 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C4138 800D3938 21380002 */   addu      $a3, $s0, $zero
    /* C413C 800D393C 38042426 */  addiu      $a0, $s1, 0x438
    /* C4140 800D3940 2128C003 */  addu       $a1, $fp, $zero
    /* C4144 800D3944 6D004626 */  addiu      $a2, $s2, 0x6D
    /* C4148 800D3948 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C414C 800D394C F9FF0726 */   addiu     $a3, $s0, -0x7
    /* C4150 800D3950 74042426 */  addiu      $a0, $s1, 0x474
    /* C4154 800D3954 03000524 */  addiu      $a1, $zero, 0x3
    /* C4158 800D3958 2130C003 */  addu       $a2, $fp, $zero
    /* C415C 800D395C 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C4160 800D3960 04000726 */   addiu     $a3, $s0, 0x4
    /* C4164 800D3964 C41880A3 */  sb         $zero, %gp_rel(D_8013DE10)($gp)
    /* C4168 800D3968 EE58030C */  jal        Hud_InitCdPlayer__Fv
    /* C416C 800D396C 00000000 */   nop
    /* C4170 800D3970 FC65030C */  jal        Hud_Reset__Fv
    /* C4174 800D3974 00000000 */   nop
    /* C4178 800D3978 1480043C */  lui        $a0, %hi(D_8013DE40)
    /* C417C 800D397C 40DE8424 */  addiu      $a0, $a0, %lo(D_8013DE40)
    /* C4180 800D3980 1480033C */  lui        $v1, %hi(D_8013DE38)
    /* C4184 800D3984 38DE6324 */  addiu      $v1, $v1, %lo(D_8013DE38)
    /* C4188 800D3988 DC1880AF */  sw         $zero, %gp_rel(D_8013DE28)($gp)
    /* C418C 800D398C E81380AF */  sw         $zero, %gp_rel(BTC_Countdown)($gp)
    /* C4190 800D3990 EC1380AF */  sw         $zero, %gp_rel(FinalBTC_Countdown)($gp)
    /* C4194 800D3994 E41880AF */  sw         $zero, %gp_rel(D_8013DE30)($gp)
    /* C4198 800D3998 DC1380AF */  sw         $zero, %gp_rel(HudBustedOverlay)($gp)
  .L800D399C:
    /* C419C 800D399C 000060AC */  sw         $zero, 0x0($v1)
    /* C41A0 800D39A0 000080AC */  sw         $zero, 0x0($a0)
    /* C41A4 800D39A4 04008424 */  addiu      $a0, $a0, 0x4
    /* C41A8 800D39A8 0100DE27 */  addiu      $fp, $fp, 0x1
    /* C41AC 800D39AC 0200C22B */  slti       $v0, $fp, 0x2
    /* C41B0 800D39B0 FAFF4014 */  bnez       $v0, .L800D399C
    /* C41B4 800D39B4 04006324 */   addiu     $v1, $v1, 0x4
    /* C41B8 800D39B8 6400BF8F */  lw         $ra, 0x64($sp)
    /* C41BC 800D39BC 6000BE8F */  lw         $fp, 0x60($sp)
    /* C41C0 800D39C0 5C00B78F */  lw         $s7, 0x5C($sp)
    /* C41C4 800D39C4 5800B68F */  lw         $s6, 0x58($sp)
    /* C41C8 800D39C8 5400B58F */  lw         $s5, 0x54($sp)
    /* C41CC 800D39CC 5000B48F */  lw         $s4, 0x50($sp)
    /* C41D0 800D39D0 4C00B38F */  lw         $s3, 0x4C($sp)
    /* C41D4 800D39D4 4800B28F */  lw         $s2, 0x48($sp)
    /* C41D8 800D39D8 4400B18F */  lw         $s1, 0x44($sp)
    /* C41DC 800D39DC 4000B08F */  lw         $s0, 0x40($sp)
    /* C41E0 800D39E0 F41380AF */  sw         $zero, %gp_rel(Hud_kTurnSongOffNext)($gp)
    /* C41E4 800D39E4 0800E003 */  jr         $ra
    /* C41E8 800D39E8 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel Hud_Init__Fv
