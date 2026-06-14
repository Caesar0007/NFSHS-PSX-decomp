.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj, 0x320

glabel Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj
    /* 91A48 800A1248 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 91A4C 800A124C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 91A50 800A1250 21808000 */  addu       $s0, $a0, $zero
    /* 91A54 800A1254 21300000 */  addu       $a2, $zero, $zero
    /* 91A58 800A1258 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 91A5C 800A125C 1180023C */  lui        $v0, %hi(D_80113208)
    /* 91A60 800A1260 0832428C */  lw         $v0, %lo(D_80113208)($v0)
    /* 91A64 800A1264 48FA6324 */  addiu      $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* 91A68 800A1268 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 91A6C 800A126C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 91A70 800A1270 1400B1AF */  sw         $s1, 0x14($sp)
    /* 91A74 800A1274 80100200 */  sll        $v0, $v0, 2
    /* 91A78 800A1278 21104300 */  addu       $v0, $v0, $v1
    /* 91A7C 800A127C 0000428C */  lw         $v0, 0x0($v0)
    /* 91A80 800A1280 A000058E */  lw         $a1, 0xA0($s0)
    /* 91A84 800A1284 A000438C */  lw         $v1, 0xA0($v0)
    /* 91A88 800A1288 00000000 */  nop
    /* 91A8C 800A128C 2320A300 */  subu       $a0, $a1, $v1
    /* 91A90 800A1290 0200801C */  bgtz       $a0, .L800A129C
    /* 91A94 800A1294 2190C000 */   addu      $s2, $a2, $zero
    /* 91A98 800A1298 23206500 */  subu       $a0, $v1, $a1
  .L800A129C:
    /* 91A9C 800A129C A800058E */  lw         $a1, 0xA8($s0)
    /* 91AA0 800A12A0 A800428C */  lw         $v0, 0xA8($v0)
    /* 91AA4 800A12A4 00000000 */  nop
    /* 91AA8 800A12A8 2318A200 */  subu       $v1, $a1, $v0
    /* 91AAC 800A12AC 0200601C */  bgtz       $v1, .L800A12B8
    /* 91AB0 800A12B0 00000000 */   nop
    /* 91AB4 800A12B4 23184500 */  subu       $v1, $v0, $a1
  .L800A12B8:
    /* 91AB8 800A12B8 2A106400 */  slt        $v0, $v1, $a0
    /* 91ABC 800A12BC 03004010 */  beqz       $v0, .L800A12CC
    /* 91AC0 800A12C0 83100300 */   sra       $v0, $v1, 2
    /* 91AC4 800A12C4 B5840208 */  j          .L800A12D4
    /* 91AC8 800A12C8 21108200 */   addu      $v0, $a0, $v0
  .L800A12CC:
    /* 91ACC 800A12CC 83100400 */  sra        $v0, $a0, 2
    /* 91AD0 800A12D0 21106200 */  addu       $v0, $v1, $v0
  .L800A12D4:
    /* 91AD4 800A12D4 8C0002AE */  sw         $v0, 0x8C($s0)
    /* 91AD8 800A12D8 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 91ADC 800A12DC 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 91AE0 800A12E0 02000224 */  addiu      $v0, $zero, 0x2
    /* 91AE4 800A12E4 25006214 */  bne        $v1, $v0, .L800A137C
    /* 91AE8 800A12E8 1180033C */   lui       $v1, %hi(Cars_gHumanRaceCarList)
    /* 91AEC 800A12EC 48FA6324 */  addiu      $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* 91AF0 800A12F0 1180023C */  lui        $v0, %hi(D_80113208)
    /* 91AF4 800A12F4 0832448C */  lw         $a0, %lo(D_80113208)($v0)
    /* 91AF8 800A12F8 01000224 */  addiu      $v0, $zero, 0x1
    /* 91AFC 800A12FC 23104400 */  subu       $v0, $v0, $a0
    /* 91B00 800A1300 80100200 */  sll        $v0, $v0, 2
    /* 91B04 800A1304 21104300 */  addu       $v0, $v0, $v1
    /* 91B08 800A1308 0000428C */  lw         $v0, 0x0($v0)
    /* 91B0C 800A130C A000058E */  lw         $a1, 0xA0($s0)
    /* 91B10 800A1310 A000438C */  lw         $v1, 0xA0($v0)
    /* 91B14 800A1314 00000000 */  nop
    /* 91B18 800A1318 2320A300 */  subu       $a0, $a1, $v1
    /* 91B1C 800A131C 0200801C */  bgtz       $a0, .L800A1328
    /* 91B20 800A1320 00000000 */   nop
    /* 91B24 800A1324 23206500 */  subu       $a0, $v1, $a1
  .L800A1328:
    /* 91B28 800A1328 A800058E */  lw         $a1, 0xA8($s0)
    /* 91B2C 800A132C A800428C */  lw         $v0, 0xA8($v0)
    /* 91B30 800A1330 00000000 */  nop
    /* 91B34 800A1334 2318A200 */  subu       $v1, $a1, $v0
    /* 91B38 800A1338 0200601C */  bgtz       $v1, .L800A1344
    /* 91B3C 800A133C 00000000 */   nop
    /* 91B40 800A1340 23184500 */  subu       $v1, $v0, $a1
  .L800A1344:
    /* 91B44 800A1344 2A106400 */  slt        $v0, $v1, $a0
    /* 91B48 800A1348 03004010 */  beqz       $v0, .L800A1358
    /* 91B4C 800A134C 83100300 */   sra       $v0, $v1, 2
    /* 91B50 800A1350 D8840208 */  j          .L800A1360
    /* 91B54 800A1354 21188200 */   addu      $v1, $a0, $v0
  .L800A1358:
    /* 91B58 800A1358 83100400 */  sra        $v0, $a0, 2
    /* 91B5C 800A135C 21186200 */  addu       $v1, $v1, $v0
  .L800A1360:
    /* 91B60 800A1360 8C00028E */  lw         $v0, 0x8C($s0)
    /* 91B64 800A1364 00000000 */  nop
    /* 91B68 800A1368 2A106200 */  slt        $v0, $v1, $v0
    /* 91B6C 800A136C 03004010 */  beqz       $v0, .L800A137C
    /* 91B70 800A1370 00000000 */   nop
    /* 91B74 800A1374 01000624 */  addiu      $a2, $zero, 0x1
    /* 91B78 800A1378 8C0003AE */  sw         $v1, 0x8C($s0)
  .L800A137C:
    /* 91B7C 800A137C 8C00028E */  lw         $v0, 0x8C($s0)
    /* 91B80 800A1380 6000113C */  lui        $s1, (0x600000 >> 16)
    /* 91B84 800A1384 2A102202 */  slt        $v0, $s1, $v0
    /* 91B88 800A1388 12004014 */  bnez       $v0, .L800A13D4
    /* 91B8C 800A138C 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* 91B90 800A1390 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* 91B94 800A1394 80180600 */  sll        $v1, $a2, 2
    /* 91B98 800A1398 21186200 */  addu       $v1, $v1, $v0
    /* 91B9C 800A139C 0000648C */  lw         $a0, 0x0($v1)
    /* 91BA0 800A13A0 08000526 */  addiu      $a1, $s0, 0x8
    /* 91BA4 800A13A4 05F7010C */  jal        BWorld_CheckChunkVisible__FP12BWorldSm_PosT0
    /* 91BA8 800A13A8 08008424 */   addiu     $a0, $a0, 0x8
    /* 91BAC 800A13AC 02004014 */  bnez       $v0, .L800A13B8
    /* 91BB0 800A13B0 00000000 */   nop
    /* 91BB4 800A13B4 01001224 */  addiu      $s2, $zero, 0x1
  .L800A13B8:
    /* 91BB8 800A13B8 8C00028E */  lw         $v0, 0x8C($s0)
    /* 91BBC 800A13BC 00000000 */  nop
    /* 91BC0 800A13C0 2A102202 */  slt        $v0, $s1, $v0
    /* 91BC4 800A13C4 03004014 */  bnez       $v0, .L800A13D4
    /* 91BC8 800A13C8 00000000 */   nop
    /* 91BCC 800A13CC 14004012 */  beqz       $s2, .L800A1420
    /* 91BD0 800A13D0 00000000 */   nop
  .L800A13D4:
    /* 91BD4 800A13D4 5C07028E */  lw         $v0, 0x75C($s0)
    /* 91BD8 800A13D8 00000000 */  nop
    /* 91BDC 800A13DC 06004010 */  beqz       $v0, .L800A13F8
    /* 91BE0 800A13E0 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 91BE4 800A13E4 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 91BE8 800A13E8 00000000 */  nop
    /* 91BEC 800A13EC 03004228 */  slti       $v0, $v0, 0x3
    /* 91BF0 800A13F0 0B004010 */  beqz       $v0, .L800A1420
    /* 91BF4 800A13F4 00000000 */   nop
  .L800A13F8:
    /* 91BF8 800A13F8 90000292 */  lbu        $v0, 0x90($s0)
    /* 91BFC 800A13FC 02000324 */  addiu      $v1, $zero, 0x2
    /* 91C00 800A1400 03004310 */  beq        $v0, $v1, .L800A1410
    /* 91C04 800A1404 01000224 */   addiu     $v0, $zero, 0x1
    /* 91C08 800A1408 BC0102AE */  sw         $v0, 0x1BC($s0)
    /* 91C0C 800A140C C00102AE */  sw         $v0, 0x1C0($s0)
  .L800A1410:
    /* 91C10 800A1410 900003A2 */  sb         $v1, 0x90($s0)
    /* 91C14 800A1414 140100AE */  sw         $zero, 0x114($s0)
    /* 91C18 800A1418 54850208 */  j          .L800A1550
    /* 91C1C 800A141C 1C0100AE */   sw        $zero, 0x11C($s0)
  .L800A1420:
    /* 91C20 800A1420 6002028E */  lw         $v0, 0x260($s0)
    /* 91C24 800A1424 90000492 */  lbu        $a0, 0x90($s0)
    /* 91C28 800A1428 30004230 */  andi       $v0, $v0, 0x30
    /* 91C2C 800A142C 11004014 */  bnez       $v0, .L800A1474
    /* 91C30 800A1430 00000000 */   nop
    /* 91C34 800A1434 5C07028E */  lw         $v0, 0x75C($s0)
    /* 91C38 800A1438 00000000 */  nop
    /* 91C3C 800A143C 06004010 */  beqz       $v0, .L800A1458
    /* 91C40 800A1440 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 91C44 800A1444 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 91C48 800A1448 00000000 */  nop
    /* 91C4C 800A144C 03004228 */  slti       $v0, $v0, 0x3
    /* 91C50 800A1450 08004010 */  beqz       $v0, .L800A1474
    /* 91C54 800A1454 00000000 */   nop
  .L800A1458:
    /* 91C58 800A1458 8C00038E */  lw         $v1, 0x8C($s0)
    /* 91C5C 800A145C 4800023C */  lui        $v0, (0x480000 >> 16)
    /* 91C60 800A1460 2A104300 */  slt        $v0, $v0, $v1
    /* 91C64 800A1464 03004010 */  beqz       $v0, .L800A1474
    /* 91C68 800A1468 01000224 */   addiu     $v0, $zero, 0x1
    /* 91C6C 800A146C 1E850208 */  j          .L800A1478
    /* 91C70 800A1470 900002A2 */   sb        $v0, 0x90($s0)
  .L800A1474:
    /* 91C74 800A1474 900000A2 */  sb         $zero, 0x90($s0)
  .L800A1478:
    /* 91C78 800A1478 02008228 */  slti       $v0, $a0, 0x2
    /* 91C7C 800A147C 34004014 */  bnez       $v0, .L800A1550
    /* 91C80 800A1480 00000000 */   nop
    /* 91C84 800A1484 B11A020C */  jal        Cars_SetCarUpForHiRezSim__FP8Car_tObj
    /* 91C88 800A1488 21200002 */   addu      $a0, $s0, $zero
    /* 91C8C 800A148C C17D020C */  jal        Newton_FindClosestQuad__FP13BO_tNewtonObj
    /* 91C90 800A1490 21200002 */   addu      $a0, $s0, $zero
    /* 91C94 800A1494 E87D020C */  jal        Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
    /* 91C98 800A1498 21200002 */   addu      $a0, $s0, $zero
    /* 91C9C 800A149C 6983020C */  jal        Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj
    /* 91CA0 800A14A0 21200002 */   addu      $a0, $s0, $zero
    /* 91CA4 800A14A4 1480023C */  lui        $v0, %hi(stackSpeedUpEnbabledFlag)
    /* 91CA8 800A14A8 1CD8428C */  lw         $v0, %lo(stackSpeedUpEnbabledFlag)($v0)
    /* 91CAC 800A14AC 00000000 */  nop
    /* 91CB0 800A14B0 18004010 */  beqz       $v0, .L800A1514
    /* 91CB4 800A14B4 21200002 */   addu      $a0, $s0, $zero
    /* 91CB8 800A14B8 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 91CBC 800A14BC 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 91CC0 800A14C0 2B91030C */  jal        SetSp
    /* 91CC4 800A14C4 00000000 */   nop
    /* 91CC8 800A14C8 21200002 */  addu       $a0, $s0, $zero
    /* 91CCC 800A14CC 1480053C */  lui        $a1, %hi(D_8013E0D8)
    /* 91CD0 800A14D0 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 91CD4 800A14D4 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 91CD8 800A14D8 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 91CDC 800A14DC 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 91CE0 800A14E0 E07F020C */  jal        Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
    /* 91CE4 800A14E4 D8E0A524 */   addiu     $a1, $a1, %lo(D_8013E0D8)
    /* 91CE8 800A14E8 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 91CEC 800A14EC 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 91CF0 800A14F0 2B91030C */  jal        SetSp
    /* 91CF4 800A14F4 800102AE */   sw        $v0, 0x180($s0)
    /* 91CF8 800A14F8 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 91CFC 800A14FC 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 91D00 800A1500 01000224 */  addiu      $v0, $zero, 0x1
    /* 91D04 800A1504 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 91D08 800A1508 1CD822AC */  sw         $v0, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 91D0C 800A150C 49850208 */  j          .L800A1524
    /* 91D10 800A1510 00000000 */   nop
  .L800A1514:
    /* 91D14 800A1514 1480053C */  lui        $a1, %hi(D_8013E0D8)
    /* 91D18 800A1518 E07F020C */  jal        Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
    /* 91D1C 800A151C D8E0A524 */   addiu     $a1, $a1, %lo(D_8013E0D8)
    /* 91D20 800A1520 800102AE */  sw         $v0, 0x180($s0)
  .L800A1524:
    /* 91D24 800A1524 8001028E */  lw         $v0, 0x180($s0)
    /* 91D28 800A1528 3801048E */  lw         $a0, 0x138($s0)
    /* 91D2C 800A152C 01000324 */  addiu      $v1, $zero, 0x1
    /* 91D30 800A1530 BC0103AE */  sw         $v1, 0x1BC($s0)
    /* 91D34 800A1534 C00103AE */  sw         $v1, 0x1C0($s0)
    /* 91D38 800A1538 840100AE */  sw         $zero, 0x184($s0)
    /* 91D3C 800A153C 900100AE */  sw         $zero, 0x190($s0)
    /* 91D40 800A1540 940100AE */  sw         $zero, 0x194($s0)
    /* 91D44 800A1544 880100AE */  sw         $zero, 0x188($s0)
    /* 91D48 800A1548 21104400 */  addu       $v0, $v0, $a0
    /* 91D4C 800A154C A40002AE */  sw         $v0, 0xA4($s0)
  .L800A1550:
    /* 91D50 800A1550 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 91D54 800A1554 1800B28F */  lw         $s2, 0x18($sp)
    /* 91D58 800A1558 1400B18F */  lw         $s1, 0x14($sp)
    /* 91D5C 800A155C 1000B08F */  lw         $s0, 0x10($sp)
    /* 91D60 800A1560 0800E003 */  jr         $ra
    /* 91D64 800A1564 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj
