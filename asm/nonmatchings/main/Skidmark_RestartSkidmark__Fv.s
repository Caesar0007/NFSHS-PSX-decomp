.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Skidmark_RestartSkidmark__Fv, 0x14

glabel Skidmark_RestartSkidmark__Fv
    /* CFD78 800DF578 7C15828F */  lw         $v0, %gp_rel(gSm)($gp)
    /* CFD7C 800DF57C 801580AF */  sw         $zero, %gp_rel(gCountSm)($gp)
    /* CFD80 800DF580 841580AF */  sw         $zero, %gp_rel(gUseSm)($gp)
    /* CFD84 800DF584 0800E003 */  jr         $ra
    /* CFD88 800DF588 0C0040A4 */   sh        $zero, 0xC($v0)
endlabel Skidmark_RestartSkidmark__Fv
