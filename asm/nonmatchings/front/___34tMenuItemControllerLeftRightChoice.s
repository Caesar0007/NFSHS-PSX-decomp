.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___34tMenuItemControllerLeftRightChoice, 0x20

glabel ___34tMenuItemControllerLeftRightChoice
    /* 11438 80020C38 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1143C 80020C3C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 11440 80020C40 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 11444 80020C44 00000000 */   nop
    /* 11448 80020C48 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1144C 80020C4C 00000000 */  nop
    /* 11450 80020C50 0800E003 */  jr         $ra
    /* 11454 80020C54 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___34tMenuItemControllerLeftRightChoice
