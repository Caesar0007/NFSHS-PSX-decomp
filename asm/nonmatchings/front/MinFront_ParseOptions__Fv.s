.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MinFront_ParseOptions__Fv, 0x48

glabel MinFront_ParseOptions__Fv
    /* 30F0 800128F0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 30F4 800128F4 0180043C */  lui        $a0, %hi(D_8001000C)
    /* 30F8 800128F8 0C008424 */  addiu      $a0, $a0, %lo(D_8001000C)
    /* 30FC 800128FC 00200524 */  addiu      $a1, $zero, 0x2000
    /* 3100 80012900 10000624 */  addiu      $a2, $zero, 0x10
    /* 3104 80012904 1400BFAF */  sw         $ra, 0x14($sp)
    /* 3108 80012908 CF94030C */  jal        reservememadr
    /* 310C 8001290C 1000B0AF */   sw        $s0, 0x10($sp)
    /* 3110 80012910 21804000 */  addu       $s0, $v0, $zero
    /* 3114 80012914 21200002 */  addu       $a0, $s0, $zero
    /* 3118 80012918 04000524 */  addiu      $a1, $zero, 0x4
    /* 311C 8001291C 54C6030C */  jal        resizememadr
    /* 3120 80012920 000000AE */   sw        $zero, 0x0($s0)
    /* 3124 80012924 21100002 */  addu       $v0, $s0, $zero
    /* 3128 80012928 1400BF8F */  lw         $ra, 0x14($sp)
    /* 312C 8001292C 1000B08F */  lw         $s0, 0x10($sp)
    /* 3130 80012930 0800E003 */  jr         $ra
    /* 3134 80012934 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MinFront_ParseOptions__Fv
