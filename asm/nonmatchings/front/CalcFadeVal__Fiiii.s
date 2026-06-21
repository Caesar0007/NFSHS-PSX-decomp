.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcFadeVal__Fiiii, 0x34

glabel CalcFadeVal__Fiiii
    /* 3C0AC 8004B8AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3C0B0 8004B8B0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3C0B4 8004B8B4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 3C0B8 8004B8B8 FE2D010C */  jal        CalcFadeVal__Fiii
    /* 3C0BC 8004B8BC 2180E000 */   addu      $s0, $a3, $zero
    /* 3C0C0 8004B8C0 21204000 */  addu       $a0, $v0, $zero
    /* 3C0C4 8004B8C4 21280000 */  addu       $a1, $zero, $zero
    /* 3C0C8 8004B8C8 FE2D010C */  jal        CalcFadeVal__Fiii
    /* 3C0CC 8004B8CC 21300002 */   addu      $a2, $s0, $zero
    /* 3C0D0 8004B8D0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3C0D4 8004B8D4 1000B08F */  lw         $s0, 0x10($sp)
    /* 3C0D8 8004B8D8 0800E003 */  jr         $ra
    /* 3C0DC 8004B8DC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CalcFadeVal__Fiiii
