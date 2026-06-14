.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_StartUp__Fv, 0x468

glabel Cars_StartUp__Fv
    /* 7ADD8 8008A5D8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 7ADDC 8008A5DC 4400BFAF */  sw         $ra, 0x44($sp)
    /* 7ADE0 8008A5E0 4000B4AF */  sw         $s4, 0x40($sp)
    /* 7ADE4 8008A5E4 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 7ADE8 8008A5E8 3800B2AF */  sw         $s2, 0x38($sp)
    /* 7ADEC 8008A5EC 3400B1AF */  sw         $s1, 0x34($sp)
    /* 7ADF0 8008A5F0 1518020C */  jal        Cars_ResetCarCounters__Fv
    /* 7ADF4 8008A5F4 3000B0AF */   sw        $s0, 0x30($sp)
    /* 7ADF8 8008A5F8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 7ADFC 8008A5FC EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* 7AE00 8008A600 C403628C */  lw         $v0, 0x3C4($v1)
    /* 7AE04 8008A604 00000000 */  nop
    /* 7AE08 8008A608 1A004018 */  blez       $v0, .L8008A674
    /* 7AE0C 8008A60C 21880000 */   addu      $s1, $zero, $zero
    /* 7AE10 8008A610 0580143C */  lui        $s4, %hi(D_800559C4)
    /* 7AE14 8008A614 21986000 */  addu       $s3, $v1, $zero
    /* 7AE18 8008A618 21902002 */  addu       $s2, $s1, $zero
  .L8008A61C:
    /* 7AE1C 8008A61C C4598426 */  addiu      $a0, $s4, %lo(D_800559C4)
    /* 7AE20 8008A620 DC080524 */  addiu      $a1, $zero, 0x8DC
    /* 7AE24 8008A624 CF94030C */  jal        reservememadr
    /* 7AE28 8008A628 21300000 */   addu      $a2, $zero, $zero
    /* 7AE2C 8008A62C 21804000 */  addu       $s0, $v0, $zero
    /* 7AE30 8008A630 21200002 */  addu       $a0, $s0, $zero
    /* 7AE34 8008A634 6D29020C */  jal        Cars_Initialize__FPci
    /* 7AE38 8008A638 DC080524 */   addiu     $a1, $zero, 0x8DC
    /* 7AE3C 8008A63C C403628E */  lw         $v0, 0x3C4($s3)
    /* 7AE40 8008A640 00000000 */  nop
    /* 7AE44 8008A644 2A102202 */  slt        $v0, $s1, $v0
    /* 7AE48 8008A648 03004010 */  beqz       $v0, .L8008A658
    /* 7AE4C 8008A64C D4036226 */   addiu     $v0, $s3, 0x3D4
    /* 7AE50 8008A650 21104202 */  addu       $v0, $s2, $v0
    /* 7AE54 8008A654 880202AE */  sw         $v0, 0x288($s0)
  .L8008A658:
    /* 7AE58 8008A658 3918020C */  jal        Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj
    /* 7AE5C 8008A65C 21200002 */   addu      $a0, $s0, $zero
    /* 7AE60 8008A660 C403628E */  lw         $v0, 0x3C4($s3)
    /* 7AE64 8008A664 01003126 */  addiu      $s1, $s1, 0x1
    /* 7AE68 8008A668 2A102202 */  slt        $v0, $s1, $v0
    /* 7AE6C 8008A66C EBFF4014 */  bnez       $v0, .L8008A61C
    /* 7AE70 8008A670 B4005226 */   addiu     $s2, $s2, 0xB4
  .L8008A674:
    /* 7AE74 8008A674 21880000 */  addu       $s1, $zero, $zero
    /* 7AE78 8008A678 1180023C */  lui        $v0, %hi(InfiniteMassNewton)
    /* 7AE7C 8008A67C E4005024 */  addiu      $s0, $v0, %lo(InfiniteMassNewton)
  .L8008A680:
    /* 7AE80 8008A680 0198020C */  jal        Object_GetNumIMassObjects__Fv
    /* 7AE84 8008A684 00000000 */   nop
    /* 7AE88 8008A688 2A102202 */  slt        $v0, $s1, $v0
    /* 7AE8C 8008A68C 14004010 */  beqz       $v0, .L8008A6E0
    /* 7AE90 8008A690 21202002 */   addu      $a0, $s1, $zero
    /* 7AE94 8008A694 0498020C */  jal        Object_GetIMassObjectDimensions__FiP8coorddef
    /* 7AE98 8008A698 2000A527 */   addiu     $a1, $sp, 0x20
    /* 7AE9C 8008A69C 21200002 */  addu       $a0, $s0, $zero
    /* 7AEA0 8008A6A0 01020524 */  addiu      $a1, $zero, 0x201
    /* 7AEA4 8008A6A4 2800063C */  lui        $a2, (0x280000 >> 16)
    /* 7AEA8 8008A6A8 4001073C */  lui        $a3, (0x1400000 >> 16)
    /* 7AEAC 8008A6AC 2000A28F */  lw         $v0, 0x20($sp)
    /* 7AEB0 8008A6B0 40021026 */  addiu      $s0, $s0, 0x240
    /* 7AEB4 8008A6B4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 7AEB8 8008A6B8 2400A28F */  lw         $v0, 0x24($sp)
    /* 7AEBC 8008A6BC 01003126 */  addiu      $s1, $s1, 0x1
    /* 7AEC0 8008A6C0 1400A2AF */  sw         $v0, 0x14($sp)
    /* 7AEC4 8008A6C4 2800A28F */  lw         $v0, 0x28($sp)
    /* 7AEC8 8008A6C8 0100033C */  lui        $v1, (0x10000 >> 16)
    /* 7AECC 8008A6CC 21104300 */  addu       $v0, $v0, $v1
    /* 7AED0 8008A6D0 FA86020C */  jal        Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii
    /* 7AED4 8008A6D4 1800A2AF */   sw        $v0, 0x18($sp)
    /* 7AED8 8008A6D8 A0290208 */  j          .L8008A680
    /* 7AEDC 8008A6DC 00000000 */   nop
  .L8008A6E0:
    /* 7AEE0 8008A6E0 21880000 */  addu       $s1, $zero, $zero
    /* 7AEE4 8008A6E4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 7AEE8 8008A6E8 EC315424 */  addiu      $s4, $v0, %lo(GameSetup_gData)
    /* 7AEEC 8008A6EC 1280023C */  lui        $v0, %hi(simGlobal)
    /* 7AEF0 8008A6F0 ACE05324 */  addiu      $s3, $v0, %lo(simGlobal)
    /* 7AEF4 8008A6F4 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7AEF8 8008A6F8 DCF95224 */  addiu      $s2, $v0, %lo(Cars_gList)
  .L8008A6FC:
    /* 7AEFC 8008A6FC C403828E */  lw         $v0, 0x3C4($s4)
    /* 7AF00 8008A700 00000000 */  nop
    /* 7AF04 8008A704 2A102202 */  slt        $v0, $s1, $v0
    /* 7AF08 8008A708 0D004010 */  beqz       $v0, .L8008A740
    /* 7AF0C 8008A70C 21282002 */   addu      $a1, $s1, $zero
    /* 7AF10 8008A710 0000508E */  lw         $s0, 0x0($s2)
    /* 7AF14 8008A714 04005226 */  addiu      $s2, $s2, 0x4
    /* 7AF18 8008A718 01003126 */  addiu      $s1, $s1, 0x1
    /* 7AF1C 8008A71C 5D28020C */  jal        Cars_InitCar__FP8Car_tObji
    /* 7AF20 8008A720 21200002 */   addu      $a0, $s0, $zero
    /* 7AF24 8008A724 21300002 */  addu       $a2, $s0, $zero
    /* 7AF28 8008A728 1000648E */  lw         $a0, 0x10($s3)
    /* 7AF2C 8008A72C C404C58C */  lw         $a1, 0x4C4($a2)
    /* 7AF30 8008A730 E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* 7AF34 8008A734 06000724 */   addiu     $a3, $zero, 0x6
    /* 7AF38 8008A738 BF290208 */  j          .L8008A6FC
    /* 7AF3C 8008A73C 00000000 */   nop
  .L8008A740:
    /* 7AF40 8008A740 1480043C */  lui        $a0, %hi(R3DCar_LicenseShapeFile)
    /* 7AF44 8008A744 B4D3848C */  lw         $a0, %lo(R3DCar_LicenseShapeFile)($a0)
    /* 7AF48 8008A748 00000000 */  nop
    /* 7AF4C 8008A74C 03008010 */  beqz       $a0, .L8008A75C
    /* 7AF50 8008A750 00000000 */   nop
    /* 7AF54 8008A754 5095030C */  jal        purgememadr
    /* 7AF58 8008A758 00000000 */   nop
  .L8008A75C:
    /* 7AF5C 8008A75C 1480013C */  lui        $at, %hi(R3DCar_LicenseShapeFile)
    /* 7AF60 8008A760 B4D320AC */  sw         $zero, %lo(R3DCar_LicenseShapeFile)($at)
    /* 7AF64 8008A764 21880000 */  addu       $s1, $zero, $zero
    /* 7AF68 8008A768 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 7AF6C 8008A76C EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
    /* 7AF70 8008A770 1280023C */  lui        $v0, %hi(simGlobal)
    /* 7AF74 8008A774 ACE05224 */  addiu      $s2, $v0, %lo(simGlobal)
    /* 7AF78 8008A778 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7AF7C 8008A77C DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
  .L8008A780:
    /* 7AF80 8008A780 C403628E */  lw         $v0, 0x3C4($s3)
    /* 7AF84 8008A784 00000000 */  nop
    /* 7AF88 8008A788 2A102202 */  slt        $v0, $s1, $v0
    /* 7AF8C 8008A78C 09004010 */  beqz       $v0, .L8008A7B4
    /* 7AF90 8008A790 15000724 */   addiu     $a3, $zero, 0x15
    /* 7AF94 8008A794 0000068E */  lw         $a2, 0x0($s0)
    /* 7AF98 8008A798 04001026 */  addiu      $s0, $s0, 0x4
    /* 7AF9C 8008A79C 1000448E */  lw         $a0, 0x10($s2)
    /* 7AFA0 8008A7A0 CC04C58C */  lw         $a1, 0x4CC($a2)
    /* 7AFA4 8008A7A4 E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* 7AFA8 8008A7A8 01003126 */   addiu     $s1, $s1, 0x1
    /* 7AFAC 8008A7AC E0290208 */  j          .L8008A780
    /* 7AFB0 8008A7B0 00000000 */   nop
  .L8008A7B4:
    /* 7AFB4 8008A7B4 21880000 */  addu       $s1, $zero, $zero
    /* 7AFB8 8008A7B8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 7AFBC 8008A7BC EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
    /* 7AFC0 8008A7C0 1280023C */  lui        $v0, %hi(simGlobal)
    /* 7AFC4 8008A7C4 ACE05224 */  addiu      $s2, $v0, %lo(simGlobal)
    /* 7AFC8 8008A7C8 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7AFCC 8008A7CC DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
  .L8008A7D0:
    /* 7AFD0 8008A7D0 C403628E */  lw         $v0, 0x3C4($s3)
    /* 7AFD4 8008A7D4 00000000 */  nop
    /* 7AFD8 8008A7D8 2A102202 */  slt        $v0, $s1, $v0
    /* 7AFDC 8008A7DC 09004010 */  beqz       $v0, .L8008A804
    /* 7AFE0 8008A7E0 1E000724 */   addiu     $a3, $zero, 0x1E
    /* 7AFE4 8008A7E4 0000068E */  lw         $a2, 0x0($s0)
    /* 7AFE8 8008A7E8 04001026 */  addiu      $s0, $s0, 0x4
    /* 7AFEC 8008A7EC 1000448E */  lw         $a0, 0x10($s2)
    /* 7AFF0 8008A7F0 D404C58C */  lw         $a1, 0x4D4($a2)
    /* 7AFF4 8008A7F4 E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* 7AFF8 8008A7F8 01003126 */   addiu     $s1, $s1, 0x1
    /* 7AFFC 8008A7FC F4290208 */  j          .L8008A7D0
    /* 7B000 8008A800 00000000 */   nop
  .L8008A804:
    /* 7B004 8008A804 21880000 */  addu       $s1, $zero, $zero
    /* 7B008 8008A808 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 7B00C 8008A80C EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
    /* 7B010 8008A810 1280023C */  lui        $v0, %hi(simGlobal)
    /* 7B014 8008A814 ACE05224 */  addiu      $s2, $v0, %lo(simGlobal)
    /* 7B018 8008A818 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7B01C 8008A81C DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
  .L8008A820:
    /* 7B020 8008A820 C403628E */  lw         $v0, 0x3C4($s3)
    /* 7B024 8008A824 00000000 */  nop
    /* 7B028 8008A828 2A102202 */  slt        $v0, $s1, $v0
    /* 7B02C 8008A82C 09004010 */  beqz       $v0, .L8008A854
    /* 7B030 8008A830 1E000724 */   addiu     $a3, $zero, 0x1E
    /* 7B034 8008A834 0000068E */  lw         $a2, 0x0($s0)
    /* 7B038 8008A838 04001026 */  addiu      $s0, $s0, 0x4
    /* 7B03C 8008A83C 1000448E */  lw         $a0, 0x10($s2)
    /* 7B040 8008A840 D804C58C */  lw         $a1, 0x4D8($a2)
    /* 7B044 8008A844 E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* 7B048 8008A848 01003126 */   addiu     $s1, $s1, 0x1
    /* 7B04C 8008A84C 082A0208 */  j          .L8008A820
    /* 7B050 8008A850 00000000 */   nop
  .L8008A854:
    /* 7B054 8008A854 21880000 */  addu       $s1, $zero, $zero
    /* 7B058 8008A858 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 7B05C 8008A85C EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
    /* 7B060 8008A860 1280023C */  lui        $v0, %hi(simGlobal)
    /* 7B064 8008A864 ACE05224 */  addiu      $s2, $v0, %lo(simGlobal)
    /* 7B068 8008A868 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7B06C 8008A86C DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
  .L8008A870:
    /* 7B070 8008A870 C403628E */  lw         $v0, 0x3C4($s3)
    /* 7B074 8008A874 00000000 */  nop
    /* 7B078 8008A878 2A102202 */  slt        $v0, $s1, $v0
    /* 7B07C 8008A87C 09004010 */  beqz       $v0, .L8008A8A4
    /* 7B080 8008A880 28000724 */   addiu     $a3, $zero, 0x28
    /* 7B084 8008A884 0000068E */  lw         $a2, 0x0($s0)
    /* 7B088 8008A888 04001026 */  addiu      $s0, $s0, 0x4
    /* 7B08C 8008A88C 1000448E */  lw         $a0, 0x10($s2)
    /* 7B090 8008A890 E404C58C */  lw         $a1, 0x4E4($a2)
    /* 7B094 8008A894 E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* 7B098 8008A898 01003126 */   addiu     $s1, $s1, 0x1
    /* 7B09C 8008A89C 1C2A0208 */  j          .L8008A870
    /* 7B0A0 8008A8A0 00000000 */   nop
  .L8008A8A4:
    /* 7B0A4 8008A8A4 21880000 */  addu       $s1, $zero, $zero
    /* 7B0A8 8008A8A8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 7B0AC 8008A8AC EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
    /* 7B0B0 8008A8B0 1280023C */  lui        $v0, %hi(simGlobal)
    /* 7B0B4 8008A8B4 ACE05224 */  addiu      $s2, $v0, %lo(simGlobal)
    /* 7B0B8 8008A8B8 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7B0BC 8008A8BC DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
  .L8008A8C0:
    /* 7B0C0 8008A8C0 C403628E */  lw         $v0, 0x3C4($s3)
    /* 7B0C4 8008A8C4 00000000 */  nop
    /* 7B0C8 8008A8C8 2A102202 */  slt        $v0, $s1, $v0
    /* 7B0CC 8008A8CC 09004010 */  beqz       $v0, .L8008A8F4
    /* 7B0D0 8008A8D0 32000724 */   addiu     $a3, $zero, 0x32
    /* 7B0D4 8008A8D4 0000068E */  lw         $a2, 0x0($s0)
    /* 7B0D8 8008A8D8 04001026 */  addiu      $s0, $s0, 0x4
    /* 7B0DC 8008A8DC 1000448E */  lw         $a0, 0x10($s2)
    /* 7B0E0 8008A8E0 E804C58C */  lw         $a1, 0x4E8($a2)
    /* 7B0E4 8008A8E4 E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* 7B0E8 8008A8E8 01003126 */   addiu     $s1, $s1, 0x1
    /* 7B0EC 8008A8EC 302A0208 */  j          .L8008A8C0
    /* 7B0F0 8008A8F0 00000000 */   nop
  .L8008A8F4:
    /* 7B0F4 8008A8F4 062C030C */  jal        Force_StartUp__Fv
    /* 7B0F8 8008A8F8 21880000 */   addu      $s1, $zero, $zero
    /* 7B0FC 8008A8FC 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 7B100 8008A900 EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
    /* 7B104 8008A904 1280023C */  lui        $v0, %hi(simGlobal)
    /* 7B108 8008A908 ACE05224 */  addiu      $s2, $v0, %lo(simGlobal)
    /* 7B10C 8008A90C 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7B110 8008A910 DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
  .L8008A914:
    /* 7B114 8008A914 C403628E */  lw         $v0, 0x3C4($s3)
    /* 7B118 8008A918 00000000 */  nop
    /* 7B11C 8008A91C 2A102202 */  slt        $v0, $s1, $v0
    /* 7B120 8008A920 0F004010 */  beqz       $v0, .L8008A960
    /* 7B124 8008A924 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 7B128 8008A928 0000068E */  lw         $a2, 0x0($s0)
    /* 7B12C 8008A92C 00000000 */  nop
    /* 7B130 8008A930 6002C28C */  lw         $v0, 0x260($a2)
    /* 7B134 8008A934 00000000 */  nop
    /* 7B138 8008A938 01004230 */  andi       $v0, $v0, 0x1
    /* 7B13C 8008A93C 05004010 */  beqz       $v0, .L8008A954
    /* 7B140 8008A940 00000000 */   nop
    /* 7B144 8008A944 0C00448E */  lw         $a0, 0xC($s2)
    /* 7B148 8008A948 D004C58C */  lw         $a1, 0x4D0($a2)
    /* 7B14C 8008A94C E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* 7B150 8008A950 19000724 */   addiu     $a3, $zero, 0x19
  .L8008A954:
    /* 7B154 8008A954 04001026 */  addiu      $s0, $s0, 0x4
    /* 7B158 8008A958 452A0208 */  j          .L8008A914
    /* 7B15C 8008A95C 01003126 */   addiu     $s1, $s1, 0x1
  .L8008A960:
    /* 7B160 8008A960 21880000 */  addu       $s1, $zero, $zero
    /* 7B164 8008A964 EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
    /* 7B168 8008A968 1280023C */  lui        $v0, %hi(simGlobal)
    /* 7B16C 8008A96C ACE05224 */  addiu      $s2, $v0, %lo(simGlobal)
    /* 7B170 8008A970 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7B174 8008A974 DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
  .L8008A978:
    /* 7B178 8008A978 C403628E */  lw         $v0, 0x3C4($s3)
    /* 7B17C 8008A97C 00000000 */  nop
    /* 7B180 8008A980 2A102202 */  slt        $v0, $s1, $v0
    /* 7B184 8008A984 09004010 */  beqz       $v0, .L8008A9AC
    /* 7B188 8008A988 1E000724 */   addiu     $a3, $zero, 0x1E
    /* 7B18C 8008A98C 0000068E */  lw         $a2, 0x0($s0)
    /* 7B190 8008A990 04001026 */  addiu      $s0, $s0, 0x4
    /* 7B194 8008A994 0C00448E */  lw         $a0, 0xC($s2)
    /* 7B198 8008A998 DC04C58C */  lw         $a1, 0x4DC($a2)
    /* 7B19C 8008A99C E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* 7B1A0 8008A9A0 01003126 */   addiu     $s1, $s1, 0x1
    /* 7B1A4 8008A9A4 5E2A0208 */  j          .L8008A978
    /* 7B1A8 8008A9A8 00000000 */   nop
  .L8008A9AC:
    /* 7B1AC 8008A9AC 21880000 */  addu       $s1, $zero, $zero
    /* 7B1B0 8008A9B0 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 7B1B4 8008A9B4 EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
    /* 7B1B8 8008A9B8 1280023C */  lui        $v0, %hi(simGlobal)
    /* 7B1BC 8008A9BC ACE05224 */  addiu      $s2, $v0, %lo(simGlobal)
    /* 7B1C0 8008A9C0 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7B1C4 8008A9C4 DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
  .L8008A9C8:
    /* 7B1C8 8008A9C8 C403628E */  lw         $v0, 0x3C4($s3)
    /* 7B1CC 8008A9CC 00000000 */  nop
    /* 7B1D0 8008A9D0 2A102202 */  slt        $v0, $s1, $v0
    /* 7B1D4 8008A9D4 12004010 */  beqz       $v0, .L8008AA20
    /* 7B1D8 8008A9D8 00000000 */   nop
    /* 7B1DC 8008A9DC 0000068E */  lw         $a2, 0x0($s0)
    /* 7B1E0 8008A9E0 00000000 */  nop
    /* 7B1E4 8008A9E4 6002C28C */  lw         $v0, 0x260($a2)
    /* 7B1E8 8008A9E8 00000000 */  nop
    /* 7B1EC 8008A9EC 04004230 */  andi       $v0, $v0, 0x4
    /* 7B1F0 8008A9F0 04004010 */  beqz       $v0, .L8008AA04
    /* 7B1F4 8008A9F4 00000000 */   nop
    /* 7B1F8 8008A9F8 0C00448E */  lw         $a0, 0xC($s2)
    /* 7B1FC 8008A9FC 822A0208 */  j          .L8008AA08
    /* 7B200 8008AA00 00000000 */   nop
  .L8008AA04:
    /* 7B204 8008AA04 1400448E */  lw         $a0, 0x14($s2)
  .L8008AA08:
    /* 7B208 8008AA08 E004C58C */  lw         $a1, 0x4E0($a2)
    /* 7B20C 8008AA0C E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* 7B210 8008AA10 1E000724 */   addiu     $a3, $zero, 0x1E
    /* 7B214 8008AA14 04001026 */  addiu      $s0, $s0, 0x4
    /* 7B218 8008AA18 722A0208 */  j          .L8008A9C8
    /* 7B21C 8008AA1C 01003126 */   addiu     $s1, $s1, 0x1
  .L8008AA20:
    /* 7B220 8008AA20 4400BF8F */  lw         $ra, 0x44($sp)
    /* 7B224 8008AA24 4000B48F */  lw         $s4, 0x40($sp)
    /* 7B228 8008AA28 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 7B22C 8008AA2C 3800B28F */  lw         $s2, 0x38($sp)
    /* 7B230 8008AA30 3400B18F */  lw         $s1, 0x34($sp)
    /* 7B234 8008AA34 3000B08F */  lw         $s0, 0x30($sp)
    /* 7B238 8008AA38 0800E003 */  jr         $ra
    /* 7B23C 8008AA3C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Cars_StartUp__Fv
