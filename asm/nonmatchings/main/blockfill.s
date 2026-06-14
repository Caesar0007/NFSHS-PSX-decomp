.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching blockfill, 0x140

glabel blockfill
    /* E1FA4 800F17A4 0400A128 */  slti       $at, $a1, 0x4
    /* E1FA8 800F17A8 46002014 */  bnez       $at, .L800F18C4
    /* E1FAC 800F17AC FF00C630 */   andi      $a2, $a2, 0xFF
    /* E1FB0 800F17B0 00520600 */  sll        $t2, $a2, 8
    /* E1FB4 800F17B4 2530CA00 */  or         $a2, $a2, $t2
    /* E1FB8 800F17B8 00540600 */  sll        $t2, $a2, 16
    /* E1FBC 800F17BC 2530CA00 */  or         $a2, $a2, $t2
    /* E1FC0 800F17C0 000086B8 */  swr        $a2, 0x0($a0)
    /* E1FC4 800F17C4 04000824 */  addiu      $t0, $zero, 0x4
    /* E1FC8 800F17C8 03008930 */  andi       $t1, $a0, 0x3
    /* E1FCC 800F17CC 23400901 */  subu       $t0, $t0, $t1
    /* E1FD0 800F17D0 21208800 */  addu       $a0, $a0, $t0
    /* E1FD4 800F17D4 2328A800 */  subu       $a1, $a1, $t0
    /* E1FD8 800F17D8 80FFA524 */  addiu      $a1, $a1, -0x80
    /* E1FDC 800F17DC 2400A004 */  bltz       $a1, .L800F1870
    /* E1FE0 800F17E0 00000000 */   nop
  .L800F17E4:
    /* E1FE4 800F17E4 000086AC */  sw         $a2, 0x0($a0)
    /* E1FE8 800F17E8 040086AC */  sw         $a2, 0x4($a0)
    /* E1FEC 800F17EC 080086AC */  sw         $a2, 0x8($a0)
    /* E1FF0 800F17F0 0C0086AC */  sw         $a2, 0xC($a0)
    /* E1FF4 800F17F4 100086AC */  sw         $a2, 0x10($a0)
    /* E1FF8 800F17F8 140086AC */  sw         $a2, 0x14($a0)
    /* E1FFC 800F17FC 180086AC */  sw         $a2, 0x18($a0)
    /* E2000 800F1800 1C0086AC */  sw         $a2, 0x1C($a0)
    /* E2004 800F1804 200086AC */  sw         $a2, 0x20($a0)
    /* E2008 800F1808 240086AC */  sw         $a2, 0x24($a0)
    /* E200C 800F180C 280086AC */  sw         $a2, 0x28($a0)
    /* E2010 800F1810 2C0086AC */  sw         $a2, 0x2C($a0)
    /* E2014 800F1814 300086AC */  sw         $a2, 0x30($a0)
    /* E2018 800F1818 340086AC */  sw         $a2, 0x34($a0)
    /* E201C 800F181C 380086AC */  sw         $a2, 0x38($a0)
    /* E2020 800F1820 3C0086AC */  sw         $a2, 0x3C($a0)
    /* E2024 800F1824 400086AC */  sw         $a2, 0x40($a0)
    /* E2028 800F1828 440086AC */  sw         $a2, 0x44($a0)
    /* E202C 800F182C 480086AC */  sw         $a2, 0x48($a0)
    /* E2030 800F1830 4C0086AC */  sw         $a2, 0x4C($a0)
    /* E2034 800F1834 500086AC */  sw         $a2, 0x50($a0)
    /* E2038 800F1838 540086AC */  sw         $a2, 0x54($a0)
    /* E203C 800F183C 580086AC */  sw         $a2, 0x58($a0)
    /* E2040 800F1840 5C0086AC */  sw         $a2, 0x5C($a0)
    /* E2044 800F1844 600086AC */  sw         $a2, 0x60($a0)
    /* E2048 800F1848 640086AC */  sw         $a2, 0x64($a0)
    /* E204C 800F184C 680086AC */  sw         $a2, 0x68($a0)
    /* E2050 800F1850 6C0086AC */  sw         $a2, 0x6C($a0)
    /* E2054 800F1854 700086AC */  sw         $a2, 0x70($a0)
    /* E2058 800F1858 740086AC */  sw         $a2, 0x74($a0)
    /* E205C 800F185C 780086AC */  sw         $a2, 0x78($a0)
    /* E2060 800F1860 7C0086AC */  sw         $a2, 0x7C($a0)
    /* E2064 800F1864 80FFA524 */  addiu      $a1, $a1, -0x80
    /* E2068 800F1868 DEFFA104 */  bgez       $a1, .L800F17E4
    /* E206C 800F186C 80008424 */   addiu     $a0, $a0, 0x80
  .L800F1870:
    /* E2070 800F1870 7000A524 */  addiu      $a1, $a1, 0x70
    /* E2074 800F1874 0800A004 */  bltz       $a1, .L800F1898
    /* E2078 800F1878 00000000 */   nop
  .L800F187C:
    /* E207C 800F187C 000086AC */  sw         $a2, 0x0($a0)
    /* E2080 800F1880 040086AC */  sw         $a2, 0x4($a0)
    /* E2084 800F1884 080086AC */  sw         $a2, 0x8($a0)
    /* E2088 800F1888 0C0086AC */  sw         $a2, 0xC($a0)
    /* E208C 800F188C F0FFA524 */  addiu      $a1, $a1, -0x10
    /* E2090 800F1890 FAFFA104 */  bgez       $a1, .L800F187C
    /* E2094 800F1894 10008424 */   addiu     $a0, $a0, 0x10
  .L800F1898:
    /* E2098 800F1898 0C00A524 */  addiu      $a1, $a1, 0xC
    /* E209C 800F189C 0500A004 */  bltz       $a1, .L800F18B4
    /* E20A0 800F18A0 00000000 */   nop
  .L800F18A4:
    /* E20A4 800F18A4 000086AC */  sw         $a2, 0x0($a0)
    /* E20A8 800F18A8 FCFFA524 */  addiu      $a1, $a1, -0x4
    /* E20AC 800F18AC FDFFA104 */  bgez       $a1, .L800F18A4
    /* E20B0 800F18B0 04008424 */   addiu     $a0, $a0, 0x4
  .L800F18B4:
    /* E20B4 800F18B4 21208500 */  addu       $a0, $a0, $a1
    /* E20B8 800F18B8 030086A8 */  swl        $a2, 0x3($a0)
    /* E20BC 800F18BC 0800E003 */  jr         $ra
    /* E20C0 800F18C0 00000000 */   nop
  .L800F18C4:
    /* E20C4 800F18C4 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* E20C8 800F18C8 0400A004 */  bltz       $a1, .L800F18DC
  .L800F18CC:
    /* E20CC 800F18CC FFFFA524 */   addiu     $a1, $a1, -0x1
    /* E20D0 800F18D0 000086A0 */  sb         $a2, 0x0($a0)
    /* E20D4 800F18D4 FDFFA104 */  bgez       $a1, .L800F18CC
    /* E20D8 800F18D8 01008424 */   addiu     $a0, $a0, 0x1
  .L800F18DC:
    /* E20DC 800F18DC 0800E003 */  jr         $ra
    /* E20E0 800F18E0 00000000 */   nop
endlabel blockfill
