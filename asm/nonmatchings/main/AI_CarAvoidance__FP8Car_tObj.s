.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_CarAvoidance__FP8Car_tObj, 0x44

glabel AI_CarAvoidance__FP8Car_tObj
    /* 48194 80057994 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 48198 80057998 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4819C 8005799C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 481A0 800579A0 A561010C */  jal        AI_SetupOncomingLaneDemerits__FP8Car_tObj
    /* 481A4 800579A4 21808000 */   addu      $s0, $a0, $zero
    /* 481A8 800579A8 4863010C */  jal        AI_CalculateLaneSpeeds__FP8Car_tObj
    /* 481AC 800579AC 21200002 */   addu      $a0, $s0, $zero
    /* 481B0 800579B0 2D64010C */  jal        AI_CalcMeritsBasedOnSpeed__FP8Car_tObj
    /* 481B4 800579B4 21200002 */   addu      $a0, $s0, $zero
    /* 481B8 800579B8 0D65010C */  jal        AI_CheckForClearLanes__FP8Car_tObj
    /* 481BC 800579BC 21200002 */   addu      $a0, $s0, $zero
    /* 481C0 800579C0 2367010C */  jal        AI_CheckForCarsOnSide__FP8Car_tObj
    /* 481C4 800579C4 21200002 */   addu      $a0, $s0, $zero
    /* 481C8 800579C8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 481CC 800579CC 1000B08F */  lw         $s0, 0x10($sp)
    /* 481D0 800579D0 0800E003 */  jr         $ra
    /* 481D4 800579D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_CarAvoidance__FP8Car_tObj
