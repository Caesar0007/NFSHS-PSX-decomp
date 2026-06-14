.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_GenericCycle__FP8Car_tObj, 0x54

glabel AI_GenericCycle__FP8Car_tObj
    /* 48294 80057A94 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 48298 80057A98 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4829C 80057A9C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 482A0 80057AA0 306A010C */  jal        AI_MaybeChangeLaneSlack__FP8Car_tObj
    /* 482A4 80057AA4 21808000 */   addu      $s0, $a0, $zero
    /* 482A8 80057AA8 0560010C */  jal        AI_DoReactionsAndBehavior__FP8Car_tObj
    /* 482AC 80057AAC 21200002 */   addu      $a0, $s0, $zero
    /* 482B0 80057AB0 C969010C */  jal        AI_PushFinishedCarsToSide__FP8Car_tObj
    /* 482B4 80057AB4 21200002 */   addu      $a0, $s0, $zero
    /* 482B8 80057AB8 C569010C */  jal        AI_KeepCarsInLane__FP8Car_tObj
    /* 482BC 80057ABC 21200002 */   addu      $a0, $s0, $zero
    /* 482C0 80057AC0 E266010C */  jal        AI_HandleTrafficHonking__FP8Car_tObj
    /* 482C4 80057AC4 21200002 */   addu      $a0, $s0, $zero
    /* 482C8 80057AC8 655E010C */  jal        AI_CarAvoidance__FP8Car_tObj
    /* 482CC 80057ACC 21200002 */   addu      $a0, $s0, $zero
    /* 482D0 80057AD0 765E010C */  jal        AI_WorldAvoidance__FP8Car_tObj
    /* 482D4 80057AD4 21200002 */   addu      $a0, $s0, $zero
    /* 482D8 80057AD8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 482DC 80057ADC 1000B08F */  lw         $s0, 0x10($sp)
    /* 482E0 80057AE0 0800E003 */  jr         $ra
    /* 482E4 80057AE4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_GenericCycle__FP8Car_tObj
