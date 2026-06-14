.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_InitTrackRender__Fv, 0xB8

glabel Render_InitTrackRender__Fv
    /* A3EF4 800B36F4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* A3EF8 800B36F8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A3EFC 800B36FC EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* A3F00 800B3700 1800BFAF */  sw         $ra, 0x18($sp)
    /* A3F04 800B3704 4800448C */  lw         $a0, 0x48($v0)
    /* A3F08 800B3708 5400458C */  lw         $a1, 0x54($v0)
    /* A3F0C 800B370C 3386030C */  jal        TrackSpec_Load__Fii
    /* A3F10 800B3710 00000000 */   nop
    /* A3F14 800B3714 79CC020C */  jal        Render_CreateViews__Fv
    /* A3F18 800B3718 00000000 */   nop
    /* A3F1C 800B371C 40010424 */  addiu      $a0, $zero, 0x140
    /* A3F20 800B3720 00010524 */  addiu      $a1, $zero, 0x100
    /* A3F24 800B3724 21108000 */  addu       $v0, $a0, $zero
    /* A3F28 800B3728 1000A2AF */  sw         $v0, 0x10($sp)
    /* A3F2C 800B372C F0000224 */  addiu      $v0, $zero, 0xF0
    /* A3F30 800B3730 21300000 */  addu       $a2, $zero, $zero
    /* A3F34 800B3734 2138A000 */  addu       $a3, $a1, $zero
    /* A3F38 800B3738 76F9020C */  jal        Draw_InitRenderEngine__Fiiiiii
    /* A3F3C 800B373C 1400A2AF */   sw        $v0, 0x14($sp)
    /* A3F40 800B3740 46FA020C */  jal        DrawC_BuildRenderingData__Fv
    /* A3F44 800B3744 00000000 */   nop
    /* A3F48 800B3748 2E81030C */  jal        Texture_InitTrackTexture__Fv
    /* A3F4C 800B374C 00000000 */   nop
    /* A3F50 800B3750 166D020C */  jal        GenericPMX_LoadTexture__Fv
    /* A3F54 800B3754 00000000 */   nop
    /* A3F58 800B3758 B5DF020C */  jal        Souffle_InitTrackSouffle__Fv
    /* A3F5C 800B375C 00000000 */   nop
    /* A3F60 800B3760 417D030C */  jal        Skidmark_InitSkidmark__Fv
    /* A3F64 800B3764 00000000 */   nop
    /* A3F68 800B3768 40EE020C */  jal        TrgSfx_InitTrgSfx__Fv
    /* A3F6C 800B376C 00000000 */   nop
    /* A3F70 800B3770 AF6B020C */  jal        DashHUD_InitHUD__Fv
    /* A3F74 800B3774 00000000 */   nop
    /* A3F78 800B3778 806C030C */  jal        Loading_UpdateLoadingScreen__Fi
    /* A3F7C 800B377C 03000424 */   addiu     $a0, $zero, 0x3
    /* A3F80 800B3780 0B84030C */  jal        Fog_InitFogTriggers__Fv
    /* A3F84 800B3784 00000000 */   nop
    /* A3F88 800B3788 0B80043C */  lui        $a0, %hi(FlareThing__Fv)
    /* A3F8C 800B378C D8F8020C */  jal        Draw_SetDrawSyncCallback__FPFv_v
    /* A3F90 800B3790 E8358424 */   addiu     $a0, $a0, %lo(FlareThing__Fv)
    /* A3F94 800B3794 81CE020C */  jal        Render_InitBlurMode__Fv
    /* A3F98 800B3798 00000000 */   nop
    /* A3F9C 800B379C 1800BF8F */  lw         $ra, 0x18($sp)
    /* A3FA0 800B37A0 00000000 */  nop
    /* A3FA4 800B37A4 0800E003 */  jr         $ra
    /* A3FA8 800B37A8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Render_InitTrackRender__Fv
