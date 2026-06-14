.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_SubmitObstacle__FP8Car_tObjiiii, 0x1A4

glabel AI_SubmitObstacle__FP8Car_tObjiiii
    /* 4A1E4 800599E4 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 4A1E8 800599E8 2400B1AF */  sw         $s1, 0x24($sp)
    /* 4A1EC 800599EC 21888000 */  addu       $s1, $a0, $zero
    /* 4A1F0 800599F0 2800B2AF */  sw         $s2, 0x28($sp)
    /* 4A1F4 800599F4 2190A000 */  addu       $s2, $a1, $zero
    /* 4A1F8 800599F8 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 4A1FC 800599FC 2198C000 */  addu       $s3, $a2, $zero
    /* 4A200 80059A00 3000B4AF */  sw         $s4, 0x30($sp)
    /* 4A204 80059A04 21A0E000 */  addu       $s4, $a3, $zero
    /* 4A208 80059A08 1000A427 */  addiu      $a0, $sp, 0x10
    /* 4A20C 80059A0C 21280000 */  addu       $a1, $zero, $zero
    /* 4A210 80059A10 2000B0AF */  sw         $s0, 0x20($sp)
    /* 4A214 80059A14 4800B08F */  lw         $s0, 0x48($sp)
    /* 4A218 80059A18 3400BFAF */  sw         $ra, 0x34($sp)
    /* 4A21C 80059A1C C690030C */  jal        memset
    /* 4A220 80059A20 0C000624 */   addiu     $a2, $zero, 0xC
    /* 4A224 80059A24 21286002 */  addu       $a1, $s3, $zero
    /* 4A228 80059A28 33CD010C */  jal        AIWorld_LaneIndex__Fii
    /* 4A22C 80059A2C 21200002 */   addu      $a0, $s0, $zero
    /* 4A230 80059A30 21200002 */  addu       $a0, $s0, $zero
    /* 4A234 80059A34 21288002 */  addu       $a1, $s4, $zero
    /* 4A238 80059A38 33CD010C */  jal        AIWorld_LaneIndex__Fii
    /* 4A23C 80059A3C 21804000 */   addu      $s0, $v0, $zero
    /* 4A240 80059A40 21204000 */  addu       $a0, $v0, $zero
    /* 4A244 80059A44 0E00822C */  sltiu      $v0, $a0, 0xE
    /* 4A248 80059A48 47004010 */  beqz       $v0, .L80059B68
    /* 4A24C 80059A4C 0E00022E */   sltiu     $v0, $s0, 0xE
    /* 4A250 80059A50 45004010 */  beqz       $v0, .L80059B68
    /* 4A254 80059A54 00000000 */   nop
    /* 4A258 80059A58 C406228E */  lw         $v0, 0x6C4($s1)
    /* 4A25C 80059A5C 00000000 */  nop
    /* 4A260 80059A60 FFFF4324 */  addiu      $v1, $v0, -0x1
    /* 4A264 80059A64 2A107000 */  slt        $v0, $v1, $s0
    /* 4A268 80059A68 04004014 */  bnez       $v0, .L80059A7C
    /* 4A26C 80059A6C 2A108300 */   slt       $v0, $a0, $v1
    /* 4A270 80059A70 02004014 */  bnez       $v0, .L80059A7C
    /* 4A274 80059A74 00000000 */   nop
    /* 4A278 80059A78 1000B2AF */  sw         $s2, 0x10($sp)
  .L80059A7C:
    /* 4A27C 80059A7C C406238E */  lw         $v1, 0x6C4($s1)
    /* 4A280 80059A80 00000000 */  nop
    /* 4A284 80059A84 2A107000 */  slt        $v0, $v1, $s0
    /* 4A288 80059A88 04004014 */  bnez       $v0, .L80059A9C
    /* 4A28C 80059A8C 2A108300 */   slt       $v0, $a0, $v1
    /* 4A290 80059A90 02004014 */  bnez       $v0, .L80059A9C
    /* 4A294 80059A94 00000000 */   nop
    /* 4A298 80059A98 1400B2AF */  sw         $s2, 0x14($sp)
  .L80059A9C:
    /* 4A29C 80059A9C C406228E */  lw         $v0, 0x6C4($s1)
    /* 4A2A0 80059AA0 00000000 */  nop
    /* 4A2A4 80059AA4 01004324 */  addiu      $v1, $v0, 0x1
    /* 4A2A8 80059AA8 2A107000 */  slt        $v0, $v1, $s0
    /* 4A2AC 80059AAC 04004014 */  bnez       $v0, .L80059AC0
    /* 4A2B0 80059AB0 2A108300 */   slt       $v0, $a0, $v1
    /* 4A2B4 80059AB4 02004014 */  bnez       $v0, .L80059AC0
    /* 4A2B8 80059AB8 00000000 */   nop
    /* 4A2BC 80059ABC 1800B2AF */  sw         $s2, 0x18($sp)
  .L80059AC0:
    /* 4A2C0 80059AC0 1000A28F */  lw         $v0, 0x10($sp)
    /* 4A2C4 80059AC4 00000000 */  nop
    /* 4A2C8 80059AC8 1A004010 */  beqz       $v0, .L80059B34
    /* 4A2CC 80059ACC 1180033C */   lui       $v1, %hi(CarLogic_gObs)
    /* 4A2D0 80059AD0 1400A28F */  lw         $v0, 0x14($sp)
    /* 4A2D4 80059AD4 00000000 */  nop
    /* 4A2D8 80059AD8 16004010 */  beqz       $v0, .L80059B34
    /* 4A2DC 80059ADC 00000000 */   nop
    /* 4A2E0 80059AE0 1800A28F */  lw         $v0, 0x18($sp)
    /* 4A2E4 80059AE4 00000000 */  nop
    /* 4A2E8 80059AE8 12004010 */  beqz       $v0, .L80059B34
    /* 4A2EC 80059AEC 00000000 */   nop
    /* 4A2F0 80059AF0 7405228E */  lw         $v0, 0x574($s1)
    /* 4A2F4 80059AF4 00000000 */  nop
    /* 4A2F8 80059AF8 23185300 */  subu       $v1, $v0, $s3
    /* 4A2FC 80059AFC 23105400 */  subu       $v0, $v0, $s4
    /* 4A300 80059B00 02006104 */  bgez       $v1, .L80059B0C
    /* 4A304 80059B04 00000000 */   nop
    /* 4A308 80059B08 23180300 */  negu       $v1, $v1
  .L80059B0C:
    /* 4A30C 80059B0C 02004104 */  bgez       $v0, .L80059B18
    /* 4A310 80059B10 00000000 */   nop
    /* 4A314 80059B14 23100200 */  negu       $v0, $v0
  .L80059B18:
    /* 4A318 80059B18 2A186200 */  slt        $v1, $v1, $v0
    /* 4A31C 80059B1C 03006010 */  beqz       $v1, .L80059B2C
    /* 4A320 80059B20 00000000 */   nop
    /* 4A324 80059B24 CC660108 */  j          .L80059B30
    /* 4A328 80059B28 1000A0AF */   sw        $zero, 0x10($sp)
  .L80059B2C:
    /* 4A32C 80059B2C 1800A0AF */  sw         $zero, 0x18($sp)
  .L80059B30:
    /* 4A330 80059B30 1180033C */  lui        $v1, %hi(CarLogic_gObs)
  .L80059B34:
    /* 4A334 80059B34 E4CC628C */  lw         $v0, %lo(CarLogic_gObs)($v1)
    /* 4A338 80059B38 1000A48F */  lw         $a0, 0x10($sp)
    /* 4A33C 80059B3C 1400A58F */  lw         $a1, 0x14($sp)
    /* 4A340 80059B40 1800A68F */  lw         $a2, 0x18($sp)
    /* 4A344 80059B44 21104400 */  addu       $v0, $v0, $a0
    /* 4A348 80059B48 E4CC62AC */  sw         $v0, %lo(CarLogic_gObs)($v1)
    /* 4A34C 80059B4C E4CC6324 */  addiu      $v1, $v1, %lo(CarLogic_gObs)
    /* 4A350 80059B50 0400628C */  lw         $v0, 0x4($v1)
    /* 4A354 80059B54 0800648C */  lw         $a0, 0x8($v1)
    /* 4A358 80059B58 21104500 */  addu       $v0, $v0, $a1
    /* 4A35C 80059B5C 21208600 */  addu       $a0, $a0, $a2
    /* 4A360 80059B60 040062AC */  sw         $v0, 0x4($v1)
    /* 4A364 80059B64 080064AC */  sw         $a0, 0x8($v1)
  .L80059B68:
    /* 4A368 80059B68 3400BF8F */  lw         $ra, 0x34($sp)
    /* 4A36C 80059B6C 3000B48F */  lw         $s4, 0x30($sp)
    /* 4A370 80059B70 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 4A374 80059B74 2800B28F */  lw         $s2, 0x28($sp)
    /* 4A378 80059B78 2400B18F */  lw         $s1, 0x24($sp)
    /* 4A37C 80059B7C 2000B08F */  lw         $s0, 0x20($sp)
    /* 4A380 80059B80 0800E003 */  jr         $ra
    /* 4A384 80059B84 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel AI_SubmitObstacle__FP8Car_tObjiiii
