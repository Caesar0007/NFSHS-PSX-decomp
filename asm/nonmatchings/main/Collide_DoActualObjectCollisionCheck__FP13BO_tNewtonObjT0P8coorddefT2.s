.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2, 0xBF4

glabel Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2
    /* 7FD50 8008F550 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 7FD54 8008F554 6400B1AF */  sw         $s1, 0x64($sp)
    /* 7FD58 8008F558 21888000 */  addu       $s1, $a0, $zero
    /* 7FD5C 8008F55C 6800B2AF */  sw         $s2, 0x68($sp)
    /* 7FD60 8008F560 2190A000 */  addu       $s2, $a1, $zero
    /* 7FD64 8008F564 01000424 */  addiu      $a0, $zero, 0x1
    /* 7FD68 8008F568 21280000 */  addu       $a1, $zero, $zero
    /* 7FD6C 8008F56C FC0286AF */  sw         $a2, %gp_rel(pP)($gp)
    /* 7FD70 8008F570 6000B0AF */  sw         $s0, 0x60($sp)
    /* 7FD74 8008F574 2180E000 */  addu       $s0, $a3, $zero
    /* 7FD78 8008F578 6C00BFAF */  sw         $ra, 0x6C($sp)
    /* 7FD7C 8008F57C F00291AF */  sw         $s1, %gp_rel(obj0)($gp)
    /* 7FD80 8008F580 F40292AF */  sw         $s2, %gp_rel(obj1)($gp)
    /* 7FD84 8008F584 F80290AF */  sw         $s0, %gp_rel(pNormal)($gp)
    /* 7FD88 8008F588 9C2E020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
    /* 7FD8C 8008F58C 2130A000 */   addu      $a2, $a1, $zero
    /* 7FD90 8008F590 E6024014 */  bnez       $v0, .L8009012C
    /* 7FD94 8008F594 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FD98 8008F598 21200000 */  addu       $a0, $zero, $zero
    /* 7FD9C 8008F59C 01000524 */  addiu      $a1, $zero, 0x1
    /* 7FDA0 8008F5A0 9C2E020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
    /* 7FDA4 8008F5A4 21308000 */   addu      $a2, $a0, $zero
    /* 7FDA8 8008F5A8 E0024014 */  bnez       $v0, .L8009012C
    /* 7FDAC 8008F5AC 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FDB0 8008F5B0 21200000 */  addu       $a0, $zero, $zero
    /* 7FDB4 8008F5B4 21288000 */  addu       $a1, $a0, $zero
    /* 7FDB8 8008F5B8 9C2E020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
    /* 7FDBC 8008F5BC 01000624 */   addiu     $a2, $zero, 0x1
    /* 7FDC0 8008F5C0 DA024014 */  bnez       $v0, .L8009012C
    /* 7FDC4 8008F5C4 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FDC8 8008F5C8 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* 7FDCC 8008F5CC 21280000 */  addu       $a1, $zero, $zero
    /* 7FDD0 8008F5D0 9C2E020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
    /* 7FDD4 8008F5D4 2130A000 */   addu      $a2, $a1, $zero
    /* 7FDD8 8008F5D8 D4024014 */  bnez       $v0, .L8009012C
    /* 7FDDC 8008F5DC 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FDE0 8008F5E0 21200000 */  addu       $a0, $zero, $zero
    /* 7FDE4 8008F5E4 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 7FDE8 8008F5E8 9C2E020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
    /* 7FDEC 8008F5EC 21308000 */   addu      $a2, $a0, $zero
    /* 7FDF0 8008F5F0 CE024014 */  bnez       $v0, .L8009012C
    /* 7FDF4 8008F5F4 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FDF8 8008F5F8 21200000 */  addu       $a0, $zero, $zero
    /* 7FDFC 8008F5FC 21288000 */  addu       $a1, $a0, $zero
    /* 7FE00 8008F600 9C2E020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
    /* 7FE04 8008F604 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 7FE08 8008F608 C8024014 */  bnez       $v0, .L8009012C
    /* 7FE0C 8008F60C 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FE10 8008F610 01000424 */  addiu      $a0, $zero, 0x1
    /* 7FE14 8008F614 21280000 */  addu       $a1, $zero, $zero
    /* 7FE18 8008F618 BC2F020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FE1C 8008F61C 2130A000 */   addu      $a2, $a1, $zero
    /* 7FE20 8008F620 C2024014 */  bnez       $v0, .L8009012C
    /* 7FE24 8008F624 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FE28 8008F628 21200000 */  addu       $a0, $zero, $zero
    /* 7FE2C 8008F62C 01000524 */  addiu      $a1, $zero, 0x1
    /* 7FE30 8008F630 BC2F020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FE34 8008F634 21308000 */   addu      $a2, $a0, $zero
    /* 7FE38 8008F638 BC024014 */  bnez       $v0, .L8009012C
    /* 7FE3C 8008F63C 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FE40 8008F640 21200000 */  addu       $a0, $zero, $zero
    /* 7FE44 8008F644 21288000 */  addu       $a1, $a0, $zero
    /* 7FE48 8008F648 BC2F020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FE4C 8008F64C 01000624 */   addiu     $a2, $zero, 0x1
    /* 7FE50 8008F650 B6024014 */  bnez       $v0, .L8009012C
    /* 7FE54 8008F654 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FE58 8008F658 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* 7FE5C 8008F65C 21280000 */  addu       $a1, $zero, $zero
    /* 7FE60 8008F660 BC2F020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FE64 8008F664 2130A000 */   addu      $a2, $a1, $zero
    /* 7FE68 8008F668 B0024014 */  bnez       $v0, .L8009012C
    /* 7FE6C 8008F66C 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FE70 8008F670 21200000 */  addu       $a0, $zero, $zero
    /* 7FE74 8008F674 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 7FE78 8008F678 BC2F020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FE7C 8008F67C 21308000 */   addu      $a2, $a0, $zero
    /* 7FE80 8008F680 AA024014 */  bnez       $v0, .L8009012C
    /* 7FE84 8008F684 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FE88 8008F688 21200000 */  addu       $a0, $zero, $zero
    /* 7FE8C 8008F68C 21288000 */  addu       $a1, $a0, $zero
    /* 7FE90 8008F690 BC2F020C */  jal        CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FE94 8008F694 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 7FE98 8008F698 A4024014 */  bnez       $v0, .L8009012C
    /* 7FE9C 8008F69C 01000224 */   addiu     $v0, $zero, 0x1
    /* 7FEA0 8008F6A0 01000424 */  addiu      $a0, $zero, 0x1
    /* 7FEA4 8008F6A4 21288000 */  addu       $a1, $a0, $zero
    /* 7FEA8 8008F6A8 DF30020C */  jal        CHECK_VERTEX_WITH_DIRS__Fiii
    /* 7FEAC 8008F6AC 21308000 */   addu      $a2, $a0, $zero
    /* 7FEB0 8008F6B0 4E004014 */  bnez       $v0, .L8008F7EC
    /* 7FEB4 8008F6B4 01000424 */   addiu     $a0, $zero, 0x1
    /* 7FEB8 8008F6B8 21288000 */  addu       $a1, $a0, $zero
    /* 7FEBC 8008F6BC DF30020C */  jal        CHECK_VERTEX_WITH_DIRS__Fiii
    /* 7FEC0 8008F6C0 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 7FEC4 8008F6C4 49004014 */  bnez       $v0, .L8008F7EC
    /* 7FEC8 8008F6C8 01000424 */   addiu     $a0, $zero, 0x1
    /* 7FECC 8008F6CC FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 7FED0 8008F6D0 DF30020C */  jal        CHECK_VERTEX_WITH_DIRS__Fiii
    /* 7FED4 8008F6D4 21308000 */   addu      $a2, $a0, $zero
    /* 7FED8 8008F6D8 44004014 */  bnez       $v0, .L8008F7EC
    /* 7FEDC 8008F6DC 01000424 */   addiu     $a0, $zero, 0x1
    /* 7FEE0 8008F6E0 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 7FEE4 8008F6E4 DF30020C */  jal        CHECK_VERTEX_WITH_DIRS__Fiii
    /* 7FEE8 8008F6E8 2130A000 */   addu      $a2, $a1, $zero
    /* 7FEEC 8008F6EC 3F004014 */  bnez       $v0, .L8008F7EC
    /* 7FEF0 8008F6F0 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* 7FEF4 8008F6F4 01000524 */  addiu      $a1, $zero, 0x1
    /* 7FEF8 8008F6F8 DF30020C */  jal        CHECK_VERTEX_WITH_DIRS__Fiii
    /* 7FEFC 8008F6FC 2130A000 */   addu      $a2, $a1, $zero
    /* 7FF00 8008F700 3A004014 */  bnez       $v0, .L8008F7EC
    /* 7FF04 8008F704 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* 7FF08 8008F708 01000524 */  addiu      $a1, $zero, 0x1
    /* 7FF0C 8008F70C DF30020C */  jal        CHECK_VERTEX_WITH_DIRS__Fiii
    /* 7FF10 8008F710 21308000 */   addu      $a2, $a0, $zero
    /* 7FF14 8008F714 35004014 */  bnez       $v0, .L8008F7EC
    /* 7FF18 8008F718 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* 7FF1C 8008F71C 21288000 */  addu       $a1, $a0, $zero
    /* 7FF20 8008F720 DF30020C */  jal        CHECK_VERTEX_WITH_DIRS__Fiii
    /* 7FF24 8008F724 01000624 */   addiu     $a2, $zero, 0x1
    /* 7FF28 8008F728 30004014 */  bnez       $v0, .L8008F7EC
    /* 7FF2C 8008F72C FFFF0424 */   addiu     $a0, $zero, -0x1
    /* 7FF30 8008F730 21288000 */  addu       $a1, $a0, $zero
    /* 7FF34 8008F734 DF30020C */  jal        CHECK_VERTEX_WITH_DIRS__Fiii
    /* 7FF38 8008F738 21308000 */   addu      $a2, $a0, $zero
    /* 7FF3C 8008F73C 2B004014 */  bnez       $v0, .L8008F7EC
    /* 7FF40 8008F740 01000424 */   addiu     $a0, $zero, 0x1
    /* 7FF44 8008F744 21288000 */  addu       $a1, $a0, $zero
    /* 7FF48 8008F748 D131020C */  jal        CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FF4C 8008F74C 21308000 */   addu      $a2, $a0, $zero
    /* 7FF50 8008F750 3F014014 */  bnez       $v0, .L8008FC50
    /* 7FF54 8008F754 01000424 */   addiu     $a0, $zero, 0x1
    /* 7FF58 8008F758 21288000 */  addu       $a1, $a0, $zero
    /* 7FF5C 8008F75C D131020C */  jal        CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FF60 8008F760 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 7FF64 8008F764 3A014014 */  bnez       $v0, .L8008FC50
    /* 7FF68 8008F768 01000424 */   addiu     $a0, $zero, 0x1
    /* 7FF6C 8008F76C FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 7FF70 8008F770 D131020C */  jal        CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FF74 8008F774 21308000 */   addu      $a2, $a0, $zero
    /* 7FF78 8008F778 35014014 */  bnez       $v0, .L8008FC50
    /* 7FF7C 8008F77C 01000424 */   addiu     $a0, $zero, 0x1
    /* 7FF80 8008F780 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 7FF84 8008F784 D131020C */  jal        CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FF88 8008F788 2130A000 */   addu      $a2, $a1, $zero
    /* 7FF8C 8008F78C 30014014 */  bnez       $v0, .L8008FC50
    /* 7FF90 8008F790 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* 7FF94 8008F794 01000524 */  addiu      $a1, $zero, 0x1
    /* 7FF98 8008F798 D131020C */  jal        CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FF9C 8008F79C 2130A000 */   addu      $a2, $a1, $zero
    /* 7FFA0 8008F7A0 2B014014 */  bnez       $v0, .L8008FC50
    /* 7FFA4 8008F7A4 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* 7FFA8 8008F7A8 01000524 */  addiu      $a1, $zero, 0x1
    /* 7FFAC 8008F7AC D131020C */  jal        CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FFB0 8008F7B0 21308000 */   addu      $a2, $a0, $zero
    /* 7FFB4 8008F7B4 26014014 */  bnez       $v0, .L8008FC50
    /* 7FFB8 8008F7B8 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* 7FFBC 8008F7BC 21288000 */  addu       $a1, $a0, $zero
    /* 7FFC0 8008F7C0 D131020C */  jal        CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FFC4 8008F7C4 01000624 */   addiu     $a2, $zero, 0x1
    /* 7FFC8 8008F7C8 21014014 */  bnez       $v0, .L8008FC50
    /* 7FFCC 8008F7CC FFFF0424 */   addiu     $a0, $zero, -0x1
    /* 7FFD0 8008F7D0 21288000 */  addu       $a1, $a0, $zero
    /* 7FFD4 8008F7D4 D131020C */  jal        CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
    /* 7FFD8 8008F7D8 21308000 */   addu      $a2, $a0, $zero
    /* 7FFDC 8008F7DC 1C014014 */  bnez       $v0, .L8008FC50
    /* 7FFE0 8008F7E0 21100000 */   addu      $v0, $zero, $zero
    /* 7FFE4 8008F7E4 4B400208 */  j          .L8009012C
    /* 7FFE8 8008F7E8 00000000 */   nop
  .L8008F7EC:
    /* 7FFEC 8008F7EC AC00448E */  lw         $a0, 0xAC($s2)
    /* 7FFF0 8008F7F0 AC00238E */  lw         $v1, 0xAC($s1)
    /* 7FFF4 8008F7F4 EC0280AF */  sw         $zero, %gp_rel(findClosestSideDave)($gp)
    /* 7FFF8 8008F7F8 23108300 */  subu       $v0, $a0, $v1
    /* 7FFFC 8008F7FC 0200401C */  bgtz       $v0, .L8008F808
    /* 80000 8008F800 00000000 */   nop
    /* 80004 8008F804 23106400 */  subu       $v0, $v1, $a0
  .L8008F808:
    /* 80008 8008F808 B000448E */  lw         $a0, 0xB0($s2)
    /* 8000C 8008F80C B000238E */  lw         $v1, 0xB0($s1)
    /* 80010 8008F810 00000000 */  nop
    /* 80014 8008F814 23288300 */  subu       $a1, $a0, $v1
    /* 80018 8008F818 0200A01C */  bgtz       $a1, .L8008F824
    /* 8001C 8008F81C 00000000 */   nop
    /* 80020 8008F820 23286400 */  subu       $a1, $v1, $a0
  .L8008F824:
    /* 80024 8008F824 B400468E */  lw         $a2, 0xB4($s2)
    /* 80028 8008F828 B400238E */  lw         $v1, 0xB4($s1)
    /* 8002C 8008F82C 00000000 */  nop
    /* 80030 8008F830 2320C300 */  subu       $a0, $a2, $v1
    /* 80034 8008F834 0200801C */  bgtz       $a0, .L8008F840
    /* 80038 8008F838 00000000 */   nop
    /* 8003C 8008F83C 23206600 */  subu       $a0, $v1, $a2
  .L8008F840:
    /* 80040 8008F840 21184000 */  addu       $v1, $v0, $zero
    /* 80044 8008F844 2A106500 */  slt        $v0, $v1, $a1
    /* 80048 8008F848 03004010 */  beqz       $v0, .L8008F858
    /* 8004C 8008F84C 2A106400 */   slt       $v0, $v1, $a0
    /* 80050 8008F850 2118A000 */  addu       $v1, $a1, $zero
    /* 80054 8008F854 2A106400 */  slt        $v0, $v1, $a0
  .L8008F858:
    /* 80058 8008F858 02004010 */  beqz       $v0, .L8008F864
    /* 8005C 8008F85C 0F00023C */   lui       $v0, (0xF0000 >> 16)
    /* 80060 8008F860 21188000 */  addu       $v1, $a0, $zero
  .L8008F864:
    /* 80064 8008F864 2A104300 */  slt        $v0, $v0, $v1
    /* 80068 8008F868 02004010 */  beqz       $v0, .L8008F874
    /* 8006C 8008F86C 01000224 */   addiu     $v0, $zero, 0x1
    /* 80070 8008F870 EC0282AF */  sw         $v0, %gp_rel(findClosestSideDave)($gp)
  .L8008F874:
    /* 80074 8008F874 EC02828F */  lw         $v0, %gp_rel(findClosestSideDave)($gp)
    /* 80078 8008F878 00000000 */  nop
    /* 8007C 8008F87C B1004010 */  beqz       $v0, .L8008FB44
    /* 80080 8008F880 00000000 */   nop
    /* 80084 8008F884 4C18828F */  lw         $v0, %gp_rel(D_8013DD98)($gp)
    /* 80088 8008F888 AC004B8E */  lw         $t3, 0xAC($s2)
    /* 8008C 8008F88C B0004C8E */  lw         $t4, 0xB0($s2)
    /* 80090 8008F890 B4004D8E */  lw         $t5, 0xB4($s2)
    /* 80094 8008F894 4000ABAF */  sw         $t3, 0x40($sp)
    /* 80098 8008F898 4400ACAF */  sw         $t4, 0x44($sp)
    /* 8009C 8008F89C 4800ADAF */  sw         $t5, 0x48($sp)
    /* 800A0 8008F8A0 F0002B8E */  lw         $t3, 0xF0($s1)
    /* 800A4 8008F8A4 F4002C8E */  lw         $t4, 0xF4($s1)
    /* 800A8 8008F8A8 F8002D8E */  lw         $t5, 0xF8($s1)
    /* 800AC 8008F8AC 1000ABAF */  sw         $t3, 0x10($sp)
    /* 800B0 8008F8B0 1400ACAF */  sw         $t4, 0x14($sp)
    /* 800B4 8008F8B4 1800ADAF */  sw         $t5, 0x18($sp)
    /* 800B8 8008F8B8 FC002B8E */  lw         $t3, 0xFC($s1)
    /* 800BC 8008F8BC 00012C8E */  lw         $t4, 0x100($s1)
    /* 800C0 8008F8C0 04012D8E */  lw         $t5, 0x104($s1)
    /* 800C4 8008F8C4 2000ABAF */  sw         $t3, 0x20($sp)
    /* 800C8 8008F8C8 2400ACAF */  sw         $t4, 0x24($sp)
    /* 800CC 8008F8CC 2800ADAF */  sw         $t5, 0x28($sp)
    /* 800D0 8008F8D0 08012B8E */  lw         $t3, 0x108($s1)
    /* 800D4 8008F8D4 0C012C8E */  lw         $t4, 0x10C($s1)
    /* 800D8 8008F8D8 10012D8E */  lw         $t5, 0x110($s1)
    /* 800DC 8008F8DC 3000ABAF */  sw         $t3, 0x30($sp)
    /* 800E0 8008F8E0 3400ACAF */  sw         $t4, 0x34($sp)
    /* 800E4 8008F8E4 3800ADAF */  sw         $t5, 0x38($sp)
    /* 800E8 8008F8E8 0A004018 */  blez       $v0, .L8008F914
    /* 800EC 8008F8EC 00000000 */   nop
    /* 800F0 8008F8F0 1000A28F */  lw         $v0, 0x10($sp)
    /* 800F4 8008F8F4 1800A38F */  lw         $v1, 0x18($sp)
    /* 800F8 8008F8F8 23100200 */  negu       $v0, $v0
    /* 800FC 8008F8FC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 80100 8008F900 1400A28F */  lw         $v0, 0x14($sp)
    /* 80104 8008F904 23180300 */  negu       $v1, $v1
    /* 80108 8008F908 1800A3AF */  sw         $v1, 0x18($sp)
    /* 8010C 8008F90C 23100200 */  negu       $v0, $v0
    /* 80110 8008F910 1400A2AF */  sw         $v0, 0x14($sp)
  .L8008F914:
    /* 80114 8008F914 5018828F */  lw         $v0, %gp_rel(D_8013DD9C)($gp)
    /* 80118 8008F918 00000000 */  nop
    /* 8011C 8008F91C 0A004018 */  blez       $v0, .L8008F948
    /* 80120 8008F920 00000000 */   nop
    /* 80124 8008F924 2000A28F */  lw         $v0, 0x20($sp)
    /* 80128 8008F928 2800A38F */  lw         $v1, 0x28($sp)
    /* 8012C 8008F92C 23100200 */  negu       $v0, $v0
    /* 80130 8008F930 2000A2AF */  sw         $v0, 0x20($sp)
    /* 80134 8008F934 2400A28F */  lw         $v0, 0x24($sp)
    /* 80138 8008F938 23180300 */  negu       $v1, $v1
    /* 8013C 8008F93C 2800A3AF */  sw         $v1, 0x28($sp)
    /* 80140 8008F940 23100200 */  negu       $v0, $v0
    /* 80144 8008F944 2400A2AF */  sw         $v0, 0x24($sp)
  .L8008F948:
    /* 80148 8008F948 5418828F */  lw         $v0, %gp_rel(D_8013DDA0)($gp)
    /* 8014C 8008F94C 00000000 */  nop
    /* 80150 8008F950 0A004018 */  blez       $v0, .L8008F97C
    /* 80154 8008F954 00000000 */   nop
    /* 80158 8008F958 3000A28F */  lw         $v0, 0x30($sp)
    /* 8015C 8008F95C 3800A38F */  lw         $v1, 0x38($sp)
    /* 80160 8008F960 23100200 */  negu       $v0, $v0
    /* 80164 8008F964 3000A2AF */  sw         $v0, 0x30($sp)
    /* 80168 8008F968 3400A28F */  lw         $v0, 0x34($sp)
    /* 8016C 8008F96C 23180300 */  negu       $v1, $v1
    /* 80170 8008F970 3800A3AF */  sw         $v1, 0x38($sp)
    /* 80174 8008F974 23100200 */  negu       $v0, $v0
    /* 80178 8008F978 3400A2AF */  sw         $v0, 0x34($sp)
  .L8008F97C:
    /* 8017C 8008F97C 1000A28F */  lw         $v0, 0x10($sp)
    /* 80180 8008F980 00000000 */  nop
    /* 80184 8008F984 02004104 */  bgez       $v0, .L8008F990
    /* 80188 8008F988 00000000 */   nop
    /* 8018C 8008F98C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008F990:
    /* 80190 8008F990 4000A68F */  lw         $a2, 0x40($sp)
    /* 80194 8008F994 03220200 */  sra        $a0, $v0, 8
    /* 80198 8008F998 0200C104 */  bgez       $a2, .L8008F9A4
    /* 8019C 8008F99C 2118C000 */   addu      $v1, $a2, $zero
    /* 801A0 8008F9A0 FF00C324 */  addiu      $v1, $a2, 0xFF
  .L8008F9A4:
    /* 801A4 8008F9A4 03520300 */  sra        $t2, $v1, 8
    /* 801A8 8008F9A8 18008A00 */  mult       $a0, $t2
    /* 801AC 8008F9AC 1400A28F */  lw         $v0, 0x14($sp)
    /* 801B0 8008F9B0 12200000 */  mflo       $a0
    /* 801B4 8008F9B4 02004104 */  bgez       $v0, .L8008F9C0
    /* 801B8 8008F9B8 00000000 */   nop
    /* 801BC 8008F9BC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008F9C0:
    /* 801C0 8008F9C0 4400A58F */  lw         $a1, 0x44($sp)
    /* 801C4 8008F9C4 03120200 */  sra        $v0, $v0, 8
    /* 801C8 8008F9C8 0200A104 */  bgez       $a1, .L8008F9D4
    /* 801CC 8008F9CC 2118A000 */   addu      $v1, $a1, $zero
    /* 801D0 8008F9D0 FF00A324 */  addiu      $v1, $a1, 0xFF
  .L8008F9D4:
    /* 801D4 8008F9D4 034A0300 */  sra        $t1, $v1, 8
    /* 801D8 8008F9D8 18004900 */  mult       $v0, $t1
    /* 801DC 8008F9DC 1800A28F */  lw         $v0, 0x18($sp)
    /* 801E0 8008F9E0 12580000 */  mflo       $t3
    /* 801E4 8008F9E4 02004104 */  bgez       $v0, .L8008F9F0
    /* 801E8 8008F9E8 21388B00 */   addu      $a3, $a0, $t3
    /* 801EC 8008F9EC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008F9F0:
    /* 801F0 8008F9F0 4800A48F */  lw         $a0, 0x48($sp)
    /* 801F4 8008F9F4 03120200 */  sra        $v0, $v0, 8
    /* 801F8 8008F9F8 02008104 */  bgez       $a0, .L8008FA04
    /* 801FC 8008F9FC 21188000 */   addu      $v1, $a0, $zero
    /* 80200 8008FA00 FF008324 */  addiu      $v1, $a0, 0xFF
  .L8008FA04:
    /* 80204 8008FA04 03420300 */  sra        $t0, $v1, 8
    /* 80208 8008FA08 18004800 */  mult       $v0, $t0
    /* 8020C 8008FA0C 2000A28F */  lw         $v0, 0x20($sp)
    /* 80210 8008FA10 12580000 */  mflo       $t3
    /* 80214 8008FA14 02004104 */  bgez       $v0, .L8008FA20
    /* 80218 8008FA18 2138EB00 */   addu      $a3, $a3, $t3
    /* 8021C 8008FA1C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FA20:
    /* 80220 8008FA20 031A0200 */  sra        $v1, $v0, 8
    /* 80224 8008FA24 18006A00 */  mult       $v1, $t2
    /* 80228 8008FA28 2400A28F */  lw         $v0, 0x24($sp)
    /* 8022C 8008FA2C 12300000 */  mflo       $a2
    /* 80230 8008FA30 02004104 */  bgez       $v0, .L8008FA3C
    /* 80234 8008FA34 00000000 */   nop
    /* 80238 8008FA38 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FA3C:
    /* 8023C 8008FA3C 03120200 */  sra        $v0, $v0, 8
    /* 80240 8008FA40 18004900 */  mult       $v0, $t1
    /* 80244 8008FA44 2800A38F */  lw         $v1, 0x28($sp)
    /* 80248 8008FA48 12580000 */  mflo       $t3
    /* 8024C 8008FA4C 02006104 */  bgez       $v1, .L8008FA58
    /* 80250 8008FA50 2110CB00 */   addu      $v0, $a2, $t3
    /* 80254 8008FA54 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008FA58:
    /* 80258 8008FA58 031A0300 */  sra        $v1, $v1, 8
    /* 8025C 8008FA5C 18006800 */  mult       $v1, $t0
    /* 80260 8008FA60 3000A38F */  lw         $v1, 0x30($sp)
    /* 80264 8008FA64 12580000 */  mflo       $t3
    /* 80268 8008FA68 02006104 */  bgez       $v1, .L8008FA74
    /* 8026C 8008FA6C 21284B00 */   addu      $a1, $v0, $t3
    /* 80270 8008FA70 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008FA74:
    /* 80274 8008FA74 4000A28F */  lw         $v0, 0x40($sp)
    /* 80278 8008FA78 00000000 */  nop
    /* 8027C 8008FA7C 02004104 */  bgez       $v0, .L8008FA88
    /* 80280 8008FA80 03220300 */   sra       $a0, $v1, 8
    /* 80284 8008FA84 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FA88:
    /* 80288 8008FA88 03120200 */  sra        $v0, $v0, 8
    /* 8028C 8008FA8C 18008200 */  mult       $a0, $v0
    /* 80290 8008FA90 3400A38F */  lw         $v1, 0x34($sp)
    /* 80294 8008FA94 12200000 */  mflo       $a0
    /* 80298 8008FA98 02006104 */  bgez       $v1, .L8008FAA4
    /* 8029C 8008FA9C 00000000 */   nop
    /* 802A0 8008FAA0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008FAA4:
    /* 802A4 8008FAA4 4400A28F */  lw         $v0, 0x44($sp)
    /* 802A8 8008FAA8 00000000 */  nop
    /* 802AC 8008FAAC 02004104 */  bgez       $v0, .L8008FAB8
    /* 802B0 8008FAB0 031A0300 */   sra       $v1, $v1, 8
    /* 802B4 8008FAB4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FAB8:
    /* 802B8 8008FAB8 03120200 */  sra        $v0, $v0, 8
    /* 802BC 8008FABC 18006200 */  mult       $v1, $v0
    /* 802C0 8008FAC0 3800A38F */  lw         $v1, 0x38($sp)
    /* 802C4 8008FAC4 12580000 */  mflo       $t3
    /* 802C8 8008FAC8 02006104 */  bgez       $v1, .L8008FAD4
    /* 802CC 8008FACC 21208B00 */   addu      $a0, $a0, $t3
    /* 802D0 8008FAD0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008FAD4:
    /* 802D4 8008FAD4 4800A28F */  lw         $v0, 0x48($sp)
    /* 802D8 8008FAD8 00000000 */  nop
    /* 802DC 8008FADC 02004104 */  bgez       $v0, .L8008FAE8
    /* 802E0 8008FAE0 031A0300 */   sra       $v1, $v1, 8
    /* 802E4 8008FAE4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FAE8:
    /* 802E8 8008FAE8 03120200 */  sra        $v0, $v0, 8
    /* 802EC 8008FAEC 18006200 */  mult       $v1, $v0
    /* 802F0 8008FAF0 0200E104 */  bgez       $a3, .L8008FAFC
    /* 802F4 8008FAF4 00000000 */   nop
    /* 802F8 8008FAF8 23380700 */  negu       $a3, $a3
  .L8008FAFC:
    /* 802FC 8008FAFC 0200A104 */  bgez       $a1, .L8008FB08
    /* 80300 8008FB00 00000000 */   nop
    /* 80304 8008FB04 23280500 */  negu       $a1, $a1
  .L8008FB08:
    /* 80308 8008FB08 2A10A700 */  slt        $v0, $a1, $a3
    /* 8030C 8008FB0C 12580000 */  mflo       $t3
    /* 80310 8008FB10 21188B00 */  addu       $v1, $a0, $t3
    /* 80314 8008FB14 02006104 */  bgez       $v1, .L8008FB20
    /* 80318 8008FB18 00000000 */   nop
    /* 8031C 8008FB1C 23180300 */  negu       $v1, $v1
  .L8008FB20:
    /* 80320 8008FB20 03004010 */  beqz       $v0, .L8008FB30
    /* 80324 8008FB24 2A106700 */   slt       $v0, $v1, $a3
    /* 80328 8008FB28 1A014014 */  bnez       $v0, .L8008FF94
    /* 8032C 8008FB2C 00000000 */   nop
  .L8008FB30:
    /* 80330 8008FB30 2A106500 */  slt        $v0, $v1, $a1
    /* 80334 8008FB34 2A014010 */  beqz       $v0, .L8008FFE0
    /* 80338 8008FB38 00000000 */   nop
    /* 8033C 8008FB3C F03F0208 */  j          .L8008FFC0
    /* 80340 8008FB40 00000000 */   nop
  .L8008FB44:
    /* 80344 8008FB44 4C18838F */  lw         $v1, %gp_rel(D_8013DD98)($gp)
    /* 80348 8008FB48 00000000 */  nop
    /* 8034C 8008FB4C 04006104 */  bgez       $v1, .L8008FB60
    /* 80350 8008FB50 00000000 */   nop
    /* 80354 8008FB54 3401228E */  lw         $v0, 0x134($s1)
    /* 80358 8008FB58 DB3E0208 */  j          .L8008FB6C
    /* 8035C 8008FB5C 21284300 */   addu      $a1, $v0, $v1
  .L8008FB60:
    /* 80360 8008FB60 3401228E */  lw         $v0, 0x134($s1)
    /* 80364 8008FB64 00000000 */  nop
    /* 80368 8008FB68 23284300 */  subu       $a1, $v0, $v1
  .L8008FB6C:
    /* 8036C 8008FB6C 5018838F */  lw         $v1, %gp_rel(D_8013DD9C)($gp)
    /* 80370 8008FB70 00000000 */  nop
    /* 80374 8008FB74 04006104 */  bgez       $v1, .L8008FB88
    /* 80378 8008FB78 00000000 */   nop
    /* 8037C 8008FB7C 3801228E */  lw         $v0, 0x138($s1)
    /* 80380 8008FB80 E53E0208 */  j          .L8008FB94
    /* 80384 8008FB84 21204300 */   addu      $a0, $v0, $v1
  .L8008FB88:
    /* 80388 8008FB88 3801228E */  lw         $v0, 0x138($s1)
    /* 8038C 8008FB8C 00000000 */  nop
    /* 80390 8008FB90 23204300 */  subu       $a0, $v0, $v1
  .L8008FB94:
    /* 80394 8008FB94 5418838F */  lw         $v1, %gp_rel(D_8013DDA0)($gp)
    /* 80398 8008FB98 00000000 */  nop
    /* 8039C 8008FB9C 04006104 */  bgez       $v1, .L8008FBB0
    /* 803A0 8008FBA0 00000000 */   nop
    /* 803A4 8008FBA4 3C01228E */  lw         $v0, 0x13C($s1)
    /* 803A8 8008FBA8 EF3E0208 */  j          .L8008FBBC
    /* 803AC 8008FBAC 21184300 */   addu      $v1, $v0, $v1
  .L8008FBB0:
    /* 803B0 8008FBB0 3C01228E */  lw         $v0, 0x13C($s1)
    /* 803B4 8008FBB4 00000000 */  nop
    /* 803B8 8008FBB8 23184300 */  subu       $v1, $v0, $v1
  .L8008FBBC:
    /* 803BC 8008FBBC 2A10A400 */  slt        $v0, $a1, $a0
    /* 803C0 8008FBC0 0C004010 */  beqz       $v0, .L8008FBF4
    /* 803C4 8008FBC4 2A10A300 */   slt       $v0, $a1, $v1
    /* 803C8 8008FBC8 0B004010 */  beqz       $v0, .L8008FBF8
    /* 803CC 8008FBCC 2A108300 */   slt       $v0, $a0, $v1
    /* 803D0 8008FBD0 4C18828F */  lw         $v0, %gp_rel(D_8013DD98)($gp)
    /* 803D4 8008FBD4 F0002C8E */  lw         $t4, 0xF0($s1)
    /* 803D8 8008FBD8 F4002D8E */  lw         $t5, 0xF4($s1)
    /* 803DC 8008FBDC F8002E8E */  lw         $t6, 0xF8($s1)
    /* 803E0 8008FBE0 00000CAE */  sw         $t4, 0x0($s0)
    /* 803E4 8008FBE4 04000DAE */  sw         $t5, 0x4($s0)
    /* 803E8 8008FBE8 08000EAE */  sw         $t6, 0x8($s0)
    /* 803EC 8008FBEC 103F0208 */  j          .L8008FC40
    /* 803F0 8008FBF0 00000000 */   nop
  .L8008FBF4:
    /* 803F4 8008FBF4 2A108300 */  slt        $v0, $a0, $v1
  .L8008FBF8:
    /* 803F8 8008FBF8 0A004010 */  beqz       $v0, .L8008FC24
    /* 803FC 8008FBFC 00000000 */   nop
    /* 80400 8008FC00 5018828F */  lw         $v0, %gp_rel(D_8013DD9C)($gp)
    /* 80404 8008FC04 FC002C8E */  lw         $t4, 0xFC($s1)
    /* 80408 8008FC08 00012D8E */  lw         $t5, 0x100($s1)
    /* 8040C 8008FC0C 04012E8E */  lw         $t6, 0x104($s1)
    /* 80410 8008FC10 00000CAE */  sw         $t4, 0x0($s0)
    /* 80414 8008FC14 04000DAE */  sw         $t5, 0x4($s0)
    /* 80418 8008FC18 08000EAE */  sw         $t6, 0x8($s0)
    /* 8041C 8008FC1C 103F0208 */  j          .L8008FC40
    /* 80420 8008FC20 00000000 */   nop
  .L8008FC24:
    /* 80424 8008FC24 5418828F */  lw         $v0, %gp_rel(D_8013DDA0)($gp)
    /* 80428 8008FC28 08012C8E */  lw         $t4, 0x108($s1)
    /* 8042C 8008FC2C 0C012D8E */  lw         $t5, 0x10C($s1)
    /* 80430 8008FC30 10012E8E */  lw         $t6, 0x110($s1)
    /* 80434 8008FC34 00000CAE */  sw         $t4, 0x0($s0)
    /* 80438 8008FC38 04000DAE */  sw         $t5, 0x4($s0)
    /* 8043C 8008FC3C 08000EAE */  sw         $t6, 0x8($s0)
  .L8008FC40:
    /* 80440 8008FC40 3A014018 */  blez       $v0, .L8009012C
    /* 80444 8008FC44 01000224 */   addiu     $v0, $zero, 0x1
    /* 80448 8008FC48 41400208 */  j          .L80090104
    /* 8044C 8008FC4C 00000000 */   nop
  .L8008FC50:
    /* 80450 8008FC50 AC00448E */  lw         $a0, 0xAC($s2)
    /* 80454 8008FC54 AC00238E */  lw         $v1, 0xAC($s1)
    /* 80458 8008FC58 EC0280AF */  sw         $zero, %gp_rel(findClosestSideDave)($gp)
    /* 8045C 8008FC5C 23108300 */  subu       $v0, $a0, $v1
    /* 80460 8008FC60 0200401C */  bgtz       $v0, .L8008FC6C
    /* 80464 8008FC64 00000000 */   nop
    /* 80468 8008FC68 23106400 */  subu       $v0, $v1, $a0
  .L8008FC6C:
    /* 8046C 8008FC6C B000448E */  lw         $a0, 0xB0($s2)
    /* 80470 8008FC70 B000238E */  lw         $v1, 0xB0($s1)
    /* 80474 8008FC74 00000000 */  nop
    /* 80478 8008FC78 23288300 */  subu       $a1, $a0, $v1
    /* 8047C 8008FC7C 0200A01C */  bgtz       $a1, .L8008FC88
    /* 80480 8008FC80 00000000 */   nop
    /* 80484 8008FC84 23286400 */  subu       $a1, $v1, $a0
  .L8008FC88:
    /* 80488 8008FC88 B400468E */  lw         $a2, 0xB4($s2)
    /* 8048C 8008FC8C B400238E */  lw         $v1, 0xB4($s1)
    /* 80490 8008FC90 00000000 */  nop
    /* 80494 8008FC94 2320C300 */  subu       $a0, $a2, $v1
    /* 80498 8008FC98 0200801C */  bgtz       $a0, .L8008FCA4
    /* 8049C 8008FC9C 00000000 */   nop
    /* 804A0 8008FCA0 23206600 */  subu       $a0, $v1, $a2
  .L8008FCA4:
    /* 804A4 8008FCA4 21184000 */  addu       $v1, $v0, $zero
    /* 804A8 8008FCA8 2A106500 */  slt        $v0, $v1, $a1
    /* 804AC 8008FCAC 03004010 */  beqz       $v0, .L8008FCBC
    /* 804B0 8008FCB0 2A106400 */   slt       $v0, $v1, $a0
    /* 804B4 8008FCB4 2118A000 */  addu       $v1, $a1, $zero
    /* 804B8 8008FCB8 2A106400 */  slt        $v0, $v1, $a0
  .L8008FCBC:
    /* 804BC 8008FCBC 02004010 */  beqz       $v0, .L8008FCC8
    /* 804C0 8008FCC0 0F00023C */   lui       $v0, (0xF0000 >> 16)
    /* 804C4 8008FCC4 21188000 */  addu       $v1, $a0, $zero
  .L8008FCC8:
    /* 804C8 8008FCC8 2A104300 */  slt        $v0, $v0, $v1
    /* 804CC 8008FCCC 02004010 */  beqz       $v0, .L8008FCD8
    /* 804D0 8008FCD0 01000224 */   addiu     $v0, $zero, 0x1
    /* 804D4 8008FCD4 EC0282AF */  sw         $v0, %gp_rel(findClosestSideDave)($gp)
  .L8008FCD8:
    /* 804D8 8008FCD8 EC02828F */  lw         $v0, %gp_rel(findClosestSideDave)($gp)
    /* 804DC 8008FCDC 00000000 */  nop
    /* 804E0 8008FCE0 C7004010 */  beqz       $v0, .L80090000
    /* 804E4 8008FCE4 00000000 */   nop
    /* 804E8 8008FCE8 4C18828F */  lw         $v0, %gp_rel(D_8013DD98)($gp)
    /* 804EC 8008FCEC AC002C8E */  lw         $t4, 0xAC($s1)
    /* 804F0 8008FCF0 B0002D8E */  lw         $t5, 0xB0($s1)
    /* 804F4 8008FCF4 B4002E8E */  lw         $t6, 0xB4($s1)
    /* 804F8 8008FCF8 5000ACAF */  sw         $t4, 0x50($sp)
    /* 804FC 8008FCFC 5400ADAF */  sw         $t5, 0x54($sp)
    /* 80500 8008FD00 5800AEAF */  sw         $t6, 0x58($sp)
    /* 80504 8008FD04 F0004C8E */  lw         $t4, 0xF0($s2)
    /* 80508 8008FD08 F4004D8E */  lw         $t5, 0xF4($s2)
    /* 8050C 8008FD0C F8004E8E */  lw         $t6, 0xF8($s2)
    /* 80510 8008FD10 1000ACAF */  sw         $t4, 0x10($sp)
    /* 80514 8008FD14 1400ADAF */  sw         $t5, 0x14($sp)
    /* 80518 8008FD18 1800AEAF */  sw         $t6, 0x18($sp)
    /* 8051C 8008FD1C FC004C8E */  lw         $t4, 0xFC($s2)
    /* 80520 8008FD20 00014D8E */  lw         $t5, 0x100($s2)
    /* 80524 8008FD24 04014E8E */  lw         $t6, 0x104($s2)
    /* 80528 8008FD28 2000ACAF */  sw         $t4, 0x20($sp)
    /* 8052C 8008FD2C 2400ADAF */  sw         $t5, 0x24($sp)
    /* 80530 8008FD30 2800AEAF */  sw         $t6, 0x28($sp)
    /* 80534 8008FD34 08014C8E */  lw         $t4, 0x108($s2)
    /* 80538 8008FD38 0C014D8E */  lw         $t5, 0x10C($s2)
    /* 8053C 8008FD3C 10014E8E */  lw         $t6, 0x110($s2)
    /* 80540 8008FD40 3000ACAF */  sw         $t4, 0x30($sp)
    /* 80544 8008FD44 3400ADAF */  sw         $t5, 0x34($sp)
    /* 80548 8008FD48 3800AEAF */  sw         $t6, 0x38($sp)
    /* 8054C 8008FD4C 0A004104 */  bgez       $v0, .L8008FD78
    /* 80550 8008FD50 00000000 */   nop
    /* 80554 8008FD54 1000A28F */  lw         $v0, 0x10($sp)
    /* 80558 8008FD58 1800A38F */  lw         $v1, 0x18($sp)
    /* 8055C 8008FD5C 23100200 */  negu       $v0, $v0
    /* 80560 8008FD60 1000A2AF */  sw         $v0, 0x10($sp)
    /* 80564 8008FD64 1400A28F */  lw         $v0, 0x14($sp)
    /* 80568 8008FD68 23180300 */  negu       $v1, $v1
    /* 8056C 8008FD6C 1800A3AF */  sw         $v1, 0x18($sp)
    /* 80570 8008FD70 23100200 */  negu       $v0, $v0
    /* 80574 8008FD74 1400A2AF */  sw         $v0, 0x14($sp)
  .L8008FD78:
    /* 80578 8008FD78 5018828F */  lw         $v0, %gp_rel(D_8013DD9C)($gp)
    /* 8057C 8008FD7C 00000000 */  nop
    /* 80580 8008FD80 0A004104 */  bgez       $v0, .L8008FDAC
    /* 80584 8008FD84 00000000 */   nop
    /* 80588 8008FD88 2000A28F */  lw         $v0, 0x20($sp)
    /* 8058C 8008FD8C 2800A38F */  lw         $v1, 0x28($sp)
    /* 80590 8008FD90 23100200 */  negu       $v0, $v0
    /* 80594 8008FD94 2000A2AF */  sw         $v0, 0x20($sp)
    /* 80598 8008FD98 2400A28F */  lw         $v0, 0x24($sp)
    /* 8059C 8008FD9C 23180300 */  negu       $v1, $v1
    /* 805A0 8008FDA0 2800A3AF */  sw         $v1, 0x28($sp)
    /* 805A4 8008FDA4 23100200 */  negu       $v0, $v0
    /* 805A8 8008FDA8 2400A2AF */  sw         $v0, 0x24($sp)
  .L8008FDAC:
    /* 805AC 8008FDAC 5418828F */  lw         $v0, %gp_rel(D_8013DDA0)($gp)
    /* 805B0 8008FDB0 00000000 */  nop
    /* 805B4 8008FDB4 0A004104 */  bgez       $v0, .L8008FDE0
    /* 805B8 8008FDB8 00000000 */   nop
    /* 805BC 8008FDBC 3000A28F */  lw         $v0, 0x30($sp)
    /* 805C0 8008FDC0 3800A38F */  lw         $v1, 0x38($sp)
    /* 805C4 8008FDC4 23100200 */  negu       $v0, $v0
    /* 805C8 8008FDC8 3000A2AF */  sw         $v0, 0x30($sp)
    /* 805CC 8008FDCC 3400A28F */  lw         $v0, 0x34($sp)
    /* 805D0 8008FDD0 23180300 */  negu       $v1, $v1
    /* 805D4 8008FDD4 3800A3AF */  sw         $v1, 0x38($sp)
    /* 805D8 8008FDD8 23100200 */  negu       $v0, $v0
    /* 805DC 8008FDDC 3400A2AF */  sw         $v0, 0x34($sp)
  .L8008FDE0:
    /* 805E0 8008FDE0 1000A28F */  lw         $v0, 0x10($sp)
    /* 805E4 8008FDE4 00000000 */  nop
    /* 805E8 8008FDE8 02004104 */  bgez       $v0, .L8008FDF4
    /* 805EC 8008FDEC 00000000 */   nop
    /* 805F0 8008FDF0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FDF4:
    /* 805F4 8008FDF4 5000A68F */  lw         $a2, 0x50($sp)
    /* 805F8 8008FDF8 03220200 */  sra        $a0, $v0, 8
    /* 805FC 8008FDFC 0200C104 */  bgez       $a2, .L8008FE08
    /* 80600 8008FE00 2118C000 */   addu      $v1, $a2, $zero
    /* 80604 8008FE04 FF00C324 */  addiu      $v1, $a2, 0xFF
  .L8008FE08:
    /* 80608 8008FE08 03520300 */  sra        $t2, $v1, 8
    /* 8060C 8008FE0C 18008A00 */  mult       $a0, $t2
    /* 80610 8008FE10 1400A28F */  lw         $v0, 0x14($sp)
    /* 80614 8008FE14 12200000 */  mflo       $a0
    /* 80618 8008FE18 02004104 */  bgez       $v0, .L8008FE24
    /* 8061C 8008FE1C 00000000 */   nop
    /* 80620 8008FE20 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FE24:
    /* 80624 8008FE24 5400A58F */  lw         $a1, 0x54($sp)
    /* 80628 8008FE28 03120200 */  sra        $v0, $v0, 8
    /* 8062C 8008FE2C 0200A104 */  bgez       $a1, .L8008FE38
    /* 80630 8008FE30 2118A000 */   addu      $v1, $a1, $zero
    /* 80634 8008FE34 FF00A324 */  addiu      $v1, $a1, 0xFF
  .L8008FE38:
    /* 80638 8008FE38 034A0300 */  sra        $t1, $v1, 8
    /* 8063C 8008FE3C 18004900 */  mult       $v0, $t1
    /* 80640 8008FE40 1800A28F */  lw         $v0, 0x18($sp)
    /* 80644 8008FE44 12580000 */  mflo       $t3
    /* 80648 8008FE48 02004104 */  bgez       $v0, .L8008FE54
    /* 8064C 8008FE4C 21388B00 */   addu      $a3, $a0, $t3
    /* 80650 8008FE50 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FE54:
    /* 80654 8008FE54 5800A48F */  lw         $a0, 0x58($sp)
    /* 80658 8008FE58 03120200 */  sra        $v0, $v0, 8
    /* 8065C 8008FE5C 02008104 */  bgez       $a0, .L8008FE68
    /* 80660 8008FE60 21188000 */   addu      $v1, $a0, $zero
    /* 80664 8008FE64 FF008324 */  addiu      $v1, $a0, 0xFF
  .L8008FE68:
    /* 80668 8008FE68 03420300 */  sra        $t0, $v1, 8
    /* 8066C 8008FE6C 18004800 */  mult       $v0, $t0
    /* 80670 8008FE70 2000A28F */  lw         $v0, 0x20($sp)
    /* 80674 8008FE74 12580000 */  mflo       $t3
    /* 80678 8008FE78 02004104 */  bgez       $v0, .L8008FE84
    /* 8067C 8008FE7C 2138EB00 */   addu      $a3, $a3, $t3
    /* 80680 8008FE80 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FE84:
    /* 80684 8008FE84 031A0200 */  sra        $v1, $v0, 8
    /* 80688 8008FE88 18006A00 */  mult       $v1, $t2
    /* 8068C 8008FE8C 2400A28F */  lw         $v0, 0x24($sp)
    /* 80690 8008FE90 12300000 */  mflo       $a2
    /* 80694 8008FE94 02004104 */  bgez       $v0, .L8008FEA0
    /* 80698 8008FE98 00000000 */   nop
    /* 8069C 8008FE9C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FEA0:
    /* 806A0 8008FEA0 03120200 */  sra        $v0, $v0, 8
    /* 806A4 8008FEA4 18004900 */  mult       $v0, $t1
    /* 806A8 8008FEA8 2800A38F */  lw         $v1, 0x28($sp)
    /* 806AC 8008FEAC 12580000 */  mflo       $t3
    /* 806B0 8008FEB0 02006104 */  bgez       $v1, .L8008FEBC
    /* 806B4 8008FEB4 2110CB00 */   addu      $v0, $a2, $t3
    /* 806B8 8008FEB8 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008FEBC:
    /* 806BC 8008FEBC 031A0300 */  sra        $v1, $v1, 8
    /* 806C0 8008FEC0 18006800 */  mult       $v1, $t0
    /* 806C4 8008FEC4 3000A38F */  lw         $v1, 0x30($sp)
    /* 806C8 8008FEC8 12580000 */  mflo       $t3
    /* 806CC 8008FECC 02006104 */  bgez       $v1, .L8008FED8
    /* 806D0 8008FED0 21284B00 */   addu      $a1, $v0, $t3
    /* 806D4 8008FED4 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008FED8:
    /* 806D8 8008FED8 5000A28F */  lw         $v0, 0x50($sp)
    /* 806DC 8008FEDC 00000000 */  nop
    /* 806E0 8008FEE0 02004104 */  bgez       $v0, .L8008FEEC
    /* 806E4 8008FEE4 03220300 */   sra       $a0, $v1, 8
    /* 806E8 8008FEE8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FEEC:
    /* 806EC 8008FEEC 03120200 */  sra        $v0, $v0, 8
    /* 806F0 8008FEF0 18008200 */  mult       $a0, $v0
    /* 806F4 8008FEF4 3400A38F */  lw         $v1, 0x34($sp)
    /* 806F8 8008FEF8 12200000 */  mflo       $a0
    /* 806FC 8008FEFC 02006104 */  bgez       $v1, .L8008FF08
    /* 80700 8008FF00 00000000 */   nop
    /* 80704 8008FF04 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008FF08:
    /* 80708 8008FF08 5400A28F */  lw         $v0, 0x54($sp)
    /* 8070C 8008FF0C 00000000 */  nop
    /* 80710 8008FF10 02004104 */  bgez       $v0, .L8008FF1C
    /* 80714 8008FF14 031A0300 */   sra       $v1, $v1, 8
    /* 80718 8008FF18 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FF1C:
    /* 8071C 8008FF1C 03120200 */  sra        $v0, $v0, 8
    /* 80720 8008FF20 18006200 */  mult       $v1, $v0
    /* 80724 8008FF24 3800A38F */  lw         $v1, 0x38($sp)
    /* 80728 8008FF28 12580000 */  mflo       $t3
    /* 8072C 8008FF2C 02006104 */  bgez       $v1, .L8008FF38
    /* 80730 8008FF30 21208B00 */   addu      $a0, $a0, $t3
    /* 80734 8008FF34 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008FF38:
    /* 80738 8008FF38 5800A28F */  lw         $v0, 0x58($sp)
    /* 8073C 8008FF3C 00000000 */  nop
    /* 80740 8008FF40 02004104 */  bgez       $v0, .L8008FF4C
    /* 80744 8008FF44 031A0300 */   sra       $v1, $v1, 8
    /* 80748 8008FF48 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008FF4C:
    /* 8074C 8008FF4C 03120200 */  sra        $v0, $v0, 8
    /* 80750 8008FF50 18006200 */  mult       $v1, $v0
    /* 80754 8008FF54 0200E104 */  bgez       $a3, .L8008FF60
    /* 80758 8008FF58 00000000 */   nop
    /* 8075C 8008FF5C 23380700 */  negu       $a3, $a3
  .L8008FF60:
    /* 80760 8008FF60 0200A104 */  bgez       $a1, .L8008FF6C
    /* 80764 8008FF64 00000000 */   nop
    /* 80768 8008FF68 23280500 */  negu       $a1, $a1
  .L8008FF6C:
    /* 8076C 8008FF6C 2A10A700 */  slt        $v0, $a1, $a3
    /* 80770 8008FF70 12580000 */  mflo       $t3
    /* 80774 8008FF74 21188B00 */  addu       $v1, $a0, $t3
    /* 80778 8008FF78 02006104 */  bgez       $v1, .L8008FF84
    /* 8077C 8008FF7C 00000000 */   nop
    /* 80780 8008FF80 23180300 */  negu       $v1, $v1
  .L8008FF84:
    /* 80784 8008FF84 0B004010 */  beqz       $v0, .L8008FFB4
    /* 80788 8008FF88 2A106700 */   slt       $v0, $v1, $a3
    /* 8078C 8008FF8C 0A004010 */  beqz       $v0, .L8008FFB8
    /* 80790 8008FF90 2A106500 */   slt       $v0, $v1, $a1
  .L8008FF94:
    /* 80794 8008FF94 1000AC8F */  lw         $t4, 0x10($sp)
    /* 80798 8008FF98 1400AD8F */  lw         $t5, 0x14($sp)
    /* 8079C 8008FF9C 1800AE8F */  lw         $t6, 0x18($sp)
    /* 807A0 8008FFA0 00000CAE */  sw         $t4, 0x0($s0)
    /* 807A4 8008FFA4 04000DAE */  sw         $t5, 0x4($s0)
    /* 807A8 8008FFA8 08000EAE */  sw         $t6, 0x8($s0)
    /* 807AC 8008FFAC 4B400208 */  j          .L8009012C
    /* 807B0 8008FFB0 01000224 */   addiu     $v0, $zero, 0x1
  .L8008FFB4:
    /* 807B4 8008FFB4 2A106500 */  slt        $v0, $v1, $a1
  .L8008FFB8:
    /* 807B8 8008FFB8 09004010 */  beqz       $v0, .L8008FFE0
    /* 807BC 8008FFBC 00000000 */   nop
  .L8008FFC0:
    /* 807C0 8008FFC0 2000AC8F */  lw         $t4, 0x20($sp)
    /* 807C4 8008FFC4 2400AD8F */  lw         $t5, 0x24($sp)
    /* 807C8 8008FFC8 2800AE8F */  lw         $t6, 0x28($sp)
    /* 807CC 8008FFCC 00000CAE */  sw         $t4, 0x0($s0)
    /* 807D0 8008FFD0 04000DAE */  sw         $t5, 0x4($s0)
    /* 807D4 8008FFD4 08000EAE */  sw         $t6, 0x8($s0)
    /* 807D8 8008FFD8 4B400208 */  j          .L8009012C
    /* 807DC 8008FFDC 01000224 */   addiu     $v0, $zero, 0x1
  .L8008FFE0:
    /* 807E0 8008FFE0 3000AC8F */  lw         $t4, 0x30($sp)
    /* 807E4 8008FFE4 3400AD8F */  lw         $t5, 0x34($sp)
    /* 807E8 8008FFE8 3800AE8F */  lw         $t6, 0x38($sp)
    /* 807EC 8008FFEC 00000CAE */  sw         $t4, 0x0($s0)
    /* 807F0 8008FFF0 04000DAE */  sw         $t5, 0x4($s0)
    /* 807F4 8008FFF4 08000EAE */  sw         $t6, 0x8($s0)
    /* 807F8 8008FFF8 4B400208 */  j          .L8009012C
    /* 807FC 8008FFFC 01000224 */   addiu     $v0, $zero, 0x1
  .L80090000:
    /* 80800 80090000 4C18838F */  lw         $v1, %gp_rel(D_8013DD98)($gp)
    /* 80804 80090004 00000000 */  nop
    /* 80808 80090008 04006104 */  bgez       $v1, .L8009001C
    /* 8080C 8009000C 00000000 */   nop
    /* 80810 80090010 3401428E */  lw         $v0, 0x134($s2)
    /* 80814 80090014 0A400208 */  j          .L80090028
    /* 80818 80090018 21284300 */   addu      $a1, $v0, $v1
  .L8009001C:
    /* 8081C 8009001C 3401428E */  lw         $v0, 0x134($s2)
    /* 80820 80090020 00000000 */  nop
    /* 80824 80090024 23284300 */  subu       $a1, $v0, $v1
  .L80090028:
    /* 80828 80090028 5018838F */  lw         $v1, %gp_rel(D_8013DD9C)($gp)
    /* 8082C 8009002C 00000000 */  nop
    /* 80830 80090030 04006104 */  bgez       $v1, .L80090044
    /* 80834 80090034 00000000 */   nop
    /* 80838 80090038 3801428E */  lw         $v0, 0x138($s2)
    /* 8083C 8009003C 14400208 */  j          .L80090050
    /* 80840 80090040 21204300 */   addu      $a0, $v0, $v1
  .L80090044:
    /* 80844 80090044 3801428E */  lw         $v0, 0x138($s2)
    /* 80848 80090048 00000000 */  nop
    /* 8084C 8009004C 23204300 */  subu       $a0, $v0, $v1
  .L80090050:
    /* 80850 80090050 5418838F */  lw         $v1, %gp_rel(D_8013DDA0)($gp)
    /* 80854 80090054 00000000 */  nop
    /* 80858 80090058 04006104 */  bgez       $v1, .L8009006C
    /* 8085C 8009005C 00000000 */   nop
    /* 80860 80090060 3C01428E */  lw         $v0, 0x13C($s2)
    /* 80864 80090064 1E400208 */  j          .L80090078
    /* 80868 80090068 21184300 */   addu      $v1, $v0, $v1
  .L8009006C:
    /* 8086C 8009006C 3C01428E */  lw         $v0, 0x13C($s2)
    /* 80870 80090070 00000000 */  nop
    /* 80874 80090074 23184300 */  subu       $v1, $v0, $v1
  .L80090078:
    /* 80878 80090078 2A10A400 */  slt        $v0, $a1, $a0
    /* 8087C 8009007C 0C004010 */  beqz       $v0, .L800900B0
    /* 80880 80090080 2A10A300 */   slt       $v0, $a1, $v1
    /* 80884 80090084 0B004010 */  beqz       $v0, .L800900B4
    /* 80888 80090088 2A108300 */   slt       $v0, $a0, $v1
    /* 8088C 8009008C 4C18828F */  lw         $v0, %gp_rel(D_8013DD98)($gp)
    /* 80890 80090090 F0004C8E */  lw         $t4, 0xF0($s2)
    /* 80894 80090094 F4004D8E */  lw         $t5, 0xF4($s2)
    /* 80898 80090098 F8004E8E */  lw         $t6, 0xF8($s2)
    /* 8089C 8009009C 00000CAE */  sw         $t4, 0x0($s0)
    /* 808A0 800900A0 04000DAE */  sw         $t5, 0x4($s0)
    /* 808A4 800900A4 08000EAE */  sw         $t6, 0x8($s0)
    /* 808A8 800900A8 3F400208 */  j          .L800900FC
    /* 808AC 800900AC 00000000 */   nop
  .L800900B0:
    /* 808B0 800900B0 2A108300 */  slt        $v0, $a0, $v1
  .L800900B4:
    /* 808B4 800900B4 0A004010 */  beqz       $v0, .L800900E0
    /* 808B8 800900B8 00000000 */   nop
    /* 808BC 800900BC 5018828F */  lw         $v0, %gp_rel(D_8013DD9C)($gp)
    /* 808C0 800900C0 FC004C8E */  lw         $t4, 0xFC($s2)
    /* 808C4 800900C4 00014D8E */  lw         $t5, 0x100($s2)
    /* 808C8 800900C8 04014E8E */  lw         $t6, 0x104($s2)
    /* 808CC 800900CC 00000CAE */  sw         $t4, 0x0($s0)
    /* 808D0 800900D0 04000DAE */  sw         $t5, 0x4($s0)
    /* 808D4 800900D4 08000EAE */  sw         $t6, 0x8($s0)
    /* 808D8 800900D8 3F400208 */  j          .L800900FC
    /* 808DC 800900DC 00000000 */   nop
  .L800900E0:
    /* 808E0 800900E0 5418828F */  lw         $v0, %gp_rel(D_8013DDA0)($gp)
    /* 808E4 800900E4 08014C8E */  lw         $t4, 0x108($s2)
    /* 808E8 800900E8 0C014D8E */  lw         $t5, 0x10C($s2)
    /* 808EC 800900EC 10014E8E */  lw         $t6, 0x110($s2)
    /* 808F0 800900F0 00000CAE */  sw         $t4, 0x0($s0)
    /* 808F4 800900F4 04000DAE */  sw         $t5, 0x4($s0)
    /* 808F8 800900F8 08000EAE */  sw         $t6, 0x8($s0)
  .L800900FC:
    /* 808FC 800900FC 0B004104 */  bgez       $v0, .L8009012C
    /* 80900 80090100 01000224 */   addiu     $v0, $zero, 0x1
  .L80090104:
    /* 80904 80090104 0000028E */  lw         $v0, 0x0($s0)
    /* 80908 80090108 0800038E */  lw         $v1, 0x8($s0)
    /* 8090C 8009010C 23100200 */  negu       $v0, $v0
    /* 80910 80090110 000002AE */  sw         $v0, 0x0($s0)
    /* 80914 80090114 0400028E */  lw         $v0, 0x4($s0)
    /* 80918 80090118 23180300 */  negu       $v1, $v1
    /* 8091C 8009011C 080003AE */  sw         $v1, 0x8($s0)
    /* 80920 80090120 23100200 */  negu       $v0, $v0
    /* 80924 80090124 040002AE */  sw         $v0, 0x4($s0)
    /* 80928 80090128 01000224 */  addiu      $v0, $zero, 0x1
  .L8009012C:
    /* 8092C 8009012C 6C00BF8F */  lw         $ra, 0x6C($sp)
    /* 80930 80090130 6800B28F */  lw         $s2, 0x68($sp)
    /* 80934 80090134 6400B18F */  lw         $s1, 0x64($sp)
    /* 80938 80090138 6000B08F */  lw         $s0, 0x60($sp)
    /* 8093C 8009013C 0800E003 */  jr         $ra
    /* 80940 80090140 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2
