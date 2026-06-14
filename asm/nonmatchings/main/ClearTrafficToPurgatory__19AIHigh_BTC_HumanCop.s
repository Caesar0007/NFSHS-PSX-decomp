.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop, 0x58

glabel ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
    /* 4E7A0 8005DFA0 21200000 */  addu       $a0, $zero, $zero
    /* 4E7A4 8005DFA4 1480053C */  lui        $a1, %hi(Cars_gNumTrafficCars)
    /* 4E7A8 8005DFA8 08C8A58C */  lw         $a1, %lo(Cars_gNumTrafficCars)($a1)
    /* 4E7AC 8005DFAC 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 4E7B0 8005DFB0 38CD4724 */  addiu      $a3, $v0, %lo(highLevelAIObjs)
    /* 4E7B4 8005DFB4 01000624 */  addiu      $a2, $zero, 0x1
    /* 4E7B8 8005DFB8 1180023C */  lui        $v0, %hi(Cars_gTrafficCarList)
    /* 4E7BC 8005DFBC 90FA4324 */  addiu      $v1, $v0, %lo(Cars_gTrafficCarList)
  .L8005DFC0:
    /* 4E7C0 8005DFC0 2A108500 */  slt        $v0, $a0, $a1
    /* 4E7C4 8005DFC4 0A004010 */  beqz       $v0, .L8005DFF0
    /* 4E7C8 8005DFC8 01008424 */   addiu     $a0, $a0, 0x1
    /* 4E7CC 8005DFCC 0000628C */  lw         $v0, 0x0($v1)
    /* 4E7D0 8005DFD0 00000000 */  nop
    /* 4E7D4 8005DFD4 5402428C */  lw         $v0, 0x254($v0)
    /* 4E7D8 8005DFD8 04006324 */  addiu      $v1, $v1, 0x4
    /* 4E7DC 8005DFDC 80100200 */  sll        $v0, $v0, 2
    /* 4E7E0 8005DFE0 21104700 */  addu       $v0, $v0, $a3
    /* 4E7E4 8005DFE4 0000428C */  lw         $v0, 0x0($v0)
    /* 4E7E8 8005DFE8 F0770108 */  j          .L8005DFC0
    /* 4E7EC 8005DFEC 1C0046AC */   sw        $a2, 0x1C($v0)
  .L8005DFF0:
    /* 4E7F0 8005DFF0 0800E003 */  jr         $ra
    /* 4E7F4 8005DFF4 00000000 */   nop
endlabel ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
