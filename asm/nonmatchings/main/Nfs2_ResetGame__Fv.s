.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Nfs2_ResetGame__Fv, 0x60

glabel Nfs2_ResetGame__Fv
    /* 946A8 800A3EA8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 946AC 800A3EAC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 946B0 800A3EB0 D1CF020C */  jal        Replay_ResetReplay__Fv
    /* 946B4 800A3EB4 00000000 */   nop
    /* 946B8 800A3EB8 59F9010C */  jal        BWorld_Restart__Fv
    /* 946BC 800A3EBC 00000000 */   nop
    /* 946C0 800A3EC0 A2D9020C */  jal        Sim_Restart__Fv
    /* 946C4 800A3EC4 00000000 */   nop
    /* 946C8 800A3EC8 160E020C */  jal        Camera_Init__Fv
    /* 946CC 800A3ECC 00000000 */   nop
    /* 946D0 800A3ED0 2D89030C */  jal        Weather_Restart__Fv
    /* 946D4 800A3ED4 00000000 */   nop
    /* 946D8 800A3ED8 FBDA010C */  jal        AudioCmn_Reset__Fv
    /* 946DC 800A3EDC 00000000 */   nop
    /* 946E0 800A3EE0 6556020C */  jal        Reset__6Speech
    /* 946E4 800A3EE4 00000000 */   nop
    /* 946E8 800A3EE8 0ED2010C */  jal        AudioClc_StartUp__Fv
    /* 946EC 800A3EEC 00000000 */   nop
    /* 946F0 800A3EF0 046C020C */  jal        DashHUD_ResetHUD__Fv
    /* 946F4 800A3EF4 00000000 */   nop
    /* 946F8 800A3EF8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 946FC 800A3EFC 00000000 */  nop
    /* 94700 800A3F00 0800E003 */  jr         $ra
    /* 94704 800A3F04 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Nfs2_ResetGame__Fv
