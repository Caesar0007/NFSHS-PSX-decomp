.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching setclipwindow, 0x8

glabel setclipwindow
    /* E6914 800F6114 0800E003 */  jr         $ra
    /* E6918 800F6118 21100000 */   addu      $v0, $zero, $zero
endlabel setclipwindow
