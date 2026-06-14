.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_MaintainLeaderBoard__Fv, 0x100

glabel AISpeeds_MaintainLeaderBoard__Fv
    /* 5F7A4 8006EFA4 21380000 */  addu       $a3, $zero, $zero
    /* 5F7A8 8006EFA8 2140E000 */  addu       $t0, $a3, $zero
    /* 5F7AC 8006EFAC 1180023C */  lui        $v0, %hi(leaderBoard)
    /* 5F7B0 8006EFB0 21484000 */  addu       $t1, $v0, $zero
    /* 5F7B4 8006EFB4 A4DD2225 */  addiu      $v0, $t1, %lo(leaderBoard)
    /* 5F7B8 8006EFB8 21304000 */  addu       $a2, $v0, $zero
    /* 5F7BC 8006EFBC 1180023C */  lui        $v0, %hi(Cars_gTotalSortedList)
    /* 5F7C0 8006EFC0 1480033C */  lui        $v1, %hi(Cars_gNumCars)
    /* 5F7C4 8006EFC4 F4C7638C */  lw         $v1, %lo(Cars_gNumCars)($v1)
    /* 5F7C8 8006EFC8 20FB4224 */  addiu      $v0, $v0, %lo(Cars_gTotalSortedList)
    /* 5F7CC 8006EFCC A4DD20AD */  sw         $zero, %lo(leaderBoard)($t1)
    /* 5F7D0 8006EFD0 0400C0AC */  sw         $zero, 0x4($a2)
    /* 5F7D4 8006EFD4 0800C0AC */  sw         $zero, 0x8($a2)
    /* 5F7D8 8006EFD8 0C00C0AC */  sw         $zero, 0xC($a2)
    /* 5F7DC 8006EFDC FFFF6524 */  addiu      $a1, $v1, -0x1
    /* 5F7E0 8006EFE0 80180500 */  sll        $v1, $a1, 2
    /* 5F7E4 8006EFE4 21186200 */  addu       $v1, $v1, $v0
  .L8006EFE8:
    /* 5F7E8 8006EFE8 2C00A004 */  bltz       $a1, .L8006F09C
    /* 5F7EC 8006EFEC 00000000 */   nop
    /* 5F7F0 8006EFF0 0000648C */  lw         $a0, 0x0($v1)
    /* 5F7F4 8006EFF4 00000000 */  nop
    /* 5F7F8 8006EFF8 6002828C */  lw         $v0, 0x260($a0)
    /* 5F7FC 8006EFFC 00000000 */  nop
    /* 5F800 8006F000 01004230 */  andi       $v0, $v0, 0x1
    /* 5F804 8006F004 0A004010 */  beqz       $v0, .L8006F030
    /* 5F808 8006F008 00000000 */   nop
    /* 5F80C 8006F00C A4DD228D */  lw         $v0, %lo(leaderBoard)($t1)
    /* 5F810 8006F010 00000000 */  nop
    /* 5F814 8006F014 06004014 */  bnez       $v0, .L8006F030
    /* 5F818 8006F018 00000000 */   nop
    /* 5F81C 8006F01C 6407828C */  lw         $v0, 0x764($a0)
    /* 5F820 8006F020 00000000 */  nop
    /* 5F824 8006F024 02004014 */  bnez       $v0, .L8006F030
    /* 5F828 8006F028 00000000 */   nop
    /* 5F82C 8006F02C A4DD24AD */  sw         $a0, %lo(leaderBoard)($t1)
  .L8006F030:
    /* 5F830 8006F030 6002828C */  lw         $v0, 0x260($a0)
    /* 5F834 8006F034 00000000 */  nop
    /* 5F838 8006F038 08004230 */  andi       $v0, $v0, 0x8
    /* 5F83C 8006F03C 0A004010 */  beqz       $v0, .L8006F068
    /* 5F840 8006F040 00000000 */   nop
    /* 5F844 8006F044 680788AC */  sw         $t0, 0x768($a0)
    /* 5F848 8006F048 21408000 */  addu       $t0, $a0, $zero
    /* 5F84C 8006F04C 740787AC */  sw         $a3, 0x774($a0)
    /* 5F850 8006F050 0800C28C */  lw         $v0, 0x8($a2)
    /* 5F854 8006F054 00000000 */  nop
    /* 5F858 8006F058 02004014 */  bnez       $v0, .L8006F064
    /* 5F85C 8006F05C 0100E724 */   addiu     $a3, $a3, 0x1
    /* 5F860 8006F060 0800C4AC */  sw         $a0, 0x8($a2)
  .L8006F064:
    /* 5F864 8006F064 0C00C4AC */  sw         $a0, 0xC($a2)
  .L8006F068:
    /* 5F868 8006F068 6002828C */  lw         $v0, 0x260($a0)
    /* 5F86C 8006F06C 00000000 */  nop
    /* 5F870 8006F070 04004230 */  andi       $v0, $v0, 0x4
    /* 5F874 8006F074 06004010 */  beqz       $v0, .L8006F090
    /* 5F878 8006F078 00000000 */   nop
    /* 5F87C 8006F07C 0400C28C */  lw         $v0, 0x4($a2)
    /* 5F880 8006F080 00000000 */  nop
    /* 5F884 8006F084 02004014 */  bnez       $v0, .L8006F090
    /* 5F888 8006F088 00000000 */   nop
    /* 5F88C 8006F08C 0400C4AC */  sw         $a0, 0x4($a2)
  .L8006F090:
    /* 5F890 8006F090 FCFF6324 */  addiu      $v1, $v1, -0x4
    /* 5F894 8006F094 FABB0108 */  j          .L8006EFE8
    /* 5F898 8006F098 FFFFA524 */   addiu     $a1, $a1, -0x1
  .L8006F09C:
    /* 5F89C 8006F09C 0800E003 */  jr         $ra
    /* 5F8A0 8006F0A0 00000000 */   nop
endlabel AISpeeds_MaintainLeaderBoard__Fv
