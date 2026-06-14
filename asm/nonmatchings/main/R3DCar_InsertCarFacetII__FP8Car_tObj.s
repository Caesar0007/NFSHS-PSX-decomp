.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_InsertCarFacetII__FP8Car_tObj, 0x5EC

glabel R3DCar_InsertCarFacetII__FP8Car_tObj
    /* A2974 800B2174 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* A2978 800B2178 4400B3AF */  sw         $s3, 0x44($sp)
    /* A297C 800B217C 21988000 */  addu       $s3, $a0, $zero
    /* A2980 800B2180 1180043C */  lui        $a0, %hi(R3DCar_LoadedScenePointer)
    /* A2984 800B2184 5C00BFAF */  sw         $ra, 0x5C($sp)
    /* A2988 800B2188 5800BEAF */  sw         $fp, 0x58($sp)
    /* A298C 800B218C 5400B7AF */  sw         $s7, 0x54($sp)
    /* A2990 800B2190 5000B6AF */  sw         $s6, 0x50($sp)
    /* A2994 800B2194 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* A2998 800B2198 4800B4AF */  sw         $s4, 0x48($sp)
    /* A299C 800B219C 4000B2AF */  sw         $s2, 0x40($sp)
    /* A29A0 800B21A0 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* A29A4 800B21A4 3800B0AF */  sw         $s0, 0x38($sp)
    /* A29A8 800B21A8 42086292 */  lbu        $v0, 0x842($s3)
    /* A29AC 800B21AC 08698424 */  addiu      $a0, $a0, %lo(R3DCar_LoadedScenePointer)
    /* A29B0 800B21B0 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* A29B4 800B21B4 BC087186 */  lh         $s1, 0x8BC($s3)
    /* A29B8 800B21B8 700E8A8F */  lw         $t2, %gp_rel(R3DCar_rightHandDrive)($gp)
    /* A29BC 800B21BC C2B90200 */  srl        $s7, $v0, 7
    /* A29C0 800B21C0 80181100 */  sll        $v1, $s1, 2
    /* A29C4 800B21C4 40101700 */  sll        $v0, $s7, 1
    /* A29C8 800B21C8 21105700 */  addu       $v0, $v0, $s7
    /* A29CC 800B21CC C0100200 */  sll        $v0, $v0, 3
    /* A29D0 800B21D0 21105700 */  addu       $v0, $v0, $s7
    /* A29D4 800B21D4 C0100200 */  sll        $v0, $v0, 3
    /* A29D8 800B21D8 21186200 */  addu       $v1, $v1, $v0
    /* A29DC 800B21DC 21186400 */  addu       $v1, $v1, $a0
    /* A29E0 800B21E0 0000648C */  lw         $a0, 0x0($v1)
    /* A29E4 800B21E4 AC02628E */  lw         $v0, 0x2AC($s3)
    /* A29E8 800B21E8 DC02638E */  lw         $v1, 0x2DC($s3)
    /* A29EC 800B21EC E4008424 */  addiu      $a0, $a0, 0xE4
    /* A29F0 800B21F0 25104300 */  or         $v0, $v0, $v1
    /* A29F4 800B21F4 2800A4AF */  sw         $a0, 0x28($sp)
    /* A29F8 800B21F8 0C03638E */  lw         $v1, 0x30C($s3)
    /* A29FC 800B21FC 3C03648E */  lw         $a0, 0x33C($s3)
    /* A2A00 800B2200 25104300 */  or         $v0, $v0, $v1
    /* A2A04 800B2204 25104400 */  or         $v0, $v0, $a0
    /* A2A08 800B2208 1E004014 */  bnez       $v0, .L800B2284
    /* A2A0C 800B220C 2400AAAF */   sw        $t2, 0x24($sp)
    /* A2A10 800B2210 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A2A14 800B2214 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* A2A18 800B2218 5400628C */  lw         $v0, 0x54($v1)
    /* A2A1C 800B221C 00000000 */  nop
    /* A2A20 800B2220 07004014 */  bnez       $v0, .L800B2240
    /* A2A24 800B2224 01000224 */   addiu     $v0, $zero, 0x1
    /* A2A28 800B2228 1480023C */  lui        $v0, %hi(DrawC_gWetRoad)
    /* A2A2C 800B222C 10D8428C */  lw         $v0, %lo(DrawC_gWetRoad)($v0)
    /* A2A30 800B2230 00000000 */  nop
    /* A2A34 800B2234 2B100200 */  sltu       $v0, $zero, $v0
    /* A2A38 800B2238 A1C80208 */  j          .L800B2284
    /* A2A3C 800B223C 2C00A2AF */   sw        $v0, 0x2C($sp)
  .L800B2240:
    /* A2A40 800B2240 0C00638C */  lw         $v1, 0xC($v1)
    /* A2A44 800B2244 00000000 */  nop
    /* A2A48 800B2248 08006214 */  bne        $v1, $v0, .L800B226C
    /* A2A4C 800B224C FFFF0A24 */   addiu     $t2, $zero, -0x1
    /* A2A50 800B2250 1480023C */  lui        $v0, %hi(DrawC_gWetRoad)
    /* A2A54 800B2254 10D8428C */  lw         $v0, %lo(DrawC_gWetRoad)($v0)
    /* A2A58 800B2258 00000000 */  nop
    /* A2A5C 800B225C 09004010 */  beqz       $v0, .L800B2284
    /* A2A60 800B2260 2C00AAAF */   sw        $t2, 0x2C($sp)
    /* A2A64 800B2264 A0C80208 */  j          .L800B2280
    /* A2A68 800B2268 01000A24 */   addiu     $t2, $zero, 0x1
  .L800B226C:
    /* A2A6C 800B226C 1480023C */  lui        $v0, %hi(DrawC_gWetRoad)
    /* A2A70 800B2270 10D8428C */  lw         $v0, %lo(DrawC_gWetRoad)($v0)
    /* A2A74 800B2274 00000000 */  nop
    /* A2A78 800B2278 02004010 */  beqz       $v0, .L800B2284
    /* A2A7C 800B227C FEFF0A24 */   addiu     $t2, $zero, -0x2
  .L800B2280:
    /* A2A80 800B2280 2C00AAAF */  sw         $t2, 0x2C($sp)
  .L800B2284:
    /* A2A84 800B2284 91FF010C */  jal        BWorldSm_QuadLight__FP12BWorldSm_Pos
    /* A2A88 800B2288 08006426 */   addiu     $a0, $s3, 0x8
    /* A2A8C 800B228C FF00033C */  lui        $v1, (0xFFFFFF >> 16)
    /* A2A90 800B2290 FFFF6334 */  ori        $v1, $v1, (0xFFFFFF & 0xFFFF)
    /* A2A94 800B2294 C2086486 */  lh         $a0, 0x8C2($s3)
    /* A2A98 800B2298 24104300 */  and        $v0, $v0, $v1
    /* A2A9C 800B229C 24018004 */  bltz       $a0, .L800B2730
    /* A2AA0 800B22A0 800862AE */   sw        $v0, 0x880($s3)
    /* A2AA4 800B22A4 1480023C */  lui        $v0, %hi(gNight_renderNight)
    /* A2AA8 800B22A8 28DA428C */  lw         $v0, %lo(gNight_renderNight)($v0)
    /* A2AAC 800B22AC 00000000 */  nop
    /* A2AB0 800B22B0 03004010 */  beqz       $v0, .L800B22C0
    /* A2AB4 800B22B4 801F123C */   lui       $s2, (0x1F80000C >> 16)
    /* A2AB8 800B22B8 5EFA020C */  jal        DrawC_NightHeadlight__FP8Car_tObj
    /* A2ABC 800B22BC 21206002 */   addu      $a0, $s3, $zero
  .L800B22C0:
    /* A2AC0 800B22C0 5555043C */  lui        $a0, (0x55555556 >> 16)
    /* A2AC4 800B22C4 8008628E */  lw         $v0, 0x880($s3)
    /* A2AC8 800B22C8 56558434 */  ori        $a0, $a0, (0x55555556 & 0xFFFF)
    /* A2ACC 800B22CC FF004630 */  andi       $a2, $v0, 0xFF
    /* A2AD0 800B22D0 00FF4330 */  andi       $v1, $v0, 0xFF00
    /* A2AD4 800B22D4 032A0300 */  sra        $a1, $v1, 8
    /* A2AD8 800B22D8 02140200 */  srl        $v0, $v0, 16
    /* A2ADC 800B22DC FF004330 */  andi       $v1, $v0, 0xFF
    /* A2AE0 800B22E0 2110C500 */  addu       $v0, $a2, $a1
    /* A2AE4 800B22E4 21104300 */  addu       $v0, $v0, $v1
    /* A2AE8 800B22E8 18004400 */  mult       $v0, $a0
    /* A2AEC 800B22EC C3170200 */  sra        $v0, $v0, 31
    /* A2AF0 800B22F0 10500000 */  mfhi       $t2
    /* A2AF4 800B22F4 23B04201 */  subu       $s6, $t2, $v0
    /* A2AF8 800B22F8 1800C22A */  slti       $v0, $s6, 0x18
    /* A2AFC 800B22FC 03004010 */  beqz       $v0, .L800B230C
    /* A2B00 800B2300 00141600 */   sll       $v0, $s6, 16
    /* A2B04 800B2304 18001624 */  addiu      $s6, $zero, 0x18
    /* A2B08 800B2308 00141600 */  sll        $v0, $s6, 16
  .L800B230C:
    /* A2B0C 800B230C 001A1600 */  sll        $v1, $s6, 8
    /* A2B10 800B2310 21104300 */  addu       $v0, $v0, $v1
    /* A2B14 800B2314 21105600 */  addu       $v0, $v0, $s6
    /* A2B18 800B2318 1480043C */  lui        $a0, %hi(R3DCar_center)
    /* A2B1C 800B231C 90D38424 */  addiu      $a0, $a0, %lo(R3DCar_center)
    /* A2B20 800B2320 21286002 */  addu       $a1, $s3, $zero
    /* A2B24 800B2324 2130C002 */  addu       $a2, $s6, $zero
    /* A2B28 800B2328 801F073C */  lui        $a3, (0x1F800000 >> 16)
    /* A2B2C 800B232C 51FB020C */  jal        DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache
    /* A2B30 800B2330 8C0042AE */   sw        $v0, (0x1F80008C & 0xFFFF)($s2)
    /* A2B34 800B2334 FE004004 */  bltz       $v0, .L800B2730
    /* A2B38 800B2338 2000A2AF */   sw        $v0, 0x20($sp)
    /* A2B3C 800B233C 21800000 */  addu       $s0, $zero, $zero
    /* A2B40 800B2340 80501100 */  sll        $t2, $s1, 2
    /* A2B44 800B2344 21A80002 */  addu       $s5, $s0, $zero
    /* A2B48 800B2348 21A00002 */  addu       $s4, $s0, $zero
    /* A2B4C 800B234C 3000AAAF */  sw         $t2, 0x30($sp)
    /* A2B50 800B2350 3400A0AF */  sw         $zero, 0x34($sp)
  .L800B2354:
    /* A2B54 800B2354 3900022A */  slti       $v0, $s0, 0x39
    /* A2B58 800B2358 CD004010 */  beqz       $v0, .L800B2690
    /* A2B5C 800B235C 40101700 */   sll       $v0, $s7, 1
    /* A2B60 800B2360 21105700 */  addu       $v0, $v0, $s7
    /* A2B64 800B2364 C0100200 */  sll        $v0, $v0, 3
    /* A2B68 800B2368 21105700 */  addu       $v0, $v0, $s7
    /* A2B6C 800B236C 3000AA8F */  lw         $t2, 0x30($sp)
    /* A2B70 800B2370 C0100200 */  sll        $v0, $v0, 3
    /* A2B74 800B2374 21104201 */  addu       $v0, $t2, $v0
    /* A2B78 800B2378 11800A3C */  lui        $t2, %hi(R3DCar_LoadedScenePointer)
    /* A2B7C 800B237C 08694A25 */  addiu      $t2, $t2, %lo(R3DCar_LoadedScenePointer)
    /* A2B80 800B2380 21104A00 */  addu       $v0, $v0, $t2
    /* A2B84 800B2384 0000438C */  lw         $v1, 0x0($v0)
    /* A2B88 800B2388 80101000 */  sll        $v0, $s0, 2
    /* A2B8C 800B238C 21186200 */  addu       $v1, $v1, $v0
    /* A2B90 800B2390 1180023C */  lui        $v0, %hi(R3DCar_ObjectVisible)
    /* A2B94 800B2394 AC684224 */  addiu      $v0, $v0, %lo(R3DCar_ObjectVisible)
    /* A2B98 800B2398 0000668C */  lw         $a2, 0x0($v1)
    /* A2B9C 800B239C 21100202 */  addu       $v0, $s0, $v0
    /* A2BA0 800B23A0 0200C394 */  lhu        $v1, 0x2($a2)
    /* A2BA4 800B23A4 00004990 */  lbu        $t1, 0x0($v0)
    /* A2BA8 800B23A8 B2006010 */  beqz       $v1, .L800B2674
    /* A2BAC 800B23AC 00000000 */   nop
    /* A2BB0 800B23B0 B0002011 */  beqz       $t1, .L800B2674
    /* A2BB4 800B23B4 1180023C */   lui       $v0, %hi(R3DCar_ObjectInfo)
    /* A2BB8 800B23B8 3400AA8F */  lw         $t2, 0x34($sp)
    /* A2BBC 800B23BC E0654224 */  addiu      $v0, $v0, %lo(R3DCar_ObjectInfo)
    /* A2BC0 800B23C0 40180A00 */  sll        $v1, $t2, 1
    /* A2BC4 800B23C4 21186200 */  addu       $v1, $v1, $v0
    /* A2BC8 800B23C8 1C00222A */  slti       $v0, $s1, 0x1C
    /* A2BCC 800B23CC 01006480 */  lb         $a0, 0x1($v1)
    /* A2BD0 800B23D0 00006880 */  lb         $t0, 0x0($v1)
    /* A2BD4 800B23D4 0C004010 */  beqz       $v0, .L800B2408
    /* A2BD8 800B23D8 21F00000 */   addu      $fp, $zero, $zero
    /* A2BDC 800B23DC E4FF0226 */  addiu      $v0, $s0, -0x1C
    /* A2BE0 800B23E0 0200422C */  sltiu      $v0, $v0, 0x2
    /* A2BE4 800B23E4 08004010 */  beqz       $v0, .L800B2408
    /* A2BE8 800B23E8 1180023C */   lui       $v0, %hi(R3DCar_RecessedLight)
    /* A2BEC 800B23EC 28684224 */  addiu      $v0, $v0, %lo(R3DCar_RecessedLight)
    /* A2BF0 800B23F0 21102202 */  addu       $v0, $s1, $v0
    /* A2BF4 800B23F4 00004290 */  lbu        $v0, 0x0($v0)
    /* A2BF8 800B23F8 00000000 */  nop
    /* A2BFC 800B23FC 02004010 */  beqz       $v0, .L800B2408
    /* A2C00 800B2400 00000000 */   nop
    /* A2C04 800B2404 23400800 */  negu       $t0, $t0
  .L800B2408:
    /* A2C08 800B2408 2400AA8F */  lw         $t2, 0x24($sp)
    /* A2C0C 800B240C 00000000 */  nop
    /* A2C10 800B2410 09004011 */  beqz       $t2, .L800B2438
    /* A2C14 800B2414 2300022A */   slti      $v0, $s0, 0x23
    /* A2C18 800B2418 07004014 */  bnez       $v0, .L800B2438
    /* A2C1C 800B241C 2900022A */   slti      $v0, $s0, 0x29
    /* A2C20 800B2420 05004010 */  beqz       $v0, .L800B2438
    /* A2C24 800B2424 00000000 */   nop
    /* A2C28 800B2428 0C00428E */  lw         $v0, (0x1F80000C & 0xFFFF)($s2)
    /* A2C2C 800B242C 01001E24 */  addiu      $fp, $zero, 0x1
    /* A2C30 800B2430 26105E00 */  xor        $v0, $v0, $fp
    /* A2C34 800B2434 0C0042AE */  sw         $v0, (0x1F80000C & 0xFFFF)($s2)
  .L800B2438:
    /* A2C38 800B2438 EFFF2925 */  addiu      $t1, $t1, -0x11
    /* A2C3C 800B243C 4C002005 */  bltz       $t1, .L800B2570
    /* A2C40 800B2440 21382001 */   addu      $a3, $t1, $zero
    /* A2C44 800B2444 1C00222A */  slti       $v0, $s1, 0x1C
    /* A2C48 800B2448 3B004010 */  beqz       $v0, .L800B2538
    /* A2C4C 800B244C FFFF0324 */   addiu     $v1, $zero, -0x1
    /* A2C50 800B2450 1600222A */  slti       $v0, $s1, 0x16
    /* A2C54 800B2454 19004014 */  bnez       $v0, .L800B24BC
    /* A2C58 800B2458 04000224 */   addiu     $v0, $zero, 0x4
    /* A2C5C 800B245C EAFF2426 */  addiu      $a0, $s1, -0x16
    /* A2C60 800B2460 80100400 */  sll        $v0, $a0, 2
    /* A2C64 800B2464 21104400 */  addu       $v0, $v0, $a0
    /* A2C68 800B2468 11800A3C */  lui        $t2, %hi(R3DCar_CopIndex)
    /* A2C6C 800B246C 7C684A25 */  addiu      $t2, $t2, %lo(R3DCar_CopIndex)
    /* A2C70 800B2470 1180053C */  lui        $a1, %hi(R3DCar_FlareCopSirenType)
    /* A2C74 800B2474 42086392 */  lbu        $v1, 0x842($s3)
    /* A2C78 800B2478 5867A524 */  addiu      $a1, $a1, %lo(R3DCar_FlareCopSirenType)
    /* A2C7C 800B247C 7F006330 */  andi       $v1, $v1, 0x7F
    /* A2C80 800B2480 21186200 */  addu       $v1, $v1, $v0
    /* A2C84 800B2484 21186A00 */  addu       $v1, $v1, $t2
    /* A2C88 800B2488 00006490 */  lbu        $a0, 0x0($v1)
    /* A2C8C 800B248C 40180700 */  sll        $v1, $a3, 1
    /* A2C90 800B2490 40100400 */  sll        $v0, $a0, 1
    /* A2C94 800B2494 21104400 */  addu       $v0, $v0, $a0
    /* A2C98 800B2498 80100200 */  sll        $v0, $v0, 2
    /* A2C9C 800B249C 21186200 */  addu       $v1, $v1, $v0
    /* A2CA0 800B24A0 21186500 */  addu       $v1, $v1, $a1
    /* A2CA4 800B24A4 00006284 */  lh         $v0, 0x0($v1)
    /* A2CA8 800B24A8 00000000 */  nop
    /* A2CAC 800B24AC 0C004010 */  beqz       $v0, .L800B24E0
    /* A2CB0 800B24B0 00000000 */   nop
    /* A2CB4 800B24B4 38C90208 */  j          .L800B24E0
    /* A2CB8 800B24B8 21384000 */   addu      $a3, $v0, $zero
  .L800B24BC:
    /* A2CBC 800B24BC 0800E214 */  bne        $a3, $v0, .L800B24E0
    /* A2CC0 800B24C0 1180023C */   lui       $v0, %hi(R3DCar_SignalBrakeFlare)
    /* A2CC4 800B24C4 0C684224 */  addiu      $v0, $v0, %lo(R3DCar_SignalBrakeFlare)
    /* A2CC8 800B24C8 21102202 */  addu       $v0, $s1, $v0
    /* A2CCC 800B24CC 00004290 */  lbu        $v0, 0x0($v0)
    /* A2CD0 800B24D0 00000000 */  nop
    /* A2CD4 800B24D4 02004010 */  beqz       $v0, .L800B24E0
    /* A2CD8 800B24D8 00000000 */   nop
    /* A2CDC 800B24DC 41000724 */  addiu      $a3, $zero, 0x41
  .L800B24E0:
    /* A2CE0 800B24E0 B6086296 */  lhu        $v0, 0x8B6($s3)
    /* A2CE4 800B24E4 00000000 */  nop
    /* A2CE8 800B24E8 02004230 */  andi       $v0, $v0, 0x2
    /* A2CEC 800B24EC 09004014 */  bnez       $v0, .L800B2514
    /* A2CF0 800B24F0 BF00E330 */   andi      $v1, $a3, 0xBF
    /* A2CF4 800B24F4 1600222A */  slti       $v0, $s1, 0x16
    /* A2CF8 800B24F8 0B004014 */  bnez       $v0, .L800B2528
    /* A2CFC 800B24FC 1180033C */   lui       $v1, %hi(R3DCar_FlareOverlayIndex)
    /* A2D00 800B2500 7005628E */  lw         $v0, 0x570($s3)
    /* A2D04 800B2504 00000000 */  nop
    /* A2D08 800B2508 02004230 */  andi       $v0, $v0, 0x2
    /* A2D0C 800B250C 05004010 */  beqz       $v0, .L800B2524
    /* A2D10 800B2510 BF00E330 */   andi      $v1, $a3, 0xBF
  .L800B2514:
    /* A2D14 800B2514 01000224 */  addiu      $v0, $zero, 0x1
    /* A2D18 800B2518 03006214 */  bne        $v1, $v0, .L800B2528
    /* A2D1C 800B251C 1180033C */   lui       $v1, %hi(R3DCar_FlareOverlayIndex)
    /* A2D20 800B2520 0006E734 */  ori        $a3, $a3, 0x600
  .L800B2524:
    /* A2D24 800B2524 1180033C */  lui        $v1, %hi(R3DCar_FlareOverlayIndex)
  .L800B2528:
    /* A2D28 800B2528 4C676324 */  addiu      $v1, $v1, %lo(R3DCar_FlareOverlayIndex)
    /* A2D2C 800B252C 40100900 */  sll        $v0, $t1, 1
    /* A2D30 800B2530 21104300 */  addu       $v0, $v0, $v1
    /* A2D34 800B2534 00004384 */  lh         $v1, 0x0($v0)
  .L800B2538:
    /* A2D38 800B2538 6808628E */  lw         $v0, 0x868($s3)
    /* A2D3C 800B253C 2C00AA8F */  lw         $t2, 0x2C($sp)
    /* A2D40 800B2540 3C0E848F */  lw         $a0, %gp_rel(R3DCar_orientMat)($gp)
    /* A2D44 800B2544 400E858F */  lw         $a1, %gp_rel(R3DCar_position)($gp)
    /* A2D48 800B2548 1000A3AF */  sw         $v1, 0x10($sp)
    /* A2D4C 800B254C 1800B2AF */  sw         $s2, 0x18($sp)
    /* A2D50 800B2550 21209400 */  addu       $a0, $a0, $s4
    /* A2D54 800B2554 2128B500 */  addu       $a1, $a1, $s5
    /* A2D58 800B2558 21104800 */  addu       $v0, $v0, $t0
    /* A2D5C 800B255C 1400AAAF */  sw         $t2, 0x14($sp)
    /* A2D60 800B2560 8C0E030C */  jal        DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache
    /* A2D64 800B2564 400042AE */   sw        $v0, (0x1F800040 & 0xFFFF)($s2)
    /* A2D68 800B2568 97C90208 */  j          .L800B265C
    /* A2D6C 800B256C 00000000 */   nop
  .L800B2570:
    /* A2D70 800B2570 1C00222A */  slti       $v0, $s1, 0x1C
    /* A2D74 800B2574 0A004014 */  bnez       $v0, .L800B25A0
    /* A2D78 800B2578 20000524 */   addiu     $a1, $zero, 0x20
    /* A2D7C 800B257C 40000524 */  addiu      $a1, $zero, 0x40
    /* A2D80 800B2580 1C000224 */  addiu      $v0, $zero, 0x1C
    /* A2D84 800B2584 11002216 */  bne        $s1, $v0, .L800B25CC
    /* A2D88 800B2588 22000424 */   addiu     $a0, $zero, 0x22
    /* A2D8C 800B258C 23000224 */  addiu      $v0, $zero, 0x23
    /* A2D90 800B2590 0E000216 */  bne        $s0, $v0, .L800B25CC
    /* A2D94 800B2594 00000000 */   nop
    /* A2D98 800B2598 73C90208 */  j          .L800B25CC
    /* A2D9C 800B259C 04000824 */   addiu     $t0, $zero, 0x4
  .L800B25A0:
    /* A2DA0 800B25A0 540E8293 */  lbu        $v0, %gp_rel(R3DCar_eMapColour)($gp)
    /* A2DA4 800B25A4 00000000 */  nop
    /* A2DA8 800B25A8 03004014 */  bnez       $v0, .L800B25B8
    /* A2DAC 800B25AC 10008230 */   andi      $v0, $a0, 0x10
    /* A2DB0 800B25B0 FE008430 */  andi       $a0, $a0, 0xFE
    /* A2DB4 800B25B4 10008230 */  andi       $v0, $a0, 0x10
  .L800B25B8:
    /* A2DB8 800B25B8 04004010 */  beqz       $v0, .L800B25CC
    /* A2DBC 800B25BC 1600222A */   slti      $v0, $s1, 0x16
    /* A2DC0 800B25C0 02004014 */  bnez       $v0, .L800B25CC
    /* A2DC4 800B25C4 00000000 */   nop
    /* A2DC8 800B25C8 0C000825 */  addiu      $t0, $t0, 0xC
  .L800B25CC:
    /* A2DCC 800B25CC C2086386 */  lh         $v1, 0x8C2($s3)
    /* A2DD0 800B25D0 03000224 */  addiu      $v0, $zero, 0x3
    /* A2DD4 800B25D4 06006214 */  bne        $v1, $v0, .L800B25F0
    /* A2DD8 800B25D8 D9FF0226 */   addiu     $v0, $s0, -0x27
    /* A2DDC 800B25DC 20008434 */  ori        $a0, $a0, 0x20
    /* A2DE0 800B25E0 0200422C */  sltiu      $v0, $v0, 0x2
    /* A2DE4 800B25E4 02004010 */  beqz       $v0, .L800B25F0
    /* A2DE8 800B25E8 23400800 */   negu      $t0, $t0
    /* A2DEC 800B25EC F0FF0825 */  addiu      $t0, $t0, -0x10
  .L800B25F0:
    /* A2DF0 800B25F0 6808628E */  lw         $v0, 0x868($s3)
    /* A2DF4 800B25F4 00000000 */  nop
    /* A2DF8 800B25F8 21104800 */  addu       $v0, $v0, $t0
    /* A2DFC 800B25FC 400042AE */  sw         $v0, (0x1F800040 & 0xFFFF)($s2)
    /* A2E00 800B2600 2000AA8F */  lw         $t2, 0x20($sp)
    /* A2E04 800B2604 00000000 */  nop
    /* A2E08 800B2608 2A104501 */  slt        $v0, $t2, $a1
    /* A2E0C 800B260C 0B004010 */  beqz       $v0, .L800B263C
    /* A2E10 800B2610 00000000 */   nop
    /* A2E14 800B2614 2800A78F */  lw         $a3, 0x28($sp)
    /* A2E18 800B2618 1000A4AF */  sw         $a0, 0x10($sp)
    /* A2E1C 800B261C 3C0E848F */  lw         $a0, %gp_rel(R3DCar_orientMat)($gp)
    /* A2E20 800B2620 400E858F */  lw         $a1, %gp_rel(R3DCar_position)($gp)
    /* A2E24 800B2624 1400B2AF */  sw         $s2, 0x14($sp)
    /* A2E28 800B2628 21209400 */  addu       $a0, $a0, $s4
    /* A2E2C 800B262C 5705030C */  jal        DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
    /* A2E30 800B2630 2128B500 */   addu      $a1, $a1, $s5
    /* A2E34 800B2634 97C90208 */  j          .L800B265C
    /* A2E38 800B2638 00000000 */   nop
  .L800B263C:
    /* A2E3C 800B263C 2800A78F */  lw         $a3, 0x28($sp)
    /* A2E40 800B2640 1000A4AF */  sw         $a0, 0x10($sp)
    /* A2E44 800B2644 3C0E848F */  lw         $a0, %gp_rel(R3DCar_orientMat)($gp)
    /* A2E48 800B2648 400E858F */  lw         $a1, %gp_rel(R3DCar_position)($gp)
    /* A2E4C 800B264C 1400B2AF */  sw         $s2, 0x14($sp)
    /* A2E50 800B2650 21209400 */  addu       $a0, $a0, $s4
    /* A2E54 800B2654 51FF020C */  jal        DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
    /* A2E58 800B2658 2128B500 */   addu      $a1, $a1, $s5
  .L800B265C:
    /* A2E5C 800B265C 0500C013 */  beqz       $fp, .L800B2674
    /* A2E60 800B2660 00000000 */   nop
    /* A2E64 800B2664 0C00428E */  lw         $v0, (0x1F80000C & 0xFFFF)($s2)
    /* A2E68 800B2668 00000000 */  nop
    /* A2E6C 800B266C 01004238 */  xori       $v0, $v0, 0x1
    /* A2E70 800B2670 0C0042AE */  sw         $v0, (0x1F80000C & 0xFFFF)($s2)
  .L800B2674:
    /* A2E74 800B2674 0C00B526 */  addiu      $s5, $s5, 0xC
    /* A2E78 800B2678 24009426 */  addiu      $s4, $s4, 0x24
    /* A2E7C 800B267C 3400AA8F */  lw         $t2, 0x34($sp)
    /* A2E80 800B2680 01001026 */  addiu      $s0, $s0, 0x1
    /* A2E84 800B2684 03004A25 */  addiu      $t2, $t2, 0x3
    /* A2E88 800B2688 D5C80208 */  j          .L800B2354
    /* A2E8C 800B268C 3400AAAF */   sw        $t2, 0x34($sp)
  .L800B2690:
    /* A2E90 800B2690 21206002 */  addu       $a0, $s3, $zero
    /* A2E94 800B2694 21FF020C */  jal        DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache
    /* A2E98 800B2698 21284002 */   addu      $a1, $s2, $zero
    /* A2E9C 800B269C 4C0E828F */  lw         $v0, %gp_rel(R3DCar_shadowFlag)($gp)
    /* A2EA0 800B26A0 00000000 */  nop
    /* A2EA4 800B26A4 22004010 */  beqz       $v0, .L800B2730
    /* A2EA8 800B26A8 00000000 */   nop
    /* A2EAC 800B26AC 500E8293 */  lbu        $v0, %gp_rel(R3DCar_shadowColour)($gp)
    /* A2EB0 800B26B0 00000000 */  nop
    /* A2EB4 800B26B4 1800C202 */  mult       $s6, $v0
    /* A2EB8 800B26B8 12200000 */  mflo       $a0
    /* A2EBC 800B26BC 510E8293 */  lbu        $v0, %gp_rel(D_8013D39D)($gp)
    /* A2EC0 800B26C0 00000000 */  nop
    /* A2EC4 800B26C4 1800C202 */  mult       $s6, $v0
    /* A2EC8 800B26C8 12180000 */  mflo       $v1
    /* A2ECC 800B26CC 520E8293 */  lbu        $v0, %gp_rel(D_8013D39E)($gp)
    /* A2ED0 800B26D0 00000000 */  nop
    /* A2ED4 800B26D4 1800C202 */  mult       $s6, $v0
    /* A2ED8 800B26D8 03320400 */  sra        $a2, $a0, 8
    /* A2EDC 800B26DC 032A0300 */  sra        $a1, $v1, 8
    /* A2EE0 800B26E0 12400000 */  mflo       $t0
    /* A2EE4 800B26E4 031A0800 */  sra        $v1, $t0, 8
    /* A2EE8 800B26E8 00140300 */  sll        $v0, $v1, 16
    /* A2EEC 800B26EC 001A0500 */  sll        $v1, $a1, 8
    /* A2EF0 800B26F0 21104300 */  addu       $v0, $v0, $v1
    /* A2EF4 800B26F4 21104600 */  addu       $v0, $v0, $a2
    /* A2EF8 800B26F8 8C0042AE */  sw         $v0, (0x1F80008C & 0xFFFF)($s2)
    /* A2EFC 800B26FC 2000AA8F */  lw         $t2, 0x20($sp)
    /* A2F00 800B2700 00000000 */  nop
    /* A2F04 800B2704 20004229 */  slti       $v0, $t2, 0x20
    /* A2F08 800B2708 06004010 */  beqz       $v0, .L800B2724
    /* A2F0C 800B270C 1180043C */   lui       $a0, %hi(R3DCar_shadowVertex)
    /* A2F10 800B2710 E8688424 */  addiu      $a0, $a0, %lo(R3DCar_shadowVertex)
    /* A2F14 800B2714 B110030C */  jal        DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache
    /* A2F18 800B2718 21284002 */   addu      $a1, $s2, $zero
    /* A2F1C 800B271C CCC90208 */  j          .L800B2730
    /* A2F20 800B2720 00000000 */   nop
  .L800B2724:
    /* A2F24 800B2724 E8688424 */  addiu      $a0, $a0, %lo(R3DCar_shadowVertex)
    /* A2F28 800B2728 B60F030C */  jal        DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache
    /* A2F2C 800B272C 21284002 */   addu      $a1, $s2, $zero
  .L800B2730:
    /* A2F30 800B2730 5C00BF8F */  lw         $ra, 0x5C($sp)
    /* A2F34 800B2734 5800BE8F */  lw         $fp, 0x58($sp)
    /* A2F38 800B2738 5400B78F */  lw         $s7, 0x54($sp)
    /* A2F3C 800B273C 5000B68F */  lw         $s6, 0x50($sp)
    /* A2F40 800B2740 4C00B58F */  lw         $s5, 0x4C($sp)
    /* A2F44 800B2744 4800B48F */  lw         $s4, 0x48($sp)
    /* A2F48 800B2748 4400B38F */  lw         $s3, 0x44($sp)
    /* A2F4C 800B274C 4000B28F */  lw         $s2, 0x40($sp)
    /* A2F50 800B2750 3C00B18F */  lw         $s1, 0x3C($sp)
    /* A2F54 800B2754 3800B08F */  lw         $s0, 0x38($sp)
    /* A2F58 800B2758 0800E003 */  jr         $ra
    /* A2F5C 800B275C 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel R3DCar_InsertCarFacetII__FP8Car_tObj
