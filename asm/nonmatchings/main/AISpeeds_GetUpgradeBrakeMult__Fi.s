.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_GetUpgradeBrakeMult__Fi, 0xBC

glabel AISpeeds_GetUpgradeBrakeMult__Fi
    /* 5F9C8 8006F1C8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5F9CC 8006F1CC 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 5F9D0 8006F1D0 DCF94224 */  addiu      $v0, $v0, %lo(Cars_gList)
    /* 5F9D4 8006F1D4 80200400 */  sll        $a0, $a0, 2
    /* 5F9D8 8006F1D8 21208200 */  addu       $a0, $a0, $v0
    /* 5F9DC 8006F1DC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5F9E0 8006F1E0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5F9E4 8006F1E4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5F9E8 8006F1E8 0000908C */  lw         $s0, 0x0($a0)
    /* 5F9EC 8006F1EC 00000000 */  nop
    /* 5F9F0 8006F1F0 8802028E */  lw         $v0, 0x288($s0)
    /* 5F9F4 8006F1F4 00000000 */  nop
    /* 5F9F8 8006F1F8 3C00428C */  lw         $v0, 0x3C($v0)
    /* 5F9FC 8006F1FC 01001124 */  addiu      $s1, $zero, 0x1
    /* 5FA00 8006F200 06005114 */  bne        $v0, $s1, .L8006F21C
    /* 5FA04 8006F204 0100043C */   lui       $a0, (0x10000 >> 16)
    /* 5FA08 8006F208 1180023C */  lui        $v0, %hi(D_8010DCE4)
    /* 5FA0C 8006F20C E4DC458C */  lw         $a1, %lo(D_8010DCE4)($v0)
    /* 5FA10 8006F210 CA90030C */  jal        fixedmult
    /* 5FA14 8006F214 00000000 */   nop
    /* 5FA18 8006F218 21204000 */  addu       $a0, $v0, $zero
  .L8006F21C:
    /* 5FA1C 8006F21C 8802028E */  lw         $v0, 0x288($s0)
    /* 5FA20 8006F220 00000000 */  nop
    /* 5FA24 8006F224 4000428C */  lw         $v0, 0x40($v0)
    /* 5FA28 8006F228 00000000 */  nop
    /* 5FA2C 8006F22C 05005114 */  bne        $v0, $s1, .L8006F244
    /* 5FA30 8006F230 1180023C */   lui       $v0, %hi(D_8010DCF4)
    /* 5FA34 8006F234 F4DC458C */  lw         $a1, %lo(D_8010DCF4)($v0)
    /* 5FA38 8006F238 CA90030C */  jal        fixedmult
    /* 5FA3C 8006F23C 00000000 */   nop
    /* 5FA40 8006F240 21204000 */  addu       $a0, $v0, $zero
  .L8006F244:
    /* 5FA44 8006F244 8802028E */  lw         $v0, 0x288($s0)
    /* 5FA48 8006F248 00000000 */  nop
    /* 5FA4C 8006F24C 4400428C */  lw         $v0, 0x44($v0)
    /* 5FA50 8006F250 00000000 */  nop
    /* 5FA54 8006F254 05005114 */  bne        $v0, $s1, .L8006F26C
    /* 5FA58 8006F258 1180023C */   lui       $v0, %hi(D_8010DD04)
    /* 5FA5C 8006F25C 04DD458C */  lw         $a1, %lo(D_8010DD04)($v0)
    /* 5FA60 8006F260 CA90030C */  jal        fixedmult
    /* 5FA64 8006F264 00000000 */   nop
    /* 5FA68 8006F268 21204000 */  addu       $a0, $v0, $zero
  .L8006F26C:
    /* 5FA6C 8006F26C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5FA70 8006F270 1400B18F */  lw         $s1, 0x14($sp)
    /* 5FA74 8006F274 1000B08F */  lw         $s0, 0x10($sp)
    /* 5FA78 8006F278 21108000 */  addu       $v0, $a0, $zero
    /* 5FA7C 8006F27C 0800E003 */  jr         $ra
    /* 5FA80 8006F280 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AISpeeds_GetUpgradeBrakeMult__Fi
