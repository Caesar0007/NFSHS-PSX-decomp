.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_ProcessObservationsAndChooseLane__FP8Car_tObj, 0x44

glabel AI_ProcessObservationsAndChooseLane__FP8Car_tObj
    /* 4A5DC 80059DDC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4A5E0 80059DE0 1180023C */  lui        $v0, %hi(CarLogic_gObs)
    /* 4A5E4 80059DE4 E4CC4524 */  addiu      $a1, $v0, %lo(CarLogic_gObs)
    /* 4A5E8 80059DE8 E4CC428C */  lw         $v0, %lo(CarLogic_gObs)($v0)
    /* 4A5EC 80059DEC 1180033C */  lui        $v1, %hi(AI_Info)
    /* 4A5F0 80059DF0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4A5F4 80059DF4 0400A68C */  lw         $a2, 0x4($a1)
    /* 4A5F8 80059DF8 0800A58C */  lw         $a1, 0x8($a1)
    /* 4A5FC 80059DFC F0CC6324 */  addiu      $v1, $v1, %lo(AI_Info)
    /* 4A600 80059E00 300062AC */  sw         $v0, 0x30($v1)
    /* 4A604 80059E04 340066AC */  sw         $a2, 0x34($v1)
    /* 4A608 80059E08 8867010C */  jal        AI_ChooseBestLane__FP8Car_tObj
    /* 4A60C 80059E0C 380065AC */   sw        $a1, 0x38($v1)
    /* 4A610 80059E10 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4A614 80059E14 00000000 */  nop
    /* 4A618 80059E18 0800E003 */  jr         $ra
    /* 4A61C 80059E1C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_ProcessObservationsAndChooseLane__FP8Car_tObj
