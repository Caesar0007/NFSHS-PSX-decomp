.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii, 0x34C

glabel R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii
    /* A15B0 800B0DB0 78FFBD27 */  addiu      $sp, $sp, -0x88
    /* A15B4 800B0DB4 7000B4AF */  sw         $s4, 0x70($sp)
    /* A15B8 800B0DB8 21A08000 */  addu       $s4, $a0, $zero
    /* A15BC 800B0DBC 7C00B7AF */  sw         $s7, 0x7C($sp)
    /* A15C0 800B0DC0 21B8A000 */  addu       $s7, $a1, $zero
    /* A15C4 800B0DC4 7400B5AF */  sw         $s5, 0x74($sp)
    /* A15C8 800B0DC8 21A8C000 */  addu       $s5, $a2, $zero
    /* A15CC 800B0DCC 7800B6AF */  sw         $s6, 0x78($sp)
    /* A15D0 800B0DD0 21B0E000 */  addu       $s6, $a3, $zero
    /* A15D4 800B0DD4 1000A427 */  addiu      $a0, $sp, 0x10
    /* A15D8 800B0DD8 8000BFAF */  sw         $ra, 0x80($sp)
    /* A15DC 800B0DDC 6C00B3AF */  sw         $s3, 0x6C($sp)
    /* A15E0 800B0DE0 6800B2AF */  sw         $s2, 0x68($sp)
    /* A15E4 800B0DE4 6400B1AF */  sw         $s1, 0x64($sp)
    /* A15E8 800B0DE8 6000B0AF */  sw         $s0, 0x60($sp)
    /* A15EC 800B0DEC 8802828E */  lw         $v0, 0x288($s4)
    /* A15F0 800B0DF0 BC089086 */  lh         $s0, 0x8BC($s4)
    /* A15F4 800B0DF4 A000468C */  lw         $a2, 0xA0($v0)
    /* A15F8 800B0DF8 A6BB020C */  jal        R3DCar_GetCarName__FPcii
    /* A15FC 800B0DFC 21280002 */   addu      $a1, $s0, $zero
    /* A1600 800B0E00 0300A012 */  beqz       $s5, .L800B0E10
    /* A1604 800B0E04 00000000 */   nop
    /* A1608 800B0E08 D6F4020C */  jal        CarIO_ReleaseCarCluts__FP8Car_tObj
    /* A160C 800B0E0C 21208002 */   addu      $a0, $s4, $zero
  .L800B0E10:
    /* A1610 800B0E10 8408828E */  lw         $v0, 0x884($s4)
    /* A1614 800B0E14 00000000 */  nop
    /* A1618 800B0E18 06004014 */  bnez       $v0, .L800B0E34
    /* A161C 800B0E1C 1480043C */   lui       $a0, %hi(D_8013D368)
    /* A1620 800B0E20 68D38424 */  addiu      $a0, $a0, %lo(D_8013D368)
    /* A1624 800B0E24 A0280524 */  addiu      $a1, $zero, 0x28A0
    /* A1628 800B0E28 CF94030C */  jal        reservememadr
    /* A162C 800B0E2C 21300000 */   addu      $a2, $zero, $zero
    /* A1630 800B0E30 840882AE */  sw         $v0, 0x884($s4)
  .L800B0E34:
    /* A1634 800B0E34 1FB6030C */  jal        DrawSync
    /* A1638 800B0E38 21200000 */   addu      $a0, $zero, $zero
    /* A163C 800B0E3C 1480013C */  lui        $at, %hi(Texture_palNum)
    /* A1640 800B0E40 10DB20AC */  sw         $zero, %lo(Texture_palNum)($at)
    /* A1644 800B0E44 1C00022A */  slti       $v0, $s0, 0x1C
    /* A1648 800B0E48 7B004010 */  beqz       $v0, .L800B1038
    /* A164C 800B0E4C 00000000 */   nop
    /* A1650 800B0E50 C0088296 */  lhu        $v0, 0x8C0($s4)
    /* A1654 800B0E54 00000000 */  nop
    /* A1658 800B0E58 01004230 */  andi       $v0, $v0, 0x1
    /* A165C 800B0E5C 06004010 */  beqz       $v0, .L800B0E78
    /* A1660 800B0E60 21980000 */   addu      $s3, $zero, $zero
    /* A1664 800B0E64 2000A427 */  addiu      $a0, $sp, 0x20
    /* A1668 800B0E68 1000A527 */  addiu      $a1, $sp, 0x10
    /* A166C 800B0E6C 1480063C */  lui        $a2, %hi(D_8013D358)
    /* A1670 800B0E70 A2C30208 */  j          .L800B0E88
    /* A1674 800B0E74 58D3C624 */   addiu     $a2, $a2, %lo(D_8013D358)
  .L800B0E78:
    /* A1678 800B0E78 2000A427 */  addiu      $a0, $sp, 0x20
    /* A167C 800B0E7C 1000A527 */  addiu      $a1, $sp, 0x10
    /* A1680 800B0E80 1480063C */  lui        $a2, %hi(D_8013D370)
    /* A1684 800B0E84 70D3C624 */  addiu      $a2, $a2, %lo(D_8013D370)
  .L800B0E88:
    /* A1688 800B0E88 7DBB020C */  jal        R3DCar_GetFileName__FPcN20
    /* A168C 800B0E8C 01007326 */   addiu     $s3, $s3, 0x1
    /* A1690 800B0E90 C0088296 */  lhu        $v0, 0x8C0($s4)
    /* A1694 800B0E94 00000000 */  nop
    /* A1698 800B0E98 01004230 */  andi       $v0, $v0, 0x1
    /* A169C 800B0E9C 09004010 */  beqz       $v0, .L800B0EC4
    /* A16A0 800B0EA0 2000A427 */   addiu     $a0, $sp, 0x20
    /* A16A4 800B0EA4 00111300 */  sll        $v0, $s3, 4
    /* A16A8 800B0EA8 23105300 */  subu       $v0, $v0, $s3
    /* A16AC 800B0EAC 21208200 */  addu       $a0, $a0, $v0
    /* A16B0 800B0EB0 1000A527 */  addiu      $a1, $sp, 0x10
    /* A16B4 800B0EB4 1480063C */  lui        $a2, %hi(D_8013D374)
    /* A16B8 800B0EB8 7DBB020C */  jal        R3DCar_GetFileName__FPcN20
    /* A16BC 800B0EBC 74D3C624 */   addiu     $a2, $a2, %lo(D_8013D374)
    /* A16C0 800B0EC0 01007326 */  addiu      $s3, $s3, 0x1
  .L800B0EC4:
    /* A16C4 800B0EC4 40088286 */  lh         $v0, 0x840($s4)
    /* A16C8 800B0EC8 00000000 */  nop
    /* A16CC 800B0ECC 08004228 */  slti       $v0, $v0, 0x8
    /* A16D0 800B0ED0 08004014 */  bnez       $v0, .L800B0EF4
    /* A16D4 800B0ED4 2000A427 */   addiu     $a0, $sp, 0x20
    /* A16D8 800B0ED8 00111300 */  sll        $v0, $s3, 4
    /* A16DC 800B0EDC 23105300 */  subu       $v0, $v0, $s3
    /* A16E0 800B0EE0 21208200 */  addu       $a0, $a0, $v0
    /* A16E4 800B0EE4 1000A527 */  addiu      $a1, $sp, 0x10
    /* A16E8 800B0EE8 1480063C */  lui        $a2, %hi(D_8013D378)
    /* A16EC 800B0EEC C3C30208 */  j          .L800B0F0C
    /* A16F0 800B0EF0 78D3C624 */   addiu     $a2, $a2, %lo(D_8013D378)
  .L800B0EF4:
    /* A16F4 800B0EF4 00111300 */  sll        $v0, $s3, 4
    /* A16F8 800B0EF8 23105300 */  subu       $v0, $v0, $s3
    /* A16FC 800B0EFC 21208200 */  addu       $a0, $a0, $v0
    /* A1700 800B0F00 1000A527 */  addiu      $a1, $sp, 0x10
    /* A1704 800B0F04 1480063C */  lui        $a2, %hi(D_8013D37C)
    /* A1708 800B0F08 7CD3C624 */  addiu      $a2, $a2, %lo(D_8013D37C)
  .L800B0F0C:
    /* A170C 800B0F0C 7DBB020C */  jal        R3DCar_GetFileName__FPcN20
    /* A1710 800B0F10 01007326 */   addiu     $s3, $s3, 0x1
    /* A1714 800B0F14 0C00601A */  blez       $s3, .L800B0F48
    /* A1718 800B0F18 21800000 */   addu      $s0, $zero, $zero
    /* A171C 800B0F1C 5000B227 */  addiu      $s2, $sp, 0x50
    /* A1720 800B0F20 2000B127 */  addiu      $s1, $sp, 0x20
  .L800B0F24:
    /* A1724 800B0F24 2120E002 */  addu       $a0, $s7, $zero
    /* A1728 800B0F28 8698030C */  jal        locatebig
    /* A172C 800B0F2C 21282002 */   addu      $a1, $s1, $zero
    /* A1730 800B0F30 000042AE */  sw         $v0, 0x0($s2)
    /* A1734 800B0F34 04005226 */  addiu      $s2, $s2, 0x4
    /* A1738 800B0F38 01001026 */  addiu      $s0, $s0, 0x1
    /* A173C 800B0F3C 2A101302 */  slt        $v0, $s0, $s3
    /* A1740 800B0F40 F8FF4014 */  bnez       $v0, .L800B0F24
    /* A1744 800B0F44 0F003126 */   addiu     $s1, $s1, 0xF
  .L800B0F48:
    /* A1748 800B0F48 CA0880A6 */  sh         $zero, 0x8CA($s4)
    /* A174C 800B0F4C 0200A012 */  beqz       $s5, .L800B0F58
    /* A1750 800B0F50 C80880A6 */   sh        $zero, 0x8C8($s4)
    /* A1754 800B0F54 11001524 */  addiu      $s5, $zero, 0x11
  .L800B0F58:
    /* A1758 800B0F58 21288002 */  addu       $a1, $s4, $zero
    /* A175C 800B0F5C 2130A002 */  addu       $a2, $s5, $zero
    /* A1760 800B0F60 2138C002 */  addu       $a3, $s6, $zero
    /* A1764 800B0F64 5000A48F */  lw         $a0, 0x50($sp)
    /* A1768 800B0F68 C1F1020C */  jal        CarIO_ReadInCarTextureData__FPcP8Car_tObjii
    /* A176C 800B0F6C 01001324 */   addiu     $s3, $zero, 0x1
    /* A1770 800B0F70 C0088296 */  lhu        $v0, 0x8C0($s4)
    /* A1774 800B0F74 00000000 */  nop
    /* A1778 800B0F78 24105300 */  and        $v0, $v0, $s3
    /* A177C 800B0F7C 07004010 */  beqz       $v0, .L800B0F9C
    /* A1780 800B0F80 5000B027 */   addiu     $s0, $sp, 0x50
    /* A1784 800B0F84 5400A48F */  lw         $a0, 0x54($sp)
    /* A1788 800B0F88 21288002 */  addu       $a1, $s4, $zero
    /* A178C 800B0F8C 19000624 */  addiu      $a2, $zero, 0x19
    /* A1790 800B0F90 2138C002 */  addu       $a3, $s6, $zero
    /* A1794 800B0F94 C1F1020C */  jal        CarIO_ReadInCarTextureData__FPcP8Car_tObjii
    /* A1798 800B0F98 02001324 */   addiu     $s3, $zero, 0x2
  .L800B0F9C:
    /* A179C 800B0F9C 0200A016 */  bnez       $s5, .L800B0FA8
    /* A17A0 800B0FA0 21288002 */   addu      $a1, $s4, $zero
    /* A17A4 800B0FA4 91001524 */  addiu      $s5, $zero, 0x91
  .L800B0FA8:
    /* A17A8 800B0FA8 2130A002 */  addu       $a2, $s5, $zero
    /* A17AC 800B0FAC 80101300 */  sll        $v0, $s3, 2
    /* A17B0 800B0FB0 21100202 */  addu       $v0, $s0, $v0
    /* A17B4 800B0FB4 0000448C */  lw         $a0, 0x0($v0)
    /* A17B8 800B0FB8 C1F1020C */  jal        CarIO_ReadInCarTextureData__FPcP8Car_tObjii
    /* A17BC 800B0FBC 2138C002 */   addu      $a3, $s6, $zero
    /* A17C0 800B0FC0 1480023C */  lui        $v0, %hi(Texture_palNum)
    /* A17C4 800B0FC4 10DB4294 */  lhu        $v0, %lo(Texture_palNum)($v0)
    /* A17C8 800B0FC8 21200000 */  addu       $a0, $zero, $zero
    /* A17CC 800B0FCC 1FB6030C */  jal        DrawSync
    /* A17D0 800B0FD0 880882A6 */   sh        $v0, 0x888($s4)
    /* A17D4 800B0FD4 21280000 */  addu       $a1, $zero, $zero
    /* A17D8 800B0FD8 8408848E */  lw         $a0, 0x884($s4)
    /* A17DC 800B0FDC 40088396 */  lhu        $v1, 0x840($s4)
    /* A17E0 800B0FE0 B3088292 */  lbu        $v0, 0x8B3($s4)
    /* A17E4 800B0FE4 07006330 */  andi       $v1, $v1, 0x7
    /* A17E8 800B0FE8 02004230 */  andi       $v0, $v0, 0x2
    /* A17EC 800B0FEC 80100200 */  sll        $v0, $v0, 2
    /* A17F0 800B0FF0 21186200 */  addu       $v1, $v1, $v0
    /* A17F4 800B0FF4 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* A17F8 800B0FF8 08DB23AC */  sw         $v1, %lo(Texture_CarColor)($at)
    /* A17FC 800B0FFC A77E030C */  jal        Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
    /* A1800 800B1000 01000624 */   addiu     $a2, $zero, 0x1
    /* A1804 800B1004 01000524 */  addiu      $a1, $zero, 0x1
    /* A1808 800B1008 8408848E */  lw         $a0, 0x884($s4)
    /* A180C 800B100C 88088686 */  lh         $a2, 0x888($s4)
    /* A1810 800B1010 40088396 */  lhu        $v1, 0x840($s4)
    /* A1814 800B1014 B3088292 */  lbu        $v0, 0x8B3($s4)
    /* A1818 800B1018 07006330 */  andi       $v1, $v1, 0x7
    /* A181C 800B101C 24104500 */  and        $v0, $v0, $a1
    /* A1820 800B1020 C0100200 */  sll        $v0, $v0, 3
    /* A1824 800B1024 21186200 */  addu       $v1, $v1, $v0
    /* A1828 800B1028 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* A182C 800B102C 08DB23AC */  sw         $v1, %lo(Texture_CarColor)($at)
    /* A1830 800B1030 30C40208 */  j          .L800B10C0
    /* A1834 800B1034 00000000 */   nop
  .L800B1038:
    /* A1838 800B1038 2000B027 */  addiu      $s0, $sp, 0x20
    /* A183C 800B103C 21200002 */  addu       $a0, $s0, $zero
    /* A1840 800B1040 CA96030C */  jal        strcpy
    /* A1844 800B1044 1000A527 */   addiu     $a1, $sp, 0x10
    /* A1848 800B1048 21200002 */  addu       $a0, $s0, $zero
    /* A184C 800B104C 1480053C */  lui        $a1, %hi(D_8013D340)
    /* A1850 800B1050 3A9E030C */  jal        strcat
    /* A1854 800B1054 40D3A524 */   addiu     $a1, $a1, %lo(D_8013D340)
    /* A1858 800B1058 2120E002 */  addu       $a0, $s7, $zero
    /* A185C 800B105C 8698030C */  jal        locatebig
    /* A1860 800B1060 21280002 */   addu      $a1, $s0, $zero
    /* A1864 800B1064 CA0880A6 */  sh         $zero, 0x8CA($s4)
    /* A1868 800B1068 0300A012 */  beqz       $s5, .L800B1078
    /* A186C 800B106C C80880A6 */   sh        $zero, 0x8C8($s4)
    /* A1870 800B1070 1FC40208 */  j          .L800B107C
    /* A1874 800B1074 11001524 */   addiu     $s5, $zero, 0x11
  .L800B1078:
    /* A1878 800B1078 80001524 */  addiu      $s5, $zero, 0x80
  .L800B107C:
    /* A187C 800B107C 21204000 */  addu       $a0, $v0, $zero
    /* A1880 800B1080 21288002 */  addu       $a1, $s4, $zero
    /* A1884 800B1084 2130A002 */  addu       $a2, $s5, $zero
    /* A1888 800B1088 C1F1020C */  jal        CarIO_ReadInCarTextureData__FPcP8Car_tObjii
    /* A188C 800B108C 21380000 */   addu      $a3, $zero, $zero
    /* A1890 800B1090 1480023C */  lui        $v0, %hi(Texture_palNum)
    /* A1894 800B1094 10DB4294 */  lhu        $v0, %lo(Texture_palNum)($v0)
    /* A1898 800B1098 21200000 */  addu       $a0, $zero, $zero
    /* A189C 800B109C 1FB6030C */  jal        DrawSync
    /* A18A0 800B10A0 880882A6 */   sh        $v0, 0x888($s4)
    /* A18A4 800B10A4 21280000 */  addu       $a1, $zero, $zero
    /* A18A8 800B10A8 8408848E */  lw         $a0, 0x884($s4)
    /* A18AC 800B10AC 40088296 */  lhu        $v0, 0x840($s4)
    /* A18B0 800B10B0 88088686 */  lh         $a2, 0x888($s4)
    /* A18B4 800B10B4 07004230 */  andi       $v0, $v0, 0x7
    /* A18B8 800B10B8 1480013C */  lui        $at, %hi(Texture_CarColor)
    /* A18BC 800B10BC 08DB22AC */  sw         $v0, %lo(Texture_CarColor)($at)
  .L800B10C0:
    /* A18C0 800B10C0 A77E030C */  jal        Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
    /* A18C4 800B10C4 00000000 */   nop
    /* A18C8 800B10C8 5095030C */  jal        purgememadr
    /* A18CC 800B10CC 2120E002 */   addu      $a0, $s7, $zero
    /* A18D0 800B10D0 8000BF8F */  lw         $ra, 0x80($sp)
    /* A18D4 800B10D4 7C00B78F */  lw         $s7, 0x7C($sp)
    /* A18D8 800B10D8 7800B68F */  lw         $s6, 0x78($sp)
    /* A18DC 800B10DC 7400B58F */  lw         $s5, 0x74($sp)
    /* A18E0 800B10E0 7000B48F */  lw         $s4, 0x70($sp)
    /* A18E4 800B10E4 6C00B38F */  lw         $s3, 0x6C($sp)
    /* A18E8 800B10E8 6800B28F */  lw         $s2, 0x68($sp)
    /* A18EC 800B10EC 6400B18F */  lw         $s1, 0x64($sp)
    /* A18F0 800B10F0 6000B08F */  lw         $s0, 0x60($sp)
    /* A18F4 800B10F4 0800E003 */  jr         $ra
    /* A18F8 800B10F8 8800BD27 */   addiu     $sp, $sp, 0x88
endlabel R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii
