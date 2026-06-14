.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_CreateHudViews__Fv, 0x2EC

glabel Hud_CreateHudViews__Fv
    /* C2280 800D1A80 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* C2284 800D1A84 3400BFAF */  sw         $ra, 0x34($sp)
    /* C2288 800D1A88 3000B2AF */  sw         $s2, 0x30($sp)
    /* C228C 800D1A8C 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* C2290 800D1A90 7B4E030C */  jal        Hud_InitTables__Fv
    /* C2294 800D1A94 2800B0AF */   sw        $s0, 0x28($sp)
    /* C2298 800D1A98 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* C229C 800D1A9C EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* C22A0 800D1AA0 C403448C */  lw         $a0, 0x3C4($v0)
    /* C22A4 800D1AA4 F01380AF */  sw         $zero, %gp_rel(Hud_BeTheCop)($gp)
    /* C22A8 800D1AA8 0E008018 */  blez       $a0, .L800D1AE4
    /* C22AC 800D1AAC 21180000 */   addu      $v1, $zero, $zero
    /* C22B0 800D1AB0 01000624 */  addiu      $a2, $zero, 0x1
    /* C22B4 800D1AB4 21288000 */  addu       $a1, $a0, $zero
    /* C22B8 800D1AB8 21204000 */  addu       $a0, $v0, $zero
  .L800D1ABC:
    /* C22BC 800D1ABC D803828C */  lw         $v0, 0x3D8($a0)
    /* C22C0 800D1AC0 00000000 */  nop
    /* C22C4 800D1AC4 40004230 */  andi       $v0, $v0, 0x40
    /* C22C8 800D1AC8 02004010 */  beqz       $v0, .L800D1AD4
    /* C22CC 800D1ACC 00000000 */   nop
    /* C22D0 800D1AD0 F01386AF */  sw         $a2, %gp_rel(Hud_BeTheCop)($gp)
  .L800D1AD4:
    /* C22D4 800D1AD4 01006324 */  addiu      $v1, $v1, 0x1
    /* C22D8 800D1AD8 2A106500 */  slt        $v0, $v1, $a1
    /* C22DC 800D1ADC F7FF4014 */  bnez       $v0, .L800D1ABC
    /* C22E0 800D1AE0 B4008424 */   addiu     $a0, $a0, 0xB4
  .L800D1AE4:
    /* C22E4 800D1AE4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* C22E8 800D1AE8 EC314424 */  addiu      $a0, $v0, %lo(GameSetup_gData)
    /* C22EC 800D1AEC C803838C */  lw         $v1, 0x3C8($a0)
    /* C22F0 800D1AF0 00000000 */  nop
    /* C22F4 800D1AF4 02006228 */  slti       $v0, $v1, 0x2
    /* C22F8 800D1AF8 04004014 */  bnez       $v0, .L800D1B0C
    /* C22FC 800D1AFC FAFF0224 */   addiu     $v0, $zero, -0x6
    /* C2300 800D1B00 201482AF */  sw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C2304 800D1B04 D2460308 */  j          .L800D1B48
    /* C2308 800D1B08 1180023C */   lui       $v0, %hi(D_801131F8)
  .L800D1B0C:
    /* C230C 800D1B0C CC03828C */  lw         $v0, 0x3CC($a0)
    /* C2310 800D1B10 00000000 */  nop
    /* C2314 800D1B14 21106200 */  addu       $v0, $v1, $v0
    /* C2318 800D1B18 01000324 */  addiu      $v1, $zero, 0x1
    /* C231C 800D1B1C 05004310 */  beq        $v0, $v1, .L800D1B34
    /* C2320 800D1B20 08000224 */   addiu     $v0, $zero, 0x8
    /* C2324 800D1B24 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C2328 800D1B28 00000000 */  nop
    /* C232C 800D1B2C 04004010 */  beqz       $v0, .L800D1B40
    /* C2330 800D1B30 08000224 */   addiu     $v0, $zero, 0x8
  .L800D1B34:
    /* C2334 800D1B34 201482AF */  sw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C2338 800D1B38 D2460308 */  j          .L800D1B48
    /* C233C 800D1B3C 1180023C */   lui       $v0, %hi(D_801131F8)
  .L800D1B40:
    /* C2340 800D1B40 201480AF */  sw         $zero, %gp_rel(HudMapOffsetY)($gp)
    /* C2344 800D1B44 1180023C */  lui        $v0, %hi(D_801131F8)
  .L800D1B48:
    /* C2348 800D1B48 F831428C */  lw         $v0, %lo(D_801131F8)($v0)
    /* C234C 800D1B4C 01001224 */  addiu      $s2, $zero, 0x1
    /* C2350 800D1B50 4C005214 */  bne        $v0, $s2, .L800D1C84
    /* C2354 800D1B54 FF000424 */   addiu     $a0, $zero, 0xFF
    /* C2358 800D1B58 05010424 */  addiu      $a0, $zero, 0x105
    /* C235C 800D1B5C 45020624 */  addiu      $a2, $zero, 0x245
    /* C2360 800D1B60 2D001124 */  addiu      $s1, $zero, 0x2D
    /* C2364 800D1B64 2014858F */  lw         $a1, %gp_rel(HudMapOffsetY)($gp)
    /* C2368 800D1B68 30001024 */  addiu      $s0, $zero, 0x30
    /* C236C 800D1B6C 1000B1AF */  sw         $s1, 0x10($sp)
    /* C2370 800D1B70 1400B0AF */  sw         $s0, 0x14($sp)
    /* C2374 800D1B74 1800A0AF */  sw         $zero, 0x18($sp)
    /* C2378 800D1B78 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C237C 800D1B7C 2000B2AF */  sw         $s2, 0x20($sp)
    /* C2380 800D1B80 3E01A524 */  addiu      $a1, $a1, 0x13E
    /* C2384 800D1B84 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* C2388 800D1B88 2138A000 */   addu      $a3, $a1, $zero
    /* C238C 800D1B8C 05010424 */  addiu      $a0, $zero, 0x105
    /* C2390 800D1B90 2014858F */  lw         $a1, %gp_rel(HudMapOffsetY)($gp)
    /* C2394 800D1B94 45020624 */  addiu      $a2, $zero, 0x245
    /* C2398 800D1B98 0C1482AF */  sw         $v0, %gp_rel(Hud_gMapView)($gp)
    /* C239C 800D1B9C 1000B1AF */  sw         $s1, 0x10($sp)
    /* C23A0 800D1BA0 1400B0AF */  sw         $s0, 0x14($sp)
    /* C23A4 800D1BA4 1800A0AF */  sw         $zero, 0x18($sp)
    /* C23A8 800D1BA8 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C23AC 800D1BAC 2000B2AF */  sw         $s2, 0x20($sp)
    /* C23B0 800D1BB0 A901A524 */  addiu      $a1, $a1, 0x1A9
    /* C23B4 800D1BB4 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* C23B8 800D1BB8 2138A000 */   addu      $a3, $a1, $zero
    /* C23BC 800D1BBC 21200000 */  addu       $a0, $zero, $zero
    /* C23C0 800D1BC0 00010524 */  addiu      $a1, $zero, 0x100
    /* C23C4 800D1BC4 40010624 */  addiu      $a2, $zero, 0x140
    /* C23C8 800D1BC8 2138A000 */  addu       $a3, $a1, $zero
    /* C23CC 800D1BCC 2188C000 */  addu       $s1, $a2, $zero
    /* C23D0 800D1BD0 78001024 */  addiu      $s0, $zero, 0x78
    /* C23D4 800D1BD4 101482AF */  sw         $v0, %gp_rel(D_8013D95C)($gp)
    /* C23D8 800D1BD8 1000B1AF */  sw         $s1, 0x10($sp)
    /* C23DC 800D1BDC 1400B0AF */  sw         $s0, 0x14($sp)
    /* C23E0 800D1BE0 1800A0AF */  sw         $zero, 0x18($sp)
    /* C23E4 800D1BE4 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C23E8 800D1BE8 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* C23EC 800D1BEC 2000B2AF */   sw        $s2, 0x20($sp)
    /* C23F0 800D1BF0 21200000 */  addu       $a0, $zero, $zero
    /* C23F4 800D1BF4 78010524 */  addiu      $a1, $zero, 0x178
    /* C23F8 800D1BF8 40010624 */  addiu      $a2, $zero, 0x140
    /* C23FC 800D1BFC 2138A000 */  addu       $a3, $a1, $zero
    /* C2400 800D1C00 041482AF */  sw         $v0, %gp_rel(Hud_gHudView)($gp)
    /* C2404 800D1C04 1000B1AF */  sw         $s1, 0x10($sp)
    /* C2408 800D1C08 1400B0AF */  sw         $s0, 0x14($sp)
    /* C240C 800D1C0C 1800A0AF */  sw         $zero, 0x18($sp)
    /* C2410 800D1C10 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C2414 800D1C14 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* C2418 800D1C18 2000B2AF */   sw        $s2, 0x20($sp)
    /* C241C 800D1C1C 15010424 */  addiu      $a0, $zero, 0x115
    /* C2420 800D1C20 13010524 */  addiu      $a1, $zero, 0x113
    /* C2424 800D1C24 55020624 */  addiu      $a2, $zero, 0x255
    /* C2428 800D1C28 2138A000 */  addu       $a3, $a1, $zero
    /* C242C 800D1C2C 1C001024 */  addiu      $s0, $zero, 0x1C
    /* C2430 800D1C30 081482AF */  sw         $v0, %gp_rel(D_8013D954)($gp)
    /* C2434 800D1C34 1000B0AF */  sw         $s0, 0x10($sp)
    /* C2438 800D1C38 1400B0AF */  sw         $s0, 0x14($sp)
    /* C243C 800D1C3C 1800A0AF */  sw         $zero, 0x18($sp)
    /* C2440 800D1C40 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C2444 800D1C44 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* C2448 800D1C48 2000B2AF */   sw        $s2, 0x20($sp)
    /* C244C 800D1C4C 15010424 */  addiu      $a0, $zero, 0x115
    /* C2450 800D1C50 7C010524 */  addiu      $a1, $zero, 0x17C
    /* C2454 800D1C54 55020624 */  addiu      $a2, $zero, 0x255
    /* C2458 800D1C58 2138A000 */  addu       $a3, $a1, $zero
    /* C245C 800D1C5C 141482AF */  sw         $v0, %gp_rel(Hud_gTacView)($gp)
    /* C2460 800D1C60 1000B0AF */  sw         $s0, 0x10($sp)
    /* C2464 800D1C64 1400B0AF */  sw         $s0, 0x14($sp)
    /* C2468 800D1C68 1800A0AF */  sw         $zero, 0x18($sp)
    /* C246C 800D1C6C 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C2470 800D1C70 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* C2474 800D1C74 2000B2AF */   sw        $s2, 0x20($sp)
    /* C2478 800D1C78 181482AF */  sw         $v0, %gp_rel(D_8013D964)($gp)
    /* C247C 800D1C7C 48470308 */  j          .L800D1D20
    /* C2480 800D1C80 21200000 */   addu      $a0, $zero, $zero
  .L800D1C84:
    /* C2484 800D1C84 3F020624 */  addiu      $a2, $zero, 0x23F
    /* C2488 800D1C88 2014858F */  lw         $a1, %gp_rel(HudMapOffsetY)($gp)
    /* C248C 800D1C8C 2D000224 */  addiu      $v0, $zero, 0x2D
    /* C2490 800D1C90 1000A2AF */  sw         $v0, 0x10($sp)
    /* C2494 800D1C94 30000224 */  addiu      $v0, $zero, 0x30
    /* C2498 800D1C98 1400A2AF */  sw         $v0, 0x14($sp)
    /* C249C 800D1C9C 1800A0AF */  sw         $zero, 0x18($sp)
    /* C24A0 800D1CA0 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C24A4 800D1CA4 2000B2AF */  sw         $s2, 0x20($sp)
    /* C24A8 800D1CA8 A401A524 */  addiu      $a1, $a1, 0x1A4
    /* C24AC 800D1CAC B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* C24B0 800D1CB0 2138A000 */   addu      $a3, $a1, $zero
    /* C24B4 800D1CB4 21200000 */  addu       $a0, $zero, $zero
    /* C24B8 800D1CB8 00010524 */  addiu      $a1, $zero, 0x100
    /* C24BC 800D1CBC 40010624 */  addiu      $a2, $zero, 0x140
    /* C24C0 800D1CC0 2138A000 */  addu       $a3, $a1, $zero
    /* C24C4 800D1CC4 0C1482AF */  sw         $v0, %gp_rel(Hud_gMapView)($gp)
    /* C24C8 800D1CC8 2110C000 */  addu       $v0, $a2, $zero
    /* C24CC 800D1CCC 1000A2AF */  sw         $v0, 0x10($sp)
    /* C24D0 800D1CD0 F0000224 */  addiu      $v0, $zero, 0xF0
    /* C24D4 800D1CD4 1400A2AF */  sw         $v0, 0x14($sp)
    /* C24D8 800D1CD8 1800A0AF */  sw         $zero, 0x18($sp)
    /* C24DC 800D1CDC 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C24E0 800D1CE0 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* C24E4 800D1CE4 2000B2AF */   sw        $s2, 0x20($sp)
    /* C24E8 800D1CE8 B8000424 */  addiu      $a0, $zero, 0xB8
    /* C24EC 800D1CEC 15010524 */  addiu      $a1, $zero, 0x115
    /* C24F0 800D1CF0 F8010624 */  addiu      $a2, $zero, 0x1F8
    /* C24F4 800D1CF4 2138A000 */  addu       $a3, $a1, $zero
    /* C24F8 800D1CF8 041482AF */  sw         $v0, %gp_rel(Hud_gHudView)($gp)
    /* C24FC 800D1CFC 1C000224 */  addiu      $v0, $zero, 0x1C
    /* C2500 800D1D00 1000A2AF */  sw         $v0, 0x10($sp)
    /* C2504 800D1D04 1400A2AF */  sw         $v0, 0x14($sp)
    /* C2508 800D1D08 1800A0AF */  sw         $zero, 0x18($sp)
    /* C250C 800D1D0C 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C2510 800D1D10 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* C2514 800D1D14 2000B2AF */   sw        $s2, 0x20($sp)
    /* C2518 800D1D18 141482AF */  sw         $v0, %gp_rel(Hud_gTacView)($gp)
    /* C251C 800D1D1C 21200000 */  addu       $a0, $zero, $zero
  .L800D1D20:
    /* C2520 800D1D20 00010524 */  addiu      $a1, $zero, 0x100
    /* C2524 800D1D24 40010624 */  addiu      $a2, $zero, 0x140
    /* C2528 800D1D28 2138A000 */  addu       $a3, $a1, $zero
    /* C252C 800D1D2C 2110C000 */  addu       $v0, $a2, $zero
    /* C2530 800D1D30 1000A2AF */  sw         $v0, 0x10($sp)
    /* C2534 800D1D34 F0000224 */  addiu      $v0, $zero, 0xF0
    /* C2538 800D1D38 1400A2AF */  sw         $v0, 0x14($sp)
    /* C253C 800D1D3C 01000224 */  addiu      $v0, $zero, 0x1
    /* C2540 800D1D40 1800A0AF */  sw         $zero, 0x18($sp)
    /* C2544 800D1D44 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C2548 800D1D48 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* C254C 800D1D4C 2000A2AF */   sw        $v0, 0x20($sp)
    /* C2550 800D1D50 3400BF8F */  lw         $ra, 0x34($sp)
    /* C2554 800D1D54 3000B28F */  lw         $s2, 0x30($sp)
    /* C2558 800D1D58 2C00B18F */  lw         $s1, 0x2C($sp)
    /* C255C 800D1D5C 2800B08F */  lw         $s0, 0x28($sp)
    /* C2560 800D1D60 1C1482AF */  sw         $v0, %gp_rel(Hud_gStatsView)($gp)
    /* C2564 800D1D64 0800E003 */  jr         $ra
    /* C2568 800D1D68 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Hud_CreateHudViews__Fv
