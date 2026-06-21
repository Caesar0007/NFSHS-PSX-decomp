.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___17tUserNameMenuItem, 0x20

glabel ___17tUserNameMenuItem
    /* 11418 80020C18 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1141C 80020C1C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 11420 80020C20 D991000C */  jal        ___9tMenuItem
    /* 11424 80020C24 00000000 */   nop
    /* 11428 80020C28 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1142C 80020C2C 00000000 */  nop
    /* 11430 80020C30 0800E003 */  jr         $ra
    /* 11434 80020C34 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___17tUserNameMenuItem
