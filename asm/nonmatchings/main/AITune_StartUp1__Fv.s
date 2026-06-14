.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AITune_StartUp1__Fv, 0x38

glabel AITune_StartUp1__Fv
    /* 63740 80072F40 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 63744 80072F44 1000BFAF */  sw         $ra, 0x10($sp)
    /* 63748 80072F48 9ACB010C */  jal        AITune_GetOneWay__Fv
    /* 6374C 80072F4C 00000000 */   nop
    /* 63750 80072F50 A40082AF */  sw         $v0, %gp_rel(AITune_oneWay)($gp)
    /* 63754 80072F54 B0CB010C */  jal        AITune_GetDriveSide__Fv
    /* 63758 80072F58 00000000 */   nop
    /* 6375C 80072F5C A80082AF */  sw         $v0, %gp_rel(AITune_driveSide)($gp)
    /* 63760 80072F60 C0CB010C */  jal        AITune_GetRoughLapTimes__Fv
    /* 63764 80072F64 00000000 */   nop
    /* 63768 80072F68 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6376C 80072F6C AC0082AF */  sw         $v0, %gp_rel(AITune_gRoughLapTime)($gp)
    /* 63770 80072F70 0800E003 */  jr         $ra
    /* 63774 80072F74 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AITune_StartUp1__Fv
