.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___20tMenuItemSlidingMenu, 0x28

glabel ___20tMenuItemSlidingMenu
    /* DA08 8001D208 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DA0C 8001D20C 0180023C */  lui        $v0, %hi(_vt_20tMenuItemSlidingMenu)
    /* DA10 8001D210 480E4224 */  addiu      $v0, $v0, %lo(_vt_20tMenuItemSlidingMenu)
    /* DA14 8001D214 1000BFAF */  sw         $ra, 0x10($sp)
    /* DA18 8001D218 D991000C */  jal        ___9tMenuItem
    /* DA1C 8001D21C 180082AC */   sw        $v0, 0x18($a0)
    /* DA20 8001D220 1000BF8F */  lw         $ra, 0x10($sp)
    /* DA24 8001D224 00000000 */  nop
    /* DA28 8001D228 0800E003 */  jr         $ra
    /* DA2C 8001D22C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___20tMenuItemSlidingMenu
