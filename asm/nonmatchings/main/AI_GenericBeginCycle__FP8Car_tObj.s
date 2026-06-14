.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_GenericBeginCycle__FP8Car_tObj, 0x28

glabel AI_GenericBeginCycle__FP8Car_tObj
    /* 4826C 80057A6C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 48270 80057A70 1000BFAF */  sw         $ra, 0x10($sp)
    /* 48274 80057A74 895E010C */  jal        AI_InitAIInfo__FP8Car_tObj
    /* 48278 80057A78 00000000 */   nop
    /* 4827C 80057A7C DB5E010C */  jal        AI_ClearLaneMerits__Fv
    /* 48280 80057A80 00000000 */   nop
    /* 48284 80057A84 1000BF8F */  lw         $ra, 0x10($sp)
    /* 48288 80057A88 00000000 */  nop
    /* 4828C 80057A8C 0800E003 */  jr         $ra
    /* 48290 80057A90 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_GenericBeginCycle__FP8Car_tObj
