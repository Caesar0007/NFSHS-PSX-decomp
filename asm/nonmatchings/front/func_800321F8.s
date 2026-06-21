.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800321F8, 0x8

glabel func_800321F8
    /* 229F8 800321F8 0800E003 */  jr         $ra
    /* 229FC 800321FC 01000224 */   addiu     $v0, $zero, 0x1
endlabel func_800321F8
