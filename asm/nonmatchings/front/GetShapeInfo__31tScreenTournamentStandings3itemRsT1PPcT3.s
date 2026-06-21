.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__31tScreenTournamentStandings3itemRsT1PPcT3, 0x24

glabel GetShapeInfo__31tScreenTournamentStandings3itemRsT1PPcT3
    /* 2A330 80039B30 1000A28F */  lw         $v0, 0x10($sp)
    /* 2A334 80039B34 0000C0A4 */  sh         $zero, 0x0($a2)
    /* 2A338 80039B38 000040AC */  sw         $zero, 0x0($v0)
    /* 2A33C 80039B3C 29000224 */  addiu      $v0, $zero, 0x29
    /* 2A340 80039B40 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 2A344 80039B44 0180023C */  lui        $v0, %hi(D_80011994)
    /* 2A348 80039B48 94194224 */  addiu      $v0, $v0, %lo(D_80011994)
    /* 2A34C 80039B4C 0800E003 */  jr         $ra
    /* 2A350 80039B50 0000E2AC */   sw        $v0, 0x0($a3)
endlabel GetShapeInfo__31tScreenTournamentStandings3itemRsT1PPcT3
