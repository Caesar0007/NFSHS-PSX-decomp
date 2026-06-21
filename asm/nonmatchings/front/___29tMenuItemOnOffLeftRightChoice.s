.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___29tMenuItemOnOffLeftRightChoice, 0x20

glabel ___29tMenuItemOnOffLeftRightChoice
    /* 11458 80020C58 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1145C 80020C5C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 11460 80020C60 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* 11464 80020C64 00000000 */   nop
    /* 11468 80020C68 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1146C 80020C6C 00000000 */  nop
    /* 11470 80020C70 0800E003 */  jr         $ra
    /* 11474 80020C74 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___29tMenuItemOnOffLeftRightChoice
