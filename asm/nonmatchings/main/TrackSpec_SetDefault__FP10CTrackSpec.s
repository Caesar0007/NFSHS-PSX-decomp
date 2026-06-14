.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrackSpec_SetDefault__FP10CTrackSpec, 0x238

glabel TrackSpec_SetDefault__FP10CTrackSpec
    /* D1D44 800E1544 21288000 */  addu       $a1, $a0, $zero
    /* D1D48 800E1548 21300000 */  addu       $a2, $zero, $zero
    /* D1D4C 800E154C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* D1D50 800E1550 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* D1D54 800E1554 01000324 */  addiu      $v1, $zero, 0x1
    /* D1D58 800E1558 0000A0A4 */  sh         $zero, 0x0($a1)
    /* D1D5C 800E155C 48004494 */  lhu        $a0, 0x48($v0)
    /* D1D60 800E1560 17000724 */  addiu      $a3, $zero, 0x17
    /* D1D64 800E1564 0400A3A4 */  sh         $v1, 0x4($a1)
    /* D1D68 800E1568 0600A3A4 */  sh         $v1, 0x6($a1)
    /* D1D6C 800E156C 0200A4A4 */  sh         $a0, 0x2($a1)
    /* D1D70 800E1570 54004494 */  lhu        $a0, 0x54($v0)
    /* D1D74 800E1574 0100023C */  lui        $v0, (0x10000 >> 16)
    /* D1D78 800E1578 1000A2AC */  sw         $v0, 0x10($a1)
    /* D1D7C 800E157C 80000224 */  addiu      $v0, $zero, 0x80
    /* D1D80 800E1580 0A00A3A4 */  sh         $v1, 0xA($a1)
    /* D1D84 800E1584 C8000324 */  addiu      $v1, $zero, 0xC8
    /* D1D88 800E1588 1800A3AC */  sw         $v1, 0x18($a1)
    /* D1D8C 800E158C 08000324 */  addiu      $v1, $zero, 0x8
    /* D1D90 800E1590 1C00A3AC */  sw         $v1, 0x1C($a1)
    /* D1D94 800E1594 02000324 */  addiu      $v1, $zero, 0x2
    /* D1D98 800E1598 2400A3AC */  sw         $v1, 0x24($a1)
    /* D1D9C 800E159C 01000324 */  addiu      $v1, $zero, 0x1
    /* D1DA0 800E15A0 2800A3AC */  sw         $v1, 0x28($a1)
    /* D1DA4 800E15A4 80EF0324 */  addiu      $v1, $zero, -0x1080
    /* D1DA8 800E15A8 3000A3AC */  sw         $v1, 0x30($a1)
    /* D1DAC 800E15AC 004B0324 */  addiu      $v1, $zero, 0x4B00
    /* D1DB0 800E15B0 1400A2A0 */  sb         $v0, 0x14($a1)
    /* D1DB4 800E15B4 1500A2A0 */  sb         $v0, 0x15($a1)
    /* D1DB8 800E15B8 1600A2A0 */  sb         $v0, 0x16($a1)
    /* D1DBC 800E15BC 2000A0AC */  sw         $zero, 0x20($a1)
    /* D1DC0 800E15C0 2C00A0AC */  sw         $zero, 0x2C($a1)
    /* D1DC4 800E15C4 3400A3AC */  sw         $v1, 0x34($a1)
    /* D1DC8 800E15C8 3800A2A0 */  sb         $v0, 0x38($a1)
    /* D1DCC 800E15CC 3900A2A0 */  sb         $v0, 0x39($a1)
    /* D1DD0 800E15D0 3A00A2A0 */  sb         $v0, 0x3A($a1)
    /* D1DD4 800E15D4 3C00A2A0 */  sb         $v0, 0x3C($a1)
    /* D1DD8 800E15D8 3D00A2A0 */  sb         $v0, 0x3D($a1)
    /* D1DDC 800E15DC 3E00A2A0 */  sb         $v0, 0x3E($a1)
    /* D1DE0 800E15E0 4000A2A0 */  sb         $v0, 0x40($a1)
    /* D1DE4 800E15E4 4100A2A0 */  sb         $v0, 0x41($a1)
    /* D1DE8 800E15E8 4200A2A0 */  sb         $v0, 0x42($a1)
    /* D1DEC 800E15EC 4400A2A0 */  sb         $v0, 0x44($a1)
    /* D1DF0 800E15F0 4500A2A0 */  sb         $v0, 0x45($a1)
    /* D1DF4 800E15F4 4600A2A0 */  sb         $v0, 0x46($a1)
    /* D1DF8 800E15F8 0800A4A4 */  sh         $a0, 0x8($a1)
    /* D1DFC 800E15FC 0800C228 */  slti       $v0, $a2, 0x8
  .L800E1600:
    /* D1E00 800E1600 04004014 */  bnez       $v0, .L800E1614
    /* D1E04 800E1604 2118A600 */   addu      $v1, $a1, $a2
    /* D1E08 800E1608 2310E600 */  subu       $v0, $a3, $a2
    /* D1E0C 800E160C 86850308 */  j          .L800E1618
    /* D1E10 800E1610 480062A0 */   sb        $v0, 0x48($v1)
  .L800E1614:
    /* D1E14 800E1614 480066A0 */  sb         $a2, 0x48($v1)
  .L800E1618:
    /* D1E18 800E1618 0100C624 */  addiu      $a2, $a2, 0x1
    /* D1E1C 800E161C 1000C228 */  slti       $v0, $a2, 0x10
    /* D1E20 800E1620 F7FF4014 */  bnez       $v0, .L800E1600
    /* D1E24 800E1624 0800C228 */   slti      $v0, $a2, 0x8
    /* D1E28 800E1628 21300000 */  addu       $a2, $zero, $zero
    /* D1E2C 800E162C 32000824 */  addiu      $t0, $zero, 0x32
    /* D1E30 800E1630 46000924 */  addiu      $t1, $zero, 0x46
    /* D1E34 800E1634 2120A000 */  addu       $a0, $a1, $zero
    /* D1E38 800E1638 2138C000 */  addu       $a3, $a2, $zero
    /* D1E3C 800E163C 04000224 */  addiu      $v0, $zero, 0x4
    /* D1E40 800E1640 5800A0AC */  sw         $zero, 0x58($a1)
    /* D1E44 800E1644 5C00A2AC */  sw         $v0, 0x5C($a1)
  .L800E1648:
    /* D1E48 800E1648 21180000 */  addu       $v1, $zero, $zero
    /* D1E4C 800E164C 600088A0 */  sb         $t0, 0x60($a0)
    /* D1E50 800E1650 610088A0 */  sb         $t0, 0x61($a0)
    /* D1E54 800E1654 620089A0 */  sb         $t1, 0x62($a0)
    /* D1E58 800E1658 740088A0 */  sb         $t0, 0x74($a0)
    /* D1E5C 800E165C 750088A0 */  sb         $t0, 0x75($a0)
    /* D1E60 800E1660 760089A0 */  sb         $t1, 0x76($a0)
    /* D1E64 800E1664 21106700 */  addu       $v0, $v1, $a3
  .L800E1668:
    /* D1E68 800E1668 2110A200 */  addu       $v0, $a1, $v0
    /* D1E6C 800E166C C40040A0 */  sb         $zero, 0xC4($v0)
    /* D1E70 800E1670 01006324 */  addiu      $v1, $v1, 0x1
    /* D1E74 800E1674 04006228 */  slti       $v0, $v1, 0x4
    /* D1E78 800E1678 FBFF4014 */  bnez       $v0, .L800E1668
    /* D1E7C 800E167C 21106700 */   addu      $v0, $v1, $a3
    /* D1E80 800E1680 00130600 */  sll        $v0, $a2, 12
    /* D1E84 800E1684 D80082AC */  sw         $v0, 0xD8($a0)
    /* D1E88 800E1688 04008424 */  addiu      $a0, $a0, 0x4
    /* D1E8C 800E168C 0100C624 */  addiu      $a2, $a2, 0x1
    /* D1E90 800E1690 0500C228 */  slti       $v0, $a2, 0x5
    /* D1E94 800E1694 ECFF4014 */  bnez       $v0, .L800E1648
    /* D1E98 800E1698 0400E724 */   addiu     $a3, $a3, 0x4
    /* D1E9C 800E169C 08000424 */  addiu      $a0, $zero, 0x8
    /* D1EA0 800E16A0 10000324 */  addiu      $v1, $zero, 0x10
    /* D1EA4 800E16A4 B8E70224 */  addiu      $v0, $zero, -0x1848
    /* D1EA8 800E16A8 8C00A2AC */  sw         $v0, 0x8C($a1)
    /* D1EAC 800E16AC EE000224 */  addiu      $v0, $zero, 0xEE
    /* D1EB0 800E16B0 9000A2AC */  sw         $v0, 0x90($a1)
    /* D1EB4 800E16B4 9800A2AC */  sw         $v0, 0x98($a1)
    /* D1EB8 800E16B8 3C000224 */  addiu      $v0, $zero, 0x3C
    /* D1EBC 800E16BC 9C00A2AC */  sw         $v0, 0x9C($a1)
    /* D1EC0 800E16C0 A00F0224 */  addiu      $v0, $zero, 0xFA0
    /* D1EC4 800E16C4 A000A2AC */  sw         $v0, 0xA0($a1)
    /* D1EC8 800E16C8 10270224 */  addiu      $v0, $zero, 0x2710
    /* D1ECC 800E16CC A400A2AC */  sw         $v0, 0xA4($a1)
    /* D1ED0 800E16D0 40000224 */  addiu      $v0, $zero, 0x40
    /* D1ED4 800E16D4 A800A2AC */  sw         $v0, 0xA8($a1)
    /* D1ED8 800E16D8 C8000224 */  addiu      $v0, $zero, 0xC8
    /* D1EDC 800E16DC AC00A2AC */  sw         $v0, 0xAC($a1)
    /* D1EE0 800E16E0 FF000224 */  addiu      $v0, $zero, 0xFF
    /* D1EE4 800E16E4 B000A2A0 */  sb         $v0, 0xB0($a1)
    /* D1EE8 800E16E8 B100A2A0 */  sb         $v0, 0xB1($a1)
    /* D1EEC 800E16EC B200A2A0 */  sb         $v0, 0xB2($a1)
    /* D1EF0 800E16F0 39300224 */  addiu      $v0, $zero, 0x3039
    /* D1EF4 800E16F4 B400A2AC */  sw         $v0, 0xB4($a1)
    /* D1EF8 800E16F8 21000224 */  addiu      $v0, $zero, 0x21
    /* D1EFC 800E16FC B800A2A0 */  sb         $v0, 0xB8($a1)
    /* D1F00 800E1700 B900A2A0 */  sb         $v0, 0xB9($a1)
    /* D1F04 800E1704 19000224 */  addiu      $v0, $zero, 0x19
    /* D1F08 800E1708 BC00A2A0 */  sb         $v0, 0xBC($a1)
    /* D1F0C 800E170C 0A000224 */  addiu      $v0, $zero, 0xA
    /* D1F10 800E1710 8900A3A0 */  sb         $v1, 0x89($a1)
    /* D1F14 800E1714 BA00A3A0 */  sb         $v1, 0xBA($a1)
    /* D1F18 800E1718 ED00A3A0 */  sb         $v1, 0xED($a1)
    /* D1F1C 800E171C EE00A3A0 */  sb         $v1, 0xEE($a1)
    /* D1F20 800E1720 80000324 */  addiu      $v1, $zero, 0x80
    /* D1F24 800E1724 BD00A2A0 */  sb         $v0, 0xBD($a1)
    /* D1F28 800E1728 44000224 */  addiu      $v0, $zero, 0x44
    /* D1F2C 800E172C F400A2AC */  sw         $v0, 0xF4($a1)
    /* D1F30 800E1730 CC4C0224 */  addiu      $v0, $zero, 0x4CCC
    /* D1F34 800E1734 8800A4A0 */  sb         $a0, 0x88($a1)
    /* D1F38 800E1738 8A00A4A0 */  sb         $a0, 0x8A($a1)
    /* D1F3C 800E173C 9400A0AC */  sw         $zero, 0x94($a1)
    /* D1F40 800E1740 BE00A0A0 */  sb         $zero, 0xBE($a1)
    /* D1F44 800E1744 C000A0AC */  sw         $zero, 0xC0($a1)
    /* D1F48 800E1748 EC00A4A0 */  sb         $a0, 0xEC($a1)
    /* D1F4C 800E174C F000A3A0 */  sb         $v1, 0xF0($a1)
    /* D1F50 800E1750 F100A3A0 */  sb         $v1, 0xF1($a1)
    /* D1F54 800E1754 F200A3A0 */  sb         $v1, 0xF2($a1)
    /* D1F58 800E1758 0001A0A4 */  sh         $zero, 0x100($a1)
    /* D1F5C 800E175C 0201A0A4 */  sh         $zero, 0x102($a1)
    /* D1F60 800E1760 0401A0A4 */  sh         $zero, 0x104($a1)
    /* D1F64 800E1764 0601A0A4 */  sh         $zero, 0x106($a1)
    /* D1F68 800E1768 F800A2AC */  sw         $v0, 0xF8($a1)
    /* D1F6C 800E176C FC00A3A0 */  sb         $v1, 0xFC($a1)
    /* D1F70 800E1770 FD00A3A0 */  sb         $v1, 0xFD($a1)
    /* D1F74 800E1774 0800E003 */  jr         $ra
    /* D1F78 800E1778 FE00A3A0 */   sb        $v1, 0xFE($a1)
endlabel TrackSpec_SetDefault__FP10CTrackSpec
