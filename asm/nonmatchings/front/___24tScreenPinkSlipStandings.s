.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___24tScreenPinkSlipStandings, 0x20

glabel ___24tScreenPinkSlipStandings
    /* 2B08C 8003A88C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2B090 8003A890 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2B094 8003A894 1E98000C */  jal        ___7tScreen
    /* 2B098 8003A898 00000000 */   nop
    /* 2B09C 8003A89C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 2B0A0 8003A8A0 00000000 */  nop
    /* 2B0A4 8003A8A4 0800E003 */  jr         $ra
    /* 2B0A8 8003A8A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___24tScreenPinkSlipStandings
