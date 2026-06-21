.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__26tScreenTournamentStandingsRsT1PPcT3, 0x24

glabel GetShapeInfo__26tScreenTournamentStandingsRsT1PPcT3
    /* 2A30C 80039B0C 1000A28F */  lw         $v0, 0x10($sp)
    /* 2A310 80039B10 0000C0A4 */  sh         $zero, 0x0($a2)
    /* 2A314 80039B14 000040AC */  sw         $zero, 0x0($v0)
    /* 2A318 80039B18 29000224 */  addiu      $v0, $zero, 0x29
    /* 2A31C 80039B1C 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 2A320 80039B20 0180023C */  lui        $v0, %hi(D_8001198C)
    /* 2A324 80039B24 8C194224 */  addiu      $v0, $v0, %lo(D_8001198C)
    /* 2A328 80039B28 0800E003 */  jr         $ra
    /* 2A32C 80039B2C 0000E2AC */   sw        $v0, 0x0($a3)
endlabel GetShapeInfo__26tScreenTournamentStandingsRsT1PPcT3
