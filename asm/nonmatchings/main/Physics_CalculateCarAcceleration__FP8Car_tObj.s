.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_CalculateCarAcceleration__FP8Car_tObj, 0xB18

glabel Physics_CalculateCarAcceleration__FP8Car_tObj
    /* 9B184 800AA984 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* 9B188 800AA988 5400B1AF */  sw         $s1, 0x54($sp)
    /* 9B18C 800AA98C 21888000 */  addu       $s1, $a0, $zero
    /* 9B190 800AA990 0580023C */  lui        $v0, %hi(D_80056370)
    /* 9B194 800AA994 7400BFAF */  sw         $ra, 0x74($sp)
    /* 9B198 800AA998 7000BEAF */  sw         $fp, 0x70($sp)
    /* 9B19C 800AA99C 6C00B7AF */  sw         $s7, 0x6C($sp)
    /* 9B1A0 800AA9A0 6800B6AF */  sw         $s6, 0x68($sp)
    /* 9B1A4 800AA9A4 6400B5AF */  sw         $s5, 0x64($sp)
    /* 9B1A8 800AA9A8 6000B4AF */  sw         $s4, 0x60($sp)
    /* 9B1AC 800AA9AC 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* 9B1B0 800AA9B0 5800B2AF */  sw         $s2, 0x58($sp)
    /* 9B1B4 800AA9B4 5000B0AF */  sw         $s0, 0x50($sp)
    /* 9B1B8 800AA9B8 70634924 */  addiu      $t1, $v0, %lo(D_80056370)
    /* 9B1BC 800AA9BC 0000268D */  lw         $a2, 0x0($t1)
    /* 9B1C0 800AA9C0 0400278D */  lw         $a3, 0x4($t1)
    /* 9B1C4 800AA9C4 0800288D */  lw         $t0, 0x8($t1)
    /* 9B1C8 800AA9C8 1000A6AF */  sw         $a2, 0x10($sp)
    /* 9B1CC 800AA9CC 1400A7AF */  sw         $a3, 0x14($sp)
    /* 9B1D0 800AA9D0 1800A8AF */  sw         $t0, 0x18($sp)
    /* 9B1D4 800AA9D4 0C00268D */  lw         $a2, 0xC($t1)
    /* 9B1D8 800AA9D8 1000278D */  lw         $a3, 0x10($t1)
    /* 9B1DC 800AA9DC 1400288D */  lw         $t0, 0x14($t1)
    /* 9B1E0 800AA9E0 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 9B1E4 800AA9E4 2000A7AF */  sw         $a3, 0x20($sp)
    /* 9B1E8 800AA9E8 2400A8AF */  sw         $t0, 0x24($sp)
    /* 9B1EC 800AA9EC 1800268D */  lw         $a2, 0x18($t1)
    /* 9B1F0 800AA9F0 1C00278D */  lw         $a3, 0x1C($t1)
    /* 9B1F4 800AA9F4 2800A6AF */  sw         $a2, 0x28($sp)
    /* 9B1F8 800AA9F8 2C00A7AF */  sw         $a3, 0x2C($sp)
    /* 9B1FC 800AA9FC 0580023C */  lui        $v0, %hi(D_80056390)
    /* 9B200 800AAA00 90634924 */  addiu      $t1, $v0, %lo(D_80056390)
    /* 9B204 800AAA04 0000268D */  lw         $a2, 0x0($t1)
    /* 9B208 800AAA08 0400278D */  lw         $a3, 0x4($t1)
    /* 9B20C 800AAA0C 0800288D */  lw         $t0, 0x8($t1)
    /* 9B210 800AAA10 3000A6AF */  sw         $a2, 0x30($sp)
    /* 9B214 800AAA14 3400A7AF */  sw         $a3, 0x34($sp)
    /* 9B218 800AAA18 3800A8AF */  sw         $t0, 0x38($sp)
    /* 9B21C 800AAA1C 0C00268D */  lw         $a2, 0xC($t1)
    /* 9B220 800AAA20 1000278D */  lw         $a3, 0x10($t1)
    /* 9B224 800AAA24 1400288D */  lw         $t0, 0x14($t1)
    /* 9B228 800AAA28 3C00A6AF */  sw         $a2, 0x3C($sp)
    /* 9B22C 800AAA2C 4000A7AF */  sw         $a3, 0x40($sp)
    /* 9B230 800AAA30 4400A8AF */  sw         $t0, 0x44($sp)
    /* 9B234 800AAA34 1800268D */  lw         $a2, 0x18($t1)
    /* 9B238 800AAA38 1C00278D */  lw         $a3, 0x1C($t1)
    /* 9B23C 800AAA3C 4800A6AF */  sw         $a2, 0x48($sp)
    /* 9B240 800AAA40 4C00A7AF */  sw         $a3, 0x4C($sp)
    /* 9B244 800AAA44 6404228E */  lw         $v0, 0x464($s1)
    /* 9B248 800AAA48 00000000 */  nop
    /* 9B24C 800AAA4C F000458C */  lw         $a1, 0xF0($v0)
    /* 9B250 800AAA50 00000000 */  nop
    /* 9B254 800AAA54 0200A104 */  bgez       $a1, .L800AAA60
    /* 9B258 800AAA58 21A00000 */   addu      $s4, $zero, $zero
    /* 9B25C 800AAA5C 0700A524 */  addiu      $a1, $a1, 0x7
  .L800AAA60:
    /* 9B260 800AAA60 1480023C */  lui        $v0, %hi(fastRandom)
    /* 9B264 800AAA64 FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 9B268 800AAA68 1480033C */  lui        $v1, %hi(randSeed)
    /* 9B26C 800AAA6C 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 9B270 800AAA70 00000000 */  nop
    /* 9B274 800AAA74 18004300 */  mult       $v0, $v1
    /* 9B278 800AAA78 21B80000 */  addu       $s7, $zero, $zero
    /* 9B27C 800AAA7C 1C02248E */  lw         $a0, 0x21C($s1)
    /* 9B280 800AAA80 2C02238E */  lw         $v1, 0x22C($s1)
    /* 9B284 800AAA84 C3F00500 */  sra        $fp, $a1, 3
    /* 9B288 800AAA88 21208300 */  addu       $a0, $a0, $v1
    /* 9B28C 800AAA8C 12100000 */  mflo       $v0
    /* 9B290 800AAA90 FFFF4330 */  andi       $v1, $v0, 0xFFFF
    /* 9B294 800AAA94 1480013C */  lui        $at, %hi(randtemp)
    /* 9B298 800AAA98 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 9B29C 800AAA9C 02120200 */  srl        $v0, $v0, 8
    /* 9B2A0 800AAAA0 1480013C */  lui        $at, %hi(fastRandom)
    /* 9B2A4 800AAAA4 FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 9B2A8 800AAAA8 02008104 */  bgez       $a0, .L800AAAB4
    /* 9B2AC 800AAAAC FFFF4330 */   andi      $v1, $v0, 0xFFFF
    /* 9B2B0 800AAAB0 FF008424 */  addiu      $a0, $a0, 0xFF
  .L800AAAB4:
    /* 9B2B4 800AAAB4 03120400 */  sra        $v0, $a0, 8
    /* 9B2B8 800AAAB8 2B106200 */  sltu       $v0, $v1, $v0
    /* 9B2BC 800AAABC 02004010 */  beqz       $v0, .L800AAAC8
    /* 9B2C0 800AAAC0 00000000 */   nop
    /* 9B2C4 800AAAC4 01001724 */  addiu      $s7, $zero, 0x1
  .L800AAAC8:
    /* 9B2C8 800AAAC8 6404328E */  lw         $s2, 0x464($s1)
    /* 9B2CC 800AAACC 6804238E */  lw         $v1, 0x468($s1)
    /* 9B2D0 800AAAD0 F000428E */  lw         $v0, 0xF0($s2)
    /* 9B2D4 800AAAD4 B40D80AF */  sw         $zero, %gp_rel(exceedRedline)($gp)
    /* 9B2D8 800AAAD8 F4014224 */  addiu      $v0, $v0, 0x1F4
    /* 9B2DC 800AAADC 2A104300 */  slt        $v0, $v0, $v1
    /* 9B2E0 800AAAE0 02004010 */  beqz       $v0, .L800AAAEC
    /* 9B2E4 800AAAE4 01000224 */   addiu     $v0, $zero, 0x1
    /* 9B2E8 800AAAE8 B40D82AF */  sw         $v0, %gp_rel(exceedRedline)($gp)
  .L800AAAEC:
    /* 9B2EC 800AAAEC 8802228E */  lw         $v0, 0x288($s1)
    /* 9B2F0 800AAAF0 00000000 */  nop
    /* 9B2F4 800AAAF4 4400428C */  lw         $v0, 0x44($v0)
    /* 9B2F8 800AAAF8 00000000 */  nop
    /* 9B2FC 800AAAFC 0C004010 */  beqz       $v0, .L800AAB30
    /* 9B300 800AAB00 0100163C */   lui       $s6, (0x10000 >> 16)
    /* 9B304 800AAB04 6404238E */  lw         $v1, 0x464($s1)
    /* 9B308 800AAB08 00000000 */  nop
    /* 9B30C 800AAB0C 1801628C */  lw         $v0, 0x118($v1)
    /* 9B310 800AAB10 1C01638C */  lw         $v1, 0x11C($v1)
    /* 9B314 800AAB14 00000000 */  nop
    /* 9B318 800AAB18 21104300 */  addu       $v0, $v0, $v1
    /* 9B31C 800AAB1C C21F0200 */  srl        $v1, $v0, 31
    /* 9B320 800AAB20 21104300 */  addu       $v0, $v0, $v1
    /* 9B324 800AAB24 43100200 */  sra        $v0, $v0, 1
    /* 9B328 800AAB28 0100033C */  lui        $v1, (0x10000 >> 16)
    /* 9B32C 800AAB2C 21B04300 */  addu       $s6, $v0, $v1
  .L800AAB30:
    /* 9B330 800AAB30 2004248E */  lw         $a0, 0x420($s1)
    /* 9B334 800AAB34 CA90030C */  jal        fixedmult
    /* 9B338 800AAB38 2128C002 */   addu      $a1, $s6, $zero
    /* 9B33C 800AAB3C 21B04000 */  addu       $s6, $v0, $zero
    /* 9B340 800AAB40 0300C106 */  bgez       $s6, .L800AAB50
    /* 9B344 800AAB44 2128C002 */   addu      $a1, $s6, $zero
    /* 9B348 800AAB48 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 9B34C 800AAB4C 2128C202 */  addu       $a1, $s6, $v0
  .L800AAB50:
    /* 9B350 800AAB50 032C0500 */  sra        $a1, $a1, 16
    /* 9B354 800AAB54 1800A500 */  mult       $a1, $a1
    /* 9B358 800AAB58 12180000 */  mflo       $v1
    /* 9B35C 800AAB5C 00000000 */  nop
    /* 9B360 800AAB60 00000000 */  nop
    /* 9B364 800AAB64 18006500 */  mult       $v1, $a1
    /* 9B368 800AAB68 C001448E */  lw         $a0, 0x1C0($s2)
    /* 9B36C 800AAB6C 12280000 */  mflo       $a1
    /* 9B370 800AAB70 CA90030C */  jal        fixedmult
    /* 9B374 800AAB74 00000000 */   nop
    /* 9B378 800AAB78 21B04000 */  addu       $s6, $v0, $zero
    /* 9B37C 800AAB7C 42042392 */  lbu        $v1, 0x442($s1)
    /* 9B380 800AAB80 01000224 */  addiu      $v0, $zero, 0x1
    /* 9B384 800AAB84 05006210 */  beq        $v1, $v0, .L800AAB9C
    /* 9B388 800AAB88 00000000 */   nop
    /* 9B38C 800AAB8C D40D828F */  lw         $v0, %gp_rel(powerControl)($gp)
    /* 9B390 800AAB90 00000000 */  nop
    /* 9B394 800AAB94 10004014 */  bnez       $v0, .L800AABD8
    /* 9B398 800AAB98 00000000 */   nop
  .L800AAB9C:
    /* 9B39C 800AAB9C F000508E */  lw         $s0, 0xF0($s2)
    /* 9B3A0 800AABA0 A80D858F */  lw         $a1, %gp_rel(gGasRatio)($gp)
    /* 9B3A4 800AABA4 FA001026 */  addiu      $s0, $s0, 0xFA
    /* 9B3A8 800AABA8 CA90030C */  jal        fixedmult
    /* 9B3AC 800AABAC 21200002 */   addu      $a0, $s0, $zero
    /* 9B3B0 800AABB0 2A105000 */  slt        $v0, $v0, $s0
    /* 9B3B4 800AABB4 04004014 */  bnez       $v0, .L800AABC8
    /* 9B3B8 800AABB8 00000000 */   nop
    /* 9B3BC 800AABBC F000428E */  lw         $v0, 0xF0($s2)
    /* 9B3C0 800AABC0 07AB0208 */  j          .L800AAC1C
    /* 9B3C4 800AABC4 FA005024 */   addiu     $s0, $v0, 0xFA
  .L800AABC8:
    /* 9B3C8 800AABC8 F000448E */  lw         $a0, 0xF0($s2)
    /* 9B3CC 800AABCC A80D858F */  lw         $a1, %gp_rel(gGasRatio)($gp)
    /* 9B3D0 800AABD0 04AB0208 */  j          .L800AAC10
    /* 9B3D4 800AABD4 FA008424 */   addiu     $a0, $a0, 0xFA
  .L800AABD8:
    /* 9B3D8 800AABD8 F000508E */  lw         $s0, 0xF0($s2)
    /* 9B3DC 800AABDC A80D858F */  lw         $a1, %gp_rel(gGasRatio)($gp)
    /* 9B3E0 800AABE0 64001026 */  addiu      $s0, $s0, 0x64
    /* 9B3E4 800AABE4 CA90030C */  jal        fixedmult
    /* 9B3E8 800AABE8 21200002 */   addu      $a0, $s0, $zero
    /* 9B3EC 800AABEC 2A105000 */  slt        $v0, $v0, $s0
    /* 9B3F0 800AABF0 04004014 */  bnez       $v0, .L800AAC04
    /* 9B3F4 800AABF4 00000000 */   nop
    /* 9B3F8 800AABF8 F000428E */  lw         $v0, 0xF0($s2)
    /* 9B3FC 800AABFC 07AB0208 */  j          .L800AAC1C
    /* 9B400 800AAC00 64005024 */   addiu     $s0, $v0, 0x64
  .L800AAC04:
    /* 9B404 800AAC04 F000448E */  lw         $a0, 0xF0($s2)
    /* 9B408 800AAC08 A80D858F */  lw         $a1, %gp_rel(gGasRatio)($gp)
    /* 9B40C 800AAC0C 64008424 */  addiu      $a0, $a0, 0x64
  .L800AAC10:
    /* 9B410 800AAC10 CA90030C */  jal        fixedmult
    /* 9B414 800AAC14 00000000 */   nop
    /* 9B418 800AAC18 21804000 */  addu       $s0, $v0, $zero
  .L800AAC1C:
    /* 9B41C 800AAC1C 6804228E */  lw         $v0, 0x468($s1)
    /* 9B420 800AAC20 F000438E */  lw         $v1, 0xF0($s2)
    /* 9B424 800AAC24 00000000 */  nop
    /* 9B428 800AAC28 2A104300 */  slt        $v0, $v0, $v1
    /* 9B42C 800AAC2C 0C004014 */  bnez       $v0, .L800AAC60
    /* 9B430 800AAC30 32006224 */   addiu     $v0, $v1, 0x32
    /* 9B434 800AAC34 42042392 */  lbu        $v1, 0x442($s1)
    /* 9B438 800AAC38 680422AE */  sw         $v0, 0x468($s1)
    /* 9B43C 800AAC3C 01000224 */  addiu      $v0, $zero, 0x1
    /* 9B440 800AAC40 06006210 */  beq        $v1, $v0, .L800AAC5C
    /* 9B444 800AAC44 03000224 */   addiu     $v0, $zero, 0x3
    /* 9B448 800AAC48 D40D828F */  lw         $v0, %gp_rel(powerControl)($gp)
    /* 9B44C 800AAC4C 00000000 */  nop
    /* 9B450 800AAC50 02004014 */  bnez       $v0, .L800AAC5C
    /* 9B454 800AAC54 04000224 */   addiu     $v0, $zero, 0x4
    /* 9B458 800AAC58 03000224 */  addiu      $v0, $zero, 0x3
  .L800AAC5C:
    /* 9B45C 800AAC5C 7C0222AE */  sw         $v0, 0x27C($s1)
  .L800AAC60:
    /* 9B460 800AAC60 7C02228E */  lw         $v0, 0x27C($s1)
    /* 9B464 800AAC64 00000000 */  nop
    /* 9B468 800AAC68 19004018 */  blez       $v0, .L800AACD0
    /* 9B46C 800AAC6C 01000224 */   addiu     $v0, $zero, 0x1
    /* 9B470 800AAC70 42042392 */  lbu        $v1, 0x442($s1)
    /* 9B474 800AAC74 00000000 */  nop
    /* 9B478 800AAC78 05006210 */  beq        $v1, $v0, .L800AAC90
    /* 9B47C 800AAC7C 00000000 */   nop
    /* 9B480 800AAC80 D40D828F */  lw         $v0, %gp_rel(powerControl)($gp)
    /* 9B484 800AAC84 00000000 */  nop
    /* 9B488 800AAC88 04004014 */  bnez       $v0, .L800AAC9C
    /* 9B48C 800AAC8C 00000000 */   nop
  .L800AAC90:
    /* 9B490 800AAC90 F000428E */  lw         $v0, 0xF0($s2)
    /* 9B494 800AAC94 2AAB0208 */  j          .L800AACA8
    /* 9B498 800AAC98 E0FC4224 */   addiu     $v0, $v0, -0x320
  .L800AAC9C:
    /* 9B49C 800AAC9C F000428E */  lw         $v0, 0xF0($s2)
    /* 9B4A0 800AACA0 00000000 */  nop
    /* 9B4A4 800AACA4 70FE4224 */  addiu      $v0, $v0, -0x190
  .L800AACA8:
    /* 9B4A8 800AACA8 21184000 */  addu       $v1, $v0, $zero
    /* 9B4AC 800AACAC 2A107000 */  slt        $v0, $v1, $s0
    /* 9B4B0 800AACB0 02004014 */  bnez       $v0, .L800AACBC
    /* 9B4B4 800AACB4 00000000 */   nop
    /* 9B4B8 800AACB8 21180002 */  addu       $v1, $s0, $zero
  .L800AACBC:
    /* 9B4BC 800AACBC 21806000 */  addu       $s0, $v1, $zero
    /* 9B4C0 800AACC0 7C02228E */  lw         $v0, 0x27C($s1)
    /* 9B4C4 800AACC4 00000000 */  nop
    /* 9B4C8 800AACC8 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 9B4CC 800AACCC 7C0222AE */  sw         $v0, 0x27C($s1)
  .L800AACD0:
    /* 9B4D0 800AACD0 42042292 */  lbu        $v0, 0x442($s1)
    /* 9B4D4 800AACD4 01000524 */  addiu      $a1, $zero, 0x1
    /* 9B4D8 800AACD8 09004510 */  beq        $v0, $a1, .L800AAD00
    /* 9B4DC 800AACDC 00000000 */   nop
    /* 9B4E0 800AACE0 44042292 */  lbu        $v0, 0x444($s1)
    /* 9B4E4 800AACE4 00000000 */  nop
    /* 9B4E8 800AACE8 05004014 */  bnez       $v0, .L800AAD00
    /* 9B4EC 800AACEC 00000000 */   nop
    /* 9B4F0 800AACF0 D40D828F */  lw         $v0, %gp_rel(powerControl)($gp)
    /* 9B4F4 800AACF4 00000000 */  nop
    /* 9B4F8 800AACF8 62004014 */  bnez       $v0, .L800AAE84
    /* 9B4FC 800AACFC 1180043C */   lui       $a0, %hi(GameSetup_gData)
  .L800AAD00:
    /* 9B500 800AAD00 0600E012 */  beqz       $s7, .L800AAD1C
    /* 9B504 800AAD04 00000000 */   nop
    /* 9B508 800AAD08 6804228E */  lw         $v0, 0x468($s1)
    /* 9B50C 800AAD0C 00000000 */  nop
    /* 9B510 800AAD10 9CFF4224 */  addiu      $v0, $v0, -0x64
    /* 9B514 800AAD14 8DAB0208 */  j          .L800AAE34
    /* 9B518 800AAD18 680422AE */   sw        $v0, 0x468($s1)
  .L800AAD1C:
    /* 9B51C 800AAD1C 6804238E */  lw         $v1, 0x468($s1)
    /* 9B520 800AAD20 00000000 */  nop
    /* 9B524 800AAD24 2A107000 */  slt        $v0, $v1, $s0
    /* 9B528 800AAD28 0B004010 */  beqz       $v0, .L800AAD58
    /* 9B52C 800AAD2C 00000000 */   nop
    /* 9B530 800AAD30 44042292 */  lbu        $v0, 0x444($s1)
    /* 9B534 800AAD34 00000000 */  nop
    /* 9B538 800AAD38 0B004014 */  bnez       $v0, .L800AAD68
    /* 9B53C 800AAD3C FA006424 */   addiu     $a0, $v1, 0xFA
    /* 9B540 800AAD40 21180002 */  addu       $v1, $s0, $zero
    /* 9B544 800AAD44 2A106400 */  slt        $v0, $v1, $a0
    /* 9B548 800AAD48 4A004014 */  bnez       $v0, .L800AAE74
    /* 9B54C 800AAD4C 680424AE */   sw        $a0, 0x468($s1)
    /* 9B550 800AAD50 9DAB0208 */  j          .L800AAE74
    /* 9B554 800AAD54 21188000 */   addu      $v1, $a0, $zero
  .L800AAD58:
    /* 9B558 800AAD58 44042292 */  lbu        $v0, 0x444($s1)
    /* 9B55C 800AAD5C 00000000 */  nop
    /* 9B560 800AAD60 3A004010 */  beqz       $v0, .L800AAE4C
    /* 9B564 800AAD64 00000000 */   nop
  .L800AAD68:
    /* 9B568 800AAD68 41042392 */  lbu        $v1, 0x441($s1)
    /* 9B56C 800AAD6C 01000224 */  addiu      $v0, $zero, 0x1
    /* 9B570 800AAD70 36006210 */  beq        $v1, $v0, .L800AAE4C
    /* 9B574 800AAD74 00000000 */   nop
    /* 9B578 800AAD78 43042292 */  lbu        $v0, 0x443($s1)
    /* 9B57C 800AAD7C 00000000 */  nop
    /* 9B580 800AAD80 1F004010 */  beqz       $v0, .L800AAE00
    /* 9B584 800AAD84 00000000 */   nop
    /* 9B588 800AAD88 40042292 */  lbu        $v0, 0x440($s1)
    /* 9B58C 800AAD8C 00000000 */  nop
    /* 9B590 800AAD90 4100422C */  sltiu      $v0, $v0, 0x41
    /* 9B594 800AAD94 09004014 */  bnez       $v0, .L800AADBC
    /* 9B598 800AAD98 00000000 */   nop
    /* 9B59C 800AAD9C 3E042292 */  lbu        $v0, 0x43E($s1)
    /* 9B5A0 800AADA0 00000000 */  nop
    /* 9B5A4 800AADA4 80100200 */  sll        $v0, $v0, 2
    /* 9B5A8 800AADA8 2118A203 */  addu       $v1, $sp, $v0
    /* 9B5AC 800AADAC 6804228E */  lw         $v0, 0x468($s1)
    /* 9B5B0 800AADB0 3000638C */  lw         $v1, 0x30($v1)
    /* 9B5B4 800AADB4 77AB0208 */  j          .L800AADDC
    /* 9B5B8 800AADB8 21104300 */   addu      $v0, $v0, $v1
  .L800AADBC:
    /* 9B5BC 800AADBC 3E042292 */  lbu        $v0, 0x43E($s1)
    /* 9B5C0 800AADC0 00000000 */  nop
    /* 9B5C4 800AADC4 80100200 */  sll        $v0, $v0, 2
    /* 9B5C8 800AADC8 2118A203 */  addu       $v1, $sp, $v0
    /* 9B5CC 800AADCC 6804228E */  lw         $v0, 0x468($s1)
    /* 9B5D0 800AADD0 1000638C */  lw         $v1, 0x10($v1)
    /* 9B5D4 800AADD4 00000000 */  nop
    /* 9B5D8 800AADD8 21104300 */  addu       $v0, $v0, $v1
  .L800AADDC:
    /* 9B5DC 800AADDC 680422AE */  sw         $v0, 0x468($s1)
    /* 9B5E0 800AADE0 F000428E */  lw         $v0, 0xF0($s2)
    /* 9B5E4 800AADE4 6804248E */  lw         $a0, 0x468($s1)
    /* 9B5E8 800AADE8 21184000 */  addu       $v1, $v0, $zero
    /* 9B5EC 800AADEC 2A106400 */  slt        $v0, $v1, $a0
    /* 9B5F0 800AADF0 20004014 */  bnez       $v0, .L800AAE74
    /* 9B5F4 800AADF4 00000000 */   nop
    /* 9B5F8 800AADF8 9DAB0208 */  j          .L800AAE74
    /* 9B5FC 800AADFC 21188000 */   addu      $v1, $a0, $zero
  .L800AAE00:
    /* 9B600 800AAE00 42042292 */  lbu        $v0, 0x442($s1)
    /* 9B604 800AAE04 00000000 */  nop
    /* 9B608 800AAE08 0400422C */  sltiu      $v0, $v0, 0x4
    /* 9B60C 800AAE0C 04004014 */  bnez       $v0, .L800AAE20
    /* 9B610 800AAE10 00000000 */   nop
    /* 9B614 800AAE14 6804228E */  lw         $v0, 0x468($s1)
    /* 9B618 800AAE18 8BAB0208 */  j          .L800AAE2C
    /* 9B61C 800AAE1C 38FF4224 */   addiu     $v0, $v0, -0xC8
  .L800AAE20:
    /* 9B620 800AAE20 6804228E */  lw         $v0, 0x468($s1)
    /* 9B624 800AAE24 00000000 */  nop
    /* 9B628 800AAE28 9CFF4224 */  addiu      $v0, $v0, -0x64
  .L800AAE2C:
    /* 9B62C 800AAE2C 680422AE */  sw         $v0, 0x468($s1)
    /* 9B630 800AAE30 6804228E */  lw         $v0, 0x468($s1)
  .L800AAE34:
    /* 9B634 800AAE34 00000000 */  nop
    /* 9B638 800AAE38 02004104 */  bgez       $v0, .L800AAE44
    /* 9B63C 800AAE3C 00000000 */   nop
    /* 9B640 800AAE40 21100000 */  addu       $v0, $zero, $zero
  .L800AAE44:
    /* 9B644 800AAE44 9EAB0208 */  j          .L800AAE78
    /* 9B648 800AAE48 680422AE */   sw        $v0, 0x468($s1)
  .L800AAE4C:
    /* 9B64C 800AAE4C 6804238E */  lw         $v1, 0x468($s1)
    /* 9B650 800AAE50 00000000 */  nop
    /* 9B654 800AAE54 2A107000 */  slt        $v0, $v1, $s0
    /* 9B658 800AAE58 07004014 */  bnez       $v0, .L800AAE78
    /* 9B65C 800AAE5C 38FF6424 */   addiu     $a0, $v1, -0xC8
    /* 9B660 800AAE60 21180002 */  addu       $v1, $s0, $zero
    /* 9B664 800AAE64 2A106400 */  slt        $v0, $v1, $a0
    /* 9B668 800AAE68 02004010 */  beqz       $v0, .L800AAE74
    /* 9B66C 800AAE6C 680424AE */   sw        $a0, 0x468($s1)
    /* 9B670 800AAE70 21188000 */  addu       $v1, $a0, $zero
  .L800AAE74:
    /* 9B674 800AAE74 680423AE */  sw         $v1, 0x468($s1)
  .L800AAE78:
    /* 9B678 800AAE78 700420AE */  sw         $zero, 0x470($s1)
    /* 9B67C 800AAE7C 06AD0208 */  j          .L800AB418
    /* 9B680 800AAE80 6C0420AE */   sw        $zero, 0x46C($s1)
  .L800AAE84:
    /* 9B684 800AAE84 5402228E */  lw         $v0, 0x254($s1)
    /* 9B688 800AAE88 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* 9B68C 800AAE8C 40180200 */  sll        $v1, $v0, 1
    /* 9B690 800AAE90 21186200 */  addu       $v1, $v1, $v0
    /* 9B694 800AAE94 00110300 */  sll        $v0, $v1, 4
    /* 9B698 800AAE98 23104300 */  subu       $v0, $v0, $v1
    /* 9B69C 800AAE9C 80100200 */  sll        $v0, $v0, 2
    /* 9B6A0 800AAEA0 21104400 */  addu       $v0, $v0, $a0
    /* 9B6A4 800AAEA4 DC03428C */  lw         $v0, 0x3DC($v0)
    /* 9B6A8 800AAEA8 00000000 */  nop
    /* 9B6AC 800AAEAC 05004510 */  beq        $v0, $a1, .L800AAEC4
    /* 9B6B0 800AAEB0 00000000 */   nop
    /* 9B6B4 800AAEB4 6004228E */  lw         $v0, 0x460($s1)
    /* 9B6B8 800AAEB8 00000000 */  nop
    /* 9B6BC 800AAEBC 03004010 */  beqz       $v0, .L800AAECC
    /* 9B6C0 800AAEC0 00000000 */   nop
  .L800AAEC4:
    /* 9B6C4 800AAEC4 94A6020C */  jal        Physics_AutoShift__FP8Car_tObj
    /* 9B6C8 800AAEC8 21202002 */   addu      $a0, $s1, $zero
  .L800AAECC:
    /* 9B6CC 800AAECC 44042292 */  lbu        $v0, 0x444($s1)
    /* 9B6D0 800AAED0 00000000 */  nop
    /* 9B6D4 800AAED4 08004010 */  beqz       $v0, .L800AAEF8
    /* 9B6D8 800AAED8 00000000 */   nop
    /* 9B6DC 800AAEDC 43042292 */  lbu        $v0, 0x443($s1)
    /* 9B6E0 800AAEE0 00000000 */  nop
    /* 9B6E4 800AAEE4 04004014 */  bnez       $v0, .L800AAEF8
    /* 9B6E8 800AAEE8 00000000 */   nop
    /* 9B6EC 800AAEEC 41042292 */  lbu        $v0, 0x441($s1)
    /* 9B6F0 800AAEF0 BFAB0208 */  j          .L800AAEFC
    /* 9B6F4 800AAEF4 00000000 */   nop
  .L800AAEF8:
    /* 9B6F8 800AAEF8 42042292 */  lbu        $v0, 0x442($s1)
  .L800AAEFC:
    /* 9B6FC 800AAEFC 2004248E */  lw         $a0, 0x420($s1)
    /* 9B700 800AAF00 80100200 */  sll        $v0, $v0, 2
    /* 9B704 800AAF04 21104202 */  addu       $v0, $s2, $v0
    /* 9B708 800AAF08 0C00458C */  lw         $a1, 0xC($v0)
    /* 9B70C 800AAF0C CA90030C */  jal        fixedmult
    /* 9B710 800AAF10 00000000 */   nop
    /* 9B714 800AAF14 21184000 */  addu       $v1, $v0, $zero
    /* 9B718 800AAF18 02006104 */  bgez       $v1, .L800AAF24
    /* 9B71C 800AAF1C FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 9B720 800AAF20 21186200 */  addu       $v1, $v1, $v0
  .L800AAF24:
    /* 9B724 800AAF24 B40D828F */  lw         $v0, %gp_rel(exceedRedline)($gp)
    /* 9B728 800AAF28 00000000 */  nop
    /* 9B72C 800AAF2C 05004014 */  bnez       $v0, .L800AAF44
    /* 9B730 800AAF30 03AC0300 */   sra       $s5, $v1, 16
    /* 9B734 800AAF34 7C02228E */  lw         $v0, 0x27C($s1)
    /* 9B738 800AAF38 00000000 */  nop
    /* 9B73C 800AAF3C 12004018 */  blez       $v0, .L800AAF88
    /* 9B740 800AAF40 00000000 */   nop
  .L800AAF44:
    /* 9B744 800AAF44 F000428E */  lw         $v0, 0xF0($s2)
    /* 9B748 800AAF48 00000000 */  nop
    /* 9B74C 800AAF4C 02004104 */  bgez       $v0, .L800AAF58
    /* 9B750 800AAF50 00000000 */   nop
    /* 9B754 800AAF54 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AAF58:
    /* 9B758 800AAF58 03120200 */  sra        $v0, $v0, 8
    /* 9B75C 800AAF5C 80100200 */  sll        $v0, $v0, 2
    /* 9B760 800AAF60 21104202 */  addu       $v0, $s2, $v0
    /* 9B764 800AAF64 42042392 */  lbu        $v1, 0x442($s1)
    /* 9B768 800AAF68 4C00448C */  lw         $a0, 0x4C($v0)
    /* 9B76C 800AAF6C 80180300 */  sll        $v1, $v1, 2
    /* 9B770 800AAF70 21184302 */  addu       $v1, $s2, $v1
    /* 9B774 800AAF74 A001658C */  lw         $a1, 0x1A0($v1)
    /* 9B778 800AAF78 CA90030C */  jal        fixedmult
    /* 9B77C 800AAF7C 00000000 */   nop
    /* 9B780 800AAF80 F2AB0208 */  j          .L800AAFC8
    /* 9B784 800AAF84 40A00200 */   sll       $s4, $v0, 1
  .L800AAF88:
    /* 9B788 800AAF88 6804258E */  lw         $a1, 0x468($s1)
    /* 9B78C 800AAF8C 00000000 */  nop
    /* 9B790 800AAF90 0200A104 */  bgez       $a1, .L800AAF9C
    /* 9B794 800AAF94 00000000 */   nop
    /* 9B798 800AAF98 FF00A524 */  addiu      $a1, $a1, 0xFF
  .L800AAF9C:
    /* 9B79C 800AAF9C 21202002 */  addu       $a0, $s1, $zero
    /* 9B7A0 800AAFA0 B9A4020C */  jal        Physics_GetTorque__FP8Car_tObji
    /* 9B7A4 800AAFA4 032A0500 */   sra       $a1, $a1, 8
    /* 9B7A8 800AAFA8 42042392 */  lbu        $v1, 0x442($s1)
    /* 9B7AC 800AAFAC 00000000 */  nop
    /* 9B7B0 800AAFB0 80180300 */  sll        $v1, $v1, 2
    /* 9B7B4 800AAFB4 21184302 */  addu       $v1, $s2, $v1
    /* 9B7B8 800AAFB8 A001658C */  lw         $a1, 0x1A0($v1)
    /* 9B7BC 800AAFBC CA90030C */  jal        fixedmult
    /* 9B7C0 800AAFC0 21204000 */   addu      $a0, $v0, $zero
    /* 9B7C4 800AAFC4 21A04000 */  addu       $s4, $v0, $zero
  .L800AAFC8:
    /* 9B7C8 800AAFC8 23201502 */  subu       $a0, $s0, $s5
    /* 9B7CC 800AAFCC 02008104 */  bgez       $a0, .L800AAFD8
    /* 9B7D0 800AAFD0 21108000 */   addu      $v0, $a0, $zero
    /* 9B7D4 800AAFD4 23100200 */  negu       $v0, $v0
  .L800AAFD8:
    /* 9B7D8 800AAFD8 7D004228 */  slti       $v0, $v0, 0x7D
    /* 9B7DC 800AAFDC 08004010 */  beqz       $v0, .L800AB000
    /* 9B7E0 800AAFE0 00000000 */   nop
    /* 9B7E4 800AAFE4 F000428E */  lw         $v0, 0xF0($s2)
    /* 9B7E8 800AAFE8 00000000 */  nop
    /* 9B7EC 800AAFEC D4FE4224 */  addiu      $v0, $v0, -0x12C
    /* 9B7F0 800AAFF0 2A100202 */  slt        $v0, $s0, $v0
    /* 9B7F4 800AAFF4 02004010 */  beqz       $v0, .L800AB000
    /* 9B7F8 800AAFF8 00000000 */   nop
    /* 9B7FC 800AAFFC 21200000 */  addu       $a0, $zero, $zero
  .L800AB000:
    /* 9B800 800AB000 6804228E */  lw         $v0, 0x468($s1)
    /* 9B804 800AB004 00000000 */  nop
    /* 9B808 800AB008 23985500 */  subu       $s3, $v0, $s5
    /* 9B80C 800AB00C FB00622A */  slti       $v0, $s3, 0xFB
    /* 9B810 800AB010 0A004014 */  bnez       $v0, .L800AB03C
    /* 9B814 800AB014 00000000 */   nop
    /* 9B818 800AB018 44042292 */  lbu        $v0, 0x444($s1)
    /* 9B81C 800AB01C 00000000 */  nop
    /* 9B820 800AB020 06004014 */  bnez       $v0, .L800AB03C
    /* 9B824 800AB024 00000000 */   nop
    /* 9B828 800AB028 42042292 */  lbu        $v0, 0x442($s1)
    /* 9B82C 800AB02C 00000000 */  nop
    /* 9B830 800AB030 0500422C */  sltiu      $v0, $v0, 0x5
    /* 9B834 800AB034 22004014 */  bnez       $v0, .L800AB0C0
    /* 9B838 800AB038 00000000 */   nop
  .L800AB03C:
    /* 9B83C 800AB03C 42042292 */  lbu        $v0, 0x442($s1)
    /* 9B840 800AB040 00000000 */  nop
    /* 9B844 800AB044 0200422C */  sltiu      $v0, $v0, 0x2
    /* 9B848 800AB048 0B004014 */  bnez       $v0, .L800AB078
    /* 9B84C 800AB04C 00000000 */   nop
    /* 9B850 800AB050 2004228E */  lw         $v0, 0x420($s1)
    /* 9B854 800AB054 00000000 */  nop
    /* 9B858 800AB058 67E64228 */  slti       $v0, $v0, -0x1999
    /* 9B85C 800AB05C 06004010 */  beqz       $v0, .L800AB078
    /* 9B860 800AB060 00800234 */   ori       $v0, $zero, 0x8000
    /* 9B864 800AB064 A80D838F */  lw         $v1, %gp_rel(gGasRatio)($gp)
    /* 9B868 800AB068 00000000 */  nop
    /* 9B86C 800AB06C 2A104300 */  slt        $v0, $v0, $v1
    /* 9B870 800AB070 13004014 */  bnez       $v0, .L800AB0C0
    /* 9B874 800AB074 00000000 */   nop
  .L800AB078:
    /* 9B878 800AB078 42042292 */  lbu        $v0, 0x442($s1)
    /* 9B87C 800AB07C 00000000 */  nop
    /* 9B880 800AB080 0B004014 */  bnez       $v0, .L800AB0B0
    /* 9B884 800AB084 00000000 */   nop
    /* 9B888 800AB088 2004228E */  lw         $v0, 0x420($s1)
    /* 9B88C 800AB08C 00000000 */  nop
    /* 9B890 800AB090 9A194228 */  slti       $v0, $v0, 0x199A
    /* 9B894 800AB094 06004014 */  bnez       $v0, .L800AB0B0
    /* 9B898 800AB098 00800234 */   ori       $v0, $zero, 0x8000
    /* 9B89C 800AB09C A80D838F */  lw         $v1, %gp_rel(gGasRatio)($gp)
    /* 9B8A0 800AB0A0 00000000 */  nop
    /* 9B8A4 800AB0A4 2A104300 */  slt        $v0, $v0, $v1
    /* 9B8A8 800AB0A8 05004014 */  bnez       $v0, .L800AB0C0
    /* 9B8AC 800AB0AC 00000000 */   nop
  .L800AB0B0:
    /* 9B8B0 800AB0B0 6C04238E */  lw         $v1, 0x46C($s1)
    /* 9B8B4 800AB0B4 01000224 */  addiu      $v0, $zero, 0x1
    /* 9B8B8 800AB0B8 31006214 */  bne        $v1, $v0, .L800AB180
    /* 9B8BC 800AB0BC 00000000 */   nop
  .L800AB0C0:
    /* 9B8C0 800AB0C0 7C02228E */  lw         $v0, 0x27C($s1)
    /* 9B8C4 800AB0C4 00000000 */  nop
    /* 9B8C8 800AB0C8 2D004014 */  bnez       $v0, .L800AB180
    /* 9B8CC 800AB0CC D007022A */   slti      $v0, $s0, 0x7D0
    /* 9B8D0 800AB0D0 13004014 */  bnez       $v0, .L800AB120
    /* 9B8D4 800AB0D4 21200000 */   addu      $a0, $zero, $zero
    /* 9B8D8 800AB0D8 3C042292 */  lbu        $v0, 0x43C($s1)
    /* 9B8DC 800AB0DC 00000000 */  nop
    /* 9B8E0 800AB0E0 4000422C */  sltiu      $v0, $v0, 0x40
    /* 9B8E4 800AB0E4 0E004014 */  bnez       $v0, .L800AB120
    /* 9B8E8 800AB0E8 00000000 */   nop
    /* 9B8EC 800AB0EC 0C00E016 */  bnez       $s7, .L800AB120
    /* 9B8F0 800AB0F0 00000000 */   nop
    /* 9B8F4 800AB0F4 8802228E */  lw         $v0, 0x288($s1)
    /* 9B8F8 800AB0F8 00000000 */  nop
    /* 9B8FC 800AB0FC 0000438C */  lw         $v1, 0x0($v0)
    /* 9B900 800AB100 13000224 */  addiu      $v0, $zero, 0x13
    /* 9B904 800AB104 08006214 */  bne        $v1, $v0, .L800AB128
    /* 9B908 800AB108 00000000 */   nop
    /* 9B90C 800AB10C 42042292 */  lbu        $v0, 0x442($s1)
    /* 9B910 800AB110 00000000 */  nop
    /* 9B914 800AB114 0300422C */  sltiu      $v0, $v0, 0x3
    /* 9B918 800AB118 03004014 */  bnez       $v0, .L800AB128
    /* 9B91C 800AB11C 00000000 */   nop
  .L800AB120:
    /* 9B920 800AB120 55AC0208 */  j          .L800AB154
    /* 9B924 800AB124 C8000424 */   addiu     $a0, $zero, 0xC8
  .L800AB128:
    /* 9B928 800AB128 42042392 */  lbu        $v1, 0x442($s1)
    /* 9B92C 800AB12C 02000224 */  addiu      $v0, $zero, 0x2
    /* 9B930 800AB130 03006210 */  beq        $v1, $v0, .L800AB140
    /* 9B934 800AB134 00000000 */   nop
    /* 9B938 800AB138 03006014 */  bnez       $v1, .L800AB148
    /* 9B93C 800AB13C 0300622C */   sltiu     $v0, $v1, 0x3
  .L800AB140:
    /* 9B940 800AB140 55AC0208 */  j          .L800AB154
    /* 9B944 800AB144 0A000424 */   addiu     $a0, $zero, 0xA
  .L800AB148:
    /* 9B948 800AB148 03004014 */  bnez       $v0, .L800AB158
    /* 9B94C 800AB14C 2A10D303 */   slt       $v0, $fp, $s3
    /* 9B950 800AB150 32000424 */  addiu      $a0, $zero, 0x32
  .L800AB154:
    /* 9B954 800AB154 2A10D303 */  slt        $v0, $fp, $s3
  .L800AB158:
    /* 9B958 800AB158 02004010 */  beqz       $v0, .L800AB164
    /* 9B95C 800AB15C 02000224 */   addiu     $v0, $zero, 0x2
    /* 9B960 800AB160 6C0422AE */  sw         $v0, 0x46C($s1)
  .L800AB164:
    /* 9B964 800AB164 6804238E */  lw         $v1, 0x468($s1)
    /* 9B968 800AB168 2A109300 */  slt        $v0, $a0, $s3
    /* 9B96C 800AB16C 02004014 */  bnez       $v0, .L800AB178
    /* 9B970 800AB170 23106400 */   subu      $v0, $v1, $a0
    /* 9B974 800AB174 23107300 */  subu       $v0, $v1, $s3
  .L800AB178:
    /* 9B978 800AB178 F1AC0208 */  j          .L800AB3C4
    /* 9B97C 800AB17C 680422AE */   sw        $v0, 0x468($s1)
  .L800AB180:
    /* 9B980 800AB180 4B008104 */  bgez       $a0, .L800AB2B0
    /* 9B984 800AB184 00000000 */   nop
    /* 9B988 800AB188 2001458E */  lw         $a1, 0x120($s2)
    /* 9B98C 800AB18C CA90030C */  jal        fixedmult
    /* 9B990 800AB190 21208002 */   addu      $a0, $s4, $zero
    /* 9B994 800AB194 1180033C */  lui        $v1, %hi(D_801165DC)
    /* 9B998 800AB198 DC65638C */  lw         $v1, %lo(D_801165DC)($v1)
    /* 9B99C 800AB19C 00000000 */  nop
    /* 9B9A0 800AB1A0 0B006018 */  blez       $v1, .L800AB1D0
    /* 9B9A4 800AB1A4 23A00200 */   negu      $s4, $v0
    /* 9B9A8 800AB1A8 42042392 */  lbu        $v1, 0x442($s1)
    /* 9B9AC 800AB1AC 00000000 */  nop
    /* 9B9B0 800AB1B0 0200622C */  sltiu      $v0, $v1, 0x2
    /* 9B9B4 800AB1B4 07004014 */  bnez       $v0, .L800AB1D4
    /* 9B9B8 800AB1B8 1180023C */   lui       $v0, %hi(D_801165DC)
    /* 9B9BC 800AB1BC 05008106 */  bgez       $s4, .L800AB1D4
    /* 9B9C0 800AB1C0 00000000 */   nop
    /* 9B9C4 800AB1C4 0300622C */  sltiu      $v0, $v1, 0x3
    /* 9B9C8 800AB1C8 0C004014 */  bnez       $v0, .L800AB1FC
    /* 9B9CC 800AB1CC C2171400 */   srl       $v0, $s4, 31
  .L800AB1D0:
    /* 9B9D0 800AB1D0 1180023C */  lui        $v0, %hi(D_801165DC)
  .L800AB1D4:
    /* 9B9D4 800AB1D4 DC65428C */  lw         $v0, %lo(D_801165DC)($v0)
    /* 9B9D8 800AB1D8 00000000 */  nop
    /* 9B9DC 800AB1DC 09004104 */  bgez       $v0, .L800AB204
    /* 9B9E0 800AB1E0 00000000 */   nop
    /* 9B9E4 800AB1E4 42042292 */  lbu        $v0, 0x442($s1)
    /* 9B9E8 800AB1E8 00000000 */  nop
    /* 9B9EC 800AB1EC 08004014 */  bnez       $v0, .L800AB210
    /* 9B9F0 800AB1F0 80100200 */   sll       $v0, $v0, 2
    /* 9B9F4 800AB1F4 0300801A */  blez       $s4, .L800AB204
    /* 9B9F8 800AB1F8 C2171400 */   srl       $v0, $s4, 31
  .L800AB1FC:
    /* 9B9FC 800AB1FC 21108202 */  addu       $v0, $s4, $v0
    /* 9BA00 800AB200 43A00200 */  sra        $s4, $v0, 1
  .L800AB204:
    /* 9BA04 800AB204 42042292 */  lbu        $v0, 0x442($s1)
    /* 9BA08 800AB208 00000000 */  nop
    /* 9BA0C 800AB20C 80100200 */  sll        $v0, $v0, 2
  .L800AB210:
    /* 9BA10 800AB210 21104202 */  addu       $v0, $s2, $v0
    /* 9BA14 800AB214 8001448C */  lw         $a0, 0x180($v0)
    /* 9BA18 800AB218 0028053C */  lui        $a1, (0x28000000 >> 16)
    /* 9BA1C 800AB21C CA90030C */  jal        fixedmult
    /* 9BA20 800AB220 C0200400 */   sll       $a0, $a0, 3
    /* 9BA24 800AB224 21184000 */  addu       $v1, $v0, $zero
    /* 9BA28 800AB228 02006104 */  bgez       $v1, .L800AB234
    /* 9BA2C 800AB22C FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 9BA30 800AB230 21186200 */  addu       $v1, $v1, $v0
  .L800AB234:
    /* 9BA34 800AB234 42042292 */  lbu        $v0, 0x442($s1)
    /* 9BA38 800AB238 00000000 */  nop
    /* 9BA3C 800AB23C 09004014 */  bnez       $v0, .L800AB264
    /* 9BA40 800AB240 031C0300 */   sra       $v1, $v1, 16
    /* 9BA44 800AB244 23201300 */  negu       $a0, $s3
    /* 9BA48 800AB248 2A106400 */  slt        $v0, $v1, $a0
    /* 9BA4C 800AB24C 02004010 */  beqz       $v0, .L800AB258
    /* 9BA50 800AB250 00000000 */   nop
    /* 9BA54 800AB254 21188000 */  addu       $v1, $a0, $zero
  .L800AB258:
    /* 9BA58 800AB258 6804228E */  lw         $v0, 0x468($s1)
    /* 9BA5C 800AB25C 9FAC0208 */  j          .L800AB27C
    /* 9BA60 800AB260 21104300 */   addu      $v0, $v0, $v1
  .L800AB264:
    /* 9BA64 800AB264 6804248E */  lw         $a0, 0x468($s1)
    /* 9BA68 800AB268 23101300 */  negu       $v0, $s3
    /* 9BA6C 800AB26C 2A106200 */  slt        $v0, $v1, $v0
    /* 9BA70 800AB270 02004014 */  bnez       $v0, .L800AB27C
    /* 9BA74 800AB274 21108300 */   addu      $v0, $a0, $v1
    /* 9BA78 800AB278 23109300 */  subu       $v0, $a0, $s3
  .L800AB27C:
    /* 9BA7C 800AB27C 680422AE */  sw         $v0, 0x468($s1)
    /* 9BA80 800AB280 B40D828F */  lw         $v0, %gp_rel(exceedRedline)($gp)
    /* 9BA84 800AB284 00000000 */  nop
    /* 9BA88 800AB288 4E004014 */  bnez       $v0, .L800AB3C4
    /* 9BA8C 800AB28C 21180002 */   addu      $v1, $s0, $zero
    /* 9BA90 800AB290 6804248E */  lw         $a0, 0x468($s1)
    /* 9BA94 800AB294 00000000 */  nop
    /* 9BA98 800AB298 2A106400 */  slt        $v0, $v1, $a0
    /* 9BA9C 800AB29C 02004010 */  beqz       $v0, .L800AB2A8
    /* 9BAA0 800AB2A0 00000000 */   nop
    /* 9BAA4 800AB2A4 21188000 */  addu       $v1, $a0, $zero
  .L800AB2A8:
    /* 9BAA8 800AB2A8 F1AC0208 */  j          .L800AB3C4
    /* 9BAAC 800AB2AC 680423AE */   sw        $v1, 0x468($s1)
  .L800AB2B0:
    /* 9BAB0 800AB2B0 04008014 */  bnez       $a0, .L800AB2C4
    /* 9BAB4 800AB2B4 00000000 */   nop
    /* 9BAB8 800AB2B8 680435AE */  sw         $s5, 0x468($s1)
    /* 9BABC 800AB2BC F1AC0208 */  j          .L800AB3C4
    /* 9BAC0 800AB2C0 21A0C002 */   addu      $s4, $s6, $zero
  .L800AB2C4:
    /* 9BAC4 800AB2C4 0600E012 */  beqz       $s7, .L800AB2E0
    /* 9BAC8 800AB2C8 C900622A */   slti      $v0, $s3, 0xC9
    /* 9BACC 800AB2CC 6804228E */  lw         $v0, 0x468($s1)
    /* 9BAD0 800AB2D0 21A00000 */  addu       $s4, $zero, $zero
    /* 9BAD4 800AB2D4 9CFF4224 */  addiu      $v0, $v0, -0x64
    /* 9BAD8 800AB2D8 CBAC0208 */  j          .L800AB32C
    /* 9BADC 800AB2DC 680422AE */   sw        $v0, 0x468($s1)
  .L800AB2E0:
    /* 9BAE0 800AB2E0 06004014 */  bnez       $v0, .L800AB2FC
    /* 9BAE4 800AB2E4 38FF622A */   slti      $v0, $s3, -0xC8
    /* 9BAE8 800AB2E8 6804228E */  lw         $v0, 0x468($s1)
    /* 9BAEC 800AB2EC 00000000 */  nop
    /* 9BAF0 800AB2F0 38FF4224 */  addiu      $v0, $v0, -0xC8
    /* 9BAF4 800AB2F4 C7AC0208 */  j          .L800AB31C
    /* 9BAF8 800AB2F8 680422AE */   sw        $v0, 0x468($s1)
  .L800AB2FC:
    /* 9BAFC 800AB2FC 06004010 */  beqz       $v0, .L800AB318
    /* 9BB00 800AB300 00000000 */   nop
    /* 9BB04 800AB304 6804228E */  lw         $v0, 0x468($s1)
    /* 9BB08 800AB308 00000000 */  nop
    /* 9BB0C 800AB30C C8004224 */  addiu      $v0, $v0, 0xC8
    /* 9BB10 800AB310 C7AC0208 */  j          .L800AB31C
    /* 9BB14 800AB314 680422AE */   sw        $v0, 0x468($s1)
  .L800AB318:
    /* 9BB18 800AB318 680435AE */  sw         $s5, 0x468($s1)
  .L800AB31C:
    /* 9BB1C 800AB31C A80D858F */  lw         $a1, %gp_rel(gGasRatio)($gp)
    /* 9BB20 800AB320 CA90030C */  jal        fixedmult
    /* 9BB24 800AB324 21208002 */   addu      $a0, $s4, $zero
    /* 9BB28 800AB328 21A04000 */  addu       $s4, $v0, $zero
  .L800AB32C:
    /* 9BB2C 800AB32C 6804238E */  lw         $v1, 0x468($s1)
    /* 9BB30 800AB330 21200002 */  addu       $a0, $s0, $zero
    /* 9BB34 800AB334 2A108300 */  slt        $v0, $a0, $v1
    /* 9BB38 800AB338 02004014 */  bnez       $v0, .L800AB344
    /* 9BB3C 800AB33C 00000000 */   nop
    /* 9BB40 800AB340 21206000 */  addu       $a0, $v1, $zero
  .L800AB344:
    /* 9BB44 800AB344 680424AE */  sw         $a0, 0x468($s1)
    /* 9BB48 800AB348 0100043C */  lui        $a0, %hi(D_100FF)
    /* 9BB4C 800AB34C 1180023C */  lui        $v0, %hi(D_80113224)
    /* 9BB50 800AB350 7804238E */  lw         $v1, 0x478($s1)
    /* 9BB54 800AB354 2432428C */  lw         $v0, %lo(D_80113224)($v0)
    /* 9BB58 800AB358 02006104 */  bgez       $v1, .L800AB364
    /* 9BB5C 800AB35C 00000000 */   nop
    /* 9BB60 800AB360 23180300 */  negu       $v1, $v1
  .L800AB364:
    /* 9BB64 800AB364 08004230 */  andi       $v0, $v0, 0x8
    /* 9BB68 800AB368 07004010 */  beqz       $v0, .L800AB388
    /* 9BB6C 800AB36C 21186400 */   addu      $v1, $v1, $a0
    /* 9BB70 800AB370 0300023C */  lui        $v0, (0x30000 >> 16)
    /* 9BB74 800AB374 2A104300 */  slt        $v0, $v0, $v1
    /* 9BB78 800AB378 08004010 */  beqz       $v0, .L800AB39C
    /* 9BB7C 800AB37C 00000000 */   nop
    /* 9BB80 800AB380 E7AC0208 */  j          .L800AB39C
    /* 9BB84 800AB384 0300033C */   lui       $v1, (0x30000 >> 16)
  .L800AB388:
    /* 9BB88 800AB388 0200023C */  lui        $v0, (0x20000 >> 16)
    /* 9BB8C 800AB38C 2A104300 */  slt        $v0, $v0, $v1
    /* 9BB90 800AB390 02004010 */  beqz       $v0, .L800AB39C
    /* 9BB94 800AB394 00000000 */   nop
    /* 9BB98 800AB398 0200033C */  lui        $v1, (0x20000 >> 16)
  .L800AB39C:
    /* 9BB9C 800AB39C 02008106 */  bgez       $s4, .L800AB3A8
    /* 9BBA0 800AB3A0 21208002 */   addu      $a0, $s4, $zero
    /* 9BBA4 800AB3A4 FF008426 */  addiu      $a0, $s4, 0xFF
  .L800AB3A8:
    /* 9BBA8 800AB3A8 21106000 */  addu       $v0, $v1, $zero
    /* 9BBAC 800AB3AC 02004104 */  bgez       $v0, .L800AB3B8
    /* 9BBB0 800AB3B0 03220400 */   sra       $a0, $a0, 8
    /* 9BBB4 800AB3B4 FF004224 */  addiu      $v0, $v0, %lo(D_100FF)
  .L800AB3B8:
    /* 9BBB8 800AB3B8 03120200 */  sra        $v0, $v0, 8
    /* 9BBBC 800AB3BC 18008200 */  mult       $a0, $v0
    /* 9BBC0 800AB3C0 12A00000 */  mflo       $s4
  .L800AB3C4:
    /* 9BBC4 800AB3C4 6804228E */  lw         $v0, 0x468($s1)
    /* 9BBC8 800AB3C8 00000000 */  nop
    /* 9BBCC 800AB3CC 12004104 */  bgez       $v0, .L800AB418
    /* 9BBD0 800AB3D0 00000000 */   nop
    /* 9BBD4 800AB3D4 2004228E */  lw         $v0, 0x420($s1)
    /* 9BBD8 800AB3D8 00000000 */  nop
    /* 9BBDC 800AB3DC 40110200 */  sll        $v0, $v0, 5
    /* 9BBE0 800AB3E0 0500801A */  blez       $s4, .L800AB3F8
    /* 9BBE4 800AB3E4 23180200 */   negu      $v1, $v0
    /* 9BBE8 800AB3E8 03006018 */  blez       $v1, .L800AB3F8
    /* 9BBEC 800AB3EC 23108302 */   subu      $v0, $s4, $v1
    /* 9BBF0 800AB3F0 0900401C */  bgtz       $v0, .L800AB418
    /* 9BBF4 800AB3F4 00000000 */   nop
  .L800AB3F8:
    /* 9BBF8 800AB3F8 05008106 */  bgez       $s4, .L800AB410
    /* 9BBFC 800AB3FC 00000000 */   nop
    /* 9BC00 800AB400 03006104 */  bgez       $v1, .L800AB410
    /* 9BC04 800AB404 23108302 */   subu      $v0, $s4, $v1
    /* 9BC08 800AB408 03004004 */  bltz       $v0, .L800AB418
    /* 9BC0C 800AB40C 00000000 */   nop
  .L800AB410:
    /* 9BC10 800AB410 21A06000 */  addu       $s4, $v1, $zero
    /* 9BC14 800AB414 680420AE */  sw         $zero, 0x468($s1)
  .L800AB418:
    /* 9BC18 800AB418 8802228E */  lw         $v0, 0x288($s1)
    /* 9BC1C 800AB41C 00000000 */  nop
    /* 9BC20 800AB420 0000428C */  lw         $v0, 0x0($v0)
    /* 9BC24 800AB424 00000000 */  nop
    /* 9BC28 800AB428 F4FF4224 */  addiu      $v0, $v0, -0xC
    /* 9BC2C 800AB42C 0400422C */  sltiu      $v0, $v0, 0x4
    /* 9BC30 800AB430 0E004010 */  beqz       $v0, .L800AB46C
    /* 9BC34 800AB434 23109602 */   subu      $v0, $s4, $s6
    /* 9BC38 800AB438 CC0D828F */  lw         $v0, %gp_rel(slippery)($gp)
    /* 9BC3C 800AB43C 00000000 */  nop
    /* 9BC40 800AB440 09004010 */  beqz       $v0, .L800AB468
    /* 9BC44 800AB444 02000224 */   addiu     $v0, $zero, 0x2
    /* 9BC48 800AB448 42042392 */  lbu        $v1, 0x442($s1)
    /* 9BC4C 800AB44C 00000000 */  nop
    /* 9BC50 800AB450 06006214 */  bne        $v1, $v0, .L800AB46C
    /* 9BC54 800AB454 23109602 */   subu      $v0, $s4, $s6
    /* 9BC58 800AB458 0300801A */  blez       $s4, .L800AB468
    /* 9BC5C 800AB45C 40101400 */   sll       $v0, $s4, 1
    /* 9BC60 800AB460 21105400 */  addu       $v0, $v0, $s4
    /* 9BC64 800AB464 83A00200 */  sra        $s4, $v0, 2
  .L800AB468:
    /* 9BC68 800AB468 23109602 */  subu       $v0, $s4, $s6
  .L800AB46C:
    /* 9BC6C 800AB46C 7400BF8F */  lw         $ra, 0x74($sp)
    /* 9BC70 800AB470 7000BE8F */  lw         $fp, 0x70($sp)
    /* 9BC74 800AB474 6C00B78F */  lw         $s7, 0x6C($sp)
    /* 9BC78 800AB478 6800B68F */  lw         $s6, 0x68($sp)
    /* 9BC7C 800AB47C 6400B58F */  lw         $s5, 0x64($sp)
    /* 9BC80 800AB480 6000B48F */  lw         $s4, 0x60($sp)
    /* 9BC84 800AB484 5C00B38F */  lw         $s3, 0x5C($sp)
    /* 9BC88 800AB488 5800B28F */  lw         $s2, 0x58($sp)
    /* 9BC8C 800AB48C 5400B18F */  lw         $s1, 0x54($sp)
    /* 9BC90 800AB490 5000B08F */  lw         $s0, 0x50($sp)
    /* 9BC94 800AB494 0800E003 */  jr         $ra
    /* 9BC98 800AB498 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel Physics_CalculateCarAcceleration__FP8Car_tObj
