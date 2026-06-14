.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_GenericEndCycle__FP8Car_tObj, 0x34

glabel AI_GenericEndCycle__FP8Car_tObj
    /* 482E8 80057AE8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 482EC 80057AEC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 482F0 80057AF0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 482F4 80057AF4 7767010C */  jal        AI_ProcessObservationsAndChooseLane__FP8Car_tObj
    /* 482F8 80057AF8 21808000 */   addu      $s0, $a0, $zero
    /* 482FC 80057AFC 5768010C */  jal        AI_CalculateDesiredLatPosition__FP8Car_tObj
    /* 48300 80057B00 21200002 */   addu      $a0, $s0, $zero
    /* 48304 80057B04 E468010C */  jal        AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj
    /* 48308 80057B08 21200002 */   addu      $a0, $s0, $zero
    /* 4830C 80057B0C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 48310 80057B10 1000B08F */  lw         $s0, 0x10($sp)
    /* 48314 80057B14 0800E003 */  jr         $ra
    /* 48318 80057B18 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_GenericEndCycle__FP8Car_tObj
