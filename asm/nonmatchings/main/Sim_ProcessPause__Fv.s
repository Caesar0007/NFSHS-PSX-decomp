.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sim_ProcessPause__Fv, 0x104

glabel Sim_ProcessPause__Fv
    /* A739C 800B6B9C 1180023C */  lui        $v0, %hi(D_80110C2C)
    /* A73A0 800B6BA0 DC0E838F */  lw         $v1, %gp_rel(unPauseDelay)($gp)
    /* A73A4 800B6BA4 2C0C428C */  lw         $v0, %lo(D_80110C2C)($v0)
    /* A73A8 800B6BA8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A73AC 800B6BAC 1400BFAF */  sw         $ra, 0x14($sp)
    /* A73B0 800B6BB0 2A104300 */  slt        $v0, $v0, $v1
    /* A73B4 800B6BB4 36004014 */  bnez       $v0, .L800B6C90
    /* A73B8 800B6BB8 1000B0AF */   sw        $s0, 0x10($sp)
    /* A73BC 800B6BBC E179020C */  jal        MPause_Logic__Fv
    /* A73C0 800B6BC0 01001024 */   addiu     $s0, $zero, 0x1
    /* A73C4 800B6BC4 21184000 */  addu       $v1, $v0, $zero
    /* A73C8 800B6BC8 0F007014 */  bne        $v1, $s0, .L800B6C08
    /* A73CC 800B6BCC 02000224 */   addiu     $v0, $zero, 0x2
    /* A73D0 800B6BD0 1280023C */  lui        $v0, %hi(simVar)
    /* A73D4 800B6BD4 C4E05024 */  addiu      $s0, $v0, %lo(simVar)
    /* A73D8 800B6BD8 1000028E */  lw         $v0, 0x10($s0)
    /* A73DC 800B6BDC 00000000 */  nop
    /* A73E0 800B6BE0 03004014 */  bnez       $v0, .L800B6BF0
    /* A73E4 800B6BE4 00000000 */   nop
    /* A73E8 800B6BE8 06E7010C */  jal        AudioCmn_UnPause__Fv
    /* A73EC 800B6BEC 00000000 */   nop
  .L800B6BF0:
    /* A73F0 800B6BF0 1480013C */  lui        $at, %hi(gSimQueue_BlockSelf)
    /* A73F4 800B6BF4 38D420AC */  sw         $zero, %lo(gSimQueue_BlockSelf)($at)
    /* A73F8 800B6BF8 7D2C030C */  jal        Force_UnPause__Fv
    /* A73FC 800B6BFC 080000AE */   sw        $zero, 0x8($s0)
    /* A7400 800B6C00 22DB0208 */  j          .L800B6C88
    /* A7404 800B6C04 00000000 */   nop
  .L800B6C08:
    /* A7408 800B6C08 09006214 */  bne        $v1, $v0, .L800B6C30
    /* A740C 800B6C0C FCFF6224 */   addiu     $v0, $v1, -0x4
    /* A7410 800B6C10 63E7010C */  jal        AudioCmn_UnPauseAndRestart__Fv
    /* A7414 800B6C14 00000000 */   nop
    /* A7418 800B6C18 1280033C */  lui        $v1, %hi(simVar)
    /* A741C 800B6C1C C4E06224 */  addiu      $v0, $v1, %lo(simVar)
    /* A7420 800B6C20 080050AC */  sw         $s0, 0x8($v0)
    /* A7424 800B6C24 040050AC */  sw         $s0, 0x4($v0)
    /* A7428 800B6C28 22DB0208 */  j          .L800B6C88
    /* A742C 800B6C2C C4E070AC */   sw        $s0, %lo(simVar)($v1)
  .L800B6C30:
    /* A7430 800B6C30 0200422C */  sltiu      $v0, $v0, 0x2
    /* A7434 800B6C34 16004010 */  beqz       $v0, .L800B6C90
    /* A7438 800B6C38 05000224 */   addiu     $v0, $zero, 0x5
    /* A743C 800B6C3C 06006214 */  bne        $v1, $v0, .L800B6C58
    /* A7440 800B6C40 1180033C */   lui       $v1, %hi(D_801132A4)
    /* A7444 800B6C44 1480023C */  lui        $v0, %hi(Device_gPausePortIndex)
    /* A7448 800B6C48 94D74290 */  lbu        $v0, %lo(Device_gPausePortIndex)($v0)
    /* A744C 800B6C4C 00000000 */  nop
    /* A7450 800B6C50 2B100200 */  sltu       $v0, $zero, $v0
    /* A7454 800B6C54 A43262AC */  sw         $v0, %lo(D_801132A4)($v1)
  .L800B6C58:
    /* A7458 800B6C58 1266030C */  jal        Hud_BTC_QuitOut__Fv
    /* A745C 800B6C5C 00000000 */   nop
    /* A7460 800B6C60 63E7010C */  jal        AudioCmn_UnPauseAndRestart__Fv
    /* A7464 800B6C64 00000000 */   nop
    /* A7468 800B6C68 1280033C */  lui        $v1, %hi(simVar)
    /* A746C 800B6C6C C4E06224 */  addiu      $v0, $v1, %lo(simVar)
    /* A7470 800B6C70 01000424 */  addiu      $a0, $zero, 0x1
    /* A7474 800B6C74 080040AC */  sw         $zero, 0x8($v0)
    /* A7478 800B6C78 040050AC */  sw         $s0, 0x4($v0)
    /* A747C 800B6C7C 81E1020C */  jal        Stats_ExtrapolateOpponentTimes__Fi
    /* A7480 800B6C80 C4E060AC */   sw        $zero, %lo(simVar)($v1)
    /* A7484 800B6C84 E40E90AF */  sw         $s0, %gp_rel(quitType)($gp)
  .L800B6C88:
    /* A7488 800B6C88 AC7B020C */  jal        MPause_EndPauseMenu__Fv
    /* A748C 800B6C8C 00000000 */   nop
  .L800B6C90:
    /* A7490 800B6C90 1400BF8F */  lw         $ra, 0x14($sp)
    /* A7494 800B6C94 1000B08F */  lw         $s0, 0x10($sp)
    /* A7498 800B6C98 0800E003 */  jr         $ra
    /* A749C 800B6C9C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Sim_ProcessPause__Fv
