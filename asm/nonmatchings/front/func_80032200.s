.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80032200, 0x8

glabel func_80032200
    /* 22A00 80032200 0800E003 */  jr         $ra
    /* 22A04 80032204 00000000 */   nop
endlabel func_80032200
