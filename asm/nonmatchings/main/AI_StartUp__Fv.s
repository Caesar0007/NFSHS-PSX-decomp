.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_StartUp__Fv, 0x8

glabel AI_StartUp__Fv
    /* 4817C 8005797C 0800E003 */  jr         $ra
    /* 48180 80057980 00000000 */   nop
endlabel AI_StartUp__Fv
