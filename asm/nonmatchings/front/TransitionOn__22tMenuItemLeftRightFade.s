.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__22tMenuItemLeftRightFade, 0x24

glabel TransitionOn__22tMenuItemLeftRightFade
    /* CBAC 8001C3AC 01000224 */  addiu      $v0, $zero, 0x1
    /* CBB0 8001C3B0 240082AC */  sw         $v0, 0x24($a0)
    /* CBB4 8001C3B4 E2FF0224 */  addiu      $v0, $zero, -0x1E
    /* CBB8 8001C3B8 220082A4 */  sh         $v0, 0x22($a0)
    /* CBBC 8001C3BC 80000224 */  addiu      $v0, $zero, 0x80
    /* CBC0 8001C3C0 280080AC */  sw         $zero, 0x28($a0)
    /* CBC4 8001C3C4 080080A4 */  sh         $zero, 0x8($a0)
    /* CBC8 8001C3C8 0800E003 */  jr         $ra
    /* CBCC 8001C3CC 200082A4 */   sh        $v0, 0x20($a0)
endlabel TransitionOn__22tMenuItemLeftRightFade
