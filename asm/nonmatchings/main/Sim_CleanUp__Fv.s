.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sim_CleanUp__Fv, 0xA4

glabel Sim_CleanUp__Fv
    /* A6F54 800B6754 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A6F58 800B6758 1400BFAF */  sw         $ra, 0x14($sp)
    /* A6F5C 800B675C 392C030C */  jal        Force_Disable__Fv
    /* A6F60 800B6760 1000B0AF */   sw        $s0, 0x10($sp)
    /* A6F64 800B6764 EEDC020C */  jal        SimQueue_CleanUp__Fv
    /* A6F68 800B6768 1280103C */   lui       $s0, %hi(simGlobal)
    /* A6F6C 800B676C ACE01026 */  addiu      $s0, $s0, %lo(simGlobal)
    /* A6F70 800B6770 0880053C */  lui        $a1, %hi(Camera_Update__Fv)
    /* A6F74 800B6774 D833A524 */  addiu      $a1, $a1, %lo(Camera_Update__Fv)
    /* A6F78 800B6778 0C00048E */  lw         $a0, 0xC($s0)
    /* A6F7C 800B677C 0DD9020C */  jal        Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* A6F80 800B6780 21300000 */   addu      $a2, $zero, $zero
    /* A6F84 800B6784 919B010C */  jal        AIInit_CleanUp2__Fv
    /* A6F88 800B6788 00000000 */   nop
    /* A6F8C 800B678C 616C010C */  jal        AIHigh_CleanUp__Fv
    /* A6F90 800B6790 00000000 */   nop
    /* A6F94 800B6794 902A020C */  jal        Cars_CleanUp__Fv
    /* A6F98 800B6798 00000000 */   nop
    /* A6F9C 800B679C D0B7020C */  jal        R3DCar_CleanUp__Fv
    /* A6FA0 800B67A0 00000000 */   nop
    /* A6FA4 800B67A4 DFEF020C */  jal        CarIO_CleanUp__Fv
    /* A6FA8 800B67A8 00000000 */   nop
    /* A6FAC 800B67AC 839B010C */  jal        AIInit_CleanUp1__Fv
    /* A6FB0 800B67B0 00000000 */   nop
    /* A6FB4 800B67B4 AA9A010C */  jal        AICop_CleanUp__Fv
    /* A6FB8 800B67B8 00000000 */   nop
    /* A6FBC 800B67BC F26C020C */  jal        FastRandom_CleanUp__Fv
    /* A6FC0 800B67C0 00000000 */   nop
    /* A6FC4 800B67C4 1000048E */  lw         $a0, 0x10($s0)
    /* A6FC8 800B67C8 D8D8020C */  jal        Sched_CleanUpSchedule__FP15Sched_tSchedule
    /* A6FCC 800B67CC 00000000 */   nop
    /* A6FD0 800B67D0 1400048E */  lw         $a0, 0x14($s0)
    /* A6FD4 800B67D4 D8D8020C */  jal        Sched_CleanUpSchedule__FP15Sched_tSchedule
    /* A6FD8 800B67D8 00000000 */   nop
    /* A6FDC 800B67DC 0C00048E */  lw         $a0, 0xC($s0)
    /* A6FE0 800B67E0 D8D8020C */  jal        Sched_CleanUpSchedule__FP15Sched_tSchedule
    /* A6FE4 800B67E4 00000000 */   nop
    /* A6FE8 800B67E8 1400BF8F */  lw         $ra, 0x14($sp)
    /* A6FEC 800B67EC 1000B08F */  lw         $s0, 0x10($sp)
    /* A6FF0 800B67F0 0800E003 */  jr         $ra
    /* A6FF4 800B67F4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Sim_CleanUp__Fv
