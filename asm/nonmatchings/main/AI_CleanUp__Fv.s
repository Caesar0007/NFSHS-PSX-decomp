.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_CleanUp__Fv, 0x8

glabel AI_CleanUp__Fv
    /* 48184 80057984 0800E003 */  jr         $ra
    /* 48188 80057988 00000000 */   nop
endlabel AI_CleanUp__Fv
