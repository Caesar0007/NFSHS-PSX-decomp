.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_Init2DRing__Fv, 0x2E4

glabel Hrz_Init2DRing__Fv
    /* C0580 800CFD80 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* C0584 800CFD84 5400B1AF */  sw         $s1, 0x54($sp)
    /* C0588 800CFD88 21880000 */  addu       $s1, $zero, $zero
    /* C058C 800CFD8C 5800BFAF */  sw         $ra, 0x58($sp)
    /* C0590 800CFD90 5000B0AF */  sw         $s0, 0x50($sp)
  .L800CFD94:
    /* C0594 800CFD94 3C13828F */  lw         $v0, %gp_rel(Hrz_gTrackSpec)($gp)
    /* C0598 800CFD98 00000000 */  nop
    /* C059C 800CFD9C 0400428C */  lw         $v0, 0x4($v0)
    /* C05A0 800CFDA0 00831100 */  sll        $s0, $s1, 12
    /* C05A4 800CFDA4 21800202 */  addu       $s0, $s0, $v0
    /* C05A8 800CFDA8 09B5030C */  jal        fixedsin
    /* C05AC 800CFDAC 21200002 */   addu      $a0, $s0, $zero
    /* C05B0 800CFDB0 21204000 */  addu       $a0, $v0, $zero
    /* C05B4 800CFDB4 CA90030C */  jal        fixedmult
    /* C05B8 800CFDB8 007D0524 */   addiu     $a1, $zero, 0x7D00
    /* C05BC 800CFDBC 21200002 */  addu       $a0, $s0, $zero
    /* C05C0 800CFDC0 4413838F */  lw         $v1, %gp_rel(gRngCoordTop)($gp)
    /* C05C4 800CFDC4 C0801100 */  sll        $s0, $s1, 3
    /* C05C8 800CFDC8 21180302 */  addu       $v1, $s0, $v1
    /* C05CC 800CFDCC 000062A4 */  sh         $v0, 0x0($v1)
    /* C05D0 800CFDD0 29B5030C */  jal        fixedcos
    /* C05D4 800CFDD4 020060A4 */   sh        $zero, 0x2($v1)
    /* C05D8 800CFDD8 21204000 */  addu       $a0, $v0, $zero
    /* C05DC 800CFDDC CA90030C */  jal        fixedmult
    /* C05E0 800CFDE0 007D0524 */   addiu     $a1, $zero, 0x7D00
    /* C05E4 800CFDE4 4413838F */  lw         $v1, %gp_rel(gRngCoordTop)($gp)
    /* C05E8 800CFDE8 01003126 */  addiu      $s1, $s1, 0x1
    /* C05EC 800CFDEC 21800302 */  addu       $s0, $s0, $v1
    /* C05F0 800CFDF0 040002A6 */  sh         $v0, 0x4($s0)
    /* C05F4 800CFDF4 1100222A */  slti       $v0, $s1, 0x11
    /* C05F8 800CFDF8 E6FF4014 */  bnez       $v0, .L800CFD94
    /* C05FC 800CFDFC 01000624 */   addiu     $a2, $zero, 0x1
    /* C0600 800CFE00 21880000 */  addu       $s1, $zero, $zero
    /* C0604 800CFE04 1280023C */  lui        $v0, %hi(gHorizonPixmap)
    /* C0608 800CFE08 F8024824 */  addiu      $t0, $v0, %lo(gHorizonPixmap)
    /* C060C 800CFE0C 3C13878F */  lw         $a3, %gp_rel(Hrz_gTrackSpec)($gp)
    /* C0610 800CFE10 1000A527 */  addiu      $a1, $sp, 0x10
    /* C0614 800CFE14 1280023C */  lui        $v0, %hi(gpPmx)
    /* C0618 800CFE18 B4074424 */  addiu      $a0, $v0, %lo(gpPmx)
  .L800CFE1C:
    /* C061C 800CFE1C 1000222A */  slti       $v0, $s1, 0x10
    /* C0620 800CFE20 15004010 */  beqz       $v0, .L800CFE78
    /* C0624 800CFE24 2110F100 */   addu      $v0, $a3, $s1
    /* C0628 800CFE28 20004290 */  lbu        $v0, 0x20($v0)
    /* C062C 800CFE2C 00000000 */  nop
    /* C0630 800CFE30 07004230 */  andi       $v0, $v0, 0x7
    /* C0634 800CFE34 80100200 */  sll        $v0, $v0, 2
    /* C0638 800CFE38 21104800 */  addu       $v0, $v0, $t0
    /* C063C 800CFE3C 0000428C */  lw         $v0, 0x0($v0)
    /* C0640 800CFE40 00000000 */  nop
    /* C0644 800CFE44 000082AC */  sw         $v0, 0x0($a0)
    /* C0648 800CFE48 09004390 */  lbu        $v1, 0x9($v0)
    /* C064C 800CFE4C 05004290 */  lbu        $v0, 0x5($v0)
    /* C0650 800CFE50 00000000 */  nop
    /* C0654 800CFE54 23186200 */  subu       $v1, $v1, $v0
    /* C0658 800CFE58 2A10C300 */  slt        $v0, $a2, $v1
    /* C065C 800CFE5C 02004010 */  beqz       $v0, .L800CFE68
    /* C0660 800CFE60 0000A3AC */   sw        $v1, 0x0($a1)
    /* C0664 800CFE64 21306000 */  addu       $a2, $v1, $zero
  .L800CFE68:
    /* C0668 800CFE68 0400A524 */  addiu      $a1, $a1, 0x4
    /* C066C 800CFE6C 04008424 */  addiu      $a0, $a0, 0x4
    /* C0670 800CFE70 873F0308 */  j          .L800CFE1C
    /* C0674 800CFE74 01003126 */   addiu     $s1, $s1, 0x1
  .L800CFE78:
    /* C0678 800CFE78 21880000 */  addu       $s1, $zero, $zero
    /* C067C 800CFE7C 1280023C */  lui        $v0, %hi(gfxPmxHeightPercentage)
    /* C0680 800CFE80 7C084524 */  addiu      $a1, $v0, %lo(gfxPmxHeightPercentage)
    /* C0684 800CFE84 1000A427 */  addiu      $a0, $sp, 0x10
  .L800CFE88:
    /* C0688 800CFE88 0000828C */  lw         $v0, 0x0($a0)
    /* C068C 800CFE8C 00000000 */  nop
    /* C0690 800CFE90 00140200 */  sll        $v0, $v0, 16
    /* C0694 800CFE94 1A004600 */  div        $zero, $v0, $a2
    /* C0698 800CFE98 0200C014 */  bnez       $a2, .L800CFEA4
    /* C069C 800CFE9C 00000000 */   nop
    /* C06A0 800CFEA0 0D000700 */  break      7
  .L800CFEA4:
    /* C06A4 800CFEA4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* C06A8 800CFEA8 0400C114 */  bne        $a2, $at, .L800CFEBC
    /* C06AC 800CFEAC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* C06B0 800CFEB0 02004114 */  bne        $v0, $at, .L800CFEBC
    /* C06B4 800CFEB4 00000000 */   nop
    /* C06B8 800CFEB8 0D000600 */  break      6
  .L800CFEBC:
    /* C06BC 800CFEBC 12100000 */  mflo       $v0
    /* C06C0 800CFEC0 04008424 */  addiu      $a0, $a0, 0x4
    /* C06C4 800CFEC4 01003126 */  addiu      $s1, $s1, 0x1
    /* C06C8 800CFEC8 0000A2AC */  sw         $v0, 0x0($a1)
    /* C06CC 800CFECC 1000222A */  slti       $v0, $s1, 0x10
    /* C06D0 800CFED0 EDFF4014 */  bnez       $v0, .L800CFE88
    /* C06D4 800CFED4 0400A524 */   addiu     $a1, $a1, 0x4
    /* C06D8 800CFED8 21480000 */  addu       $t1, $zero, $zero
    /* C06DC 800CFEDC 10000C24 */  addiu      $t4, $zero, 0x10
    /* C06E0 800CFEE0 1280023C */  lui        $v0, %hi(gHrzRingColor)
    /* C06E4 800CFEE4 F4074824 */  addiu      $t0, $v0, %lo(gHrzRingColor)
    /* C06E8 800CFEE8 21580001 */  addu       $t3, $t0, $zero
    /* C06EC 800CFEEC 21502001 */  addu       $t2, $t1, $zero
  .L800CFEF0:
    /* C06F0 800CFEF0 02002229 */  slti       $v0, $t1, 0x2
    /* C06F4 800CFEF4 50004010 */  beqz       $v0, .L800D0038
    /* C06F8 800CFEF8 21880000 */   addu      $s1, $zero, $zero
    /* C06FC 800CFEFC 21384001 */  addu       $a3, $t2, $zero
    /* C0700 800CFF00 3C13828F */  lw         $v0, %gp_rel(Hrz_gTrackSpec)($gp)
    /* C0704 800CFF04 80200900 */  sll        $a0, $t1, 2
    /* C0708 800CFF08 21184000 */  addu       $v1, $v0, $zero
    /* C070C 800CFF0C 21104400 */  addu       $v0, $v0, $a0
    /* C0710 800CFF10 21186400 */  addu       $v1, $v1, $a0
    /* C0714 800CFF14 1B004D88 */  lwl        $t5, 0x1B($v0)
    /* C0718 800CFF18 18004D98 */  lwr        $t5, 0x18($v0)
    /* C071C 800CFF1C 00000000 */  nop
    /* C0720 800CFF20 1300ADAB */  swl        $t5, 0x13($sp)
    /* C0724 800CFF24 1000ADBB */  swr        $t5, 0x10($sp)
    /* C0728 800CFF28 13006D88 */  lwl        $t5, 0x13($v1)
    /* C072C 800CFF2C 10006D98 */  lwr        $t5, 0x10($v1)
    /* C0730 800CFF30 00000000 */  nop
    /* C0734 800CFF34 1B00ADAB */  swl        $t5, 0x1B($sp)
    /* C0738 800CFF38 1800ADBB */  swr        $t5, 0x18($sp)
  .L800CFF3C:
    /* C073C 800CFF3C 1000222A */  slti       $v0, $s1, 0x10
    /* C0740 800CFF40 34004010 */  beqz       $v0, .L800D0014
    /* C0744 800CFF44 0900222A */   slti      $v0, $s1, 0x9
    /* C0748 800CFF48 02004014 */  bnez       $v0, .L800CFF54
    /* C074C 800CFF4C 21282002 */   addu      $a1, $s1, $zero
    /* C0750 800CFF50 23289101 */  subu       $a1, $t4, $s1
  .L800CFF54:
    /* C0754 800CFF54 1000A293 */  lbu        $v0, 0x10($sp)
    /* C0758 800CFF58 1800A693 */  lbu        $a2, 0x18($sp)
    /* C075C 800CFF5C 00000000 */  nop
    /* C0760 800CFF60 23104600 */  subu       $v0, $v0, $a2
    /* C0764 800CFF64 02004104 */  bgez       $v0, .L800CFF70
    /* C0768 800CFF68 00000000 */   nop
    /* C076C 800CFF6C 07004224 */  addiu      $v0, $v0, 0x7
  .L800CFF70:
    /* C0770 800CFF70 1100A493 */  lbu        $a0, 0x11($sp)
    /* C0774 800CFF74 1900A393 */  lbu        $v1, 0x19($sp)
    /* C0778 800CFF78 C3100200 */  sra        $v0, $v0, 3
    /* C077C 800CFF7C 2000A2A3 */  sb         $v0, 0x20($sp)
    /* C0780 800CFF80 23108300 */  subu       $v0, $a0, $v1
    /* C0784 800CFF84 02004104 */  bgez       $v0, .L800CFF90
    /* C0788 800CFF88 00000000 */   nop
    /* C078C 800CFF8C 07004224 */  addiu      $v0, $v0, 0x7
  .L800CFF90:
    /* C0790 800CFF90 1200A493 */  lbu        $a0, 0x12($sp)
    /* C0794 800CFF94 1A00A393 */  lbu        $v1, 0x1A($sp)
    /* C0798 800CFF98 C3100200 */  sra        $v0, $v0, 3
    /* C079C 800CFF9C 23208300 */  subu       $a0, $a0, $v1
    /* C07A0 800CFFA0 02008104 */  bgez       $a0, .L800CFFAC
    /* C07A4 800CFFA4 2100A2A3 */   sb        $v0, 0x21($sp)
    /* C07A8 800CFFA8 07008424 */  addiu      $a0, $a0, 0x7
  .L800CFFAC:
    /* C07AC 800CFFAC 2000A293 */  lbu        $v0, 0x20($sp)
    /* C07B0 800CFFB0 00000000 */  nop
    /* C07B4 800CFFB4 18004500 */  mult       $v0, $a1
    /* C07B8 800CFFB8 2118EB00 */  addu       $v1, $a3, $t3
    /* C07BC 800CFFBC C3100400 */  sra        $v0, $a0, 3
    /* C07C0 800CFFC0 2200A2A3 */  sb         $v0, 0x22($sp)
    /* C07C4 800CFFC4 12680000 */  mflo       $t5
    /* C07C8 800CFFC8 2110CD00 */  addu       $v0, $a2, $t5
    /* C07CC 800CFFCC 000062A0 */  sb         $v0, 0x0($v1)
    /* C07D0 800CFFD0 2100A293 */  lbu        $v0, 0x21($sp)
    /* C07D4 800CFFD4 00000000 */  nop
    /* C07D8 800CFFD8 18004500 */  mult       $v0, $a1
    /* C07DC 800CFFDC 1900A293 */  lbu        $v0, 0x19($sp)
    /* C07E0 800CFFE0 12680000 */  mflo       $t5
    /* C07E4 800CFFE4 21104D00 */  addu       $v0, $v0, $t5
    /* C07E8 800CFFE8 010062A0 */  sb         $v0, 0x1($v1)
    /* C07EC 800CFFEC 2200A293 */  lbu        $v0, 0x22($sp)
    /* C07F0 800CFFF0 00000000 */  nop
    /* C07F4 800CFFF4 18004500 */  mult       $v0, $a1
    /* C07F8 800CFFF8 0400E724 */  addiu      $a3, $a3, 0x4
    /* C07FC 800CFFFC 01003126 */  addiu      $s1, $s1, 0x1
    /* C0800 800D0000 1A00A293 */  lbu        $v0, 0x1A($sp)
    /* C0804 800D0004 12680000 */  mflo       $t5
    /* C0808 800D0008 21104D00 */  addu       $v0, $v0, $t5
    /* C080C 800D000C CF3F0308 */  j          .L800CFF3C
    /* C0810 800D0010 020062A0 */   sb        $v0, 0x2($v1)
  .L800D0014:
    /* C0814 800D0014 03000E89 */  lwl        $t6, 0x3($t0)
    /* C0818 800D0018 00000E99 */  lwr        $t6, 0x0($t0)
    /* C081C 800D001C 00000000 */  nop
    /* C0820 800D0020 43000EA9 */  swl        $t6, 0x43($t0)
    /* C0824 800D0024 40000EB9 */  swr        $t6, 0x40($t0)
    /* C0828 800D0028 44000825 */  addiu      $t0, $t0, 0x44
    /* C082C 800D002C 44004A25 */  addiu      $t2, $t2, 0x44
    /* C0830 800D0030 BC3F0308 */  j          .L800CFEF0
    /* C0834 800D0034 01002925 */   addiu     $t1, $t1, 0x1
  .L800D0038:
    /* C0838 800D0038 8F3E030C */  jal        Hrz_InitSky__Fv
    /* C083C 800D003C 00000000 */   nop
    /* C0840 800D0040 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C0844 800D0044 5800BF8F */  lw         $ra, 0x58($sp)
    /* C0848 800D0048 5400B18F */  lw         $s1, 0x54($sp)
    /* C084C 800D004C 5000B08F */  lw         $s0, 0x50($sp)
    /* C0850 800D0050 0800438C */  lw         $v1, 0x8($v0)
    /* C0854 800D0054 1480023C */  lui        $v0, %hi(D_8013E384)
    /* C0858 800D0058 84E343AC */  sw         $v1, %lo(D_8013E384)($v0)
    /* C085C 800D005C 0800E003 */  jr         $ra
    /* C0860 800D0060 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel Hrz_Init2DRing__Fv
