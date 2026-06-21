.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__28tMenuItemNFS4LeftRightChoice, 0x10

glabel TransitionOn__28tMenuItemNFS4LeftRightChoice
    /* B35C 8001AB5C 0C000224 */  addiu      $v0, $zero, 0xC
    /* B360 8001AB60 260080A4 */  sh         $zero, 0x26($a0)
    /* B364 8001AB64 0800E003 */  jr         $ra
    /* B368 8001AB68 240082A4 */   sh        $v0, 0x24($a0)
endlabel TransitionOn__28tMenuItemNFS4LeftRightChoice
