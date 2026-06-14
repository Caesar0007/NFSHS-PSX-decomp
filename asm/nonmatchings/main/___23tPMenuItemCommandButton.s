.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___23tPMenuItemCommandButton, 0x28

glabel ___23tPMenuItemCommandButton
    /* 986F4 800A7EF4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 986F8 800A7EF8 0580023C */  lui        $v0, %hi(_vt_23tPMenuItemCommandButton)
    /* 986FC 800A7EFC 44614224 */  addiu      $v0, $v0, %lo(_vt_23tPMenuItemCommandButton)
    /* 98700 800A7F00 1000BFAF */  sw         $ra, 0x10($sp)
    /* 98704 800A7F04 429D020C */  jal        ___21tPMenuItemInteractive
    /* 98708 800A7F08 080082AC */   sw        $v0, 0x8($a0)
    /* 9870C 800A7F0C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 98710 800A7F10 00000000 */  nop
    /* 98714 800A7F14 0800E003 */  jr         $ra
    /* 98718 800A7F18 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___23tPMenuItemCommandButton
