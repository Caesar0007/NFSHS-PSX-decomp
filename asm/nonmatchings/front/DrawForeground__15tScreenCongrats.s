.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawForeground__15tScreenCongrats, 0x8

glabel DrawForeground__15tScreenCongrats
    /* 391B0 800489B0 0800E003 */  jr         $ra
    /* 391B4 800489B4 00000000 */   nop
endlabel DrawForeground__15tScreenCongrats
