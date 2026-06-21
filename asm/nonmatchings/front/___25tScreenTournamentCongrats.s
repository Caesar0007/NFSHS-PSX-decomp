.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___25tScreenTournamentCongrats, 0x20

glabel ___25tScreenTournamentCongrats
    /* 39FA0 800497A0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 39FA4 800497A4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 39FA8 800497A8 1E98000C */  jal        ___7tScreen
    /* 39FAC 800497AC 00000000 */   nop
    /* 39FB0 800497B0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 39FB4 800497B4 00000000 */  nop
    /* 39FB8 800497B8 0800E003 */  jr         $ra
    /* 39FBC 800497BC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___25tScreenTournamentCongrats
