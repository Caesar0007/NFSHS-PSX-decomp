.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_ClearLaneMerits__Fv, 0x28

glabel AI_ClearLaneMerits__Fv
    /* 4836C 80057B6C 21100000 */  addu       $v0, $zero, $zero
    /* 48370 80057B70 1180043C */  lui        $a0, %hi(CarLogic_gObs)
    /* 48374 80057B74 E4CC8324 */  addiu      $v1, $a0, %lo(CarLogic_gObs)
  .L80057B78:
    /* 48378 80057B78 01004224 */  addiu      $v0, $v0, 0x1
    /* 4837C 80057B7C 080060AC */  sw         $zero, 0x8($v1)
    /* 48380 80057B80 040060AC */  sw         $zero, 0x4($v1)
    /* 48384 80057B84 FCFF4018 */  blez       $v0, .L80057B78
    /* 48388 80057B88 E4CC80AC */   sw        $zero, %lo(CarLogic_gObs)($a0)
    /* 4838C 80057B8C 0800E003 */  jr         $ra
    /* 48390 80057B90 00000000 */   nop
endlabel AI_ClearLaneMerits__Fv
