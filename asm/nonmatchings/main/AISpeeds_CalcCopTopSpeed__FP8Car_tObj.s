.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_CalcCopTopSpeed__FP8Car_tObj, 0xC8

glabel AISpeeds_CalcCopTopSpeed__FP8Car_tObj
    /* 5F2A4 8006EAA4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5F2A8 8006EAA8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5F2AC 8006EAAC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5F2B0 8006EAB0 CDB7010C */  jal        AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj
    /* 5F2B4 8006EAB4 21808000 */   addu      $s0, $a0, $zero
    /* 5F2B8 8006EAB8 C806038E */  lw         $v1, 0x6C8($s0)
    /* 5F2BC 8006EABC 21204000 */  addu       $a0, $v0, $zero
    /* 5F2C0 8006EAC0 2A108300 */  slt        $v0, $a0, $v1
    /* 5F2C4 8006EAC4 02004010 */  beqz       $v0, .L8006EAD0
    /* 5F2C8 8006EAC8 00000000 */   nop
    /* 5F2CC 8006EACC 21188000 */  addu       $v1, $a0, $zero
  .L8006EAD0:
    /* 5F2D0 8006EAD0 21206000 */  addu       $a0, $v1, $zero
    /* 5F2D4 8006EAD4 6800838F */  lw         $v1, %gp_rel(D_8013C5B4)($gp)
    /* 5F2D8 8006EAD8 4007028E */  lw         $v0, 0x740($s0)
    /* 5F2DC 8006EADC 02006104 */  bgez       $v1, .L8006EAE8
    /* 5F2E0 8006EAE0 00000000 */   nop
    /* 5F2E4 8006EAE4 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8006EAE8:
    /* 5F2E8 8006EAE8 02004104 */  bgez       $v0, .L8006EAF4
    /* 5F2EC 8006EAEC 031A0300 */   sra       $v1, $v1, 8
    /* 5F2F0 8006EAF0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006EAF4:
    /* 5F2F4 8006EAF4 03120200 */  sra        $v0, $v0, 8
    /* 5F2F8 8006EAF8 18006200 */  mult       $v1, $v0
    /* 5F2FC 8006EAFC 0100053C */  lui        $a1, (0x10000 >> 16)
    /* 5F300 8006EB00 12180000 */  mflo       $v1
    /* 5F304 8006EB04 2A10A300 */  slt        $v0, $a1, $v1
    /* 5F308 8006EB08 03004010 */  beqz       $v0, .L8006EB18
    /* 5F30C 8006EB0C 300703AE */   sw        $v1, 0x730($s0)
    /* 5F310 8006EB10 C7BA0108 */  j          .L8006EB1C
    /* 5F314 8006EB14 940003AE */   sw        $v1, 0x94($s0)
  .L8006EB18:
    /* 5F318 8006EB18 940005AE */  sw         $a1, 0x94($s0)
  .L8006EB1C:
    /* 5F31C 8006EB1C 21108000 */  addu       $v0, $a0, $zero
    /* 5F320 8006EB20 02004104 */  bgez       $v0, .L8006EB2C
    /* 5F324 8006EB24 00000000 */   nop
    /* 5F328 8006EB28 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006EB2C:
    /* 5F32C 8006EB2C 3007038E */  lw         $v1, 0x730($s0)
    /* 5F330 8006EB30 00000000 */  nop
    /* 5F334 8006EB34 02006104 */  bgez       $v1, .L8006EB40
    /* 5F338 8006EB38 03220200 */   sra       $a0, $v0, 8
    /* 5F33C 8006EB3C FF006324 */  addiu      $v1, $v1, 0xFF
  .L8006EB40:
    /* 5F340 8006EB40 03120300 */  sra        $v0, $v1, 8
    /* 5F344 8006EB44 18008200 */  mult       $a0, $v0
    /* 5F348 8006EB48 12180000 */  mflo       $v1
    /* 5F34C 8006EB4C 5405028E */  lw         $v0, 0x554($s0)
    /* 5F350 8006EB50 00000000 */  nop
    /* 5F354 8006EB54 18006200 */  mult       $v1, $v0
    /* 5F358 8006EB58 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5F35C 8006EB5C 1000B08F */  lw         $s0, 0x10($sp)
    /* 5F360 8006EB60 12100000 */  mflo       $v0
    /* 5F364 8006EB64 0800E003 */  jr         $ra
    /* 5F368 8006EB68 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AISpeeds_CalcCopTopSpeed__FP8Car_tObj
