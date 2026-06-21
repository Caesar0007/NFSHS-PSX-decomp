.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__20tDialogMessageString, 0x164

glabel Draw__20tDialogMessageString
    /* 9E2C 8001962C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 9E30 80019630 2000B0AF */  sw         $s0, 0x20($sp)
    /* 9E34 80019634 21808000 */  addu       $s0, $a0, $zero
    /* 9E38 80019638 2800BFAF */  sw         $ra, 0x28($sp)
    /* 9E3C 8001963C 2400B1AF */  sw         $s1, 0x24($sp)
    /* 9E40 80019640 6000028E */  lw         $v0, 0x60($s0)
    /* 9E44 80019644 00000000 */  nop
    /* 9E48 80019648 50004484 */  lh         $a0, 0x50($v0)
    /* 9E4C 8001964C 5400428C */  lw         $v0, 0x54($v0)
    /* 9E50 80019650 00000000 */  nop
    /* 9E54 80019654 09F84000 */  jalr       $v0
    /* 9E58 80019658 21200402 */   addu      $a0, $s0, $a0
    /* 9E5C 8001965C 1480033C */  lui        $v1, %hi(ticks)
    /* 9E60 80019660 7400028E */  lw         $v0, 0x74($s0)
    /* 9E64 80019664 ACDC638C */  lw         $v1, %lo(ticks)($v1)
    /* 9E68 80019668 32004224 */  addiu      $v0, $v0, 0x32
    /* 9E6C 8001966C 2A186200 */  slt        $v1, $v1, $v0
    /* 9E70 80019670 03006010 */  beqz       $v1, .L80019680
    /* 9E74 80019674 00000000 */   nop
    /* 9E78 80019678 DD650008 */  j          .L80019774
    /* 9E7C 8001967C 840000AE */   sw        $zero, 0x84($s0)
  .L80019680:
    /* 9E80 80019680 8C00028E */  lw         $v0, 0x8C($s0)
    /* 9E84 80019684 00000000 */  nop
    /* 9E88 80019688 02004010 */  beqz       $v0, .L80019694
    /* 9E8C 8001968C 0580033C */   lui       $v1, %hi(kRGBVals)
    /* 9E90 80019690 840000AE */  sw         $zero, 0x84($s0)
  .L80019694:
    /* 9E94 80019694 0580023C */  lui        $v0, %hi(D_800515EC)
    /* 9E98 80019698 C8166324 */  addiu      $v1, $v1, %lo(kRGBVals)
    /* 9E9C 8001969C EC154290 */  lbu        $v0, %lo(D_800515EC)($v0)
    /* 9EA0 800196A0 8C00058E */  lw         $a1, 0x8C($s0)
    /* 9EA4 800196A4 80100200 */  sll        $v0, $v0, 2
    /* 9EA8 800196A8 21104300 */  addu       $v0, $v0, $v1
    /* 9EAC 800196AC 0000448C */  lw         $a0, 0x0($v0)
    /* 9EB0 800196B0 222E010C */  jal        CalcFadeVal__Fii
    /* 9EB4 800196B4 00000000 */   nop
    /* 9EB8 800196B8 66000396 */  lhu        $v1, 0x66($s0)
    /* 9EBC 800196BC 01000424 */  addiu      $a0, $zero, 0x1
    /* 9EC0 800196C0 11006324 */  addiu      $v1, $v1, 0x11
    /* 9EC4 800196C4 1800A3A7 */  sh         $v1, 0x18($sp)
    /* 9EC8 800196C8 68000396 */  lhu        $v1, 0x68($s0)
    /* 9ECC 800196CC 21288000 */  addu       $a1, $a0, $zero
    /* 9ED0 800196D0 0A006324 */  addiu      $v1, $v1, 0xA
    /* 9ED4 800196D4 1A00A3A7 */  sh         $v1, 0x1A($sp)
    /* 9ED8 800196D8 6A000396 */  lhu        $v1, 0x6A($s0)
    /* 9EDC 800196DC 21884000 */  addu       $s1, $v0, $zero
    /* 9EE0 800196E0 ECFF6324 */  addiu      $v1, $v1, -0x14
    /* 9EE4 800196E4 1C00A3A7 */  sh         $v1, 0x1C($sp)
    /* 9EE8 800196E8 6E000396 */  lhu        $v1, 0x6E($s0)
    /* 9EEC 800196EC 6C000696 */  lhu        $a2, 0x6C($s0)
    /* 9EF0 800196F0 08006324 */  addiu      $v1, $v1, 0x8
    /* 9EF4 800196F4 2330C300 */  subu       $a2, $a2, $v1
    /* 9EF8 800196F8 7A86000C */  jal        FETextRender_SetABR__Fib
    /* 9EFC 800196FC 1E00A6A7 */   sh        $a2, 0x1E($sp)
    /* 9F00 80019700 9400028E */  lw         $v0, 0x94($s0)
    /* 9F04 80019704 00000000 */  nop
    /* 9F08 80019708 13004010 */  beqz       $v0, .L80019758
    /* 9F0C 8001970C 02000224 */   addiu     $v0, $zero, 0x2
    /* 9F10 80019710 6A000396 */  lhu        $v1, 0x6A($s0)
    /* 9F14 80019714 66000596 */  lhu        $a1, 0x66($s0)
    /* 9F18 80019718 68000696 */  lhu        $a2, 0x68($s0)
    /* 9F1C 8001971C 21382002 */  addu       $a3, $s1, $zero
    /* 9F20 80019720 1000A0AF */  sw         $zero, 0x10($sp)
    /* 9F24 80019724 1400A2AF */  sw         $v0, 0x14($sp)
    /* 9F28 80019728 9000048E */  lw         $a0, 0x90($s0)
    /* 9F2C 8001972C 001C0300 */  sll        $v1, $v1, 16
    /* 9F30 80019730 431C0300 */  sra        $v1, $v1, 17
    /* 9F34 80019734 2128A300 */  addu       $a1, $a1, $v1
    /* 9F38 80019738 002C0500 */  sll        $a1, $a1, 16
    /* 9F3C 8001973C 032C0500 */  sra        $a1, $a1, 16
    /* 9F40 80019740 0800C624 */  addiu      $a2, $a2, 0x8
    /* 9F44 80019744 00340600 */  sll        $a2, $a2, 16
    /* 9F48 80019748 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 9F4C 8001974C 03340600 */   sra       $a2, $a2, 16
    /* 9F50 80019750 DB650008 */  j          .L8001976C
    /* 9F54 80019754 21200000 */   addu      $a0, $zero, $zero
  .L80019758:
    /* 9F58 80019758 9000048E */  lw         $a0, 0x90($s0)
    /* 9F5C 8001975C 1800A527 */  addiu      $a1, $sp, 0x18
    /* 9F60 80019760 C685000C */  jal        FETextRender_WordWrapTextRGB__FPcR4RECTi
    /* 9F64 80019764 21302002 */   addu      $a2, $s1, $zero
    /* 9F68 80019768 21200000 */  addu       $a0, $zero, $zero
  .L8001976C:
    /* 9F6C 8001976C 7A86000C */  jal        FETextRender_SetABR__Fib
    /* 9F70 80019770 21288000 */   addu      $a1, $a0, $zero
  .L80019774:
    /* 9F74 80019774 6E62000C */  jal        Draw__11tDialogBase
    /* 9F78 80019778 21200002 */   addu      $a0, $s0, $zero
    /* 9F7C 8001977C 2800BF8F */  lw         $ra, 0x28($sp)
    /* 9F80 80019780 2400B18F */  lw         $s1, 0x24($sp)
    /* 9F84 80019784 2000B08F */  lw         $s0, 0x20($sp)
    /* 9F88 80019788 0800E003 */  jr         $ra
    /* 9F8C 8001978C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Draw__20tDialogMessageString
