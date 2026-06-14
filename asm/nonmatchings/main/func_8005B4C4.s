.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8005B4C4, 0x8

glabel func_8005B4C4
    /* 4BCC4 8005B4C4 0800E003 */  jr         $ra
    /* 4BCC8 8005B4C8 21100000 */   addu      $v0, $zero, $zero
endlabel func_8005B4C4
