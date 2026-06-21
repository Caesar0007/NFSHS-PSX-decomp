.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadConfig__Fv, 0x8

glabel LoadConfig__Fv
    /* 18140 80027940 0800E003 */  jr         $ra
    /* 18144 80027944 21100000 */   addu      $v0, $zero, $zero
endlabel LoadConfig__Fv
