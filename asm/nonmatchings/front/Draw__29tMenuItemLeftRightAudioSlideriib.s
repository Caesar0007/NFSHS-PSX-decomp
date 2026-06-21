.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__29tMenuItemLeftRightAudioSlideriib, 0x20C

glabel Draw__29tMenuItemLeftRightAudioSlideriib
    /* ED70 8001E570 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* ED74 8001E574 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* ED78 8001E578 21988000 */  addu       $s3, $a0, $zero
    /* ED7C 8001E57C 5000B0AF */  sw         $s0, 0x50($sp)
    /* ED80 8001E580 2180A000 */  addu       $s0, $a1, $zero
    /* ED84 8001E584 6000BFAF */  sw         $ra, 0x60($sp)
    /* ED88 8001E588 5800B2AF */  sw         $s2, 0x58($sp)
    /* ED8C 8001E58C 5400B1AF */  sw         $s1, 0x54($sp)
    /* ED90 8001E590 0400648E */  lw         $a0, 0x4($s3)
    /* ED94 8001E594 A4E4020C */  jal        TextSys_WordX__Fi
    /* ED98 8001E598 2188C000 */   addu      $s1, $a2, $zero
    /* ED9C 8001E59C 0400648E */  lw         $a0, 0x4($s3)
    /* EDA0 8001E5A0 21105000 */  addu       $v0, $v0, $s0
    /* EDA4 8001E5A4 ACE4020C */  jal        TextSys_WordY__Fi
    /* EDA8 8001E5A8 200062A6 */   sh        $v0, 0x20($s3)
    /* EDAC 8001E5AC 21105100 */  addu       $v0, $v0, $s1
    /* EDB0 8001E5B0 0580113C */  lui        $s1, %hi(kRGBVals)
    /* EDB4 8001E5B4 04006486 */  lh         $a0, 0x4($s3)
    /* EDB8 8001E5B8 C8163126 */  addiu      $s1, $s1, %lo(kRGBVals)
    /* EDBC 8001E5BC 9CE4020C */  jal        TextSys_WordFlags__Fi
    /* EDC0 8001E5C0 220062A6 */   sh        $v0, 0x22($s3)
    /* EDC4 8001E5C4 0580103C */  lui        $s0, %hi(textDefinitions)
    /* EDC8 8001E5C8 B8151026 */  addiu      $s0, $s0, %lo(textDefinitions)
    /* EDCC 8001E5CC 40180200 */  sll        $v1, $v0, 1
    /* EDD0 8001E5D0 21186200 */  addu       $v1, $v1, $v0
    /* EDD4 8001E5D4 40180300 */  sll        $v1, $v1, 1
    /* EDD8 8001E5D8 21187000 */  addu       $v1, $v1, $s0
    /* EDDC 8001E5DC 05006290 */  lbu        $v0, 0x5($v1)
    /* EDE0 8001E5E0 04006486 */  lh         $a0, 0x4($s3)
    /* EDE4 8001E5E4 80100200 */  sll        $v0, $v0, 2
    /* EDE8 8001E5E8 21105100 */  addu       $v0, $v0, $s1
    /* EDEC 8001E5EC 0000528C */  lw         $s2, 0x0($v0)
    /* EDF0 8001E5F0 9CE4020C */  jal        TextSys_WordFlags__Fi
    /* EDF4 8001E5F4 00000000 */   nop
    /* EDF8 8001E5F8 40180200 */  sll        $v1, $v0, 1
    /* EDFC 8001E5FC 21186200 */  addu       $v1, $v1, $v0
    /* EE00 8001E600 40180300 */  sll        $v1, $v1, 1
    /* EE04 8001E604 21187000 */  addu       $v1, $v1, $s0
    /* EE08 8001E608 22006486 */  lh         $a0, 0x22($s3)
    /* EE0C 8001E60C 08006586 */  lh         $a1, 0x8($s3)
    /* EE10 8001E610 04006290 */  lbu        $v0, 0x4($v1)
    /* EE14 8001E614 28006686 */  lh         $a2, 0x28($s3)
    /* EE18 8001E618 80100200 */  sll        $v0, $v0, 2
    /* EE1C 8001E61C 21105100 */  addu       $v0, $v0, $s1
    /* EE20 8001E620 0000508C */  lw         $s0, 0x0($v0)
    /* EE24 8001E624 E86F000C */  jal        DrawLeftFlare__FiiiRi
    /* EE28 8001E628 34006726 */   addiu     $a3, $s3, 0x34
    /* EE2C 8001E62C 21284002 */  addu       $a1, $s2, $zero
    /* EE30 8001E630 08006686 */  lh         $a2, 0x8($s3)
    /* EE34 8001E634 28006786 */  lh         $a3, 0x28($s3)
    /* EE38 8001E638 2B2E010C */  jal        CalcFadeVal__Fiiii
    /* EE3C 8001E63C 21200002 */   addu      $a0, $s0, $zero
    /* EE40 8001E640 21804000 */  addu       $s0, $v0, $zero
    /* EE44 8001E644 28006386 */  lh         $v1, 0x28($s3)
    /* EE48 8001E648 80000224 */  addiu      $v0, $zero, 0x80
    /* EE4C 8001E64C 44006210 */  beq        $v1, $v0, .L8001E760
    /* EE50 8001E650 00000000 */   nop
    /* EE54 8001E654 0400648E */  lw         $a0, 0x4($s3)
    /* EE58 8001E658 94E4020C */  jal        TextSys_Word__Fi
    /* EE5C 8001E65C 00000000 */   nop
    /* EE60 8001E660 21204000 */  addu       $a0, $v0, $zero
    /* EE64 8001E664 21380002 */  addu       $a3, $s0, $zero
    /* EE68 8001E668 20006586 */  lh         $a1, 0x20($s3)
    /* EE6C 8001E66C 22006686 */  lh         $a2, 0x22($s3)
    /* EE70 8001E670 01000224 */  addiu      $v0, $zero, 0x1
    /* EE74 8001E674 1000A0AF */  sw         $zero, 0x10($sp)
    /* EE78 8001E678 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* EE7C 8001E67C 1400A2AF */   sw        $v0, 0x14($sp)
    /* EE80 8001E680 5500043C */  lui        $a0, (0x551E00 >> 16)
    /* EE84 8001E684 001E8434 */  ori        $a0, $a0, (0x551E00 & 0xFFFF)
    /* EE88 8001E688 08006686 */  lh         $a2, 0x8($s3)
    /* EE8C 8001E68C 28006786 */  lh         $a3, 0x28($s3)
    /* EE90 8001E690 2B2E010C */  jal        CalcFadeVal__Fiiii
    /* EE94 8001E694 BEBE0534 */   ori       $a1, $zero, 0xBEBE
    /* EE98 8001E698 3C00A2AF */  sw         $v0, 0x3C($sp)
    /* EE9C 8001E69C 08006286 */  lh         $v0, 0x8($s3)
    /* EEA0 8001E6A0 00000000 */  nop
    /* EEA4 8001E6A4 0A004010 */  beqz       $v0, .L8001E6D0
    /* EEA8 8001E6A8 10000524 */   addiu     $a1, $zero, 0x10
    /* EEAC 8001E6AC 21300000 */  addu       $a2, $zero, $zero
    /* EEB0 8001E6B0 2138C000 */  addu       $a3, $a2, $zero
    /* EEB4 8001E6B4 30006486 */  lh         $a0, 0x30($s3)
    /* EEB8 8001E6B8 3800A227 */  addiu      $v0, $sp, 0x38
    /* EEBC 8001E6BC 1000A0AF */  sw         $zero, 0x10($sp)
    /* EEC0 8001E6C0 1400A0AF */  sw         $zero, 0x14($sp)
    /* EEC4 8001E6C4 1800A2AF */  sw         $v0, 0x18($sp)
    /* EEC8 8001E6C8 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* EECC 8001E6CC 01008424 */   addiu     $a0, $a0, 0x1
  .L8001E6D0:
    /* EED0 8001E6D0 1C00638E */  lw         $v1, 0x1C($s3)
    /* EED4 8001E6D4 00000000 */  nop
    /* EED8 8001E6D8 0C00628C */  lw         $v0, 0xC($v1)
    /* EEDC 8001E6DC FFFF0524 */  addiu      $a1, $zero, -0x1
    /* EEE0 8001E6E0 10004484 */  lh         $a0, 0x10($v0)
    /* EEE4 8001E6E4 1400428C */  lw         $v0, 0x14($v0)
    /* EEE8 8001E6E8 00000000 */  nop
    /* EEEC 8001E6EC 09F84000 */  jalr       $v0
    /* EEF0 8001E6F0 21206400 */   addu      $a0, $v1, $a0
    /* EEF4 8001E6F4 FF004430 */  andi       $a0, $v0, 0xFF
    /* EEF8 8001E6F8 22006396 */  lhu        $v1, 0x22($s3)
    /* EEFC 8001E6FC 1C00628E */  lw         $v0, 0x1C($s3)
    /* EF00 8001E700 20006796 */  lhu        $a3, 0x20($s3)
    /* EF04 8001E704 01006324 */  addiu      $v1, $v1, 0x1
    /* EF08 8001E708 001C0300 */  sll        $v1, $v1, 16
    /* EF0C 8001E70C 08004590 */  lbu        $a1, 0x8($v0)
    /* EF10 8001E710 09004690 */  lbu        $a2, 0x9($v0)
    /* EF14 8001E714 031C0300 */  sra        $v1, $v1, 16
    /* EF18 8001E718 1000A3AF */  sw         $v1, 0x10($sp)
    /* EF1C 8001E71C 24006286 */  lh         $v0, 0x24($s3)
    /* EF20 8001E720 1400E724 */  addiu      $a3, $a3, 0x14
    /* EF24 8001E724 1400A2AF */  sw         $v0, 0x14($sp)
    /* EF28 8001E728 26006386 */  lh         $v1, 0x26($s3)
    /* EF2C 8001E72C 04000224 */  addiu      $v0, $zero, 0x4
    /* EF30 8001E730 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* EF34 8001E734 2000A2AF */  sw         $v0, 0x20($sp)
    /* EF38 8001E738 2400A0AF */  sw         $zero, 0x24($sp)
    /* EF3C 8001E73C 2800A0AF */  sw         $zero, 0x28($sp)
    /* EF40 8001E740 1800A3AF */  sw         $v1, 0x18($sp)
    /* EF44 8001E744 08006286 */  lh         $v0, 0x8($s3)
    /* EF48 8001E748 003C0700 */  sll        $a3, $a3, 16
    /* EF4C 8001E74C 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* EF50 8001E750 28006286 */  lh         $v0, 0x28($s3)
    /* EF54 8001E754 033C0700 */  sra        $a3, $a3, 16
    /* EF58 8001E758 0B93000C */  jal        DrawSlider__FsssssssssbT9ss
    /* EF5C 8001E75C 3000A2AF */   sw        $v0, 0x30($sp)
  .L8001E760:
    /* EF60 8001E760 6000BF8F */  lw         $ra, 0x60($sp)
    /* EF64 8001E764 5C00B38F */  lw         $s3, 0x5C($sp)
    /* EF68 8001E768 5800B28F */  lw         $s2, 0x58($sp)
    /* EF6C 8001E76C 5400B18F */  lw         $s1, 0x54($sp)
    /* EF70 8001E770 5000B08F */  lw         $s0, 0x50($sp)
    /* EF74 8001E774 0800E003 */  jr         $ra
    /* EF78 8001E778 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel Draw__29tMenuItemLeftRightAudioSlideriib
