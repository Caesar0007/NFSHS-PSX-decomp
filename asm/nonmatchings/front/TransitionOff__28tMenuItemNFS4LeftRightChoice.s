.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__28tMenuItemNFS4LeftRightChoice, 0xC

glabel TransitionOff__28tMenuItemNFS4LeftRightChoice
    /* B36C 8001AB6C F4FF0224 */  addiu      $v0, $zero, -0xC
    /* B370 8001AB70 0800E003 */  jr         $ra
    /* B374 8001AB74 240082A4 */   sh        $v0, 0x24($a0)
endlabel TransitionOff__28tMenuItemNFS4LeftRightChoice
