.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Math_NormalizeShortVector__FP8coorddef, 0xAC

glabel Math_NormalizeShortVector__FP8coorddef
    /* 8E3D4 8009DBD4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 8E3D8 8009DBD8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8E3DC 8009DBDC 21908000 */  addu       $s2, $a0, $zero
    /* 8E3E0 8009DBE0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 8E3E4 8009DBE4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8E3E8 8009DBE8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8E3EC 8009DBEC 0000448E */  lw         $a0, 0x0($s2)
    /* 8E3F0 8009DBF0 CA90030C */  jal        fixedmult
    /* 8E3F4 8009DBF4 21288000 */   addu      $a1, $a0, $zero
    /* 8E3F8 8009DBF8 0400448E */  lw         $a0, 0x4($s2)
    /* 8E3FC 8009DBFC 21804000 */  addu       $s0, $v0, $zero
    /* 8E400 8009DC00 CA90030C */  jal        fixedmult
    /* 8E404 8009DC04 21288000 */   addu      $a1, $a0, $zero
    /* 8E408 8009DC08 0800448E */  lw         $a0, 0x8($s2)
    /* 8E40C 8009DC0C 21884000 */  addu       $s1, $v0, $zero
    /* 8E410 8009DC10 CA90030C */  jal        fixedmult
    /* 8E414 8009DC14 21288000 */   addu      $a1, $a0, $zero
    /* 8E418 8009DC18 21801102 */  addu       $s0, $s0, $s1
    /* 8E41C 8009DC1C 2BAC030C */  jal        fixedsqrt
    /* 8E420 8009DC20 21200202 */   addu      $a0, $s0, $v0
    /* 8E424 8009DC24 10004010 */  beqz       $v0, .L8009DC68
    /* 8E428 8009DC28 0100043C */   lui       $a0, (0x10000 >> 16)
    /* 8E42C 8009DC2C 0191030C */  jal        rdiv
    /* 8E430 8009DC30 21284000 */   addu      $a1, $v0, $zero
    /* 8E434 8009DC34 21804000 */  addu       $s0, $v0, $zero
    /* 8E438 8009DC38 0000448E */  lw         $a0, 0x0($s2)
    /* 8E43C 8009DC3C CA90030C */  jal        fixedmult
    /* 8E440 8009DC40 21280002 */   addu      $a1, $s0, $zero
    /* 8E444 8009DC44 0400448E */  lw         $a0, 0x4($s2)
    /* 8E448 8009DC48 21280002 */  addu       $a1, $s0, $zero
    /* 8E44C 8009DC4C CA90030C */  jal        fixedmult
    /* 8E450 8009DC50 000042AE */   sw        $v0, 0x0($s2)
    /* 8E454 8009DC54 0800448E */  lw         $a0, 0x8($s2)
    /* 8E458 8009DC58 21280002 */  addu       $a1, $s0, $zero
    /* 8E45C 8009DC5C CA90030C */  jal        fixedmult
    /* 8E460 8009DC60 040042AE */   sw        $v0, 0x4($s2)
    /* 8E464 8009DC64 080042AE */  sw         $v0, 0x8($s2)
  .L8009DC68:
    /* 8E468 8009DC68 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 8E46C 8009DC6C 1800B28F */  lw         $s2, 0x18($sp)
    /* 8E470 8009DC70 1400B18F */  lw         $s1, 0x14($sp)
    /* 8E474 8009DC74 1000B08F */  lw         $s0, 0x10($sp)
    /* 8E478 8009DC78 0800E003 */  jr         $ra
    /* 8E47C 8009DC7C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Math_NormalizeShortVector__FP8coorddef
