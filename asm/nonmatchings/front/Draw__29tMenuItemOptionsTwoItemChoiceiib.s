.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__29tMenuItemOptionsTwoItemChoiceiib, 0x284

glabel Draw__29tMenuItemOptionsTwoItemChoiceiib
    /* B614 8001AE14 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* B618 8001AE18 5000B2AF */  sw         $s2, 0x50($sp)
    /* B61C 8001AE1C 21908000 */  addu       $s2, $a0, $zero
    /* B620 8001AE20 5800B4AF */  sw         $s4, 0x58($sp)
    /* B624 8001AE24 21A0A000 */  addu       $s4, $a1, $zero
    /* B628 8001AE28 6400BFAF */  sw         $ra, 0x64($sp)
    /* B62C 8001AE2C 6000B6AF */  sw         $s6, 0x60($sp)
    /* B630 8001AE30 5C00B5AF */  sw         $s5, 0x5C($sp)
    /* B634 8001AE34 5400B3AF */  sw         $s3, 0x54($sp)
    /* B638 8001AE38 4C00B1AF */  sw         $s1, 0x4C($sp)
    /* B63C 8001AE3C 4800B0AF */  sw         $s0, 0x48($sp)
    /* B640 8001AE40 1C00428E */  lw         $v0, 0x1C($s2)
    /* B644 8001AE44 21A8C000 */  addu       $s5, $a2, $zero
    /* B648 8001AE48 0C00468C */  lw         $a2, 0xC($v0)
    /* B64C 8001AE4C 21B0E000 */  addu       $s6, $a3, $zero
    /* B650 8001AE50 1000C484 */  lh         $a0, 0x10($a2)
    /* B654 8001AE54 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* B658 8001AE58 21204400 */  addu       $a0, $v0, $a0
    /* B65C 8001AE5C 0580023C */  lui        $v0, %hi(gHelpShapes)
    /* B660 8001AE60 642A438C */  lw         $v1, %lo(gHelpShapes)($v0)
    /* B664 8001AE64 1400C28C */  lw         $v0, 0x14($a2)
    /* B668 8001AE68 00000000 */  nop
    /* B66C 8001AE6C 09F84000 */  jalr       $v0
    /* B670 8001AE70 20057324 */   addiu     $s3, $v1, 0x520
    /* B674 8001AE74 FF004230 */  andi       $v0, $v0, 0xFF
    /* B678 8001AE78 04004010 */  beqz       $v0, .L8001AE8C
    /* B67C 8001AE7C 00000000 */   nop
    /* B680 8001AE80 20004296 */  lhu        $v0, 0x20($s2)
    /* B684 8001AE84 A66B0008 */  j          .L8001AE98
    /* B688 8001AE88 40004224 */   addiu     $v0, $v0, 0x40
  .L8001AE8C:
    /* B68C 8001AE8C 20004296 */  lhu        $v0, 0x20($s2)
    /* B690 8001AE90 00000000 */  nop
    /* B694 8001AE94 C0FF4224 */  addiu      $v0, $v0, -0x40
  .L8001AE98:
    /* B698 8001AE98 200042A6 */  sh         $v0, 0x20($s2)
    /* B69C 8001AE9C 20004386 */  lh         $v1, 0x20($s2)
    /* B6A0 8001AEA0 20004496 */  lhu        $a0, 0x20($s2)
    /* B6A4 8001AEA4 03006018 */  blez       $v1, .L8001AEB4
    /* B6A8 8001AEA8 80006228 */   slti      $v0, $v1, 0x80
    /* B6AC 8001AEAC 04004010 */  beqz       $v0, .L8001AEC0
    /* B6B0 8001AEB0 80000224 */   addiu     $v0, $zero, 0x80
  .L8001AEB4:
    /* B6B4 8001AEB4 02006104 */  bgez       $v1, .L8001AEC0
    /* B6B8 8001AEB8 21108000 */   addu      $v0, $a0, $zero
    /* B6BC 8001AEBC 21100000 */  addu       $v0, $zero, $zero
  .L8001AEC0:
    /* B6C0 8001AEC0 06000424 */  addiu      $a0, $zero, 0x6
    /* B6C4 8001AEC4 08004586 */  lh         $a1, 0x8($s2)
    /* B6C8 8001AEC8 21300000 */  addu       $a2, $zero, $zero
    /* B6CC 8001AECC 542E010C */  jal        CalcTextFadeSelToHi__F13tMenuTextTypess
    /* B6D0 8001AED0 200042A6 */   sh        $v0, 0x20($s2)
    /* B6D4 8001AED4 06000424 */  addiu      $a0, $zero, 0x6
    /* B6D8 8001AED8 21380000 */  addu       $a3, $zero, $zero
    /* B6DC 8001AEDC 20004586 */  lh         $a1, 0x20($s2)
    /* B6E0 8001AEE0 08004686 */  lh         $a2, 0x8($s2)
    /* B6E4 8001AEE4 4000A327 */  addiu      $v1, $sp, 0x40
    /* B6E8 8001AEE8 1000A3AF */  sw         $v1, 0x10($sp)
    /* B6EC 8001AEEC 4400A327 */  addiu      $v1, $sp, 0x44
    /* B6F0 8001AEF0 21884000 */  addu       $s1, $v0, $zero
    /* B6F4 8001AEF4 752E010C */  jal        CalcOnOffFade__F13tMenuTextTypesssRiT4
    /* B6F8 8001AEF8 1400A3AF */   sw        $v1, 0x14($sp)
    /* B6FC 8001AEFC 0400448E */  lw         $a0, 0x4($s2)
    /* B700 8001AF00 94E4020C */  jal        TextSys_Word__Fi
    /* B704 8001AF04 0300B026 */   addiu     $s0, $s5, 0x3
    /* B708 8001AF08 21204000 */  addu       $a0, $v0, $zero
    /* B70C 8001AF0C 94008526 */  addiu      $a1, $s4, 0x94
    /* B710 8001AF10 002C0500 */  sll        $a1, $a1, 16
    /* B714 8001AF14 032C0500 */  sra        $a1, $a1, 16
    /* B718 8001AF18 00841000 */  sll        $s0, $s0, 16
    /* B71C 8001AF1C 03841000 */  sra        $s0, $s0, 16
    /* B720 8001AF20 21300002 */  addu       $a2, $s0, $zero
    /* B724 8001AF24 21382002 */  addu       $a3, $s1, $zero
    /* B728 8001AF28 01001124 */  addiu      $s1, $zero, 0x1
    /* B72C 8001AF2C 1000A0AF */  sw         $zero, 0x10($sp)
    /* B730 8001AF30 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* B734 8001AF34 1400B1AF */   sw        $s1, 0x14($sp)
    /* B738 8001AF38 1C00428E */  lw         $v0, 0x1C($s2)
    /* B73C 8001AF3C 00000000 */  nop
    /* B740 8001AF40 0000428C */  lw         $v0, 0x0($v0)
    /* B744 8001AF44 00000000 */  nop
    /* B748 8001AF48 00004484 */  lh         $a0, 0x0($v0)
    /* B74C 8001AF4C 94E4020C */  jal        TextSys_Word__Fi
    /* B750 8001AF50 00000000 */   nop
    /* B754 8001AF54 21204000 */  addu       $a0, $v0, $zero
    /* B758 8001AF58 B0008526 */  addiu      $a1, $s4, 0xB0
    /* B75C 8001AF5C 002C0500 */  sll        $a1, $a1, 16
    /* B760 8001AF60 032C0500 */  sra        $a1, $a1, 16
    /* B764 8001AF64 4400A78F */  lw         $a3, 0x44($sp)
    /* B768 8001AF68 21300002 */  addu       $a2, $s0, $zero
    /* B76C 8001AF6C 1000A0AF */  sw         $zero, 0x10($sp)
    /* B770 8001AF70 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* B774 8001AF74 1400A0AF */   sw        $zero, 0x14($sp)
    /* B778 8001AF78 1C00428E */  lw         $v0, 0x1C($s2)
    /* B77C 8001AF7C 00000000 */  nop
    /* B780 8001AF80 0000428C */  lw         $v0, 0x0($v0)
    /* B784 8001AF84 00000000 */  nop
    /* B788 8001AF88 02004484 */  lh         $a0, 0x2($v0)
    /* B78C 8001AF8C 94E4020C */  jal        TextSys_Word__Fi
    /* B790 8001AF90 00000000 */   nop
    /* B794 8001AF94 21204000 */  addu       $a0, $v0, $zero
    /* B798 8001AF98 10006596 */  lhu        $a1, 0x10($s3)
    /* B79C 8001AF9C 4000A78F */  lw         $a3, 0x40($sp)
    /* B7A0 8001AFA0 21300002 */  addu       $a2, $s0, $zero
    /* B7A4 8001AFA4 1000A0AF */  sw         $zero, 0x10($sp)
    /* B7A8 8001AFA8 1400B1AF */  sw         $s1, 0x14($sp)
    /* B7AC 8001AFAC 23288502 */  subu       $a1, $s4, $a1
    /* B7B0 8001AFB0 2601A524 */  addiu      $a1, $a1, 0x126
    /* B7B4 8001AFB4 002C0500 */  sll        $a1, $a1, 16
    /* B7B8 8001AFB8 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* B7BC 8001AFBC 032C0500 */   sra       $a1, $a1, 16
    /* B7C0 8001AFC0 B500043C */  lui        $a0, (0xB54200 >> 16)
    /* B7C4 8001AFC4 00428434 */  ori        $a0, $a0, (0xB54200 & 0xFFFF)
    /* B7C8 8001AFC8 08004686 */  lh         $a2, 0x8($s2)
    /* B7CC 8001AFCC FE2D010C */  jal        CalcFadeVal__Fiii
    /* B7D0 8001AFD0 BEBE0534 */   ori       $a1, $zero, 0xBEBE
    /* B7D4 8001AFD4 A6008626 */  addiu      $a2, $s4, 0xA6
    /* B7D8 8001AFD8 0600A726 */  addiu      $a3, $s5, 0x6
    /* B7DC 8001AFDC 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* B7E0 8001AFE0 0300C012 */  beqz       $s6, .L8001AFF0
    /* B7E4 8001AFE4 1000A0AF */   sw        $zero, 0x10($sp)
    /* B7E8 8001AFE8 FD6B0008 */  j          .L8001AFF4
    /* B7EC 8001AFEC 1400A0AF */   sw        $zero, 0x14($sp)
  .L8001AFF0:
    /* B7F0 8001AFF0 1400B1AF */  sw         $s1, 0x14($sp)
  .L8001AFF4:
    /* B7F4 8001AFF4 0A000424 */  addiu      $a0, $zero, 0xA
    /* B7F8 8001AFF8 18010524 */  addiu      $a1, $zero, 0x118
    /* B7FC 8001AFFC 2800A227 */  addiu      $v0, $sp, 0x28
    /* B800 8001B000 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* B804 8001B004 1800A2AF */   sw        $v0, 0x18($sp)
    /* B808 8001B008 10006286 */  lh         $v0, 0x10($s3)
    /* B80C 8001B00C 0600A726 */  addiu      $a3, $s5, 0x6
    /* B810 8001B010 1000A0AF */  sw         $zero, 0x10($sp)
    /* B814 8001B014 23108202 */  subu       $v0, $s4, $v0
    /* B818 8001B018 0300C012 */  beqz       $s6, .L8001B028
    /* B81C 8001B01C 2F014624 */   addiu     $a2, $v0, 0x12F
    /* B820 8001B020 0C6C0008 */  j          .L8001B030
    /* B824 8001B024 1400A0AF */   sw        $zero, 0x14($sp)
  .L8001B028:
    /* B828 8001B028 01000224 */  addiu      $v0, $zero, 0x1
    /* B82C 8001B02C 1400A2AF */  sw         $v0, 0x14($sp)
  .L8001B030:
    /* B830 8001B030 0B000424 */  addiu      $a0, $zero, 0xB
    /* B834 8001B034 18010524 */  addiu      $a1, $zero, 0x118
    /* B838 8001B038 2800A227 */  addiu      $v0, $sp, 0x28
    /* B83C 8001B03C 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* B840 8001B040 1800A2AF */   sw        $v0, 0x18($sp)
    /* B844 8001B044 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* B848 8001B048 2000A527 */  addiu      $a1, $sp, 0x20
    /* B84C 8001B04C 29010224 */  addiu      $v0, $zero, 0x129
    /* B850 8001B050 00341600 */  sll        $a2, $s6, 16
    /* B854 8001B054 2000B4A7 */  sh         $s4, 0x20($sp)
    /* B858 8001B058 2200B5A7 */  sh         $s5, 0x22($sp)
    /* B85C 8001B05C 2400A2A7 */  sh         $v0, 0x24($sp)
    /* B860 8001B060 12006296 */  lhu        $v0, 0x12($s3)
    /* B864 8001B064 03340600 */  sra        $a2, $a2, 16
    /* B868 8001B068 EC2F010C */  jal        DrawShape_NFS4RoundRectangle__FiR4RECTs
    /* B86C 8001B06C 2600A2A7 */   sh        $v0, 0x26($sp)
    /* B870 8001B070 6400BF8F */  lw         $ra, 0x64($sp)
    /* B874 8001B074 6000B68F */  lw         $s6, 0x60($sp)
    /* B878 8001B078 5C00B58F */  lw         $s5, 0x5C($sp)
    /* B87C 8001B07C 5800B48F */  lw         $s4, 0x58($sp)
    /* B880 8001B080 5400B38F */  lw         $s3, 0x54($sp)
    /* B884 8001B084 5000B28F */  lw         $s2, 0x50($sp)
    /* B888 8001B088 4C00B18F */  lw         $s1, 0x4C($sp)
    /* B88C 8001B08C 4800B08F */  lw         $s0, 0x48($sp)
    /* B890 8001B090 0800E003 */  jr         $ra
    /* B894 8001B094 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel Draw__29tMenuItemOptionsTwoItemChoiceiib
