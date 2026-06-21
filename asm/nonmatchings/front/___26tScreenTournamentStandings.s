.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___26tScreenTournamentStandings, 0x20

glabel ___26tScreenTournamentStandings
    /* 2B0CC 8003A8CC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2B0D0 8003A8D0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2B0D4 8003A8D4 1E98000C */  jal        ___7tScreen
    /* 2B0D8 8003A8D8 00000000 */   nop
    /* 2B0DC 8003A8DC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 2B0E0 8003A8E0 00000000 */  nop
    /* 2B0E4 8003A8E4 0800E003 */  jr         $ra
    /* 2B0E8 8003A8E8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___26tScreenTournamentStandings
    /* 2B0EC 8003A8EC 00000000 */  nop
