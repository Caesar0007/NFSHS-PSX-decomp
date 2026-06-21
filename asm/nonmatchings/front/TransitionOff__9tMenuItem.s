.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__9tMenuItem, 0x8

glabel TransitionOff__9tMenuItem
    /* 162B0 80025AB0 0800E003 */  jr         $ra
    /* 162B4 80025AB4 00000000 */   nop
endlabel TransitionOff__9tMenuItem
