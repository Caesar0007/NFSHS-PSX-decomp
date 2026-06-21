.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__22tMenuItemLeftRightFade, 0x18

glabel TransitionOff__22tMenuItemLeftRightFade
    /* CB94 8001C394 01000224 */  addiu      $v0, $zero, 0x1
    /* CB98 8001C398 240082AC */  sw         $v0, 0x24($a0)
    /* CB9C 8001C39C 1E000224 */  addiu      $v0, $zero, 0x1E
    /* CBA0 8001C3A0 220082A4 */  sh         $v0, 0x22($a0)
    /* CBA4 8001C3A4 0800E003 */  jr         $ra
    /* CBA8 8001C3A8 200080A4 */   sh        $zero, 0x20($a0)
endlabel TransitionOff__22tMenuItemLeftRightFade
