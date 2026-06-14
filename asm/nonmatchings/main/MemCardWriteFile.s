.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardWriteFile, 0x118

glabel MemCardWriteFile
    /* EBE68 800FB668 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* EBE6C 800FB66C 2000B4AF */  sw         $s4, 0x20($sp)
    /* EBE70 800FB670 21A08000 */  addu       $s4, $a0, $zero
    /* EBE74 800FB674 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* EBE78 800FB678 2198A000 */  addu       $s3, $a1, $zero
    /* EBE7C 800FB67C 2400B5AF */  sw         $s5, 0x24($sp)
    /* EBE80 800FB680 21A8C000 */  addu       $s5, $a2, $zero
    /* EBE84 800FB684 1800B2AF */  sw         $s2, 0x18($sp)
    /* EBE88 800FB688 2190E000 */  addu       $s2, $a3, $zero
    /* EBE8C 800FB68C 1400B1AF */  sw         $s1, 0x14($sp)
    /* EBE90 800FB690 1480113C */  lui        $s1, %hi(D_80147518)
    /* EBE94 800FB694 18753126 */  addiu      $s1, $s1, %lo(D_80147518)
    /* EBE98 800FB698 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* EBE9C 800FB69C 2800B6AF */  sw         $s6, 0x28($sp)
    /* EBEA0 800FB6A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* EBEA4 800FB6A4 0000228E */  lw         $v0, 0x0($s1)
    /* EBEA8 800FB6A8 4000B68F */  lw         $s6, 0x40($sp)
    /* EBEAC 800FB6AC 04004018 */  blez       $v0, .L800FB6C0
    /* EBEB0 800FB6B0 00000000 */   nop
    /* EBEB4 800FB6B4 0580043C */  lui        $a0, %hi(D_800574C0)
    /* EBEB8 800FB6B8 D3ED0308 */  j          .L800FB74C
    /* EBEBC 800FB6BC C0748424 */   addiu     $a0, $a0, %lo(D_800574C0)
  .L800FB6C0:
    /* EBEC0 800FB6C0 1000228E */  lw         $v0, 0x10($s1)
    /* EBEC4 800FB6C4 00000000 */  nop
    /* EBEC8 800FB6C8 04004004 */  bltz       $v0, .L800FB6DC
    /* EBECC 800FB6CC 7F00C232 */   andi      $v0, $s6, 0x7F
    /* EBED0 800FB6D0 0580043C */  lui        $a0, %hi(D_80057418)
    /* EBED4 800FB6D4 D3ED0308 */  j          .L800FB74C
    /* EBED8 800FB6D8 18748424 */   addiu     $a0, $a0, %lo(D_80057418)
  .L800FB6DC:
    /* EBEDC 800FB6DC 04004010 */  beqz       $v0, .L800FB6F0
    /* EBEE0 800FB6E0 7F004232 */   andi      $v0, $s2, 0x7F
    /* EBEE4 800FB6E4 0580043C */  lui        $a0, %hi(D_80057464)
    /* EBEE8 800FB6E8 D3ED0308 */  j          .L800FB74C
    /* EBEEC 800FB6EC 64748424 */   addiu     $a0, $a0, %lo(D_80057464)
  .L800FB6F0:
    /* EBEF0 800FB6F0 14004014 */  bnez       $v0, .L800FB744
    /* EBEF4 800FB6F4 21208002 */   addu      $a0, $s4, $zero
    /* EBEF8 800FB6F8 20003026 */  addiu      $s0, $s1, 0x20
    /* EBEFC 800FB6FC 7DF0030C */  jal        func_800FC1F4
    /* EBF00 800FB700 21280002 */   addu      $a1, $s0, $zero
    /* EBF04 800FB704 21200002 */  addu       $a0, $s0, $zero
    /* EBF08 800FB708 3A9E030C */  jal        strcat
    /* EBF0C 800FB70C 21286002 */   addu      $a1, $s3, $zero
    /* EBF10 800FB710 1080043C */  lui        $a0, %hi(func_800FB780)
    /* EBF14 800FB714 80B78424 */  addiu      $a0, $a0, %lo(func_800FB780)
    /* EBF18 800FB718 04000224 */  addiu      $v0, $zero, 0x4
    /* EBF1C 800FB71C 000022AE */  sw         $v0, 0x0($s1)
    /* EBF20 800FB720 040020AE */  sw         $zero, 0x4($s1)
    /* EBF24 800FB724 080020AE */  sw         $zero, 0x8($s1)
    /* EBF28 800FB728 140032AE */  sw         $s2, 0x14($s1)
    /* EBF2C 800FB72C 1C0035AE */  sw         $s5, 0x1C($s1)
    /* EBF30 800FB730 180036AE */  sw         $s6, 0x18($s1)
    /* EBF34 800FB734 0427040C */  jal        UserFuncOpen
    /* EBF38 800FB738 0C0034AE */   sw        $s4, 0xC($s1)
    /* EBF3C 800FB73C D6ED0308 */  j          .L800FB758
    /* EBF40 800FB740 01000224 */   addiu     $v0, $zero, 0x1
  .L800FB744:
    /* EBF44 800FB744 0580043C */  lui        $a0, %hi(D_80057490)
    /* EBF48 800FB748 90748424 */  addiu      $a0, $a0, %lo(D_80057490)
  .L800FB74C:
    /* EBF4C 800FB74C 2B0A040C */  jal        printf
    /* EBF50 800FB750 00000000 */   nop
    /* EBF54 800FB754 21100000 */  addu       $v0, $zero, $zero
  .L800FB758:
    /* EBF58 800FB758 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* EBF5C 800FB75C 2800B68F */  lw         $s6, 0x28($sp)
    /* EBF60 800FB760 2400B58F */  lw         $s5, 0x24($sp)
    /* EBF64 800FB764 2000B48F */  lw         $s4, 0x20($sp)
    /* EBF68 800FB768 1C00B38F */  lw         $s3, 0x1C($sp)
    /* EBF6C 800FB76C 1800B28F */  lw         $s2, 0x18($sp)
    /* EBF70 800FB770 1400B18F */  lw         $s1, 0x14($sp)
    /* EBF74 800FB774 1000B08F */  lw         $s0, 0x10($sp)
    /* EBF78 800FB778 0800E003 */  jr         $ra
    /* EBF7C 800FB77C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel MemCardWriteFile
