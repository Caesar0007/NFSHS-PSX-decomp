.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__5tMenu, 0x8

glabel TransitionOff__5tMenu
    /* 1623C 80025A3C 0800E003 */  jr         $ra
    /* 16240 80025A40 00000000 */   nop
endlabel TransitionOff__5tMenu
