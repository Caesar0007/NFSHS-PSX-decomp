.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib, 0x8

glabel Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib
    /* 229C8 800321C8 0800E003 */  jr         $ra
    /* 229CC 800321CC 00000000 */   nop
endlabel Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib
