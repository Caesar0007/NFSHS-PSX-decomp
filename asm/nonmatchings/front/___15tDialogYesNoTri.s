.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___15tDialogYesNoTri, 0x20

glabel ___15tDialogYesNoTri
    /* A6C4 80019EC4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A6C8 80019EC8 1000BFAF */  sw         $ra, 0x10($sp)
    /* A6CC 80019ECC 1E98000C */  jal        ___7tScreen
    /* A6D0 80019ED0 00000000 */   nop
    /* A6D4 80019ED4 1000BF8F */  lw         $ra, 0x10($sp)
    /* A6D8 80019ED8 00000000 */  nop
    /* A6DC 80019EDC 0800E003 */  jr         $ra
    /* A6E0 80019EE0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___15tDialogYesNoTri
