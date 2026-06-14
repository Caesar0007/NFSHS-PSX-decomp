.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop, 0x54

glabel ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
    /* 4E7F8 8005DFF8 21200000 */  addu       $a0, $zero, $zero
    /* 4E7FC 8005DFFC 1480053C */  lui        $a1, %hi(Cars_gNumTrafficCars)
    /* 4E800 8005E000 08C8A58C */  lw         $a1, %lo(Cars_gNumTrafficCars)($a1)
    /* 4E804 8005E004 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 4E808 8005E008 38CD4624 */  addiu      $a2, $v0, %lo(highLevelAIObjs)
    /* 4E80C 8005E00C 1180023C */  lui        $v0, %hi(Cars_gTrafficCarList)
    /* 4E810 8005E010 90FA4324 */  addiu      $v1, $v0, %lo(Cars_gTrafficCarList)
  .L8005E014:
    /* 4E814 8005E014 2A108500 */  slt        $v0, $a0, $a1
    /* 4E818 8005E018 0A004010 */  beqz       $v0, .L8005E044
    /* 4E81C 8005E01C 01008424 */   addiu     $a0, $a0, 0x1
    /* 4E820 8005E020 0000628C */  lw         $v0, 0x0($v1)
    /* 4E824 8005E024 00000000 */  nop
    /* 4E828 8005E028 5402428C */  lw         $v0, 0x254($v0)
    /* 4E82C 8005E02C 04006324 */  addiu      $v1, $v1, 0x4
    /* 4E830 8005E030 80100200 */  sll        $v0, $v0, 2
    /* 4E834 8005E034 21104600 */  addu       $v0, $v0, $a2
    /* 4E838 8005E038 0000428C */  lw         $v0, 0x0($v0)
    /* 4E83C 8005E03C 05780108 */  j          .L8005E014
    /* 4E840 8005E040 1C0040AC */   sw        $zero, 0x1C($v0)
  .L8005E044:
    /* 4E844 8005E044 0800E003 */  jr         $ra
    /* 4E848 8005E048 00000000 */   nop
endlabel ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
