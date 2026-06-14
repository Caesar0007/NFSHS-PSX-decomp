.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Scene_Init__Fi, 0x14

glabel Scene_Init__Fi
    /* A677C 800B5F7C 02008018 */  blez       $a0, .L800B5F88
    /* A6780 800B5F80 00000000 */   nop
    /* A6784 800B5F84 BC0E80AF */  sw         $zero, %gp_rel(gGameSceneList)($gp)
  .L800B5F88:
    /* A6788 800B5F88 0800E003 */  jr         $ra
    /* A678C 800B5F8C 00000000 */   nop
endlabel Scene_Init__Fi
