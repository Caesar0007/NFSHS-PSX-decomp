.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_Render__Fv, 0x468

glabel Hud_Render__Fv
    /* C9858 800D9058 1180023C */  lui        $v0, %hi(D_80117048)
    /* C985C 800D905C 4870428C */  lw         $v0, %lo(D_80117048)($v0)
    /* C9860 800D9060 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* C9864 800D9064 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* C9868 800D9068 2800B6AF */  sw         $s6, 0x28($sp)
    /* C986C 800D906C 2400B5AF */  sw         $s5, 0x24($sp)
    /* C9870 800D9070 2000B4AF */  sw         $s4, 0x20($sp)
    /* C9874 800D9074 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C9878 800D9078 1800B2AF */  sw         $s2, 0x18($sp)
    /* C987C 800D907C 1400B1AF */  sw         $s1, 0x14($sp)
    /* C9880 800D9080 17004010 */  beqz       $v0, .L800D90E0
    /* C9884 800D9084 1000B0AF */   sw        $s0, 0x10($sp)
    /* C9888 800D9088 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* C988C 800D908C B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* C9890 800D9090 00000000 */  nop
    /* C9894 800D9094 40024228 */  slti       $v0, $v0, 0x240
    /* C9898 800D9098 04004010 */  beqz       $v0, .L800D90AC
    /* C989C 800D909C 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* C98A0 800D90A0 30274224 */  addiu      $v0, $v0, %lo(DashHUD_gInfo)
    /* C98A4 800D90A4 1C0040AC */  sw         $zero, 0x1C($v0)
    /* C98A8 800D90A8 200040AC */  sw         $zero, 0x20($v0)
  .L800D90AC:
    /* C98AC 800D90AC 1C14848F */  lw         $a0, %gp_rel(Hud_gStatsView)($gp)
    /* C98B0 800D90B0 1180023C */  lui        $v0, %hi(gCView)
    /* C98B4 800D90B4 18F8020C */  jal        Draw_StartRenderingView__Fi
    /* C98B8 800D90B8 7C6F44AC */   sw        $a0, %lo(gCView)($v0)
    /* C98BC 800D90BC E447030C */  jal        Hud_DebugCrap__Fv
    /* C98C0 800D90C0 00000000 */   nop
    /* C98C4 800D90C4 A36B030C */  jal        Hud_RenderStatsView__Fv
    /* C98C8 800D90C8 00000000 */   nop
    /* C98CC 800D90CC 1C14848F */  lw         $a0, %gp_rel(Hud_gStatsView)($gp)
    /* C98D0 800D90D0 46F8020C */  jal        Draw_StopRenderingView__Fi
    /* C98D4 800D90D4 00000000 */   nop
    /* C98D8 800D90D8 26650308 */  j          .L800D9498
    /* C98DC 800D90DC 00000000 */   nop
  .L800D90E0:
    /* C98E0 800D90E0 DC13828F */  lw         $v0, %gp_rel(HudBustedOverlay)($gp)
    /* C98E4 800D90E4 00000000 */  nop
    /* C98E8 800D90E8 30004014 */  bnez       $v0, .L800D91AC
    /* C98EC 800D90EC 00000000 */   nop
    /* C98F0 800D90F0 DC18828F */  lw         $v0, %gp_rel(D_8013DE28)($gp)
    /* C98F4 800D90F4 00000000 */  nop
    /* C98F8 800D90F8 2C004010 */  beqz       $v0, .L800D91AC
    /* C98FC 800D90FC 00000000 */   nop
    /* C9900 800D9100 1480023C */  lui        $v0, %hi(ticks)
    /* C9904 800D9104 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* C9908 800D9108 E018838F */  lw         $v1, %gp_rel(D_8013DE2C)($gp)
    /* C990C 800D910C 00000000 */  nop
    /* C9910 800D9110 23104300 */  subu       $v0, $v0, $v1
    /* C9914 800D9114 FB004228 */  slti       $v0, $v0, 0xFB
    /* C9918 800D9118 24004014 */  bnez       $v0, .L800D91AC
    /* C991C 800D911C 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* C9920 800D9120 3027428C */  lw         $v0, %lo(DashHUD_gInfo)($v0)
    /* C9924 800D9124 00000000 */  nop
    /* C9928 800D9128 0F004010 */  beqz       $v0, .L800D9168
    /* C992C 800D912C 1180033C */   lui       $v1, %hi(Cars_gRaceCarList)
    /* C9930 800D9130 00FA628C */  lw         $v0, %lo(Cars_gRaceCarList)($v1)
    /* C9934 800D9134 00000000 */  nop
    /* C9938 800D9138 6002428C */  lw         $v0, 0x260($v0)
    /* C993C 800D913C 00000000 */  nop
    /* C9940 800D9140 00024230 */  andi       $v0, $v0, 0x200
    /* C9944 800D9144 0A004010 */  beqz       $v0, .L800D9170
    /* C9948 800D9148 00FA6324 */   addiu     $v1, $v1, %lo(Cars_gRaceCarList)
    /* C994C 800D914C 0400628C */  lw         $v0, 0x4($v1)
    /* C9950 800D9150 00000000 */  nop
    /* C9954 800D9154 6002428C */  lw         $v0, 0x260($v0)
    /* C9958 800D9158 00000000 */  nop
    /* C995C 800D915C 00024230 */  andi       $v0, $v0, 0x200
    /* C9960 800D9160 04004010 */  beqz       $v0, .L800D9174
    /* C9964 800D9164 FA000424 */   addiu     $a0, $zero, 0xFA
  .L800D9168:
    /* C9968 800D9168 5D640308 */  j          .L800D9174
    /* C996C 800D916C 32000424 */   addiu     $a0, $zero, 0x32
  .L800D9170:
    /* C9970 800D9170 FA000424 */  addiu      $a0, $zero, 0xFA
  .L800D9174:
    /* C9974 800D9174 DC18838F */  lw         $v1, %gp_rel(D_8013DE28)($gp)
    /* C9978 800D9178 00000000 */  nop
    /* C997C 800D917C 2A106400 */  slt        $v0, $v1, $a0
    /* C9980 800D9180 02004010 */  beqz       $v0, .L800D918C
    /* C9984 800D9184 21288000 */   addu      $a1, $a0, $zero
    /* C9988 800D9188 21286000 */  addu       $a1, $v1, $zero
  .L800D918C:
    /* C998C 800D918C E813828F */  lw         $v0, %gp_rel(BTC_Countdown)($gp)
    /* C9990 800D9190 23186400 */  subu       $v1, $v1, $a0
    /* C9994 800D9194 21104500 */  addu       $v0, $v0, $a1
    /* C9998 800D9198 E81382AF */  sw         $v0, %gp_rel(BTC_Countdown)($gp)
    /* C999C 800D919C 02006104 */  bgez       $v1, .L800D91A8
    /* C99A0 800D91A0 00000000 */   nop
    /* C99A4 800D91A4 21180000 */  addu       $v1, $zero, $zero
  .L800D91A8:
    /* C99A8 800D91A8 DC1883AF */  sw         $v1, %gp_rel(D_8013DE28)($gp)
  .L800D91AC:
    /* C99AC 800D91AC F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C99B0 800D91B0 00000000 */  nop
    /* C99B4 800D91B4 4E004010 */  beqz       $v0, .L800D92F0
    /* C99B8 800D91B8 00000000 */   nop
    /* C99BC 800D91BC E418828F */  lw         $v0, %gp_rel(D_8013DE30)($gp)
    /* C99C0 800D91C0 00000000 */  nop
    /* C99C4 800D91C4 4A004014 */  bnez       $v0, .L800D92F0
    /* C99C8 800D91C8 1180033C */   lui       $v1, %hi(DashHUD_gInfo)
    /* C99CC 800D91CC 3027628C */  lw         $v0, %lo(DashHUD_gInfo)($v1)
    /* C99D0 800D91D0 00000000 */  nop
    /* C99D4 800D91D4 B0004004 */  bltz       $v0, .L800D9498
    /* C99D8 800D91D8 21800000 */   addu      $s0, $zero, $zero
    /* C99DC 800D91DC 1180023C */  lui        $v0, %hi(Replay_ReplayInterface)
    /* C99E0 800D91E0 2C705624 */  addiu      $s6, $v0, %lo(Replay_ReplayInterface)
    /* C99E4 800D91E4 21986000 */  addu       $s3, $v1, $zero
    /* C99E8 800D91E8 1280023C */  lui        $v0, %hi(simGlobal)
    /* C99EC 800D91EC ACE05524 */  addiu      $s5, $v0, %lo(simGlobal)
    /* C99F0 800D91F0 21880002 */  addu       $s1, $s0, $zero
    /* C99F4 800D91F4 1480143C */  lui        $s4, %hi(Hud_gHudView)
    /* C99F8 800D91F8 50D99426 */  addiu      $s4, $s4, %lo(Hud_gHudView)
    /* C99FC 800D91FC 21908002 */  addu       $s2, $s4, $zero
  .L800D9200:
    /* C9A00 800D9200 0000448E */  lw         $a0, 0x0($s2)
    /* C9A04 800D9204 18F8020C */  jal        Draw_StartRenderingView__Fi
    /* C9A08 800D9208 00000000 */   nop
    /* C9A0C 800D920C 5B47030C */  jal        Hud_GoTpage__Fi
    /* C9A10 800D9210 01000424 */   addiu     $a0, $zero, 0x1
    /* C9A14 800D9214 0D000016 */  bnez       $s0, .L800D924C
    /* C9A18 800D9218 00000000 */   nop
    /* C9A1C 800D921C 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* C9A20 800D9220 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* C9A24 800D9224 00000000 */  nop
    /* C9A28 800D9228 02004228 */  slti       $v0, $v0, 0x2
    /* C9A2C 800D922C 07004014 */  bnez       $v0, .L800D924C
    /* C9A30 800D9230 00000000 */   nop
    /* C9A34 800D9234 1C00C28E */  lw         $v0, 0x1C($s6)
    /* C9A38 800D9238 00000000 */  nop
    /* C9A3C 800D923C 03004014 */  bnez       $v0, .L800D924C
    /* C9A40 800D9240 00000000 */   nop
    /* C9A44 800D9244 945C030C */  jal        Hud_BuildReplay__Fv
    /* C9A48 800D9248 00000000 */   nop
  .L800D924C:
    /* C9A4C 800D924C 3027628E */  lw         $v0, %lo(DashHUD_gInfo)($s3)
    /* C9A50 800D9250 00000000 */  nop
    /* C9A54 800D9254 0F000216 */  bne        $s0, $v0, .L800D9294
    /* C9A58 800D9258 30276226 */   addiu     $v0, $s3, %lo(DashHUD_gInfo)
    /* C9A5C 800D925C 0400A28E */  lw         $v0, 0x4($s5)
    /* C9A60 800D9260 00000000 */  nop
    /* C9A64 800D9264 40024228 */  slti       $v0, $v0, 0x240
    /* C9A68 800D9268 07004010 */  beqz       $v0, .L800D9288
    /* C9A6C 800D926C 01000424 */   addiu     $a0, $zero, 0x1
    /* C9A70 800D9270 1480023C */  lui        $v0, %hi(countdown)
    /* C9A74 800D9274 3CC64290 */  lbu        $v0, %lo(countdown)($v0)
    /* C9A78 800D9278 00000000 */  nop
    /* C9A7C 800D927C 02004014 */  bnez       $v0, .L800D9288
    /* C9A80 800D9280 00000000 */   nop
    /* C9A84 800D9284 21200000 */  addu       $a0, $zero, $zero
  .L800D9288:
    /* C9A88 800D9288 F758030C */  jal        Hud_BuildCdPlayer__Fii
    /* C9A8C 800D928C 21280002 */   addu      $a1, $s0, $zero
    /* C9A90 800D9290 30276226 */  addiu      $v0, $s3, %lo(DashHUD_gInfo)
  .L800D9294:
    /* C9A94 800D9294 21102202 */  addu       $v0, $s1, $v0
    /* C9A98 800D9298 1C00428C */  lw         $v0, 0x1C($v0)
    /* C9A9C 800D929C 00000000 */  nop
    /* C9AA0 800D92A0 05004010 */  beqz       $v0, .L800D92B8
    /* C9AA4 800D92A4 00000000 */   nop
    /* C9AA8 800D92A8 7F47030C */  jal        Hud_DebugInfo__Fv
    /* C9AAC 800D92AC 00000000 */   nop
    /* C9AB0 800D92B0 8951030C */  jal        Hud_BuildNumbers0__Fi
    /* C9AB4 800D92B4 21200002 */   addu      $a0, $s0, $zero
  .L800D92B8:
    /* C9AB8 800D92B8 5B47030C */  jal        Hud_GoTpage__Fi
    /* C9ABC 800D92BC 21200000 */   addu      $a0, $zero, $zero
    /* C9AC0 800D92C0 21103402 */  addu       $v0, $s1, $s4
    /* C9AC4 800D92C4 04003126 */  addiu      $s1, $s1, 0x4
    /* C9AC8 800D92C8 0000448C */  lw         $a0, 0x0($v0)
    /* C9ACC 800D92CC 46F8020C */  jal        Draw_StopRenderingView__Fi
    /* C9AD0 800D92D0 04005226 */   addiu     $s2, $s2, 0x4
    /* C9AD4 800D92D4 3027628E */  lw         $v0, %lo(DashHUD_gInfo)($s3)
    /* C9AD8 800D92D8 01001026 */  addiu      $s0, $s0, 0x1
    /* C9ADC 800D92DC 2A105000 */  slt        $v0, $v0, $s0
    /* C9AE0 800D92E0 C7FF4010 */  beqz       $v0, .L800D9200
    /* C9AE4 800D92E4 00000000 */   nop
    /* C9AE8 800D92E8 26650308 */  j          .L800D9498
    /* C9AEC 800D92EC 00000000 */   nop
  .L800D92F0:
    /* C9AF0 800D92F0 DC13828F */  lw         $v0, %gp_rel(HudBustedOverlay)($gp)
    /* C9AF4 800D92F4 00000000 */  nop
    /* C9AF8 800D92F8 1A004010 */  beqz       $v0, .L800D9364
    /* C9AFC 800D92FC 21800000 */   addu      $s0, $zero, $zero
    /* C9B00 800D9300 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* C9B04 800D9304 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* C9B08 800D9308 00000000 */  nop
    /* C9B0C 800D930C 02004228 */  slti       $v0, $v0, 0x2
    /* C9B10 800D9310 14004010 */  beqz       $v0, .L800D9364
    /* C9B14 800D9314 1180023C */   lui       $v0, %hi(gCView)
    /* C9B18 800D9318 1C14848F */  lw         $a0, %gp_rel(Hud_gStatsView)($gp)
    /* C9B1C 800D931C F8139097 */  lhu        $s0, %gp_rel(HudBustedOverlayPlayer)($gp)
    /* C9B20 800D9320 18F8020C */  jal        Draw_StartRenderingView__Fi
    /* C9B24 800D9324 7C6F44AC */   sw        $a0, %lo(gCView)($v0)
    /* C9B28 800D9328 00841000 */  sll        $s0, $s0, 16
    /* C9B2C 800D932C 03841000 */  sra        $s0, $s0, 16
    /* C9B30 800D9330 21200002 */  addu       $a0, $s0, $zero
    /* C9B34 800D9334 80180400 */  sll        $v1, $a0, 2
    /* C9B38 800D9338 1480023C */  lui        $v0, %hi(StatsTimer)
    /* C9B3C 800D933C 98D94224 */  addiu      $v0, $v0, %lo(StatsTimer)
    /* C9B40 800D9340 21186200 */  addu       $v1, $v1, $v0
    /* C9B44 800D9344 0000628C */  lw         $v0, 0x0($v1)
    /* C9B48 800D9348 21280000 */  addu       $a1, $zero, $zero
    /* C9B4C 800D934C 01004224 */  addiu      $v0, $v0, 0x1
    /* C9B50 800D9350 CA69030C */  jal        Hud_BTCStats__Fsb
    /* C9B54 800D9354 000062AC */   sw        $v0, 0x0($v1)
    /* C9B58 800D9358 1C14848F */  lw         $a0, %gp_rel(Hud_gStatsView)($gp)
    /* C9B5C 800D935C 46F8020C */  jal        Draw_StopRenderingView__Fi
    /* C9B60 800D9360 21800000 */   addu      $s0, $zero, $zero
  .L800D9364:
    /* C9B64 800D9364 1480123C */  lui        $s2, %hi(Hud_gWingmanInterface)
    /* C9B68 800D9368 B0D85226 */  addiu      $s2, $s2, %lo(Hud_gWingmanInterface)
  .L800D936C:
    /* C9B6C 800D936C 0200022A */  slti       $v0, $s0, 0x2
    /* C9B70 800D9370 33004010 */  beqz       $v0, .L800D9440
    /* C9B74 800D9374 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* C9B78 800D9378 0271020C */  jal        Input_WingCommandMode__Fi
    /* C9B7C 800D937C 21200002 */   addu      $a0, $s0, $zero
    /* C9B80 800D9380 00004392 */  lbu        $v1, 0x0($s2)
    /* C9B84 800D9384 21884000 */  addu       $s1, $v0, $zero
    /* C9B88 800D9388 05007114 */  bne        $v1, $s1, .L800D93A0
    /* C9B8C 800D938C 80181000 */   sll       $v1, $s0, 2
    /* C9B90 800D9390 DC13828F */  lw         $v0, %gp_rel(HudBustedOverlay)($gp)
    /* C9B94 800D9394 00000000 */  nop
    /* C9B98 800D9398 22004014 */  bnez       $v0, .L800D9424
    /* C9B9C 800D939C 00000000 */   nop
  .L800D93A0:
    /* C9BA0 800D93A0 1480023C */  lui        $v0, %hi(Hud_gWingmanFlashTicks)
    /* C9BA4 800D93A4 B8D84224 */  addiu      $v0, $v0, %lo(Hud_gWingmanFlashTicks)
    /* C9BA8 800D93A8 21186200 */  addu       $v1, $v1, $v0
    /* C9BAC 800D93AC 1480043C */  lui        $a0, %hi(ticks)
    /* C9BB0 800D93B0 ACDC848C */  lw         $a0, %lo(ticks)($a0)
    /* C9BB4 800D93B4 0000628C */  lw         $v0, 0x0($v1)
    /* C9BB8 800D93B8 00000000 */  nop
    /* C9BBC 800D93BC 2A104400 */  slt        $v0, $v0, $a0
    /* C9BC0 800D93C0 1C004010 */  beqz       $v0, .L800D9434
    /* C9BC4 800D93C4 00000000 */   nop
    /* C9BC8 800D93C8 00004292 */  lbu        $v0, 0x0($s2)
    /* C9BCC 800D93CC 00000000 */  nop
    /* C9BD0 800D93D0 0E005110 */  beq        $v0, $s1, .L800D940C
    /* C9BD4 800D93D4 00000000 */   nop
    /* C9BD8 800D93D8 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* C9BDC 800D93DC F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* C9BE0 800D93E0 00000000 */  nop
    /* C9BE4 800D93E4 02004228 */  slti       $v0, $v0, 0x2
    /* C9BE8 800D93E8 0E004010 */  beqz       $v0, .L800D9424
    /* C9BEC 800D93EC 00000000 */   nop
    /* C9BF0 800D93F0 DC13828F */  lw         $v0, %gp_rel(HudBustedOverlay)($gp)
    /* C9BF4 800D93F4 00000000 */  nop
    /* C9BF8 800D93F8 04004014 */  bnez       $v0, .L800D940C
    /* C9BFC 800D93FC 21200002 */   addu      $a0, $s0, $zero
    /* C9C00 800D9400 D34A030C */  jal        Hud_InitMapFrame__Fii
    /* C9C04 800D9404 21282002 */   addu      $a1, $s1, $zero
    /* C9C08 800D9408 000051A2 */  sb         $s1, 0x0($s2)
  .L800D940C:
    /* C9C0C 800D940C 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* C9C10 800D9410 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* C9C14 800D9414 00000000 */  nop
    /* C9C18 800D9418 02004228 */  slti       $v0, $v0, 0x2
    /* C9C1C 800D941C 05004014 */  bnez       $v0, .L800D9434
    /* C9C20 800D9420 00000000 */   nop
  .L800D9424:
    /* C9C24 800D9424 000040A2 */  sb         $zero, 0x0($s2)
    /* C9C28 800D9428 21200002 */  addu       $a0, $s0, $zero
    /* C9C2C 800D942C D34A030C */  jal        Hud_InitMapFrame__Fii
    /* C9C30 800D9430 21280000 */   addu      $a1, $zero, $zero
  .L800D9434:
    /* C9C34 800D9434 01005226 */  addiu      $s2, $s2, 0x1
    /* C9C38 800D9438 DB640308 */  j          .L800D936C
    /* C9C3C 800D943C 01001026 */   addiu     $s0, $s0, 0x1
  .L800D9440:
    /* C9C40 800D9440 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* C9C44 800D9444 FC1880AF */  sw         $zero, %gp_rel(D_8013DE48)($gp)
    /* C9C48 800D9448 40024228 */  slti       $v0, $v0, 0x240
    /* C9C4C 800D944C 0C004010 */  beqz       $v0, .L800D9480
    /* C9C50 800D9450 00000000 */   nop
    /* C9C54 800D9454 1480023C */  lui        $v0, %hi(countdown)
    /* C9C58 800D9458 3CC64290 */  lbu        $v0, %lo(countdown)($v0)
    /* C9C5C 800D945C 00000000 */  nop
    /* C9C60 800D9460 07004010 */  beqz       $v0, .L800D9480
    /* C9C64 800D9464 00000000 */   nop
    /* C9C68 800D9468 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C9C6C 800D946C 00000000 */  nop
    /* C9C70 800D9470 03004014 */  bnez       $v0, .L800D9480
    /* C9C74 800D9474 00000000 */   nop
    /* C9C78 800D9478 995F030C */  jal        Hud_Render321Go__Fv
    /* C9C7C 800D947C 00000000 */   nop
  .L800D9480:
    /* C9C80 800D9480 B460030C */  jal        Hud_RenderHudView__Fv
    /* C9C84 800D9484 00000000 */   nop
    /* C9C88 800D9488 0E5E030C */  jal        Hud_RenderMapView__Fv
    /* C9C8C 800D948C 00000000 */   nop
    /* C9C90 800D9490 1263030C */  jal        Hud_RenderTacView__Fv
    /* C9C94 800D9494 00000000 */   nop
  .L800D9498:
    /* C9C98 800D9498 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* C9C9C 800D949C 2800B68F */  lw         $s6, 0x28($sp)
    /* C9CA0 800D94A0 2400B58F */  lw         $s5, 0x24($sp)
    /* C9CA4 800D94A4 2000B48F */  lw         $s4, 0x20($sp)
    /* C9CA8 800D94A8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C9CAC 800D94AC 1800B28F */  lw         $s2, 0x18($sp)
    /* C9CB0 800D94B0 1400B18F */  lw         $s1, 0x14($sp)
    /* C9CB4 800D94B4 1000B08F */  lw         $s0, 0x10($sp)
    /* C9CB8 800D94B8 0800E003 */  jr         $ra
    /* C9CBC 800D94BC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Hud_Render__Fv
