.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_CheckForSpikeBelts__FP13BO_tNewtonObj, 0xC4

glabel Newton_CheckForSpikeBelts__FP13BO_tNewtonObj
    /* 9322C 800A2A2C F0FFBD27 */  addiu      $sp, $sp, -0x10
    /* 93230 800A2A30 21288000 */  addu       $a1, $a0, $zero
    /* 93234 800A2A34 1180023C */  lui        $v0, %hi(AICop_spikeBelt)
    /* 93238 800A2A38 4CD5468C */  lw         $a2, %lo(AICop_spikeBelt)($v0)
    /* 9323C 800A2A3C 00000000 */  nop
    /* 93240 800A2A40 2900C010 */  beqz       $a2, .L800A2AE8
    /* 93244 800A2A44 4CD54424 */   addiu     $a0, $v0, %lo(AICop_spikeBelt)
    /* 93248 800A2A48 0400828C */  lw         $v0, 0x4($a0)
    /* 9324C 800A2A4C 0800838C */  lw         $v1, 0x8($a0)
    /* 93250 800A2A50 0C00848C */  lw         $a0, 0xC($a0)
    /* 93254 800A2A54 0000A2AF */  sw         $v0, 0x0($sp)
    /* 93258 800A2A58 0400A3AF */  sw         $v1, 0x4($sp)
    /* 9325C 800A2A5C 2200C010 */  beqz       $a2, .L800A2AE8
    /* 93260 800A2A60 0800A4AF */   sw        $a0, 0x8($sp)
    /* 93264 800A2A64 0800A384 */  lh         $v1, 0x8($a1)
    /* 93268 800A2A68 00000000 */  nop
    /* 9326C 800A2A6C 1E006214 */  bne        $v1, $v0, .L800A2AE8
    /* 93270 800A2A70 00000000 */   nop
    /* 93274 800A2A74 6002A28C */  lw         $v0, 0x260($a1)
    /* 93278 800A2A78 7405A38C */  lw         $v1, 0x574($a1)
    /* 9327C 800A2A7C 30024230 */  andi       $v0, $v0, 0x230
    /* 93280 800A2A80 19004014 */  bnez       $v0, .L800A2AE8
    /* 93284 800A2A84 00000000 */   nop
    /* 93288 800A2A88 0400A28F */  lw         $v0, 0x4($sp)
    /* 9328C 800A2A8C 00000000 */  nop
    /* 93290 800A2A90 2A104300 */  slt        $v0, $v0, $v1
    /* 93294 800A2A94 14004010 */  beqz       $v0, .L800A2AE8
    /* 93298 800A2A98 21108000 */   addu      $v0, $a0, $zero
    /* 9329C 800A2A9C 2A106200 */  slt        $v0, $v1, $v0
    /* 932A0 800A2AA0 11004010 */  beqz       $v0, .L800A2AE8
    /* 932A4 800A2AA4 01000324 */   addiu     $v1, $zero, 0x1
    /* 932A8 800A2AA8 7402A28C */  lw         $v0, 0x274($a1)
    /* 932AC 800A2AAC 00000000 */  nop
    /* 932B0 800A2AB0 01004224 */  addiu      $v0, $v0, 0x1
    /* 932B4 800A2AB4 0C004314 */  bne        $v0, $v1, .L800A2AE8
    /* 932B8 800A2AB8 7402A2AC */   sw        $v0, 0x274($a1)
    /* 932BC 800A2ABC 0500033C */  lui        $v1, (0x50007 >> 16)
    /* 932C0 800A2AC0 07006334 */  ori        $v1, $v1, (0x50007 & 0xFFFF)
    /* 932C4 800A2AC4 0F00023C */  lui        $v0, (0xF0000 >> 16)
    /* 932C8 800A2AC8 9001A2AC */  sw         $v0, 0x190($a1)
    /* 932CC 800A2ACC 9801A3AC */  sw         $v1, 0x198($a1)
    /* 932D0 800A2AD0 A000A78C */  lw         $a3, 0xA0($a1)
    /* 932D4 800A2AD4 A400A88C */  lw         $t0, 0xA4($a1)
    /* 932D8 800A2AD8 A800A98C */  lw         $t1, 0xA8($a1)
    /* 932DC 800A2ADC A001A7AC */  sw         $a3, 0x1A0($a1)
    /* 932E0 800A2AE0 A401A8AC */  sw         $t0, 0x1A4($a1)
    /* 932E4 800A2AE4 A801A9AC */  sw         $t1, 0x1A8($a1)
  .L800A2AE8:
    /* 932E8 800A2AE8 0800E003 */  jr         $ra
    /* 932EC 800A2AEC 1000BD27 */   addiu     $sp, $sp, 0x10
endlabel Newton_CheckForSpikeBelts__FP13BO_tNewtonObj
