.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__24tScreenPinkSlipStandings7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x20

glabel ProcessInput__24tScreenPinkSlipStandings7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 2B06C 8003A86C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2B070 8003A870 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2B074 8003A874 369A000C */  jal        ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 2B078 8003A878 00000000 */   nop
    /* 2B07C 8003A87C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 2B080 8003A880 00000000 */  nop
    /* 2B084 8003A884 0800E003 */  jr         $ra
    /* 2B088 8003A888 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__24tScreenPinkSlipStandings7tPlayerR13tInputKeyTypeR12tMenuCommand
