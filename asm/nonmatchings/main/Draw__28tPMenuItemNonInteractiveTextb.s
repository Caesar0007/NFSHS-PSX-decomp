.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__28tPMenuItemNonInteractiveTextb, 0x28

glabel Draw__28tPMenuItemNonInteractiveTextb
    /* 97CAC 800A74AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97CB0 800A74B0 21280000 */  addu       $a1, $zero, $zero
    /* 97CB4 800A74B4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 97CB8 800A74B8 04008484 */  lh         $a0, 0x4($a0)
    /* 97CBC 800A74BC E39B020C */  jal        PauseMenu_MenuText__FsbT1
    /* 97CC0 800A74C0 2130A000 */   addu      $a2, $a1, $zero
    /* 97CC4 800A74C4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 97CC8 800A74C8 00000000 */  nop
    /* 97CCC 800A74CC 0800E003 */  jr         $ra
    /* 97CD0 800A74D0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Draw__28tPMenuItemNonInteractiveTextb
