.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___12tDialogYesNo, 0x20

glabel ___12tDialogYesNo
    /* A704 80019F04 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A708 80019F08 1000BFAF */  sw         $ra, 0x10($sp)
    /* A70C 80019F0C 1E98000C */  jal        ___7tScreen
    /* A710 80019F10 00000000 */   nop
    /* A714 80019F14 1000BF8F */  lw         $ra, 0x10($sp)
    /* A718 80019F18 00000000 */  nop
    /* A71C 80019F1C 0800E003 */  jr         $ra
    /* A720 80019F20 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___12tDialogYesNo
