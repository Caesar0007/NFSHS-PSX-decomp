.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Deny__Q26Speech7Speaker, 0x8

glabel Deny__Q26Speech7Speaker
    /* 8651C 80095D1C 0800E003 */  jr         $ra
    /* 86520 80095D20 00000000 */   nop
endlabel Deny__Q26Speech7Speaker
