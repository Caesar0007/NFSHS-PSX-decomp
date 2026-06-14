.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_LimitGlueMultiplier__FP8Car_tObji, 0xF4

glabel AISpeeds_LimitGlueMultiplier__FP8Car_tObji
    /* 5F1B0 8006E9B0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 5F1B4 8006E9B4 2000B4AF */  sw         $s4, 0x20($sp)
    /* 5F1B8 8006E9B8 21A08000 */  addu       $s4, $a0, $zero
    /* 5F1BC 8006E9BC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5F1C0 8006E9C0 2190A000 */  addu       $s2, $a1, $zero
    /* 5F1C4 8006E9C4 FFFF033C */  lui        $v1, (0xFFFF6666 >> 16)
    /* 5F1C8 8006E9C8 66666334 */  ori        $v1, $v1, (0xFFFF6666 & 0xFFFF)
    /* 5F1CC 8006E9CC 21184302 */  addu       $v1, $s2, $v1
    /* 5F1D0 8006E9D0 CBCC0234 */  ori        $v0, $zero, 0xCCCB
    /* 5F1D4 8006E9D4 2B104300 */  sltu       $v0, $v0, $v1
    /* 5F1D8 8006E9D8 2400BFAF */  sw         $ra, 0x24($sp)
    /* 5F1DC 8006E9DC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 5F1E0 8006E9E0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5F1E4 8006E9E4 26004010 */  beqz       $v0, .L8006EA80
    /* 5F1E8 8006E9E8 1000B0AF */   sw        $s0, 0x10($sp)
    /* 5F1EC 8006E9EC 1027133C */  lui        $s3, (0x27100000 >> 16)
    /* 5F1F0 8006E9F0 21880000 */  addu       $s1, $zero, $zero
    /* 5F1F4 8006E9F4 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 5F1F8 8006E9F8 48FA5024 */  addiu      $s0, $v0, %lo(Cars_gHumanRaceCarList)
  .L8006E9FC:
    /* 5F1FC 8006E9FC 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 5F200 8006EA00 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 5F204 8006EA04 00000000 */  nop
    /* 5F208 8006EA08 2A102202 */  slt        $v0, $s1, $v0
    /* 5F20C 8006EA0C 0E004010 */  beqz       $v0, .L8006EA48
    /* 5F210 8006EA10 7800023C */   lui       $v0, (0x780000 >> 16)
    /* 5F214 8006EA14 0000058E */  lw         $a1, 0x0($s0)
    /* 5F218 8006EA18 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 5F21C 8006EA1C 21208002 */   addu      $a0, $s4, $zero
    /* 5F220 8006EA20 02004104 */  bgez       $v0, .L8006EA2C
    /* 5F224 8006EA24 21184000 */   addu      $v1, $v0, $zero
    /* 5F228 8006EA28 23180300 */  negu       $v1, $v1
  .L8006EA2C:
    /* 5F22C 8006EA2C 2A107300 */  slt        $v0, $v1, $s3
    /* 5F230 8006EA30 02004010 */  beqz       $v0, .L8006EA3C
    /* 5F234 8006EA34 00000000 */   nop
    /* 5F238 8006EA38 21986000 */  addu       $s3, $v1, $zero
  .L8006EA3C:
    /* 5F23C 8006EA3C 04001026 */  addiu      $s0, $s0, 0x4
    /* 5F240 8006EA40 7FBA0108 */  j          .L8006E9FC
    /* 5F244 8006EA44 01003126 */   addiu     $s1, $s1, 0x1
  .L8006EA48:
    /* 5F248 8006EA48 2A105300 */  slt        $v0, $v0, $s3
    /* 5F24C 8006EA4C 0D004014 */  bnez       $v0, .L8006EA84
    /* 5F250 8006EA50 21104002 */   addu      $v0, $s2, $zero
    /* 5F254 8006EA54 0100023C */  lui        $v0, (0x16666 >> 16)
    /* 5F258 8006EA58 66664234 */  ori        $v0, $v0, (0x16666 & 0xFFFF)
    /* 5F25C 8006EA5C 2A105200 */  slt        $v0, $v0, $s2
    /* 5F260 8006EA60 03004010 */  beqz       $v0, .L8006EA70
    /* 5F264 8006EA64 98990234 */   ori       $v0, $zero, 0x9998
    /* 5F268 8006EA68 0100123C */  lui        $s2, (0x16666 >> 16)
    /* 5F26C 8006EA6C 66665236 */  ori        $s2, $s2, (0x16666 & 0xFFFF)
  .L8006EA70:
    /* 5F270 8006EA70 2A105200 */  slt        $v0, $v0, $s2
    /* 5F274 8006EA74 03004014 */  bnez       $v0, .L8006EA84
    /* 5F278 8006EA78 21104002 */   addu      $v0, $s2, $zero
    /* 5F27C 8006EA7C 99991234 */  ori        $s2, $zero, 0x9999
  .L8006EA80:
    /* 5F280 8006EA80 21104002 */  addu       $v0, $s2, $zero
  .L8006EA84:
    /* 5F284 8006EA84 2400BF8F */  lw         $ra, 0x24($sp)
    /* 5F288 8006EA88 2000B48F */  lw         $s4, 0x20($sp)
    /* 5F28C 8006EA8C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5F290 8006EA90 1800B28F */  lw         $s2, 0x18($sp)
    /* 5F294 8006EA94 1400B18F */  lw         $s1, 0x14($sp)
    /* 5F298 8006EA98 1000B08F */  lw         $s0, 0x10($sp)
    /* 5F29C 8006EA9C 0800E003 */  jr         $ra
    /* 5F2A0 8006EAA0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AISpeeds_LimitGlueMultiplier__FP8Car_tObji
