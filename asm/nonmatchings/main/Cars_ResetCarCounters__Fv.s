.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_ResetCarCounters__Fv, 0x28

glabel Cars_ResetCarCounters__Fv
    /* 76854 80086054 A80280AF */  sw         $zero, %gp_rel(Cars_gNumCars)($gp)
    /* 76858 80086058 AC0280AF */  sw         $zero, %gp_rel(Cars_gNumRaceCars)($gp)
    /* 7685C 8008605C B00280AF */  sw         $zero, %gp_rel(Cars_gNumAICars)($gp)
    /* 76860 80086060 B40280AF */  sw         $zero, %gp_rel(Cars_gNumHumanRaceCars)($gp)
    /* 76864 80086064 B80280AF */  sw         $zero, %gp_rel(Cars_gNumAIRaceCars)($gp)
    /* 76868 80086068 BC0280AF */  sw         $zero, %gp_rel(Cars_gNumTrafficCars)($gp)
    /* 7686C 8008606C C00280AF */  sw         $zero, %gp_rel(Cars_gNumCopCars)($gp)
    /* 76870 80086070 C40280AF */  sw         $zero, %gp_rel(Cars_gNumLifeBasisCars)($gp)
    /* 76874 80086074 0800E003 */  jr         $ra
    /* 76878 80086078 00000000 */   nop
endlabel Cars_ResetCarCounters__Fv
