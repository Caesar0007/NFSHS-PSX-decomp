.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcTierFinishPrize__18tTournamentManager, 0x2C

glabel CalcTierFinishPrize__18tTournamentManager
    /* 24338 80033B38 0400828C */  lw         $v0, 0x4($a0)
    /* 2433C 80033B3C 07000324 */  addiu      $v1, $zero, 0x7
    /* 24340 80033B40 40100200 */  sll        $v0, $v0, 1
    /* 24344 80033B44 21108200 */  addu       $v0, $a0, $v0
    /* 24348 80033B48 240043A4 */  sh         $v1, 0x24($v0)
    /* 2434C 80033B4C 0400828C */  lw         $v0, 0x4($a0)
    /* 24350 80033B50 00000000 */  nop
    /* 24354 80033B54 40100200 */  sll        $v0, $v0, 1
    /* 24358 80033B58 21208200 */  addu       $a0, $a0, $v0
    /* 2435C 80033B5C 0800E003 */  jr         $ra
    /* 24360 80033B60 2C0080A4 */   sh        $zero, 0x2C($a0)
endlabel CalcTierFinishPrize__18tTournamentManager
