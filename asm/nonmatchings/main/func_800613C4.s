.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800613C4, 0x8

glabel func_800613C4
    /* 51BC4 800613C4 0800E003 */  jr         $ra
    /* 51BC8 800613C8 21100000 */   addu      $v0, $zero, $zero
endlabel func_800613C4
