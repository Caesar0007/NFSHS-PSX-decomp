.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_Reset1__Fv, 0xC

glabel AIInit_Reset1__Fv
    /* 574FC 80066CFC 380080AF */  sw         $zero, %gp_rel(AIInit_forceHumanHandBrake)($gp)
    /* 57500 80066D00 0800E003 */  jr         $ra
    /* 57504 80066D04 00000000 */   nop
endlabel AIInit_Reset1__Fv
