.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___15tDialogYesNoMem, 0x20

glabel ___15tDialogYesNoMem
    /* A6E4 80019EE4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A6E8 80019EE8 1000BFAF */  sw         $ra, 0x10($sp)
    /* A6EC 80019EEC 1E98000C */  jal        ___7tScreen
    /* A6F0 80019EF0 00000000 */   nop
    /* A6F4 80019EF4 1000BF8F */  lw         $ra, 0x10($sp)
    /* A6F8 80019EF8 00000000 */  nop
    /* A6FC 80019EFC 0800E003 */  jr         $ra
    /* A700 80019F00 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___15tDialogYesNoMem
