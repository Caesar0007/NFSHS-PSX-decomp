.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___10AIHigh_Cop, 0x20

glabel ___10AIHigh_Cop
    /* 5646C 80065C6C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 56470 80065C70 1000BFAF */  sw         $ra, 0x10($sp)
    /* 56474 80065C74 F16C010C */  jal        ___11AIHigh_Base
    /* 56478 80065C78 00000000 */   nop
    /* 5647C 80065C7C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 56480 80065C80 00000000 */  nop
    /* 56484 80065C84 0800E003 */  jr         $ra
    /* 56488 80065C88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___10AIHigh_Cop
