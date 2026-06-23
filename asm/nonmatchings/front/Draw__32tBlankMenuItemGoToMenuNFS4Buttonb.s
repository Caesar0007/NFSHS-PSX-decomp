.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__32tBlankMenuItemGoToMenuNFS4Buttonb, 0x8

glabel Draw__32tBlankMenuItemGoToMenuNFS4Buttonb
    /* 229D0 800321D0 0800E003 */  jr         $ra
    /* 229D4 800321D4 00000000 */   nop
endlabel Draw__32tBlankMenuItemGoToMenuNFS4Buttonb
