.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__29tMenuItemLeftRightAudioSlider, 0x18

glabel TransitionOn__29tMenuItemLeftRightAudioSlider
    /* F060 8001E860 80000224 */  addiu      $v0, $zero, 0x80
    /* F064 8001E864 280082A4 */  sh         $v0, 0x28($a0)
    /* F068 8001E868 C4FF0224 */  addiu      $v0, $zero, -0x3C
    /* F06C 8001E86C 2A0082A4 */  sh         $v0, 0x2A($a0)
    /* F070 8001E870 0800E003 */  jr         $ra
    /* F074 8001E874 080080A4 */   sh        $zero, 0x8($a0)
endlabel TransitionOn__29tMenuItemLeftRightAudioSlider
