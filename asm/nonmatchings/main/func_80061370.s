.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80061370, 0x8

glabel func_80061370
    /* 51B70 80061370 0800E003 */  jr         $ra
    /* 51B74 80061374 00000000 */   nop
endlabel func_80061370
