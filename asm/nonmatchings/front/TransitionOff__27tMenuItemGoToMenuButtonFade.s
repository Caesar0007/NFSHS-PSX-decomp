.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__27tMenuItemGoToMenuButtonFade, 0xC

glabel TransitionOff__27tMenuItemGoToMenuButtonFade
    /* CA5C 8001C25C 1E000224 */  addiu      $v0, $zero, 0x1E
    /* CA60 8001C260 0800E003 */  jr         $ra
    /* CA64 8001C264 220082A4 */   sh        $v0, 0x22($a0)
endlabel TransitionOff__27tMenuItemGoToMenuButtonFade
