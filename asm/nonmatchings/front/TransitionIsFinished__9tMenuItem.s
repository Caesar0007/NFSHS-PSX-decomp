.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__9tMenuItem, 0x8

glabel TransitionIsFinished__9tMenuItem
    /* 14FC8 800247C8 0800E003 */  jr         $ra
    /* 14FCC 800247CC 01000224 */   addiu     $v0, $zero, 0x1
endlabel TransitionIsFinished__9tMenuItem
