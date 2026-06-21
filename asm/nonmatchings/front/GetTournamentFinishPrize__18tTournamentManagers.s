.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetTournamentFinishPrize__18tTournamentManagers, 0x74

glabel GetTournamentFinishPrize__18tTournamentManagers
    /* 24060 80033860 FFFFA230 */  andi       $v0, $a1, 0xFFFF
    /* 24064 80033864 0600422C */  sltiu      $v0, $v0, 0x6
    /* 24068 80033868 03004014 */  bnez       $v0, .L80033878
    /* 2406C 8003386C 21308000 */   addu      $a2, $a0, $zero
    /* 24070 80033870 0800E003 */  jr         $ra
    /* 24074 80033874 21100000 */   addu      $v0, $zero, $zero
  .L80033878:
    /* 24078 80033878 0400C38C */  lw         $v1, 0x4($a2)
    /* 2407C 8003387C 1800C48C */  lw         $a0, 0x18($a2)
    /* 24080 80033880 40100300 */  sll        $v0, $v1, 1
    /* 24084 80033884 21104300 */  addu       $v0, $v0, $v1
    /* 24088 80033888 80100200 */  sll        $v0, $v0, 2
    /* 2408C 8003388C 21108200 */  addu       $v0, $a0, $v0
    /* 24090 80033890 02004390 */  lbu        $v1, 0x2($v0)
    /* 24094 80033894 0800C28C */  lw         $v0, 0x8($a2)
    /* 24098 80033898 00000000 */  nop
    /* 2409C 8003389C 21186200 */  addu       $v1, $v1, $v0
    /* 240A0 800338A0 80100300 */  sll        $v0, $v1, 2
    /* 240A4 800338A4 21104300 */  addu       $v0, $v0, $v1
    /* 240A8 800338A8 80100200 */  sll        $v0, $v0, 2
    /* 240AC 800338AC 21104300 */  addu       $v0, $v0, $v1
    /* 240B0 800338B0 80100200 */  sll        $v0, $v0, 2
    /* 240B4 800338B4 24004224 */  addiu      $v0, $v0, 0x24
    /* 240B8 800338B8 21208200 */  addu       $a0, $a0, $v0
    /* 240BC 800338BC 00140500 */  sll        $v0, $a1, 16
    /* 240C0 800338C0 83130200 */  sra        $v0, $v0, 14
    /* 240C4 800338C4 21208200 */  addu       $a0, $a0, $v0
    /* 240C8 800338C8 1800828C */  lw         $v0, 0x18($a0)
    /* 240CC 800338CC 0800E003 */  jr         $ra
    /* 240D0 800338D0 00000000 */   nop
endlabel GetTournamentFinishPrize__18tTournamentManagers
