.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StartCARD, 0x38

glabel StartCARD
    /* FCFF0 8010C7F0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FCFF4 8010C7F4 1000BFAF */  sw         $ra, 0x10($sp)
    /* FCFF8 8010C7F8 631A040C */  jal        EnterCriticalSection
    /* FCFFC 8010C7FC 00000000 */   nop
    /* FD000 8010C800 E832040C */  jal        StartCARD2
    /* FD004 8010C804 00000000 */   nop
    /* FD008 8010C808 9519040C */  jal        ChangeClearPAD
    /* FD00C 8010C80C 21200000 */   addu      $a0, $zero, $zero
    /* FD010 8010C810 5B1A040C */  jal        ExitCriticalSection
    /* FD014 8010C814 00000000 */   nop
    /* FD018 8010C818 1000BF8F */  lw         $ra, 0x10($sp)
    /* FD01C 8010C81C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* FD020 8010C820 0800E003 */  jr         $ra
    /* FD024 8010C824 00000000 */   nop
endlabel StartCARD
