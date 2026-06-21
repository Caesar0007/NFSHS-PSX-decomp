.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___23tScreenTournamentTrophy, 0x20

glabel ___23tScreenTournamentTrophy
    /* 3A000 80049800 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3A004 80049804 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3A008 80049808 1E98000C */  jal        ___7tScreen
    /* 3A00C 8004980C 00000000 */   nop
    /* 3A010 80049810 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3A014 80049814 00000000 */  nop
    /* 3A018 80049818 0800E003 */  jr         $ra
    /* 3A01C 8004981C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___23tScreenTournamentTrophy
