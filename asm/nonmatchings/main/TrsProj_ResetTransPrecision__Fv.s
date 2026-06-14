.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrsProj_ResetTransPrecision__Fv, 0x10

glabel TrsProj_ResetTransPrecision__Fv
    /* D2138 800E1938 0A000224 */  addiu      $v0, $zero, 0xA
    /* D213C 800E193C 501682AF */  sw         $v0, %gp_rel(TrsProj_precision)($gp)
    /* D2140 800E1940 0800E003 */  jr         $ra
    /* D2144 800E1944 00000000 */   nop
endlabel TrsProj_ResetTransPrecision__Fv
