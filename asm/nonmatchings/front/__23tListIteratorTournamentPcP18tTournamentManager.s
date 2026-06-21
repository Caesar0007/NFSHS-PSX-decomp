.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __23tListIteratorTournamentPcP18tTournamentManager, 0x50

glabel __23tListIteratorTournamentPcP18tTournamentManager
    /* 2459C 80033D9C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 245A0 80033DA0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 245A4 80033DA4 21808000 */  addu       $s0, $a0, $zero
    /* 245A8 80033DA8 2110A000 */  addu       $v0, $a1, $zero
    /* 245AC 80033DAC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 245B0 80033DB0 2188C000 */  addu       $s1, $a2, $zero
    /* 245B4 80033DB4 21280000 */  addu       $a1, $zero, $zero
    /* 245B8 80033DB8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 245BC 80033DBC 748F000C */  jal        __13tListIteratorPsPc
    /* 245C0 80033DC0 21304000 */   addu      $a2, $v0, $zero
    /* 245C4 80033DC4 21100002 */  addu       $v0, $s0, $zero
    /* 245C8 80033DC8 0180033C */  lui        $v1, %hi(_vt_23tListIteratorTournament)
    /* 245CC 80033DCC 70166324 */  addiu      $v1, $v1, %lo(_vt_23tListIteratorTournament)
    /* 245D0 80033DD0 0C0043AC */  sw         $v1, 0xC($v0)
    /* 245D4 80033DD4 100051AC */  sw         $s1, 0x10($v0)
    /* 245D8 80033DD8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 245DC 80033DDC 1400B18F */  lw         $s1, 0x14($sp)
    /* 245E0 80033DE0 1000B08F */  lw         $s0, 0x10($sp)
    /* 245E4 80033DE4 0800E003 */  jr         $ra
    /* 245E8 80033DE8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __23tListIteratorTournamentPcP18tTournamentManager
