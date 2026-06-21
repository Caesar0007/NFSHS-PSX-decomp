.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__5tMenu, 0x8

glabel TransitionIsFinished__5tMenu
    /* 1624C 80025A4C 0800E003 */  jr         $ra
    /* 16250 80025A50 01000224 */   addiu     $v0, $zero, 0x1
endlabel TransitionIsFinished__5tMenu
