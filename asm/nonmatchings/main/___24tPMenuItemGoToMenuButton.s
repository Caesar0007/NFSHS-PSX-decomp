.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___24tPMenuItemGoToMenuButton, 0x28

glabel ___24tPMenuItemGoToMenuButton
    /* 985C8 800A7DC8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 985CC 800A7DCC 0580023C */  lui        $v0, %hi(_vt_24tPMenuItemGoToMenuButton)
    /* 985D0 800A7DD0 7C614224 */  addiu      $v0, $v0, %lo(_vt_24tPMenuItemGoToMenuButton)
    /* 985D4 800A7DD4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 985D8 800A7DD8 429D020C */  jal        ___21tPMenuItemInteractive
    /* 985DC 800A7DDC 080082AC */   sw        $v0, 0x8($a0)
    /* 985E0 800A7DE0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 985E4 800A7DE4 00000000 */  nop
    /* 985E8 800A7DE8 0800E003 */  jr         $ra
    /* 985EC 800A7DEC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___24tPMenuItemGoToMenuButton
