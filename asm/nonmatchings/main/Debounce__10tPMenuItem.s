.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Debounce__10tPMenuItem, 0x8

glabel Debounce__10tPMenuItem
    /* 97C40 800A7440 0800E003 */  jr         $ra
    /* 97C44 800A7444 01000224 */   addiu     $v0, $zero, 0x1
endlabel Debounce__10tPMenuItem
