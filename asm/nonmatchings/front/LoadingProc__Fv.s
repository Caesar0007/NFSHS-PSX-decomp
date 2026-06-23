.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadingProc__Fv, 0x8

glabel LoadingProc__Fv
    /* 24E4C 8003464C 0800E003 */  jr         $ra
    /* 24E50 80034650 00000000 */   nop
endlabel LoadingProc__Fv
