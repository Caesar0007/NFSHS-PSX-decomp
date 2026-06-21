.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800321C0, 0x8

glabel func_800321C0
    /* 229C0 800321C0 0800E003 */  jr         $ra
    /* 229C4 800321C4 01000224 */   addiu     $v0, $zero, 0x1
endlabel func_800321C0
