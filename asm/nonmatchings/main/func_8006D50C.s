.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8006D50C, 0x8

glabel func_8006D50C
    /* 5DD0C 8006D50C 0800E003 */  jr         $ra
    /* 5DD10 8006D510 21100000 */   addu      $v0, $zero, $zero
endlabel func_8006D50C
