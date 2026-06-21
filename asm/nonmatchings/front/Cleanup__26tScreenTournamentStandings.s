.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__26tScreenTournamentStandings, 0x20

glabel Cleanup__26tScreenTournamentStandings
    /* 2A2EC 80039AEC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2A2F0 80039AF0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2A2F4 80039AF4 6898000C */  jal        Cleanup__7tScreen
    /* 2A2F8 80039AF8 840080AC */   sw        $zero, 0x84($a0)
    /* 2A2FC 80039AFC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 2A300 80039B00 00000000 */  nop
    /* 2A304 80039B04 0800E003 */  jr         $ra
    /* 2A308 80039B08 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__26tScreenTournamentStandings
