.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_Init__Fv, 0x34C

glabel Weather_Init__Fv
    /* D2D30 800E2530 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D2D34 800E2534 1280043C */  lui        $a0, %hi(D_8012329C)
    /* D2D38 800E2538 1180023C */  lui        $v0, %hi(D_80113234)
    /* D2D3C 800E253C 3432438C */  lw         $v1, %lo(D_80113234)($v0)
    /* D2D40 800E2540 9C328224 */  addiu      $v0, $a0, %lo(D_8012329C)
    /* D2D44 800E2544 2000BFAF */  sw         $ra, 0x20($sp)
    /* D2D48 800E2548 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D2D4C 800E254C 1800B2AF */  sw         $s2, 0x18($sp)
    /* D2D50 800E2550 1400B1AF */  sw         $s1, 0x14($sp)
    /* D2D54 800E2554 1000B0AF */  sw         $s0, 0x10($sp)
    /* D2D58 800E2558 781682AF */  sw         $v0, %gp_rel(Weather_gTrackSpec)($gp)
    /* D2D5C 800E255C C0006010 */  beqz       $v1, .L800E2860
    /* D2D60 800E2560 01000224 */   addiu     $v0, $zero, 0x1
    /* D2D64 800E2564 9C32838C */  lw         $v1, %lo(D_8012329C)($a0)
    /* D2D68 800E2568 00000000 */  nop
    /* D2D6C 800E256C A01683AF */  sw         $v1, %gp_rel(Weather_gType)($gp)
    /* D2D70 800E2570 05006214 */  bne        $v1, $v0, .L800E2588
    /* D2D74 800E2574 00000000 */   nop
    /* D2D78 800E2578 DE87030C */  jal        Weather_InitRain__Fv
    /* D2D7C 800E257C 00000000 */   nop
    /* D2D80 800E2580 66890308 */  j          .L800E2598
    /* D2D84 800E2584 00000000 */   nop
  .L800E2588:
    /* D2D88 800E2588 03006014 */  bnez       $v1, .L800E2598
    /* D2D8C 800E258C 00000000 */   nop
    /* D2D90 800E2590 C687030C */  jal        Weather_InitSnow__Fv
    /* D2D94 800E2594 00000000 */   nop
  .L800E2598:
    /* D2D98 800E2598 6016828F */  lw         $v0, %gp_rel(Weather_gSplatInfo)($gp)
    /* D2D9C 800E259C 00000000 */  nop
    /* D2DA0 800E25A0 06004014 */  bnez       $v0, .L800E25BC
    /* D2DA4 800E25A4 0580043C */   lui       $a0, %hi(D_80056AFC)
    /* D2DA8 800E25A8 FC6A8424 */  addiu      $a0, $a0, %lo(D_80056AFC)
    /* D2DAC 800E25AC A8000524 */  addiu      $a1, $zero, 0xA8
    /* D2DB0 800E25B0 CF94030C */  jal        reservememadr
    /* D2DB4 800E25B4 21300000 */   addu      $a2, $zero, $zero
    /* D2DB8 800E25B8 601682AF */  sw         $v0, %gp_rel(Weather_gSplatInfo)($gp)
  .L800E25BC:
    /* D2DBC 800E25BC 5C16828F */  lw         $v0, %gp_rel(Weather_gPos)($gp)
    /* D2DC0 800E25C0 00000000 */  nop
    /* D2DC4 800E25C4 06004014 */  bnez       $v0, .L800E25E0
    /* D2DC8 800E25C8 0580043C */   lui       $a0, %hi(D_80056B08)
    /* D2DCC 800E25CC 086B8424 */  addiu      $a0, $a0, %lo(D_80056B08)
    /* D2DD0 800E25D0 C0040524 */  addiu      $a1, $zero, 0x4C0
    /* D2DD4 800E25D4 CF94030C */  jal        reservememadr
    /* D2DD8 800E25D8 21300000 */   addu      $a2, $zero, $zero
    /* D2DDC 800E25DC 5C1682AF */  sw         $v0, %gp_rel(Weather_gPos)($gp)
  .L800E25E0:
    /* D2DE0 800E25E0 6416828F */  lw         $v0, %gp_rel(Weather_gPrevPos)($gp)
    /* D2DE4 800E25E4 00000000 */  nop
    /* D2DE8 800E25E8 06004014 */  bnez       $v0, .L800E2604
    /* D2DEC 800E25EC 0580043C */   lui       $a0, %hi(D_80056B14)
    /* D2DF0 800E25F0 146B8424 */  addiu      $a0, $a0, %lo(D_80056B14)
    /* D2DF4 800E25F4 60020524 */  addiu      $a1, $zero, 0x260
    /* D2DF8 800E25F8 CF94030C */  jal        reservememadr
    /* D2DFC 800E25FC 21300000 */   addu      $a2, $zero, $zero
    /* D2E00 800E2600 641682AF */  sw         $v0, %gp_rel(Weather_gPrevPos)($gp)
  .L800E2604:
    /* D2E04 800E2604 5816828F */  lw         $v0, %gp_rel(Weather_gWasDrawn)($gp)
    /* D2E08 800E2608 00000000 */  nop
    /* D2E0C 800E260C 08004014 */  bnez       $v0, .L800E2630
    /* D2E10 800E2610 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* D2E14 800E2614 0580043C */  lui        $a0, %hi(D_80056B20)
    /* D2E18 800E2618 206B8424 */  addiu      $a0, $a0, %lo(D_80056B20)
    /* D2E1C 800E261C 98000524 */  addiu      $a1, $zero, 0x98
    /* D2E20 800E2620 CF94030C */  jal        reservememadr
    /* D2E24 800E2624 21300000 */   addu      $a2, $zero, $zero
    /* D2E28 800E2628 581682AF */  sw         $v0, %gp_rel(Weather_gWasDrawn)($gp)
    /* D2E2C 800E262C 1280023C */  lui        $v0, %hi(D_8011E0B0)
  .L800E2630:
    /* D2E30 800E2630 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* D2E34 800E2634 5C16848F */  lw         $a0, %gp_rel(Weather_gPos)($gp)
    /* D2E38 800E2638 6416858F */  lw         $a1, %gp_rel(Weather_gPrevPos)($gp)
    /* D2E3C 800E263C 5816868F */  lw         $a2, %gp_rel(Weather_gWasDrawn)($gp)
    /* D2E40 800E2640 6016878F */  lw         $a3, %gp_rel(Weather_gSplatInfo)($gp)
    /* D2E44 800E2644 0C1982AF */  sw         $v0, %gp_rel(D_8013DE58)($gp)
    /* D2E48 800E2648 081982AF */  sw         $v0, %gp_rel(D_8013DE54)($gp)
    /* D2E4C 800E264C 1180023C */  lui        $v0, %hi(D_801131F8)
    /* D2E50 800E2650 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* D2E54 800E2654 01000224 */  addiu      $v0, $zero, 0x1
    /* D2E58 800E2658 841684AF */  sw         $a0, %gp_rel(Weather_gPServer)($gp)
    /* D2E5C 800E265C 8C1685AF */  sw         $a1, %gp_rel(Weather_gPrevPServer)($gp)
    /* D2E60 800E2660 941686AF */  sw         $a2, %gp_rel(Weather_gDrawnServer)($gp)
    /* D2E64 800E2664 7C1687AF */  sw         $a3, %gp_rel(Weather_gSplatInfoServer)($gp)
    /* D2E68 800E2668 0F006214 */  bne        $v1, $v0, .L800E26A8
    /* D2E6C 800E266C 1280023C */   lui       $v0, %hi(prevCamMat)
    /* D2E70 800E2670 60028224 */  addiu      $v0, $a0, 0x260
    /* D2E74 800E2674 881682AF */  sw         $v0, %gp_rel(D_8013DBD4)($gp)
    /* D2E78 800E2678 3001A224 */  addiu      $v0, $a1, 0x130
    /* D2E7C 800E267C 901682AF */  sw         $v0, %gp_rel(D_8013DBDC)($gp)
    /* D2E80 800E2680 4C00C224 */  addiu      $v0, $a2, 0x4C
    /* D2E84 800E2684 981682AF */  sw         $v0, %gp_rel(D_8013DBE4)($gp)
    /* D2E88 800E2688 1280023C */  lui        $v0, %hi(Weather_gSys)
    /* D2E8C 800E268C 4C000324 */  addiu      $v1, $zero, 0x4C
    /* D2E90 800E2690 083443AC */  sw         $v1, %lo(Weather_gSys)($v0)
    /* D2E94 800E2694 08344224 */  addiu      $v0, $v0, %lo(Weather_gSys)
    /* D2E98 800E2698 040043AC */  sw         $v1, 0x4($v0)
    /* D2E9C 800E269C 4800E224 */  addiu      $v0, $a3, 0x48
    /* D2EA0 800E26A0 801682AF */  sw         $v0, %gp_rel(D_8013DBCC)($gp)
    /* D2EA4 800E26A4 1280023C */  lui        $v0, %hi(prevCamMat)
  .L800E26A8:
    /* D2EA8 800E26A8 44344724 */  addiu      $a3, $v0, %lo(prevCamMat)
    /* D2EAC 800E26AC 2148E000 */  addu       $t1, $a3, $zero
    /* D2EB0 800E26B0 2130E000 */  addu       $a2, $a3, $zero
    /* D2EB4 800E26B4 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* D2EB8 800E26B8 ACF24224 */  addiu      $v0, $v0, %lo(Camera_gInfo)
    /* D2EBC 800E26BC 30004524 */  addiu      $a1, $v0, 0x30
    /* D2EC0 800E26C0 50004824 */  addiu      $t0, $v0, 0x50
    /* D2EC4 800E26C4 1280043C */  lui        $a0, %hi(prevCamPos)
    /* D2EC8 800E26C8 2C348324 */  addiu      $v1, $a0, %lo(prevCamPos)
    /* D2ECC 800E26CC 08004A8C */  lw         $t2, 0x8($v0)
    /* D2ED0 800E26D0 0C004B8C */  lw         $t3, 0xC($v0)
    /* D2ED4 800E26D4 10004C8C */  lw         $t4, 0x10($v0)
    /* D2ED8 800E26D8 0C006AAC */  sw         $t2, 0xC($v1)
    /* D2EDC 800E26DC 10006BAC */  sw         $t3, 0x10($v1)
    /* D2EE0 800E26E0 14006CAC */  sw         $t4, 0x14($v1)
    /* D2EE4 800E26E4 2C348D24 */  addiu      $t5, $a0, %lo(prevCamPos)
    /* D2EE8 800E26E8 0C006A8C */  lw         $t2, 0xC($v1)
    /* D2EEC 800E26EC 10006B8C */  lw         $t3, 0x10($v1)
    /* D2EF0 800E26F0 14006C8C */  lw         $t4, 0x14($v1)
    /* D2EF4 800E26F4 0000AAAD */  sw         $t2, 0x0($t5)
    /* D2EF8 800E26F8 0400ABAD */  sw         $t3, 0x4($t5)
    /* D2EFC 800E26FC 0800ACAD */  sw         $t4, 0x8($t5)
  .L800E2700:
    /* D2F00 800E2700 0000AA8C */  lw         $t2, 0x0($a1)
    /* D2F04 800E2704 0400AB8C */  lw         $t3, 0x4($a1)
    /* D2F08 800E2708 0800AC8C */  lw         $t4, 0x8($a1)
    /* D2F0C 800E270C 0C00AD8C */  lw         $t5, 0xC($a1)
    /* D2F10 800E2710 0000CAAC */  sw         $t2, 0x0($a2)
    /* D2F14 800E2714 0400CBAC */  sw         $t3, 0x4($a2)
    /* D2F18 800E2718 0800CCAC */  sw         $t4, 0x8($a2)
    /* D2F1C 800E271C 0C00CDAC */  sw         $t5, 0xC($a2)
    /* D2F20 800E2720 1000A524 */  addiu      $a1, $a1, 0x10
    /* D2F24 800E2724 F6FFA814 */  bne        $a1, $t0, .L800E2700
    /* D2F28 800E2728 1000C624 */   addiu     $a2, $a2, 0x10
    /* D2F2C 800E272C 0000AA8C */  lw         $t2, 0x0($a1)
    /* D2F30 800E2730 00000000 */  nop
    /* D2F34 800E2734 0000CAAC */  sw         $t2, 0x0($a2)
    /* D2F38 800E2738 24002425 */  addiu      $a0, $t1, 0x24
    /* D2F3C 800E273C 2118E000 */  addu       $v1, $a3, $zero
    /* D2F40 800E2740 20006224 */  addiu      $v0, $v1, 0x20
  .L800E2744:
    /* D2F44 800E2744 00006A8C */  lw         $t2, 0x0($v1)
    /* D2F48 800E2748 04006B8C */  lw         $t3, 0x4($v1)
    /* D2F4C 800E274C 08006C8C */  lw         $t4, 0x8($v1)
    /* D2F50 800E2750 0C006D8C */  lw         $t5, 0xC($v1)
    /* D2F54 800E2754 00008AAC */  sw         $t2, 0x0($a0)
    /* D2F58 800E2758 04008BAC */  sw         $t3, 0x4($a0)
    /* D2F5C 800E275C 08008CAC */  sw         $t4, 0x8($a0)
    /* D2F60 800E2760 0C008DAC */  sw         $t5, 0xC($a0)
    /* D2F64 800E2764 10006324 */  addiu      $v1, $v1, 0x10
    /* D2F68 800E2768 F6FF6214 */  bne        $v1, $v0, .L800E2744
    /* D2F6C 800E276C 10008424 */   addiu     $a0, $a0, 0x10
    /* D2F70 800E2770 97001024 */  addiu      $s0, $zero, 0x97
    /* D2F74 800E2774 1280023C */  lui        $v0, %hi(Weather_gSys)
    /* D2F78 800E2778 5C16928F */  lw         $s2, %gp_rel(Weather_gPos)($gp)
    /* D2F7C 800E277C 08345324 */  addiu      $s3, $v0, %lo(Weather_gSys)
    /* D2F80 800E2780 00006A8C */  lw         $t2, 0x0($v1)
    /* D2F84 800E2784 00000000 */  nop
    /* D2F88 800E2788 00008AAC */  sw         $t2, 0x0($a0)
    /* D2F8C 800E278C 04005126 */  addiu      $s1, $s2, 0x4
  .L800E2790:
    /* D2F90 800E2790 EA9D030C */  jal        random
    /* D2F94 800E2794 FFFF1026 */   addiu     $s0, $s0, -0x1
    /* D2F98 800E2798 20006386 */  lh         $v1, 0x20($s3)
    /* D2F9C 800E279C 00000000 */  nop
    /* D2FA0 800E27A0 1B004300 */  divu       $zero, $v0, $v1
    /* D2FA4 800E27A4 02006014 */  bnez       $v1, .L800E27B0
    /* D2FA8 800E27A8 00000000 */   nop
    /* D2FAC 800E27AC 0D000700 */  break      7
  .L800E27B0:
    /* D2FB0 800E27B0 10180000 */  mfhi       $v1
    /* D2FB4 800E27B4 20006296 */  lhu        $v0, 0x20($s3)
    /* D2FB8 800E27B8 40180300 */  sll        $v1, $v1, 1
    /* D2FBC 800E27BC 23186200 */  subu       $v1, $v1, $v0
    /* D2FC0 800E27C0 EA9D030C */  jal        random
    /* D2FC4 800E27C4 000043A6 */   sh        $v1, 0x0($s2)
    /* D2FC8 800E27C8 1E006386 */  lh         $v1, 0x1E($s3)
    /* D2FCC 800E27CC 00000000 */  nop
    /* D2FD0 800E27D0 1B004300 */  divu       $zero, $v0, $v1
    /* D2FD4 800E27D4 02006014 */  bnez       $v1, .L800E27E0
    /* D2FD8 800E27D8 00000000 */   nop
    /* D2FDC 800E27DC 0D000700 */  break      7
  .L800E27E0:
    /* D2FE0 800E27E0 10180000 */  mfhi       $v1
    /* D2FE4 800E27E4 1A006296 */  lhu        $v0, 0x1A($s3)
    /* D2FE8 800E27E8 00000000 */  nop
    /* D2FEC 800E27EC 21104300 */  addu       $v0, $v0, $v1
    /* D2FF0 800E27F0 EA9D030C */  jal        random
    /* D2FF4 800E27F4 FEFF22A6 */   sh        $v0, -0x2($s1)
    /* D2FF8 800E27F8 18006386 */  lh         $v1, 0x18($s3)
    /* D2FFC 800E27FC 00000000 */  nop
    /* D3000 800E2800 1B004300 */  divu       $zero, $v0, $v1
    /* D3004 800E2804 02006014 */  bnez       $v1, .L800E2810
    /* D3008 800E2808 00000000 */   nop
    /* D300C 800E280C 0D000700 */  break      7
  .L800E2810:
    /* D3010 800E2810 10180000 */  mfhi       $v1
    /* D3014 800E2814 14006296 */  lhu        $v0, 0x14($s3)
    /* D3018 800E2818 08005226 */  addiu      $s2, $s2, 0x8
    /* D301C 800E281C 21104300 */  addu       $v0, $v0, $v1
    /* D3020 800E2820 000022A6 */  sh         $v0, 0x0($s1)
    /* D3024 800E2824 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* D3028 800E2828 D9FF0216 */  bne        $s0, $v0, .L800E2790
    /* D302C 800E282C 08003126 */   addiu     $s1, $s1, 0x8
    /* D3030 800E2830 21800000 */  addu       $s0, $zero, $zero
  .L800E2834:
    /* D3034 800E2834 5816828F */  lw         $v0, %gp_rel(Weather_gWasDrawn)($gp)
    /* D3038 800E2838 00000000 */  nop
    /* D303C 800E283C 21105000 */  addu       $v0, $v0, $s0
    /* D3040 800E2840 01001026 */  addiu      $s0, $s0, 0x1
    /* D3044 800E2844 000040A0 */  sb         $zero, 0x0($v0)
    /* D3048 800E2848 9800022A */  slti       $v0, $s0, 0x98
    /* D304C 800E284C F9FF4014 */  bnez       $v0, .L800E2834
    /* D3050 800E2850 00000000 */   nop
    /* D3054 800E2854 541680AF */  sw         $zero, %gp_rel(gCurrentNumSplats)($gp)
    /* D3058 800E2858 F687030C */  jal        Weather_InitSplats__Fv
    /* D305C 800E285C 00000000 */   nop
  .L800E2860:
    /* D3060 800E2860 2000BF8F */  lw         $ra, 0x20($sp)
    /* D3064 800E2864 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D3068 800E2868 1800B28F */  lw         $s2, 0x18($sp)
    /* D306C 800E286C 1400B18F */  lw         $s1, 0x14($sp)
    /* D3070 800E2870 1000B08F */  lw         $s0, 0x10($sp)
    /* D3074 800E2874 0800E003 */  jr         $ra
    /* D3078 800E2878 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Weather_Init__Fv
