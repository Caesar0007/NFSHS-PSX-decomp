.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_GetUpgradeTopSpeedMult__Fi, 0xBC

glabel AISpeeds_GetUpgradeTopSpeedMult__Fi
    /* 5FB40 8006F340 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5FB44 8006F344 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 5FB48 8006F348 DCF94224 */  addiu      $v0, $v0, %lo(Cars_gList)
    /* 5FB4C 8006F34C 80200400 */  sll        $a0, $a0, 2
    /* 5FB50 8006F350 21208200 */  addu       $a0, $a0, $v0
    /* 5FB54 8006F354 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5FB58 8006F358 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5FB5C 8006F35C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5FB60 8006F360 0000908C */  lw         $s0, 0x0($a0)
    /* 5FB64 8006F364 00000000 */  nop
    /* 5FB68 8006F368 8802028E */  lw         $v0, 0x288($s0)
    /* 5FB6C 8006F36C 00000000 */  nop
    /* 5FB70 8006F370 3C00428C */  lw         $v0, 0x3C($v0)
    /* 5FB74 8006F374 01001124 */  addiu      $s1, $zero, 0x1
    /* 5FB78 8006F378 06005114 */  bne        $v0, $s1, .L8006F394
    /* 5FB7C 8006F37C 0100043C */   lui       $a0, (0x10000 >> 16)
    /* 5FB80 8006F380 1180023C */  lui        $v0, %hi(D_8010DCEC)
    /* 5FB84 8006F384 ECDC458C */  lw         $a1, %lo(D_8010DCEC)($v0)
    /* 5FB88 8006F388 CA90030C */  jal        fixedmult
    /* 5FB8C 8006F38C 00000000 */   nop
    /* 5FB90 8006F390 21204000 */  addu       $a0, $v0, $zero
  .L8006F394:
    /* 5FB94 8006F394 8802028E */  lw         $v0, 0x288($s0)
    /* 5FB98 8006F398 00000000 */  nop
    /* 5FB9C 8006F39C 4000428C */  lw         $v0, 0x40($v0)
    /* 5FBA0 8006F3A0 00000000 */  nop
    /* 5FBA4 8006F3A4 05005114 */  bne        $v0, $s1, .L8006F3BC
    /* 5FBA8 8006F3A8 1180023C */   lui       $v0, %hi(D_8010DCFC)
    /* 5FBAC 8006F3AC FCDC458C */  lw         $a1, %lo(D_8010DCFC)($v0)
    /* 5FBB0 8006F3B0 CA90030C */  jal        fixedmult
    /* 5FBB4 8006F3B4 00000000 */   nop
    /* 5FBB8 8006F3B8 21204000 */  addu       $a0, $v0, $zero
  .L8006F3BC:
    /* 5FBBC 8006F3BC 8802028E */  lw         $v0, 0x288($s0)
    /* 5FBC0 8006F3C0 00000000 */  nop
    /* 5FBC4 8006F3C4 4400428C */  lw         $v0, 0x44($v0)
    /* 5FBC8 8006F3C8 00000000 */  nop
    /* 5FBCC 8006F3CC 05005114 */  bne        $v0, $s1, .L8006F3E4
    /* 5FBD0 8006F3D0 1180023C */   lui       $v0, %hi(D_8010DD0C)
    /* 5FBD4 8006F3D4 0CDD458C */  lw         $a1, %lo(D_8010DD0C)($v0)
    /* 5FBD8 8006F3D8 CA90030C */  jal        fixedmult
    /* 5FBDC 8006F3DC 00000000 */   nop
    /* 5FBE0 8006F3E0 21204000 */  addu       $a0, $v0, $zero
  .L8006F3E4:
    /* 5FBE4 8006F3E4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5FBE8 8006F3E8 1400B18F */  lw         $s1, 0x14($sp)
    /* 5FBEC 8006F3EC 1000B08F */  lw         $s0, 0x10($sp)
    /* 5FBF0 8006F3F0 21108000 */  addu       $v0, $a0, $zero
    /* 5FBF4 8006F3F4 0800E003 */  jr         $ra
    /* 5FBF8 8006F3F8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AISpeeds_GetUpgradeTopSpeedMult__Fi
