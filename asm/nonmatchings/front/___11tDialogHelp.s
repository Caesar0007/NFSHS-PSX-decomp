.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___11tDialogHelp, 0x20

glabel ___11tDialogHelp
    /* A7A4 80019FA4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A7A8 80019FA8 1000BFAF */  sw         $ra, 0x10($sp)
    /* A7AC 80019FAC 1E98000C */  jal        ___7tScreen
    /* A7B0 80019FB0 00000000 */   nop
    /* A7B4 80019FB4 1000BF8F */  lw         $ra, 0x10($sp)
    /* A7B8 80019FB8 00000000 */  nop
    /* A7BC 80019FBC 0800E003 */  jr         $ra
    /* A7C0 80019FC0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___11tDialogHelp
