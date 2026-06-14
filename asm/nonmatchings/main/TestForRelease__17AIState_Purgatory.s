.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TestForRelease__17AIState_Purgatory, 0x7C

glabel TestForRelease__17AIState_Purgatory
    /* 61F5C 8007175C 0000878C */  lw         $a3, 0x0($a0)
    /* 61F60 80071760 00000000 */  nop
    /* 61F64 80071764 8C05E28C */  lw         $v0, 0x58C($a3)
    /* 61F68 80071768 00000000 */  nop
    /* 61F6C 8007176C 1600401C */  bgtz       $v0, .L800717C8
    /* 61F70 80071770 1180033C */   lui       $v1, %hi(GameSetup_gData)
    /* 61F74 80071774 EC316324 */  addiu      $v1, $v1, %lo(GameSetup_gData)
    /* 61F78 80071778 1480053C */  lui        $a1, %hi(Cars_gNumTrafficCars)
    /* 61F7C 8007177C 08C8A58C */  lw         $a1, %lo(Cars_gNumTrafficCars)($a1)
    /* 61F80 80071780 1800628C */  lw         $v0, 0x18($v1)
    /* 61F84 80071784 3018848F */  lw         $a0, %gp_rel(_bss_obj)($gp)
    /* 61F88 80071788 80300200 */  sll        $a2, $v0, 2
    /* 61F8C 8007178C 2328A400 */  subu       $a1, $a1, $a0
    /* 61F90 80071790 1180023C */  lui        $v0, %hi(AITune_MaxTraffic)
    /* 61F94 80071794 BCDF4424 */  addiu      $a0, $v0, %lo(AITune_MaxTraffic)
    /* 61F98 80071798 0C00628C */  lw         $v0, 0xC($v1)
    /* 61F9C 8007179C 01000324 */  addiu      $v1, $zero, 0x1
    /* 61FA0 800717A0 03004314 */  bne        $v0, $v1, .L800717B0
    /* 61FA4 800717A4 2110C400 */   addu      $v0, $a2, $a0
    /* 61FA8 800717A8 1000C624 */  addiu      $a2, $a2, 0x10
    /* 61FAC 800717AC 2110C400 */  addu       $v0, $a2, $a0
  .L800717B0:
    /* 61FB0 800717B0 0000428C */  lw         $v0, 0x0($v0)
    /* 61FB4 800717B4 00000000 */  nop
    /* 61FB8 800717B8 2A10A200 */  slt        $v0, $a1, $v0
    /* 61FBC 800717BC 04004014 */  bnez       $v0, .L800717D0
    /* 61FC0 800717C0 01000224 */   addiu     $v0, $zero, 0x1
    /* 61FC4 800717C4 8C05E3AC */  sw         $v1, 0x58C($a3)
  .L800717C8:
    /* 61FC8 800717C8 0800E003 */  jr         $ra
    /* 61FCC 800717CC 21100000 */   addu      $v0, $zero, $zero
  .L800717D0:
    /* 61FD0 800717D0 0800E003 */  jr         $ra
    /* 61FD4 800717D4 00000000 */   nop
endlabel TestForRelease__17AIState_Purgatory
