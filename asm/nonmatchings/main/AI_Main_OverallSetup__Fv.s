.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_Main_OverallSetup__Fv, 0x8

glabel AI_Main_OverallSetup__Fv
    /* 4818C 8005798C 0800E003 */  jr         $ra
    /* 48190 80057990 00000000 */   nop
endlabel AI_Main_OverallSetup__Fv
