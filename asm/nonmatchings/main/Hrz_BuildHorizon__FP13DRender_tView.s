.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_BuildHorizon__FP13DRender_tView, 0x764

glabel Hrz_BuildHorizon__FP13DRender_tView
    /* C1B1C 800D131C 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* C1B20 800D1320 5800B0AF */  sw         $s0, 0x58($sp)
    /* C1B24 800D1324 21808000 */  addu       $s0, $a0, $zero
    /* C1B28 800D1328 0100023C */  lui        $v0, (0x107AE >> 16)
    /* C1B2C 800D132C AE074234 */  ori        $v0, $v0, (0x107AE & 0xFFFF)
    /* C1B30 800D1330 1800A427 */  addiu      $a0, $sp, 0x18
    /* C1B34 800D1334 21280000 */  addu       $a1, $zero, $zero
    /* C1B38 800D1338 0C000624 */  addiu      $a2, $zero, 0xC
    /* C1B3C 800D133C 7C00BFAF */  sw         $ra, 0x7C($sp)
    /* C1B40 800D1340 7800BEAF */  sw         $fp, 0x78($sp)
    /* C1B44 800D1344 7400B7AF */  sw         $s7, 0x74($sp)
    /* C1B48 800D1348 7000B6AF */  sw         $s6, 0x70($sp)
    /* C1B4C 800D134C 6C00B5AF */  sw         $s5, 0x6C($sp)
    /* C1B50 800D1350 6800B4AF */  sw         $s4, 0x68($sp)
    /* C1B54 800D1354 6400B3AF */  sw         $s3, 0x64($sp)
    /* C1B58 800D1358 6000B2AF */  sw         $s2, 0x60($sp)
    /* C1B5C 800D135C 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* C1B60 800D1360 C690030C */  jal        memset
    /* C1B64 800D1364 4C00A2AF */   sw        $v0, 0x4C($sp)
    /* C1B68 800D1368 1480033C */  lui        $v1, %hi(Camera_gGeomScreen)
    /* C1B6C 800D136C DCC7638C */  lw         $v1, %lo(Camera_gGeomScreen)($v1)
    /* C1B70 800D1370 801F163C */  lui        $s6, (0x1F800058 >> 16)
    /* C1B74 800D1374 BD026228 */  slti       $v0, $v1, 0x2BD
    /* C1B78 800D1378 04004014 */  bnez       $v0, .L800D138C
    /* C1B7C 800D137C 5000A0AF */   sw        $zero, 0x50($sp)
    /* C1B80 800D1380 5000A3AF */  sw         $v1, 0x50($sp)
    /* C1B84 800D1384 E7AA030C */  jal        SetGeomScreen
    /* C1B88 800D1388 BC020424 */   addiu     $a0, $zero, 0x2BC
  .L800D138C:
    /* C1B8C 800D138C 0F42030C */  jal        HrzSetPsxMatrix__FP10matrixtdef
    /* C1B90 800D1390 44000426 */   addiu     $a0, $s0, 0x44
    /* C1B94 800D1394 4742030C */  jal        HrzSetPsxTranslation__FP8coorddef
    /* C1B98 800D1398 1800A427 */   addiu     $a0, $sp, 0x18
    /* C1B9C 800D139C 11000424 */  addiu      $a0, $zero, 0x11
    /* C1BA0 800D13A0 4413858F */  lw         $a1, %gp_rel(gRngCoordTop)($gp)
    /* C1BA4 800D13A4 801F063C */  lui        $a2, (0x1F800124 >> 16)
    /* C1BA8 800D13A8 2401C634 */  ori        $a2, $a2, (0x1F800124 & 0xFFFF)
    /* C1BAC 800D13AC 801F073C */  lui        $a3, (0x1F800058 >> 16)
    /* C1BB0 800D13B0 5B42030C */  jal        Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR
    /* C1BB4 800D13B4 5800E734 */   ori       $a3, $a3, (0x1F800058 & 0xFFFF)
    /* C1BB8 800D13B8 21400000 */  addu       $t0, $zero, $zero
    /* C1BBC 800D13BC 21280001 */  addu       $a1, $t0, $zero
    /* C1BC0 800D13C0 801F043C */  lui        $a0, (0x1F800124 >> 16)
    /* C1BC4 800D13C4 24018434 */  ori        $a0, $a0, (0x1F800124 & 0xFFFF)
    /* C1BC8 800D13C8 21380001 */  addu       $a3, $t0, $zero
  .L800D13CC:
    /* C1BCC 800D13CC 0000838C */  lw         $v1, 0x0($a0)
    /* C1BD0 800D13D0 00000000 */  nop
    /* C1BD4 800D13D4 2A10A300 */  slt        $v0, $a1, $v1
    /* C1BD8 800D13D8 03004010 */  beqz       $v0, .L800D13E8
    /* C1BDC 800D13DC 00000000 */   nop
    /* C1BE0 800D13E0 21286000 */  addu       $a1, $v1, $zero
    /* C1BE4 800D13E4 2140E000 */  addu       $t0, $a3, $zero
  .L800D13E8:
    /* C1BE8 800D13E8 0100E724 */  addiu      $a3, $a3, 0x1
    /* C1BEC 800D13EC 1000E228 */  slti       $v0, $a3, 0x10
    /* C1BF0 800D13F0 F6FF4014 */  bnez       $v0, .L800D13CC
    /* C1BF4 800D13F4 04008424 */   addiu     $a0, $a0, 0x4
    /* C1BF8 800D13F8 C0200800 */  sll        $a0, $t0, 3
    /* C1BFC 800D13FC 4413828F */  lw         $v0, %gp_rel(gRngCoordTop)($gp)
    /* C1C00 800D1400 3C13858F */  lw         $a1, %gp_rel(Hrz_gTrackSpec)($gp)
    /* C1C04 800D1404 21208200 */  addu       $a0, $a0, $v0
    /* C1C08 800D1408 00008294 */  lhu        $v0, 0x0($a0)
    /* C1C0C 800D140C 00000000 */  nop
    /* C1C10 800D1410 2800A2A7 */  sh         $v0, 0x28($sp)
    /* C1C14 800D1414 0800A294 */  lhu        $v0, 0x8($a1)
    /* C1C18 800D1418 0C00A394 */  lhu        $v1, 0xC($a1)
    /* C1C1C 800D141C 00000000 */  nop
    /* C1C20 800D1420 21104300 */  addu       $v0, $v0, $v1
    /* C1C24 800D1424 2A00A2A7 */  sh         $v0, 0x2A($sp)
    /* C1C28 800D1428 04008294 */  lhu        $v0, 0x4($a0)
    /* C1C2C 800D142C 00000000 */  nop
    /* C1C30 800D1430 2C00A2A7 */  sh         $v0, 0x2C($sp)
    /* C1C34 800D1434 00008294 */  lhu        $v0, 0x0($a0)
    /* C1C38 800D1438 00000000 */  nop
    /* C1C3C 800D143C 3000A2A7 */  sh         $v0, 0x30($sp)
    /* C1C40 800D1440 0800A294 */  lhu        $v0, 0x8($a1)
    /* C1C44 800D1444 00000000 */  nop
    /* C1C48 800D1448 3200A2A7 */  sh         $v0, 0x32($sp)
    /* C1C4C 800D144C 04008294 */  lhu        $v0, 0x4($a0)
    /* C1C50 800D1450 4000A427 */  addiu      $a0, $sp, 0x40
    /* C1C54 800D1454 3400A2A7 */  sh         $v0, 0x34($sp)
    /* C1C58 800D1458 3300A98B */  lwl        $t1, 0x33($sp)
    /* C1C5C 800D145C 3000A99B */  lwr        $t1, 0x30($sp)
    /* C1C60 800D1460 3700AA8B */  lwl        $t2, 0x37($sp)
    /* C1C64 800D1464 3400AA9B */  lwr        $t2, 0x34($sp)
    /* C1C68 800D1468 4300A9AB */  swl        $t1, 0x43($sp)
    /* C1C6C 800D146C 4000A9BB */  swr        $t1, 0x40($sp)
    /* C1C70 800D1470 4700AAAB */  swl        $t2, 0x47($sp)
    /* C1C74 800D1474 4400AABB */  swr        $t2, 0x44($sp)
    /* C1C78 800D1478 000080C8 */  lwc2       $0, 0x0($a0)
    /* C1C7C 800D147C 040081C8 */  lwc2       $1, 0x4($a0)
    /* C1C80 800D1480 00000000 */  nop
    /* C1C84 800D1484 00000000 */  nop
    /* C1C88 800D1488 0100184A */  .word 0x4A180001  /* rtps */
    /* C1C8C 800D148C 4800A327 */  addiu      $v1, $sp, 0x48
    /* C1C90 800D1490 00006EE8 */  swc2       $14, 0x0($v1)
    /* C1C94 800D1494 4800A28F */  lw         $v0, 0x48($sp)
    /* C1C98 800D1498 00000000 */  nop
    /* C1C9C 800D149C 3C00A2AF */  sw         $v0, 0x3C($sp)
    /* C1CA0 800D14A0 2B00A98B */  lwl        $t1, 0x2B($sp)
    /* C1CA4 800D14A4 2800A99B */  lwr        $t1, 0x28($sp)
    /* C1CA8 800D14A8 2F00AA8B */  lwl        $t2, 0x2F($sp)
    /* C1CAC 800D14AC 2C00AA9B */  lwr        $t2, 0x2C($sp)
    /* C1CB0 800D14B0 4300A9AB */  swl        $t1, 0x43($sp)
    /* C1CB4 800D14B4 4000A9BB */  swr        $t1, 0x40($sp)
    /* C1CB8 800D14B8 4700AAAB */  swl        $t2, 0x47($sp)
    /* C1CBC 800D14BC 4400AABB */  swr        $t2, 0x44($sp)
    /* C1CC0 800D14C0 000080C8 */  lwc2       $0, 0x0($a0)
    /* C1CC4 800D14C4 040081C8 */  lwc2       $1, 0x4($a0)
    /* C1CC8 800D14C8 00000000 */  nop
    /* C1CCC 800D14CC 00000000 */  nop
    /* C1CD0 800D14D0 0100184A */  .word 0x4A180001  /* rtps */
    /* C1CD4 800D14D4 00006EE8 */  swc2       $14, 0x0($v1)
    /* C1CD8 800D14D8 21380000 */  addu       $a3, $zero, $zero
    /* C1CDC 800D14DC 4800A28F */  lw         $v0, 0x48($sp)
    /* C1CE0 800D14E0 2130C002 */  addu       $a2, $s6, $zero
    /* C1CE4 800D14E4 3800A2AF */  sw         $v0, 0x38($sp)
    /* C1CE8 800D14E8 80100800 */  sll        $v0, $t0, 2
    /* C1CEC 800D14EC 2110C202 */  addu       $v0, $s6, $v0
    /* C1CF0 800D14F0 3800A587 */  lh         $a1, 0x38($sp)
    /* C1CF4 800D14F4 58004384 */  lh         $v1, (0x1F800058 & 0xFFFF)($v0)
    /* C1CF8 800D14F8 3A00A487 */  lh         $a0, 0x3A($sp)
    /* C1CFC 800D14FC 5A004284 */  lh         $v0, (0x1F80005A & 0xFFFF)($v0)
    /* C1D00 800D1500 2328A300 */  subu       $a1, $a1, $v1
    /* C1D04 800D1504 23208200 */  subu       $a0, $a0, $v0
  .L800D1508:
    /* C1D08 800D1508 2401C28C */  lw         $v0, (0x1F800124 & 0xFFFF)($a2)
    /* C1D0C 800D150C 00000000 */  nop
    /* C1D10 800D1510 07004018 */  blez       $v0, .L800D1530
    /* C1D14 800D1514 00000000 */   nop
    /* C1D18 800D1518 5800C294 */  lhu        $v0, 0x58($a2)
    /* C1D1C 800D151C 5A00C394 */  lhu        $v1, 0x5A($a2)
    /* C1D20 800D1520 21104500 */  addu       $v0, $v0, $a1
    /* C1D24 800D1524 21186400 */  addu       $v1, $v1, $a0
    /* C1D28 800D1528 1400C2A4 */  sh         $v0, 0x14($a2)
    /* C1D2C 800D152C 1600C3A4 */  sh         $v1, 0x16($a2)
  .L800D1530:
    /* C1D30 800D1530 0100E724 */  addiu      $a3, $a3, 0x1
    /* C1D34 800D1534 1100E228 */  slti       $v0, $a3, 0x11
    /* C1D38 800D1538 F3FF4014 */  bnez       $v0, .L800D1508
    /* C1D3C 800D153C 0400C624 */   addiu     $a2, $a2, %lo(D_1F800004)
    /* C1D40 800D1540 21380000 */  addu       $a3, $zero, $zero
    /* C1D44 800D1544 2130C002 */  addu       $a2, $s6, $zero
    /* C1D48 800D1548 80100800 */  sll        $v0, $t0, 2
    /* C1D4C 800D154C 2110C202 */  addu       $v0, $s6, $v0
    /* C1D50 800D1550 3C00A587 */  lh         $a1, 0x3C($sp)
    /* C1D54 800D1554 58004384 */  lh         $v1, (0x1F800058 & 0xFFFF)($v0)
    /* C1D58 800D1558 3E00A487 */  lh         $a0, 0x3E($sp)
    /* C1D5C 800D155C 5A004284 */  lh         $v0, (0x1F80005A & 0xFFFF)($v0)
    /* C1D60 800D1560 2328A300 */  subu       $a1, $a1, $v1
    /* C1D64 800D1564 23208200 */  subu       $a0, $a0, $v0
  .L800D1568:
    /* C1D68 800D1568 2401C28C */  lw         $v0, (0x1F800124 & 0xFFFF)($a2)
    /* C1D6C 800D156C 00000000 */  nop
    /* C1D70 800D1570 07004018 */  blez       $v0, .L800D1590
    /* C1D74 800D1574 00000000 */   nop
    /* C1D78 800D1578 5800C294 */  lhu        $v0, 0x58($a2)
    /* C1D7C 800D157C 5A00C394 */  lhu        $v1, 0x5A($a2)
    /* C1D80 800D1580 21104500 */  addu       $v0, $v0, $a1
    /* C1D84 800D1584 21186400 */  addu       $v1, $v1, $a0
    /* C1D88 800D1588 5800C2A4 */  sh         $v0, 0x58($a2)
    /* C1D8C 800D158C 5A00C3A4 */  sh         $v1, 0x5A($a2)
  .L800D1590:
    /* C1D90 800D1590 0100E724 */  addiu      $a3, $a3, 0x1
    /* C1D94 800D1594 1100E228 */  slti       $v0, $a3, 0x11
    /* C1D98 800D1598 F3FF4014 */  bnez       $v0, .L800D1568
    /* C1D9C 800D159C 0400C624 */   addiu     $a2, $a2, %lo(D_1F800004)
    /* C1DA0 800D15A0 9C00C436 */  ori        $a0, $s6, (0x1F80009C & 0xFFFF)
    /* C1DA4 800D15A4 5800C536 */  ori        $a1, $s6, (0x1F800058 & 0xFFFF)
    /* C1DA8 800D15A8 1400C636 */  ori        $a2, $s6, (0x1F800014 & 0xFFFF)
    /* C1DAC 800D15AC 1280103C */  lui        $s0, %hi(gfxPmxHeightPercentage)
    /* C1DB0 800D15B0 7C081026 */  addiu      $s0, $s0, %lo(gfxPmxHeightPercentage)
    /* C1DB4 800D15B4 21380002 */  addu       $a3, $s0, $zero
    /* C1DB8 800D15B8 10001224 */  addiu      $s2, $zero, 0x10
    /* C1DBC 800D15BC 01001124 */  addiu      $s1, $zero, 0x1
    /* C1DC0 800D15C0 1000B2AF */  sw         $s2, 0x10($sp)
    /* C1DC4 800D15C4 5D3D030C */  jal        Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii
    /* C1DC8 800D15C8 1400B1AF */   sw        $s1, 0x14($sp)
    /* C1DCC 800D15CC E000C436 */  ori        $a0, $s6, (0x1F8000E0 & 0xFFFF)
    /* C1DD0 800D15D0 5C00C536 */  ori        $a1, $s6, (0x1F80005C & 0xFFFF)
    /* C1DD4 800D15D4 1800C636 */  ori        $a2, $s6, (0x1F800018 & 0xFFFF)
    /* C1DD8 800D15D8 21380002 */  addu       $a3, $s0, $zero
    /* C1DDC 800D15DC 1000B2AF */  sw         $s2, 0x10($sp)
    /* C1DE0 800D15E0 5D3D030C */  jal        Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii
    /* C1DE4 800D15E4 1400B1AF */   sw        $s1, 0x14($sp)
    /* C1DE8 800D15E8 1280023C */  lui        $v0, %hi(D_80123280)
    /* C1DEC 800D15EC 80324284 */  lh         $v0, %lo(D_80123280)($v0)
    /* C1DF0 800D15F0 00000000 */  nop
    /* C1DF4 800D15F4 E3004010 */  beqz       $v0, .L800D1984
    /* C1DF8 800D15F8 21A00000 */   addu      $s4, $zero, $zero
    /* C1DFC 800D15FC FF00173C */  lui        $s7, (0xFFFFFF >> 16)
    /* C1E00 800D1600 FFFFF736 */  ori        $s7, $s7, (0xFFFFFF & 0xFFFF)
    /* C1E04 800D1604 1280023C */  lui        $v0, %hi(D_80120838)
    /* C1E08 800D1608 38085E24 */  addiu      $fp, $v0, %lo(D_80120838)
    /* C1E0C 800D160C 2198C002 */  addu       $s3, $s6, $zero
    /* C1E10 800D1610 21908002 */  addu       $s2, $s4, $zero
    /* C1E14 800D1614 04001524 */  addiu      $s5, $zero, 0x4
  .L800D1618:
    /* C1E18 800D1618 1000822A */  slti       $v0, $s4, 0x10
    /* C1E1C 800D161C D9004010 */  beqz       $v0, .L800D1984
    /* C1E20 800D1620 00000000 */   nop
    /* C1E24 800D1624 2401628E */  lw         $v0, (0x1F800124 & 0xFFFF)($s3)
    /* C1E28 800D1628 00000000 */  nop
    /* C1E2C 800D162C 803E4228 */  slti       $v0, $v0, 0x3E80
    /* C1E30 800D1630 06004010 */  beqz       $v0, .L800D164C
    /* C1E34 800D1634 2110D502 */   addu      $v0, $s6, $s5
    /* C1E38 800D1638 2401428C */  lw         $v0, (0x1F800124 & 0xFFFF)($v0)
    /* C1E3C 800D163C 00000000 */  nop
    /* C1E40 800D1640 803E4228 */  slti       $v0, $v0, 0x3E80
    /* C1E44 800D1644 CA004014 */  bnez       $v0, .L800D1970
    /* C1E48 800D1648 00000000 */   nop
  .L800D164C:
    /* C1E4C 800D164C 2110D502 */  addu       $v0, $s6, $s5
    /* C1E50 800D1650 9F00698A */  lwl        $t1, (0x1F80009F & 0xFFFF)($s3)
    /* C1E54 800D1654 9C00699A */  lwr        $t1, (0x1F80009C & 0xFFFF)($s3)
    /* C1E58 800D1658 00000000 */  nop
    /* C1E5C 800D165C 2B00A9AB */  swl        $t1, 0x2B($sp)
    /* C1E60 800D1660 2800A9BB */  swr        $t1, 0x28($sp)
    /* C1E64 800D1664 E300698A */  lwl        $t1, (0x1F8000E3 & 0xFFFF)($s3)
    /* C1E68 800D1668 E000699A */  lwr        $t1, (0x1F8000E0 & 0xFFFF)($s3)
    /* C1E6C 800D166C 00000000 */  nop
    /* C1E70 800D1670 2F00A9AB */  swl        $t1, 0x2F($sp)
    /* C1E74 800D1674 2C00A9BB */  swr        $t1, 0x2C($sp)
    /* C1E78 800D1678 5B004988 */  lwl        $t1, (0x1F80005B & 0xFFFF)($v0)
    /* C1E7C 800D167C 58004998 */  lwr        $t1, (0x1F800058 & 0xFFFF)($v0)
    /* C1E80 800D1680 00000000 */  nop
    /* C1E84 800D1684 3300A9AB */  swl        $t1, 0x33($sp)
    /* C1E88 800D1688 3000A9BB */  swr        $t1, 0x30($sp)
    /* C1E8C 800D168C 5B00698A */  lwl        $t1, (0x1F80005B & 0xFFFF)($s3)
    /* C1E90 800D1690 5800699A */  lwr        $t1, (0x1F800058 & 0xFFFF)($s3)
    /* C1E94 800D1694 00000000 */  nop
    /* C1E98 800D1698 3700A9AB */  swl        $t1, 0x37($sp)
    /* C1E9C 800D169C 3400A9BB */  swr        $t1, 0x34($sp)
    /* C1EA0 800D16A0 2800A287 */  lh         $v0, 0x28($sp)
    /* C1EA4 800D16A4 00000000 */  nop
    /* C1EA8 800D16A8 0D004104 */  bgez       $v0, .L800D16E0
    /* C1EAC 800D16AC 00000000 */   nop
    /* C1EB0 800D16B0 2C00A287 */  lh         $v0, 0x2C($sp)
    /* C1EB4 800D16B4 00000000 */  nop
    /* C1EB8 800D16B8 09004104 */  bgez       $v0, .L800D16E0
    /* C1EBC 800D16BC 00000000 */   nop
    /* C1EC0 800D16C0 3000A287 */  lh         $v0, 0x30($sp)
    /* C1EC4 800D16C4 00000000 */  nop
    /* C1EC8 800D16C8 05004104 */  bgez       $v0, .L800D16E0
    /* C1ECC 800D16CC 00000000 */   nop
    /* C1ED0 800D16D0 3400A287 */  lh         $v0, 0x34($sp)
    /* C1ED4 800D16D4 00000000 */  nop
    /* C1ED8 800D16D8 A5004004 */  bltz       $v0, .L800D1970
    /* C1EDC 800D16DC 00000000 */   nop
  .L800D16E0:
    /* C1EE0 800D16E0 801F023C */  lui        $v0, (0x1F800010 >> 16)
    /* C1EE4 800D16E4 10004294 */  lhu        $v0, (0x1F800010 & 0xFFFF)($v0)
    /* C1EE8 800D16E8 2800A387 */  lh         $v1, 0x28($sp)
    /* C1EEC 800D16EC 00140200 */  sll        $v0, $v0, 16
    /* C1EF0 800D16F0 03240200 */  sra        $a0, $v0, 16
    /* C1EF4 800D16F4 2A188300 */  slt        $v1, $a0, $v1
    /* C1EF8 800D16F8 10006010 */  beqz       $v1, .L800D173C
    /* C1EFC 800D16FC 00000000 */   nop
    /* C1F00 800D1700 2C00A287 */  lh         $v0, 0x2C($sp)
    /* C1F04 800D1704 00000000 */  nop
    /* C1F08 800D1708 2A108200 */  slt        $v0, $a0, $v0
    /* C1F0C 800D170C 0B004010 */  beqz       $v0, .L800D173C
    /* C1F10 800D1710 00000000 */   nop
    /* C1F14 800D1714 3000A287 */  lh         $v0, 0x30($sp)
    /* C1F18 800D1718 00000000 */  nop
    /* C1F1C 800D171C 2A108200 */  slt        $v0, $a0, $v0
    /* C1F20 800D1720 06004010 */  beqz       $v0, .L800D173C
    /* C1F24 800D1724 00000000 */   nop
    /* C1F28 800D1728 3400A287 */  lh         $v0, 0x34($sp)
    /* C1F2C 800D172C 00000000 */  nop
    /* C1F30 800D1730 2A108200 */  slt        $v0, $a0, $v0
    /* C1F34 800D1734 8E004014 */  bnez       $v0, .L800D1970
    /* C1F38 800D1738 00000000 */   nop
  .L800D173C:
    /* C1F3C 800D173C 2A00A287 */  lh         $v0, 0x2A($sp)
    /* C1F40 800D1740 00000000 */  nop
    /* C1F44 800D1744 0D004104 */  bgez       $v0, .L800D177C
    /* C1F48 800D1748 00000000 */   nop
    /* C1F4C 800D174C 2E00A287 */  lh         $v0, 0x2E($sp)
    /* C1F50 800D1750 00000000 */  nop
    /* C1F54 800D1754 09004104 */  bgez       $v0, .L800D177C
    /* C1F58 800D1758 00000000 */   nop
    /* C1F5C 800D175C 3200A287 */  lh         $v0, 0x32($sp)
    /* C1F60 800D1760 00000000 */  nop
    /* C1F64 800D1764 05004104 */  bgez       $v0, .L800D177C
    /* C1F68 800D1768 00000000 */   nop
    /* C1F6C 800D176C 3600A287 */  lh         $v0, 0x36($sp)
    /* C1F70 800D1770 00000000 */  nop
    /* C1F74 800D1774 7E004004 */  bltz       $v0, .L800D1970
    /* C1F78 800D1778 00000000 */   nop
  .L800D177C:
    /* C1F7C 800D177C 801F023C */  lui        $v0, (0x1F800012 >> 16)
    /* C1F80 800D1780 12004294 */  lhu        $v0, (0x1F800012 & 0xFFFF)($v0)
    /* C1F84 800D1784 2A00A387 */  lh         $v1, 0x2A($sp)
    /* C1F88 800D1788 00140200 */  sll        $v0, $v0, 16
    /* C1F8C 800D178C 03240200 */  sra        $a0, $v0, 16
    /* C1F90 800D1790 2A188300 */  slt        $v1, $a0, $v1
    /* C1F94 800D1794 10006010 */  beqz       $v1, .L800D17D8
    /* C1F98 800D1798 00000000 */   nop
    /* C1F9C 800D179C 2E00A287 */  lh         $v0, 0x2E($sp)
    /* C1FA0 800D17A0 00000000 */  nop
    /* C1FA4 800D17A4 2A108200 */  slt        $v0, $a0, $v0
    /* C1FA8 800D17A8 0B004010 */  beqz       $v0, .L800D17D8
    /* C1FAC 800D17AC 00000000 */   nop
    /* C1FB0 800D17B0 3200A287 */  lh         $v0, 0x32($sp)
    /* C1FB4 800D17B4 00000000 */  nop
    /* C1FB8 800D17B8 2A108200 */  slt        $v0, $a0, $v0
    /* C1FBC 800D17BC 06004010 */  beqz       $v0, .L800D17D8
    /* C1FC0 800D17C0 00000000 */   nop
    /* C1FC4 800D17C4 3600A287 */  lh         $v0, 0x36($sp)
    /* C1FC8 800D17C8 00000000 */  nop
    /* C1FCC 800D17CC 2A108200 */  slt        $v0, $a0, $v0
    /* C1FD0 800D17D0 67004014 */  bnez       $v0, .L800D1970
    /* C1FD4 800D17D4 00000000 */   nop
  .L800D17D8:
    /* C1FD8 800D17D8 3800A427 */  addiu      $a0, $sp, 0x38
    /* C1FDC 800D17DC 9C004526 */  addiu      $a1, $s2, 0x9C
    /* C1FE0 800D17E0 2128C502 */  addu       $a1, $s6, $a1
    /* C1FE4 800D17E4 E0004626 */  addiu      $a2, $s2, 0xE0
    /* C1FE8 800D17E8 2130C602 */  addu       $a2, $s6, $a2
    /* C1FEC 800D17EC 4C00A727 */  addiu      $a3, $sp, 0x4C
    /* C1FF0 800D17F0 01000224 */  addiu      $v0, $zero, 0x1
    /* C1FF4 800D17F4 1000A2AF */  sw         $v0, 0x10($sp)
    /* C1FF8 800D17F8 5D3D030C */  jal        Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii
    /* C1FFC 800D17FC 1400A0AF */   sw        $zero, 0x14($sp)
    /* C2000 800D1800 1280033C */  lui        $v1, %hi(gpPmx)
    /* C2004 800D1804 B4076324 */  addiu      $v1, $v1, %lo(gpPmx)
    /* C2008 800D1808 21184302 */  addu       $v1, $s2, $v1
    /* C200C 800D180C 3C13828F */  lw         $v0, %gp_rel(Hrz_gTrackSpec)($gp)
    /* C2010 800D1810 10000424 */  addiu      $a0, $zero, 0x10
    /* C2014 800D1814 21105400 */  addu       $v0, $v0, $s4
    /* C2018 800D1818 20004290 */  lbu        $v0, 0x20($v0)
    /* C201C 800D181C 0000718C */  lw         $s1, 0x0($v1)
    /* C2020 800D1820 53004410 */  beq        $v0, $a0, .L800D1970
    /* C2024 800D1824 801F063C */   lui       $a2, (0x1F800004 >> 16)
    /* C2028 800D1828 0400C634 */  ori        $a2, $a2, (0x1F800004 & 0xFFFF)
    /* C202C 800D182C 00FF053C */  lui        $a1, (0xFF000000 >> 16)
    /* C2030 800D1830 1480043C */  lui        $a0, %hi(Draw_gViewOtSize)
    /* C2034 800D1834 B0D7848C */  lw         $a0, %lo(Draw_gViewOtSize)($a0)
    /* C2038 800D1838 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* C203C 800D183C 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* C2040 800D1840 0000D08C */  lw         $s0, 0x0($a2)
    /* C2044 800D1844 80200400 */  sll        $a0, $a0, 2
    /* C2048 800D1848 21208200 */  addu       $a0, $a0, $v0
    /* C204C 800D184C 0000038E */  lw         $v1, 0x0($s0)
    /* C2050 800D1850 F8FF828C */  lw         $v0, -0x8($a0)
    /* C2054 800D1854 24186500 */  and        $v1, $v1, $a1
    /* C2058 800D1858 24105700 */  and        $v0, $v0, $s7
    /* C205C 800D185C 25186200 */  or         $v1, $v1, $v0
    /* C2060 800D1860 000003AE */  sw         $v1, 0x0($s0)
    /* C2064 800D1864 F8FF828C */  lw         $v0, -0x8($a0)
    /* C2068 800D1868 24181702 */  and        $v1, $s0, $s7
    /* C206C 800D186C 24104500 */  and        $v0, $v0, $a1
    /* C2070 800D1870 25104300 */  or         $v0, $v0, $v1
    /* C2074 800D1874 F8FF82AC */  sw         $v0, -0x8($a0)
    /* C2078 800D1878 21105E02 */  addu       $v0, $s2, $fp
    /* C207C 800D187C 0000438C */  lw         $v1, 0x0($v0)
    /* C2080 800D1880 34000226 */  addiu      $v0, $s0, 0x34
    /* C2084 800D1884 0000C2AC */  sw         $v0, 0x0($a2)
    /* C2088 800D1888 2110D203 */  addu       $v0, $fp, $s2
    /* C208C 800D188C 040003AE */  sw         $v1, 0x4($s0)
    /* C2090 800D1890 0400428C */  lw         $v0, 0x4($v0)
    /* C2094 800D1894 1280093C */  lui        $t1, %hi(D_801207F8)
    /* C2098 800D1898 100002AE */  sw         $v0, 0x10($s0)
    /* C209C 800D189C 2110D203 */  addu       $v0, $fp, $s2
    /* C20A0 800D18A0 BCFF428C */  lw         $v0, -0x44($v0)
    /* C20A4 800D18A4 F8072925 */  addiu      $t1, $t1, %lo(D_801207F8)
    /* C20A8 800D18A8 1C0002AE */  sw         $v0, 0x1C($s0)
    /* C20AC 800D18AC 21104902 */  addu       $v0, $s2, $t1
    /* C20B0 800D18B0 0000428C */  lw         $v0, 0x0($v0)
    /* C20B4 800D18B4 21200002 */  addu       $a0, $s0, $zero
    /* C20B8 800D18B8 24CD030C */  jal        SetPolyGT4
    /* C20BC 800D18BC 280002AE */   sw        $v0, 0x28($s0)
    /* C20C0 800D18C0 0000228E */  lw         $v0, 0x0($s1)
    /* C20C4 800D18C4 00000000 */  nop
    /* C20C8 800D18C8 0C0002AE */  sw         $v0, 0xC($s0)
    /* C20CC 800D18CC 0400228E */  lw         $v0, 0x4($s1)
    /* C20D0 800D18D0 00000000 */  nop
    /* C20D4 800D18D4 180002AE */  sw         $v0, 0x18($s0)
    /* C20D8 800D18D8 0800228E */  lw         $v0, 0x8($s1)
    /* C20DC 800D18DC 00000000 */  nop
    /* C20E0 800D18E0 240002AE */  sw         $v0, 0x24($s0)
    /* C20E4 800D18E4 0C00228E */  lw         $v0, 0xC($s1)
    /* C20E8 800D18E8 00000000 */  nop
    /* C20EC 800D18EC 300002AE */  sw         $v0, 0x30($s0)
    /* C20F0 800D18F0 3C13828F */  lw         $v0, %gp_rel(Hrz_gTrackSpec)($gp)
    /* C20F4 800D18F4 00000000 */  nop
    /* C20F8 800D18F8 21105400 */  addu       $v0, $v0, $s4
    /* C20FC 800D18FC 20004290 */  lbu        $v0, 0x20($v0)
    /* C2100 800D1900 00000000 */  nop
    /* C2104 800D1904 0800422C */  sltiu      $v0, $v0, 0x8
    /* C2108 800D1908 0D004014 */  bnez       $v0, .L800D1940
    /* C210C 800D190C 21185602 */   addu      $v1, $s2, $s6
    /* C2110 800D1910 3800A28F */  lw         $v0, 0x38($sp)
    /* C2114 800D1914 00000000 */  nop
    /* C2118 800D1918 080002AE */  sw         $v0, 0x8($s0)
    /* C211C 800D191C 9C00628E */  lw         $v0, 0x9C($s3)
    /* C2120 800D1920 00000000 */  nop
    /* C2124 800D1924 140002AE */  sw         $v0, 0x14($s0)
    /* C2128 800D1928 5C00628E */  lw         $v0, 0x5C($s3)
    /* C212C 800D192C 00000000 */  nop
    /* C2130 800D1930 200002AE */  sw         $v0, 0x20($s0)
    /* C2134 800D1934 5800628E */  lw         $v0, 0x58($s3)
    /* C2138 800D1938 5C460308 */  j          .L800D1970
    /* C213C 800D193C 2C0002AE */   sw        $v0, 0x2C($s0)
  .L800D1940:
    /* C2140 800D1940 9C00628C */  lw         $v0, (0x1F80009C & 0xFFFF)($v1)
    /* C2144 800D1944 00000000 */  nop
    /* C2148 800D1948 080002AE */  sw         $v0, 0x8($s0)
    /* C214C 800D194C 3800A28F */  lw         $v0, 0x38($sp)
    /* C2150 800D1950 00000000 */  nop
    /* C2154 800D1954 140002AE */  sw         $v0, 0x14($s0)
    /* C2158 800D1958 5800628C */  lw         $v0, (0x1F800058 & 0xFFFF)($v1)
    /* C215C 800D195C 00000000 */  nop
    /* C2160 800D1960 200002AE */  sw         $v0, 0x20($s0)
    /* C2164 800D1964 5C00628C */  lw         $v0, (0x1F80005C & 0xFFFF)($v1)
    /* C2168 800D1968 00000000 */  nop
    /* C216C 800D196C 2C0002AE */  sw         $v0, 0x2C($s0)
  .L800D1970:
    /* C2170 800D1970 04007326 */  addiu      $s3, $s3, %lo(D_1F800004)
    /* C2174 800D1974 04005226 */  addiu      $s2, $s2, 0x4
    /* C2178 800D1978 0400B526 */  addiu      $s5, $s5, 0x4
    /* C217C 800D197C 86450308 */  j          .L800D1618
    /* C2180 800D1980 01009426 */   addiu     $s4, $s4, 0x1
  .L800D1984:
    /* C2184 800D1984 1480023C */  lui        $v0, %hi(Night_gLightning)
    /* C2188 800D1988 64DA428C */  lw         $v0, %lo(Night_gLightning)($v0)
    /* C218C 800D198C 00000000 */  nop
    /* C2190 800D1990 09004010 */  beqz       $v0, .L800D19B8
    /* C2194 800D1994 1280023C */   lui       $v0, %hi(TrackSpec_gSpec)
    /* C2198 800D1998 1480023C */  lui        $v0, %hi(Night_gShowForks)
    /* C219C 800D199C 78DA4290 */  lbu        $v0, %lo(Night_gShowForks)($v0)
    /* C21A0 800D19A0 00000000 */  nop
    /* C21A4 800D19A4 04004010 */  beqz       $v0, .L800D19B8
    /* C21A8 800D19A8 1280023C */   lui       $v0, %hi(TrackSpec_gSpec)
    /* C21AC 800D19AC 9141030C */  jal        Hrz_BuildForkLightning__FP11Draw_DCache
    /* C21B0 800D19B0 801F043C */   lui       $a0, (0x1F800000 >> 16)
    /* C21B4 800D19B4 1280023C */  lui        $v0, %hi(TrackSpec_gSpec)
  .L800D19B8:
    /* C21B8 800D19B8 7C325124 */  addiu      $s1, $v0, %lo(TrackSpec_gSpec)
    /* C21BC 800D19BC 5C00228E */  lw         $v0, 0x5C($s1)
    /* C21C0 800D19C0 00000000 */  nop
    /* C21C4 800D19C4 08004230 */  andi       $v0, $v0, 0x8
    /* C21C8 800D19C8 0C004010 */  beqz       $v0, .L800D19FC
    /* C21CC 800D19CC 00000000 */   nop
    /* C21D0 800D19D0 2800B027 */  addiu      $s0, $sp, 0x28
    /* C21D4 800D19D4 21200002 */  addu       $a0, $s0, $zero
    /* C21D8 800D19D8 21280000 */  addu       $a1, $zero, $zero
    /* C21DC 800D19DC C690030C */  jal        memset
    /* C21E0 800D19E0 0C000624 */   addiu     $a2, $zero, 0xC
    /* C21E4 800D19E4 4742030C */  jal        HrzSetPsxTranslation__FP8coorddef
    /* C21E8 800D19E8 21200002 */   addu      $a0, $s0, $zero
    /* C21EC 800D19EC 1480043C */  lui        $a0, %hi(D_8013DDF8)
    /* C21F0 800D19F0 F8DD8424 */  addiu      $a0, $a0, %lo(D_8013DDF8)
    /* C21F4 800D19F4 2F3D030C */  jal        Flare_Moon__FP7SVECTORP15Draw_FlareCache
    /* C21F8 800D19F8 801F053C */   lui       $a1, (0x1F800000 >> 16)
  .L800D19FC:
    /* C21FC 800D19FC 5C00228E */  lw         $v0, 0x5C($s1)
    /* C2200 800D1A00 00000000 */  nop
    /* C2204 800D1A04 10004230 */  andi       $v0, $v0, 0x10
    /* C2208 800D1A08 05004010 */  beqz       $v0, .L800D1A20
    /* C220C 800D1A0C 801F043C */   lui       $a0, (0x1F800000 >> 16)
    /* C2210 800D1A10 1480053C */  lui        $a1, %hi(Draw_gViewOtSize)
    /* C2214 800D1A14 B0D7A58C */  lw         $a1, %lo(Draw_gViewOtSize)($a1)
    /* C2218 800D1A18 5844030C */  jal        Sky_RenderStars__FP13Draw_SkyCachei
    /* C221C 800D1A1C FEFFA524 */   addiu     $a1, $a1, -0x2
  .L800D1A20:
    /* C2220 800D1A20 06002286 */  lh         $v0, 0x6($s1)
    /* C2224 800D1A24 00000000 */  nop
    /* C2228 800D1A28 03004010 */  beqz       $v0, .L800D1A38
    /* C222C 800D1A2C 00000000 */   nop
    /* C2230 800D1A30 8E42030C */  jal        Hrz_BuildSky__Fv
    /* C2234 800D1A34 00000000 */   nop
  .L800D1A38:
    /* C2238 800D1A38 5000AA8F */  lw         $t2, 0x50($sp)
    /* C223C 800D1A3C 00000000 */  nop
    /* C2240 800D1A40 03004011 */  beqz       $t2, .L800D1A50
    /* C2244 800D1A44 00000000 */   nop
    /* C2248 800D1A48 E7AA030C */  jal        SetGeomScreen
    /* C224C 800D1A4C 21204001 */   addu      $a0, $t2, $zero
  .L800D1A50:
    /* C2250 800D1A50 7C00BF8F */  lw         $ra, 0x7C($sp)
    /* C2254 800D1A54 7800BE8F */  lw         $fp, 0x78($sp)
    /* C2258 800D1A58 7400B78F */  lw         $s7, 0x74($sp)
    /* C225C 800D1A5C 7000B68F */  lw         $s6, 0x70($sp)
    /* C2260 800D1A60 6C00B58F */  lw         $s5, 0x6C($sp)
    /* C2264 800D1A64 6800B48F */  lw         $s4, 0x68($sp)
    /* C2268 800D1A68 6400B38F */  lw         $s3, 0x64($sp)
    /* C226C 800D1A6C 6000B28F */  lw         $s2, 0x60($sp)
    /* C2270 800D1A70 5C00B18F */  lw         $s1, 0x5C($sp)
    /* C2274 800D1A74 5800B08F */  lw         $s0, 0x58($sp)
    /* C2278 800D1A78 0800E003 */  jr         $ra
    /* C227C 800D1A7C 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel Hrz_BuildHorizon__FP13DRender_tView
