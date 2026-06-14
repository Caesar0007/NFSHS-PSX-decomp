.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_InitDashData__FP8Car_tObjPiT1, 0x28

glabel Cars_InitDashData__FP8Car_tObjPiT1
    /* 76764 80085F64 6404828C */  lw         $v0, 0x464($a0)
    /* 76768 80085F68 00000000 */  nop
    /* 7676C 80085F6C F000428C */  lw         $v0, 0xF0($v0)
    /* 76770 80085F70 00000000 */  nop
    /* 76774 80085F74 0000A2AC */  sw         $v0, 0x0($a1)
    /* 76778 80085F78 6404828C */  lw         $v0, 0x464($a0)
    /* 7677C 80085F7C 00000000 */  nop
    /* 76780 80085F80 F400428C */  lw         $v0, 0xF4($v0)
    /* 76784 80085F84 0800E003 */  jr         $ra
    /* 76788 80085F88 0000C2AC */   sw        $v0, 0x0($a2)
endlabel Cars_InitDashData__FP8Car_tObjPiT1
