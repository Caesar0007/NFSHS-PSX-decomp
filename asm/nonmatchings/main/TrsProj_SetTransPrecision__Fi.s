.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrsProj_SetTransPrecision__Fi, 0xC

glabel TrsProj_SetTransPrecision__Fi
    /* D212C 800E192C 501684AF */  sw         $a0, %gp_rel(TrsProj_precision)($gp)
    /* D2130 800E1930 0800E003 */  jr         $ra
    /* D2134 800E1934 00000000 */   nop
endlabel TrsProj_SetTransPrecision__Fi
