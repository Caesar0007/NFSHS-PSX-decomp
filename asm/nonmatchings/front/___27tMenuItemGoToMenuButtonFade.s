.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___27tMenuItemGoToMenuButtonFade, 0x20

glabel ___27tMenuItemGoToMenuButtonFade
    /* 113F8 80020BF8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 113FC 80020BFC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 11400 80020C00 DF94000C */  jal        ___23tMenuItemGoToMenuButton
    /* 11404 80020C04 00000000 */   nop
    /* 11408 80020C08 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1140C 80020C0C 00000000 */  nop
    /* 11410 80020C10 0800E003 */  jr         $ra
    /* 11414 80020C14 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___27tMenuItemGoToMenuButtonFade
