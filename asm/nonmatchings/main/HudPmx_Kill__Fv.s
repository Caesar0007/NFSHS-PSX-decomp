.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HudPmx_Kill__Fv, 0x24

glabel HudPmx_Kill__Fv
    /* 83730 80092F30 5818848F */  lw         $a0, %gp_rel(D_8013DDA4)($gp)
    /* 83734 80092F34 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 83738 80092F38 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8373C 80092F3C 5095030C */  jal        purgememadr
    /* 83740 80092F40 00000000 */   nop
    /* 83744 80092F44 1000BF8F */  lw         $ra, 0x10($sp)
    /* 83748 80092F48 00000000 */  nop
    /* 8374C 80092F4C 0800E003 */  jr         $ra
    /* 83750 80092F50 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel HudPmx_Kill__Fv
