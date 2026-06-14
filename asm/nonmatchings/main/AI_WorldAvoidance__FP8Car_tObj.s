.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_WorldAvoidance__FP8Car_tObj, 0x4C

glabel AI_WorldAvoidance__FP8Car_tObj
    /* 481D8 800579D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 481DC 800579DC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 481E0 800579E0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 481E4 800579E4 B560010C */  jal        AI_CheckForBarriers__FP8Car_tObj
    /* 481E8 800579E8 21808000 */   addu      $s0, $a0, $zero
    /* 481EC 800579EC FB61010C */  jal        AI_HandleChangeInNumLanes__FP8Car_tObj
    /* 481F0 800579F0 21200002 */   addu      $a0, $s0, $zero
    /* 481F4 800579F4 5762010C */  jal        AI_HandleShouldersAndOffRoad__FP8Car_tObj
    /* 481F8 800579F8 21200002 */   addu      $a0, $s0, $zero
    /* 481FC 800579FC A965010C */  jal        AI_CalcBestLineMerits__FP8Car_tObj
    /* 48200 80057A00 21200002 */   addu      $a0, $s0, $zero
    /* 48204 80057A04 4A66010C */  jal        AI_AvoidObjects__FP8Car_tObj
    /* 48208 80057A08 21200002 */   addu      $a0, $s0, $zero
    /* 4820C 80057A0C 5766010C */  jal        AI_AvoidSpikeBelt__FP8Car_tObj
    /* 48210 80057A10 21200002 */   addu      $a0, $s0, $zero
    /* 48214 80057A14 1400BF8F */  lw         $ra, 0x14($sp)
    /* 48218 80057A18 1000B08F */  lw         $s0, 0x10($sp)
    /* 4821C 80057A1C 0800E003 */  jr         $ra
    /* 48220 80057A20 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_WorldAvoidance__FP8Car_tObj
