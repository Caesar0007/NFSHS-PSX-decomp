.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___20tDialogMessageString, 0x20

glabel ___20tDialogMessageString
    /* A784 80019F84 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A788 80019F88 1000BFAF */  sw         $ra, 0x10($sp)
    /* A78C 80019F8C 1E98000C */  jal        ___7tScreen
    /* A790 80019F90 00000000 */   nop
    /* A794 80019F94 1000BF8F */  lw         $ra, 0x10($sp)
    /* A798 80019F98 00000000 */  nop
    /* A79C 80019F9C 0800E003 */  jr         $ra
    /* A7A0 80019FA0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___20tDialogMessageString
