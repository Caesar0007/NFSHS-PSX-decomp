.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__27tMenuItemGoToMenuNFS4Button, 0x10

glabel TransitionOn__27tMenuItemGoToMenuNFS4Button
    /* AFB8 8001A7B8 0C000224 */  addiu      $v0, $zero, 0xC
    /* AFBC 8001A7BC 2A0080A4 */  sh         $zero, 0x2A($a0)
    /* AFC0 8001A7C0 0800E003 */  jr         $ra
    /* AFC4 8001A7C4 280082A4 */   sh        $v0, 0x28($a0)
endlabel TransitionOn__27tMenuItemGoToMenuNFS4Button
