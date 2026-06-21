.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SaveTournament__18tTournamentManagerR15tSaveTournament, 0x48

glabel SaveTournament__18tTournamentManagerR15tSaveTournament
    /* 23CFC 800334FC 21388000 */  addu       $a3, $a0, $zero
    /* 23D00 80033500 1400E28C */  lw         $v0, 0x14($a3)
    /* 23D04 80033504 21300000 */  addu       $a2, $zero, $zero
    /* 23D08 80033508 0000A2AC */  sw         $v0, 0x0($a1)
  .L8003350C:
    /* 23D0C 8003350C 00240600 */  sll        $a0, $a2, 16
    /* 23D10 80033510 0100C324 */  addiu      $v1, $a2, 0x1
    /* 23D14 80033514 21306000 */  addu       $a2, $v1, $zero
    /* 23D18 80033518 03240400 */  sra        $a0, $a0, 16
    /* 23D1C 8003351C 2110E400 */  addu       $v0, $a3, $a0
    /* 23D20 80033520 2120A400 */  addu       $a0, $a1, $a0
    /* 23D24 80033524 001C0300 */  sll        $v1, $v1, 16
    /* 23D28 80033528 031C0300 */  sra        $v1, $v1, 16
    /* 23D2C 8003352C F0014290 */  lbu        $v0, 0x1F0($v0)
    /* 23D30 80033530 40006328 */  slti       $v1, $v1, 0x40
    /* 23D34 80033534 F5FF6014 */  bnez       $v1, .L8003350C
    /* 23D38 80033538 680082A0 */   sb        $v0, 0x68($a0)
    /* 23D3C 8003353C 0800E003 */  jr         $ra
    /* 23D40 80033540 00000000 */   nop
endlabel SaveTournament__18tTournamentManagerR15tSaveTournament
