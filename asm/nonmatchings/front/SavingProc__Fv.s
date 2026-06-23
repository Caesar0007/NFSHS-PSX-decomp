.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SavingProc__Fv, 0x28

glabel SavingProc__Fv
    /* 24E7C 8003467C 0580023C */  lui        $v0, %hi(FEApp)
    /* 24E80 80034680 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 24E84 80034684 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 24E88 80034688 1000BFAF */  sw         $ra, 0x10($sp)
    /* 24E8C 8003468C CF4D000C */  jal        Redraw__14tFEApplication
    /* 24E90 80034690 00000000 */   nop
    /* 24E94 80034694 1000BF8F */  lw         $ra, 0x10($sp)
    /* 24E98 80034698 00000000 */  nop
    /* 24E9C 8003469C 0800E003 */  jr         $ra
    /* 24EA0 800346A0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SavingProc__Fv
