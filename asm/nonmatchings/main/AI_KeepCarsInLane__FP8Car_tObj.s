.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_KeepCarsInLane__FP8Car_tObj, 0x10

glabel AI_KeepCarsInLane__FP8Car_tObj
    /* 4AF14 8005A714 F0FFBD27 */  addiu      $sp, $sp, -0x10
    /* 4AF18 8005A718 1000BD27 */  addiu      $sp, $sp, 0x10
    /* 4AF1C 8005A71C 0800E003 */  jr         $ra
    /* 4AF20 8005A720 00000000 */   nop
endlabel AI_KeepCarsInLane__FP8Car_tObj
