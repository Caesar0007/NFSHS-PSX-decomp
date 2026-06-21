.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__7tScreen, 0x8

glabel DrawBackground__7tScreen
    /* 170E8 800268E8 0800E003 */  jr         $ra
    /* 170EC 800268EC 00000000 */   nop
endlabel DrawBackground__7tScreen
