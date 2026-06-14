.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_DeInitContexts__Fv, 0x20

glabel BWorld_DeInitContexts__Fv
    /* 6EC60 8007E460 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6EC64 8007E464 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6EC68 8007E468 0AF9010C */  jal        BWorld_InitContexts__Fv
    /* 6EC6C 8007E46C 00000000 */   nop
    /* 6EC70 8007E470 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6EC74 8007E474 00000000 */  nop
    /* 6EC78 8007E478 0800E003 */  jr         $ra
    /* 6EC7C 8007E47C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel BWorld_DeInitContexts__Fv
