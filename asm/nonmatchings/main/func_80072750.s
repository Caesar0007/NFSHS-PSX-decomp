.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80072750, 0x8

glabel func_80072750
    /* 62F50 80072750 0800E003 */  jr         $ra
    /* 62F54 80072754 00000000 */   nop
endlabel func_80072750
