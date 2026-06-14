.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sim_CheckForPause__Fi, 0xAC

glabel Sim_CheckForPause__Fi
    /* A74A0 800B6CA0 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* A74A4 800B6CA4 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* A74A8 800B6CA8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A74AC 800B6CAC 02004228 */  slti       $v0, $v0, 0x2
    /* A74B0 800B6CB0 22004010 */  beqz       $v0, .L800B6D3C
    /* A74B4 800B6CB4 1000BFAF */   sw        $ra, 0x10($sp)
    /* A74B8 800B6CB8 1280023C */  lui        $v0, %hi(simVar)
    /* A74BC 800B6CBC C4E0428C */  lw         $v0, %lo(simVar)($v0)
    /* A74C0 800B6CC0 00000000 */  nop
    /* A74C4 800B6CC4 1D004014 */  bnez       $v0, .L800B6D3C
    /* A74C8 800B6CC8 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* A74CC 800B6CCC B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* A74D0 800B6CD0 00000000 */  nop
    /* A74D4 800B6CD4 21004228 */  slti       $v0, $v0, 0x21
    /* A74D8 800B6CD8 18004014 */  bnez       $v0, .L800B6D3C
    /* A74DC 800B6CDC 00000000 */   nop
    /* A74E0 800B6CE0 05008010 */  beqz       $a0, .L800B6CF8
    /* A74E4 800B6CE4 06000424 */   addiu     $a0, $zero, 0x6
    /* A74E8 800B6CE8 C674020C */  jal        Input_Interface__FUli
    /* A74EC 800B6CEC 01000524 */   addiu     $a1, $zero, 0x1
    /* A74F0 800B6CF0 06004014 */  bnez       $v0, .L800B6D0C
    /* A74F4 800B6CF4 1180023C */   lui       $v0, %hi(D_80110C2C)
  .L800B6CF8:
    /* A74F8 800B6CF8 1480023C */  lui        $v0, %hi(Device_gForcePause)
    /* A74FC 800B6CFC 78D7428C */  lw         $v0, %lo(Device_gForcePause)($v0)
    /* A7500 800B6D00 00000000 */  nop
    /* A7504 800B6D04 0D004010 */  beqz       $v0, .L800B6D3C
    /* A7508 800B6D08 1180023C */   lui       $v0, %hi(D_80110C2C)
  .L800B6D0C:
    /* A750C 800B6D0C 2C0C428C */  lw         $v0, %lo(D_80110C2C)($v0)
    /* A7510 800B6D10 00000000 */  nop
    /* A7514 800B6D14 04004224 */  addiu      $v0, $v0, 0x4
    /* A7518 800B6D18 DC0E82AF */  sw         $v0, %gp_rel(unPauseDelay)($gp)
    /* A751C 800B6D1C D8E6010C */  jal        AudioCmn_Pause__Fv
    /* A7520 800B6D20 00000000 */   nop
    /* A7524 800B6D24 01000324 */  addiu      $v1, $zero, 0x1
    /* A7528 800B6D28 1280023C */  lui        $v0, %hi(D_8011E0CC)
    /* A752C 800B6D2C 1480013C */  lui        $at, %hi(gSimQueue_BlockSelf)
    /* A7530 800B6D30 38D423AC */  sw         $v1, %lo(gSimQueue_BlockSelf)($at)
    /* A7534 800B6D34 6D2C030C */  jal        Force_Pause__Fv
    /* A7538 800B6D38 CCE043AC */   sw        $v1, %lo(D_8011E0CC)($v0)
  .L800B6D3C:
    /* A753C 800B6D3C 1000BF8F */  lw         $ra, 0x10($sp)
    /* A7540 800B6D40 00000000 */  nop
    /* A7544 800B6D44 0800E003 */  jr         $ra
    /* A7548 800B6D48 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Sim_CheckForPause__Fi
