.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___32tBlankMenuItemGoToMenuNFS4Button, 0x20

glabel ___32tBlankMenuItemGoToMenuNFS4Button
    /* 229D8 800321D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 229DC 800321DC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 229E0 800321E0 4569000C */  jal        ___27tMenuItemGoToMenuNFS4Button
    /* 229E4 800321E4 00000000 */   nop
    /* 229E8 800321E8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 229EC 800321EC 00000000 */  nop
    /* 229F0 800321F0 0800E003 */  jr         $ra
    /* 229F4 800321F4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___32tBlankMenuItemGoToMenuNFS4Button
