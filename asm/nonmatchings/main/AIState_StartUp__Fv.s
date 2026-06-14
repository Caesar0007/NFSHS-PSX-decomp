.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIState_StartUp__Fv, 0x20

glabel AIState_StartUp__Fv
    /* 601A4 8006F9A4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 601A8 8006F9A8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 601AC 8006F9AC 10C6010C */  jal        StartUp__17AIState_Purgatory
    /* 601B0 8006F9B0 00000000 */   nop
    /* 601B4 8006F9B4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 601B8 8006F9B8 00000000 */  nop
    /* 601BC 8006F9BC 0800E003 */  jr         $ra
    /* 601C0 8006F9C0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIState_StartUp__Fv
