.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___11tDialogBase, 0x20

glabel ___11tDialogBase
    /* A7C4 80019FC4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A7C8 80019FC8 1000BFAF */  sw         $ra, 0x10($sp)
    /* A7CC 80019FCC 1E98000C */  jal        ___7tScreen
    /* A7D0 80019FD0 00000000 */   nop
    /* A7D4 80019FD4 1000BF8F */  lw         $ra, 0x10($sp)
    /* A7D8 80019FD8 00000000 */  nop
    /* A7DC 80019FDC 0800E003 */  jr         $ra
    /* A7E0 80019FE0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___11tDialogBase
    /* A7E4 80019FE4 00000000 */  nop
