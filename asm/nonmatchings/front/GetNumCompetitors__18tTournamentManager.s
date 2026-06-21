.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetNumCompetitors__18tTournamentManager, 0x4C

glabel GetNumCompetitors__18tTournamentManager
    /* 23D8C 8003358C 0400838C */  lw         $v1, 0x4($a0)
    /* 23D90 80033590 1800858C */  lw         $a1, 0x18($a0)
    /* 23D94 80033594 40100300 */  sll        $v0, $v1, 1
    /* 23D98 80033598 21104300 */  addu       $v0, $v0, $v1
    /* 23D9C 8003359C 80100200 */  sll        $v0, $v0, 2
    /* 23DA0 800335A0 2110A200 */  addu       $v0, $a1, $v0
    /* 23DA4 800335A4 02004390 */  lbu        $v1, 0x2($v0)
    /* 23DA8 800335A8 0800828C */  lw         $v0, 0x8($a0)
    /* 23DAC 800335AC 00000000 */  nop
    /* 23DB0 800335B0 21186200 */  addu       $v1, $v1, $v0
    /* 23DB4 800335B4 80100300 */  sll        $v0, $v1, 2
    /* 23DB8 800335B8 21104300 */  addu       $v0, $v0, $v1
    /* 23DBC 800335BC 80100200 */  sll        $v0, $v0, 2
    /* 23DC0 800335C0 21104300 */  addu       $v0, $v0, $v1
    /* 23DC4 800335C4 80100200 */  sll        $v0, $v0, 2
    /* 23DC8 800335C8 21104500 */  addu       $v0, $v0, $a1
    /* 23DCC 800335CC 2A004290 */  lbu        $v0, 0x2A($v0)
    /* 23DD0 800335D0 0800E003 */  jr         $ra
    /* 23DD4 800335D4 00000000 */   nop
endlabel GetNumCompetitors__18tTournamentManager
