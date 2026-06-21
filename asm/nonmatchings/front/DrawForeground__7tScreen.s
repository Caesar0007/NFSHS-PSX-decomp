.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawForeground__7tScreen, 0x8

glabel DrawForeground__7tScreen
    /* 170E0 800268E0 0800E003 */  jr         $ra
    /* 170E4 800268E4 00000000 */   nop
endlabel DrawForeground__7tScreen
