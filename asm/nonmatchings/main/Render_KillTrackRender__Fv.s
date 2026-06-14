.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_KillTrackRender__Fv, 0x68

glabel Render_KillTrackRender__Fv
    /* A4020 800B3820 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A4024 800B3824 1000BFAF */  sw         $ra, 0x10($sp)
    /* A4028 800B3828 A1F9020C */  jal        Draw_DeInitRenderEngine__Fv
    /* A402C 800B382C 00000000 */   nop
    /* A4030 800B3830 52FA020C */  jal        DrawC_KillRenderingData__Fv
    /* A4034 800B3834 00000000 */   nop
    /* A4038 800B3838 E06F030C */  jal        Night_KillNightDriving__Fv
    /* A403C 800B383C 00000000 */   nop
    /* A4040 800B3840 1382030C */  jal        Texture_KillTrackTexture__Fv
    /* A4044 800B3844 00000000 */   nop
    /* A4048 800B3848 CCDF020C */  jal        Souffle_KillTrackSouffle__Fv
    /* A404C 800B384C 00000000 */   nop
    /* A4050 800B3850 637D030C */  jal        Skidmark_KillSkidmark__Fv
    /* A4054 800B3854 00000000 */   nop
    /* A4058 800B3858 80EE020C */  jal        TrgSfx_KillTrgSfx__Fv
    /* A405C 800B385C 00000000 */   nop
    /* A4060 800B3860 FC6B020C */  jal        DashHUD_KillHUD__Fv
    /* A4064 800B3864 00000000 */   nop
    /* A4068 800B3868 D8F8020C */  jal        Draw_SetDrawSyncCallback__FPFv_v
    /* A406C 800B386C 21200000 */   addu      $a0, $zero, $zero
    /* A4070 800B3870 4484030C */  jal        Fog_DeInitFogTriggers__Fv
    /* A4074 800B3874 00000000 */   nop
    /* A4078 800B3878 1000BF8F */  lw         $ra, 0x10($sp)
    /* A407C 800B387C 00000000 */  nop
    /* A4080 800B3880 0800E003 */  jr         $ra
    /* A4084 800B3884 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_KillTrackRender__Fv
