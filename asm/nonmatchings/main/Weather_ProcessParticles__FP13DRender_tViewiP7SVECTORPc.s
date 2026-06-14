.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc, 0x3EC

glabel Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc
    /* D37D0 800E2FD0 F8FEBD27 */  addiu      $sp, $sp, -0x108
    /* D37D4 800E2FD4 F400B3AF */  sw         $s3, 0xF4($sp)
    /* D37D8 800E2FD8 21988000 */  addu       $s3, $a0, $zero
    /* D37DC 800E2FDC F800B4AF */  sw         $s4, 0xF8($sp)
    /* D37E0 800E2FE0 21A0A000 */  addu       $s4, $a1, $zero
    /* D37E4 800E2FE4 FC00B5AF */  sw         $s5, 0xFC($sp)
    /* D37E8 800E2FE8 21A8C000 */  addu       $s5, $a2, $zero
    /* D37EC 800E2FEC 0001B6AF */  sw         $s6, 0x100($sp)
    /* D37F0 800E2FF0 21B0E000 */  addu       $s6, $a3, $zero
    /* D37F4 800E2FF4 F000B2AF */  sw         $s2, 0xF0($sp)
    /* D37F8 800E2FF8 68007226 */  addiu      $s2, $s3, 0x68
    /* D37FC 800E2FFC 21204002 */  addu       $a0, $s2, $zero
    /* D3800 800E3000 EC00B1AF */  sw         $s1, 0xEC($sp)
    /* D3804 800E3004 3800B127 */  addiu      $s1, $sp, 0x38
    /* D3808 800E3008 21282002 */  addu       $a1, $s1, $zero
    /* D380C 800E300C 0401BFAF */  sw         $ra, 0x104($sp)
    /* D3810 800E3010 548B030C */  jal        Weather_QuickReOrthogonalize__FP10matrixtdefT0
    /* D3814 800E3014 E800B0AF */   sw        $s0, 0xE8($sp)
    /* D3818 800E3018 21282002 */  addu       $a1, $s1, $zero
    /* D381C 800E301C 1000A627 */  addiu      $a2, $sp, 0x10
    /* D3820 800E3020 1280103C */  lui        $s0, %hi(prevCamMat)
    /* D3824 800E3024 0400628E */  lw         $v0, 0x4($s3)
    /* D3828 800E3028 44341026 */  addiu      $s0, $s0, %lo(prevCamMat)
    /* D382C 800E302C C0200200 */  sll        $a0, $v0, 3
    /* D3830 800E3030 21208200 */  addu       $a0, $a0, $v0
    /* D3834 800E3034 80200400 */  sll        $a0, $a0, 2
    /* D3838 800E3038 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* D383C 800E303C 21209000 */   addu      $a0, $a0, $s0
    /* D3840 800E3040 0400628E */  lw         $v0, 0x4($s3)
    /* D3844 800E3044 21202002 */  addu       $a0, $s1, $zero
    /* D3848 800E3048 C0280200 */  sll        $a1, $v0, 3
    /* D384C 800E304C 2128A200 */  addu       $a1, $a1, $v0
    /* D3850 800E3050 80280500 */  sll        $a1, $a1, 2
    /* D3854 800E3054 D690030C */  jal        transpose
    /* D3858 800E3058 2128B000 */   addu      $a1, $a1, $s0
    /* D385C 800E305C 1000A427 */  addiu      $a0, $sp, 0x10
    /* D3860 800E3060 21288002 */  addu       $a1, $s4, $zero
    /* D3864 800E3064 448A030C */  jal        Weather_TransformVertex__FP10matrixtdefiP7SVECTOR
    /* D3868 800E3068 2130A002 */   addu      $a2, $s5, $zero
    /* D386C 800E306C 7487030C */  jal        Weather_SetMatrix__FP10matrixtdef
    /* D3870 800E3070 21204002 */   addu      $a0, $s2, $zero
    /* D3874 800E3074 1280023C */  lui        $v0, %hi(prevCamPos)
    /* D3878 800E3078 0400638E */  lw         $v1, 0x4($s3)
    /* D387C 800E307C 2C344524 */  addiu      $a1, $v0, %lo(prevCamPos)
    /* D3880 800E3080 40100300 */  sll        $v0, $v1, 1
    /* D3884 800E3084 21104300 */  addu       $v0, $v0, $v1
    /* D3888 800E3088 80100200 */  sll        $v0, $v0, 2
    /* D388C 800E308C 21104500 */  addu       $v0, $v0, $a1
    /* D3890 800E3090 0800638E */  lw         $v1, 0x8($s3)
    /* D3894 800E3094 0000428C */  lw         $v0, 0x0($v0)
    /* D3898 800E3098 00000000 */  nop
    /* D389C 800E309C 23106200 */  subu       $v0, $v1, $v0
    /* D38A0 800E30A0 02004104 */  bgez       $v0, .L800E30AC
    /* D38A4 800E30A4 08006426 */   addiu     $a0, $s3, 0x8
    /* D38A8 800E30A8 FF034224 */  addiu      $v0, $v0, 0x3FF
  .L800E30AC:
    /* D38AC 800E30AC 83120200 */  sra        $v0, $v0, 10
    /* D38B0 800E30B0 7000A2A7 */  sh         $v0, 0x70($sp)
    /* D38B4 800E30B4 0400638E */  lw         $v1, 0x4($s3)
    /* D38B8 800E30B8 00000000 */  nop
    /* D38BC 800E30BC 40100300 */  sll        $v0, $v1, 1
    /* D38C0 800E30C0 21104300 */  addu       $v0, $v0, $v1
    /* D38C4 800E30C4 80100200 */  sll        $v0, $v0, 2
    /* D38C8 800E30C8 21104500 */  addu       $v0, $v0, $a1
    /* D38CC 800E30CC 0400838C */  lw         $v1, 0x4($a0)
    /* D38D0 800E30D0 0400428C */  lw         $v0, 0x4($v0)
    /* D38D4 800E30D4 00000000 */  nop
    /* D38D8 800E30D8 23106200 */  subu       $v0, $v1, $v0
    /* D38DC 800E30DC 02004104 */  bgez       $v0, .L800E30E8
    /* D38E0 800E30E0 00000000 */   nop
    /* D38E4 800E30E4 FF034224 */  addiu      $v0, $v0, 0x3FF
  .L800E30E8:
    /* D38E8 800E30E8 83120200 */  sra        $v0, $v0, 10
    /* D38EC 800E30EC 7200A2A7 */  sh         $v0, 0x72($sp)
    /* D38F0 800E30F0 0400638E */  lw         $v1, 0x4($s3)
    /* D38F4 800E30F4 00000000 */  nop
    /* D38F8 800E30F8 40100300 */  sll        $v0, $v1, 1
    /* D38FC 800E30FC 21104300 */  addu       $v0, $v0, $v1
    /* D3900 800E3100 80100200 */  sll        $v0, $v0, 2
    /* D3904 800E3104 21104500 */  addu       $v0, $v0, $a1
    /* D3908 800E3108 0800838C */  lw         $v1, 0x8($a0)
    /* D390C 800E310C 0800428C */  lw         $v0, 0x8($v0)
    /* D3910 800E3110 00000000 */  nop
    /* D3914 800E3114 23106200 */  subu       $v0, $v1, $v0
    /* D3918 800E3118 02004104 */  bgez       $v0, .L800E3124
    /* D391C 800E311C 00000000 */   nop
    /* D3920 800E3120 FF034224 */  addiu      $v0, $v0, 0x3FF
  .L800E3124:
    /* D3924 800E3124 83120200 */  sra        $v0, $v0, 10
    /* D3928 800E3128 7000A727 */  addiu      $a3, $sp, 0x70
    /* D392C 800E312C 7400A2A7 */  sh         $v0, 0x74($sp)
    /* D3930 800E3130 0000E0C8 */  lwc2       $0, 0x0($a3)
    /* D3934 800E3134 0400E1C8 */  lwc2       $1, 0x4($a3)
    /* D3938 800E3138 00000000 */  nop
    /* D393C 800E313C 00000000 */  nop
    /* D3940 800E3140 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* D3944 800E3144 0400638E */  lw         $v1, 0x4($s3)
    /* D3948 800E3148 7800A627 */  addiu      $a2, $sp, 0x78
    /* D394C 800E314C 40100300 */  sll        $v0, $v1, 1
    /* D3950 800E3150 21104300 */  addu       $v0, $v0, $v1
    /* D3954 800E3154 80100200 */  sll        $v0, $v0, 2
    /* D3958 800E3158 21104500 */  addu       $v0, $v0, $a1
    /* D395C 800E315C 08006C8E */  lw         $t4, 0x8($s3)
    /* D3960 800E3160 0C006D8E */  lw         $t5, 0xC($s3)
    /* D3964 800E3164 10006E8E */  lw         $t6, 0x10($s3)
    /* D3968 800E3168 00004CAC */  sw         $t4, 0x0($v0)
    /* D396C 800E316C 04004DAC */  sw         $t5, 0x4($v0)
    /* D3970 800E3170 08004EAC */  sw         $t6, 0x8($v0)
    /* D3974 800E3174 0000D9E8 */  swc2       $25, 0x0($a2)
    /* D3978 800E3178 0400DAE8 */  swc2       $26, 0x4($a2) /* handwritten instruction */
    /* D397C 800E317C 0800DBE8 */  swc2       $27, 0x8($a2) /* handwritten instruction */
    /* D3980 800E3180 7800A297 */  lhu        $v0, 0x78($sp)
    /* D3984 800E3184 7C00A397 */  lhu        $v1, 0x7C($sp)
    /* D3988 800E3188 23100200 */  negu       $v0, $v0
    /* D398C 800E318C 23180300 */  negu       $v1, $v1
    /* D3990 800E3190 6A00A3A7 */  sh         $v1, 0x6A($sp)
    /* D3994 800E3194 1280033C */  lui        $v1, %hi(D_80123410)
    /* D3998 800E3198 10346424 */  addiu      $a0, $v1, %lo(D_80123410)
    /* D399C 800E319C 6800A2A7 */  sh         $v0, 0x68($sp)
    /* D39A0 800E31A0 8000A297 */  lhu        $v0, 0x80($sp)
    /* D39A4 800E31A4 10346394 */  lhu        $v1, %lo(D_80123410)($v1)
    /* D39A8 800E31A8 02008594 */  lhu        $a1, 0x2($a0)
    /* D39AC 800E31AC 04008494 */  lhu        $a0, 0x4($a0)
    /* D39B0 800E31B0 23100200 */  negu       $v0, $v0
    /* D39B4 800E31B4 6C00A2A7 */  sh         $v0, 0x6C($sp)
    /* D39B8 800E31B8 7000A3A7 */  sh         $v1, 0x70($sp)
    /* D39BC 800E31BC 7200A5A7 */  sh         $a1, 0x72($sp)
    /* D39C0 800E31C0 7400A4A7 */  sh         $a0, 0x74($sp)
    /* D39C4 800E31C4 0000E0C8 */  lwc2       $0, 0x0($a3)
    /* D39C8 800E31C8 0400E1C8 */  lwc2       $1, 0x4($a3)
    /* D39CC 800E31CC 00000000 */  nop
    /* D39D0 800E31D0 00000000 */  nop
    /* D39D4 800E31D4 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* D39D8 800E31D8 0000D9E8 */  swc2       $25, 0x0($a2)
    /* D39DC 800E31DC 0400DAE8 */  swc2       $26, 0x4($a2) /* handwritten instruction */
    /* D39E0 800E31E0 0800DBE8 */  swc2       $27, 0x8($a2) /* handwritten instruction */
    /* D39E4 800E31E4 21500000 */  addu       $t2, $zero, $zero
    /* D39E8 800E31E8 2158C000 */  addu       $t3, $a2, $zero
    /* D39EC 800E31EC 8800A927 */  addiu      $t1, $sp, 0x88
    /* D39F0 800E31F0 1280033C */  lui        $v1, %hi(Weather_gRandomVelocityVectors)
    /* D39F4 800E31F4 E4336824 */  addiu      $t0, $v1, %lo(Weather_gRandomVelocityVectors)
    /* D39F8 800E31F8 7800A497 */  lhu        $a0, 0x78($sp)
    /* D39FC 800E31FC 7C00A597 */  lhu        $a1, 0x7C($sp)
    /* D3A00 800E3200 8000A697 */  lhu        $a2, 0x80($sp)
    /* D3A04 800E3204 6800A297 */  lhu        $v0, 0x68($sp)
    /* D3A08 800E3208 6C00A397 */  lhu        $v1, 0x6C($sp)
    /* D3A0C 800E320C 21104400 */  addu       $v0, $v0, $a0
    /* D3A10 800E3210 6800A2A7 */  sh         $v0, 0x68($sp)
    /* D3A14 800E3214 6A00A297 */  lhu        $v0, 0x6A($sp)
    /* D3A18 800E3218 21186600 */  addu       $v1, $v1, $a2
    /* D3A1C 800E321C 6000A4A7 */  sh         $a0, 0x60($sp)
    /* D3A20 800E3220 6200A5A7 */  sh         $a1, 0x62($sp)
    /* D3A24 800E3224 6400A6A7 */  sh         $a2, 0x64($sp)
    /* D3A28 800E3228 6C00A3A7 */  sh         $v1, 0x6C($sp)
    /* D3A2C 800E322C 21104500 */  addu       $v0, $v0, $a1
    /* D3A30 800E3230 6A00A2A7 */  sh         $v0, 0x6A($sp)
  .L800E3234:
    /* D3A34 800E3234 0C004229 */  slti       $v0, $t2, 0xC
    /* D3A38 800E3238 23004010 */  beqz       $v0, .L800E32C8
    /* D3A3C 800E323C 00000000 */   nop
    /* D3A40 800E3240 00000291 */  lbu        $v0, 0x0($t0)
    /* D3A44 800E3244 00000000 */  nop
    /* D3A48 800E3248 00160200 */  sll        $v0, $v0, 24
    /* D3A4C 800E324C 03160200 */  sra        $v0, $v0, 24
    /* D3A50 800E3250 7000A2A7 */  sh         $v0, 0x70($sp)
    /* D3A54 800E3254 01000291 */  lbu        $v0, 0x1($t0)
    /* D3A58 800E3258 00000000 */  nop
    /* D3A5C 800E325C 00160200 */  sll        $v0, $v0, 24
    /* D3A60 800E3260 03160200 */  sra        $v0, $v0, 24
    /* D3A64 800E3264 7200A2A7 */  sh         $v0, 0x72($sp)
    /* D3A68 800E3268 02000291 */  lbu        $v0, 0x2($t0)
    /* D3A6C 800E326C 00000000 */  nop
    /* D3A70 800E3270 00160200 */  sll        $v0, $v0, 24
    /* D3A74 800E3274 03160200 */  sra        $v0, $v0, 24
    /* D3A78 800E3278 7400A2A7 */  sh         $v0, 0x74($sp)
    /* D3A7C 800E327C 0000E0C8 */  lwc2       $0, 0x0($a3)
    /* D3A80 800E3280 0400E1C8 */  lwc2       $1, 0x4($a3)
    /* D3A84 800E3284 00000000 */  nop
    /* D3A88 800E3288 00000000 */  nop
    /* D3A8C 800E328C 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* D3A90 800E3290 000079E9 */  swc2       $25, 0x0($t3)
    /* D3A94 800E3294 04007AE9 */  swc2       $26, 0x4($t3) /* handwritten instruction */
    /* D3A98 800E3298 08007BE9 */  swc2       $27, 0x8($t3) /* handwritten instruction */
    /* D3A9C 800E329C 7800A297 */  lhu        $v0, 0x78($sp)
    /* D3AA0 800E32A0 00000000 */  nop
    /* D3AA4 800E32A4 000022A5 */  sh         $v0, 0x0($t1)
    /* D3AA8 800E32A8 7C00A297 */  lhu        $v0, 0x7C($sp)
    /* D3AAC 800E32AC 03000825 */  addiu      $t0, $t0, 0x3
    /* D3AB0 800E32B0 020022A5 */  sh         $v0, 0x2($t1)
    /* D3AB4 800E32B4 8000A297 */  lhu        $v0, 0x80($sp)
    /* D3AB8 800E32B8 01004A25 */  addiu      $t2, $t2, 0x1
    /* D3ABC 800E32BC 040022A5 */  sh         $v0, 0x4($t1)
    /* D3AC0 800E32C0 8D8C0308 */  j          .L800E3234
    /* D3AC4 800E32C4 08002925 */   addiu     $t1, $t1, 0x8
  .L800E32C8:
    /* D3AC8 800E32C8 2190A002 */  addu       $s2, $s5, $zero
    /* D3ACC 800E32CC 21800000 */  addu       $s0, $zero, $zero
    /* D3AD0 800E32D0 04005126 */  addiu      $s1, $s2, 0x4
  .L800E32D4:
    /* D3AD4 800E32D4 2A101402 */  slt        $v0, $s0, $s4
    /* D3AD8 800E32D8 2E004010 */  beqz       $v0, .L800E3394
    /* D3ADC 800E32DC AA2A023C */   lui       $v0, (0x2AAAAAAB >> 16)
    /* D3AE0 800E32E0 ABAA4234 */  ori        $v0, $v0, (0x2AAAAAAB & 0xFFFF)
    /* D3AE4 800E32E4 18000202 */  mult       $s0, $v0
    /* D3AE8 800E32E8 7000A427 */  addiu      $a0, $sp, 0x70
    /* D3AEC 800E32EC C3171000 */  sra        $v0, $s0, 31
    /* D3AF0 800E32F0 8800A627 */  addiu      $a2, $sp, 0x88
    /* D3AF4 800E32F4 6800A597 */  lhu        $a1, 0x68($sp)
    /* D3AF8 800E32F8 10600000 */  mfhi       $t4
    /* D3AFC 800E32FC 43180C00 */  sra        $v1, $t4, 1
    /* D3B00 800E3300 23186200 */  subu       $v1, $v1, $v0
    /* D3B04 800E3304 40100300 */  sll        $v0, $v1, 1
    /* D3B08 800E3308 21104300 */  addu       $v0, $v0, $v1
    /* D3B0C 800E330C 80100200 */  sll        $v0, $v0, 2
    /* D3B10 800E3310 23100202 */  subu       $v0, $s0, $v0
    /* D3B14 800E3314 C0100200 */  sll        $v0, $v0, 3
    /* D3B18 800E3318 2130C200 */  addu       $a2, $a2, $v0
    /* D3B1C 800E331C 00004396 */  lhu        $v1, 0x0($s2)
    /* D3B20 800E3320 0000C294 */  lhu        $v0, 0x0($a2)
    /* D3B24 800E3324 21186500 */  addu       $v1, $v1, $a1
    /* D3B28 800E3328 21104300 */  addu       $v0, $v0, $v1
    /* D3B2C 800E332C 7000A2A7 */  sh         $v0, 0x70($sp)
    /* D3B30 800E3330 FEFF2396 */  lhu        $v1, -0x2($s1)
    /* D3B34 800E3334 6A00A597 */  lhu        $a1, 0x6A($sp)
    /* D3B38 800E3338 0200C294 */  lhu        $v0, 0x2($a2)
    /* D3B3C 800E333C 21186500 */  addu       $v1, $v1, $a1
    /* D3B40 800E3340 21104300 */  addu       $v0, $v0, $v1
    /* D3B44 800E3344 7200A2A7 */  sh         $v0, 0x72($sp)
    /* D3B48 800E3348 00002396 */  lhu        $v1, 0x0($s1)
    /* D3B4C 800E334C 6C00A597 */  lhu        $a1, 0x6C($sp)
    /* D3B50 800E3350 0400C294 */  lhu        $v0, 0x4($a2)
    /* D3B54 800E3354 21186500 */  addu       $v1, $v1, $a1
    /* D3B58 800E3358 21104300 */  addu       $v0, $v0, $v1
    /* D3B5C 800E335C 758A030C */  jal        Weather_CheckAndResetParticles__FP7SVECTOR
    /* D3B60 800E3360 7400A2A7 */   sh        $v0, 0x74($sp)
    /* D3B64 800E3364 7000A38F */  lw         $v1, 0x70($sp)
    /* D3B68 800E3368 00140200 */  sll        $v0, $v0, 16
    /* D3B6C 800E336C 000043AE */  sw         $v1, 0x0($s2)
    /* D3B70 800E3370 7400A397 */  lhu        $v1, 0x74($sp)
    /* D3B74 800E3374 08005226 */  addiu      $s2, $s2, 0x8
    /* D3B78 800E3378 000023A6 */  sh         $v1, 0x0($s1)
    /* D3B7C 800E337C 03004010 */  beqz       $v0, .L800E338C
    /* D3B80 800E3380 08003126 */   addiu     $s1, $s1, 0x8
    /* D3B84 800E3384 2110D002 */  addu       $v0, $s6, $s0
    /* D3B88 800E3388 000040A0 */  sb         $zero, 0x0($v0)
  .L800E338C:
    /* D3B8C 800E338C B58C0308 */  j          .L800E32D4
    /* D3B90 800E3390 01001026 */   addiu     $s0, $s0, 0x1
  .L800E3394:
    /* D3B94 800E3394 0401BF8F */  lw         $ra, 0x104($sp)
    /* D3B98 800E3398 0001B68F */  lw         $s6, 0x100($sp)
    /* D3B9C 800E339C FC00B58F */  lw         $s5, 0xFC($sp)
    /* D3BA0 800E33A0 F800B48F */  lw         $s4, 0xF8($sp)
    /* D3BA4 800E33A4 F400B38F */  lw         $s3, 0xF4($sp)
    /* D3BA8 800E33A8 F000B28F */  lw         $s2, 0xF0($sp)
    /* D3BAC 800E33AC EC00B18F */  lw         $s1, 0xEC($sp)
    /* D3BB0 800E33B0 E800B08F */  lw         $s0, 0xE8($sp)
    /* D3BB4 800E33B4 0800E003 */  jr         $ra
    /* D3BB8 800E33B8 0801BD27 */   addiu     $sp, $sp, 0x108
endlabel Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc
