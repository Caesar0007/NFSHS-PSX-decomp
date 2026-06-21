.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__22tInsideBoxTwoWaySlideriiib, 0x2C0

glabel Draw__22tInsideBoxTwoWaySlideriiib
    /* FDA0 8001F5A0 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* FDA4 8001F5A4 5000B6AF */  sw         $s6, 0x50($sp)
    /* FDA8 8001F5A8 21B08000 */  addu       $s6, $a0, $zero
    /* FDAC 8001F5AC 3800B0AF */  sw         $s0, 0x38($sp)
    /* FDB0 8001F5B0 2180A000 */  addu       $s0, $a1, $zero
    /* FDB4 8001F5B4 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* FDB8 8001F5B8 2188C000 */  addu       $s1, $a2, $zero
    /* FDBC 8001F5BC 5400BFAF */  sw         $ra, 0x54($sp)
    /* FDC0 8001F5C0 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* FDC4 8001F5C4 4800B4AF */  sw         $s4, 0x48($sp)
    /* FDC8 8001F5C8 4400B3AF */  sw         $s3, 0x44($sp)
    /* FDCC 8001F5CC 4000B2AF */  sw         $s2, 0x40($sp)
    /* FDD0 8001F5D0 2C00C28E */  lw         $v0, 0x2C($s6)
    /* FDD4 8001F5D4 00000000 */  nop
    /* FDD8 8001F5D8 03004010 */  beqz       $v0, .L8001F5E8
    /* FDDC 8001F5DC 2190E000 */   addu      $s2, $a3, $zero
    /* FDE0 8001F5E0 467E000C */  jal        Calibrate__22tInsideBoxTwoWaySlider
    /* FDE4 8001F5E4 00000000 */   nop
  .L8001F5E8:
    /* FDE8 8001F5E8 5500043C */  lui        $a0, (0x551E00 >> 16)
    /* FDEC 8001F5EC 001E8434 */  ori        $a0, $a0, (0x551E00 & 0xFFFF)
    /* FDF0 8001F5F0 C800053C */  lui        $a1, (0xC83C1E >> 16)
    /* FDF4 8001F5F4 1E3CA534 */  ori        $a1, $a1, (0xC83C1E & 0xFFFF)
    /* FDF8 8001F5F8 0800C686 */  lh         $a2, 0x8($s6)
    /* FDFC 8001F5FC 43901200 */  sra        $s2, $s2, 1
    /* FE00 8001F600 2000D0A6 */  sh         $s0, 0x20($s6)
    /* FE04 8001F604 FE2D010C */  jal        CalcFadeVal__Fiii
    /* FE08 8001F608 2200D1A6 */   sh        $s1, 0x22($s6)
    /* FE0C 8001F60C 5500043C */  lui        $a0, (0x551E00 >> 16)
    /* FE10 8001F610 001E8434 */  ori        $a0, $a0, (0x551E00 & 0xFFFF)
    /* FE14 8001F614 BEBE0534 */  ori        $a1, $zero, 0xBEBE
    /* FE18 8001F618 0800C686 */  lh         $a2, 0x8($s6)
    /* FE1C 8001F61C FE2D010C */  jal        CalcFadeVal__Fiii
    /* FE20 8001F620 21804000 */   addu      $s0, $v0, $zero
    /* FE24 8001F624 06000424 */  addiu      $a0, $zero, 0x6
    /* FE28 8001F628 21300000 */  addu       $a2, $zero, $zero
    /* FE2C 8001F62C 0800C586 */  lh         $a1, 0x8($s6)
    /* FE30 8001F630 382E010C */  jal        CalcTextFadeUnselToSel__F13tMenuTextTypess
    /* FE34 8001F634 21A04000 */   addu      $s4, $v0, $zero
    /* FE38 8001F638 21200002 */  addu       $a0, $s0, $zero
    /* FE3C 8001F63C FCFF5126 */  addiu      $s1, $s2, -0x4
    /* FE40 8001F640 21382002 */  addu       $a3, $s1, $zero
    /* FE44 8001F644 01001324 */  addiu      $s3, $zero, 0x1
    /* FE48 8001F648 2000C586 */  lh         $a1, 0x20($s6)
    /* FE4C 8001F64C 2200C686 */  lh         $a2, 0x22($s6)
    /* FE50 8001F650 21A84000 */  addu       $s5, $v0, $zero
    /* FE54 8001F654 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* FE58 8001F658 1000B3AF */   sw        $s3, 0x10($sp)
    /* FE5C 8001F65C 21200002 */  addu       $a0, $s0, $zero
    /* FE60 8001F660 2000C586 */  lh         $a1, 0x20($s6)
    /* FE64 8001F664 2200C686 */  lh         $a2, 0x22($s6)
    /* FE68 8001F668 21382002 */  addu       $a3, $s1, $zero
    /* FE6C 8001F66C 1000B3AF */  sw         $s3, 0x10($sp)
    /* FE70 8001F670 2128B100 */  addu       $a1, $a1, $s1
    /* FE74 8001F674 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* FE78 8001F678 0800A524 */   addiu     $a1, $a1, 0x8
    /* FE7C 8001F67C 21200002 */  addu       $a0, $s0, $zero
    /* FE80 8001F680 2000C586 */  lh         $a1, 0x20($s6)
    /* FE84 8001F684 2200C686 */  lh         $a2, 0x22($s6)
    /* FE88 8001F688 21382002 */  addu       $a3, $s1, $zero
    /* FE8C 8001F68C 1000B3AF */  sw         $s3, 0x10($sp)
    /* FE90 8001F690 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* FE94 8001F694 0800C624 */   addiu     $a2, $a2, 0x8
    /* FE98 8001F698 21200002 */  addu       $a0, $s0, $zero
    /* FE9C 8001F69C 2000C586 */  lh         $a1, 0x20($s6)
    /* FEA0 8001F6A0 2200C686 */  lh         $a2, 0x22($s6)
    /* FEA4 8001F6A4 21382002 */  addu       $a3, $s1, $zero
    /* FEA8 8001F6A8 1000B3AF */  sw         $s3, 0x10($sp)
    /* FEAC 8001F6AC 2128B100 */  addu       $a1, $a1, $s1
    /* FEB0 8001F6B0 0900A524 */  addiu      $a1, $a1, 0x9
    /* FEB4 8001F6B4 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* FEB8 8001F6B8 0800C624 */   addiu     $a2, $a2, 0x8
    /* FEBC 8001F6BC 21208002 */  addu       $a0, $s4, $zero
    /* FEC0 8001F6C0 02000724 */  addiu      $a3, $zero, 0x2
    /* FEC4 8001F6C4 2000C586 */  lh         $a1, 0x20($s6)
    /* FEC8 8001F6C8 2200C686 */  lh         $a2, 0x22($s6)
    /* FECC 8001F6CC 09000224 */  addiu      $v0, $zero, 0x9
    /* FED0 8001F6D0 1000A2AF */  sw         $v0, 0x10($sp)
    /* FED4 8001F6D4 2128B100 */  addu       $a1, $a1, $s1
    /* FED8 8001F6D8 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* FEDC 8001F6DC 0300A524 */   addiu     $a1, $a1, 0x3
    /* FEE0 8001F6E0 0400C48E */  lw         $a0, 0x4($s6)
    /* FEE4 8001F6E4 94E4020C */  jal        TextSys_Word__Fi
    /* FEE8 8001F6E8 F8FF5226 */   addiu     $s2, $s2, -0x8
    /* FEEC 8001F6EC 21204000 */  addu       $a0, $v0, $zero
    /* FEF0 8001F6F0 2000C596 */  lhu        $a1, 0x20($s6)
    /* FEF4 8001F6F4 2200C696 */  lhu        $a2, 0x22($s6)
    /* FEF8 8001F6F8 2138A002 */  addu       $a3, $s5, $zero
    /* FEFC 8001F6FC 1000A0AF */  sw         $zero, 0x10($sp)
    /* FF00 8001F700 1400A0AF */  sw         $zero, 0x14($sp)
    /* FF04 8001F704 0400A524 */  addiu      $a1, $a1, 0x4
    /* FF08 8001F708 002C0500 */  sll        $a1, $a1, 16
    /* FF0C 8001F70C 032C0500 */  sra        $a1, $a1, 16
    /* FF10 8001F710 0A00C624 */  addiu      $a2, $a2, 0xA
    /* FF14 8001F714 00340600 */  sll        $a2, $a2, 16
    /* FF18 8001F718 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* FF1C 8001F71C 03340600 */   sra       $a2, $a2, 16
    /* FF20 8001F720 1C00C38E */  lw         $v1, 0x1C($s6)
    /* FF24 8001F724 00000000 */  nop
    /* FF28 8001F728 0C00628C */  lw         $v0, 0xC($v1)
    /* FF2C 8001F72C FFFF0524 */  addiu      $a1, $zero, -0x1
    /* FF30 8001F730 10004484 */  lh         $a0, 0x10($v0)
    /* FF34 8001F734 1400428C */  lw         $v0, 0x14($v0)
    /* FF38 8001F738 00000000 */  nop
    /* FF3C 8001F73C 09F84000 */  jalr       $v0
    /* FF40 8001F740 21206400 */   addu      $a0, $v1, $a0
    /* FF44 8001F744 FF004430 */  andi       $a0, $v0, 0xFF
    /* FF48 8001F748 00941200 */  sll        $s2, $s2, 16
    /* FF4C 8001F74C 03941200 */  sra        $s2, $s2, 16
    /* FF50 8001F750 04001024 */  addiu      $s0, $zero, 0x4
    /* FF54 8001F754 2000C796 */  lhu        $a3, 0x20($s6)
    /* FF58 8001F758 2200C296 */  lhu        $v0, 0x22($s6)
    /* FF5C 8001F75C 1C00C38E */  lw         $v1, 0x1C($s6)
    /* FF60 8001F760 2138F300 */  addu       $a3, $a3, $s3
    /* FF64 8001F764 02004224 */  addiu      $v0, $v0, 0x2
    /* FF68 8001F768 00140200 */  sll        $v0, $v0, 16
    /* FF6C 8001F76C 08006590 */  lbu        $a1, 0x8($v1)
    /* FF70 8001F770 09006690 */  lbu        $a2, 0x9($v1)
    /* FF74 8001F774 03140200 */  sra        $v0, $v0, 16
    /* FF78 8001F778 1000A2AF */  sw         $v0, 0x10($sp)
    /* FF7C 8001F77C 1400B2AF */  sw         $s2, 0x14($sp)
    /* FF80 8001F780 2600C286 */  lh         $v0, 0x26($s6)
    /* FF84 8001F784 003C0700 */  sll        $a3, $a3, 16
    /* FF88 8001F788 1C00B0AF */  sw         $s0, 0x1C($sp)
    /* FF8C 8001F78C 2000B0AF */  sw         $s0, 0x20($sp)
    /* FF90 8001F790 2400B3AF */  sw         $s3, 0x24($sp)
    /* FF94 8001F794 2800A0AF */  sw         $zero, 0x28($sp)
    /* FF98 8001F798 1800A2AF */  sw         $v0, 0x18($sp)
    /* FF9C 8001F79C 0800C286 */  lh         $v0, 0x8($s6)
    /* FFA0 8001F7A0 033C0700 */  sra        $a3, $a3, 16
    /* FFA4 8001F7A4 3000A0AF */  sw         $zero, 0x30($sp)
    /* FFA8 8001F7A8 0B93000C */  jal        DrawSlider__FsssssssssbT9ss
    /* FFAC 8001F7AC 2C00A2AF */   sw        $v0, 0x2C($sp)
    /* FFB0 8001F7B0 1C00C38E */  lw         $v1, 0x1C($s6)
    /* FFB4 8001F7B4 00000000 */  nop
    /* FFB8 8001F7B8 0C00628C */  lw         $v0, 0xC($v1)
    /* FFBC 8001F7BC FFFF0524 */  addiu      $a1, $zero, -0x1
    /* FFC0 8001F7C0 10004484 */  lh         $a0, 0x10($v0)
    /* FFC4 8001F7C4 1400428C */  lw         $v0, 0x14($v0)
    /* FFC8 8001F7C8 00000000 */  nop
    /* FFCC 8001F7CC 09F84000 */  jalr       $v0
    /* FFD0 8001F7D0 21206400 */   addu      $a0, $v1, $a0
    /* FFD4 8001F7D4 FF004430 */  andi       $a0, $v0, 0xFF
    /* FFD8 8001F7D8 2200C396 */  lhu        $v1, 0x22($s6)
    /* FFDC 8001F7DC 1C00C28E */  lw         $v0, 0x1C($s6)
    /* FFE0 8001F7E0 2000C796 */  lhu        $a3, 0x20($s6)
    /* FFE4 8001F7E4 02006324 */  addiu      $v1, $v1, 0x2
    /* FFE8 8001F7E8 001C0300 */  sll        $v1, $v1, 16
    /* FFEC 8001F7EC 031C0300 */  sra        $v1, $v1, 16
    /* FFF0 8001F7F0 2138F100 */  addu       $a3, $a3, $s1
    /* FFF4 8001F7F4 08004590 */  lbu        $a1, 0x8($v0)
    /* FFF8 8001F7F8 09004690 */  lbu        $a2, 0x9($v0)
    /* FFFC 8001F7FC 0A00E724 */  addiu      $a3, $a3, 0xA
    /* 10000 8001F800 1000A3AF */  sw         $v1, 0x10($sp)
    /* 10004 8001F804 1400B2AF */  sw         $s2, 0x14($sp)
    /* 10008 8001F808 2600C286 */  lh         $v0, 0x26($s6)
    /* 1000C 8001F80C 003C0700 */  sll        $a3, $a3, 16
    /* 10010 8001F810 1C00B0AF */  sw         $s0, 0x1C($sp)
    /* 10014 8001F814 2000B0AF */  sw         $s0, 0x20($sp)
    /* 10018 8001F818 2400A0AF */  sw         $zero, 0x24($sp)
    /* 1001C 8001F81C 2800A0AF */  sw         $zero, 0x28($sp)
    /* 10020 8001F820 1800A2AF */  sw         $v0, 0x18($sp)
    /* 10024 8001F824 0800C286 */  lh         $v0, 0x8($s6)
    /* 10028 8001F828 033C0700 */  sra        $a3, $a3, 16
    /* 1002C 8001F82C 3000A0AF */  sw         $zero, 0x30($sp)
    /* 10030 8001F830 0B93000C */  jal        DrawSlider__FsssssssssbT9ss
    /* 10034 8001F834 2C00A2AF */   sw        $v0, 0x2C($sp)
    /* 10038 8001F838 5400BF8F */  lw         $ra, 0x54($sp)
    /* 1003C 8001F83C 5000B68F */  lw         $s6, 0x50($sp)
    /* 10040 8001F840 4C00B58F */  lw         $s5, 0x4C($sp)
    /* 10044 8001F844 4800B48F */  lw         $s4, 0x48($sp)
    /* 10048 8001F848 4400B38F */  lw         $s3, 0x44($sp)
    /* 1004C 8001F84C 4000B28F */  lw         $s2, 0x40($sp)
    /* 10050 8001F850 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 10054 8001F854 3800B08F */  lw         $s0, 0x38($sp)
    /* 10058 8001F858 0800E003 */  jr         $ra
    /* 1005C 8001F85C 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel Draw__22tInsideBoxTwoWaySlideriiib
