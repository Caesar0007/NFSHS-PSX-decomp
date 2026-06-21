.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__25tMenuItemSlidingActivated, 0x2C

glabel TransitionOff__25tMenuItemSlidingActivated
    /* E5D4 8001DDD4 1C00828C */  lw         $v0, 0x1C($a0)
    /* E5D8 8001DDD8 01000324 */  addiu      $v1, $zero, 0x1
    /* E5DC 8001DDDC 2E0080A4 */  sh         $zero, 0x2E($a0)
    /* E5E0 8001DDE0 05004010 */  beqz       $v0, .L8001DDF8
    /* E5E4 8001DDE4 340083AC */   sw        $v1, 0x34($a0)
    /* E5E8 8001DDE8 1E000224 */  addiu      $v0, $zero, 0x1E
    /* E5EC 8001DDEC 300083AC */  sw         $v1, 0x30($a0)
    /* E5F0 8001DDF0 2E0082A4 */  sh         $v0, 0x2E($a0)
    /* E5F4 8001DDF4 2C0080A4 */  sh         $zero, 0x2C($a0)
  .L8001DDF8:
    /* E5F8 8001DDF8 0800E003 */  jr         $ra
    /* E5FC 8001DDFC 00000000 */   nop
endlabel TransitionOff__25tMenuItemSlidingActivated
