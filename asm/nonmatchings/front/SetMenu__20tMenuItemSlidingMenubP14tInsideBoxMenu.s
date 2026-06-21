.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetMenu__20tMenuItemSlidingMenubP14tInsideBoxMenu, 0x44

glabel SetMenu__20tMenuItemSlidingMenubP14tInsideBoxMenu
    /* E528 8001DD28 0200A010 */  beqz       $a1, .L8001DD34
    /* E52C 8001DD2C 200086AC */   sw        $a2, 0x20($a0)
    /* E530 8001DD30 1C0086AC */  sw         $a2, 0x1C($a0)
  .L8001DD34:
    /* E534 8001DD34 2000828C */  lw         $v0, 0x20($a0)
    /* E538 8001DD38 00000000 */  nop
    /* E53C 8001DD3C 06004014 */  bnez       $v0, .L8001DD58
    /* E540 8001DD40 FEFF0324 */   addiu     $v1, $zero, -0x2
    /* E544 8001DD44 0000828C */  lw         $v0, 0x0($a0)
    /* E548 8001DD48 00000000 */  nop
    /* E54C 8001DD4C 01004234 */  ori        $v0, $v0, 0x1
    /* E550 8001DD50 0800E003 */  jr         $ra
    /* E554 8001DD54 000082AC */   sw        $v0, 0x0($a0)
  .L8001DD58:
    /* E558 8001DD58 0000828C */  lw         $v0, 0x0($a0)
    /* E55C 8001DD5C 00000000 */  nop
    /* E560 8001DD60 24104300 */  and        $v0, $v0, $v1
    /* E564 8001DD64 0800E003 */  jr         $ra
    /* E568 8001DD68 000082AC */   sw        $v0, 0x0($a0)
endlabel SetMenu__20tMenuItemSlidingMenubP14tInsideBoxMenu
