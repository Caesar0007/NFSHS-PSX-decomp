.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__29tMenuItemLeftRightAudioSlider, 0x10

glabel TransitionOff__29tMenuItemLeftRightAudioSlider
    /* F050 8001E850 3C000224 */  addiu      $v0, $zero, 0x3C
    /* F054 8001E854 280080A4 */  sh         $zero, 0x28($a0)
    /* F058 8001E858 0800E003 */  jr         $ra
    /* F05C 8001E85C 2A0082A4 */   sh        $v0, 0x2A($a0)
endlabel TransitionOff__29tMenuItemLeftRightAudioSlider
