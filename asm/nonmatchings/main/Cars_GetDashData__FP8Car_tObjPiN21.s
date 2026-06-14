.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_GetDashData__FP8Car_tObjPiN21, 0x24

glabel Cars_GetDashData__FP8Car_tObjPiN21
    /* 766C4 80085EC4 6804828C */  lw         $v0, 0x468($a0)
    /* 766C8 80085EC8 00000000 */  nop
    /* 766CC 80085ECC 0000A2AC */  sw         $v0, 0x0($a1)
    /* 766D0 80085ED0 42048290 */  lbu        $v0, 0x442($a0)
    /* 766D4 80085ED4 00000000 */  nop
    /* 766D8 80085ED8 0000C2AC */  sw         $v0, 0x0($a2)
    /* 766DC 80085EDC 2004828C */  lw         $v0, 0x420($a0)
    /* 766E0 80085EE0 0800E003 */  jr         $ra
    /* 766E4 80085EE4 0000E2AC */   sw        $v0, 0x0($a3)
endlabel Cars_GetDashData__FP8Car_tObjPiN21
