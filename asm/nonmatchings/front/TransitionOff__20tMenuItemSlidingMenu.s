.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__20tMenuItemSlidingMenu, 0x2C

glabel TransitionOff__20tMenuItemSlidingMenu
    /* DA30 8001D230 1C00828C */  lw         $v0, 0x1C($a0)
    /* DA34 8001D234 01000324 */  addiu      $v1, $zero, 0x1
    /* DA38 8001D238 2E0080A4 */  sh         $zero, 0x2E($a0)
    /* DA3C 8001D23C 05004010 */  beqz       $v0, .L8001D254
    /* DA40 8001D240 340083AC */   sw        $v1, 0x34($a0)
    /* DA44 8001D244 1E000224 */  addiu      $v0, $zero, 0x1E
    /* DA48 8001D248 300083AC */  sw         $v1, 0x30($a0)
    /* DA4C 8001D24C 2E0082A4 */  sh         $v0, 0x2E($a0)
    /* DA50 8001D250 2C0080A4 */  sh         $zero, 0x2C($a0)
  .L8001D254:
    /* DA54 8001D254 0800E003 */  jr         $ra
    /* DA58 8001D258 00000000 */   nop
endlabel TransitionOff__20tMenuItemSlidingMenu
