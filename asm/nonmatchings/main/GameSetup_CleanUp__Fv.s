.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GameSetup_CleanUp__Fv, 0x8

glabel GameSetup_CleanUp__Fv
    /* 8C920 8009C120 0800E003 */  jr         $ra
    /* 8C924 8009C124 00000000 */   nop
endlabel GameSetup_CleanUp__Fv
