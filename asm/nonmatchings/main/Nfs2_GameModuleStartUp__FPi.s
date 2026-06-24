.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Nfs2_GameModuleStartUp__FPi, 0x1AC

glabel Nfs2_GameModuleStartUp__FPi
    /* 949A8 800A41A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 949AC 800A41AC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 949B0 800A41B0 21808000 */  addu       $s0, $a0, $zero
    /* 949B4 800A41B4 21200000 */  addu       $a0, $zero, $zero
    /* 949B8 800A41B8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 949BC 800A41BC E1EE020C */  jal        Audio_InitDriver__Fii
    /* 949C0 800A41C0 21288000 */   addu      $a1, $a0, $zero
    /* 949C4 800A41C4 978F030C */  jal        restoretextdraw
    /* 949C8 800A41C8 00000000 */   nop
    /* 949CC 800A41CC AE70030C */  jal        Platform_InitMemory__Fv
    /* 949D0 800A41D0 00000000 */   nop
    /* 949D4 800A41D4 2871030C */  jal        Platform_ResetDCTBuffer__Fv
    /* 949D8 800A41D8 00000000 */   nop
    /* 949DC 800A41DC 676F020C */  jal        GameSetup_StartUp__FPi
    /* 949E0 800A41E0 21200002 */   addu      $a0, $s0, $zero
    /* 949E4 800A41E4 68CF020C */  jal        Replay_InitReplay__Fv
    /* 949E8 800A41E8 00000000 */   nop
    /* 949EC 800A41EC 948F020C */  jal        Nfs2_BefuddleCode__Fv
    /* 949F0 800A41F0 00000000 */   nop
    /* 949F4 800A41F4 2E6C030C */  jal        Loading_DrawLoadingScreen__Fv
    /* 949F8 800A41F8 00000000 */   nop
    /* 949FC 800A41FC 806C030C */  jal        Loading_UpdateLoadingScreen__Fi
    /* 94A00 800A4200 01000424 */   addiu     $a0, $zero, 0x1
    /* 94A04 800A4204 C28F020C */  jal        NFS4_LoadPerps__Fv
    /* 94A08 800A4208 00000000 */   nop
    /* 94A0C 800A420C 806C030C */  jal        Loading_UpdateLoadingScreen__Fi
    /* 94A10 800A4210 02000424 */   addiu     $a0, $zero, 0x2
    /* 94A14 800A4214 9DA3020C */  jal        Physics_CheckGamedata__Fv
    /* 94A18 800A4218 00000000 */   nop
    /* 94A1C 800A421C 792E020C */  jal        Clock_SystemStartUp__Fv
    /* 94A20 800A4220 00000000 */   nop
    /* 94A24 800A4224 DFDD010C */  jal        AudioCmn_LoadGameSamples__Fv
    /* 94A28 800A4228 00000000 */   nop
    /* 94A2C 800A422C 4F67020C */  jal        CopSpeak_StartUp__Fv
    /* 94A30 800A4230 00000000 */   nop
    /* 94A34 800A4234 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 94A38 800A4238 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 94A3C 800A423C 01000224 */  addiu      $v0, $zero, 0x1
    /* 94A40 800A4240 0C006214 */  bne        $v1, $v0, .L800A4274
    /* 94A44 800A4244 00000000 */   nop
    /* 94A48 800A4248 1480023C */  lui        $v0, %hi(_6Speech_fgSpeech)
    /* 94A4C 800A424C 84CD428C */  lw         $v0, %lo(_6Speech_fgSpeech)($v0)
    /* 94A50 800A4250 00000000 */  nop
    /* 94A54 800A4254 07004014 */  bnez       $v0, .L800A4274
    /* 94A58 800A4258 00000000 */   nop
    /* 94A5C 800A425C 578F020C */  jal        __builtin_new
    /* 94A60 800A4260 A4030424 */   addiu     $a0, $zero, 0x3A4
    /* 94A64 800A4264 7D55020C */  jal        __6Speech
    /* 94A68 800A4268 21204000 */   addu      $a0, $v0, $zero
    /* 94A6C 800A426C 1480013C */  lui        $at, %hi(_6Speech_fgSpeech)
    /* 94A70 800A4270 84CD22AC */  sw         $v0, %lo(_6Speech_fgSpeech)($at)
  .L800A4274:
    /* 94A74 800A4274 04CD020C */  jal        Render_InitPauseMenu__Fv
    /* 94A78 800A4278 00000000 */   nop
    /* 94A7C 800A427C BDCD020C */  jal        Render_InitTrackRender__Fv
    /* 94A80 800A4280 00000000 */   nop
    /* 94A84 800A4284 806C030C */  jal        Loading_UpdateLoadingScreen__Fi
    /* 94A88 800A4288 04000424 */   addiu     $a0, $zero, 0x4
    /* 94A8C 800A428C 72F9010C */  jal        BWorld_Init__Fv
    /* 94A90 800A4290 00000000 */   nop
    /* 94A94 800A4294 806C030C */  jal        Loading_UpdateLoadingScreen__Fi
    /* 94A98 800A4298 06000424 */   addiu     $a0, $zero, 0x6
    /* 94A9C 800A429C 4640030C */  jal        Hrz_InitHorizon__Fv
    /* 94AA0 800A42A0 00000000 */   nop
    /* 94AA4 800A42A4 796F030C */  jal        Night_InitNightDriving__Fv
    /* 94AA8 800A42A8 00000000 */   nop
    /* 94AAC 800A42AC 4C89030C */  jal        Weather_Init__Fv
    /* 94AB0 800A42B0 00000000 */   nop
    /* 94AB4 800A42B4 806C030C */  jal        Loading_UpdateLoadingScreen__Fi
    /* 94AB8 800A42B8 07000424 */   addiu     $a0, $zero, 0x7
    /* 94ABC 800A42BC 5DD9020C */  jal        Sim_StartUp__Fv
    /* 94AC0 800A42C0 00000000 */   nop
    /* 94AC4 800A42C4 FDCD020C */  jal        Render_InitTrackRenderPostSim__Fv
    /* 94AC8 800A42C8 00000000 */   nop
    /* 94ACC 800A42CC 9256030C */  jal        Hud_InitMap__Fv
    /* 94AD0 800A42D0 00000000 */   nop
    /* 94AD4 800A42D4 BBDC020C */  jal        SimQueue_StartUp__Fv
    /* 94AD8 800A42D8 00000000 */   nop
    /* 94ADC 800A42DC A194030C */  jal        largestunused
    /* 94AE0 800A42E0 00000000 */   nop
    /* 94AE4 800A42E4 21204000 */  addu       $a0, $v0, $zero
    /* 94AE8 800A42E8 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 94AEC 800A42EC F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 94AF0 800A42F0 01000224 */  addiu      $v0, $zero, 0x1
    /* 94AF4 800A42F4 03006214 */  bne        $v1, $v0, .L800A4304
    /* 94AF8 800A42F8 0100023C */   lui       $v0, (0x13000 >> 16)
    /* 94AFC 800A42FC C2900208 */  j          .L800A4308
    /* 94B00 800A4300 00304234 */   ori       $v0, $v0, (0x13000 & 0xFFFF)
  .L800A4304:
    /* 94B04 800A4304 00B00234 */  ori        $v0, $zero, 0xB000
  .L800A4308:
    /* 94B08 800A4308 2A104400 */  slt        $v0, $v0, $a0
    /* 94B0C 800A430C 06004010 */  beqz       $v0, .L800A4328
    /* 94B10 800A4310 00600424 */   addiu     $a0, $zero, 0x6000
    /* 94B14 800A4314 0100053C */  lui        $a1, (0x14000 >> 16)
    /* 94B18 800A4318 0040A534 */  ori        $a1, $a1, (0x14000 & 0xFFFF)
    /* 94B1C 800A431C 1480063C */  lui        $a2, %hi(D_8013D29C)
    /* 94B20 800A4320 06EB010C */  jal        AudioMus_SysStartUp__FiiPc
    /* 94B24 800A4324 9CD2C624 */   addiu     $a2, $a2, %lo(D_8013D29C)
  .L800A4328:
    /* 94B28 800A4328 1180053C */  lui        $a1, %hi(GameSetup_gData)
    /* 94B2C 800A432C EC31A524 */  addiu      $a1, $a1, %lo(GameSetup_gData)
    /* 94B30 800A4330 0801A48C */  lw         $a0, 0x108($a1)
    /* 94B34 800A4334 B6EB010C */  jal        AudioMus_BuildPlayList__FiPi
    /* 94B38 800A4338 0C01A524 */   addiu     $a1, $a1, 0x10C
    /* 94B3C 800A433C A194030C */  jal        largestunused
    /* 94B40 800A4340 00000000 */   nop
    /* 94B44 800A4344 1400BF8F */  lw         $ra, 0x14($sp)
    /* 94B48 800A4348 1000B08F */  lw         $s0, 0x10($sp)
    /* 94B4C 800A434C 0800E003 */  jr         $ra
    /* 94B50 800A4350 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Nfs2_GameModuleStartUp__FPi
