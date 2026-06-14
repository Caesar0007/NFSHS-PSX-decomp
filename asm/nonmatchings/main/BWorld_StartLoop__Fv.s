.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_StartLoop__Fv, 0x8

glabel BWorld_StartLoop__Fv
    /* 6EDC0 8007E5C0 0800E003 */  jr         $ra
    /* 6EDC4 8007E5C4 00000000 */   nop
endlabel BWorld_StartLoop__Fv
