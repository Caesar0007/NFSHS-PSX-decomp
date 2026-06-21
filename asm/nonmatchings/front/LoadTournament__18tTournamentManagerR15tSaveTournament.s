.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadTournament__18tTournamentManagerR15tSaveTournament, 0x48

glabel LoadTournament__18tTournamentManagerR15tSaveTournament
    /* 23D44 80033544 21388000 */  addu       $a3, $a0, $zero
    /* 23D48 80033548 0000A28C */  lw         $v0, 0x0($a1)
    /* 23D4C 8003354C 21300000 */  addu       $a2, $zero, $zero
    /* 23D50 80033550 1400E2AC */  sw         $v0, 0x14($a3)
  .L80033554:
    /* 23D54 80033554 00240600 */  sll        $a0, $a2, 16
    /* 23D58 80033558 0100C324 */  addiu      $v1, $a2, 0x1
    /* 23D5C 8003355C 21306000 */  addu       $a2, $v1, $zero
    /* 23D60 80033560 03240400 */  sra        $a0, $a0, 16
    /* 23D64 80033564 2110A400 */  addu       $v0, $a1, $a0
    /* 23D68 80033568 2120E400 */  addu       $a0, $a3, $a0
    /* 23D6C 8003356C 001C0300 */  sll        $v1, $v1, 16
    /* 23D70 80033570 031C0300 */  sra        $v1, $v1, 16
    /* 23D74 80033574 68004290 */  lbu        $v0, 0x68($v0)
    /* 23D78 80033578 40006328 */  slti       $v1, $v1, 0x40
    /* 23D7C 8003357C F5FF6014 */  bnez       $v1, .L80033554
    /* 23D80 80033580 F00182A0 */   sb        $v0, 0x1F0($a0)
    /* 23D84 80033584 0800E003 */  jr         $ra
    /* 23D88 80033588 00000000 */   nop
endlabel LoadTournament__18tTournamentManagerR15tSaveTournament
