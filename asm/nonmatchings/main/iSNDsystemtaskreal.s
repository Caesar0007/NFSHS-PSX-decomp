.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDsystemtaskreal, 0x20

glabel iSNDsystemtaskreal
    /* E2930 800F2130 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E2934 800F2134 1000BFAF */  sw         $ra, 0x10($sp)
    /* E2938 800F2138 1E12040C */  jal        SNDSYS_service
    /* E293C 800F213C 00000000 */   nop
    /* E2940 800F2140 1000BF8F */  lw         $ra, 0x10($sp)
    /* E2944 800F2144 21100000 */  addu       $v0, $zero, $zero
    /* E2948 800F2148 0800E003 */  jr         $ra
    /* E294C 800F214C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDsystemtaskreal
