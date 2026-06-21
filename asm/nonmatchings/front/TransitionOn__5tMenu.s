.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__5tMenu, 0x8

glabel TransitionOn__5tMenu
    /* 16244 80025A44 0800E003 */  jr         $ra
    /* 16248 80025A48 00000000 */   nop
endlabel TransitionOn__5tMenu
