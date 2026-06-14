.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_Randomize__Fv, 0x78

glabel Cars_Randomize__Fv
    /* 7B784 8008AF84 B002828F */  lw         $v0, %gp_rel(Cars_gNumAICars)($gp)
    /* 7B788 8008AF88 00000000 */  nop
    /* 7B78C 8008AF8C 19004010 */  beqz       $v0, .L8008AFF4
    /* 7B790 8008AF90 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* 7B794 8008AF94 48FA428C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v0)
    /* 7B798 8008AF98 00000000 */  nop
    /* 7B79C 8008AF9C 7405428C */  lw         $v0, 0x574($v0)
    /* 7B7A0 8008AFA0 00000000 */  nop
    /* 7B7A4 8008AFA4 00034230 */  andi       $v0, $v0, 0x300
    /* 7B7A8 8008AFA8 03220200 */  sra        $a0, $v0, 8
    /* 7B7AC 8008AFAC 11008010 */  beqz       $a0, .L8008AFF4
    /* 7B7B0 8008AFB0 21180000 */   addu      $v1, $zero, $zero
    /* 7B7B4 8008AFB4 1480053C */  lui        $a1, %hi(randSeed)
    /* 7B7B8 8008AFB8 04D1A58C */  lw         $a1, %lo(randSeed)($a1)
  .L8008AFBC:
    /* 7B7BC 8008AFBC 1480023C */  lui        $v0, %hi(fastRandom)
    /* 7B7C0 8008AFC0 FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 7B7C4 8008AFC4 00000000 */  nop
    /* 7B7C8 8008AFC8 18004500 */  mult       $v0, $a1
    /* 7B7CC 8008AFCC 01006324 */  addiu      $v1, $v1, 0x1
    /* 7B7D0 8008AFD0 12100000 */  mflo       $v0
    /* 7B7D4 8008AFD4 1480013C */  lui        $at, %hi(randtemp)
    /* 7B7D8 8008AFD8 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 7B7DC 8008AFDC FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 7B7E0 8008AFE0 1480013C */  lui        $at, %hi(fastRandom)
    /* 7B7E4 8008AFE4 FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 7B7E8 8008AFE8 2A106400 */  slt        $v0, $v1, $a0
    /* 7B7EC 8008AFEC F3FF4014 */  bnez       $v0, .L8008AFBC
    /* 7B7F0 8008AFF0 00000000 */   nop
  .L8008AFF4:
    /* 7B7F4 8008AFF4 0800E003 */  jr         $ra
    /* 7B7F8 8008AFF8 00000000 */   nop
endlabel Cars_Randomize__Fv
