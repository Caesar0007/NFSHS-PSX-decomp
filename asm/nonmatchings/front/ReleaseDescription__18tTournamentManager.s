.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReleaseDescription__18tTournamentManager, 0x3C

glabel ReleaseDescription__18tTournamentManager
    /* 22D48 80032548 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 22D4C 8003254C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 22D50 80032550 21808000 */  addu       $s0, $a0, $zero
    /* 22D54 80032554 1400BFAF */  sw         $ra, 0x14($sp)
    /* 22D58 80032558 1800048E */  lw         $a0, 0x18($s0)
    /* 22D5C 8003255C 00000000 */  nop
    /* 22D60 80032560 04008010 */  beqz       $a0, .L80032574
    /* 22D64 80032564 00000000 */   nop
    /* 22D68 80032568 5095030C */  jal        purgememadr
    /* 22D6C 8003256C 00000000 */   nop
    /* 22D70 80032570 180000AE */  sw         $zero, 0x18($s0)
  .L80032574:
    /* 22D74 80032574 1400BF8F */  lw         $ra, 0x14($sp)
    /* 22D78 80032578 1000B08F */  lw         $s0, 0x10($sp)
    /* 22D7C 8003257C 0800E003 */  jr         $ra
    /* 22D80 80032580 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ReleaseDescription__18tTournamentManager
