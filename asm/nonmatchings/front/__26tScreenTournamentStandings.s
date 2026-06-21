.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __26tScreenTournamentStandings, 0x38

glabel __26tScreenTournamentStandings
    /* 2A128 80039928 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2A12C 8003992C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2A130 80039930 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2A134 80039934 0898000C */  jal        __7tScreen
    /* 2A138 80039938 21808000 */   addu      $s0, $a0, $zero
    /* 2A13C 8003993C 21100002 */  addu       $v0, $s0, $zero
    /* 2A140 80039940 0180033C */  lui        $v1, %hi(_vt_26tScreenTournamentStandings)
    /* 2A144 80039944 481A6324 */  addiu      $v1, $v1, %lo(_vt_26tScreenTournamentStandings)
    /* 2A148 80039948 600043AC */  sw         $v1, 0x60($v0)
    /* 2A14C 8003994C 840040AC */  sw         $zero, 0x84($v0)
    /* 2A150 80039950 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2A154 80039954 1000B08F */  lw         $s0, 0x10($sp)
    /* 2A158 80039958 0800E003 */  jr         $ra
    /* 2A15C 8003995C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __26tScreenTournamentStandings
