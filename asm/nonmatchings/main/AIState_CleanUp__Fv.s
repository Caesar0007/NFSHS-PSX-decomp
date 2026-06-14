.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIState_CleanUp__Fv, 0x8

glabel AIState_CleanUp__Fv
    /* 601E4 8006F9E4 0800E003 */  jr         $ra
    /* 601E8 8006F9E8 00000000 */   nop
endlabel AIState_CleanUp__Fv
