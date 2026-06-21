.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__25tMenuItemSlidingActivated, 0x40

glabel TransitionOn__25tMenuItemSlidingActivated
    /* E600 8001DE00 26008394 */  lhu        $v1, 0x26($a0)
    /* E604 8001DE04 E2FF0224 */  addiu      $v0, $zero, -0x1E
    /* E608 8001DE08 2E0082A4 */  sh         $v0, 0x2E($a0)
    /* E60C 8001DE0C 01000224 */  addiu      $v0, $zero, 0x1
    /* E610 8001DE10 300082AC */  sw         $v0, 0x30($a0)
    /* E614 8001DE14 80000224 */  addiu      $v0, $zero, 0x80
    /* E618 8001DE18 440080AC */  sw         $zero, 0x44($a0)
    /* E61C 8001DE1C 340080AC */  sw         $zero, 0x34($a0)
    /* E620 8001DE20 2C0082A4 */  sh         $v0, 0x2C($a0)
    /* E624 8001DE24 00140300 */  sll        $v0, $v1, 16
    /* E628 8001DE28 43140200 */  sra        $v0, $v0, 17
    /* E62C 8001DE2C 21286000 */  addu       $a1, $v1, $zero
    /* E630 8001DE30 21186200 */  addu       $v1, $v1, $v0
    /* E634 8001DE34 2A0083A4 */  sh         $v1, 0x2A($a0)
    /* E638 8001DE38 0800E003 */  jr         $ra
    /* E63C 8001DE3C 280085A4 */   sh        $a1, 0x28($a0)
endlabel TransitionOn__25tMenuItemSlidingActivated
