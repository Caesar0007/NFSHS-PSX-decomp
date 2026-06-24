.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iFILE_perror, 0x8

glabel iFILE_perror
    /* DD8D4 800ED0D4 0800E003 */  jr         $ra
    /* DD8D8 800ED0D8 00000000 */   nop
endlabel iFILE_perror
