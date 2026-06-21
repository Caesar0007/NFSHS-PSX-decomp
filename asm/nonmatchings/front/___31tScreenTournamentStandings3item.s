.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___31tScreenTournamentStandings3item, 0x20

glabel ___31tScreenTournamentStandings3item
    /* 2B0AC 8003A8AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2B0B0 8003A8B0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2B0B4 8003A8B4 1E98000C */  jal        ___7tScreen
    /* 2B0B8 8003A8B8 00000000 */   nop
    /* 2B0BC 8003A8BC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 2B0C0 8003A8C0 00000000 */  nop
    /* 2B0C4 8003A8C4 0800E003 */  jr         $ra
    /* 2B0C8 8003A8C8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___31tScreenTournamentStandings3item
