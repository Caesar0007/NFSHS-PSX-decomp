.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___31tMenuItemDisplayLeftRightChoice, 0x20

glabel ___31tMenuItemDisplayLeftRightChoice
    /* 11478 80020C78 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1147C 80020C7C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 11480 80020C80 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 11484 80020C84 00000000 */   nop
    /* 11488 80020C88 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1148C 80020C8C 00000000 */  nop
    /* 11490 80020C90 0800E003 */  jr         $ra
    /* 11494 80020C94 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___31tMenuItemDisplayLeftRightChoice
