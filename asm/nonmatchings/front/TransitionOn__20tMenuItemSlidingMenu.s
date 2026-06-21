.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__20tMenuItemSlidingMenu, 0x38

glabel TransitionOn__20tMenuItemSlidingMenu
    /* DA5C 8001D25C 26008394 */  lhu        $v1, 0x26($a0)
    /* DA60 8001D260 E2FF0224 */  addiu      $v0, $zero, -0x1E
    /* DA64 8001D264 2E0082A4 */  sh         $v0, 0x2E($a0)
    /* DA68 8001D268 01000224 */  addiu      $v0, $zero, 0x1
    /* DA6C 8001D26C 300082AC */  sw         $v0, 0x30($a0)
    /* DA70 8001D270 80000224 */  addiu      $v0, $zero, 0x80
    /* DA74 8001D274 280080A4 */  sh         $zero, 0x28($a0)
    /* DA78 8001D278 340080AC */  sw         $zero, 0x34($a0)
    /* DA7C 8001D27C 2C0082A4 */  sh         $v0, 0x2C($a0)
    /* DA80 8001D280 00140300 */  sll        $v0, $v1, 16
    /* DA84 8001D284 43140200 */  sra        $v0, $v0, 17
    /* DA88 8001D288 21186200 */  addu       $v1, $v1, $v0
    /* DA8C 8001D28C 0800E003 */  jr         $ra
    /* DA90 8001D290 2A0083A4 */   sh        $v1, 0x2A($a0)
endlabel TransitionOn__20tMenuItemSlidingMenu
