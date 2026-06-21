.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__27tMenuItemGoToMenuNFS4Button, 0xC

glabel TransitionOff__27tMenuItemGoToMenuNFS4Button
    /* AFC8 8001A7C8 F4FF0224 */  addiu      $v0, $zero, -0xC
    /* AFCC 8001A7CC 0800E003 */  jr         $ra
    /* AFD0 8001A7D0 280082A4 */   sh        $v0, 0x28($a0)
endlabel TransitionOff__27tMenuItemGoToMenuNFS4Button
