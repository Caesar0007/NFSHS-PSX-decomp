.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrackSpec_Read__Fi, 0xFC

glabel TrackSpec_Read__Fi
    /* D1FD0 800E17D0 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* D1FD4 800E17D4 6800B2AF */  sw         $s2, 0x68($sp)
    /* D1FD8 800E17D8 21908000 */  addu       $s2, $a0, $zero
    /* D1FDC 800E17DC 1000A427 */  addiu      $a0, $sp, 0x10
    /* D1FE0 800E17E0 1180023C */  lui        $v0, %hi(D_80116480)
    /* D1FE4 800E17E4 8064468C */  lw         $a2, %lo(D_80116480)($v0)
    /* D1FE8 800E17E8 1180023C */  lui        $v0, %hi(D_80113228)
    /* D1FEC 800E17EC 0580053C */  lui        $a1, %hi(D_80056AC4)
    /* D1FF0 800E17F0 2832478C */  lw         $a3, %lo(D_80113228)($v0)
    /* D1FF4 800E17F4 C46AA524 */  addiu      $a1, $a1, %lo(D_80056AC4)
    /* D1FF8 800E17F8 7000BFAF */  sw         $ra, 0x70($sp)
    /* D1FFC 800E17FC 6C00B3AF */  sw         $s3, 0x6C($sp)
    /* D2000 800E1800 6400B1AF */  sw         $s1, 0x64($sp)
    /* D2004 800E1804 2F91030C */  jal        sprintf
    /* D2008 800E1808 6000B0AF */   sw        $s0, 0x60($sp)
    /* D200C 800E180C 1000A427 */  addiu      $a0, $sp, 0x10
    /* D2010 800E1810 FA95030C */  jal        loadfileadr
    /* D2014 800E1814 21280000 */   addu      $a1, $zero, $zero
    /* D2018 800E1818 21804000 */  addu       $s0, $v0, $zero
    /* D201C 800E181C 21980002 */  addu       $s3, $s0, $zero
    /* D2020 800E1820 23000012 */  beqz       $s0, .L800E18B0
    /* D2024 800E1824 5800A2AF */   sw        $v0, 0x58($sp)
    /* D2028 800E1828 5800B127 */  addiu      $s1, $sp, 0x58
    /* D202C 800E182C 21202002 */  addu       $a0, $s1, $zero
    /* D2030 800E1830 5000A527 */  addiu      $a1, $sp, 0x50
    /* D2034 800E1834 481692AF */  sw         $s2, %gp_rel(TrackSpec_gCurrentSpec)($gp)
    /* D2038 800E1838 441692AF */  sw         $s2, %gp_rel(TrackSpec_gPrevSpec)($gp)
    /* D203C 800E183C E885030C */  jal        read__FPPcPvi
    /* D2040 800E1840 08000624 */   addiu     $a2, $zero, 0x8
    /* D2044 800E1844 5400A38F */  lw         $v1, 0x54($sp)
    /* D2048 800E1848 00000000 */  nop
    /* D204C 800E184C 2A104302 */  slt        $v0, $s2, $v1
    /* D2050 800E1850 06004014 */  bnez       $v0, .L800E186C
    /* D2054 800E1854 1280053C */   lui       $a1, %hi(TrackSpec_gSpec)
    /* D2058 800E1858 1280043C */  lui        $a0, %hi(TrackSpec_gSpec)
    /* D205C 800E185C 5185030C */  jal        TrackSpec_SetDefault__FP10CTrackSpec
    /* D2060 800E1860 7C328424 */   addiu     $a0, $a0, %lo(TrackSpec_gSpec)
    /* D2064 800E1864 2A860308 */  j          .L800E18A8
    /* D2068 800E1868 21200002 */   addu      $a0, $s0, $zero
  .L800E186C:
    /* D206C 800E186C 21202002 */  addu       $a0, $s1, $zero
    /* D2070 800E1870 7C32A524 */  addiu      $a1, $a1, %lo(TrackSpec_gSpec)
    /* D2074 800E1874 08010624 */  addiu      $a2, $zero, 0x108
    /* D2078 800E1878 01006224 */  addiu      $v0, $v1, 0x1
    /* D207C 800E187C 4C1682AF */  sw         $v0, %gp_rel(TrackSpec_gMaxSpec)($gp)
    /* D2080 800E1880 40111200 */  sll        $v0, $s2, 5
    /* D2084 800E1884 21105200 */  addu       $v0, $v0, $s2
    /* D2088 800E1888 5800A38F */  lw         $v1, 0x58($sp)
    /* D208C 800E188C C0100200 */  sll        $v0, $v0, 3
    /* D2090 800E1890 21186200 */  addu       $v1, $v1, $v0
    /* D2094 800E1894 E885030C */  jal        read__FPPcPvi
    /* D2098 800E1898 5800A3AF */   sw        $v1, 0x58($sp)
    /* D209C 800E189C DF85030C */  jal        TrackSpec_SetUp__Fv
    /* D20A0 800E18A0 00000000 */   nop
    /* D20A4 800E18A4 21206002 */  addu       $a0, $s3, $zero
  .L800E18A8:
    /* D20A8 800E18A8 5095030C */  jal        purgememadr
    /* D20AC 800E18AC 00000000 */   nop
  .L800E18B0:
    /* D20B0 800E18B0 7000BF8F */  lw         $ra, 0x70($sp)
    /* D20B4 800E18B4 6C00B38F */  lw         $s3, 0x6C($sp)
    /* D20B8 800E18B8 6800B28F */  lw         $s2, 0x68($sp)
    /* D20BC 800E18BC 6400B18F */  lw         $s1, 0x64($sp)
    /* D20C0 800E18C0 6000B08F */  lw         $s0, 0x60($sp)
    /* D20C4 800E18C4 0800E003 */  jr         $ra
    /* D20C8 800E18C8 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel TrackSpec_Read__Fi
