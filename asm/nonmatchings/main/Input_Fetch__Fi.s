.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Input_Fetch__Fi, 0x28

glabel Input_Fetch__Fi
    /* 8DA94 8009D294 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8DA98 8009D298 1480053C */  lui        $a1, %hi(Input_gSim)
    /* 8DA9C 8009D29C 2CD2A524 */  addiu      $a1, $a1, %lo(Input_gSim)
    /* 8DAA0 8009D2A0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8DAA4 8009D2A4 69DD020C */  jal        SimQueue_GetCurrentInput__FiP14Input_tResults
    /* 8DAA8 8009D2A8 00000000 */   nop
    /* 8DAAC 8009D2AC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8DAB0 8009D2B0 00000000 */  nop
    /* 8DAB4 8009D2B4 0800E003 */  jr         $ra
    /* 8DAB8 8009D2B8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Input_Fetch__Fi
