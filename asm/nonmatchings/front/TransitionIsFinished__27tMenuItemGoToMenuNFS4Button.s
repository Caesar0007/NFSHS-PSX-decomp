.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__27tMenuItemGoToMenuNFS4Button, 0xC

glabel TransitionIsFinished__27tMenuItemGoToMenuNFS4Button
    /* AFD4 8001A7D4 28008284 */  lh         $v0, 0x28($a0)
    /* AFD8 8001A7D8 0800E003 */  jr         $ra
    /* AFDC 8001A7DC 0100422C */   sltiu     $v0, $v0, 0x1
endlabel TransitionIsFinished__27tMenuItemGoToMenuNFS4Button
