.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Speech_HandleRequest__Fllll, 0x20

glabel Speech_HandleRequest__Fllll
    /* 84B34 80094334 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 84B38 80094338 1000BFAF */  sw         $ra, 0x10($sp)
    /* 84B3C 8009433C 0857020C */  jal        SubmitRequest__6Speechlll
    /* 84B40 80094340 00000000 */   nop
    /* 84B44 80094344 1000BF8F */  lw         $ra, 0x10($sp)
    /* 84B48 80094348 00000000 */  nop
    /* 84B4C 8009434C 0800E003 */  jr         $ra
    /* 84B50 80094350 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Speech_HandleRequest__Fllll
