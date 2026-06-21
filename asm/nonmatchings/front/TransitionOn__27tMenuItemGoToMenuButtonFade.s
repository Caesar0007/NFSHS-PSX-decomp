.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__27tMenuItemGoToMenuButtonFade, 0x1C

glabel TransitionOn__27tMenuItemGoToMenuButtonFade
    /* CA68 8001C268 80000224 */  addiu      $v0, $zero, 0x80
    /* CA6C 8001C26C 200082A4 */  sh         $v0, 0x20($a0)
    /* CA70 8001C270 E2FF0224 */  addiu      $v0, $zero, -0x1E
    /* CA74 8001C274 220082A4 */  sh         $v0, 0x22($a0)
    /* CA78 8001C278 080080A4 */  sh         $zero, 0x8($a0)
    /* CA7C 8001C27C 0800E003 */  jr         $ra
    /* CA80 8001C280 280080A4 */   sh        $zero, 0x28($a0)
endlabel TransitionOn__27tMenuItemGoToMenuButtonFade
