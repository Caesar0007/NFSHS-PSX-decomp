.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__20tMenuItemSlidingMenu, 0x88

glabel TransitionIsFinished__20tMenuItemSlidingMenu
    /* DA94 8001D294 1C00828C */  lw         $v0, 0x1C($a0)
    /* DA98 8001D298 00000000 */  nop
    /* DA9C 8001D29C 05004010 */  beqz       $v0, .L8001D2B4
    /* DAA0 8001D2A0 00000000 */   nop
    /* DAA4 8001D2A4 2000828C */  lw         $v0, 0x20($a0)
    /* DAA8 8001D2A8 00000000 */  nop
    /* DAAC 8001D2AC 04004014 */  bnez       $v0, .L8001D2C0
    /* DAB0 8001D2B0 00000000 */   nop
  .L8001D2B4:
    /* DAB4 8001D2B4 2E0080A4 */  sh         $zero, 0x2E($a0)
  .L8001D2B8:
    /* DAB8 8001D2B8 C4740008 */  j          .L8001D310
    /* DABC 8001D2BC 300080AC */   sw        $zero, 0x30($a0)
  .L8001D2C0:
    /* DAC0 8001D2C0 2E008284 */  lh         $v0, 0x2E($a0)
    /* DAC4 8001D2C4 00000000 */  nop
    /* DAC8 8001D2C8 FBFF4010 */  beqz       $v0, .L8001D2B8
    /* DACC 8001D2CC 00000000 */   nop
    /* DAD0 8001D2D0 06004104 */  bgez       $v0, .L8001D2EC
    /* DAD4 8001D2D4 00000000 */   nop
    /* DAD8 8001D2D8 2C008284 */  lh         $v0, 0x2C($a0)
    /* DADC 8001D2DC 00000000 */  nop
    /* DAE0 8001D2E0 F5FF4018 */  blez       $v0, .L8001D2B8
    /* DAE4 8001D2E4 00000000 */   nop
    /* DAE8 8001D2E8 2E008284 */  lh         $v0, 0x2E($a0)
  .L8001D2EC:
    /* DAEC 8001D2EC 00000000 */  nop
    /* DAF0 8001D2F0 06004018 */  blez       $v0, .L8001D30C
    /* DAF4 8001D2F4 01000224 */   addiu     $v0, $zero, 0x1
    /* DAF8 8001D2F8 2C008284 */  lh         $v0, 0x2C($a0)
    /* DAFC 8001D2FC 00000000 */  nop
    /* DB00 8001D300 80004228 */  slti       $v0, $v0, 0x80
    /* DB04 8001D304 ECFF4010 */  beqz       $v0, .L8001D2B8
    /* DB08 8001D308 01000224 */   addiu     $v0, $zero, 0x1
  .L8001D30C:
    /* DB0C 8001D30C 300082AC */  sw         $v0, 0x30($a0)
  .L8001D310:
    /* DB10 8001D310 3000828C */  lw         $v0, 0x30($a0)
    /* DB14 8001D314 0800E003 */  jr         $ra
    /* DB18 8001D318 01004238 */   xori      $v0, $v0, 0x1
endlabel TransitionIsFinished__20tMenuItemSlidingMenu
