.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache, 0x1D54

glabel DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
    /* B1D5C 800C155C B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* B1D60 800C1560 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* B1D64 800C1564 6400B18F */  lw         $s1, 0x64($sp)
    /* B1D68 800C1568 2800B0AF */  sw         $s0, 0x28($sp)
    /* B1D6C 800C156C 21808000 */  addu       $s0, $a0, $zero
    /* B1D70 800C1570 3800B4AF */  sw         $s4, 0x38($sp)
    /* B1D74 800C1574 21A0A000 */  addu       $s4, $a1, $zero
    /* B1D78 800C1578 4000B6AF */  sw         $s6, 0x40($sp)
    /* B1D7C 800C157C 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* B1D80 800C1580 4800BEAF */  sw         $fp, 0x48($sp)
    /* B1D84 800C1584 4400B7AF */  sw         $s7, 0x44($sp)
    /* B1D88 800C1588 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* B1D8C 800C158C 3400B3AF */  sw         $s3, 0x34($sp)
    /* B1D90 800C1590 3000B2AF */  sw         $s2, 0x30($sp)
    /* B1D94 800C1594 5800A6AF */  sw         $a2, 0x58($sp)
    /* B1D98 800C1598 6400228E */  lw         $v0, 0x64($s1)
    /* B1D9C 800C159C 1400D38C */  lw         $s3, 0x14($a2)
    /* B1DA0 800C15A0 09004014 */  bnez       $v0, .L800C15C8
    /* B1DA4 800C15A4 21B0E000 */   addu      $s6, $a3, $zero
    /* B1DA8 800C15A8 7400228E */  lw         $v0, 0x74($s1)
    /* B1DAC 800C15AC 00000000 */  nop
    /* B1DB0 800C15B0 05004014 */  bnez       $v0, .L800C15C8
    /* B1DB4 800C15B4 00000000 */   nop
    /* B1DB8 800C15B8 6000B98F */  lw         $t9, 0x60($sp)
    /* B1DBC 800C15BC 00000000 */  nop
    /* B1DC0 800C15C0 BE003933 */  andi       $t9, $t9, 0xBE
    /* B1DC4 800C15C4 6000B9AF */  sw         $t9, 0x60($sp)
  .L800C15C8:
    /* B1DC8 800C15C8 6000B98F */  lw         $t9, 0x60($sp)
    /* B1DCC 800C15CC 00000000 */  nop
    /* B1DD0 800C15D0 01002233 */  andi       $v0, $t9, 0x1
    /* B1DD4 800C15D4 39004010 */  beqz       $v0, .L800C16BC
    /* B1DD8 800C15D8 21386002 */   addu      $a3, $s3, $zero
    /* B1DDC 800C15DC 1280193C */  lui        $t9, %hi(DrawC_gMatA)
    /* B1DE0 800C15E0 E8F43927 */  addiu      $t9, $t9, %lo(DrawC_gMatA)
    /* B1DE4 800C15E4 00002C8F */  lw         $t4, 0x0($t9)
    /* B1DE8 800C15E8 04002D8F */  lw         $t5, 0x4($t9)
    /* B1DEC 800C15EC 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B1DF0 800C15F0 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B1DF4 800C15F4 08002C8F */  lw         $t4, 0x8($t9)
    /* B1DF8 800C15F8 0C002D8F */  lw         $t5, 0xC($t9)
    /* B1DFC 800C15FC 10002E8F */  lw         $t6, 0x10($t9)
    /* B1E00 800C1600 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B1E04 800C1604 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B1E08 800C1608 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B1E0C 800C160C 1280193C */  lui        $t9, %hi(DrawC_gMatA)
    /* B1E10 800C1610 E8F43927 */  addiu      $t9, $t9, %lo(DrawC_gMatA)
    /* B1E14 800C1614 14002C8F */  lw         $t4, 0x14($t9)
    /* B1E18 800C1618 18002D8F */  lw         $t5, 0x18($t9)
    /* B1E1C 800C161C 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B1E20 800C1620 1C002E8F */  lw         $t6, 0x1C($t9)
    /* B1E24 800C1624 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B1E28 800C1628 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B1E2C 800C162C FFFF0A24 */  addiu      $t2, $zero, -0x1
    /* B1E30 800C1630 AC002926 */  addiu      $t1, $s1, 0xAC
    /* B1E34 800C1634 9C002826 */  addiu      $t0, $s1, 0x9C
    /* B1E38 800C1638 D7002626 */  addiu      $a2, $s1, 0xD7
    /* B1E3C 800C163C 5800B98F */  lw         $t9, 0x58($sp)
    /* B1E40 800C1640 04006526 */  addiu      $a1, $s3, 0x4
    /* B1E44 800C1644 00003297 */  lhu        $s2, 0x0($t9)
  .L800C1648:
    /* B1E48 800C1648 00000000 */  nop
    /* B1E4C 800C164C FFFF5226 */  addiu      $s2, $s2, -0x1
    /* B1E50 800C1650 1A004A12 */  beq        $s2, $t2, .L800C16BC
    /* B1E54 800C1654 00000000 */   nop
    /* B1E58 800C1658 0000E294 */  lhu        $v0, 0x0($a3)
    /* B1E5C 800C165C FEFFA394 */  lhu        $v1, -0x2($a1)
    /* B1E60 800C1660 0000A494 */  lhu        $a0, 0x0($a1)
    /* B1E64 800C1664 AC0022A6 */  sh         $v0, 0xAC($s1)
    /* B1E68 800C1668 AE0023A6 */  sh         $v1, 0xAE($s1)
    /* B1E6C 800C166C B00024A6 */  sh         $a0, 0xB0($s1)
    /* B1E70 800C1670 000020C9 */  lwc2       $0, 0x0($t1)
    /* B1E74 800C1674 040021C9 */  lwc2       $1, 0x4($t1)
    /* B1E78 800C1678 00000000 */  nop
    /* B1E7C 800C167C 00000000 */  nop
    /* B1E80 800C1680 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B1E84 800C1684 000019E9 */  swc2       $25, 0x0($t0)
    /* B1E88 800C1688 04001AE9 */  swc2       $26, 0x4($t0) /* handwritten instruction */
    /* B1E8C 800C168C 08001BE9 */  swc2       $27, 0x8($t0) /* handwritten instruction */
    /* B1E90 800C1690 A400228E */  lw         $v0, 0xA4($s1)
    /* B1E94 800C1694 9C00238E */  lw         $v1, 0x9C($s1)
    /* B1E98 800C1698 02004104 */  bgez       $v0, .L800C16A4
    /* B1E9C 800C169C 00000000 */   nop
    /* B1EA0 800C16A0 23100200 */  negu       $v0, $v0
  .L800C16A4:
    /* B1EA4 800C16A4 0600A524 */  addiu      $a1, $a1, 0x6
    /* B1EA8 800C16A8 0600E724 */  addiu      $a3, $a3, 0x6
    /* B1EAC 800C16AC FFFFC3A0 */  sb         $v1, -0x1($a2)
    /* B1EB0 800C16B0 0000C2A0 */  sb         $v0, 0x0($a2)
    /* B1EB4 800C16B4 92050308 */  j          .L800C1648
    /* B1EB8 800C16B8 0800C624 */   addiu     $a2, $a2, 0x8
  .L800C16BC:
    /* B1EBC 800C16BC 4B86030C */  jal        TrsProj_SetTransPrecision__Fi
    /* B1EC0 800C16C0 08000424 */   addiu     $a0, $zero, 0x8
    /* B1EC4 800C16C4 0000028E */  lw         $v0, 0x0($s0)
    /* B1EC8 800C16C8 0C00038E */  lw         $v1, 0xC($s0)
    /* B1ECC 800C16CC 1800048E */  lw         $a0, 0x18($s0)
    /* B1ED0 800C16D0 03110200 */  sra        $v0, $v0, 4
    /* B1ED4 800C16D4 03190300 */  sra        $v1, $v1, 4
    /* B1ED8 800C16D8 03210400 */  sra        $a0, $a0, 4
    /* B1EDC 800C16DC 140022A6 */  sh         $v0, 0x14($s1)
    /* B1EE0 800C16E0 160023A6 */  sh         $v1, 0x16($s1)
    /* B1EE4 800C16E4 180024A6 */  sh         $a0, 0x18($s1)
    /* B1EE8 800C16E8 0400028E */  lw         $v0, 0x4($s0)
    /* B1EEC 800C16EC 1000038E */  lw         $v1, 0x10($s0)
    /* B1EF0 800C16F0 1C00048E */  lw         $a0, 0x1C($s0)
    /* B1EF4 800C16F4 03110200 */  sra        $v0, $v0, 4
    /* B1EF8 800C16F8 03190300 */  sra        $v1, $v1, 4
    /* B1EFC 800C16FC 03210400 */  sra        $a0, $a0, 4
    /* B1F00 800C1700 1A0022A6 */  sh         $v0, 0x1A($s1)
    /* B1F04 800C1704 1C0023A6 */  sh         $v1, 0x1C($s1)
    /* B1F08 800C1708 1E0024A6 */  sh         $a0, 0x1E($s1)
    /* B1F0C 800C170C 0800028E */  lw         $v0, 0x8($s0)
    /* B1F10 800C1710 1400038E */  lw         $v1, 0x14($s0)
    /* B1F14 800C1714 2000048E */  lw         $a0, 0x20($s0)
    /* B1F18 800C1718 03110200 */  sra        $v0, $v0, 4
    /* B1F1C 800C171C 03190300 */  sra        $v1, $v1, 4
    /* B1F20 800C1720 03210400 */  sra        $a0, $a0, 4
    /* B1F24 800C1724 200022A6 */  sh         $v0, 0x20($s1)
    /* B1F28 800C1728 220023A6 */  sh         $v1, 0x22($s1)
    /* B1F2C 800C172C 240024A6 */  sh         $a0, 0x24($s1)
    /* B1F30 800C1730 0000828E */  lw         $v0, 0x0($s4)
    /* B1F34 800C1734 1480033C */  lui        $v1, %hi(TrsProj_precision)
    /* B1F38 800C1738 9CDB638C */  lw         $v1, %lo(TrsProj_precision)($v1)
    /* B1F3C 800C173C 00000000 */  nop
    /* B1F40 800C1740 07106200 */  srav       $v0, $v0, $v1
    /* B1F44 800C1744 280022AE */  sw         $v0, 0x28($s1)
    /* B1F48 800C1748 0400828E */  lw         $v0, 0x4($s4)
    /* B1F4C 800C174C 00000000 */  nop
    /* B1F50 800C1750 07106200 */  srav       $v0, $v0, $v1
    /* B1F54 800C1754 2C0022AE */  sw         $v0, 0x2C($s1)
    /* B1F58 800C1758 0800828E */  lw         $v0, 0x8($s4)
    /* B1F5C 800C175C 00000000 */  nop
    /* B1F60 800C1760 07106200 */  srav       $v0, $v0, $v1
    /* B1F64 800C1764 4E86030C */  jal        TrsProj_ResetTransPrecision__Fv
    /* B1F68 800C1768 300022AE */   sw        $v0, 0x30($s1)
    /* B1F6C 800C176C 14002226 */  addiu      $v0, $s1, 0x14
    /* B1F70 800C1770 00004C8C */  lw         $t4, 0x0($v0)
    /* B1F74 800C1774 04004D8C */  lw         $t5, 0x4($v0)
    /* B1F78 800C1778 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B1F7C 800C177C 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B1F80 800C1780 08004C8C */  lw         $t4, 0x8($v0)
    /* B1F84 800C1784 0C004D8C */  lw         $t5, 0xC($v0)
    /* B1F88 800C1788 10004E8C */  lw         $t6, 0x10($v0)
    /* B1F8C 800C178C 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B1F90 800C1790 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B1F94 800C1794 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B1F98 800C1798 14004C8C */  lw         $t4, 0x14($v0)
    /* B1F9C 800C179C 18004D8C */  lw         $t5, 0x18($v0)
    /* B1FA0 800C17A0 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B1FA4 800C17A4 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B1FA8 800C17A8 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B1FAC 800C17AC 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B1FB0 800C17B0 D0002726 */  addiu      $a3, $s1, 0xD0
    /* B1FB4 800C17B4 FFFF0A24 */  addiu      $t2, $zero, -0x1
    /* B1FB8 800C17B8 9C002926 */  addiu      $t1, $s1, 0x9C
    /* B1FBC 800C17BC 5800B98F */  lw         $t9, 0x58($sp)
    /* B1FC0 800C17C0 D4002526 */  addiu      $a1, $s1, 0xD4
    /* B1FC4 800C17C4 1000288F */  lw         $t0, 0x10($t9)
    /* B1FC8 800C17C8 00003297 */  lhu        $s2, 0x0($t9)
    /* B1FCC 800C17CC 04000625 */  addiu      $a2, $t0, 0x4
  .L800C17D0:
    /* B1FD0 800C17D0 FFFF5226 */  addiu      $s2, $s2, -0x1
    /* B1FD4 800C17D4 1A004A12 */  beq        $s2, $t2, .L800C1840
    /* B1FD8 800C17D8 1280193C */   lui       $t9, %hi(DrawC_gScreenMat)
    /* B1FDC 800C17DC 00000295 */  lhu        $v0, 0x0($t0)
    /* B1FE0 800C17E0 FEFFC394 */  lhu        $v1, -0x2($a2)
    /* B1FE4 800C17E4 0000C494 */  lhu        $a0, 0x0($a2)
    /* B1FE8 800C17E8 0000E2A4 */  sh         $v0, 0x0($a3)
    /* B1FEC 800C17EC FEFFA3A4 */  sh         $v1, -0x2($a1)
    /* B1FF0 800C17F0 0000A4A4 */  sh         $a0, 0x0($a1)
    /* B1FF4 800C17F4 0000E0C8 */  lwc2       $0, 0x0($a3)
    /* B1FF8 800C17F8 0400E1C8 */  lwc2       $1, 0x4($a3)
    /* B1FFC 800C17FC 00000000 */  nop
    /* B2000 800C1800 00000000 */  nop
    /* B2004 800C1804 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B2008 800C1808 000039E9 */  swc2       $25, 0x0($t1)
    /* B200C 800C180C 04003AE9 */  swc2       $26, 0x4($t1) /* handwritten instruction */
    /* B2010 800C1810 08003BE9 */  swc2       $27, 0x8($t1) /* handwritten instruction */
    /* B2014 800C1814 0600C624 */  addiu      $a2, $a2, 0x6
    /* B2018 800C1818 9C00228E */  lw         $v0, 0x9C($s1)
    /* B201C 800C181C A000238E */  lw         $v1, 0xA0($s1)
    /* B2020 800C1820 A400248E */  lw         $a0, 0xA4($s1)
    /* B2024 800C1824 06000825 */  addiu      $t0, $t0, 0x6
    /* B2028 800C1828 0000E2A4 */  sh         $v0, 0x0($a3)
    /* B202C 800C182C FEFFA3A4 */  sh         $v1, -0x2($a1)
    /* B2030 800C1830 0000A4A4 */  sh         $a0, 0x0($a1)
    /* B2034 800C1834 0800A524 */  addiu      $a1, $a1, 0x8
    /* B2038 800C1838 F4050308 */  j          .L800C17D0
    /* B203C 800C183C 0800E724 */   addiu     $a3, $a3, 0x8
  .L800C1840:
    /* B2040 800C1840 C8F43927 */  addiu      $t9, $t9, %lo(DrawC_gScreenMat)
    /* B2044 800C1844 00002C8F */  lw         $t4, 0x0($t9)
    /* B2048 800C1848 04002D8F */  lw         $t5, 0x4($t9)
    /* B204C 800C184C 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B2050 800C1850 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B2054 800C1854 08002C8F */  lw         $t4, 0x8($t9)
    /* B2058 800C1858 0C002D8F */  lw         $t5, 0xC($t9)
    /* B205C 800C185C 10002E8F */  lw         $t6, 0x10($t9)
    /* B2060 800C1860 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B2064 800C1864 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B2068 800C1868 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B206C 800C186C 1280193C */  lui        $t9, %hi(DrawC_gScreenMat)
    /* B2070 800C1870 C8F43927 */  addiu      $t9, $t9, %lo(DrawC_gScreenMat)
    /* B2074 800C1874 14002C8F */  lw         $t4, 0x14($t9)
    /* B2078 800C1878 18002D8F */  lw         $t5, 0x18($t9)
    /* B207C 800C187C 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B2080 800C1880 1C002E8F */  lw         $t6, 0x1C($t9)
    /* B2084 800C1884 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B2088 800C1888 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B208C 800C188C 5800B98F */  lw         $t9, 0x58($sp)
    /* B2090 800C1890 00000000 */  nop
    /* B2094 800C1894 02003297 */  lhu        $s2, 0x2($t9)
    /* B2098 800C1898 6000B98F */  lw         $t9, 0x60($sp)
    /* B209C 800C189C 01000224 */  addiu      $v0, $zero, 0x1
    /* B20A0 800C18A0 09002333 */  andi       $v1, $t9, 0x9
    /* B20A4 800C18A4 D6016210 */  beq        $v1, $v0, .L800C2000
    /* B20A8 800C18A8 02006228 */   slti      $v0, $v1, 0x2
    /* B20AC 800C18AC 05004010 */  beqz       $v0, .L800C18C4
    /* B20B0 800C18B0 00000000 */   nop
    /* B20B4 800C18B4 0A006010 */  beqz       $v1, .L800C18E0
    /* B20B8 800C18B8 20002233 */   andi      $v0, $t9, 0x20
    /* B20BC 800C18BC A00C0308 */  j          .L800C3280
    /* B20C0 800C18C0 00000000 */   nop
  .L800C18C4:
    /* B20C4 800C18C4 08000224 */  addiu      $v0, $zero, 0x8
    /* B20C8 800C18C8 3C036210 */  beq        $v1, $v0, .L800C25BC
    /* B20CC 800C18CC 09000224 */   addiu     $v0, $zero, 0x9
    /* B20D0 800C18D0 73046210 */  beq        $v1, $v0, .L800C2AA0
    /* B20D4 800C18D4 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* B20D8 800C18D8 A00C0308 */  j          .L800C3280
    /* B20DC 800C18DC 00000000 */   nop
  .L800C18E0:
    /* B20E0 800C18E0 F3004014 */  bnez       $v0, .L800C1CB0
    /* B20E4 800C18E4 D0033926 */   addiu     $t9, $s1, 0x3D0
    /* B20E8 800C18E8 40101200 */  sll        $v0, $s2, 1
    /* B20EC 800C18EC 21105200 */  addu       $v0, $v0, $s2
    /* B20F0 800C18F0 80480200 */  sll        $t1, $v0, 2
  .L800C18F4:
    /* B20F4 800C18F4 FFFF5226 */  addiu      $s2, $s2, -0x1
  .L800C18F8:
    /* B20F8 800C18F8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B20FC 800C18FC 60064212 */  beq        $s2, $v0, .L800C3280
    /* B2100 800C1900 F4FF2925 */   addiu     $t1, $t1, -0xC
    /* B2104 800C1904 5800B98F */  lw         $t9, 0x58($sp)
    /* B2108 800C1908 00000000 */  nop
    /* B210C 800C190C 1800228F */  lw         $v0, 0x18($t9)
    /* B2110 800C1910 0800238E */  lw         $v1, 0x8($s1)
    /* B2114 800C1914 21404900 */  addu       $t0, $v0, $t1
    /* B2118 800C1918 03000691 */  lbu        $a2, 0x3($t0)
    /* B211C 800C191C 04000591 */  lbu        $a1, 0x4($t0)
    /* B2120 800C1920 0400228E */  lw         $v0, 0x4($s1)
    /* B2124 800C1924 05000491 */  lbu        $a0, 0x5($t0)
    /* B2128 800C1928 2B104300 */  sltu       $v0, $v0, $v1
    /* B212C 800C192C F2FF4010 */  beqz       $v0, .L800C18F8
    /* B2130 800C1930 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2134 800C1934 01005226 */  addiu      $s2, $s2, 0x1
    /* B2138 800C1938 C0300600 */  sll        $a2, $a2, 3
    /* B213C 800C193C 2130D100 */  addu       $a2, $a2, $s1
    /* B2140 800C1940 C0280500 */  sll        $a1, $a1, 3
    /* B2144 800C1944 2128B100 */  addu       $a1, $a1, $s1
    /* B2148 800C1948 C0200400 */  sll        $a0, $a0, 3
    /* B214C 800C194C 21209100 */  addu       $a0, $a0, $s1
    /* B2150 800C1950 D000C0C8 */  lwc2       $0, 0xD0($a2)
    /* B2154 800C1954 D400C1C8 */  lwc2       $1, 0xD4($a2)
    /* B2158 800C1958 D000A2C8 */  lwc2       $2, 0xD0($a1)
    /* B215C 800C195C D400A3C8 */  lwc2       $3, 0xD4($a1)
    /* B2160 800C1960 D00084C8 */  lwc2       $4, 0xD0($a0)
    /* B2164 800C1964 D40085C8 */  lwc2       $5, 0xD4($a0)
    /* B2168 800C1968 00000000 */  nop
    /* B216C 800C196C 00000000 */  nop
    /* B2170 800C1970 3000284A */  .word 0x4A280030  /* rtpt */
    /* B2174 800C1974 00000000 */  nop
    /* B2178 800C1978 00000000 */  nop
    /* B217C 800C197C 0600404B */  .word 0x4B400006  /* nclip */
    /* B2180 800C1980 440038EA */  swc2       $24, 0x44($s1)
    /* B2184 800C1984 0C00228E */  lw         $v0, 0xC($s1)
    /* B2188 800C1988 4400238E */  lw         $v1, 0x44($s1)
    /* B218C 800C198C 02004010 */  beqz       $v0, .L800C1998
    /* B2190 800C1990 00000000 */   nop
    /* B2194 800C1994 23180300 */  negu       $v1, $v1
  .L800C1998:
    /* B2198 800C1998 D7FF6018 */  blez       $v1, .L800C18F8
    /* B219C 800C199C FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B21A0 800C19A0 01005226 */  addiu      $s2, $s2, 0x1
    /* B21A4 800C19A4 C4002CEA */  swc2       $12, 0xC4($s1)
    /* B21A8 800C19A8 C8002DEA */  swc2       $13, 0xC8($s1)
    /* B21AC 800C19AC CC002EEA */  swc2       $14, 0xCC($s1)
    /* B21B0 800C19B0 D400CC94 */  lhu        $t4, 0xD4($a2)
    /* B21B4 800C19B4 D400AD94 */  lhu        $t5, 0xD4($a1)
    /* B21B8 800C19B8 D4008E94 */  lhu        $t6, 0xD4($a0)
    /* B21BC 800C19BC B0002CA6 */  sh         $t4, 0xB0($s1)
    /* B21C0 800C19C0 B8002DA6 */  sh         $t5, 0xB8($s1)
    /* B21C4 800C19C4 C0002EA6 */  sh         $t6, 0xC0($s1)
    /* B21C8 800C19C8 10002386 */  lh         $v1, 0x10($s1)
    /* B21CC 800C19CC C4002286 */  lh         $v0, 0xC4($s1)
    /* B21D0 800C19D0 12002486 */  lh         $a0, 0x12($s1)
    /* B21D4 800C19D4 2A106200 */  slt        $v0, $v1, $v0
    /* B21D8 800C19D8 0C004010 */  beqz       $v0, .L800C1A0C
    /* B21DC 800C19DC 00000000 */   nop
    /* B21E0 800C19E0 C8002286 */  lh         $v0, 0xC8($s1)
    /* B21E4 800C19E4 00000000 */  nop
    /* B21E8 800C19E8 2A106200 */  slt        $v0, $v1, $v0
    /* B21EC 800C19EC 07004010 */  beqz       $v0, .L800C1A0C
    /* B21F0 800C19F0 00000000 */   nop
    /* B21F4 800C19F4 CC002286 */  lh         $v0, 0xCC($s1)
    /* B21F8 800C19F8 00000000 */  nop
    /* B21FC 800C19FC 2A106200 */  slt        $v0, $v1, $v0
    /* B2200 800C1A00 BDFF4014 */  bnez       $v0, .L800C18F8
    /* B2204 800C1A04 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2208 800C1A08 01005226 */  addiu      $s2, $s2, 0x1
  .L800C1A0C:
    /* B220C 800C1A0C C4002286 */  lh         $v0, 0xC4($s1)
    /* B2210 800C1A10 00000000 */  nop
    /* B2214 800C1A14 0A004104 */  bgez       $v0, .L800C1A40
    /* B2218 800C1A18 00000000 */   nop
    /* B221C 800C1A1C C8002286 */  lh         $v0, 0xC8($s1)
    /* B2220 800C1A20 00000000 */  nop
    /* B2224 800C1A24 06004104 */  bgez       $v0, .L800C1A40
    /* B2228 800C1A28 00000000 */   nop
    /* B222C 800C1A2C CC002286 */  lh         $v0, 0xCC($s1)
    /* B2230 800C1A30 00000000 */  nop
    /* B2234 800C1A34 B0FF4004 */  bltz       $v0, .L800C18F8
    /* B2238 800C1A38 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B223C 800C1A3C 01005226 */  addiu      $s2, $s2, 0x1
  .L800C1A40:
    /* B2240 800C1A40 C6002286 */  lh         $v0, 0xC6($s1)
    /* B2244 800C1A44 00000000 */  nop
    /* B2248 800C1A48 2A108200 */  slt        $v0, $a0, $v0
    /* B224C 800C1A4C 0C004010 */  beqz       $v0, .L800C1A80
    /* B2250 800C1A50 00000000 */   nop
    /* B2254 800C1A54 CA002286 */  lh         $v0, 0xCA($s1)
    /* B2258 800C1A58 00000000 */  nop
    /* B225C 800C1A5C 2A108200 */  slt        $v0, $a0, $v0
    /* B2260 800C1A60 07004010 */  beqz       $v0, .L800C1A80
    /* B2264 800C1A64 00000000 */   nop
    /* B2268 800C1A68 CE002286 */  lh         $v0, 0xCE($s1)
    /* B226C 800C1A6C 00000000 */  nop
    /* B2270 800C1A70 2A108200 */  slt        $v0, $a0, $v0
    /* B2274 800C1A74 A0FF4014 */  bnez       $v0, .L800C18F8
    /* B2278 800C1A78 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B227C 800C1A7C 01005226 */  addiu      $s2, $s2, 0x1
  .L800C1A80:
    /* B2280 800C1A80 C6002286 */  lh         $v0, 0xC6($s1)
    /* B2284 800C1A84 00000000 */  nop
    /* B2288 800C1A88 0A004104 */  bgez       $v0, .L800C1AB4
    /* B228C 800C1A8C 00000000 */   nop
    /* B2290 800C1A90 CA002286 */  lh         $v0, 0xCA($s1)
    /* B2294 800C1A94 00000000 */  nop
    /* B2298 800C1A98 06004104 */  bgez       $v0, .L800C1AB4
    /* B229C 800C1A9C 00000000 */   nop
    /* B22A0 800C1AA0 CE002286 */  lh         $v0, 0xCE($s1)
    /* B22A4 800C1AA4 00000000 */  nop
    /* B22A8 800C1AA8 93FF4004 */  bltz       $v0, .L800C18F8
    /* B22AC 800C1AAC FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B22B0 800C1AB0 01005226 */  addiu      $s2, $s2, 0x1
  .L800C1AB4:
    /* B22B4 800C1AB4 B0002286 */  lh         $v0, 0xB0($s1)
    /* B22B8 800C1AB8 00000000 */  nop
    /* B22BC 800C1ABC 0A004104 */  bgez       $v0, .L800C1AE8
    /* B22C0 800C1AC0 00000000 */   nop
    /* B22C4 800C1AC4 B8002286 */  lh         $v0, 0xB8($s1)
    /* B22C8 800C1AC8 00000000 */  nop
    /* B22CC 800C1ACC 06004104 */  bgez       $v0, .L800C1AE8
    /* B22D0 800C1AD0 00000000 */   nop
    /* B22D4 800C1AD4 C0002286 */  lh         $v0, 0xC0($s1)
    /* B22D8 800C1AD8 00000000 */  nop
    /* B22DC 800C1ADC 86FF4004 */  bltz       $v0, .L800C18F8
    /* B22E0 800C1AE0 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B22E4 800C1AE4 01005226 */  addiu      $s2, $s2, 0x1
  .L800C1AE8:
    /* B22E8 800C1AE8 00000000 */  nop
    /* B22EC 800C1AEC 00000000 */  nop
    /* B22F0 800C1AF0 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B22F4 800C1AF4 3C0027EA */  swc2       $7, 0x3C($s1)
    /* B22F8 800C1AF8 3C00238E */  lw         $v1, 0x3C($s1)
    /* B22FC 800C1AFC 4000228E */  lw         $v0, 0x40($s1)
    /* B2300 800C1B00 00000000 */  nop
    /* B2304 800C1B04 21186200 */  addu       $v1, $v1, $v0
    /* B2308 800C1B08 7AFF6004 */  bltz       $v1, .L800C18F4
    /* B230C 800C1B0C 3C0023AE */   sw        $v1, 0x3C($s1)
    /* B2310 800C1B10 8800228E */  lw         $v0, 0x88($s1)
    /* B2314 800C1B14 00000000 */  nop
    /* B2318 800C1B18 2A104300 */  slt        $v0, $v0, $v1
    /* B231C 800C1B1C 76FF4014 */  bnez       $v0, .L800C18F8
    /* B2320 800C1B20 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2324 800C1B24 01005226 */  addiu      $s2, $s2, 0x1
    /* B2328 800C1B28 0400278E */  lw         $a3, 0x4($s1)
    /* B232C 800C1B2C 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B2330 800C1B30 38002D8E */  lw         $t5, 0x38($s1)
    /* B2334 800C1B34 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B2338 800C1B38 80600C00 */  sll        $t4, $t4, 2
    /* B233C 800C1B3C 2168AC01 */  addu       $t5, $t5, $t4
    /* B2340 800C1B40 04002EAE */  sw         $t6, 0x4($s1)
    /* B2344 800C1B44 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B2348 800C1B48 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B234C 800C1B4C 02720E00 */  srl        $t6, $t6, 8
    /* B2350 800C1B50 2570CC01 */  or         $t6, $t6, $t4
    /* B2354 800C1B54 00620700 */  sll        $t4, $a3, 8
    /* B2358 800C1B58 0000EEAC */  sw         $t6, 0x0($a3)
    /* B235C 800C1B5C 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B2360 800C1B60 CC00248E */  lw         $a0, 0xCC($s1)
    /* B2364 800C1B64 C400228E */  lw         $v0, 0xC4($s1)
    /* B2368 800C1B68 C800238E */  lw         $v1, 0xC8($s1)
    /* B236C 800C1B6C 1800E4AC */  sw         $a0, 0x18($a3)
    /* B2370 800C1B70 0800E2AC */  sw         $v0, 0x8($a3)
    /* B2374 800C1B74 1000E3AC */  sw         $v1, 0x10($a3)
    /* B2378 800C1B78 00000295 */  lhu        $v0, 0x0($t0)
    /* B237C 800C1B7C 8C00238E */  lw         $v1, 0x8C($s1)
    /* B2380 800C1B80 01004230 */  andi       $v0, $v0, 0x1
    /* B2384 800C1B84 02004010 */  beqz       $v0, .L800C1B90
    /* B2388 800C1B88 24000424 */   addiu     $a0, $zero, 0x24
    /* B238C 800C1B8C 26000424 */  addiu      $a0, $zero, 0x26
  .L800C1B90:
    /* B2390 800C1B90 0400E3AC */  sw         $v1, 0x4($a3)
    /* B2394 800C1B94 0700E4A0 */  sb         $a0, 0x7($a3)
    /* B2398 800C1B98 6000B98F */  lw         $t9, 0x60($sp)
    /* B239C 800C1B9C 00000000 */  nop
    /* B23A0 800C1BA0 02002233 */  andi       $v0, $t9, 0x2
    /* B23A4 800C1BA4 11004010 */  beqz       $v0, .L800C1BEC
    /* B23A8 800C1BA8 00000000 */   nop
    /* B23AC 800C1BAC 00000295 */  lhu        $v0, 0x0($t0)
    /* B23B0 800C1BB0 00000000 */  nop
    /* B23B4 800C1BB4 01004230 */  andi       $v0, $v0, 0x1
    /* B23B8 800C1BB8 0C004014 */  bnez       $v0, .L800C1BEC
    /* B23BC 800C1BBC 00000000 */   nop
    /* B23C0 800C1BC0 02000291 */  lbu        $v0, 0x2($t0)
    /* B23C4 800C1BC4 6000238E */  lw         $v1, 0x60($s1)
    /* B23C8 800C1BC8 EE032592 */  lbu        $a1, 0x3EE($s1)
    /* B23CC 800C1BCC EF032692 */  lbu        $a2, 0x3EF($s1)
    /* B23D0 800C1BD0 00110200 */  sll        $v0, $v0, 4
    /* B23D4 800C1BD4 21186200 */  addu       $v1, $v1, $v0
    /* B23D8 800C1BD8 02006494 */  lhu        $a0, 0x2($v1)
    /* B23DC 800C1BDC 06006294 */  lhu        $v0, 0x6($v1)
    /* B23E0 800C1BE0 0E00E4A4 */  sh         $a0, 0xE($a3)
    /* B23E4 800C1BE4 0E070308 */  j          .L800C1C38
    /* B23E8 800C1BE8 1600E2A4 */   sh        $v0, 0x16($a3)
  .L800C1BEC:
    /* B23EC 800C1BEC 02000291 */  lbu        $v0, 0x2($t0)
    /* B23F0 800C1BF0 6000238E */  lw         $v1, 0x60($s1)
    /* B23F4 800C1BF4 00110200 */  sll        $v0, $v0, 4
    /* B23F8 800C1BF8 21186200 */  addu       $v1, $v1, $v0
    /* B23FC 800C1BFC 0E006494 */  lhu        $a0, 0xE($v1)
    /* B2400 800C1C00 00000000 */  nop
    /* B2404 800C1C04 7F008230 */  andi       $v0, $a0, 0x7F
    /* B2408 800C1C08 1E004010 */  beqz       $v0, .L800C1C84
    /* B240C 800C1C0C 02008230 */   andi      $v0, $a0, 0x2
    /* B2410 800C1C10 F6032592 */  lbu        $a1, 0x3F6($s1)
    /* B2414 800C1C14 F7032692 */  lbu        $a2, 0x3F7($s1)
    /* B2418 800C1C18 03004010 */  beqz       $v0, .L800C1C28
    /* B241C 800C1C1C 00000000 */   nop
    /* B2420 800C1C20 FE032592 */  lbu        $a1, 0x3FE($s1)
    /* B2424 800C1C24 FF032692 */  lbu        $a2, 0x3FF($s1)
  .L800C1C28:
    /* B2428 800C1C28 02006294 */  lhu        $v0, 0x2($v1)
    /* B242C 800C1C2C 06006394 */  lhu        $v1, 0x6($v1)
    /* B2430 800C1C30 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B2434 800C1C34 1600E3A4 */  sh         $v1, 0x16($a3)
  .L800C1C38:
    /* B2438 800C1C38 06000291 */  lbu        $v0, 0x6($t0)
    /* B243C 800C1C3C 08000391 */  lbu        $v1, 0x8($t0)
    /* B2440 800C1C40 0A000491 */  lbu        $a0, 0xA($t0)
    /* B2444 800C1C44 21104500 */  addu       $v0, $v0, $a1
    /* B2448 800C1C48 21186500 */  addu       $v1, $v1, $a1
    /* B244C 800C1C4C 21208500 */  addu       $a0, $a0, $a1
    /* B2450 800C1C50 0C00E2A0 */  sb         $v0, 0xC($a3)
    /* B2454 800C1C54 1400E3A0 */  sb         $v1, 0x14($a3)
    /* B2458 800C1C58 1C00E4A0 */  sb         $a0, 0x1C($a3)
    /* B245C 800C1C5C 07000291 */  lbu        $v0, 0x7($t0)
    /* B2460 800C1C60 09000391 */  lbu        $v1, 0x9($t0)
    /* B2464 800C1C64 0B000491 */  lbu        $a0, 0xB($t0)
    /* B2468 800C1C68 21104600 */  addu       $v0, $v0, $a2
    /* B246C 800C1C6C 21186600 */  addu       $v1, $v1, $a2
    /* B2470 800C1C70 21208600 */  addu       $a0, $a0, $a2
    /* B2474 800C1C74 0D00E2A0 */  sb         $v0, 0xD($a3)
    /* B2478 800C1C78 1500E3A0 */  sb         $v1, 0x15($a3)
    /* B247C 800C1C7C 3D060308 */  j          .L800C18F4
    /* B2480 800C1C80 1D00E4A0 */   sb        $a0, 0x1D($a3)
  .L800C1C84:
    /* B2484 800C1C84 02006294 */  lhu        $v0, 0x2($v1)
    /* B2488 800C1C88 06006394 */  lhu        $v1, 0x6($v1)
    /* B248C 800C1C8C 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B2490 800C1C90 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B2494 800C1C94 06000295 */  lhu        $v0, 0x6($t0)
    /* B2498 800C1C98 08000395 */  lhu        $v1, 0x8($t0)
    /* B249C 800C1C9C 0A000495 */  lhu        $a0, 0xA($t0)
    /* B24A0 800C1CA0 0C00E2A4 */  sh         $v0, 0xC($a3)
    /* B24A4 800C1CA4 1400E3A4 */  sh         $v1, 0x14($a3)
    /* B24A8 800C1CA8 3D060308 */  j          .L800C18F4
    /* B24AC 800C1CAC 1C00E4A4 */   sh        $a0, 0x1C($a3)
  .L800C1CB0:
    /* B24B0 800C1CB0 2000B9AF */  sw         $t9, 0x20($sp)
    /* B24B4 800C1CB4 E0033E26 */  addiu      $fp, $s1, 0x3E0
    /* B24B8 800C1CB8 D6033726 */  addiu      $s7, $s1, 0x3D6
    /* B24BC 800C1CBC E6033626 */  addiu      $s6, $s1, 0x3E6
    /* B24C0 800C1CC0 D8033526 */  addiu      $s5, $s1, 0x3D8
    /* B24C4 800C1CC4 DE033426 */  addiu      $s4, $s1, 0x3DE
    /* B24C8 800C1CC8 40101200 */  sll        $v0, $s2, 1
    /* B24CC 800C1CCC 21105200 */  addu       $v0, $v0, $s2
    /* B24D0 800C1CD0 80980200 */  sll        $s3, $v0, 2
    /* B24D4 800C1CD4 FFFF5226 */  addiu      $s2, $s2, -0x1
  .L800C1CD8:
    /* B24D8 800C1CD8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B24DC 800C1CDC 68054212 */  beq        $s2, $v0, .L800C3280
    /* B24E0 800C1CE0 F4FF7326 */   addiu     $s3, $s3, -0xC
    /* B24E4 800C1CE4 5800B98F */  lw         $t9, 0x58($sp)
    /* B24E8 800C1CE8 00000000 */  nop
    /* B24EC 800C1CEC 1800278F */  lw         $a3, 0x18($t9)
    /* B24F0 800C1CF0 00000000 */  nop
    /* B24F4 800C1CF4 2138F300 */  addu       $a3, $a3, $s3
    /* B24F8 800C1CF8 0300E290 */  lbu        $v0, 0x3($a3)
    /* B24FC 800C1CFC 0400E390 */  lbu        $v1, 0x4($a3)
    /* B2500 800C1D00 0500E490 */  lbu        $a0, 0x5($a3)
    /* B2504 800C1D04 0200E890 */  lbu        $t0, 0x2($a3)
    /* B2508 800C1D08 C0100200 */  sll        $v0, $v0, 3
    /* B250C 800C1D0C D0004224 */  addiu      $v0, $v0, 0xD0
    /* B2510 800C1D10 21102202 */  addu       $v0, $s1, $v0
    /* B2514 800C1D14 C0180300 */  sll        $v1, $v1, 3
    /* B2518 800C1D18 D0006324 */  addiu      $v1, $v1, 0xD0
    /* B251C 800C1D1C 21182302 */  addu       $v1, $s1, $v1
    /* B2520 800C1D20 C0200400 */  sll        $a0, $a0, 3
    /* B2524 800C1D24 00004694 */  lhu        $a2, 0x0($v0)
    /* B2528 800C1D28 02004594 */  lhu        $a1, 0x2($v0)
    /* B252C 800C1D2C 04004294 */  lhu        $v0, 0x4($v0)
    /* B2530 800C1D30 D0008424 */  addiu      $a0, $a0, 0xD0
    /* B2534 800C1D34 AC0026A6 */  sh         $a2, 0xAC($s1)
    /* B2538 800C1D38 AE0025A6 */  sh         $a1, 0xAE($s1)
    /* B253C 800C1D3C B00022A6 */  sh         $v0, 0xB0($s1)
    /* B2540 800C1D40 00006294 */  lhu        $v0, 0x0($v1)
    /* B2544 800C1D44 02006594 */  lhu        $a1, 0x2($v1)
    /* B2548 800C1D48 04006394 */  lhu        $v1, 0x4($v1)
    /* B254C 800C1D4C 21202402 */  addu       $a0, $s1, $a0
    /* B2550 800C1D50 B40022A6 */  sh         $v0, 0xB4($s1)
    /* B2554 800C1D54 B60025A6 */  sh         $a1, 0xB6($s1)
    /* B2558 800C1D58 B80023A6 */  sh         $v1, 0xB8($s1)
    /* B255C 800C1D5C 00008594 */  lhu        $a1, 0x0($a0)
    /* B2560 800C1D60 02008694 */  lhu        $a2, 0x2($a0)
    /* B2564 800C1D64 AC002386 */  lh         $v1, 0xAC($s1)
    /* B2568 800C1D68 B4002286 */  lh         $v0, 0xB4($s1)
    /* B256C 800C1D6C 04008494 */  lhu        $a0, 0x4($a0)
    /* B2570 800C1D70 21186200 */  addu       $v1, $v1, $v0
    /* B2574 800C1D74 AE002286 */  lh         $v0, 0xAE($s1)
    /* B2578 800C1D78 01006324 */  addiu      $v1, $v1, 0x1
    /* B257C 800C1D7C C00024A6 */  sh         $a0, 0xC0($s1)
    /* B2580 800C1D80 B6002486 */  lh         $a0, 0xB6($s1)
    /* B2584 800C1D84 43180300 */  sra        $v1, $v1, 1
    /* B2588 800C1D88 D00323A6 */  sh         $v1, 0x3D0($s1)
    /* B258C 800C1D8C B0002386 */  lh         $v1, 0xB0($s1)
    /* B2590 800C1D90 BC0025A6 */  sh         $a1, 0xBC($s1)
    /* B2594 800C1D94 BE0026A6 */  sh         $a2, 0xBE($s1)
    /* B2598 800C1D98 21104400 */  addu       $v0, $v0, $a0
    /* B259C 800C1D9C 01004224 */  addiu      $v0, $v0, 0x1
    /* B25A0 800C1DA0 B8002486 */  lh         $a0, 0xB8($s1)
    /* B25A4 800C1DA4 43100200 */  sra        $v0, $v0, 1
    /* B25A8 800C1DA8 D20322A6 */  sh         $v0, 0x3D2($s1)
    /* B25AC 800C1DAC B4002286 */  lh         $v0, 0xB4($s1)
    /* B25B0 800C1DB0 21186400 */  addu       $v1, $v1, $a0
    /* B25B4 800C1DB4 01006324 */  addiu      $v1, $v1, 0x1
    /* B25B8 800C1DB8 BC002486 */  lh         $a0, 0xBC($s1)
    /* B25BC 800C1DBC 43180300 */  sra        $v1, $v1, 1
    /* B25C0 800C1DC0 D40323A6 */  sh         $v1, 0x3D4($s1)
    /* B25C4 800C1DC4 6000258E */  lw         $a1, 0x60($s1)
    /* B25C8 800C1DC8 21104400 */  addu       $v0, $v0, $a0
    /* B25CC 800C1DCC 01004224 */  addiu      $v0, $v0, 0x1
    /* B25D0 800C1DD0 43100200 */  sra        $v0, $v0, 1
    /* B25D4 800C1DD4 D80322A6 */  sh         $v0, 0x3D8($s1)
    /* B25D8 800C1DD8 B6002286 */  lh         $v0, 0xB6($s1)
    /* B25DC 800C1DDC BE002386 */  lh         $v1, 0xBE($s1)
    /* B25E0 800C1DE0 C0002486 */  lh         $a0, 0xC0($s1)
    /* B25E4 800C1DE4 21104300 */  addu       $v0, $v0, $v1
    /* B25E8 800C1DE8 01004224 */  addiu      $v0, $v0, 0x1
    /* B25EC 800C1DEC B8002386 */  lh         $v1, 0xB8($s1)
    /* B25F0 800C1DF0 43100200 */  sra        $v0, $v0, 1
    /* B25F4 800C1DF4 DA0322A6 */  sh         $v0, 0x3DA($s1)
    /* B25F8 800C1DF8 BC002286 */  lh         $v0, 0xBC($s1)
    /* B25FC 800C1DFC 21186400 */  addu       $v1, $v1, $a0
    /* B2600 800C1E00 01006324 */  addiu      $v1, $v1, 0x1
    /* B2604 800C1E04 AC002486 */  lh         $a0, 0xAC($s1)
    /* B2608 800C1E08 43180300 */  sra        $v1, $v1, 1
    /* B260C 800C1E0C DC0323A6 */  sh         $v1, 0x3DC($s1)
    /* B2610 800C1E10 BE002386 */  lh         $v1, 0xBE($s1)
    /* B2614 800C1E14 21104400 */  addu       $v0, $v0, $a0
    /* B2618 800C1E18 01004224 */  addiu      $v0, $v0, 0x1
    /* B261C 800C1E1C AE002486 */  lh         $a0, 0xAE($s1)
    /* B2620 800C1E20 43100200 */  sra        $v0, $v0, 1
    /* B2624 800C1E24 E00322A6 */  sh         $v0, 0x3E0($s1)
    /* B2628 800C1E28 C0002286 */  lh         $v0, 0xC0($s1)
    /* B262C 800C1E2C 21186400 */  addu       $v1, $v1, $a0
    /* B2630 800C1E30 01006324 */  addiu      $v1, $v1, 0x1
    /* B2634 800C1E34 B0002486 */  lh         $a0, 0xB0($s1)
    /* B2638 800C1E38 43180300 */  sra        $v1, $v1, 1
    /* B263C 800C1E3C E20323A6 */  sh         $v1, 0x3E2($s1)
    /* B2640 800C1E40 21104400 */  addu       $v0, $v0, $a0
    /* B2644 800C1E44 01004224 */  addiu      $v0, $v0, 0x1
    /* B2648 800C1E48 43100200 */  sra        $v0, $v0, 1
    /* B264C 800C1E4C E40322A6 */  sh         $v0, 0x3E4($s1)
    /* B2650 800C1E50 0600E294 */  lhu        $v0, 0x6($a3)
    /* B2654 800C1E54 0800E394 */  lhu        $v1, 0x8($a3)
    /* B2658 800C1E58 0A00E494 */  lhu        $a0, 0xA($a3)
    /* B265C 800C1E5C 00410800 */  sll        $t0, $t0, 4
    /* B2660 800C1E60 B20022A6 */  sh         $v0, 0xB2($s1)
    /* B2664 800C1E64 BA0023A6 */  sh         $v1, 0xBA($s1)
    /* B2668 800C1E68 C20024A6 */  sh         $a0, 0xC2($s1)
    /* B266C 800C1E6C 6000B98F */  lw         $t9, 0x60($sp)
    /* B2670 800C1E70 00000000 */  nop
    /* B2674 800C1E74 02002233 */  andi       $v0, $t9, 0x2
    /* B2678 800C1E78 15004010 */  beqz       $v0, .L800C1ED0
    /* B267C 800C1E7C 2180A800 */   addu      $s0, $a1, $t0
    /* B2680 800C1E80 EE032492 */  lbu        $a0, 0x3EE($s1)
    /* B2684 800C1E84 EF032592 */  lbu        $a1, 0x3EF($s1)
    /* B2688 800C1E88 B2002292 */  lbu        $v0, 0xB2($s1)
    /* B268C 800C1E8C B3002392 */  lbu        $v1, 0xB3($s1)
    /* B2690 800C1E90 21104400 */  addu       $v0, $v0, $a0
    /* B2694 800C1E94 B20022A2 */  sb         $v0, 0xB2($s1)
    /* B2698 800C1E98 BA002292 */  lbu        $v0, 0xBA($s1)
    /* B269C 800C1E9C 21186500 */  addu       $v1, $v1, $a1
    /* B26A0 800C1EA0 B30023A2 */  sb         $v1, 0xB3($s1)
    /* B26A4 800C1EA4 BB002392 */  lbu        $v1, 0xBB($s1)
    /* B26A8 800C1EA8 21104400 */  addu       $v0, $v0, $a0
    /* B26AC 800C1EAC BA0022A2 */  sb         $v0, 0xBA($s1)
    /* B26B0 800C1EB0 C2002292 */  lbu        $v0, 0xC2($s1)
    /* B26B4 800C1EB4 21186500 */  addu       $v1, $v1, $a1
    /* B26B8 800C1EB8 BB0023A2 */  sb         $v1, 0xBB($s1)
    /* B26BC 800C1EBC C3002392 */  lbu        $v1, 0xC3($s1)
    /* B26C0 800C1EC0 21104400 */  addu       $v0, $v0, $a0
    /* B26C4 800C1EC4 21186500 */  addu       $v1, $v1, $a1
    /* B26C8 800C1EC8 C20022A2 */  sb         $v0, 0xC2($s1)
    /* B26CC 800C1ECC C30023A2 */  sb         $v1, 0xC3($s1)
  .L800C1ED0:
    /* B26D0 800C1ED0 AC002426 */  addiu      $a0, $s1, 0xAC
    /* B26D4 800C1ED4 2130C003 */  addu       $a2, $fp, $zero
    /* B26D8 800C1ED8 B2002726 */  addiu      $a3, $s1, 0xB2
    /* B26DC 800C1EDC 2000A58F */  lw         $a1, 0x20($sp)
    /* B26E0 800C1EE0 B2002292 */  lbu        $v0, 0xB2($s1)
    /* B26E4 800C1EE4 BA002392 */  lbu        $v1, 0xBA($s1)
    /* B26E8 800C1EE8 BB002892 */  lbu        $t0, 0xBB($s1)
    /* B26EC 800C1EEC 21104300 */  addu       $v0, $v0, $v1
    /* B26F0 800C1EF0 01004224 */  addiu      $v0, $v0, 0x1
    /* B26F4 800C1EF4 B3002392 */  lbu        $v1, 0xB3($s1)
    /* B26F8 800C1EF8 43100200 */  sra        $v0, $v0, 1
    /* B26FC 800C1EFC D60322A2 */  sb         $v0, 0x3D6($s1)
    /* B2700 800C1F00 BA002292 */  lbu        $v0, 0xBA($s1)
    /* B2704 800C1F04 21186800 */  addu       $v1, $v1, $t0
    /* B2708 800C1F08 01006324 */  addiu      $v1, $v1, 0x1
    /* B270C 800C1F0C C2002892 */  lbu        $t0, 0xC2($s1)
    /* B2710 800C1F10 43180300 */  sra        $v1, $v1, 1
    /* B2714 800C1F14 D70323A2 */  sb         $v1, 0x3D7($s1)
    /* B2718 800C1F18 BB002392 */  lbu        $v1, 0xBB($s1)
    /* B271C 800C1F1C 21104800 */  addu       $v0, $v0, $t0
    /* B2720 800C1F20 01004224 */  addiu      $v0, $v0, 0x1
    /* B2724 800C1F24 C3002892 */  lbu        $t0, 0xC3($s1)
    /* B2728 800C1F28 43100200 */  sra        $v0, $v0, 1
    /* B272C 800C1F2C DE0322A2 */  sb         $v0, 0x3DE($s1)
    /* B2730 800C1F30 B2002292 */  lbu        $v0, 0xB2($s1)
    /* B2734 800C1F34 21186800 */  addu       $v1, $v1, $t0
    /* B2738 800C1F38 01006324 */  addiu      $v1, $v1, 0x1
    /* B273C 800C1F3C C2002892 */  lbu        $t0, 0xC2($s1)
    /* B2740 800C1F40 43180300 */  sra        $v1, $v1, 1
    /* B2744 800C1F44 DF0323A2 */  sb         $v1, 0x3DF($s1)
    /* B2748 800C1F48 B3002392 */  lbu        $v1, 0xB3($s1)
    /* B274C 800C1F4C 21400201 */  addu       $t0, $t0, $v0
    /* B2750 800C1F50 01000825 */  addiu      $t0, $t0, 0x1
    /* B2754 800C1F54 C3002292 */  lbu        $v0, 0xC3($s1)
    /* B2758 800C1F58 43400800 */  sra        $t0, $t0, 1
    /* B275C 800C1F5C E60328A2 */  sb         $t0, 0x3E6($s1)
    /* B2760 800C1F60 21104300 */  addu       $v0, $v0, $v1
    /* B2764 800C1F64 01004224 */  addiu      $v0, $v0, 0x1
    /* B2768 800C1F68 43100200 */  sra        $v0, $v0, 1
    /* B276C 800C1F6C E70322A2 */  sb         $v0, 0x3E7($s1)
    /* B2770 800C1F70 1000B7AF */  sw         $s7, 0x10($sp)
    /* B2774 800C1F74 1400B6AF */  sw         $s6, 0x14($sp)
    /* B2778 800C1F78 1800B0AF */  sw         $s0, 0x18($sp)
    /* B277C 800C1F7C BE04030C */  jal        DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
    /* B2780 800C1F80 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* B2784 800C1F84 B4002526 */  addiu      $a1, $s1, 0xB4
    /* B2788 800C1F88 2130A002 */  addu       $a2, $s5, $zero
    /* B278C 800C1F8C 2138E002 */  addu       $a3, $s7, $zero
    /* B2790 800C1F90 2000A48F */  lw         $a0, 0x20($sp)
    /* B2794 800C1F94 BA002226 */  addiu      $v0, $s1, 0xBA
    /* B2798 800C1F98 1000A2AF */  sw         $v0, 0x10($sp)
    /* B279C 800C1F9C 1400B4AF */  sw         $s4, 0x14($sp)
    /* B27A0 800C1FA0 1800B0AF */  sw         $s0, 0x18($sp)
    /* B27A4 800C1FA4 BE04030C */  jal        DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
    /* B27A8 800C1FA8 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* B27AC 800C1FAC 2120C003 */  addu       $a0, $fp, $zero
    /* B27B0 800C1FB0 2128A002 */  addu       $a1, $s5, $zero
    /* B27B4 800C1FB4 BC002626 */  addiu      $a2, $s1, 0xBC
    /* B27B8 800C1FB8 2138C002 */  addu       $a3, $s6, $zero
    /* B27BC 800C1FBC C2002226 */  addiu      $v0, $s1, 0xC2
    /* B27C0 800C1FC0 1000B4AF */  sw         $s4, 0x10($sp)
    /* B27C4 800C1FC4 1400A2AF */  sw         $v0, 0x14($sp)
    /* B27C8 800C1FC8 1800B0AF */  sw         $s0, 0x18($sp)
    /* B27CC 800C1FCC BE04030C */  jal        DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
    /* B27D0 800C1FD0 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* B27D4 800C1FD4 2120C003 */  addu       $a0, $fp, $zero
    /* B27D8 800C1FD8 2130A002 */  addu       $a2, $s5, $zero
    /* B27DC 800C1FDC 2000A58F */  lw         $a1, 0x20($sp)
    /* B27E0 800C1FE0 2138C002 */  addu       $a3, $s6, $zero
    /* B27E4 800C1FE4 1000B7AF */  sw         $s7, 0x10($sp)
    /* B27E8 800C1FE8 1400B4AF */  sw         $s4, 0x14($sp)
    /* B27EC 800C1FEC 1800B0AF */  sw         $s0, 0x18($sp)
    /* B27F0 800C1FF0 BE04030C */  jal        DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
    /* B27F4 800C1FF4 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* B27F8 800C1FF8 36070308 */  j          .L800C1CD8
    /* B27FC 800C1FFC FFFF5226 */   addiu     $s2, $s2, -0x1
  .L800C2000:
    /* B2800 800C2000 26000B24 */  addiu      $t3, $zero, 0x26
    /* B2804 800C2004 24001424 */  addiu      $s4, $zero, 0x24
    /* B2808 800C2008 40101200 */  sll        $v0, $s2, 1
    /* B280C 800C200C 21105200 */  addu       $v0, $v0, $s2
    /* B2810 800C2010 80500200 */  sll        $t2, $v0, 2
  .L800C2014:
    /* B2814 800C2014 FFFF5226 */  addiu      $s2, $s2, -0x1
  .L800C2018:
    /* B2818 800C2018 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B281C 800C201C 98044212 */  beq        $s2, $v0, .L800C3280
    /* B2820 800C2020 F4FF4A25 */   addiu     $t2, $t2, -0xC
    /* B2824 800C2024 5800B98F */  lw         $t9, 0x58($sp)
    /* B2828 800C2028 00000000 */  nop
    /* B282C 800C202C 1800228F */  lw         $v0, 0x18($t9)
    /* B2830 800C2030 0800238E */  lw         $v1, 0x8($s1)
    /* B2834 800C2034 21304A00 */  addu       $a2, $v0, $t2
    /* B2838 800C2038 0300C990 */  lbu        $t1, 0x3($a2)
    /* B283C 800C203C 0400C890 */  lbu        $t0, 0x4($a2)
    /* B2840 800C2040 0400228E */  lw         $v0, 0x4($s1)
    /* B2844 800C2044 0500C790 */  lbu        $a3, 0x5($a2)
    /* B2848 800C2048 2B104300 */  sltu       $v0, $v0, $v1
    /* B284C 800C204C F2FF4010 */  beqz       $v0, .L800C2018
    /* B2850 800C2050 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2854 800C2054 01005226 */  addiu      $s2, $s2, 0x1
    /* B2858 800C2058 C0480900 */  sll        $t1, $t1, 3
    /* B285C 800C205C 21483101 */  addu       $t1, $t1, $s1
    /* B2860 800C2060 C0400800 */  sll        $t0, $t0, 3
    /* B2864 800C2064 21401101 */  addu       $t0, $t0, $s1
    /* B2868 800C2068 C0380700 */  sll        $a3, $a3, 3
    /* B286C 800C206C 2138F100 */  addu       $a3, $a3, $s1
    /* B2870 800C2070 D00020C9 */  lwc2       $0, 0xD0($t1)
    /* B2874 800C2074 D40021C9 */  lwc2       $1, 0xD4($t1)
    /* B2878 800C2078 D00002C9 */  lwc2       $2, 0xD0($t0)
    /* B287C 800C207C D40003C9 */  lwc2       $3, 0xD4($t0)
    /* B2880 800C2080 D000E4C8 */  lwc2       $4, 0xD0($a3)
    /* B2884 800C2084 D400E5C8 */  lwc2       $5, 0xD4($a3)
    /* B2888 800C2088 00000000 */  nop
    /* B288C 800C208C 00000000 */  nop
    /* B2890 800C2090 3000284A */  .word 0x4A280030  /* rtpt */
    /* B2894 800C2094 00000000 */  nop
    /* B2898 800C2098 00000000 */  nop
    /* B289C 800C209C 0600404B */  .word 0x4B400006  /* nclip */
    /* B28A0 800C20A0 440038EA */  swc2       $24, 0x44($s1)
    /* B28A4 800C20A4 0C00228E */  lw         $v0, 0xC($s1)
    /* B28A8 800C20A8 4400238E */  lw         $v1, 0x44($s1)
    /* B28AC 800C20AC 02004010 */  beqz       $v0, .L800C20B8
    /* B28B0 800C20B0 00000000 */   nop
    /* B28B4 800C20B4 23180300 */  negu       $v1, $v1
  .L800C20B8:
    /* B28B8 800C20B8 D7FF6018 */  blez       $v1, .L800C2018
    /* B28BC 800C20BC FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B28C0 800C20C0 01005226 */  addiu      $s2, $s2, 0x1
    /* B28C4 800C20C4 C4002CEA */  swc2       $12, 0xC4($s1)
    /* B28C8 800C20C8 C8002DEA */  swc2       $13, 0xC8($s1)
    /* B28CC 800C20CC CC002EEA */  swc2       $14, 0xCC($s1)
    /* B28D0 800C20D0 D4002C95 */  lhu        $t4, 0xD4($t1)
    /* B28D4 800C20D4 D4000D95 */  lhu        $t5, 0xD4($t0)
    /* B28D8 800C20D8 D400EE94 */  lhu        $t6, 0xD4($a3)
    /* B28DC 800C20DC B0002CA6 */  sh         $t4, 0xB0($s1)
    /* B28E0 800C20E0 B8002DA6 */  sh         $t5, 0xB8($s1)
    /* B28E4 800C20E4 C0002EA6 */  sh         $t6, 0xC0($s1)
    /* B28E8 800C20E8 10002386 */  lh         $v1, 0x10($s1)
    /* B28EC 800C20EC C4002286 */  lh         $v0, 0xC4($s1)
    /* B28F0 800C20F0 12002486 */  lh         $a0, 0x12($s1)
    /* B28F4 800C20F4 2A106200 */  slt        $v0, $v1, $v0
    /* B28F8 800C20F8 0C004010 */  beqz       $v0, .L800C212C
    /* B28FC 800C20FC 00000000 */   nop
    /* B2900 800C2100 C8002286 */  lh         $v0, 0xC8($s1)
    /* B2904 800C2104 00000000 */  nop
    /* B2908 800C2108 2A106200 */  slt        $v0, $v1, $v0
    /* B290C 800C210C 07004010 */  beqz       $v0, .L800C212C
    /* B2910 800C2110 00000000 */   nop
    /* B2914 800C2114 CC002286 */  lh         $v0, 0xCC($s1)
    /* B2918 800C2118 00000000 */  nop
    /* B291C 800C211C 2A106200 */  slt        $v0, $v1, $v0
    /* B2920 800C2120 BDFF4014 */  bnez       $v0, .L800C2018
    /* B2924 800C2124 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2928 800C2128 01005226 */  addiu      $s2, $s2, 0x1
  .L800C212C:
    /* B292C 800C212C C4002286 */  lh         $v0, 0xC4($s1)
    /* B2930 800C2130 00000000 */  nop
    /* B2934 800C2134 0A004104 */  bgez       $v0, .L800C2160
    /* B2938 800C2138 00000000 */   nop
    /* B293C 800C213C C8002286 */  lh         $v0, 0xC8($s1)
    /* B2940 800C2140 00000000 */  nop
    /* B2944 800C2144 06004104 */  bgez       $v0, .L800C2160
    /* B2948 800C2148 00000000 */   nop
    /* B294C 800C214C CC002286 */  lh         $v0, 0xCC($s1)
    /* B2950 800C2150 00000000 */  nop
    /* B2954 800C2154 B0FF4004 */  bltz       $v0, .L800C2018
    /* B2958 800C2158 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B295C 800C215C 01005226 */  addiu      $s2, $s2, 0x1
  .L800C2160:
    /* B2960 800C2160 C6002286 */  lh         $v0, 0xC6($s1)
    /* B2964 800C2164 00000000 */  nop
    /* B2968 800C2168 2A108200 */  slt        $v0, $a0, $v0
    /* B296C 800C216C 0C004010 */  beqz       $v0, .L800C21A0
    /* B2970 800C2170 00000000 */   nop
    /* B2974 800C2174 CA002286 */  lh         $v0, 0xCA($s1)
    /* B2978 800C2178 00000000 */  nop
    /* B297C 800C217C 2A108200 */  slt        $v0, $a0, $v0
    /* B2980 800C2180 07004010 */  beqz       $v0, .L800C21A0
    /* B2984 800C2184 00000000 */   nop
    /* B2988 800C2188 CE002286 */  lh         $v0, 0xCE($s1)
    /* B298C 800C218C 00000000 */  nop
    /* B2990 800C2190 2A108200 */  slt        $v0, $a0, $v0
    /* B2994 800C2194 A0FF4014 */  bnez       $v0, .L800C2018
    /* B2998 800C2198 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B299C 800C219C 01005226 */  addiu      $s2, $s2, 0x1
  .L800C21A0:
    /* B29A0 800C21A0 C6002286 */  lh         $v0, 0xC6($s1)
    /* B29A4 800C21A4 00000000 */  nop
    /* B29A8 800C21A8 0A004104 */  bgez       $v0, .L800C21D4
    /* B29AC 800C21AC 00000000 */   nop
    /* B29B0 800C21B0 CA002286 */  lh         $v0, 0xCA($s1)
    /* B29B4 800C21B4 00000000 */  nop
    /* B29B8 800C21B8 06004104 */  bgez       $v0, .L800C21D4
    /* B29BC 800C21BC 00000000 */   nop
    /* B29C0 800C21C0 CE002286 */  lh         $v0, 0xCE($s1)
    /* B29C4 800C21C4 00000000 */  nop
    /* B29C8 800C21C8 93FF4004 */  bltz       $v0, .L800C2018
    /* B29CC 800C21CC FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B29D0 800C21D0 01005226 */  addiu      $s2, $s2, 0x1
  .L800C21D4:
    /* B29D4 800C21D4 B0002286 */  lh         $v0, 0xB0($s1)
    /* B29D8 800C21D8 00000000 */  nop
    /* B29DC 800C21DC 0A004104 */  bgez       $v0, .L800C2208
    /* B29E0 800C21E0 00000000 */   nop
    /* B29E4 800C21E4 B8002286 */  lh         $v0, 0xB8($s1)
    /* B29E8 800C21E8 00000000 */  nop
    /* B29EC 800C21EC 06004104 */  bgez       $v0, .L800C2208
    /* B29F0 800C21F0 00000000 */   nop
    /* B29F4 800C21F4 C0002286 */  lh         $v0, 0xC0($s1)
    /* B29F8 800C21F8 00000000 */  nop
    /* B29FC 800C21FC 86FF4004 */  bltz       $v0, .L800C2018
    /* B2A00 800C2200 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2A04 800C2204 01005226 */  addiu      $s2, $s2, 0x1
  .L800C2208:
    /* B2A08 800C2208 00000000 */  nop
    /* B2A0C 800C220C 00000000 */  nop
    /* B2A10 800C2210 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B2A14 800C2214 3C0027EA */  swc2       $7, 0x3C($s1)
    /* B2A18 800C2218 3C00238E */  lw         $v1, 0x3C($s1)
    /* B2A1C 800C221C 4000228E */  lw         $v0, 0x40($s1)
    /* B2A20 800C2220 00000000 */  nop
    /* B2A24 800C2224 21186200 */  addu       $v1, $v1, $v0
    /* B2A28 800C2228 7AFF6004 */  bltz       $v1, .L800C2014
    /* B2A2C 800C222C 3C0023AE */   sw        $v1, 0x3C($s1)
    /* B2A30 800C2230 8800228E */  lw         $v0, 0x88($s1)
    /* B2A34 800C2234 00000000 */  nop
    /* B2A38 800C2238 2A104300 */  slt        $v0, $v0, $v1
    /* B2A3C 800C223C 76FF4014 */  bnez       $v0, .L800C2018
    /* B2A40 800C2240 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2A44 800C2244 0000C294 */  lhu        $v0, 0x0($a2)
    /* B2A48 800C2248 00000000 */  nop
    /* B2A4C 800C224C F3034230 */  andi       $v0, $v0, 0x3F3
    /* B2A50 800C2250 7E004010 */  beqz       $v0, .L800C244C
    /* B2A54 800C2254 01005226 */   addiu     $s2, $s2, 0x1
    /* B2A58 800C2258 7400228E */  lw         $v0, 0x74($s1)
    /* B2A5C 800C225C 00000000 */  nop
    /* B2A60 800C2260 7A004010 */  beqz       $v0, .L800C244C
    /* B2A64 800C2264 00000000 */   nop
    /* B2A68 800C2268 0300C390 */  lbu        $v1, 0x3($a2)
    /* B2A6C 800C226C 00000000 */  nop
    /* B2A70 800C2270 40100300 */  sll        $v0, $v1, 1
    /* B2A74 800C2274 21104300 */  addu       $v0, $v0, $v1
    /* B2A78 800C2278 40100200 */  sll        $v0, $v0, 1
    /* B2A7C 800C227C 21106202 */  addu       $v0, $s3, $v0
    /* B2A80 800C2280 00004394 */  lhu        $v1, 0x0($v0)
    /* B2A84 800C2284 02004494 */  lhu        $a0, 0x2($v0)
    /* B2A88 800C2288 04004294 */  lhu        $v0, 0x4($v0)
    /* B2A8C 800C228C AC0023A6 */  sh         $v1, 0xAC($s1)
    /* B2A90 800C2290 AE0024A6 */  sh         $a0, 0xAE($s1)
    /* B2A94 800C2294 B00022A6 */  sh         $v0, 0xB0($s1)
    /* B2A98 800C2298 0400C390 */  lbu        $v1, 0x4($a2)
    /* B2A9C 800C229C 00000000 */  nop
    /* B2AA0 800C22A0 40100300 */  sll        $v0, $v1, 1
    /* B2AA4 800C22A4 21104300 */  addu       $v0, $v0, $v1
    /* B2AA8 800C22A8 40100200 */  sll        $v0, $v0, 1
    /* B2AAC 800C22AC 21106202 */  addu       $v0, $s3, $v0
    /* B2AB0 800C22B0 00004394 */  lhu        $v1, 0x0($v0)
    /* B2AB4 800C22B4 02004494 */  lhu        $a0, 0x2($v0)
    /* B2AB8 800C22B8 04004294 */  lhu        $v0, 0x4($v0)
    /* B2ABC 800C22BC B40023A6 */  sh         $v1, 0xB4($s1)
    /* B2AC0 800C22C0 B60024A6 */  sh         $a0, 0xB6($s1)
    /* B2AC4 800C22C4 B80022A6 */  sh         $v0, 0xB8($s1)
    /* B2AC8 800C22C8 0500C390 */  lbu        $v1, 0x5($a2)
    /* B2ACC 800C22CC 00000000 */  nop
    /* B2AD0 800C22D0 40100300 */  sll        $v0, $v1, 1
    /* B2AD4 800C22D4 21104300 */  addu       $v0, $v0, $v1
    /* B2AD8 800C22D8 40100200 */  sll        $v0, $v0, 1
    /* B2ADC 800C22DC 21106202 */  addu       $v0, $s3, $v0
    /* B2AE0 800C22E0 00004394 */  lhu        $v1, 0x0($v0)
    /* B2AE4 800C22E4 02004494 */  lhu        $a0, 0x2($v0)
    /* B2AE8 800C22E8 04004294 */  lhu        $v0, 0x4($v0)
    /* B2AEC 800C22EC BC0023A6 */  sh         $v1, 0xBC($s1)
    /* B2AF0 800C22F0 BE0024A6 */  sh         $a0, 0xBE($s1)
    /* B2AF4 800C22F4 C00022A6 */  sh         $v0, 0xC0($s1)
    /* B2AF8 800C22F8 04002C8E */  lw         $t4, 0x4($s1)
    /* B2AFC 800C22FC 3C002D8E */  lw         $t5, 0x3C($s1)
    /* B2B00 800C2300 38002E8E */  lw         $t6, 0x38($s1)
    /* B2B04 800C2304 0C008F25 */  addiu      $t7, $t4, 0xC
    /* B2B08 800C2308 80680D00 */  sll        $t5, $t5, 2
    /* B2B0C 800C230C 2170CD01 */  addu       $t6, $t6, $t5
    /* B2B10 800C2310 04002FAE */  sw         $t7, 0x4($s1)
    /* B2B14 800C2314 54002D8E */  lw         $t5, 0x54($s1)
    /* B2B18 800C2318 58002F8E */  lw         $t7, 0x58($s1)
    /* B2B1C 800C231C 5C00308E */  lw         $s0, 0x5C($s1)
    /* B2B20 800C2320 00008DAD */  sw         $t5, 0x0($t4)
    /* B2B24 800C2324 04008FAD */  sw         $t7, 0x4($t4)
    /* B2B28 800C2328 080090AD */  sw         $s0, 0x8($t4)
    /* B2B2C 800C232C 0200CD89 */  lwl        $t5, 0x2($t6)
    /* B2B30 800C2330 007A0C00 */  sll        $t7, $t4, 8
    /* B2B34 800C2334 02008DA9 */  swl        $t5, 0x2($t4)
    /* B2B38 800C2338 0200CFA9 */  swl        $t7, 0x2($t6)
    /* B2B3C 800C233C 0400258E */  lw         $a1, 0x4($s1)
    /* B2B40 800C2340 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B2B44 800C2344 38002D8E */  lw         $t5, 0x38($s1)
    /* B2B48 800C2348 2000AE24 */  addiu      $t6, $a1, 0x20
    /* B2B4C 800C234C 80600C00 */  sll        $t4, $t4, 2
    /* B2B50 800C2350 2168AC01 */  addu       $t5, $t5, $t4
    /* B2B54 800C2354 04002EAE */  sw         $t6, 0x4($s1)
    /* B2B58 800C2358 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B2B5C 800C235C 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B2B60 800C2360 02720E00 */  srl        $t6, $t6, 8
    /* B2B64 800C2364 2570CC01 */  or         $t6, $t6, $t4
    /* B2B68 800C2368 00620500 */  sll        $t4, $a1, 8
    /* B2B6C 800C236C 0000AEAC */  sw         $t6, 0x0($a1)
    /* B2B70 800C2370 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B2B74 800C2374 04002C8E */  lw         $t4, 0x4($s1)
    /* B2B78 800C2378 3C002D8E */  lw         $t5, 0x3C($s1)
    /* B2B7C 800C237C 38002E8E */  lw         $t6, 0x38($s1)
    /* B2B80 800C2380 0C008F25 */  addiu      $t7, $t4, 0xC
    /* B2B84 800C2384 80680D00 */  sll        $t5, $t5, 2
    /* B2B88 800C2388 2170CD01 */  addu       $t6, $t6, $t5
    /* B2B8C 800C238C 04002FAE */  sw         $t7, 0x4($s1)
    /* B2B90 800C2390 48002D8E */  lw         $t5, 0x48($s1)
    /* B2B94 800C2394 4C002F8E */  lw         $t7, 0x4C($s1)
    /* B2B98 800C2398 5000308E */  lw         $s0, 0x50($s1)
    /* B2B9C 800C239C 00008DAD */  sw         $t5, 0x0($t4)
    /* B2BA0 800C23A0 04008FAD */  sw         $t7, 0x4($t4)
    /* B2BA4 800C23A4 080090AD */  sw         $s0, 0x8($t4)
    /* B2BA8 800C23A8 0200CD89 */  lwl        $t5, 0x2($t6)
    /* B2BAC 800C23AC 007A0C00 */  sll        $t7, $t4, 8
    /* B2BB0 800C23B0 02008DA9 */  swl        $t5, 0x2($t4)
    /* B2BB4 800C23B4 0200CFA9 */  swl        $t7, 0x2($t6)
    /* B2BB8 800C23B8 C400228E */  lw         $v0, 0xC4($s1)
    /* B2BBC 800C23BC C800238E */  lw         $v1, 0xC8($s1)
    /* B2BC0 800C23C0 CC00248E */  lw         $a0, 0xCC($s1)
    /* B2BC4 800C23C4 0800A2AC */  sw         $v0, 0x8($a1)
    /* B2BC8 800C23C8 1000A3AC */  sw         $v1, 0x10($a1)
    /* B2BCC 800C23CC 1800A4AC */  sw         $a0, 0x18($a1)
    /* B2BD0 800C23D0 9000228E */  lw         $v0, 0x90($s1)
    /* B2BD4 800C23D4 00000000 */  nop
    /* B2BD8 800C23D8 0400A2AC */  sw         $v0, 0x4($a1)
    /* B2BDC 800C23DC 0700ABA0 */  sb         $t3, 0x7($a1)
    /* B2BE0 800C23E0 76002296 */  lhu        $v0, 0x76($s1)
    /* B2BE4 800C23E4 7A002396 */  lhu        $v1, 0x7A($s1)
    /* B2BE8 800C23E8 0E00A2A4 */  sh         $v0, 0xE($a1)
    /* B2BEC 800C23EC 1600A3A4 */  sh         $v1, 0x16($a1)
    /* B2BF0 800C23F0 74002E92 */  lbu        $t6, 0x74($s1)
    /* B2BF4 800C23F4 75002F92 */  lbu        $t7, 0x75($s1)
    /* B2BF8 800C23F8 84002D92 */  lbu        $t5, 0x84($s1)
    /* B2BFC 800C23FC 4000CE25 */  addiu      $t6, $t6, 0x40
    /* B2C00 800C2400 2178ED01 */  addu       $t7, $t7, $t5
    /* B2C04 800C2404 AE002C92 */  lbu        $t4, 0xAE($s1)
    /* B2C08 800C2408 B0002D92 */  lbu        $t5, 0xB0($s1)
    /* B2C0C 800C240C 21608E01 */  addu       $t4, $t4, $t6
    /* B2C10 800C2410 0C00ACA0 */  sb         $t4, 0xC($a1)
    /* B2C14 800C2414 2168AF01 */  addu       $t5, $t5, $t7
    /* B2C18 800C2418 0D00ADA0 */  sb         $t5, 0xD($a1)
    /* B2C1C 800C241C B6002C92 */  lbu        $t4, 0xB6($s1)
    /* B2C20 800C2420 B8002D92 */  lbu        $t5, 0xB8($s1)
    /* B2C24 800C2424 21608E01 */  addu       $t4, $t4, $t6
    /* B2C28 800C2428 1400ACA0 */  sb         $t4, 0x14($a1)
    /* B2C2C 800C242C 2168AF01 */  addu       $t5, $t5, $t7
    /* B2C30 800C2430 1500ADA0 */  sb         $t5, 0x15($a1)
    /* B2C34 800C2434 BE002C92 */  lbu        $t4, 0xBE($s1)
    /* B2C38 800C2438 C0002D92 */  lbu        $t5, 0xC0($s1)
    /* B2C3C 800C243C 21608E01 */  addu       $t4, $t4, $t6
    /* B2C40 800C2440 1C00ACA0 */  sb         $t4, 0x1C($a1)
    /* B2C44 800C2444 2168AF01 */  addu       $t5, $t5, $t7
    /* B2C48 800C2448 1D00ADA0 */  sb         $t5, 0x1D($a1)
  .L800C244C:
    /* B2C4C 800C244C 6400228E */  lw         $v0, 0x64($s1)
    /* B2C50 800C2450 00000000 */  nop
    /* B2C54 800C2454 32004010 */  beqz       $v0, .L800C2520
    /* B2C58 800C2458 00000000 */   nop
    /* B2C5C 800C245C 0400258E */  lw         $a1, 0x4($s1)
    /* B2C60 800C2460 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B2C64 800C2464 38002D8E */  lw         $t5, 0x38($s1)
    /* B2C68 800C2468 2000AE24 */  addiu      $t6, $a1, 0x20
    /* B2C6C 800C246C 80600C00 */  sll        $t4, $t4, 2
    /* B2C70 800C2470 2168AC01 */  addu       $t5, $t5, $t4
    /* B2C74 800C2474 04002EAE */  sw         $t6, 0x4($s1)
    /* B2C78 800C2478 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B2C7C 800C247C 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B2C80 800C2480 02720E00 */  srl        $t6, $t6, 8
    /* B2C84 800C2484 2570CC01 */  or         $t6, $t6, $t4
    /* B2C88 800C2488 00620500 */  sll        $t4, $a1, 8
    /* B2C8C 800C248C 0000AEAC */  sw         $t6, 0x0($a1)
    /* B2C90 800C2490 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B2C94 800C2494 C400228E */  lw         $v0, 0xC4($s1)
    /* B2C98 800C2498 C800238E */  lw         $v1, 0xC8($s1)
    /* B2C9C 800C249C CC00248E */  lw         $a0, 0xCC($s1)
    /* B2CA0 800C24A0 0800A2AC */  sw         $v0, 0x8($a1)
    /* B2CA4 800C24A4 1000A3AC */  sw         $v1, 0x10($a1)
    /* B2CA8 800C24A8 1800A4AC */  sw         $a0, 0x18($a1)
    /* B2CAC 800C24AC 9000228E */  lw         $v0, 0x90($s1)
    /* B2CB0 800C24B0 00000000 */  nop
    /* B2CB4 800C24B4 0400A2AC */  sw         $v0, 0x4($a1)
    /* B2CB8 800C24B8 0700ABA0 */  sb         $t3, 0x7($a1)
    /* B2CBC 800C24BC 66002296 */  lhu        $v0, 0x66($s1)
    /* B2CC0 800C24C0 6A002396 */  lhu        $v1, 0x6A($s1)
    /* B2CC4 800C24C4 0E00A2A4 */  sh         $v0, 0xE($a1)
    /* B2CC8 800C24C8 1600A3A4 */  sh         $v1, 0x16($a1)
    /* B2CCC 800C24CC 64002E92 */  lbu        $t6, 0x64($s1)
    /* B2CD0 800C24D0 65002F92 */  lbu        $t7, 0x65($s1)
    /* B2CD4 800C24D4 4000CE25 */  addiu      $t6, $t6, 0x40
    /* B2CD8 800C24D8 D6002C91 */  lbu        $t4, 0xD6($t1)
    /* B2CDC 800C24DC D7002D91 */  lbu        $t5, 0xD7($t1)
    /* B2CE0 800C24E0 21608E01 */  addu       $t4, $t4, $t6
    /* B2CE4 800C24E4 0C00ACA0 */  sb         $t4, 0xC($a1)
    /* B2CE8 800C24E8 2168AF01 */  addu       $t5, $t5, $t7
    /* B2CEC 800C24EC 0D00ADA0 */  sb         $t5, 0xD($a1)
    /* B2CF0 800C24F0 D6000C91 */  lbu        $t4, 0xD6($t0)
    /* B2CF4 800C24F4 D7000D91 */  lbu        $t5, 0xD7($t0)
    /* B2CF8 800C24F8 21608E01 */  addu       $t4, $t4, $t6
    /* B2CFC 800C24FC 1400ACA0 */  sb         $t4, 0x14($a1)
    /* B2D00 800C2500 2168AF01 */  addu       $t5, $t5, $t7
    /* B2D04 800C2504 1500ADA0 */  sb         $t5, 0x15($a1)
    /* B2D08 800C2508 D600EC90 */  lbu        $t4, 0xD6($a3)
    /* B2D0C 800C250C D700ED90 */  lbu        $t5, 0xD7($a3)
    /* B2D10 800C2510 21608E01 */  addu       $t4, $t4, $t6
    /* B2D14 800C2514 1C00ACA0 */  sb         $t4, 0x1C($a1)
    /* B2D18 800C2518 2168AF01 */  addu       $t5, $t5, $t7
    /* B2D1C 800C251C 1D00ADA0 */  sb         $t5, 0x1D($a1)
  .L800C2520:
    /* B2D20 800C2520 0400258E */  lw         $a1, 0x4($s1)
    /* B2D24 800C2524 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B2D28 800C2528 38002D8E */  lw         $t5, 0x38($s1)
    /* B2D2C 800C252C 2000AE24 */  addiu      $t6, $a1, 0x20
    /* B2D30 800C2530 80600C00 */  sll        $t4, $t4, 2
    /* B2D34 800C2534 2168AC01 */  addu       $t5, $t5, $t4
    /* B2D38 800C2538 04002EAE */  sw         $t6, 0x4($s1)
    /* B2D3C 800C253C 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B2D40 800C2540 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B2D44 800C2544 02720E00 */  srl        $t6, $t6, 8
    /* B2D48 800C2548 2570CC01 */  or         $t6, $t6, $t4
    /* B2D4C 800C254C 00620500 */  sll        $t4, $a1, 8
    /* B2D50 800C2550 0000AEAC */  sw         $t6, 0x0($a1)
    /* B2D54 800C2554 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B2D58 800C2558 C400228E */  lw         $v0, 0xC4($s1)
    /* B2D5C 800C255C C800238E */  lw         $v1, 0xC8($s1)
    /* B2D60 800C2560 CC00248E */  lw         $a0, 0xCC($s1)
    /* B2D64 800C2564 0800A2AC */  sw         $v0, 0x8($a1)
    /* B2D68 800C2568 1000A3AC */  sw         $v1, 0x10($a1)
    /* B2D6C 800C256C 1800A4AC */  sw         $a0, 0x18($a1)
    /* B2D70 800C2570 8C00228E */  lw         $v0, 0x8C($s1)
    /* B2D74 800C2574 00000000 */  nop
    /* B2D78 800C2578 0400A2AC */  sw         $v0, 0x4($a1)
    /* B2D7C 800C257C 0700B4A0 */  sb         $s4, 0x7($a1)
    /* B2D80 800C2580 0200C290 */  lbu        $v0, 0x2($a2)
    /* B2D84 800C2584 6000238E */  lw         $v1, 0x60($s1)
    /* B2D88 800C2588 00110200 */  sll        $v0, $v0, 4
    /* B2D8C 800C258C 21186200 */  addu       $v1, $v1, $v0
    /* B2D90 800C2590 02006294 */  lhu        $v0, 0x2($v1)
    /* B2D94 800C2594 06006394 */  lhu        $v1, 0x6($v1)
    /* B2D98 800C2598 0E00A2A4 */  sh         $v0, 0xE($a1)
    /* B2D9C 800C259C 1600A3A4 */  sh         $v1, 0x16($a1)
    /* B2DA0 800C25A0 0600C294 */  lhu        $v0, 0x6($a2)
    /* B2DA4 800C25A4 0800C394 */  lhu        $v1, 0x8($a2)
    /* B2DA8 800C25A8 0A00C494 */  lhu        $a0, 0xA($a2)
    /* B2DAC 800C25AC 0C00A2A4 */  sh         $v0, 0xC($a1)
    /* B2DB0 800C25B0 1400A3A4 */  sh         $v1, 0x14($a1)
    /* B2DB4 800C25B4 05080308 */  j          .L800C2014
    /* B2DB8 800C25B8 1C00A4A4 */   sh        $a0, 0x1C($a1)
  .L800C25BC:
    /* B2DBC 800C25BC 1280023C */  lui        $v0, %hi(DrawC_gOverlay)
    /* B2DC0 800C25C0 08F54F24 */  addiu      $t7, $v0, %lo(DrawC_gOverlay)
    /* B2DC4 800C25C4 40101200 */  sll        $v0, $s2, 1
    /* B2DC8 800C25C8 21105200 */  addu       $v0, $v0, $s2
    /* B2DCC 800C25CC 80580200 */  sll        $t3, $v0, 2
  .L800C25D0:
    /* B2DD0 800C25D0 FFFF5226 */  addiu      $s2, $s2, -0x1
  .L800C25D4:
    /* B2DD4 800C25D4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B2DD8 800C25D8 29034212 */  beq        $s2, $v0, .L800C3280
    /* B2DDC 800C25DC F4FF6B25 */   addiu     $t3, $t3, -0xC
    /* B2DE0 800C25E0 5800B98F */  lw         $t9, 0x58($sp)
    /* B2DE4 800C25E4 00000000 */  nop
    /* B2DE8 800C25E8 1800228F */  lw         $v0, 0x18($t9)
    /* B2DEC 800C25EC 0800238E */  lw         $v1, 0x8($s1)
    /* B2DF0 800C25F0 21404B00 */  addu       $t0, $v0, $t3
    /* B2DF4 800C25F4 03000691 */  lbu        $a2, 0x3($t0)
    /* B2DF8 800C25F8 04000591 */  lbu        $a1, 0x4($t0)
    /* B2DFC 800C25FC 0400228E */  lw         $v0, 0x4($s1)
    /* B2E00 800C2600 05000491 */  lbu        $a0, 0x5($t0)
    /* B2E04 800C2604 2B104300 */  sltu       $v0, $v0, $v1
    /* B2E08 800C2608 F2FF4010 */  beqz       $v0, .L800C25D4
    /* B2E0C 800C260C FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2E10 800C2610 01005226 */  addiu      $s2, $s2, 0x1
    /* B2E14 800C2614 C0300600 */  sll        $a2, $a2, 3
    /* B2E18 800C2618 2130D100 */  addu       $a2, $a2, $s1
    /* B2E1C 800C261C C0280500 */  sll        $a1, $a1, 3
    /* B2E20 800C2620 2128B100 */  addu       $a1, $a1, $s1
    /* B2E24 800C2624 C0200400 */  sll        $a0, $a0, 3
    /* B2E28 800C2628 21209100 */  addu       $a0, $a0, $s1
    /* B2E2C 800C262C D000C0C8 */  lwc2       $0, 0xD0($a2)
    /* B2E30 800C2630 D400C1C8 */  lwc2       $1, 0xD4($a2)
    /* B2E34 800C2634 D000A2C8 */  lwc2       $2, 0xD0($a1)
    /* B2E38 800C2638 D400A3C8 */  lwc2       $3, 0xD4($a1)
    /* B2E3C 800C263C D00084C8 */  lwc2       $4, 0xD0($a0)
    /* B2E40 800C2640 D40085C8 */  lwc2       $5, 0xD4($a0)
    /* B2E44 800C2644 00000000 */  nop
    /* B2E48 800C2648 00000000 */  nop
    /* B2E4C 800C264C 3000284A */  .word 0x4A280030  /* rtpt */
    /* B2E50 800C2650 00000000 */  nop
    /* B2E54 800C2654 00000000 */  nop
    /* B2E58 800C2658 0600404B */  .word 0x4B400006  /* nclip */
    /* B2E5C 800C265C 440038EA */  swc2       $24, 0x44($s1)
    /* B2E60 800C2660 0C00228E */  lw         $v0, 0xC($s1)
    /* B2E64 800C2664 4400238E */  lw         $v1, 0x44($s1)
    /* B2E68 800C2668 02004010 */  beqz       $v0, .L800C2674
    /* B2E6C 800C266C 00000000 */   nop
    /* B2E70 800C2670 23180300 */  negu       $v1, $v1
  .L800C2674:
    /* B2E74 800C2674 D7FF6018 */  blez       $v1, .L800C25D4
    /* B2E78 800C2678 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2E7C 800C267C 01005226 */  addiu      $s2, $s2, 0x1
    /* B2E80 800C2680 C4002CEA */  swc2       $12, 0xC4($s1)
    /* B2E84 800C2684 C8002DEA */  swc2       $13, 0xC8($s1)
    /* B2E88 800C2688 CC002EEA */  swc2       $14, 0xCC($s1)
    /* B2E8C 800C268C D400CC94 */  lhu        $t4, 0xD4($a2)
    /* B2E90 800C2690 D400AD94 */  lhu        $t5, 0xD4($a1)
    /* B2E94 800C2694 D4008E94 */  lhu        $t6, 0xD4($a0)
    /* B2E98 800C2698 B0002CA6 */  sh         $t4, 0xB0($s1)
    /* B2E9C 800C269C B8002DA6 */  sh         $t5, 0xB8($s1)
    /* B2EA0 800C26A0 C0002EA6 */  sh         $t6, 0xC0($s1)
    /* B2EA4 800C26A4 10002386 */  lh         $v1, 0x10($s1)
    /* B2EA8 800C26A8 C4002286 */  lh         $v0, 0xC4($s1)
    /* B2EAC 800C26AC 12002486 */  lh         $a0, 0x12($s1)
    /* B2EB0 800C26B0 2A106200 */  slt        $v0, $v1, $v0
    /* B2EB4 800C26B4 0C004010 */  beqz       $v0, .L800C26E8
    /* B2EB8 800C26B8 00000000 */   nop
    /* B2EBC 800C26BC C8002286 */  lh         $v0, 0xC8($s1)
    /* B2EC0 800C26C0 00000000 */  nop
    /* B2EC4 800C26C4 2A106200 */  slt        $v0, $v1, $v0
    /* B2EC8 800C26C8 07004010 */  beqz       $v0, .L800C26E8
    /* B2ECC 800C26CC 00000000 */   nop
    /* B2ED0 800C26D0 CC002286 */  lh         $v0, 0xCC($s1)
    /* B2ED4 800C26D4 00000000 */  nop
    /* B2ED8 800C26D8 2A106200 */  slt        $v0, $v1, $v0
    /* B2EDC 800C26DC BDFF4014 */  bnez       $v0, .L800C25D4
    /* B2EE0 800C26E0 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2EE4 800C26E4 01005226 */  addiu      $s2, $s2, 0x1
  .L800C26E8:
    /* B2EE8 800C26E8 C4002286 */  lh         $v0, 0xC4($s1)
    /* B2EEC 800C26EC 00000000 */  nop
    /* B2EF0 800C26F0 0A004104 */  bgez       $v0, .L800C271C
    /* B2EF4 800C26F4 00000000 */   nop
    /* B2EF8 800C26F8 C8002286 */  lh         $v0, 0xC8($s1)
    /* B2EFC 800C26FC 00000000 */  nop
    /* B2F00 800C2700 06004104 */  bgez       $v0, .L800C271C
    /* B2F04 800C2704 00000000 */   nop
    /* B2F08 800C2708 CC002286 */  lh         $v0, 0xCC($s1)
    /* B2F0C 800C270C 00000000 */  nop
    /* B2F10 800C2710 B0FF4004 */  bltz       $v0, .L800C25D4
    /* B2F14 800C2714 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2F18 800C2718 01005226 */  addiu      $s2, $s2, 0x1
  .L800C271C:
    /* B2F1C 800C271C C6002286 */  lh         $v0, 0xC6($s1)
    /* B2F20 800C2720 00000000 */  nop
    /* B2F24 800C2724 2A108200 */  slt        $v0, $a0, $v0
    /* B2F28 800C2728 0C004010 */  beqz       $v0, .L800C275C
    /* B2F2C 800C272C 00000000 */   nop
    /* B2F30 800C2730 CA002286 */  lh         $v0, 0xCA($s1)
    /* B2F34 800C2734 00000000 */  nop
    /* B2F38 800C2738 2A108200 */  slt        $v0, $a0, $v0
    /* B2F3C 800C273C 07004010 */  beqz       $v0, .L800C275C
    /* B2F40 800C2740 00000000 */   nop
    /* B2F44 800C2744 CE002286 */  lh         $v0, 0xCE($s1)
    /* B2F48 800C2748 00000000 */  nop
    /* B2F4C 800C274C 2A108200 */  slt        $v0, $a0, $v0
    /* B2F50 800C2750 A0FF4014 */  bnez       $v0, .L800C25D4
    /* B2F54 800C2754 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2F58 800C2758 01005226 */  addiu      $s2, $s2, 0x1
  .L800C275C:
    /* B2F5C 800C275C C6002286 */  lh         $v0, 0xC6($s1)
    /* B2F60 800C2760 00000000 */  nop
    /* B2F64 800C2764 0A004104 */  bgez       $v0, .L800C2790
    /* B2F68 800C2768 00000000 */   nop
    /* B2F6C 800C276C CA002286 */  lh         $v0, 0xCA($s1)
    /* B2F70 800C2770 00000000 */  nop
    /* B2F74 800C2774 06004104 */  bgez       $v0, .L800C2790
    /* B2F78 800C2778 00000000 */   nop
    /* B2F7C 800C277C CE002286 */  lh         $v0, 0xCE($s1)
    /* B2F80 800C2780 00000000 */  nop
    /* B2F84 800C2784 93FF4004 */  bltz       $v0, .L800C25D4
    /* B2F88 800C2788 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2F8C 800C278C 01005226 */  addiu      $s2, $s2, 0x1
  .L800C2790:
    /* B2F90 800C2790 B0002286 */  lh         $v0, 0xB0($s1)
    /* B2F94 800C2794 00000000 */  nop
    /* B2F98 800C2798 0A004104 */  bgez       $v0, .L800C27C4
    /* B2F9C 800C279C 00000000 */   nop
    /* B2FA0 800C27A0 B8002286 */  lh         $v0, 0xB8($s1)
    /* B2FA4 800C27A4 00000000 */  nop
    /* B2FA8 800C27A8 06004104 */  bgez       $v0, .L800C27C4
    /* B2FAC 800C27AC 00000000 */   nop
    /* B2FB0 800C27B0 C0002286 */  lh         $v0, 0xC0($s1)
    /* B2FB4 800C27B4 00000000 */  nop
    /* B2FB8 800C27B8 86FF4004 */  bltz       $v0, .L800C25D4
    /* B2FBC 800C27BC FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B2FC0 800C27C0 01005226 */  addiu      $s2, $s2, 0x1
  .L800C27C4:
    /* B2FC4 800C27C4 00000000 */  nop
    /* B2FC8 800C27C8 00000000 */  nop
    /* B2FCC 800C27CC 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B2FD0 800C27D0 3C0027EA */  swc2       $7, 0x3C($s1)
    /* B2FD4 800C27D4 02000291 */  lbu        $v0, 0x2($t0)
    /* B2FD8 800C27D8 00000000 */  nop
    /* B2FDC 800C27DC 40100200 */  sll        $v0, $v0, 1
    /* B2FE0 800C27E0 21104F00 */  addu       $v0, $v0, $t7
    /* B2FE4 800C27E4 00004294 */  lhu        $v0, 0x0($v0)
    /* B2FE8 800C27E8 00000000 */  nop
    /* B2FEC 800C27EC 00140200 */  sll        $v0, $v0, 16
    /* B2FF0 800C27F0 032C0200 */  sra        $a1, $v0, 16
    /* B2FF4 800C27F4 2600A010 */  beqz       $a1, .L800C2890
    /* B2FF8 800C27F8 00000000 */   nop
    /* B2FFC 800C27FC 00000685 */  lh         $a2, 0x0($t0)
    /* B3000 800C2800 3C00248E */  lw         $a0, 0x3C($s1)
    /* B3004 800C2804 0200C104 */  bgez       $a2, .L800C2810
    /* B3008 800C2808 FF00A530 */   andi      $a1, $a1, 0xFF
    /* B300C 800C280C 032E0200 */  sra        $a1, $v0, 24
  .L800C2810:
    /* B3010 800C2810 4000228E */  lw         $v0, 0x40($s1)
    /* B3014 800C2814 00000000 */  nop
    /* B3018 800C2818 21208200 */  addu       $a0, $a0, $v0
    /* B301C 800C281C 4000A230 */  andi       $v0, $a1, 0x40
    /* B3020 800C2820 02004010 */  beqz       $v0, .L800C282C
    /* B3024 800C2824 00000000 */   nop
    /* B3028 800C2828 FEFF8424 */  addiu      $a0, $a0, -0x2
  .L800C282C:
    /* B302C 800C282C 69FF8004 */  bltz       $a0, .L800C25D4
    /* B3030 800C2830 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B3034 800C2834 01005226 */  addiu      $s2, $s2, 0x1
    /* B3038 800C2838 8800228E */  lw         $v0, 0x88($s1)
    /* B303C 800C283C 00000000 */  nop
    /* B3040 800C2840 2A104400 */  slt        $v0, $v0, $a0
    /* B3044 800C2844 63FF4014 */  bnez       $v0, .L800C25D4
    /* B3048 800C2848 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B304C 800C284C 01005226 */  addiu      $s2, $s2, 0x1
    /* B3050 800C2850 FF0FC330 */  andi       $v1, $a2, 0xFFF
    /* B3054 800C2854 F003C230 */  andi       $v0, $a2, 0x3F0
    /* B3058 800C2858 0B004010 */  beqz       $v0, .L800C2888
    /* B305C 800C285C 21506000 */   addu      $t2, $v1, $zero
    /* B3060 800C2860 02110300 */  srl        $v0, $v1, 4
    /* B3064 800C2864 2428A200 */  and        $a1, $a1, $v0
    /* B3068 800C2868 0700A010 */  beqz       $a1, .L800C2888
    /* B306C 800C286C 0300A230 */   andi      $v0, $a1, 0x3
    /* B3070 800C2870 05004014 */  bnez       $v0, .L800C2888
    /* B3074 800C2874 00000000 */   nop
  .L800C2878:
    /* B3078 800C2878 83280500 */  sra        $a1, $a1, 2
    /* B307C 800C287C 0300A230 */  andi       $v0, $a1, 0x3
    /* B3080 800C2880 FDFF4010 */  beqz       $v0, .L800C2878
    /* B3084 800C2884 00000000 */   nop
  .L800C2888:
    /* B3088 800C2888 330A0308 */  j          .L800C28CC
    /* B308C 800C288C 3C0024AE */   sw        $a0, 0x3C($s1)
  .L800C2890:
    /* B3090 800C2890 3C00238E */  lw         $v1, 0x3C($s1)
    /* B3094 800C2894 4000228E */  lw         $v0, 0x40($s1)
    /* B3098 800C2898 00000000 */  nop
    /* B309C 800C289C 21186200 */  addu       $v1, $v1, $v0
    /* B30A0 800C28A0 4BFF6004 */  bltz       $v1, .L800C25D0
    /* B30A4 800C28A4 3C0023AE */   sw        $v1, 0x3C($s1)
    /* B30A8 800C28A8 8800228E */  lw         $v0, 0x88($s1)
    /* B30AC 800C28AC 00000000 */  nop
    /* B30B0 800C28B0 2A104300 */  slt        $v0, $v0, $v1
    /* B30B4 800C28B4 47FF4014 */  bnez       $v0, .L800C25D4
    /* B30B8 800C28B8 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B30BC 800C28BC 01005226 */  addiu      $s2, $s2, 0x1
    /* B30C0 800C28C0 00000295 */  lhu        $v0, 0x0($t0)
    /* B30C4 800C28C4 00000000 */  nop
    /* B30C8 800C28C8 FF0F4A30 */  andi       $t2, $v0, 0xFFF
  .L800C28CC:
    /* B30CC 800C28CC 0300A430 */  andi       $a0, $a1, 0x3
    /* B30D0 800C28D0 45008010 */  beqz       $a0, .L800C29E8
    /* B30D4 800C28D4 FFFF8424 */   addiu     $a0, $a0, -0x1
    /* B30D8 800C28D8 02000391 */  lbu        $v1, 0x2($t0)
    /* B30DC 800C28DC 0400278E */  lw         $a3, 0x4($s1)
    /* B30E0 800C28E0 40100300 */  sll        $v0, $v1, 1
    /* B30E4 800C28E4 21104300 */  addu       $v0, $v0, $v1
    /* B30E8 800C28E8 21104400 */  addu       $v0, $v0, $a0
    /* B30EC 800C28EC 80100200 */  sll        $v0, $v0, 2
    /* B30F0 800C28F0 2130C202 */  addu       $a2, $s6, $v0
    /* B30F4 800C28F4 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B30F8 800C28F8 38002D8E */  lw         $t5, 0x38($s1)
    /* B30FC 800C28FC 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B3100 800C2900 80600C00 */  sll        $t4, $t4, 2
    /* B3104 800C2904 2168AC01 */  addu       $t5, $t5, $t4
    /* B3108 800C2908 04002EAE */  sw         $t6, 0x4($s1)
    /* B310C 800C290C 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B3110 800C2910 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B3114 800C2914 02720E00 */  srl        $t6, $t6, 8
    /* B3118 800C2918 2570CC01 */  or         $t6, $t6, $t4
    /* B311C 800C291C 00620700 */  sll        $t4, $a3, 8
    /* B3120 800C2920 0000EEAC */  sw         $t6, 0x0($a3)
    /* B3124 800C2924 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B3128 800C2928 8000093C */  lui        $t1, (0x808080 >> 16)
    /* B312C 800C292C C400228E */  lw         $v0, 0xC4($s1)
    /* B3130 800C2930 C800238E */  lw         $v1, 0xC8($s1)
    /* B3134 800C2934 CC00248E */  lw         $a0, 0xCC($s1)
    /* B3138 800C2938 80802935 */  ori        $t1, $t1, (0x808080 & 0xFFFF)
    /* B313C 800C293C 0800E2AC */  sw         $v0, 0x8($a3)
    /* B3140 800C2940 8000A230 */  andi       $v0, $a1, 0x80
    /* B3144 800C2944 1000E3AC */  sw         $v1, 0x10($a3)
    /* B3148 800C2948 02004014 */  bnez       $v0, .L800C2954
    /* B314C 800C294C 1800E4AC */   sw        $a0, 0x18($a3)
    /* B3150 800C2950 8C00298E */  lw         $t1, 0x8C($s1)
  .L800C2954:
    /* B3154 800C2954 01004231 */  andi       $v0, $t2, 0x1
    /* B3158 800C2958 02004010 */  beqz       $v0, .L800C2964
    /* B315C 800C295C 24000324 */   addiu     $v1, $zero, 0x24
    /* B3160 800C2960 26000324 */  addiu      $v1, $zero, 0x26
  .L800C2964:
    /* B3164 800C2964 0400E9AC */  sw         $t1, 0x4($a3)
    /* B3168 800C2968 0700E3A0 */  sb         $v1, 0x7($a3)
    /* B316C 800C296C 02000391 */  lbu        $v1, 0x2($t0)
    /* B3170 800C2970 0000C284 */  lh         $v0, 0x0($a2)
    /* B3174 800C2974 0200C590 */  lbu        $a1, 0x2($a2)
    /* B3178 800C2978 0300C690 */  lbu        $a2, 0x3($a2)
    /* B317C 800C297C 21186200 */  addu       $v1, $v1, $v0
    /* B3180 800C2980 6000228E */  lw         $v0, 0x60($s1)
    /* B3184 800C2984 00190300 */  sll        $v1, $v1, 4
    /* B3188 800C2988 21104300 */  addu       $v0, $v0, $v1
    /* B318C 800C298C 02004394 */  lhu        $v1, 0x2($v0)
    /* B3190 800C2990 06004294 */  lhu        $v0, 0x6($v0)
    /* B3194 800C2994 0E00E3A4 */  sh         $v1, 0xE($a3)
    /* B3198 800C2998 1600E2A4 */  sh         $v0, 0x16($a3)
    /* B319C 800C299C 06000291 */  lbu        $v0, 0x6($t0)
    /* B31A0 800C29A0 08000391 */  lbu        $v1, 0x8($t0)
    /* B31A4 800C29A4 0A000491 */  lbu        $a0, 0xA($t0)
    /* B31A8 800C29A8 21104500 */  addu       $v0, $v0, $a1
    /* B31AC 800C29AC 21186500 */  addu       $v1, $v1, $a1
    /* B31B0 800C29B0 21208500 */  addu       $a0, $a0, $a1
    /* B31B4 800C29B4 0C00E2A0 */  sb         $v0, 0xC($a3)
    /* B31B8 800C29B8 1400E3A0 */  sb         $v1, 0x14($a3)
    /* B31BC 800C29BC 1C00E4A0 */  sb         $a0, 0x1C($a3)
    /* B31C0 800C29C0 07000291 */  lbu        $v0, 0x7($t0)
    /* B31C4 800C29C4 09000391 */  lbu        $v1, 0x9($t0)
    /* B31C8 800C29C8 0B000491 */  lbu        $a0, 0xB($t0)
    /* B31CC 800C29CC 21104600 */  addu       $v0, $v0, $a2
    /* B31D0 800C29D0 21186600 */  addu       $v1, $v1, $a2
    /* B31D4 800C29D4 21208600 */  addu       $a0, $a0, $a2
    /* B31D8 800C29D8 0D00E2A0 */  sb         $v0, 0xD($a3)
    /* B31DC 800C29DC 1500E3A0 */  sb         $v1, 0x15($a3)
    /* B31E0 800C29E0 74090308 */  j          .L800C25D0
    /* B31E4 800C29E4 1D00E4A0 */   sb        $a0, 0x1D($a3)
  .L800C29E8:
    /* B31E8 800C29E8 0400278E */  lw         $a3, 0x4($s1)
    /* B31EC 800C29EC 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B31F0 800C29F0 38002D8E */  lw         $t5, 0x38($s1)
    /* B31F4 800C29F4 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B31F8 800C29F8 80600C00 */  sll        $t4, $t4, 2
    /* B31FC 800C29FC 2168AC01 */  addu       $t5, $t5, $t4
    /* B3200 800C2A00 04002EAE */  sw         $t6, 0x4($s1)
    /* B3204 800C2A04 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B3208 800C2A08 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B320C 800C2A0C 02720E00 */  srl        $t6, $t6, 8
    /* B3210 800C2A10 2570CC01 */  or         $t6, $t6, $t4
    /* B3214 800C2A14 00620700 */  sll        $t4, $a3, 8
    /* B3218 800C2A18 0000EEAC */  sw         $t6, 0x0($a3)
    /* B321C 800C2A1C 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B3220 800C2A20 8000063C */  lui        $a2, (0x808080 >> 16)
    /* B3224 800C2A24 C400228E */  lw         $v0, 0xC4($s1)
    /* B3228 800C2A28 C800238E */  lw         $v1, 0xC8($s1)
    /* B322C 800C2A2C CC00248E */  lw         $a0, 0xCC($s1)
    /* B3230 800C2A30 8080C634 */  ori        $a2, $a2, (0x808080 & 0xFFFF)
    /* B3234 800C2A34 0800E2AC */  sw         $v0, 0x8($a3)
    /* B3238 800C2A38 8000A230 */  andi       $v0, $a1, 0x80
    /* B323C 800C2A3C 1000E3AC */  sw         $v1, 0x10($a3)
    /* B3240 800C2A40 02004014 */  bnez       $v0, .L800C2A4C
    /* B3244 800C2A44 1800E4AC */   sw        $a0, 0x18($a3)
    /* B3248 800C2A48 8C00268E */  lw         $a2, 0x8C($s1)
  .L800C2A4C:
    /* B324C 800C2A4C 01004231 */  andi       $v0, $t2, 0x1
    /* B3250 800C2A50 02004010 */  beqz       $v0, .L800C2A5C
    /* B3254 800C2A54 24000324 */   addiu     $v1, $zero, 0x24
    /* B3258 800C2A58 26000324 */  addiu      $v1, $zero, 0x26
  .L800C2A5C:
    /* B325C 800C2A5C 0400E6AC */  sw         $a2, 0x4($a3)
    /* B3260 800C2A60 0700E3A0 */  sb         $v1, 0x7($a3)
    /* B3264 800C2A64 02000291 */  lbu        $v0, 0x2($t0)
    /* B3268 800C2A68 6000238E */  lw         $v1, 0x60($s1)
    /* B326C 800C2A6C 00110200 */  sll        $v0, $v0, 4
    /* B3270 800C2A70 21186200 */  addu       $v1, $v1, $v0
    /* B3274 800C2A74 02006294 */  lhu        $v0, 0x2($v1)
    /* B3278 800C2A78 06006394 */  lhu        $v1, 0x6($v1)
    /* B327C 800C2A7C 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B3280 800C2A80 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B3284 800C2A84 06000295 */  lhu        $v0, 0x6($t0)
    /* B3288 800C2A88 08000395 */  lhu        $v1, 0x8($t0)
    /* B328C 800C2A8C 0A000495 */  lhu        $a0, 0xA($t0)
    /* B3290 800C2A90 0C00E2A4 */  sh         $v0, 0xC($a3)
    /* B3294 800C2A94 1400E3A4 */  sh         $v1, 0x14($a3)
    /* B3298 800C2A98 74090308 */  j          .L800C25D0
    /* B329C 800C2A9C 1C00E4A4 */   sh        $a0, 0x1C($a3)
  .L800C2AA0:
    /* B32A0 800C2AA0 08F55724 */  addiu      $s7, $v0, %lo(DrawC_gOverlay)
    /* B32A4 800C2AA4 26001524 */  addiu      $s5, $zero, 0x26
    /* B32A8 800C2AA8 40101200 */  sll        $v0, $s2, 1
    /* B32AC 800C2AAC 21105200 */  addu       $v0, $v0, $s2
    /* B32B0 800C2AB0 80A00200 */  sll        $s4, $v0, 2
  .L800C2AB4:
    /* B32B4 800C2AB4 FFFF5226 */  addiu      $s2, $s2, -0x1
  .L800C2AB8:
    /* B32B8 800C2AB8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B32BC 800C2ABC F0014212 */  beq        $s2, $v0, .L800C3280
    /* B32C0 800C2AC0 F4FF9426 */   addiu     $s4, $s4, -0xC
    /* B32C4 800C2AC4 5800B98F */  lw         $t9, 0x58($sp)
    /* B32C8 800C2AC8 00000000 */  nop
    /* B32CC 800C2ACC 1800228F */  lw         $v0, 0x18($t9)
    /* B32D0 800C2AD0 0800238E */  lw         $v1, 0x8($s1)
    /* B32D4 800C2AD4 21405400 */  addu       $t0, $v0, $s4
    /* B32D8 800C2AD8 03000B91 */  lbu        $t3, 0x3($t0)
    /* B32DC 800C2ADC 04000A91 */  lbu        $t2, 0x4($t0)
    /* B32E0 800C2AE0 0400228E */  lw         $v0, 0x4($s1)
    /* B32E4 800C2AE4 05000991 */  lbu        $t1, 0x5($t0)
    /* B32E8 800C2AE8 2B104300 */  sltu       $v0, $v0, $v1
    /* B32EC 800C2AEC F2FF4010 */  beqz       $v0, .L800C2AB8
    /* B32F0 800C2AF0 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B32F4 800C2AF4 01005226 */  addiu      $s2, $s2, 0x1
    /* B32F8 800C2AF8 C0580B00 */  sll        $t3, $t3, 3
    /* B32FC 800C2AFC 21587101 */  addu       $t3, $t3, $s1
    /* B3300 800C2B00 C0500A00 */  sll        $t2, $t2, 3
    /* B3304 800C2B04 21505101 */  addu       $t2, $t2, $s1
    /* B3308 800C2B08 C0480900 */  sll        $t1, $t1, 3
    /* B330C 800C2B0C 21483101 */  addu       $t1, $t1, $s1
    /* B3310 800C2B10 D00060C9 */  lwc2       $0, 0xD0($t3)
    /* B3314 800C2B14 D40061C9 */  lwc2       $1, 0xD4($t3)
    /* B3318 800C2B18 D00042C9 */  lwc2       $2, 0xD0($t2)
    /* B331C 800C2B1C D40043C9 */  lwc2       $3, 0xD4($t2)
    /* B3320 800C2B20 D00024C9 */  lwc2       $4, 0xD0($t1)
    /* B3324 800C2B24 D40025C9 */  lwc2       $5, 0xD4($t1)
    /* B3328 800C2B28 00000000 */  nop
    /* B332C 800C2B2C 00000000 */  nop
    /* B3330 800C2B30 3000284A */  .word 0x4A280030  /* rtpt */
    /* B3334 800C2B34 00000000 */  nop
    /* B3338 800C2B38 00000000 */  nop
    /* B333C 800C2B3C 0600404B */  .word 0x4B400006  /* nclip */
    /* B3340 800C2B40 440038EA */  swc2       $24, 0x44($s1)
    /* B3344 800C2B44 0C00228E */  lw         $v0, 0xC($s1)
    /* B3348 800C2B48 4400238E */  lw         $v1, 0x44($s1)
    /* B334C 800C2B4C 02004010 */  beqz       $v0, .L800C2B58
    /* B3350 800C2B50 00000000 */   nop
    /* B3354 800C2B54 23180300 */  negu       $v1, $v1
  .L800C2B58:
    /* B3358 800C2B58 D7FF6018 */  blez       $v1, .L800C2AB8
    /* B335C 800C2B5C FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B3360 800C2B60 01005226 */  addiu      $s2, $s2, 0x1
    /* B3364 800C2B64 C4002CEA */  swc2       $12, 0xC4($s1)
    /* B3368 800C2B68 C8002DEA */  swc2       $13, 0xC8($s1)
    /* B336C 800C2B6C CC002EEA */  swc2       $14, 0xCC($s1)
    /* B3370 800C2B70 D4006C95 */  lhu        $t4, 0xD4($t3)
    /* B3374 800C2B74 D4004D95 */  lhu        $t5, 0xD4($t2)
    /* B3378 800C2B78 D4002E95 */  lhu        $t6, 0xD4($t1)
    /* B337C 800C2B7C B0002CA6 */  sh         $t4, 0xB0($s1)
    /* B3380 800C2B80 B8002DA6 */  sh         $t5, 0xB8($s1)
    /* B3384 800C2B84 C0002EA6 */  sh         $t6, 0xC0($s1)
    /* B3388 800C2B88 10002386 */  lh         $v1, 0x10($s1)
    /* B338C 800C2B8C C4002286 */  lh         $v0, 0xC4($s1)
    /* B3390 800C2B90 12002486 */  lh         $a0, 0x12($s1)
    /* B3394 800C2B94 2A106200 */  slt        $v0, $v1, $v0
    /* B3398 800C2B98 0C004010 */  beqz       $v0, .L800C2BCC
    /* B339C 800C2B9C 00000000 */   nop
    /* B33A0 800C2BA0 C8002286 */  lh         $v0, 0xC8($s1)
    /* B33A4 800C2BA4 00000000 */  nop
    /* B33A8 800C2BA8 2A106200 */  slt        $v0, $v1, $v0
    /* B33AC 800C2BAC 07004010 */  beqz       $v0, .L800C2BCC
    /* B33B0 800C2BB0 00000000 */   nop
    /* B33B4 800C2BB4 CC002286 */  lh         $v0, 0xCC($s1)
    /* B33B8 800C2BB8 00000000 */  nop
    /* B33BC 800C2BBC 2A106200 */  slt        $v0, $v1, $v0
    /* B33C0 800C2BC0 BDFF4014 */  bnez       $v0, .L800C2AB8
    /* B33C4 800C2BC4 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B33C8 800C2BC8 01005226 */  addiu      $s2, $s2, 0x1
  .L800C2BCC:
    /* B33CC 800C2BCC C4002286 */  lh         $v0, 0xC4($s1)
    /* B33D0 800C2BD0 00000000 */  nop
    /* B33D4 800C2BD4 0A004104 */  bgez       $v0, .L800C2C00
    /* B33D8 800C2BD8 00000000 */   nop
    /* B33DC 800C2BDC C8002286 */  lh         $v0, 0xC8($s1)
    /* B33E0 800C2BE0 00000000 */  nop
    /* B33E4 800C2BE4 06004104 */  bgez       $v0, .L800C2C00
    /* B33E8 800C2BE8 00000000 */   nop
    /* B33EC 800C2BEC CC002286 */  lh         $v0, 0xCC($s1)
    /* B33F0 800C2BF0 00000000 */  nop
    /* B33F4 800C2BF4 B0FF4004 */  bltz       $v0, .L800C2AB8
    /* B33F8 800C2BF8 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B33FC 800C2BFC 01005226 */  addiu      $s2, $s2, 0x1
  .L800C2C00:
    /* B3400 800C2C00 C6002286 */  lh         $v0, 0xC6($s1)
    /* B3404 800C2C04 00000000 */  nop
    /* B3408 800C2C08 2A108200 */  slt        $v0, $a0, $v0
    /* B340C 800C2C0C 0C004010 */  beqz       $v0, .L800C2C40
    /* B3410 800C2C10 00000000 */   nop
    /* B3414 800C2C14 CA002286 */  lh         $v0, 0xCA($s1)
    /* B3418 800C2C18 00000000 */  nop
    /* B341C 800C2C1C 2A108200 */  slt        $v0, $a0, $v0
    /* B3420 800C2C20 07004010 */  beqz       $v0, .L800C2C40
    /* B3424 800C2C24 00000000 */   nop
    /* B3428 800C2C28 CE002286 */  lh         $v0, 0xCE($s1)
    /* B342C 800C2C2C 00000000 */  nop
    /* B3430 800C2C30 2A108200 */  slt        $v0, $a0, $v0
    /* B3434 800C2C34 A0FF4014 */  bnez       $v0, .L800C2AB8
    /* B3438 800C2C38 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B343C 800C2C3C 01005226 */  addiu      $s2, $s2, 0x1
  .L800C2C40:
    /* B3440 800C2C40 C6002286 */  lh         $v0, 0xC6($s1)
    /* B3444 800C2C44 00000000 */  nop
    /* B3448 800C2C48 0A004104 */  bgez       $v0, .L800C2C74
    /* B344C 800C2C4C 00000000 */   nop
    /* B3450 800C2C50 CA002286 */  lh         $v0, 0xCA($s1)
    /* B3454 800C2C54 00000000 */  nop
    /* B3458 800C2C58 06004104 */  bgez       $v0, .L800C2C74
    /* B345C 800C2C5C 00000000 */   nop
    /* B3460 800C2C60 CE002286 */  lh         $v0, 0xCE($s1)
    /* B3464 800C2C64 00000000 */  nop
    /* B3468 800C2C68 93FF4004 */  bltz       $v0, .L800C2AB8
    /* B346C 800C2C6C FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B3470 800C2C70 01005226 */  addiu      $s2, $s2, 0x1
  .L800C2C74:
    /* B3474 800C2C74 B0002286 */  lh         $v0, 0xB0($s1)
    /* B3478 800C2C78 00000000 */  nop
    /* B347C 800C2C7C 0A004104 */  bgez       $v0, .L800C2CA8
    /* B3480 800C2C80 00000000 */   nop
    /* B3484 800C2C84 B8002286 */  lh         $v0, 0xB8($s1)
    /* B3488 800C2C88 00000000 */  nop
    /* B348C 800C2C8C 06004104 */  bgez       $v0, .L800C2CA8
    /* B3490 800C2C90 00000000 */   nop
    /* B3494 800C2C94 C0002286 */  lh         $v0, 0xC0($s1)
    /* B3498 800C2C98 00000000 */  nop
    /* B349C 800C2C9C 86FF4004 */  bltz       $v0, .L800C2AB8
    /* B34A0 800C2CA0 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B34A4 800C2CA4 01005226 */  addiu      $s2, $s2, 0x1
  .L800C2CA8:
    /* B34A8 800C2CA8 00000000 */  nop
    /* B34AC 800C2CAC 00000000 */  nop
    /* B34B0 800C2CB0 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B34B4 800C2CB4 3C0027EA */  swc2       $7, 0x3C($s1)
    /* B34B8 800C2CB8 02000291 */  lbu        $v0, 0x2($t0)
    /* B34BC 800C2CBC 00000000 */  nop
    /* B34C0 800C2CC0 40100200 */  sll        $v0, $v0, 1
    /* B34C4 800C2CC4 21105700 */  addu       $v0, $v0, $s7
    /* B34C8 800C2CC8 00004294 */  lhu        $v0, 0x0($v0)
    /* B34CC 800C2CCC 00000000 */  nop
    /* B34D0 800C2CD0 00140200 */  sll        $v0, $v0, 16
    /* B34D4 800C2CD4 03340200 */  sra        $a2, $v0, 16
    /* B34D8 800C2CD8 2200C010 */  beqz       $a2, .L800C2D64
    /* B34DC 800C2CDC 00000000 */   nop
    /* B34E0 800C2CE0 00000485 */  lh         $a0, 0x0($t0)
    /* B34E4 800C2CE4 3C00258E */  lw         $a1, 0x3C($s1)
    /* B34E8 800C2CE8 02008104 */  bgez       $a0, .L800C2CF4
    /* B34EC 800C2CEC FF00C630 */   andi      $a2, $a2, 0xFF
    /* B34F0 800C2CF0 03360200 */  sra        $a2, $v0, 24
  .L800C2CF4:
    /* B34F4 800C2CF4 4000228E */  lw         $v0, 0x40($s1)
    /* B34F8 800C2CF8 00000000 */  nop
    /* B34FC 800C2CFC 2128A200 */  addu       $a1, $a1, $v0
    /* B3500 800C2D00 6DFFA004 */  bltz       $a1, .L800C2AB8
    /* B3504 800C2D04 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B3508 800C2D08 01005226 */  addiu      $s2, $s2, 0x1
    /* B350C 800C2D0C 8800228E */  lw         $v0, 0x88($s1)
    /* B3510 800C2D10 00000000 */  nop
    /* B3514 800C2D14 2A104500 */  slt        $v0, $v0, $a1
    /* B3518 800C2D18 67FF4014 */  bnez       $v0, .L800C2AB8
    /* B351C 800C2D1C FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B3520 800C2D20 01005226 */  addiu      $s2, $s2, 0x1
    /* B3524 800C2D24 FF0F8330 */  andi       $v1, $a0, 0xFFF
    /* B3528 800C2D28 F0038230 */  andi       $v0, $a0, 0x3F0
    /* B352C 800C2D2C 0B004010 */  beqz       $v0, .L800C2D5C
    /* B3530 800C2D30 21C06000 */   addu      $t8, $v1, $zero
    /* B3534 800C2D34 02110300 */  srl        $v0, $v1, 4
    /* B3538 800C2D38 2430C200 */  and        $a2, $a2, $v0
    /* B353C 800C2D3C 0700C010 */  beqz       $a2, .L800C2D5C
    /* B3540 800C2D40 0300C230 */   andi      $v0, $a2, 0x3
    /* B3544 800C2D44 05004014 */  bnez       $v0, .L800C2D5C
    /* B3548 800C2D48 00000000 */   nop
  .L800C2D4C:
    /* B354C 800C2D4C 83300600 */  sra        $a2, $a2, 2
    /* B3550 800C2D50 0300C230 */  andi       $v0, $a2, 0x3
    /* B3554 800C2D54 FDFF4010 */  beqz       $v0, .L800C2D4C
    /* B3558 800C2D58 00000000 */   nop
  .L800C2D5C:
    /* B355C 800C2D5C 680B0308 */  j          .L800C2DA0
    /* B3560 800C2D60 3C0025AE */   sw        $a1, 0x3C($s1)
  .L800C2D64:
    /* B3564 800C2D64 3C00238E */  lw         $v1, 0x3C($s1)
    /* B3568 800C2D68 4000228E */  lw         $v0, 0x40($s1)
    /* B356C 800C2D6C 00000000 */  nop
    /* B3570 800C2D70 21186200 */  addu       $v1, $v1, $v0
    /* B3574 800C2D74 4FFF6004 */  bltz       $v1, .L800C2AB4
    /* B3578 800C2D78 3C0023AE */   sw        $v1, 0x3C($s1)
    /* B357C 800C2D7C 8800228E */  lw         $v0, 0x88($s1)
    /* B3580 800C2D80 00000000 */  nop
    /* B3584 800C2D84 2A104300 */  slt        $v0, $v0, $v1
    /* B3588 800C2D88 4BFF4014 */  bnez       $v0, .L800C2AB8
    /* B358C 800C2D8C FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B3590 800C2D90 01005226 */  addiu      $s2, $s2, 0x1
    /* B3594 800C2D94 00000295 */  lhu        $v0, 0x0($t0)
    /* B3598 800C2D98 00000000 */  nop
    /* B359C 800C2D9C FF0F5830 */  andi       $t8, $v0, 0xFFF
  .L800C2DA0:
    /* B35A0 800C2DA0 6000B98F */  lw         $t9, 0x60($sp)
    /* B35A4 800C2DA4 00000000 */  nop
    /* B35A8 800C2DA8 20002233 */  andi       $v0, $t9, 0x20
    /* B35AC 800C2DAC 04004010 */  beqz       $v0, .L800C2DC0
    /* B35B0 800C2DB0 01000233 */   andi      $v0, $t8, 0x1
    /* B35B4 800C2DB4 40FF4014 */  bnez       $v0, .L800C2AB8
    /* B35B8 800C2DB8 FFFF5226 */   addiu     $s2, $s2, -0x1
    /* B35BC 800C2DBC 01005226 */  addiu      $s2, $s2, 0x1
  .L800C2DC0:
    /* B35C0 800C2DC0 F3030233 */  andi       $v0, $t8, 0x3F3
    /* B35C4 800C2DC4 7E004010 */  beqz       $v0, .L800C2FC0
    /* B35C8 800C2DC8 00000000 */   nop
    /* B35CC 800C2DCC 7400228E */  lw         $v0, 0x74($s1)
    /* B35D0 800C2DD0 00000000 */  nop
    /* B35D4 800C2DD4 7A004010 */  beqz       $v0, .L800C2FC0
    /* B35D8 800C2DD8 00000000 */   nop
    /* B35DC 800C2DDC 03000391 */  lbu        $v1, 0x3($t0)
    /* B35E0 800C2DE0 00000000 */  nop
    /* B35E4 800C2DE4 40100300 */  sll        $v0, $v1, 1
    /* B35E8 800C2DE8 21104300 */  addu       $v0, $v0, $v1
    /* B35EC 800C2DEC 40100200 */  sll        $v0, $v0, 1
    /* B35F0 800C2DF0 21106202 */  addu       $v0, $s3, $v0
    /* B35F4 800C2DF4 00004394 */  lhu        $v1, 0x0($v0)
    /* B35F8 800C2DF8 02004494 */  lhu        $a0, 0x2($v0)
    /* B35FC 800C2DFC 04004294 */  lhu        $v0, 0x4($v0)
    /* B3600 800C2E00 AC0023A6 */  sh         $v1, 0xAC($s1)
    /* B3604 800C2E04 AE0024A6 */  sh         $a0, 0xAE($s1)
    /* B3608 800C2E08 B00022A6 */  sh         $v0, 0xB0($s1)
    /* B360C 800C2E0C 04000391 */  lbu        $v1, 0x4($t0)
    /* B3610 800C2E10 00000000 */  nop
    /* B3614 800C2E14 40100300 */  sll        $v0, $v1, 1
    /* B3618 800C2E18 21104300 */  addu       $v0, $v0, $v1
    /* B361C 800C2E1C 40100200 */  sll        $v0, $v0, 1
    /* B3620 800C2E20 21106202 */  addu       $v0, $s3, $v0
    /* B3624 800C2E24 00004394 */  lhu        $v1, 0x0($v0)
    /* B3628 800C2E28 02004494 */  lhu        $a0, 0x2($v0)
    /* B362C 800C2E2C 04004294 */  lhu        $v0, 0x4($v0)
    /* B3630 800C2E30 B40023A6 */  sh         $v1, 0xB4($s1)
    /* B3634 800C2E34 B60024A6 */  sh         $a0, 0xB6($s1)
    /* B3638 800C2E38 B80022A6 */  sh         $v0, 0xB8($s1)
    /* B363C 800C2E3C 05000391 */  lbu        $v1, 0x5($t0)
    /* B3640 800C2E40 00000000 */  nop
    /* B3644 800C2E44 40100300 */  sll        $v0, $v1, 1
    /* B3648 800C2E48 21104300 */  addu       $v0, $v0, $v1
    /* B364C 800C2E4C 40100200 */  sll        $v0, $v0, 1
    /* B3650 800C2E50 21106202 */  addu       $v0, $s3, $v0
    /* B3654 800C2E54 00004394 */  lhu        $v1, 0x0($v0)
    /* B3658 800C2E58 02004494 */  lhu        $a0, 0x2($v0)
    /* B365C 800C2E5C 04004294 */  lhu        $v0, 0x4($v0)
    /* B3660 800C2E60 BC0023A6 */  sh         $v1, 0xBC($s1)
    /* B3664 800C2E64 BE0024A6 */  sh         $a0, 0xBE($s1)
    /* B3668 800C2E68 C00022A6 */  sh         $v0, 0xC0($s1)
    /* B366C 800C2E6C 04002C8E */  lw         $t4, 0x4($s1)
    /* B3670 800C2E70 3C002D8E */  lw         $t5, 0x3C($s1)
    /* B3674 800C2E74 38002E8E */  lw         $t6, 0x38($s1)
    /* B3678 800C2E78 0C008F25 */  addiu      $t7, $t4, 0xC
    /* B367C 800C2E7C 80680D00 */  sll        $t5, $t5, 2
    /* B3680 800C2E80 2170CD01 */  addu       $t6, $t6, $t5
    /* B3684 800C2E84 04002FAE */  sw         $t7, 0x4($s1)
    /* B3688 800C2E88 54002D8E */  lw         $t5, 0x54($s1)
    /* B368C 800C2E8C 58002F8E */  lw         $t7, 0x58($s1)
    /* B3690 800C2E90 5C00308E */  lw         $s0, 0x5C($s1)
    /* B3694 800C2E94 00008DAD */  sw         $t5, 0x0($t4)
    /* B3698 800C2E98 04008FAD */  sw         $t7, 0x4($t4)
    /* B369C 800C2E9C 080090AD */  sw         $s0, 0x8($t4)
    /* B36A0 800C2EA0 0200CD89 */  lwl        $t5, 0x2($t6)
    /* B36A4 800C2EA4 007A0C00 */  sll        $t7, $t4, 8
    /* B36A8 800C2EA8 02008DA9 */  swl        $t5, 0x2($t4)
    /* B36AC 800C2EAC 0200CFA9 */  swl        $t7, 0x2($t6)
    /* B36B0 800C2EB0 0400278E */  lw         $a3, 0x4($s1)
    /* B36B4 800C2EB4 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B36B8 800C2EB8 38002D8E */  lw         $t5, 0x38($s1)
    /* B36BC 800C2EBC 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B36C0 800C2EC0 80600C00 */  sll        $t4, $t4, 2
    /* B36C4 800C2EC4 2168AC01 */  addu       $t5, $t5, $t4
    /* B36C8 800C2EC8 04002EAE */  sw         $t6, 0x4($s1)
    /* B36CC 800C2ECC 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B36D0 800C2ED0 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B36D4 800C2ED4 02720E00 */  srl        $t6, $t6, 8
    /* B36D8 800C2ED8 2570CC01 */  or         $t6, $t6, $t4
    /* B36DC 800C2EDC 00620700 */  sll        $t4, $a3, 8
    /* B36E0 800C2EE0 0000EEAC */  sw         $t6, 0x0($a3)
    /* B36E4 800C2EE4 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B36E8 800C2EE8 04002C8E */  lw         $t4, 0x4($s1)
    /* B36EC 800C2EEC 3C002D8E */  lw         $t5, 0x3C($s1)
    /* B36F0 800C2EF0 38002E8E */  lw         $t6, 0x38($s1)
    /* B36F4 800C2EF4 0C008F25 */  addiu      $t7, $t4, 0xC
    /* B36F8 800C2EF8 80680D00 */  sll        $t5, $t5, 2
    /* B36FC 800C2EFC 2170CD01 */  addu       $t6, $t6, $t5
    /* B3700 800C2F00 04002FAE */  sw         $t7, 0x4($s1)
    /* B3704 800C2F04 48002D8E */  lw         $t5, 0x48($s1)
    /* B3708 800C2F08 4C002F8E */  lw         $t7, 0x4C($s1)
    /* B370C 800C2F0C 5000308E */  lw         $s0, 0x50($s1)
    /* B3710 800C2F10 00008DAD */  sw         $t5, 0x0($t4)
    /* B3714 800C2F14 04008FAD */  sw         $t7, 0x4($t4)
    /* B3718 800C2F18 080090AD */  sw         $s0, 0x8($t4)
    /* B371C 800C2F1C 0200CD89 */  lwl        $t5, 0x2($t6)
    /* B3720 800C2F20 007A0C00 */  sll        $t7, $t4, 8
    /* B3724 800C2F24 02008DA9 */  swl        $t5, 0x2($t4)
    /* B3728 800C2F28 0200CFA9 */  swl        $t7, 0x2($t6)
    /* B372C 800C2F2C C400228E */  lw         $v0, 0xC4($s1)
    /* B3730 800C2F30 C800238E */  lw         $v1, 0xC8($s1)
    /* B3734 800C2F34 CC00248E */  lw         $a0, 0xCC($s1)
    /* B3738 800C2F38 0800E2AC */  sw         $v0, 0x8($a3)
    /* B373C 800C2F3C 1000E3AC */  sw         $v1, 0x10($a3)
    /* B3740 800C2F40 1800E4AC */  sw         $a0, 0x18($a3)
    /* B3744 800C2F44 9000228E */  lw         $v0, 0x90($s1)
    /* B3748 800C2F48 00000000 */  nop
    /* B374C 800C2F4C 0400E2AC */  sw         $v0, 0x4($a3)
    /* B3750 800C2F50 0700F5A0 */  sb         $s5, 0x7($a3)
    /* B3754 800C2F54 76002296 */  lhu        $v0, 0x76($s1)
    /* B3758 800C2F58 7A002396 */  lhu        $v1, 0x7A($s1)
    /* B375C 800C2F5C 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B3760 800C2F60 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B3764 800C2F64 74002E92 */  lbu        $t6, 0x74($s1)
    /* B3768 800C2F68 75002F92 */  lbu        $t7, 0x75($s1)
    /* B376C 800C2F6C 84002D92 */  lbu        $t5, 0x84($s1)
    /* B3770 800C2F70 4000CE25 */  addiu      $t6, $t6, 0x40
    /* B3774 800C2F74 2178ED01 */  addu       $t7, $t7, $t5
    /* B3778 800C2F78 AE002C92 */  lbu        $t4, 0xAE($s1)
    /* B377C 800C2F7C B0002D92 */  lbu        $t5, 0xB0($s1)
    /* B3780 800C2F80 21608E01 */  addu       $t4, $t4, $t6
    /* B3784 800C2F84 0C00ECA0 */  sb         $t4, 0xC($a3)
    /* B3788 800C2F88 2168AF01 */  addu       $t5, $t5, $t7
    /* B378C 800C2F8C 0D00EDA0 */  sb         $t5, 0xD($a3)
    /* B3790 800C2F90 B6002C92 */  lbu        $t4, 0xB6($s1)
    /* B3794 800C2F94 B8002D92 */  lbu        $t5, 0xB8($s1)
    /* B3798 800C2F98 21608E01 */  addu       $t4, $t4, $t6
    /* B379C 800C2F9C 1400ECA0 */  sb         $t4, 0x14($a3)
    /* B37A0 800C2FA0 2168AF01 */  addu       $t5, $t5, $t7
    /* B37A4 800C2FA4 1500EDA0 */  sb         $t5, 0x15($a3)
    /* B37A8 800C2FA8 BE002C92 */  lbu        $t4, 0xBE($s1)
    /* B37AC 800C2FAC C0002D92 */  lbu        $t5, 0xC0($s1)
    /* B37B0 800C2FB0 21608E01 */  addu       $t4, $t4, $t6
    /* B37B4 800C2FB4 1C00ECA0 */  sb         $t4, 0x1C($a3)
    /* B37B8 800C2FB8 2168AF01 */  addu       $t5, $t5, $t7
    /* B37BC 800C2FBC 1D00EDA0 */  sb         $t5, 0x1D($a3)
  .L800C2FC0:
    /* B37C0 800C2FC0 6400228E */  lw         $v0, 0x64($s1)
    /* B37C4 800C2FC4 00000000 */  nop
    /* B37C8 800C2FC8 3E004010 */  beqz       $v0, .L800C30C4
    /* B37CC 800C2FCC 0300C230 */   andi      $v0, $a2, 0x3
    /* B37D0 800C2FD0 0400278E */  lw         $a3, 0x4($s1)
    /* B37D4 800C2FD4 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B37D8 800C2FD8 38002D8E */  lw         $t5, 0x38($s1)
    /* B37DC 800C2FDC 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B37E0 800C2FE0 80600C00 */  sll        $t4, $t4, 2
    /* B37E4 800C2FE4 2168AC01 */  addu       $t5, $t5, $t4
    /* B37E8 800C2FE8 04002EAE */  sw         $t6, 0x4($s1)
    /* B37EC 800C2FEC 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B37F0 800C2FF0 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B37F4 800C2FF4 02720E00 */  srl        $t6, $t6, 8
    /* B37F8 800C2FF8 2570CC01 */  or         $t6, $t6, $t4
    /* B37FC 800C2FFC 00620700 */  sll        $t4, $a3, 8
    /* B3800 800C3000 0000EEAC */  sw         $t6, 0x0($a3)
    /* B3804 800C3004 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B3808 800C3008 C400228E */  lw         $v0, 0xC4($s1)
    /* B380C 800C300C C800238E */  lw         $v1, 0xC8($s1)
    /* B3810 800C3010 CC00248E */  lw         $a0, 0xCC($s1)
    /* B3814 800C3014 0800E2AC */  sw         $v0, 0x8($a3)
    /* B3818 800C3018 0100C230 */  andi       $v0, $a2, 0x1
    /* B381C 800C301C 1000E3AC */  sw         $v1, 0x10($a3)
    /* B3820 800C3020 04004010 */  beqz       $v0, .L800C3034
    /* B3824 800C3024 1800E4AC */   sw        $a0, 0x18($a3)
    /* B3828 800C3028 9800228E */  lw         $v0, 0x98($s1)
    /* B382C 800C302C 160C0308 */  j          .L800C3058
    /* B3830 800C3030 0400E2AC */   sw        $v0, 0x4($a3)
  .L800C3034:
    /* B3834 800C3034 04000233 */  andi       $v0, $t8, 0x4
    /* B3838 800C3038 04004010 */  beqz       $v0, .L800C304C
    /* B383C 800C303C 00000000 */   nop
    /* B3840 800C3040 9400228E */  lw         $v0, 0x94($s1)
    /* B3844 800C3044 160C0308 */  j          .L800C3058
    /* B3848 800C3048 0400E2AC */   sw        $v0, 0x4($a3)
  .L800C304C:
    /* B384C 800C304C 9000228E */  lw         $v0, 0x90($s1)
    /* B3850 800C3050 00000000 */  nop
    /* B3854 800C3054 0400E2AC */  sw         $v0, 0x4($a3)
  .L800C3058:
    /* B3858 800C3058 0700F5A0 */  sb         $s5, 0x7($a3)
    /* B385C 800C305C 66002296 */  lhu        $v0, 0x66($s1)
    /* B3860 800C3060 6A002396 */  lhu        $v1, 0x6A($s1)
    /* B3864 800C3064 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B3868 800C3068 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B386C 800C306C 64002E92 */  lbu        $t6, 0x64($s1)
    /* B3870 800C3070 65002F92 */  lbu        $t7, 0x65($s1)
    /* B3874 800C3074 4000CE25 */  addiu      $t6, $t6, 0x40
    /* B3878 800C3078 D6006C91 */  lbu        $t4, 0xD6($t3)
    /* B387C 800C307C D7006D91 */  lbu        $t5, 0xD7($t3)
    /* B3880 800C3080 21608E01 */  addu       $t4, $t4, $t6
    /* B3884 800C3084 0C00ECA0 */  sb         $t4, 0xC($a3)
    /* B3888 800C3088 2168AF01 */  addu       $t5, $t5, $t7
    /* B388C 800C308C 0D00EDA0 */  sb         $t5, 0xD($a3)
    /* B3890 800C3090 D6004C91 */  lbu        $t4, 0xD6($t2)
    /* B3894 800C3094 D7004D91 */  lbu        $t5, 0xD7($t2)
    /* B3898 800C3098 21608E01 */  addu       $t4, $t4, $t6
    /* B389C 800C309C 1400ECA0 */  sb         $t4, 0x14($a3)
    /* B38A0 800C30A0 2168AF01 */  addu       $t5, $t5, $t7
    /* B38A4 800C30A4 1500EDA0 */  sb         $t5, 0x15($a3)
    /* B38A8 800C30A8 D6002C91 */  lbu        $t4, 0xD6($t1)
    /* B38AC 800C30AC D7002D91 */  lbu        $t5, 0xD7($t1)
    /* B38B0 800C30B0 21608E01 */  addu       $t4, $t4, $t6
    /* B38B4 800C30B4 1C00ECA0 */  sb         $t4, 0x1C($a3)
    /* B38B8 800C30B8 2168AF01 */  addu       $t5, $t5, $t7
    /* B38BC 800C30BC 1D00EDA0 */  sb         $t5, 0x1D($a3)
    /* B38C0 800C30C0 0300C230 */  andi       $v0, $a2, 0x3
  .L800C30C4:
    /* B38C4 800C30C4 44004010 */  beqz       $v0, .L800C31D8
    /* B38C8 800C30C8 FFFF4424 */   addiu     $a0, $v0, -0x1
    /* B38CC 800C30CC 02000391 */  lbu        $v1, 0x2($t0)
    /* B38D0 800C30D0 0400278E */  lw         $a3, 0x4($s1)
    /* B38D4 800C30D4 40100300 */  sll        $v0, $v1, 1
    /* B38D8 800C30D8 21104300 */  addu       $v0, $v0, $v1
    /* B38DC 800C30DC 21104400 */  addu       $v0, $v0, $a0
    /* B38E0 800C30E0 80100200 */  sll        $v0, $v0, 2
    /* B38E4 800C30E4 2130C202 */  addu       $a2, $s6, $v0
    /* B38E8 800C30E8 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B38EC 800C30EC 38002D8E */  lw         $t5, 0x38($s1)
    /* B38F0 800C30F0 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B38F4 800C30F4 80600C00 */  sll        $t4, $t4, 2
    /* B38F8 800C30F8 2168AC01 */  addu       $t5, $t5, $t4
    /* B38FC 800C30FC 04002EAE */  sw         $t6, 0x4($s1)
    /* B3900 800C3100 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B3904 800C3104 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B3908 800C3108 02720E00 */  srl        $t6, $t6, 8
    /* B390C 800C310C 2570CC01 */  or         $t6, $t6, $t4
    /* B3910 800C3110 00620700 */  sll        $t4, $a3, 8
    /* B3914 800C3114 0000EEAC */  sw         $t6, 0x0($a3)
    /* B3918 800C3118 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B391C 800C311C C400228E */  lw         $v0, 0xC4($s1)
    /* B3920 800C3120 C800238E */  lw         $v1, 0xC8($s1)
    /* B3924 800C3124 CC00248E */  lw         $a0, 0xCC($s1)
    /* B3928 800C3128 0800E2AC */  sw         $v0, 0x8($a3)
    /* B392C 800C312C 01000233 */  andi       $v0, $t8, 0x1
    /* B3930 800C3130 1000E3AC */  sw         $v1, 0x10($a3)
    /* B3934 800C3134 1800E4AC */  sw         $a0, 0x18($a3)
    /* B3938 800C3138 8C00238E */  lw         $v1, 0x8C($s1)
    /* B393C 800C313C 02004010 */  beqz       $v0, .L800C3148
    /* B3940 800C3140 24000524 */   addiu     $a1, $zero, 0x24
    /* B3944 800C3144 26000524 */  addiu      $a1, $zero, 0x26
  .L800C3148:
    /* B3948 800C3148 0400E3AC */  sw         $v1, 0x4($a3)
    /* B394C 800C314C 03004010 */  beqz       $v0, .L800C315C
    /* B3950 800C3150 0700E5A0 */   sb        $a1, 0x7($a3)
    /* B3954 800C3154 0200A234 */  ori        $v0, $a1, 0x2
    /* B3958 800C3158 0700E2A0 */  sb         $v0, 0x7($a3)
  .L800C315C:
    /* B395C 800C315C 02000391 */  lbu        $v1, 0x2($t0)
    /* B3960 800C3160 0000C284 */  lh         $v0, 0x0($a2)
    /* B3964 800C3164 0200C590 */  lbu        $a1, 0x2($a2)
    /* B3968 800C3168 0300C690 */  lbu        $a2, 0x3($a2)
    /* B396C 800C316C 21186200 */  addu       $v1, $v1, $v0
    /* B3970 800C3170 6000228E */  lw         $v0, 0x60($s1)
    /* B3974 800C3174 00190300 */  sll        $v1, $v1, 4
    /* B3978 800C3178 21104300 */  addu       $v0, $v0, $v1
    /* B397C 800C317C 02004394 */  lhu        $v1, 0x2($v0)
    /* B3980 800C3180 06004294 */  lhu        $v0, 0x6($v0)
    /* B3984 800C3184 0E00E3A4 */  sh         $v1, 0xE($a3)
    /* B3988 800C3188 1600E2A4 */  sh         $v0, 0x16($a3)
    /* B398C 800C318C 06000291 */  lbu        $v0, 0x6($t0)
    /* B3990 800C3190 08000391 */  lbu        $v1, 0x8($t0)
    /* B3994 800C3194 0A000491 */  lbu        $a0, 0xA($t0)
    /* B3998 800C3198 21104500 */  addu       $v0, $v0, $a1
    /* B399C 800C319C 21186500 */  addu       $v1, $v1, $a1
    /* B39A0 800C31A0 21208500 */  addu       $a0, $a0, $a1
    /* B39A4 800C31A4 0C00E2A0 */  sb         $v0, 0xC($a3)
    /* B39A8 800C31A8 1400E3A0 */  sb         $v1, 0x14($a3)
    /* B39AC 800C31AC 1C00E4A0 */  sb         $a0, 0x1C($a3)
    /* B39B0 800C31B0 07000291 */  lbu        $v0, 0x7($t0)
    /* B39B4 800C31B4 09000391 */  lbu        $v1, 0x9($t0)
    /* B39B8 800C31B8 0B000491 */  lbu        $a0, 0xB($t0)
    /* B39BC 800C31BC 21104600 */  addu       $v0, $v0, $a2
    /* B39C0 800C31C0 21186600 */  addu       $v1, $v1, $a2
    /* B39C4 800C31C4 21208600 */  addu       $a0, $a0, $a2
    /* B39C8 800C31C8 0D00E2A0 */  sb         $v0, 0xD($a3)
    /* B39CC 800C31CC 1500E3A0 */  sb         $v1, 0x15($a3)
    /* B39D0 800C31D0 AD0A0308 */  j          .L800C2AB4
    /* B39D4 800C31D4 1D00E4A0 */   sb        $a0, 0x1D($a3)
  .L800C31D8:
    /* B39D8 800C31D8 0400278E */  lw         $a3, 0x4($s1)
    /* B39DC 800C31DC 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B39E0 800C31E0 38002D8E */  lw         $t5, 0x38($s1)
    /* B39E4 800C31E4 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B39E8 800C31E8 80600C00 */  sll        $t4, $t4, 2
    /* B39EC 800C31EC 2168AC01 */  addu       $t5, $t5, $t4
    /* B39F0 800C31F0 04002EAE */  sw         $t6, 0x4($s1)
    /* B39F4 800C31F4 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B39F8 800C31F8 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B39FC 800C31FC 02720E00 */  srl        $t6, $t6, 8
    /* B3A00 800C3200 2570CC01 */  or         $t6, $t6, $t4
    /* B3A04 800C3204 00620700 */  sll        $t4, $a3, 8
    /* B3A08 800C3208 0000EEAC */  sw         $t6, 0x0($a3)
    /* B3A0C 800C320C 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B3A10 800C3210 C400228E */  lw         $v0, 0xC4($s1)
    /* B3A14 800C3214 C800238E */  lw         $v1, 0xC8($s1)
    /* B3A18 800C3218 CC00248E */  lw         $a0, 0xCC($s1)
    /* B3A1C 800C321C 0800E2AC */  sw         $v0, 0x8($a3)
    /* B3A20 800C3220 01000233 */  andi       $v0, $t8, 0x1
    /* B3A24 800C3224 1000E3AC */  sw         $v1, 0x10($a3)
    /* B3A28 800C3228 1800E4AC */  sw         $a0, 0x18($a3)
    /* B3A2C 800C322C 8C00238E */  lw         $v1, 0x8C($s1)
    /* B3A30 800C3230 02004010 */  beqz       $v0, .L800C323C
    /* B3A34 800C3234 24000524 */   addiu     $a1, $zero, 0x24
    /* B3A38 800C3238 26000524 */  addiu      $a1, $zero, 0x26
  .L800C323C:
    /* B3A3C 800C323C 0400E3AC */  sw         $v1, 0x4($a3)
    /* B3A40 800C3240 0700E5A0 */  sb         $a1, 0x7($a3)
    /* B3A44 800C3244 02000291 */  lbu        $v0, 0x2($t0)
    /* B3A48 800C3248 6000238E */  lw         $v1, 0x60($s1)
    /* B3A4C 800C324C 00110200 */  sll        $v0, $v0, 4
    /* B3A50 800C3250 21186200 */  addu       $v1, $v1, $v0
    /* B3A54 800C3254 02006294 */  lhu        $v0, 0x2($v1)
    /* B3A58 800C3258 06006394 */  lhu        $v1, 0x6($v1)
    /* B3A5C 800C325C 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B3A60 800C3260 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B3A64 800C3264 06000295 */  lhu        $v0, 0x6($t0)
    /* B3A68 800C3268 08000395 */  lhu        $v1, 0x8($t0)
    /* B3A6C 800C326C 0A000495 */  lhu        $a0, 0xA($t0)
    /* B3A70 800C3270 0C00E2A4 */  sh         $v0, 0xC($a3)
    /* B3A74 800C3274 1400E3A4 */  sh         $v1, 0x14($a3)
    /* B3A78 800C3278 AD0A0308 */  j          .L800C2AB4
    /* B3A7C 800C327C 1C00E4A4 */   sh        $a0, 0x1C($a3)
  .L800C3280:
    /* B3A80 800C3280 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* B3A84 800C3284 4800BE8F */  lw         $fp, 0x48($sp)
    /* B3A88 800C3288 4400B78F */  lw         $s7, 0x44($sp)
    /* B3A8C 800C328C 4000B68F */  lw         $s6, 0x40($sp)
    /* B3A90 800C3290 3C00B58F */  lw         $s5, 0x3C($sp)
    /* B3A94 800C3294 3800B48F */  lw         $s4, 0x38($sp)
    /* B3A98 800C3298 3400B38F */  lw         $s3, 0x34($sp)
    /* B3A9C 800C329C 3000B28F */  lw         $s2, 0x30($sp)
    /* B3AA0 800C32A0 2C00B18F */  lw         $s1, 0x2C($sp)
    /* B3AA4 800C32A4 2800B08F */  lw         $s0, 0x28($sp)
    /* B3AA8 800C32A8 0800E003 */  jr         $ra
    /* B3AAC 800C32AC 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
