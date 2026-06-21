.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__28tMenuItemNFS4LeftRightChoice, 0xC

glabel TransitionIsFinished__28tMenuItemNFS4LeftRightChoice
    /* B378 8001AB78 24008284 */  lh         $v0, 0x24($a0)
    /* B37C 8001AB7C 0800E003 */  jr         $ra
    /* B380 8001AB80 0100422C */   sltiu     $v0, $v0, 0x1
endlabel TransitionIsFinished__28tMenuItemNFS4LeftRightChoice
