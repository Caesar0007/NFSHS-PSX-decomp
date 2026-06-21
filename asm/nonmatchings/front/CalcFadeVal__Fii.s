.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcFadeVal__Fii, 0x24

glabel CalcFadeVal__Fii
    /* 3C088 8004B888 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3C08C 8004B88C 2130A000 */  addu       $a2, $a1, $zero
    /* 3C090 8004B890 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3C094 8004B894 FE2D010C */  jal        CalcFadeVal__Fiii
    /* 3C098 8004B898 21280000 */   addu      $a1, $zero, $zero
    /* 3C09C 8004B89C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3C0A0 8004B8A0 00000000 */  nop
    /* 3C0A4 8004B8A4 0800E003 */  jr         $ra
    /* 3C0A8 8004B8A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CalcFadeVal__Fii
