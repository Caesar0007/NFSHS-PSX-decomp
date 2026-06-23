.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___31tDialogMessageStringWithTimeout, 0x20

glabel ___31tDialogMessageStringWithTimeout
    /* 5F60 80015760 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5F64 80015764 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5F68 80015768 1E98000C */  jal        ___7tScreen
    /* 5F6C 8001576C 00000000 */   nop
    /* 5F70 80015770 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5F74 80015774 00000000 */  nop
    /* 5F78 80015778 0800E003 */  jr         $ra
    /* 5F7C 8001577C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___31tDialogMessageStringWithTimeout
