.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80034618, 0x8

glabel func_80034618
    /* 24E18 80034618 0800E003 */  jr         $ra
    /* 24E1C 8003461C 01000224 */   addiu     $v0, $zero, 0x1
endlabel func_80034618
