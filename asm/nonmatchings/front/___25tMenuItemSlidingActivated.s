.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___25tMenuItemSlidingActivated, 0x20

glabel ___25tMenuItemSlidingActivated
    /* 11498 80020C98 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1149C 80020C9C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 114A0 80020CA0 8274000C */  jal        ___20tMenuItemSlidingMenu
    /* 114A4 80020CA4 00000000 */   nop
    /* 114A8 80020CA8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 114AC 80020CAC 00000000 */  nop
    /* 114B0 80020CB0 0800E003 */  jr         $ra
    /* 114B4 80020CB4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___25tMenuItemSlidingActivated
