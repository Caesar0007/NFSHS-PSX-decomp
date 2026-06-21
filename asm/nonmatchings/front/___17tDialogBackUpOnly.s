.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___17tDialogBackUpOnly, 0x20

glabel ___17tDialogBackUpOnly
    /* A764 80019F64 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A768 80019F68 1000BFAF */  sw         $ra, 0x10($sp)
    /* A76C 80019F6C 1E98000C */  jal        ___7tScreen
    /* A770 80019F70 00000000 */   nop
    /* A774 80019F74 1000BF8F */  lw         $ra, 0x10($sp)
    /* A778 80019F78 00000000 */  nop
    /* A77C 80019F7C 0800E003 */  jr         $ra
    /* A780 80019F80 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___17tDialogBackUpOnly
