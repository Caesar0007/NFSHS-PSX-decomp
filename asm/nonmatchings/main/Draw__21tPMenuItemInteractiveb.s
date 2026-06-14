.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__21tPMenuItemInteractiveb, 0x28

glabel Draw__21tPMenuItemInteractiveb
    /* 97D30 800A7530 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97D34 800A7534 1000BFAF */  sw         $ra, 0x10($sp)
    /* 97D38 800A7538 0000868C */  lw         $a2, 0x0($a0)
    /* 97D3C 800A753C 04008484 */  lh         $a0, 0x4($a0)
    /* 97D40 800A7540 E39B020C */  jal        PauseMenu_MenuText__FsbT1
    /* 97D44 800A7544 0100C630 */   andi      $a2, $a2, 0x1
    /* 97D48 800A7548 1000BF8F */  lw         $ra, 0x10($sp)
    /* 97D4C 800A754C 00000000 */  nop
    /* 97D50 800A7550 0800E003 */  jr         $ra
    /* 97D54 800A7554 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Draw__21tPMenuItemInteractiveb
