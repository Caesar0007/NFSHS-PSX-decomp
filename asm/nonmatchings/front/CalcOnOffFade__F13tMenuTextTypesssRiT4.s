.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcOnOffFade__F13tMenuTextTypesssRiT4, 0x160

glabel CalcOnOffFade__F13tMenuTextTypesssRiT4
    /* 3C1D4 8004B9D4 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 3C1D8 8004B9D8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 3C1DC 8004B9DC 2198C000 */  addu       $s3, $a2, $zero
    /* 3C1E0 8004B9E0 2000B4AF */  sw         $s4, 0x20($sp)
    /* 3C1E4 8004B9E4 21A0E000 */  addu       $s4, $a3, $zero
    /* 3C1E8 8004B9E8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3C1EC 8004B9EC 008C0500 */  sll        $s1, $a1, 16
    /* 3C1F0 8004B9F0 038C1100 */  sra        $s1, $s1, 16
    /* 3C1F4 8004B9F4 21302002 */  addu       $a2, $s1, $zero
    /* 3C1F8 8004B9F8 0580073C */  lui        $a3, %hi(kRGBVals)
    /* 3C1FC 8004B9FC C816E724 */  addiu      $a3, $a3, %lo(kRGBVals)
    /* 3C200 8004BA00 0580053C */  lui        $a1, %hi(textDefinitions)
    /* 3C204 8004BA04 B815A524 */  addiu      $a1, $a1, %lo(textDefinitions)
    /* 3C208 8004BA08 40180400 */  sll        $v1, $a0, 1
    /* 3C20C 8004BA0C 21186400 */  addu       $v1, $v1, $a0
    /* 3C210 8004BA10 40180300 */  sll        $v1, $v1, 1
    /* 3C214 8004BA14 21106500 */  addu       $v0, $v1, $a1
    /* 3C218 8004BA18 21206500 */  addu       $a0, $v1, $a1
    /* 3C21C 8004BA1C 21186500 */  addu       $v1, $v1, $a1
    /* 3C220 8004BA20 3400BFAF */  sw         $ra, 0x34($sp)
    /* 3C224 8004BA24 3000BEAF */  sw         $fp, 0x30($sp)
    /* 3C228 8004BA28 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 3C22C 8004BA2C 2800B6AF */  sw         $s6, 0x28($sp)
    /* 3C230 8004BA30 2400B5AF */  sw         $s5, 0x24($sp)
    /* 3C234 8004BA34 1800B2AF */  sw         $s2, 0x18($sp)
    /* 3C238 8004BA38 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3C23C 8004BA3C 04004290 */  lbu        $v0, 0x4($v0)
    /* 3C240 8004BA40 4800B78F */  lw         $s7, 0x48($sp)
    /* 3C244 8004BA44 4C00BE8F */  lw         $fp, 0x4C($sp)
    /* 3C248 8004BA48 80100200 */  sll        $v0, $v0, 2
    /* 3C24C 8004BA4C 21104700 */  addu       $v0, $v0, $a3
    /* 3C250 8004BA50 0000508C */  lw         $s0, 0x0($v0)
    /* 3C254 8004BA54 05008290 */  lbu        $v0, 0x5($a0)
    /* 3C258 8004BA58 21200002 */  addu       $a0, $s0, $zero
    /* 3C25C 8004BA5C 80100200 */  sll        $v0, $v0, 2
    /* 3C260 8004BA60 21104700 */  addu       $v0, $v0, $a3
    /* 3C264 8004BA64 0000528C */  lw         $s2, 0x0($v0)
    /* 3C268 8004BA68 03006290 */  lbu        $v0, 0x3($v1)
    /* 3C26C 8004BA6C 00000000 */  nop
    /* 3C270 8004BA70 80100200 */  sll        $v0, $v0, 2
    /* 3C274 8004BA74 21104700 */  addu       $v0, $v0, $a3
    /* 3C278 8004BA78 0000558C */  lw         $s5, 0x0($v0)
    /* 3C27C 8004BA7C FE2D010C */  jal        CalcFadeVal__Fiii
    /* 3C280 8004BA80 21284002 */   addu      $a1, $s2, $zero
    /* 3C284 8004BA84 21204002 */  addu       $a0, $s2, $zero
    /* 3C288 8004BA88 21280002 */  addu       $a1, $s0, $zero
    /* 3C28C 8004BA8C 21302002 */  addu       $a2, $s1, $zero
    /* 3C290 8004BA90 FE2D010C */  jal        CalcFadeVal__Fiii
    /* 3C294 8004BA94 21904000 */   addu      $s2, $v0, $zero
    /* 3C298 8004BA98 21280002 */  addu       $a1, $s0, $zero
    /* 3C29C 8004BA9C 21302002 */  addu       $a2, $s1, $zero
    /* 3C2A0 8004BAA0 21B04000 */  addu       $s6, $v0, $zero
    /* 3C2A4 8004BAA4 FE2D010C */  jal        CalcFadeVal__Fiii
    /* 3C2A8 8004BAA8 2120A002 */   addu      $a0, $s5, $zero
    /* 3C2AC 8004BAAC 21200002 */  addu       $a0, $s0, $zero
    /* 3C2B0 8004BAB0 2128A002 */  addu       $a1, $s5, $zero
    /* 3C2B4 8004BAB4 21302002 */  addu       $a2, $s1, $zero
    /* 3C2B8 8004BAB8 FE2D010C */  jal        CalcFadeVal__Fiii
    /* 3C2BC 8004BABC 21804000 */   addu      $s0, $v0, $zero
    /* 3C2C0 8004BAC0 21200002 */  addu       $a0, $s0, $zero
    /* 3C2C4 8004BAC4 21284002 */  addu       $a1, $s2, $zero
    /* 3C2C8 8004BAC8 009C1300 */  sll        $s3, $s3, 16
    /* 3C2CC 8004BACC 039C1300 */  sra        $s3, $s3, 16
    /* 3C2D0 8004BAD0 21306002 */  addu       $a2, $s3, $zero
    /* 3C2D4 8004BAD4 00A41400 */  sll        $s4, $s4, 16
    /* 3C2D8 8004BAD8 03A41400 */  sra        $s4, $s4, 16
    /* 3C2DC 8004BADC 21388002 */  addu       $a3, $s4, $zero
    /* 3C2E0 8004BAE0 2B2E010C */  jal        CalcFadeVal__Fiiii
    /* 3C2E4 8004BAE4 21804000 */   addu      $s0, $v0, $zero
    /* 3C2E8 8004BAE8 21200002 */  addu       $a0, $s0, $zero
    /* 3C2EC 8004BAEC 2128C002 */  addu       $a1, $s6, $zero
    /* 3C2F0 8004BAF0 21306002 */  addu       $a2, $s3, $zero
    /* 3C2F4 8004BAF4 21388002 */  addu       $a3, $s4, $zero
    /* 3C2F8 8004BAF8 2B2E010C */  jal        CalcFadeVal__Fiiii
    /* 3C2FC 8004BAFC 0000E2AE */   sw        $v0, 0x0($s7)
    /* 3C300 8004BB00 0000C2AF */  sw         $v0, 0x0($fp)
    /* 3C304 8004BB04 3400BF8F */  lw         $ra, 0x34($sp)
    /* 3C308 8004BB08 3000BE8F */  lw         $fp, 0x30($sp)
    /* 3C30C 8004BB0C 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 3C310 8004BB10 2800B68F */  lw         $s6, 0x28($sp)
    /* 3C314 8004BB14 2400B58F */  lw         $s5, 0x24($sp)
    /* 3C318 8004BB18 2000B48F */  lw         $s4, 0x20($sp)
    /* 3C31C 8004BB1C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 3C320 8004BB20 1800B28F */  lw         $s2, 0x18($sp)
    /* 3C324 8004BB24 1400B18F */  lw         $s1, 0x14($sp)
    /* 3C328 8004BB28 1000B08F */  lw         $s0, 0x10($sp)
    /* 3C32C 8004BB2C 0800E003 */  jr         $ra
    /* 3C330 8004BB30 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CalcOnOffFade__F13tMenuTextTypesssRiT4
    /* 3C334 8004BB34 00000000 */  nop
