.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_CleanUp1__Fv, 0x38

glabel AIInit_CleanUp1__Fv
    /* 5760C 80066E0C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 57610 80066E10 1000BFAF */  sw         $ra, 0x10($sp)
    /* 57614 80066E14 615E010C */  jal        AI_CleanUp__Fv
    /* 57618 80066E18 00000000 */   nop
    /* 5761C 80066E1C 05B4010C */  jal        CleanUp1__14AIDataRecord_t
    /* 57620 80066E20 00000000 */   nop
    /* 57624 80066E24 E0CB010C */  jal        AITune_CleanUp1__Fv
    /* 57628 80066E28 00000000 */   nop
    /* 5762C 80066E2C EA9B010C */  jal        AI_TrafficCleanUp__Fv
    /* 57630 80066E30 00000000 */   nop
    /* 57634 80066E34 1000BF8F */  lw         $ra, 0x10($sp)
    /* 57638 80066E38 00000000 */  nop
    /* 5763C 80066E3C 0800E003 */  jr         $ra
    /* 57640 80066E40 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIInit_CleanUp1__Fv
