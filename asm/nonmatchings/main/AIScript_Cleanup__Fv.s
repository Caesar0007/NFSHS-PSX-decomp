.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIScript_Cleanup__Fv, 0x8

glabel AIScript_Cleanup__Fv
    /* 5FF60 8006F760 0800E003 */  jr         $ra
    /* 5FF64 8006F764 00000000 */   nop
endlabel AIScript_Cleanup__Fv
