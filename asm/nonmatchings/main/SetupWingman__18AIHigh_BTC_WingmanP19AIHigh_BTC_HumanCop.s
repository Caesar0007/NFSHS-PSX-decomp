.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop, 0x13C

glabel SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop
    /* 4F738 8005EF38 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4F73C 8005EF3C 1800B0AF */  sw         $s0, 0x18($sp)
    /* 4F740 8005EF40 21808000 */  addu       $s0, $a0, $zero
    /* 4F744 8005EF44 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 4F748 8005EF48 0000A48C */  lw         $a0, 0x0($a1)
    /* 4F74C 8005EF4C 00000000 */  nop
    /* 4F750 8005EF50 6405828C */  lw         $v0, 0x564($a0)
    /* 4F754 8005EF54 00000000 */  nop
    /* 4F758 8005EF58 02004004 */  bltz       $v0, .L8005EF64
    /* 4F75C 8005EF5C FFFF0724 */   addiu     $a3, $zero, -0x1
    /* 4F760 8005EF60 01000724 */  addiu      $a3, $zero, 0x1
  .L8005EF64:
    /* 4F764 8005EF64 1480033C */  lui        $v1, %hi(fastRandom)
    /* 4F768 8005EF68 FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 4F76C 8005EF6C 1480023C */  lui        $v0, %hi(randSeed)
    /* 4F770 8005EF70 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 4F774 8005EF74 00000000 */  nop
    /* 4F778 8005EF78 18006200 */  mult       $v1, $v0
    /* 4F77C 8005EF7C 12180000 */  mflo       $v1
    /* 4F780 8005EF80 FFFF6230 */  andi       $v0, $v1, 0xFFFF
    /* 4F784 8005EF84 1480013C */  lui        $at, %hi(randtemp)
    /* 4F788 8005EF88 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 4F78C 8005EF8C 021A0300 */  srl        $v1, $v1, 8
    /* 4F790 8005EF90 FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* 4F794 8005EF94 1480013C */  lui        $at, %hi(fastRandom)
    /* 4F798 8005EF98 FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 4F79C 8005EF9C 40110300 */  sll        $v0, $v1, 5
    /* 4F7A0 8005EFA0 23104300 */  subu       $v0, $v0, $v1
    /* 4F7A4 8005EFA4 80100200 */  sll        $v0, $v0, 2
    /* 4F7A8 8005EFA8 21104300 */  addu       $v0, $v0, $v1
    /* 4F7AC 8005EFAC C0100200 */  sll        $v0, $v0, 3
    /* 4F7B0 8005EFB0 02140200 */  srl        $v0, $v0, 16
    /* 4F7B4 8005EFB4 F401422C */  sltiu      $v0, $v0, 0x1F4
    /* 4F7B8 8005EFB8 02004010 */  beqz       $v0, .L8005EFC4
    /* 4F7BC 8005EFBC FFFF0524 */   addiu     $a1, $zero, -0x1
    /* 4F7C0 8005EFC0 01000524 */  addiu      $a1, $zero, 0x1
  .L8005EFC4:
    /* 4F7C4 8005EFC4 C0100700 */  sll        $v0, $a3, 3
    /* 4F7C8 8005EFC8 23104700 */  subu       $v0, $v0, $a3
    /* 4F7CC 8005EFCC 80100200 */  sll        $v0, $v0, 2
    /* 4F7D0 8005EFD0 1800A200 */  mult       $a1, $v0
    /* 4F7D4 8005EFD4 12280000 */  mflo       $a1
    /* 4F7D8 8005EFD8 0A00A004 */  bltz       $a1, .L8005F004
    /* 4F7DC 8005EFDC 00000000 */   nop
    /* 4F7E0 8005EFE0 08008284 */  lh         $v0, 0x8($a0)
    /* 4F7E4 8005EFE4 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 4F7E8 8005EFE8 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 4F7EC 8005EFEC 21284500 */  addu       $a1, $v0, $a1
    /* 4F7F0 8005EFF0 2A10A300 */  slt        $v0, $a1, $v1
    /* 4F7F4 8005EFF4 0C004014 */  bnez       $v0, .L8005F028
    /* 4F7F8 8005EFF8 00000000 */   nop
    /* 4F7FC 8005EFFC 0A7C0108 */  j          .L8005F028
    /* 4F800 8005F000 2328A300 */   subu      $a1, $a1, $v1
  .L8005F004:
    /* 4F804 8005F004 08008284 */  lh         $v0, 0x8($a0)
    /* 4F808 8005F008 00000000 */  nop
    /* 4F80C 8005F00C 21284500 */  addu       $a1, $v0, $a1
    /* 4F810 8005F010 0500A104 */  bgez       $a1, .L8005F028
    /* 4F814 8005F014 00000000 */   nop
    /* 4F818 8005F018 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4F81C 8005F01C C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4F820 8005F020 00000000 */  nop
    /* 4F824 8005F024 2128A200 */  addu       $a1, $a1, $v0
  .L8005F028:
    /* 4F828 8005F028 6405828C */  lw         $v0, 0x564($a0)
    /* 4F82C 8005F02C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 4F830 8005F030 1000A2AF */  sw         $v0, 0x10($sp)
    /* 4F834 8005F034 0000048E */  lw         $a0, 0x0($s0)
    /* 4F838 8005F038 149F010C */  jal        AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
    /* 4F83C 8005F03C 21300000 */   addu      $a2, $zero, $zero
    /* 4F840 8005F040 BC57020C */  jal        Dispatch__6Speech
    /* 4F844 8005F044 00000000 */   nop
    /* 4F848 8005F048 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4F84C 8005F04C 0000058E */  lw         $a1, 0x0($s0)
    /* 4F850 8005F050 28006484 */  lh         $a0, 0x28($v1)
    /* 4F854 8005F054 2C00638C */  lw         $v1, 0x2C($v1)
    /* 4F858 8005F058 00000000 */  nop
    /* 4F85C 8005F05C 09F86000 */  jalr       $v1
    /* 4F860 8005F060 21204400 */   addu      $a0, $v0, $a0
    /* 4F864 8005F064 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 4F868 8005F068 1800B08F */  lw         $s0, 0x18($sp)
    /* 4F86C 8005F06C 0800E003 */  jr         $ra
    /* 4F870 8005F070 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop
