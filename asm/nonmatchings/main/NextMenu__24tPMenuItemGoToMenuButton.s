.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NextMenu__24tPMenuItemGoToMenuButton, 0xC

glabel NextMenu__24tPMenuItemGoToMenuButton
    /* 985F0 800A7DF0 0C00828C */  lw         $v0, 0xC($a0)
    /* 985F4 800A7DF4 0800E003 */  jr         $ra
    /* 985F8 800A7DF8 00000000 */   nop
endlabel NextMenu__24tPMenuItemGoToMenuButton
