.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReActivate__Q26Speech7Speaker, 0x8

glabel ReActivate__Q26Speech7Speaker
    /* 89B84 80099384 0800E003 */  jr         $ra
    /* 89B88 80099388 00000000 */   nop
endlabel ReActivate__Q26Speech7Speaker
