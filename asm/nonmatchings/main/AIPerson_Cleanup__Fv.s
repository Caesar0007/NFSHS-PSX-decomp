.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPerson_Cleanup__Fv, 0x8

glabel AIPerson_Cleanup__Fv
    /* 59A30 80069230 0800E003 */  jr         $ra
    /* 59A34 80069234 00000000 */   nop
endlabel AIPerson_Cleanup__Fv
