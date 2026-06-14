.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForNeedyPlayers__10AIHigh_Cop, 0x9C

glabel CheckForNeedyPlayers__10AIHigh_Cop
    /* 55B94 80065394 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 55B98 80065398 21300000 */  addu       $a2, $zero, $zero
    /* 55B9C 8006539C 1480083C */  lui        $t0, %hi(Cars_gNumHumanRaceCars)
    /* 55BA0 800653A0 00C8088D */  lw         $t0, %lo(Cars_gNumHumanRaceCars)($t0)
    /* 55BA4 800653A4 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 55BA8 800653A8 38CD4A24 */  addiu      $t2, $v0, %lo(highLevelAIObjs)
    /* 55BAC 800653AC 1400093C */  lui        $t1, (0x140000 >> 16)
    /* 55BB0 800653B0 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 55BB4 800653B4 48FA4524 */  addiu      $a1, $v0, %lo(Cars_gHumanRaceCarList)
  .L800653B8:
    /* 55BB8 800653B8 2A10C800 */  slt        $v0, $a2, $t0
    /* 55BBC 800653BC 1A004010 */  beqz       $v0, .L80065428
    /* 55BC0 800653C0 00000000 */   nop
    /* 55BC4 800653C4 0000A38C */  lw         $v1, 0x0($a1)
    /* 55BC8 800653C8 00000000 */  nop
    /* 55BCC 800653CC 5402648C */  lw         $a0, 0x254($v1)
    /* 55BD0 800653D0 00000000 */  nop
    /* 55BD4 800653D4 80100400 */  sll        $v0, $a0, 2
    /* 55BD8 800653D8 21104A00 */  addu       $v0, $v0, $t2
    /* 55BDC 800653DC 0000428C */  lw         $v0, 0x0($v0)
    /* 55BE0 800653E0 00000000 */  nop
    /* 55BE4 800653E4 AC00428C */  lw         $v0, 0xAC($v0)
    /* 55BE8 800653E8 00000000 */  nop
    /* 55BEC 800653EC 21034228 */  slti       $v0, $v0, 0x321
    /* 55BF0 800653F0 0A004014 */  bnez       $v0, .L8006541C
    /* 55BF4 800653F4 00000000 */   nop
    /* 55BF8 800653F8 6405628C */  lw         $v0, 0x564($v1)
    /* 55BFC 800653FC 00000000 */  nop
    /* 55C00 80065400 02004104 */  bgez       $v0, .L8006540C
    /* 55C04 80065404 00000000 */   nop
    /* 55C08 80065408 23100200 */  negu       $v0, $v0
  .L8006540C:
    /* 55C0C 8006540C 2A102201 */  slt        $v0, $t1, $v0
    /* 55C10 80065410 02004010 */  beqz       $v0, .L8006541C
    /* 55C14 80065414 00000000 */   nop
    /* 55C18 80065418 21388000 */  addu       $a3, $a0, $zero
  .L8006541C:
    /* 55C1C 8006541C 0400A524 */  addiu      $a1, $a1, 0x4
    /* 55C20 80065420 EE940108 */  j          .L800653B8
    /* 55C24 80065424 0100C624 */   addiu     $a2, $a2, 0x1
  .L80065428:
    /* 55C28 80065428 0800E003 */  jr         $ra
    /* 55C2C 8006542C 2110E000 */   addu      $v0, $a3, $zero
endlabel CheckForNeedyPlayers__10AIHigh_Cop
