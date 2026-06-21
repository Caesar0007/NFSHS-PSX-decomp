.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching IsSubMenu__12tMenuOptions, 0x8

glabel IsSubMenu__12tMenuOptions
    /* C6F0 8001BEF0 0800E003 */  jr         $ra
    /* C6F4 8001BEF4 01000224 */   addiu     $v0, $zero, 0x1
endlabel IsSubMenu__12tMenuOptions
