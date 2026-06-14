.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_TargetLane__FP8Car_tObji, 0x50

glabel AI_TargetLane__FP8Car_tObji
    /* 4831C 80057B1C C406838C */  lw         $v1, 0x6C4($a0)
    /* 48320 80057B20 00000000 */  nop
    /* 48324 80057B24 2A106500 */  slt        $v0, $v1, $a1
    /* 48328 80057B28 08004010 */  beqz       $v0, .L80057B4C
    /* 4832C 80057B2C 2A10A300 */   slt       $v0, $a1, $v1
    /* 48330 80057B30 1180023C */  lui        $v0, %hi(CarLogic_gObs)
    /* 48334 80057B34 E4CC4224 */  addiu      $v0, $v0, %lo(CarLogic_gObs)
    /* 48338 80057B38 0800438C */  lw         $v1, 0x8($v0)
    /* 4833C 80057B3C 0500043C */  lui        $a0, (0x50000 >> 16)
    /* 48340 80057B40 21186400 */  addu       $v1, $v1, $a0
    /* 48344 80057B44 0800E003 */  jr         $ra
    /* 48348 80057B48 080043AC */   sw        $v1, 0x8($v0)
  .L80057B4C:
    /* 4834C 80057B4C 05004010 */  beqz       $v0, .L80057B64
    /* 48350 80057B50 1180023C */   lui       $v0, %hi(CarLogic_gObs)
    /* 48354 80057B54 E4CC438C */  lw         $v1, %lo(CarLogic_gObs)($v0)
    /* 48358 80057B58 0500043C */  lui        $a0, (0x50000 >> 16)
    /* 4835C 80057B5C 21186400 */  addu       $v1, $v1, $a0
    /* 48360 80057B60 E4CC43AC */  sw         $v1, %lo(CarLogic_gObs)($v0)
  .L80057B64:
    /* 48364 80057B64 0800E003 */  jr         $ra
    /* 48368 80057B68 00000000 */   nop
endlabel AI_TargetLane__FP8Car_tObji
