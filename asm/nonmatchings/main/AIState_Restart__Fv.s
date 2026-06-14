.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIState_Restart__Fv, 0x20

glabel AIState_Restart__Fv
    /* 601C4 8006F9C4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 601C8 8006F9C8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 601CC 8006F9CC 10C6010C */  jal        StartUp__17AIState_Purgatory
    /* 601D0 8006F9D0 00000000 */   nop
    /* 601D4 8006F9D4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 601D8 8006F9D8 00000000 */  nop
    /* 601DC 8006F9DC 0800E003 */  jr         $ra
    /* 601E0 8006F9E0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIState_Restart__Fv
