.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching IsSubMenu__5tMenu, 0x8

glabel IsSubMenu__5tMenu
    /* 16254 80025A54 0800E003 */  jr         $ra
    /* 16258 80025A58 21100000 */   addu      $v0, $zero, $zero
endlabel IsSubMenu__5tMenu
