.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Get__26AIDataRecord_CarTracking_ti, 0x8

glabel Get__26AIDataRecord_CarTracking_ti
    /* 5DD0C 8006D50C 0800E003 */  jr         $ra
    /* 5DD10 8006D510 21100000 */   addu      $v0, $zero, $zero
endlabel Get__26AIDataRecord_CarTracking_ti
