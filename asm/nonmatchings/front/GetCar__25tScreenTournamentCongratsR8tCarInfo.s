.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCar__25tScreenTournamentCongratsR8tCarInfo, 0x54

glabel GetCar__25tScreenTournamentCongratsR8tCarInfo
    /* 39DE8 800495E8 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 39DEC 800495EC 5800B0AF */  sw         $s0, 0x58($sp)
    /* 39DF0 800495F0 2180A000 */  addu       $s0, $a1, $zero
    /* 39DF4 800495F4 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 39DF8 800495F8 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 39DFC 800495FC 5C00BFAF */  sw         $ra, 0x5C($sp)
    /* 39E00 80049600 35CE000C */  jal        GetAwardInformation__18tTournamentManagerR17tAwardInformation
    /* 39E04 80049604 1000A527 */   addiu     $a1, $sp, 0x10
    /* 39E08 80049608 1180043C */  lui        $a0, %hi(carManager)
    /* 39E0C 8004960C 4800A587 */  lh         $a1, 0x48($sp)
    /* 39E10 80049610 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 39E14 80049614 74428424 */   addiu     $a0, $a0, %lo(carManager)
    /* 39E18 80049618 21204000 */  addu       $a0, $v0, $zero
    /* 39E1C 8004961C 21280002 */  addu       $a1, $s0, $zero
    /* 39E20 80049620 B798030C */  jal        blockmove
    /* 39E24 80049624 CC000624 */   addiu     $a2, $zero, 0xCC
    /* 39E28 80049628 5C00BF8F */  lw         $ra, 0x5C($sp)
    /* 39E2C 8004962C 5800B08F */  lw         $s0, 0x58($sp)
    /* 39E30 80049630 01000224 */  addiu      $v0, $zero, 0x1
    /* 39E34 80049634 0800E003 */  jr         $ra
    /* 39E38 80049638 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel GetCar__25tScreenTournamentCongratsR8tCarInfo
