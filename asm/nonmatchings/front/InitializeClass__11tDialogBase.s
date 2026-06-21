.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitializeClass__11tDialogBase, 0x20

glabel InitializeClass__11tDialogBase
    /* 8F00 80018700 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8F04 80018704 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8F08 80018708 FC61000C */  jal        HideAllDialogs__11tDialogBase
    /* 8F0C 8001870C 00000000 */   nop
    /* 8F10 80018710 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8F14 80018714 00000000 */  nop
    /* 8F18 80018718 0800E003 */  jr         $ra
    /* 8F1C 8001871C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel InitializeClass__11tDialogBase
