.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_CheckGamedata__Fv, 0x8

glabel Physics_CheckGamedata__Fv
    /* 99674 800A8E74 0800E003 */  jr         $ra
    /* 99678 800A8E78 00000000 */   nop
endlabel Physics_CheckGamedata__Fv
