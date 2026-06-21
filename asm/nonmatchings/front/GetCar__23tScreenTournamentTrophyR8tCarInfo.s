.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCar__23tScreenTournamentTrophyR8tCarInfo, 0xAC

glabel GetCar__23tScreenTournamentTrophyR8tCarInfo
    /* 396B8 80048EB8 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 396BC 80048EBC 5C00BFAF */  sw         $ra, 0x5C($sp)
    /* 396C0 80048EC0 5800B0AF */  sw         $s0, 0x58($sp)
    /* 396C4 80048EC4 6400828C */  lw         $v0, 0x64($a0)
    /* 396C8 80048EC8 00000000 */  nop
    /* 396CC 80048ECC 13004014 */  bnez       $v0, .L80048F1C
    /* 396D0 80048ED0 2180A000 */   addu      $s0, $a1, $zero
    /* 396D4 80048ED4 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 396D8 80048ED8 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 396DC 80048EDC 35CE000C */  jal        GetAwardInformation__18tTournamentManagerR17tAwardInformation
    /* 396E0 80048EE0 1000A527 */   addiu     $a1, $sp, 0x10
    /* 396E4 80048EE4 1180043C */  lui        $a0, %hi(carManager)
    /* 396E8 80048EE8 3800A587 */  lh         $a1, 0x38($sp)
    /* 396EC 80048EEC 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 396F0 80048EF0 74428424 */   addiu     $a0, $a0, %lo(carManager)
    /* 396F4 80048EF4 21204000 */  addu       $a0, $v0, $zero
    /* 396F8 80048EF8 21280002 */  addu       $a1, $s0, $zero
    /* 396FC 80048EFC B798030C */  jal        blockmove
    /* 39700 80048F00 CC000624 */   addiu     $a2, $zero, 0xCC
    /* 39704 80048F04 3D00A293 */  lbu        $v0, 0x3D($sp)
    /* 39708 80048F08 00000000 */  nop
    /* 3970C 80048F0C C40002A2 */  sb         $v0, 0xC4($s0)
    /* 39710 80048F10 3C00A293 */  lbu        $v0, 0x3C($sp)
    /* 39714 80048F14 D4230108 */  j          .L80048F50
    /* 39718 80048F18 C50002A2 */   sb        $v0, 0xC5($s0)
  .L80048F1C:
    /* 3971C 80048F1C 1180043C */  lui        $a0, %hi(carManager)
    /* 39720 80048F20 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 39724 80048F24 21300002 */  addu       $a2, $s0, $zero
    /* 39728 80048F28 1180023C */  lui        $v0, %hi(D_80114723)
    /* 3972C 80048F2C 23474590 */  lbu        $a1, %lo(D_80114723)($v0)
    /* 39730 80048F30 D35B000C */  jal        GetGarageCar__11tCarManagersR8tCarInfos
    /* 39734 80048F34 21380000 */   addu      $a3, $zero, $zero
    /* 39738 80048F38 C5000292 */  lbu        $v0, 0xC5($s0)
    /* 3973C 80048F3C 00000000 */  nop
    /* 39740 80048F40 21100202 */  addu       $v0, $s0, $v0
    /* 39744 80048F44 AF004290 */  lbu        $v0, 0xAF($v0)
    /* 39748 80048F48 00000000 */  nop
    /* 3974C 80048F4C C50002A2 */  sb         $v0, 0xC5($s0)
  .L80048F50:
    /* 39750 80048F50 5C00BF8F */  lw         $ra, 0x5C($sp)
    /* 39754 80048F54 5800B08F */  lw         $s0, 0x58($sp)
    /* 39758 80048F58 01000224 */  addiu      $v0, $zero, 0x1
    /* 3975C 80048F5C 0800E003 */  jr         $ra
    /* 39760 80048F60 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel GetCar__23tScreenTournamentTrophyR8tCarInfo
