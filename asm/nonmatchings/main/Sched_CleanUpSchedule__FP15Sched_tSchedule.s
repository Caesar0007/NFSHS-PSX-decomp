.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sched_CleanUpSchedule__FP15Sched_tSchedule, 0x20

glabel Sched_CleanUpSchedule__FP15Sched_tSchedule
    /* A6B60 800B6360 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A6B64 800B6364 1000BFAF */  sw         $ra, 0x10($sp)
    /* A6B68 800B6368 5095030C */  jal        purgememadr
    /* A6B6C 800B636C 00000000 */   nop
    /* A6B70 800B6370 1000BF8F */  lw         $ra, 0x10($sp)
    /* A6B74 800B6374 00000000 */  nop
    /* A6B78 800B6378 0800E003 */  jr         $ra
    /* A6B7C 800B637C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Sched_CleanUpSchedule__FP15Sched_tSchedule
