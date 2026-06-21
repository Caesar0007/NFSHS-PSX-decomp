.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__27tMenuItemGoToMenuButtonFade, 0x58

glabel TransitionIsFinished__27tMenuItemGoToMenuButtonFade
    /* CA84 8001C284 22008284 */  lh         $v0, 0x22($a0)
    /* CA88 8001C288 00000000 */  nop
    /* CA8C 8001C28C 05004104 */  bgez       $v0, .L8001C2A4
    /* CA90 8001C290 240080AC */   sw        $zero, 0x24($a0)
    /* CA94 8001C294 20008284 */  lh         $v0, 0x20($a0)
    /* CA98 8001C298 00000000 */  nop
    /* CA9C 8001C29C 0B00401C */  bgtz       $v0, .L8001C2CC
    /* CAA0 8001C2A0 01000224 */   addiu     $v0, $zero, 0x1
  .L8001C2A4:
    /* CAA4 8001C2A4 22008284 */  lh         $v0, 0x22($a0)
    /* CAA8 8001C2A8 00000000 */  nop
    /* CAAC 8001C2AC 08004018 */  blez       $v0, .L8001C2D0
    /* CAB0 8001C2B0 00000000 */   nop
    /* CAB4 8001C2B4 20008284 */  lh         $v0, 0x20($a0)
    /* CAB8 8001C2B8 00000000 */  nop
    /* CABC 8001C2BC 80004228 */  slti       $v0, $v0, 0x80
    /* CAC0 8001C2C0 03004010 */  beqz       $v0, .L8001C2D0
    /* CAC4 8001C2C4 00000000 */   nop
    /* CAC8 8001C2C8 01000224 */  addiu      $v0, $zero, 0x1
  .L8001C2CC:
    /* CACC 8001C2CC 240082AC */  sw         $v0, 0x24($a0)
  .L8001C2D0:
    /* CAD0 8001C2D0 2400828C */  lw         $v0, 0x24($a0)
    /* CAD4 8001C2D4 0800E003 */  jr         $ra
    /* CAD8 8001C2D8 01004238 */   xori      $v0, $v0, 0x1
endlabel TransitionIsFinished__27tMenuItemGoToMenuButtonFade
