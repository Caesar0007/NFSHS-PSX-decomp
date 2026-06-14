.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___28tPMenuItemNonInteractiveText, 0x28

glabel ___28tPMenuItemNonInteractiveText
    /* 97C84 800A7484 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97C88 800A7488 0580023C */  lui        $v0, %hi(_vt_28tPMenuItemNonInteractiveText)
    /* 97C8C 800A748C 94624224 */  addiu      $v0, $v0, %lo(_vt_28tPMenuItemNonInteractiveText)
    /* 97C90 800A7490 1000BFAF */  sw         $ra, 0x10($sp)
    /* 97C94 800A7494 019D020C */  jal        ___10tPMenuItem
    /* 97C98 800A7498 080082AC */   sw        $v0, 0x8($a0)
    /* 97C9C 800A749C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 97CA0 800A74A0 00000000 */  nop
    /* 97CA4 800A74A4 0800E003 */  jr         $ra
    /* 97CA8 800A74A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___28tPMenuItemNonInteractiveText
