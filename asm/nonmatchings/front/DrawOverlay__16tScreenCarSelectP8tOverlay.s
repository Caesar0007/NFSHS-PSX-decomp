.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawOverlay__16tScreenCarSelectP8tOverlay, 0x89C

glabel DrawOverlay__16tScreenCarSelectP8tOverlay
    /* 2B500 8003AD00 C0FEBD27 */  addiu      $sp, $sp, -0x140
    /* 2B504 8003AD04 3001B2AF */  sw         $s2, 0x130($sp)
    /* 2B508 8003AD08 3401B3AF */  sw         $s3, 0x134($sp)
    /* 2B50C 8003AD0C 2198A000 */  addu       $s3, $a1, $zero
    /* 2B510 8003AD10 0180023C */  lui        $v0, %hi(D_80011AA4)
    /* 2B514 8003AD14 3801BFAF */  sw         $ra, 0x138($sp)
    /* 2B518 8003AD18 2C01B1AF */  sw         $s1, 0x12C($sp)
    /* 2B51C 8003AD1C 2801B0AF */  sw         $s0, 0x128($sp)
    /* 2B520 8003AD20 A41A4F24 */  addiu      $t7, $v0, %lo(D_80011AA4)
    /* 2B524 8003AD24 0300EC89 */  lwl        $t4, 0x3($t7)
    /* 2B528 8003AD28 0000EC99 */  lwr        $t4, 0x0($t7)
    /* 2B52C 8003AD2C 0400ED85 */  lh         $t5, 0x4($t7)
    /* 2B530 8003AD30 1B01ACAB */  swl        $t4, 0x11B($sp)
    /* 2B534 8003AD34 1801ACBB */  swr        $t4, 0x118($sp)
    /* 2B538 8003AD38 1C01ADA7 */  sh         $t5, 0x11C($sp)
    /* 2B53C 8003AD3C 0180023C */  lui        $v0, %hi(D_80011AAC)
    /* 2B540 8003AD40 AC1A4F24 */  addiu      $t7, $v0, %lo(D_80011AAC)
    /* 2B544 8003AD44 0300EC89 */  lwl        $t4, 0x3($t7)
    /* 2B548 8003AD48 0000EC99 */  lwr        $t4, 0x0($t7)
    /* 2B54C 8003AD4C 0400ED85 */  lh         $t5, 0x4($t7)
    /* 2B550 8003AD50 2301ACAB */  swl        $t4, 0x123($sp)
    /* 2B554 8003AD54 2001ACBB */  swr        $t4, 0x120($sp)
    /* 2B558 8003AD58 2401ADA7 */  sh         $t5, 0x124($sp)
    /* 2B55C 8003AD5C 08026012 */  beqz       $s3, .L8003B580
    /* 2B560 8003AD60 21908000 */   addu      $s2, $a0, $zero
    /* 2B564 8003AD64 6000428E */  lw         $v0, 0x60($s2)
    /* 2B568 8003AD68 3000A527 */  addiu      $a1, $sp, 0x30
    /* 2B56C 8003AD6C 68004484 */  lh         $a0, 0x68($v0)
    /* 2B570 8003AD70 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2B574 8003AD74 00000000 */  nop
    /* 2B578 8003AD78 09F84000 */  jalr       $v0
    /* 2B57C 8003AD7C 21204402 */   addu      $a0, $s2, $a0
    /* 2B580 8003AD80 21884000 */  addu       $s1, $v0, $zero
    /* 2B584 8003AD84 14006286 */  lh         $v0, 0x14($s3)
    /* 2B588 8003AD88 14006396 */  lhu        $v1, 0x14($s3)
    /* 2B58C 8003AD8C 12004010 */  beqz       $v0, .L8003ADD8
    /* 2B590 8003AD90 00000000 */   nop
    /* 2B594 8003AD94 12006296 */  lhu        $v0, 0x12($s3)
    /* 2B598 8003AD98 00000000 */  nop
    /* 2B59C 8003AD9C 18004300 */  mult       $v0, $v1
    /* 2B5A0 8003ADA0 10006296 */  lhu        $v0, 0x10($s3)
    /* 2B5A4 8003ADA4 12600000 */  mflo       $t4
    /* 2B5A8 8003ADA8 21104C00 */  addu       $v0, $v0, $t4
    /* 2B5AC 8003ADAC 100062A6 */  sh         $v0, 0x10($s3)
    /* 2B5B0 8003ADB0 00140200 */  sll        $v0, $v0, 16
    /* 2B5B4 8003ADB4 03140200 */  sra        $v0, $v0, 16
    /* 2B5B8 8003ADB8 0300401C */  bgtz       $v0, .L8003ADC8
    /* 2B5BC 8003ADBC 80004228 */   slti      $v0, $v0, 0x80
    /* 2B5C0 8003ADC0 75EB0008 */  j          .L8003ADD4
    /* 2B5C4 8003ADC4 100060A6 */   sh        $zero, 0x10($s3)
  .L8003ADC8:
    /* 2B5C8 8003ADC8 03004014 */  bnez       $v0, .L8003ADD8
    /* 2B5CC 8003ADCC 80000224 */   addiu     $v0, $zero, 0x80
    /* 2B5D0 8003ADD0 100062A6 */  sh         $v0, 0x10($s3)
  .L8003ADD4:
    /* 2B5D4 8003ADD4 140060A6 */  sh         $zero, 0x14($s3)
  .L8003ADD8:
    /* 2B5D8 8003ADD8 08006286 */  lh         $v0, 0x8($s3)
    /* 2B5DC 8003ADDC 00006386 */  lh         $v1, 0x0($s3)
    /* 2B5E0 8003ADE0 10006486 */  lh         $a0, 0x10($s3)
    /* 2B5E4 8003ADE4 23104300 */  subu       $v0, $v0, $v1
    /* 2B5E8 8003ADE8 18008200 */  mult       $a0, $v0
    /* 2B5EC 8003ADEC 00006396 */  lhu        $v1, 0x0($s3)
    /* 2B5F0 8003ADF0 12100000 */  mflo       $v0
    /* 2B5F4 8003ADF4 02004104 */  bgez       $v0, .L8003AE00
    /* 2B5F8 8003ADF8 00000000 */   nop
    /* 2B5FC 8003ADFC 7F004224 */  addiu      $v0, $v0, 0x7F
  .L8003AE00:
    /* 2B600 8003AE00 C3110200 */  sra        $v0, $v0, 7
    /* 2B604 8003AE04 21106200 */  addu       $v0, $v1, $v0
    /* 2B608 8003AE08 2000A2A7 */  sh         $v0, 0x20($sp)
    /* 2B60C 8003AE0C 0A006286 */  lh         $v0, 0xA($s3)
    /* 2B610 8003AE10 02006386 */  lh         $v1, 0x2($s3)
    /* 2B614 8003AE14 10006486 */  lh         $a0, 0x10($s3)
    /* 2B618 8003AE18 23104300 */  subu       $v0, $v0, $v1
    /* 2B61C 8003AE1C 18008200 */  mult       $a0, $v0
    /* 2B620 8003AE20 02006396 */  lhu        $v1, 0x2($s3)
    /* 2B624 8003AE24 12100000 */  mflo       $v0
    /* 2B628 8003AE28 02004104 */  bgez       $v0, .L8003AE34
    /* 2B62C 8003AE2C 00000000 */   nop
    /* 2B630 8003AE30 7F004224 */  addiu      $v0, $v0, 0x7F
  .L8003AE34:
    /* 2B634 8003AE34 C3110200 */  sra        $v0, $v0, 7
    /* 2B638 8003AE38 21106200 */  addu       $v0, $v1, $v0
    /* 2B63C 8003AE3C 2200A2A7 */  sh         $v0, 0x22($sp)
    /* 2B640 8003AE40 0C006286 */  lh         $v0, 0xC($s3)
    /* 2B644 8003AE44 04006386 */  lh         $v1, 0x4($s3)
    /* 2B648 8003AE48 10006486 */  lh         $a0, 0x10($s3)
    /* 2B64C 8003AE4C 23104300 */  subu       $v0, $v0, $v1
    /* 2B650 8003AE50 18008200 */  mult       $a0, $v0
    /* 2B654 8003AE54 04006396 */  lhu        $v1, 0x4($s3)
    /* 2B658 8003AE58 12100000 */  mflo       $v0
    /* 2B65C 8003AE5C 02004104 */  bgez       $v0, .L8003AE68
    /* 2B660 8003AE60 00000000 */   nop
    /* 2B664 8003AE64 7F004224 */  addiu      $v0, $v0, 0x7F
  .L8003AE68:
    /* 2B668 8003AE68 C3110200 */  sra        $v0, $v0, 7
    /* 2B66C 8003AE6C 21106200 */  addu       $v0, $v1, $v0
    /* 2B670 8003AE70 2400A2A7 */  sh         $v0, 0x24($sp)
    /* 2B674 8003AE74 0E006286 */  lh         $v0, 0xE($s3)
    /* 2B678 8003AE78 06006386 */  lh         $v1, 0x6($s3)
    /* 2B67C 8003AE7C 10006486 */  lh         $a0, 0x10($s3)
    /* 2B680 8003AE80 23104300 */  subu       $v0, $v0, $v1
    /* 2B684 8003AE84 18008200 */  mult       $a0, $v0
    /* 2B688 8003AE88 06006396 */  lhu        $v1, 0x6($s3)
    /* 2B68C 8003AE8C 12100000 */  mflo       $v0
    /* 2B690 8003AE90 02004104 */  bgez       $v0, .L8003AE9C
    /* 2B694 8003AE94 00000000 */   nop
    /* 2B698 8003AE98 7F004224 */  addiu      $v0, $v0, 0x7F
  .L8003AE9C:
    /* 2B69C 8003AE9C C3110200 */  sra        $v0, $v0, 7
    /* 2B6A0 8003AEA0 21106200 */  addu       $v0, $v1, $v0
    /* 2B6A4 8003AEA4 2600A2A7 */  sh         $v0, 0x26($sp)
    /* 2B6A8 8003AEA8 16006386 */  lh         $v1, 0x16($s3)
    /* 2B6AC 8003AEAC 00000000 */  nop
    /* 2B6B0 8003AEB0 0700622C */  sltiu      $v0, $v1, 0x7
    /* 2B6B4 8003AEB4 AC014010 */  beqz       $v0, .L8003B568
    /* 2B6B8 8003AEB8 0180023C */   lui       $v0, %hi(jtbl_80011AB8)
    /* 2B6BC 8003AEBC B81A4224 */  addiu      $v0, $v0, %lo(jtbl_80011AB8)
    /* 2B6C0 8003AEC0 80180300 */  sll        $v1, $v1, 2
    /* 2B6C4 8003AEC4 21186200 */  addu       $v1, $v1, $v0
    /* 2B6C8 8003AEC8 0000628C */  lw         $v0, 0x0($v1)
    /* 2B6CC 8003AECC 00000000 */  nop
    /* 2B6D0 8003AED0 08004000 */  jr         $v0
    /* 2B6D4 8003AED4 00000000 */   nop
  jlabel .L8003AED8
    /* 2B6D8 8003AED8 A3012012 */  beqz       $s1, .L8003B568
    /* 2B6DC 8003AEDC 2000A527 */   addiu     $a1, $sp, 0x20
    /* 2B6E0 8003AEE0 3000A483 */  lb         $a0, 0x30($sp)
    /* 2B6E4 8003AEE4 21300000 */  addu       $a2, $zero, $zero
    /* 2B6E8 8003AEE8 EC2F010C */  jal        DrawShape_NFS4RoundRectangle__FiR4RECTs
    /* 2B6EC 8003AEEC 21018424 */   addiu     $a0, $a0, 0x121
    /* 2B6F0 8003AEF0 5AED0008 */  j          .L8003B568
    /* 2B6F4 8003AEF4 00000000 */   nop
  jlabel .L8003AEF8
    /* 2B6F8 8003AEF8 2000A397 */  lhu        $v1, 0x20($sp)
    /* 2B6FC 8003AEFC 2200A697 */  lhu        $a2, 0x22($sp)
    /* 2B700 8003AF00 17000224 */  addiu      $v0, $zero, 0x17
    /* 2B704 8003AF04 2E00A2A7 */  sh         $v0, 0x2E($sp)
    /* 2B708 8003AF08 2600A297 */  lhu        $v0, 0x26($sp)
    /* 2B70C 8003AF0C 0F006524 */  addiu      $a1, $v1, 0xF
    /* 2B710 8003AF10 2110C200 */  addu       $v0, $a2, $v0
    /* 2B714 8003AF14 2400A397 */  lhu        $v1, 0x24($sp)
    /* 2B718 8003AF18 E2FF4224 */  addiu      $v0, $v0, -0x1E
    /* 2B71C 8003AF1C 2800A5A7 */  sh         $a1, 0x28($sp)
    /* 2B720 8003AF20 2A00A2A7 */  sh         $v0, 0x2A($sp)
    /* 2B724 8003AF24 E2FF6324 */  addiu      $v1, $v1, -0x1E
    /* 2B728 8003AF28 14002012 */  beqz       $s1, .L8003AF7C
    /* 2B72C 8003AF2C 2C00A3A7 */   sh        $v1, 0x2C($sp)
    /* 2B730 8003AF30 2128A300 */  addu       $a1, $a1, $v1
    /* 2B734 8003AF34 F4FFA524 */  addiu      $a1, $a1, -0xC
    /* 2B738 8003AF38 002C0500 */  sll        $a1, $a1, 16
    /* 2B73C 8003AF3C 032C0500 */  sra        $a1, $a1, 16
    /* 2B740 8003AF40 0200C624 */  addiu      $a2, $a2, 0x2
    /* 2B744 8003AF44 00340600 */  sll        $a2, $a2, 16
    /* 2B748 8003AF48 03340600 */  sra        $a2, $a2, 16
    /* 2B74C 8003AF4C 01000724 */  addiu      $a3, $zero, 0x1
    /* 2B750 8003AF50 3000A493 */  lbu        $a0, 0x30($sp)
    /* 2B754 8003AF54 2110E000 */  addu       $v0, $a3, $zero
    /* 2B758 8003AF58 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2B75C 8003AF5C 03000224 */  addiu      $v0, $zero, 0x3
    /* 2B760 8003AF60 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2B764 8003AF64 00260400 */  sll        $a0, $a0, 24
    /* 2B768 8003AF68 03260400 */  sra        $a0, $a0, 24
    /* 2B76C 8003AF6C 21018424 */  addiu      $a0, $a0, 0x121
    /* 2B770 8003AF70 00240400 */  sll        $a0, $a0, 16
    /* 2B774 8003AF74 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 2B778 8003AF78 03240400 */   sra       $a0, $a0, 16
  .L8003AF7C:
    /* 2B77C 8003AF7C 16006386 */  lh         $v1, 0x16($s3)
    /* 2B780 8003AF80 02000224 */  addiu      $v0, $zero, 0x2
    /* 2B784 8003AF84 05006210 */  beq        $v1, $v0, .L8003AF9C
    /* 2B788 8003AF88 03000224 */   addiu     $v0, $zero, 0x3
    /* 2B78C 8003AF8C 04006214 */  bne        $v1, $v0, .L8003AFA0
    /* 2B790 8003AF90 8C001024 */   addiu     $s0, $zero, 0x8C
    /* 2B794 8003AF94 E8EB0008 */  j          .L8003AFA0
    /* 2B798 8003AF98 8E001024 */   addiu     $s0, $zero, 0x8E
  .L8003AF9C:
    /* 2B79C 8003AF9C 8D001024 */  addiu      $s0, $zero, 0x8D
  .L8003AFA0:
    /* 2B7A0 8003AFA0 1F002012 */  beqz       $s1, .L8003B020
    /* 2B7A4 8003AFA4 02000224 */   addiu     $v0, $zero, 0x2
    /* 2B7A8 8003AFA8 16006386 */  lh         $v1, 0x16($s3)
    /* 2B7AC 8003AFAC 00000000 */  nop
    /* 2B7B0 8003AFB0 04006214 */  bne        $v1, $v0, .L8003AFC4
    /* 2B7B4 8003AFB4 BEBE1134 */   ori       $s1, $zero, 0xBEBE
    /* 2B7B8 8003AFB8 5000A78F */  lw         $a3, 0x50($sp)
    /* 2B7BC 8003AFBC 0CEC0008 */  j          .L8003B030
    /* 2B7C0 8003AFC0 2300123C */   lui       $s2, (0x232323 >> 16)
  .L8003AFC4:
    /* 2B7C4 8003AFC4 03000224 */  addiu      $v0, $zero, 0x3
    /* 2B7C8 8003AFC8 0F006214 */  bne        $v1, $v0, .L8003B008
    /* 2B7CC 8003AFCC 1180023C */   lui       $v0, %hi(D_80114729)
    /* 2B7D0 8003AFD0 0580023C */  lui        $v0, %hi(menuDefs)
    /* 2B7D4 8003AFD4 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 2B7D8 8003AFD8 00000000 */  nop
    /* 2B7DC 8003AFDC 3C1F4284 */  lh         $v0, 0x1F3C($v0)
    /* 2B7E0 8003AFE0 00000000 */  nop
    /* 2B7E4 8003AFE4 40100200 */  sll        $v0, $v0, 1
    /* 2B7E8 8003AFE8 2110A203 */  addu       $v0, $sp, $v0
    /* 2B7EC 8003AFEC 18014284 */  lh         $v0, 0x118($v0)
    /* 2B7F0 8003AFF0 00000000 */  nop
    /* 2B7F4 8003AFF4 80100200 */  sll        $v0, $v0, 2
    /* 2B7F8 8003AFF8 2110A203 */  addu       $v0, $sp, $v0
    /* 2B7FC 8003AFFC 5000478C */  lw         $a3, 0x50($v0)
    /* 2B800 8003B000 0CEC0008 */  j          .L8003B030
    /* 2B804 8003B004 2300123C */   lui       $s2, (0x232323 >> 16)
  .L8003B008:
    /* 2B808 8003B008 29474590 */  lbu        $a1, %lo(D_80114729)($v0)
    /* 2B80C 8003B00C 1180043C */  lui        $a0, %hi(carManager)
    /* 2B810 8003B010 D158000C */  jal        CalcUsedPrice__11tCarManagers
    /* 2B814 8003B014 74428424 */   addiu     $a0, $a0, %lo(carManager)
    /* 2B818 8003B018 0BEC0008 */  j          .L8003B02C
    /* 2B81C 8003B01C 21384000 */   addu      $a3, $v0, $zero
  .L8003B020:
    /* 2B820 8003B020 2300113C */  lui        $s1, (0x232323 >> 16)
    /* 2B824 8003B024 23233136 */  ori        $s1, $s1, (0x232323 & 0xFFFF)
    /* 2B828 8003B028 21380000 */  addu       $a3, $zero, $zero
  .L8003B02C:
    /* 2B82C 8003B02C 2300123C */  lui        $s2, (0x232323 >> 16)
  .L8003B030:
    /* 2B830 8003B030 23235236 */  ori        $s2, $s2, (0x232323 & 0xFFFF)
    /* 2B834 8003B034 2800A487 */  lh         $a0, 0x28($sp)
    /* 2B838 8003B038 2C00A287 */  lh         $v0, 0x2C($sp)
    /* 2B83C 8003B03C 2A00A587 */  lh         $a1, 0x2A($sp)
    /* 2B840 8003B040 06000624 */  addiu      $a2, $zero, 0x6
    /* 2B844 8003B044 1000B1AF */  sw         $s1, 0x10($sp)
    /* 2B848 8003B048 1400B2AF */  sw         $s2, 0x14($sp)
    /* 2B84C 8003B04C 21208200 */  addu       $a0, $a0, $v0
    /* 2B850 8003B050 F4FF8424 */  addiu      $a0, $a0, -0xC
    /* 2B854 8003B054 FCE5000C */  jal        DrawMoney__Fiiilii
    /* 2B858 8003B058 0300A524 */   addiu     $a1, $a1, 0x3
    /* 2B85C 8003B05C 21200002 */  addu       $a0, $s0, $zero
    /* 2B860 8003B060 01000724 */  addiu      $a3, $zero, 0x1
    /* 2B864 8003B064 2188E000 */  addu       $s1, $a3, $zero
    /* 2B868 8003B068 2C00A297 */  lhu        $v0, 0x2C($sp)
    /* 2B86C 8003B06C 2800A597 */  lhu        $a1, 0x28($sp)
    /* 2B870 8003B070 2A00A697 */  lhu        $a2, 0x2A($sp)
    /* 2B874 8003B074 03001024 */  addiu      $s0, $zero, 0x3
    /* 2B878 8003B078 1000B1AF */  sw         $s1, 0x10($sp)
    /* 2B87C 8003B07C 1400B0AF */  sw         $s0, 0x14($sp)
    /* 2B880 8003B080 00140200 */  sll        $v0, $v0, 16
    /* 2B884 8003B084 43140200 */  sra        $v0, $v0, 17
    /* 2B888 8003B088 2128A200 */  addu       $a1, $a1, $v0
    /* 2B88C 8003B08C 002C0500 */  sll        $a1, $a1, 16
    /* 2B890 8003B090 032C0500 */  sra        $a1, $a1, 16
    /* 2B894 8003B094 2130D000 */  addu       $a2, $a2, $s0
    /* 2B898 8003B098 00340600 */  sll        $a2, $a2, 16
    /* 2B89C 8003B09C 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 2B8A0 8003B0A0 03340600 */   sra       $a2, $a2, 16
    /* 2B8A4 8003B0A4 2800A487 */  lh         $a0, 0x28($sp)
    /* 2B8A8 8003B0A8 2C00A387 */  lh         $v1, 0x2C($sp)
    /* 2B8AC 8003B0AC 2A00A587 */  lh         $a1, 0x2A($sp)
    /* 2B8B0 8003B0B0 BEBE0234 */  ori        $v0, $zero, 0xBEBE
    /* 2B8B4 8003B0B4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2B8B8 8003B0B8 1180023C */  lui        $v0, %hi(D_80114AEC)
    /* 2B8BC 8003B0BC EC4A478C */  lw         $a3, %lo(D_80114AEC)($v0)
    /* 2B8C0 8003B0C0 09000624 */  addiu      $a2, $zero, 0x9
    /* 2B8C4 8003B0C4 1400B2AF */  sw         $s2, 0x14($sp)
    /* 2B8C8 8003B0C8 21208300 */  addu       $a0, $a0, $v1
    /* 2B8CC 8003B0CC F4FF8424 */  addiu      $a0, $a0, -0xC
    /* 2B8D0 8003B0D0 FCE5000C */  jal        DrawMoney__Fiiilii
    /* 2B8D4 8003B0D4 0D00A524 */   addiu     $a1, $a1, 0xD
    /* 2B8D8 8003B0D8 7B000424 */  addiu      $a0, $zero, 0x7B
    /* 2B8DC 8003B0DC 2C00A297 */  lhu        $v0, 0x2C($sp)
    /* 2B8E0 8003B0E0 2800A597 */  lhu        $a1, 0x28($sp)
    /* 2B8E4 8003B0E4 2A00A697 */  lhu        $a2, 0x2A($sp)
    /* 2B8E8 8003B0E8 01000724 */  addiu      $a3, $zero, 0x1
    /* 2B8EC 8003B0EC 1000B1AF */  sw         $s1, 0x10($sp)
    /* 2B8F0 8003B0F0 1400B0AF */  sw         $s0, 0x14($sp)
    /* 2B8F4 8003B0F4 00140200 */  sll        $v0, $v0, 16
    /* 2B8F8 8003B0F8 43140200 */  sra        $v0, $v0, 17
    /* 2B8FC 8003B0FC 2128A200 */  addu       $a1, $a1, $v0
    /* 2B900 8003B100 002C0500 */  sll        $a1, $a1, 16
    /* 2B904 8003B104 032C0500 */  sra        $a1, $a1, 16
    /* 2B908 8003B108 0D00C624 */  addiu      $a2, $a2, 0xD
    /* 2B90C 8003B10C 00340600 */  sll        $a2, $a2, 16
    /* 2B910 8003B110 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 2B914 8003B114 03340600 */   sra       $a2, $a2, 16
    /* 2B918 8003B118 6F30010C */  jal        DrawShape_NFS4Rectangle__FR4RECT
    /* 2B91C 8003B11C 2800A427 */   addiu     $a0, $sp, 0x28
    /* 2B920 8003B120 21200000 */  addu       $a0, $zero, $zero
    /* 2B924 8003B124 2000A587 */  lh         $a1, 0x20($sp)
    /* 2B928 8003B128 2200A687 */  lh         $a2, 0x22($sp)
    /* 2B92C 8003B12C 2400A787 */  lh         $a3, 0x24($sp)
    /* 2B930 8003B130 0A000224 */  addiu      $v0, $zero, 0xA
    /* 2B934 8003B134 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 2B938 8003B138 1000A2AF */   sw        $v0, 0x10($sp)
    /* 2B93C 8003B13C 5AED0008 */  j          .L8003B568
    /* 2B940 8003B140 00000000 */   nop
  jlabel .L8003B144
    /* 2B944 8003B144 21800000 */  addu       $s0, $zero, $zero
    /* 2B948 8003B148 00141000 */  sll        $v0, $s0, 16
  .L8003B14C:
    /* 2B94C 8003B14C 03340200 */  sra        $a2, $v0, 16
    /* 2B950 8003B150 0300C228 */  slti       $v0, $a2, 0x3
    /* 2B954 8003B154 04014010 */  beqz       $v0, .L8003B568
    /* 2B958 8003B158 40100600 */   sll       $v0, $a2, 1
    /* 2B95C 8003B15C 2001A327 */  addiu      $v1, $sp, 0x120
    /* 2B960 8003B160 21286200 */  addu       $a1, $v1, $v0
    /* 2B964 8003B164 F400AB93 */  lbu        $t3, 0xF4($sp)
    /* 2B968 8003B168 0000A284 */  lh         $v0, 0x0($a1)
    /* 2B96C 8003B16C 00000000 */  nop
    /* 2B970 8003B170 24106201 */  and        $v0, $t3, $v0
    /* 2B974 8003B174 02004014 */  bnez       $v0, .L8003B180
    /* 2B978 8003B178 21200000 */   addu      $a0, $zero, $zero
    /* 2B97C 8003B17C 60000424 */  addiu      $a0, $zero, 0x60
  .L8003B180:
    /* 2B980 8003B180 6666033C */  lui        $v1, (0x66666667 >> 16)
    /* 2B984 8003B184 67666334 */  ori        $v1, $v1, (0x66666667 & 0xFFFF)
    /* 2B988 8003B188 BEBE0234 */  ori        $v0, $zero, 0xBEBE
    /* 2B98C 8003B18C 01001026 */  addiu      $s0, $s0, 0x1
    /* 2B990 8003B190 0401A2AF */  sw         $v0, 0x104($sp)
    /* 2B994 8003B194 1480023C */  lui        $v0, %hi(ticks)
    /* 2B998 8003B198 0000A584 */  lh         $a1, 0x0($a1)
    /* 2B99C 8003B19C 2000AA87 */  lh         $t2, 0x20($sp)
    /* 2B9A0 8003B1A0 2200A787 */  lh         $a3, 0x22($sp)
    /* 2B9A4 8003B1A4 ACDC498C */  lw         $t1, %lo(ticks)($v0)
    /* 2B9A8 8003B1A8 01000224 */  addiu      $v0, $zero, 0x1
    /* 2B9AC 8003B1AC 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2B9B0 8003B1B0 0001A227 */  addiu      $v0, $sp, 0x100
    /* 2B9B4 8003B1B4 1000A4AF */  sw         $a0, 0x10($sp)
    /* 2B9B8 8003B1B8 80200600 */  sll        $a0, $a2, 2
    /* 2B9BC 8003B1BC 03410900 */  sra        $t0, $t1, 4
    /* 2B9C0 8003B1C0 18000301 */  mult       $t0, $v1
    /* 2B9C4 8003B1C4 21208600 */  addu       $a0, $a0, $a2
    /* 2B9C8 8003B1C8 C0300400 */  sll        $a2, $a0, 3
    /* 2B9CC 8003B1CC 2100C624 */  addiu      $a2, $a2, 0x21
    /* 2B9D0 8003B1D0 40200400 */  sll        $a0, $a0, 1
    /* 2B9D4 8003B1D4 1800A2AF */  sw         $v0, 0x18($sp)
    /* 2B9D8 8003B1D8 24286501 */  and        $a1, $t3, $a1
    /* 2B9DC 8003B1DC 0100A52C */  sltiu      $a1, $a1, 0x1
    /* 2B9E0 8003B1E0 1004A534 */  ori        $a1, $a1, 0x410
    /* 2B9E4 8003B1E4 21304601 */  addu       $a2, $t2, $a2
    /* 2B9E8 8003B1E8 0600E724 */  addiu      $a3, $a3, 0x6
    /* 2B9EC 8003B1EC C34F0900 */  sra        $t1, $t1, 31
    /* 2B9F0 8003B1F0 10600000 */  mfhi       $t4
    /* 2B9F4 8003B1F4 83180C00 */  sra        $v1, $t4, 2
    /* 2B9F8 8003B1F8 23186900 */  subu       $v1, $v1, $t1
    /* 2B9FC 8003B1FC 80100300 */  sll        $v0, $v1, 2
    /* 2BA00 8003B200 21104300 */  addu       $v0, $v0, $v1
    /* 2BA04 8003B204 40100200 */  sll        $v0, $v0, 1
    /* 2BA08 8003B208 23400201 */  subu       $t0, $t0, $v0
    /* 2BA0C 8003B20C 62000825 */  addiu      $t0, $t0, 0x62
    /* 2BA10 8003B210 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2BA14 8003B214 21208800 */   addu      $a0, $a0, $t0
    /* 2BA18 8003B218 53EC0008 */  j          .L8003B14C
    /* 2BA1C 8003B21C 00141000 */   sll       $v0, $s0, 16
  jlabel .L8003B220
    /* 2BA20 8003B220 10006386 */  lh         $v1, 0x10($s3)
    /* 2BA24 8003B224 80000224 */  addiu      $v0, $zero, 0x80
    /* 2BA28 8003B228 92006214 */  bne        $v1, $v0, .L8003B474
    /* 2BA2C 8003B22C 21800000 */   addu      $s0, $zero, $zero
    /* 2BA30 8003B230 00141000 */  sll        $v0, $s0, 16
  .L8003B234:
    /* 2BA34 8003B234 03340200 */  sra        $a2, $v0, 16
    /* 2BA38 8003B238 0300C228 */  slti       $v0, $a2, 0x3
    /* 2BA3C 8003B23C 32004010 */  beqz       $v0, .L8003B308
    /* 2BA40 8003B240 40100600 */   sll       $v0, $a2, 1
    /* 2BA44 8003B244 2001A327 */  addiu      $v1, $sp, 0x120
    /* 2BA48 8003B248 21286200 */  addu       $a1, $v1, $v0
    /* 2BA4C 8003B24C F400AB93 */  lbu        $t3, 0xF4($sp)
    /* 2BA50 8003B250 0000A284 */  lh         $v0, 0x0($a1)
    /* 2BA54 8003B254 00000000 */  nop
    /* 2BA58 8003B258 24106201 */  and        $v0, $t3, $v0
    /* 2BA5C 8003B25C 02004014 */  bnez       $v0, .L8003B268
    /* 2BA60 8003B260 21200000 */   addu      $a0, $zero, $zero
    /* 2BA64 8003B264 60000424 */  addiu      $a0, $zero, 0x60
  .L8003B268:
    /* 2BA68 8003B268 6666033C */  lui        $v1, (0x66666667 >> 16)
    /* 2BA6C 8003B26C 67666334 */  ori        $v1, $v1, (0x66666667 & 0xFFFF)
    /* 2BA70 8003B270 BEBE0234 */  ori        $v0, $zero, 0xBEBE
    /* 2BA74 8003B274 01001026 */  addiu      $s0, $s0, 0x1
    /* 2BA78 8003B278 0401A2AF */  sw         $v0, 0x104($sp)
    /* 2BA7C 8003B27C 1480023C */  lui        $v0, %hi(ticks)
    /* 2BA80 8003B280 0000A584 */  lh         $a1, 0x0($a1)
    /* 2BA84 8003B284 2000AA87 */  lh         $t2, 0x20($sp)
    /* 2BA88 8003B288 2200A787 */  lh         $a3, 0x22($sp)
    /* 2BA8C 8003B28C ACDC498C */  lw         $t1, %lo(ticks)($v0)
    /* 2BA90 8003B290 01000224 */  addiu      $v0, $zero, 0x1
    /* 2BA94 8003B294 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2BA98 8003B298 0001A227 */  addiu      $v0, $sp, 0x100
    /* 2BA9C 8003B29C 1000A4AF */  sw         $a0, 0x10($sp)
    /* 2BAA0 8003B2A0 80200600 */  sll        $a0, $a2, 2
    /* 2BAA4 8003B2A4 03410900 */  sra        $t0, $t1, 4
    /* 2BAA8 8003B2A8 18000301 */  mult       $t0, $v1
    /* 2BAAC 8003B2AC 21208600 */  addu       $a0, $a0, $a2
    /* 2BAB0 8003B2B0 C0300400 */  sll        $a2, $a0, 3
    /* 2BAB4 8003B2B4 8500C624 */  addiu      $a2, $a2, 0x85
    /* 2BAB8 8003B2B8 40200400 */  sll        $a0, $a0, 1
    /* 2BABC 8003B2BC 1800A2AF */  sw         $v0, 0x18($sp)
    /* 2BAC0 8003B2C0 24286501 */  and        $a1, $t3, $a1
    /* 2BAC4 8003B2C4 0100A52C */  sltiu      $a1, $a1, 0x1
    /* 2BAC8 8003B2C8 1004A534 */  ori        $a1, $a1, 0x410
    /* 2BACC 8003B2CC 21304601 */  addu       $a2, $t2, $a2
    /* 2BAD0 8003B2D0 0600E724 */  addiu      $a3, $a3, 0x6
    /* 2BAD4 8003B2D4 C34F0900 */  sra        $t1, $t1, 31
    /* 2BAD8 8003B2D8 10600000 */  mfhi       $t4
    /* 2BADC 8003B2DC 83180C00 */  sra        $v1, $t4, 2
    /* 2BAE0 8003B2E0 23186900 */  subu       $v1, $v1, $t1
    /* 2BAE4 8003B2E4 80100300 */  sll        $v0, $v1, 2
    /* 2BAE8 8003B2E8 21104300 */  addu       $v0, $v0, $v1
    /* 2BAEC 8003B2EC 40100200 */  sll        $v0, $v0, 1
    /* 2BAF0 8003B2F0 23400201 */  subu       $t0, $t0, $v0
    /* 2BAF4 8003B2F4 62000825 */  addiu      $t0, $t0, 0x62
    /* 2BAF8 8003B2F8 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2BAFC 8003B2FC 21208800 */   addu      $a0, $a0, $t0
    /* 2BB00 8003B300 8DEC0008 */  j          .L8003B234
    /* 2BB04 8003B304 00141000 */   sll       $v0, $s0, 16
  .L8003B308:
    /* 2BB08 8003B308 02000724 */  addiu      $a3, $zero, 0x2
    /* 2BB0C 8003B30C 0580103C */  lui        $s0, %hi(menuDefs)
    /* 2BB10 8003B310 2400A497 */  lhu        $a0, 0x24($sp)
    /* 2BB14 8003B314 2000A397 */  lhu        $v1, 0x20($sp)
    /* 2BB18 8003B318 2200A297 */  lhu        $v0, 0x22($sp)
    /* 2BB1C 8003B31C 002C0400 */  sll        $a1, $a0, 16
    /* 2BB20 8003B320 432C0500 */  sra        $a1, $a1, 17
    /* 2BB24 8003B324 21286500 */  addu       $a1, $v1, $a1
    /* 2BB28 8003B328 002C0500 */  sll        $a1, $a1, 16
    /* 2BB2C 8003B32C 032C0500 */  sra        $a1, $a1, 16
    /* 2BB30 8003B330 18004624 */  addiu      $a2, $v0, 0x18
    /* 2BB34 8003B334 00340600 */  sll        $a2, $a2, 16
    /* 2BB38 8003B338 03340600 */  sra        $a2, $a2, 16
    /* 2BB3C 8003B33C 23004224 */  addiu      $v0, $v0, 0x23
    /* 2BB40 8003B340 2A00A2A7 */  sh         $v0, 0x2A($sp)
    /* 2BB44 8003B344 2600A297 */  lhu        $v0, 0x26($sp)
    /* 2BB48 8003B348 1E006324 */  addiu      $v1, $v1, 0x1E
    /* 2BB4C 8003B34C 2800A3A7 */  sh         $v1, 0x28($sp)
    /* 2BB50 8003B350 581A038E */  lw         $v1, %lo(menuDefs)($s0)
    /* 2BB54 8003B354 C4FF8424 */  addiu      $a0, $a0, -0x3C
    /* 2BB58 8003B358 2C00A4A7 */  sh         $a0, 0x2C($sp)
    /* 2BB5C 8003B35C B5FF4224 */  addiu      $v0, $v0, -0x4B
    /* 2BB60 8003B360 2E00A2A7 */  sh         $v0, 0x2E($sp)
    /* 2BB64 8003B364 3C1F648C */  lw         $a0, 0x1F3C($v1)
    /* 2BB68 8003B368 2110E000 */  addu       $v0, $a3, $zero
    /* 2BB6C 8003B36C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2BB70 8003B370 03000224 */  addiu      $v0, $zero, 0x3
    /* 2BB74 8003B374 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2BB78 8003B378 96008424 */  addiu      $a0, $a0, 0x96
    /* 2BB7C 8003B37C 00240400 */  sll        $a0, $a0, 16
    /* 2BB80 8003B380 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 2BB84 8003B384 03240400 */   sra       $a0, $a0, 16
    /* 2BB88 8003B388 581A028E */  lw         $v0, %lo(menuDefs)($s0)
    /* 2BB8C 8003B38C 00000000 */  nop
    /* 2BB90 8003B390 3C1F4284 */  lh         $v0, 0x1F3C($v0)
    /* 2BB94 8003B394 00000000 */  nop
    /* 2BB98 8003B398 AF004424 */  addiu      $a0, $v0, 0xAF
    /* 2BB9C 8003B39C B0000224 */  addiu      $v0, $zero, 0xB0
    /* 2BBA0 8003B3A0 08008214 */  bne        $a0, $v0, .L8003B3C4
    /* 2BBA4 8003B3A4 0C000224 */   addiu     $v0, $zero, 0xC
    /* 2BBA8 8003B3A8 3000A383 */  lb         $v1, 0x30($sp)
    /* 2BBAC 8003B3AC 00000000 */  nop
    /* 2BBB0 8003B3B0 03006210 */  beq        $v1, $v0, .L8003B3C0
    /* 2BBB4 8003B3B4 0A000224 */   addiu     $v0, $zero, 0xA
    /* 2BBB8 8003B3B8 03006214 */  bne        $v1, $v0, .L8003B3C8
    /* 2BBBC 8003B3BC 00240400 */   sll       $a0, $a0, 16
  .L8003B3C0:
    /* 2BBC0 8003B3C0 41000424 */  addiu      $a0, $zero, 0x41
  .L8003B3C4:
    /* 2BBC4 8003B3C4 00240400 */  sll        $a0, $a0, 16
  .L8003B3C8:
    /* 2BBC8 8003B3C8 03240400 */  sra        $a0, $a0, 16
    /* 2BBCC 8003B3CC 2800A527 */  addiu      $a1, $sp, 0x28
    /* 2BBD0 8003B3D0 02000624 */  addiu      $a2, $zero, 0x2
    /* 2BBD4 8003B3D4 2386000C */  jal        FETextRender_WordWrap__FsR4RECT14tMenuTextState13tMenuTextType
    /* 2BBD8 8003B3D8 08000724 */   addiu     $a3, $zero, 0x8
    /* 2BBDC 8003B3DC 0580023C */  lui        $v0, %hi(menuDefs)
    /* 2BBE0 8003B3E0 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 2BBE4 8003B3E4 00000000 */  nop
    /* 2BBE8 8003B3E8 3C1F4284 */  lh         $v0, 0x1F3C($v0)
    /* 2BBEC 8003B3EC 00000000 */  nop
    /* 2BBF0 8003B3F0 40100200 */  sll        $v0, $v0, 1
    /* 2BBF4 8003B3F4 2118A203 */  addu       $v1, $sp, $v0
    /* 2BBF8 8003B3F8 F400A293 */  lbu        $v0, 0xF4($sp)
    /* 2BBFC 8003B3FC 20016384 */  lh         $v1, 0x120($v1)
    /* 2BC00 8003B400 00000000 */  nop
    /* 2BC04 8003B404 24104300 */  and        $v0, $v0, $v1
    /* 2BC08 8003B408 07004014 */  bnez       $v0, .L8003B428
    /* 2BC0C 8003B40C A0001024 */   addiu     $s0, $zero, 0xA0
    /* 2BC10 8003B410 1480023C */  lui        $v0, %hi(D_8013E8A1)
    /* 2BC14 8003B414 A1E84390 */  lbu        $v1, %lo(D_8013E8A1)($v0)
    /* 2BC18 8003B418 23000224 */  addiu      $v0, $zero, 0x23
    /* 2BC1C 8003B41C 02006214 */  bne        $v1, $v0, .L8003B428
    /* 2BC20 8003B420 9E001024 */   addiu     $s0, $zero, 0x9E
    /* 2BC24 8003B424 9F001024 */  addiu      $s0, $zero, 0x9F
  .L8003B428:
    /* 2BC28 8003B428 21200002 */  addu       $a0, $s0, $zero
    /* 2BC2C 8003B42C 01000724 */  addiu      $a3, $zero, 0x1
    /* 2BC30 8003B430 2000A597 */  lhu        $a1, 0x20($sp)
    /* 2BC34 8003B434 2400A397 */  lhu        $v1, 0x24($sp)
    /* 2BC38 8003B438 2200A697 */  lhu        $a2, 0x22($sp)
    /* 2BC3C 8003B43C 2600A897 */  lhu        $t0, 0x26($sp)
    /* 2BC40 8003B440 02000224 */  addiu      $v0, $zero, 0x2
    /* 2BC44 8003B444 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2BC48 8003B448 03000224 */  addiu      $v0, $zero, 0x3
    /* 2BC4C 8003B44C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2BC50 8003B450 2128A300 */  addu       $a1, $a1, $v1
    /* 2BC54 8003B454 F1FFA524 */  addiu      $a1, $a1, -0xF
    /* 2BC58 8003B458 002C0500 */  sll        $a1, $a1, 16
    /* 2BC5C 8003B45C 032C0500 */  sra        $a1, $a1, 16
    /* 2BC60 8003B460 2130C800 */  addu       $a2, $a2, $t0
    /* 2BC64 8003B464 ECFFC624 */  addiu      $a2, $a2, -0x14
    /* 2BC68 8003B468 00340600 */  sll        $a2, $a2, 16
    /* 2BC6C 8003B46C 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 2BC70 8003B470 03340600 */   sra       $a2, $a2, 16
  .L8003B474:
    /* 2BC74 8003B474 2400A287 */  lh         $v0, 0x24($sp)
    /* 2BC78 8003B478 2400A597 */  lhu        $a1, 0x24($sp)
    /* 2BC7C 8003B47C 43004228 */  slti       $v0, $v0, 0x43
    /* 2BC80 8003B480 39004014 */  bnez       $v0, .L8003B568
    /* 2BC84 8003B484 00000000 */   nop
    /* 2BC88 8003B488 2600A287 */  lh         $v0, 0x26($sp)
    /* 2BC8C 8003B48C 2600A397 */  lhu        $v1, 0x26($sp)
    /* 2BC90 8003B490 33004228 */  slti       $v0, $v0, 0x33
    /* 2BC94 8003B494 34004014 */  bnez       $v0, .L8003B568
    /* 2BC98 8003B498 2800A427 */   addiu     $a0, $sp, 0x28
    /* 2BC9C 8003B49C E2FFA224 */  addiu      $v0, $a1, -0x1E
    /* 2BCA0 8003B4A0 2C00A2A7 */  sh         $v0, 0x2C($sp)
    /* 2BCA4 8003B4A4 E7FF6224 */  addiu      $v0, $v1, -0x19
    /* 2BCA8 8003B4A8 2E00A2A7 */  sh         $v0, 0x2E($sp)
    /* 2BCAC 8003B4AC 2000A297 */  lhu        $v0, 0x20($sp)
    /* 2BCB0 8003B4B0 2200A397 */  lhu        $v1, 0x22($sp)
    /* 2BCB4 8003B4B4 0F004224 */  addiu      $v0, $v0, 0xF
    /* 2BCB8 8003B4B8 14006324 */  addiu      $v1, $v1, 0x14
    /* 2BCBC 8003B4BC 2800A2A7 */  sh         $v0, 0x28($sp)
    /* 2BCC0 8003B4C0 6F30010C */  jal        DrawShape_NFS4Rectangle__FR4RECT
    /* 2BCC4 8003B4C4 2A00A3A7 */   sh        $v1, 0x2A($sp)
    /* 2BCC8 8003B4C8 5AED0008 */  j          .L8003B568
    /* 2BCCC 8003B4CC 00000000 */   nop
  jlabel .L8003B4D0
    /* 2BCD0 8003B4D0 1B002016 */  bnez       $s1, .L8003B540
    /* 2BCD4 8003B4D4 21204002 */   addu      $a0, $s2, $zero
    /* 2BCD8 8003B4D8 21800000 */  addu       $s0, $zero, $zero
    /* 2BCDC 8003B4DC 3000A627 */  addiu      $a2, $sp, 0x30
    /* 2BCE0 8003B4E0 21200000 */  addu       $a0, $zero, $zero
  .L8003B4E4:
    /* 2BCE4 8003B4E4 00141000 */  sll        $v0, $s0, 16
    /* 2BCE8 8003B4E8 032C0200 */  sra        $a1, $v0, 16
  .L8003B4EC:
    /* 2BCEC 8003B4EC 00140400 */  sll        $v0, $a0, 16
    /* 2BCF0 8003B4F0 03140200 */  sra        $v0, $v0, 16
    /* 2BCF4 8003B4F4 80180200 */  sll        $v1, $v0, 2
    /* 2BCF8 8003B4F8 21186200 */  addu       $v1, $v1, $v0
    /* 2BCFC 8003B4FC 2118A300 */  addu       $v1, $a1, $v1
    /* 2BD00 8003B500 2118C300 */  addu       $v1, $a2, $v1
    /* 2BD04 8003B504 01008224 */  addiu      $v0, $a0, 0x1
    /* 2BD08 8003B508 21204000 */  addu       $a0, $v0, $zero
    /* 2BD0C 8003B50C 00140200 */  sll        $v0, $v0, 16
    /* 2BD10 8003B510 03140200 */  sra        $v0, $v0, 16
    /* 2BD14 8003B514 04004228 */  slti       $v0, $v0, 0x4
    /* 2BD18 8003B518 F4FF4014 */  bnez       $v0, .L8003B4EC
    /* 2BD1C 8003B51C 300060A0 */   sb        $zero, 0x30($v1)
    /* 2BD20 8003B520 01000226 */  addiu      $v0, $s0, 0x1
    /* 2BD24 8003B524 21804000 */  addu       $s0, $v0, $zero
    /* 2BD28 8003B528 00140200 */  sll        $v0, $v0, 16
    /* 2BD2C 8003B52C 03140200 */  sra        $v0, $v0, 16
    /* 2BD30 8003B530 05004228 */  slti       $v0, $v0, 0x5
    /* 2BD34 8003B534 EBFF4014 */  bnez       $v0, .L8003B4E4
    /* 2BD38 8003B538 21200000 */   addu      $a0, $zero, $zero
    /* 2BD3C 8003B53C 21204002 */  addu       $a0, $s2, $zero
  .L8003B540:
    /* 2BD40 8003B540 3000A527 */  addiu      $a1, $sp, 0x30
    /* 2BD44 8003B544 2000A697 */  lhu        $a2, 0x20($sp)
    /* 2BD48 8003B548 2200A797 */  lhu        $a3, 0x22($sp)
    /* 2BD4C 8003B54C 0D00C624 */  addiu      $a2, $a2, 0xD
    /* 2BD50 8003B550 00340600 */  sll        $a2, $a2, 16
    /* 2BD54 8003B554 03340600 */  sra        $a2, $a2, 16
    /* 2BD58 8003B558 0400E724 */  addiu      $a3, $a3, 0x4
    /* 2BD5C 8003B55C 003C0700 */  sll        $a3, $a3, 16
    /* 2BD60 8003B560 9BF1000C */  jal        DrawSliders__16tScreenCarSelectR8tCarInfoss
    /* 2BD64 8003B564 033C0700 */   sra       $a3, $a3, 16
  .L8003B568:
    /* 2BD68 8003B568 16006286 */  lh         $v0, 0x16($s3)
    /* 2BD6C 8003B56C 00000000 */  nop
    /* 2BD70 8003B570 03004010 */  beqz       $v0, .L8003B580
    /* 2BD74 8003B574 2000A427 */   addiu     $a0, $sp, 0x20
    /* 2BD78 8003B578 3731010C */  jal        DrawShape_NFS4TransRectangle__FR4RECTs
    /* 2BD7C 8003B57C 01000524 */   addiu     $a1, $zero, 0x1
  .L8003B580:
    /* 2BD80 8003B580 3801BF8F */  lw         $ra, 0x138($sp)
    /* 2BD84 8003B584 3401B38F */  lw         $s3, 0x134($sp)
    /* 2BD88 8003B588 3001B28F */  lw         $s2, 0x130($sp)
    /* 2BD8C 8003B58C 2C01B18F */  lw         $s1, 0x12C($sp)
    /* 2BD90 8003B590 2801B08F */  lw         $s0, 0x128($sp)
    /* 2BD94 8003B594 0800E003 */  jr         $ra
    /* 2BD98 8003B598 4001BD27 */   addiu     $sp, $sp, 0x140
endlabel DrawOverlay__16tScreenCarSelectP8tOverlay
