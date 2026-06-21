.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Decrement__16tListIteratorCar7tPlayer, 0x20

glabel Decrement__16tListIteratorCar7tPlayer
    /* 88B4 800180B4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 88B8 800180B8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 88BC 800180BC A75E000C */  jal        AdjustPosition__16tListIteratorCar7tPlayers
    /* 88C0 800180C0 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 88C4 800180C4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 88C8 800180C8 00000000 */  nop
    /* 88CC 800180CC 0800E003 */  jr         $ra
    /* 88D0 800180D0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Decrement__16tListIteratorCar7tPlayer
