.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RotMatrix, 0x28C

glabel RotMatrix
    /* E2D2C 800F252C 00008F84 */  lh         $t7, 0x0($a0)
    /* E2D30 800F2530 2110A000 */  addu       $v0, $a1, $zero
    /* E2D34 800F2534 0E00E105 */  bgez       $t7, .L800F2570
    /* E2D38 800F2538 FF0FF931 */   andi      $t9, $t7, 0xFFF
    /* E2D3C 800F253C 23780F00 */  negu       $t7, $t7
    /* E2D40 800F2540 0100E105 */  bgez       $t7, .L800F2548
    /* E2D44 800F2544 FF0FEF31 */   andi      $t7, $t7, 0xFFF
  .L800F2548:
    /* E2D48 800F2548 80C00F00 */  sll        $t8, $t7, 2
    /* E2D4C 800F254C 1380193C */  lui        $t9, %hi(rcossin_tbl)
    /* E2D50 800F2550 21C83803 */  addu       $t9, $t9, $t8
    /* E2D54 800F2554 207D398F */  lw         $t9, %lo(rcossin_tbl)($t9)
    /* E2D58 800F2558 00000000 */  nop
    /* E2D5C 800F255C 00C41900 */  sll        $t8, $t9, 16
    /* E2D60 800F2560 03C41800 */  sra        $t8, $t8, 16
    /* E2D64 800F2564 23581800 */  negu       $t3, $t8
    /* E2D68 800F2568 64C90308 */  j          .L800F2590
    /* E2D6C 800F256C 03441900 */   sra       $t0, $t9, 16
  .L800F2570:
    /* E2D70 800F2570 80C01900 */  sll        $t8, $t9, 2
    /* E2D74 800F2574 1380193C */  lui        $t9, %hi(rcossin_tbl)
    /* E2D78 800F2578 21C83803 */  addu       $t9, $t9, $t8
    /* E2D7C 800F257C 207D398F */  lw         $t9, %lo(rcossin_tbl)($t9)
    /* E2D80 800F2580 00000000 */  nop
    /* E2D84 800F2584 00C41900 */  sll        $t8, $t9, 16
    /* E2D88 800F2588 035C1800 */  sra        $t3, $t8, 16
    /* E2D8C 800F258C 03441900 */  sra        $t0, $t9, 16
  .L800F2590:
    /* E2D90 800F2590 02008F84 */  lh         $t7, 0x2($a0)
    /* E2D94 800F2594 00000000 */  nop
    /* E2D98 800F2598 0E00E105 */  bgez       $t7, .L800F25D4
    /* E2D9C 800F259C FF0FF931 */   andi      $t9, $t7, 0xFFF
    /* E2DA0 800F25A0 23780F00 */  negu       $t7, $t7
    /* E2DA4 800F25A4 0100E105 */  bgez       $t7, .L800F25AC
    /* E2DA8 800F25A8 FF0FEF31 */   andi      $t7, $t7, 0xFFF
  .L800F25AC:
    /* E2DAC 800F25AC 80C00F00 */  sll        $t8, $t7, 2
    /* E2DB0 800F25B0 1380193C */  lui        $t9, %hi(rcossin_tbl)
    /* E2DB4 800F25B4 21C83803 */  addu       $t9, $t9, $t8
    /* E2DB8 800F25B8 207D398F */  lw         $t9, %lo(rcossin_tbl)($t9)
    /* E2DBC 800F25BC 00000000 */  nop
    /* E2DC0 800F25C0 00641900 */  sll        $t4, $t9, 16
    /* E2DC4 800F25C4 03640C00 */  sra        $t4, $t4, 16
    /* E2DC8 800F25C8 23700C00 */  negu       $t6, $t4
    /* E2DCC 800F25CC 7EC90308 */  j          .L800F25F8
    /* E2DD0 800F25D0 034C1900 */   sra       $t1, $t9, 16
  .L800F25D4:
    /* E2DD4 800F25D4 80C01900 */  sll        $t8, $t9, 2
    /* E2DD8 800F25D8 1380193C */  lui        $t9, %hi(rcossin_tbl)
    /* E2DDC 800F25DC 21C83803 */  addu       $t9, $t9, $t8
    /* E2DE0 800F25E0 207D398F */  lw         $t9, %lo(rcossin_tbl)($t9)
    /* E2DE4 800F25E4 00000000 */  nop
    /* E2DE8 800F25E8 00741900 */  sll        $t6, $t9, 16
    /* E2DEC 800F25EC 03740E00 */  sra        $t6, $t6, 16
    /* E2DF0 800F25F0 23600E00 */  negu       $t4, $t6
    /* E2DF4 800F25F4 034C1900 */  sra        $t1, $t9, 16
  .L800F25F8:
    /* E2DF8 800F25F8 19002B01 */  multu      $t1, $t3
    /* E2DFC 800F25FC 04008F84 */  lh         $t7, 0x4($a0)
    /* E2E00 800F2600 0400AEA4 */  sh         $t6, 0x4($a1)
    /* E2E04 800F2604 12C00000 */  mflo       $t8
    /* E2E08 800F2608 23C81800 */  negu       $t9, $t8
    /* E2E0C 800F260C 03731900 */  sra        $t6, $t9, 12
    /* E2E10 800F2610 19002801 */  multu      $t1, $t0
    /* E2E14 800F2614 0A00AEA4 */  sh         $t6, 0xA($a1)
    /* E2E18 800F2618 1100E105 */  bgez       $t7, .L800F2660
    /* E2E1C 800F261C FF0FF931 */   andi      $t9, $t7, 0xFFF
    /* E2E20 800F2620 12C00000 */  mflo       $t8
    /* E2E24 800F2624 03731800 */  sra        $t6, $t8, 12
    /* E2E28 800F2628 1000AEA4 */  sh         $t6, 0x10($a1)
    /* E2E2C 800F262C 23780F00 */  negu       $t7, $t7
    /* E2E30 800F2630 0100E105 */  bgez       $t7, .L800F2638
    /* E2E34 800F2634 FF0FEF31 */   andi      $t7, $t7, 0xFFF
  .L800F2638:
    /* E2E38 800F2638 80C00F00 */  sll        $t8, $t7, 2
    /* E2E3C 800F263C 1380193C */  lui        $t9, %hi(rcossin_tbl)
    /* E2E40 800F2640 21C83803 */  addu       $t9, $t9, $t8
    /* E2E44 800F2644 207D398F */  lw         $t9, %lo(rcossin_tbl)($t9)
    /* E2E48 800F2648 00000000 */  nop
    /* E2E4C 800F264C 00C41900 */  sll        $t8, $t9, 16
    /* E2E50 800F2650 03C41800 */  sra        $t8, $t8, 16
    /* E2E54 800F2654 23681800 */  negu       $t5, $t8
    /* E2E58 800F2658 A3C90308 */  j          .L800F268C
    /* E2E5C 800F265C 03541900 */   sra       $t2, $t9, 16
  .L800F2660:
    /* E2E60 800F2660 12780000 */  mflo       $t7
    /* E2E64 800F2664 03730F00 */  sra        $t6, $t7, 12
    /* E2E68 800F2668 1000AEA4 */  sh         $t6, 0x10($a1)
    /* E2E6C 800F266C 80C01900 */  sll        $t8, $t9, 2
    /* E2E70 800F2670 1380193C */  lui        $t9, %hi(rcossin_tbl)
    /* E2E74 800F2674 21C83803 */  addu       $t9, $t9, $t8
    /* E2E78 800F2678 207D398F */  lw         $t9, %lo(rcossin_tbl)($t9)
    /* E2E7C 800F267C 00000000 */  nop
    /* E2E80 800F2680 00C41900 */  sll        $t8, $t9, 16
    /* E2E84 800F2684 036C1800 */  sra        $t5, $t8, 16
    /* E2E88 800F2688 03541900 */  sra        $t2, $t9, 16
  .L800F268C:
    /* E2E8C 800F268C 19004901 */  multu      $t2, $t1
    /* E2E90 800F2690 00000000 */  nop
    /* E2E94 800F2694 00000000 */  nop
    /* E2E98 800F2698 12780000 */  mflo       $t7
    /* E2E9C 800F269C 03730F00 */  sra        $t6, $t7, 12
    /* E2EA0 800F26A0 0000AEA4 */  sh         $t6, 0x0($a1)
    /* E2EA4 800F26A4 1900A901 */  multu      $t5, $t1
    /* E2EA8 800F26A8 00000000 */  nop
    /* E2EAC 800F26AC 00000000 */  nop
    /* E2EB0 800F26B0 12780000 */  mflo       $t7
    /* E2EB4 800F26B4 23700F00 */  negu       $t6, $t7
    /* E2EB8 800F26B8 037B0E00 */  sra        $t7, $t6, 12
    /* E2EBC 800F26BC 19004C01 */  multu      $t2, $t4
    /* E2EC0 800F26C0 0200AFA4 */  sh         $t7, 0x2($a1)
    /* E2EC4 800F26C4 00000000 */  nop
    /* E2EC8 800F26C8 12780000 */  mflo       $t7
    /* E2ECC 800F26CC 03C30F00 */  sra        $t8, $t7, 12
    /* E2ED0 800F26D0 00000000 */  nop
    /* E2ED4 800F26D4 19000B03 */  multu      $t8, $t3
    /* E2ED8 800F26D8 00000000 */  nop
    /* E2EDC 800F26DC 00000000 */  nop
    /* E2EE0 800F26E0 12780000 */  mflo       $t7
    /* E2EE4 800F26E4 03730F00 */  sra        $t6, $t7, 12
    /* E2EE8 800F26E8 00000000 */  nop
    /* E2EEC 800F26EC 1900A801 */  multu      $t5, $t0
    /* E2EF0 800F26F0 00000000 */  nop
    /* E2EF4 800F26F4 00000000 */  nop
    /* E2EF8 800F26F8 12780000 */  mflo       $t7
    /* E2EFC 800F26FC 03CB0F00 */  sra        $t9, $t7, 12
    /* E2F00 800F2700 23782E03 */  subu       $t7, $t9, $t6
    /* E2F04 800F2704 19000803 */  multu      $t8, $t0
    /* E2F08 800F2708 0600AFA4 */  sh         $t7, 0x6($a1)
    /* E2F0C 800F270C 00000000 */  nop
    /* E2F10 800F2710 12700000 */  mflo       $t6
    /* E2F14 800F2714 037B0E00 */  sra        $t7, $t6, 12
    /* E2F18 800F2718 00000000 */  nop
    /* E2F1C 800F271C 1900AB01 */  multu      $t5, $t3
    /* E2F20 800F2720 00000000 */  nop
    /* E2F24 800F2724 00000000 */  nop
    /* E2F28 800F2728 12700000 */  mflo       $t6
    /* E2F2C 800F272C 03CB0E00 */  sra        $t9, $t6, 12
    /* E2F30 800F2730 21702F03 */  addu       $t6, $t9, $t7
    /* E2F34 800F2734 1900AC01 */  multu      $t5, $t4
    /* E2F38 800F2738 0C00AEA4 */  sh         $t6, 0xC($a1)
    /* E2F3C 800F273C 00000000 */  nop
    /* E2F40 800F2740 12780000 */  mflo       $t7
    /* E2F44 800F2744 03C30F00 */  sra        $t8, $t7, 12
    /* E2F48 800F2748 00000000 */  nop
    /* E2F4C 800F274C 19000B03 */  multu      $t8, $t3
    /* E2F50 800F2750 00000000 */  nop
    /* E2F54 800F2754 00000000 */  nop
    /* E2F58 800F2758 12780000 */  mflo       $t7
    /* E2F5C 800F275C 03730F00 */  sra        $t6, $t7, 12
    /* E2F60 800F2760 00000000 */  nop
    /* E2F64 800F2764 19004801 */  multu      $t2, $t0
    /* E2F68 800F2768 00000000 */  nop
    /* E2F6C 800F276C 00000000 */  nop
    /* E2F70 800F2770 12780000 */  mflo       $t7
    /* E2F74 800F2774 03CB0F00 */  sra        $t9, $t7, 12
    /* E2F78 800F2778 21782E03 */  addu       $t7, $t9, $t6
    /* E2F7C 800F277C 19000803 */  multu      $t8, $t0
    /* E2F80 800F2780 0800AFA4 */  sh         $t7, 0x8($a1)
    /* E2F84 800F2784 00000000 */  nop
    /* E2F88 800F2788 12700000 */  mflo       $t6
    /* E2F8C 800F278C 037B0E00 */  sra        $t7, $t6, 12
    /* E2F90 800F2790 00000000 */  nop
    /* E2F94 800F2794 19004B01 */  multu      $t2, $t3
    /* E2F98 800F2798 00000000 */  nop
    /* E2F9C 800F279C 00000000 */  nop
    /* E2FA0 800F27A0 12700000 */  mflo       $t6
    /* E2FA4 800F27A4 03CB0E00 */  sra        $t9, $t6, 12
    /* E2FA8 800F27A8 23702F03 */  subu       $t6, $t9, $t7
    /* E2FAC 800F27AC 0E00AEA4 */  sh         $t6, 0xE($a1)
    /* E2FB0 800F27B0 0800E003 */  jr         $ra
    /* E2FB4 800F27B4 00000000 */   nop
endlabel RotMatrix
    /* E2FB8 800F27B8 00000000 */  nop
