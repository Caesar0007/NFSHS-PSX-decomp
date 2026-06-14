.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_CalcLateralVelocity__FP8Car_tObj, 0x5C

glabel AIWorld_CalcLateralVelocity__FP8Car_tObj
    /* 6411C 8007391C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 64120 80073920 1400B1AF */  sw         $s1, 0x14($sp)
    /* 64124 80073924 21888000 */  addu       $s1, $a0, $zero
    /* 64128 80073928 1800BFAF */  sw         $ra, 0x18($sp)
    /* 6412C 8007392C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 64130 80073930 AC00248E */  lw         $a0, 0xAC($s1)
    /* 64134 80073934 4401258E */  lw         $a1, 0x144($s1)
    /* 64138 80073938 CA90030C */  jal        fixedmult
    /* 6413C 8007393C 00000000 */   nop
    /* 64140 80073940 B000248E */  lw         $a0, 0xB0($s1)
    /* 64144 80073944 4801258E */  lw         $a1, 0x148($s1)
    /* 64148 80073948 CA90030C */  jal        fixedmult
    /* 6414C 8007394C 21804000 */   addu      $s0, $v0, $zero
    /* 64150 80073950 B400248E */  lw         $a0, 0xB4($s1)
    /* 64154 80073954 4C01258E */  lw         $a1, 0x14C($s1)
    /* 64158 80073958 CA90030C */  jal        fixedmult
    /* 6415C 8007395C 21800202 */   addu      $s0, $s0, $v0
    /* 64160 80073960 21100202 */  addu       $v0, $s0, $v0
    /* 64164 80073964 1800BF8F */  lw         $ra, 0x18($sp)
    /* 64168 80073968 1400B18F */  lw         $s1, 0x14($sp)
    /* 6416C 8007396C 1000B08F */  lw         $s0, 0x10($sp)
    /* 64170 80073970 0800E003 */  jr         $ra
    /* 64174 80073974 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIWorld_CalcLateralVelocity__FP8Car_tObj
