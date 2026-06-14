.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_GetUpgradeHandlingMult__Fi, 0xBC

glabel AISpeeds_GetUpgradeHandlingMult__Fi
    /* 5FA84 8006F284 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5FA88 8006F288 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 5FA8C 8006F28C DCF94224 */  addiu      $v0, $v0, %lo(Cars_gList)
    /* 5FA90 8006F290 80200400 */  sll        $a0, $a0, 2
    /* 5FA94 8006F294 21208200 */  addu       $a0, $a0, $v0
    /* 5FA98 8006F298 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5FA9C 8006F29C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5FAA0 8006F2A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5FAA4 8006F2A4 0000908C */  lw         $s0, 0x0($a0)
    /* 5FAA8 8006F2A8 00000000 */  nop
    /* 5FAAC 8006F2AC 8802028E */  lw         $v0, 0x288($s0)
    /* 5FAB0 8006F2B0 00000000 */  nop
    /* 5FAB4 8006F2B4 3C00428C */  lw         $v0, 0x3C($v0)
    /* 5FAB8 8006F2B8 01001124 */  addiu      $s1, $zero, 0x1
    /* 5FABC 8006F2BC 06005114 */  bne        $v0, $s1, .L8006F2D8
    /* 5FAC0 8006F2C0 0100043C */   lui       $a0, (0x10000 >> 16)
    /* 5FAC4 8006F2C4 1180023C */  lui        $v0, %hi(D_8010DCE8)
    /* 5FAC8 8006F2C8 E8DC458C */  lw         $a1, %lo(D_8010DCE8)($v0)
    /* 5FACC 8006F2CC CA90030C */  jal        fixedmult
    /* 5FAD0 8006F2D0 00000000 */   nop
    /* 5FAD4 8006F2D4 21204000 */  addu       $a0, $v0, $zero
  .L8006F2D8:
    /* 5FAD8 8006F2D8 8802028E */  lw         $v0, 0x288($s0)
    /* 5FADC 8006F2DC 00000000 */  nop
    /* 5FAE0 8006F2E0 4000428C */  lw         $v0, 0x40($v0)
    /* 5FAE4 8006F2E4 00000000 */  nop
    /* 5FAE8 8006F2E8 05005114 */  bne        $v0, $s1, .L8006F300
    /* 5FAEC 8006F2EC 1180023C */   lui       $v0, %hi(D_8010DCF8)
    /* 5FAF0 8006F2F0 F8DC458C */  lw         $a1, %lo(D_8010DCF8)($v0)
    /* 5FAF4 8006F2F4 CA90030C */  jal        fixedmult
    /* 5FAF8 8006F2F8 00000000 */   nop
    /* 5FAFC 8006F2FC 21204000 */  addu       $a0, $v0, $zero
  .L8006F300:
    /* 5FB00 8006F300 8802028E */  lw         $v0, 0x288($s0)
    /* 5FB04 8006F304 00000000 */  nop
    /* 5FB08 8006F308 4400428C */  lw         $v0, 0x44($v0)
    /* 5FB0C 8006F30C 00000000 */  nop
    /* 5FB10 8006F310 05005114 */  bne        $v0, $s1, .L8006F328
    /* 5FB14 8006F314 1180023C */   lui       $v0, %hi(D_8010DD08)
    /* 5FB18 8006F318 08DD458C */  lw         $a1, %lo(D_8010DD08)($v0)
    /* 5FB1C 8006F31C CA90030C */  jal        fixedmult
    /* 5FB20 8006F320 00000000 */   nop
    /* 5FB24 8006F324 21204000 */  addu       $a0, $v0, $zero
  .L8006F328:
    /* 5FB28 8006F328 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5FB2C 8006F32C 1400B18F */  lw         $s1, 0x14($sp)
    /* 5FB30 8006F330 1000B08F */  lw         $s0, 0x10($sp)
    /* 5FB34 8006F334 21108000 */  addu       $v0, $a0, $zero
    /* 5FB38 8006F338 0800E003 */  jr         $ra
    /* 5FB3C 8006F33C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AISpeeds_GetUpgradeHandlingMult__Fi
