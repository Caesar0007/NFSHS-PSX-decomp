.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___21tDialogNoInputMessage, 0x20

glabel ___21tDialogNoInputMessage
    /* A744 80019F44 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A748 80019F48 1000BFAF */  sw         $ra, 0x10($sp)
    /* A74C 80019F4C 1E98000C */  jal        ___7tScreen
    /* A750 80019F50 00000000 */   nop
    /* A754 80019F54 1000BF8F */  lw         $ra, 0x10($sp)
    /* A758 80019F58 00000000 */  nop
    /* A75C 80019F5C 0800E003 */  jr         $ra
    /* A760 80019F60 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___21tDialogNoInputMessage
