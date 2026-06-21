.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Increment__16tListIteratorCar7tPlayer, 0x20

glabel Increment__16tListIteratorCar7tPlayer
    /* 8894 80018094 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8898 80018098 1000BFAF */  sw         $ra, 0x10($sp)
    /* 889C 8001809C A75E000C */  jal        AdjustPosition__16tListIteratorCar7tPlayers
    /* 88A0 800180A0 01000624 */   addiu     $a2, $zero, 0x1
    /* 88A4 800180A4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 88A8 800180A8 00000000 */  nop
    /* 88AC 800180AC 0800E003 */  jr         $ra
    /* 88B0 800180B0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Increment__16tListIteratorCar7tPlayer
