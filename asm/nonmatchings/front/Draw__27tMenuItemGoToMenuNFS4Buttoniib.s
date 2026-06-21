.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__27tMenuItemGoToMenuNFS4Buttoniib, 0x27C

glabel Draw__27tMenuItemGoToMenuNFS4Buttoniib
    /* AD3C 8001A53C 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* AD40 8001A540 6C00B1AF */  sw         $s1, 0x6C($sp)
    /* AD44 8001A544 21888000 */  addu       $s1, $a0, $zero
    /* AD48 8001A548 7400B3AF */  sw         $s3, 0x74($sp)
    /* AD4C 8001A54C 2198A000 */  addu       $s3, $a1, $zero
    /* AD50 8001A550 7800B4AF */  sw         $s4, 0x78($sp)
    /* AD54 8001A554 21A0C000 */  addu       $s4, $a2, $zero
    /* AD58 8001A558 7000B2AF */  sw         $s2, 0x70($sp)
    /* AD5C 8001A55C 2190E000 */  addu       $s2, $a3, $zero
    /* AD60 8001A560 7C00BFAF */  sw         $ra, 0x7C($sp)
    /* AD64 8001A564 07004016 */  bnez       $s2, .L8001A584
    /* AD68 8001A568 6800B0AF */   sw        $s0, 0x68($sp)
    /* AD6C 8001A56C 24002286 */  lh         $v0, 0x24($s1)
    /* AD70 8001A570 00000000 */  nop
    /* AD74 8001A574 F2FF4224 */  addiu      $v0, $v0, -0xE
    /* AD78 8001A578 02004228 */  slti       $v0, $v0, 0x2
    /* AD7C 8001A57C 25004014 */  bnez       $v0, .L8001A614
    /* AD80 8001A580 0E000224 */   addiu     $v0, $zero, 0xE
  .L8001A584:
    /* AD84 8001A584 3683000C */  jal        FETextRender_SetFont__Fi
    /* AD88 8001A588 21200000 */   addu      $a0, $zero, $zero
    /* AD8C 8001A58C 0400248E */  lw         $a0, 0x4($s1)
    /* AD90 8001A590 94E4020C */  jal        TextSys_Word__Fi
    /* AD94 8001A594 00000000 */   nop
    /* AD98 8001A598 2800B027 */  addiu      $s0, $sp, 0x28
    /* AD9C 8001A59C 21200002 */  addu       $a0, $s0, $zero
    /* ADA0 8001A5A0 0180053C */  lui        $a1, %hi(D_8001061C)
    /* ADA4 8001A5A4 1C06A524 */  addiu      $a1, $a1, %lo(D_8001061C)
    /* ADA8 8001A5A8 2F91030C */  jal        sprintf
    /* ADAC 8001A5AC 21304000 */   addu      $a2, $v0, $zero
    /* ADB0 8001A5B0 3C9A000C */  jal        s_upper__FPc
    /* ADB4 8001A5B4 21200002 */   addu      $a0, $s0, $zero
    /* ADB8 8001A5B8 888F030C */  jal        textpixels
    /* ADBC 8001A5BC 21200002 */   addu      $a0, $s0, $zero
    /* ADC0 8001A5C0 21200002 */  addu       $a0, $s0, $zero
    /* ADC4 8001A5C4 DDA7030C */  jal        strlen
    /* ADC8 8001A5C8 21804000 */   addu      $s0, $v0, $zero
    /* ADCC 8001A5CC 23800202 */  subu       $s0, $s0, $v0
    /* ADD0 8001A5D0 00141000 */  sll        $v0, $s0, 16
    /* ADD4 8001A5D4 03140200 */  sra        $v0, $v0, 16
    /* ADD8 8001A5D8 8C004228 */  slti       $v0, $v0, 0x8C
    /* ADDC 8001A5DC 02004014 */  bnez       $v0, .L8001A5E8
    /* ADE0 8001A5E0 A5000424 */   addiu     $a0, $zero, 0xA5
    /* ADE4 8001A5E4 19000426 */  addiu      $a0, $s0, 0x19
  .L8001A5E8:
    /* ADE8 8001A5E8 24002396 */  lhu        $v1, 0x24($s1)
    /* ADEC 8001A5EC 00000000 */  nop
    /* ADF0 8001A5F0 FEFF6224 */  addiu      $v0, $v1, -0x2
    /* ADF4 8001A5F4 03004016 */  bnez       $s2, .L8001A604
    /* ADF8 8001A5F8 240022A6 */   sh        $v0, 0x24($s1)
    /* ADFC 8001A5FC FCFF6224 */  addiu      $v0, $v1, -0x4
    /* AE00 8001A600 240022A6 */  sh         $v0, 0x24($s1)
  .L8001A604:
    /* AE04 8001A604 24002286 */  lh         $v0, 0x24($s1)
    /* AE08 8001A608 24002396 */  lhu        $v1, 0x24($s1)
    /* AE0C 8001A60C 02004104 */  bgez       $v0, .L8001A618
    /* AE10 8001A610 21106400 */   addu      $v0, $v1, $a0
  .L8001A614:
    /* AE14 8001A614 240022A6 */  sh         $v0, 0x24($s1)
  .L8001A618:
    /* AE18 8001A618 0000228E */  lw         $v0, 0x0($s1)
    /* AE1C 8001A61C 00000000 */  nop
    /* AE20 8001A620 01004238 */  xori       $v0, $v0, 0x1
    /* AE24 8001A624 01004230 */  andi       $v0, $v0, 0x1
    /* AE28 8001A628 04004010 */  beqz       $v0, .L8001A63C
    /* AE2C 8001A62C 00000000 */   nop
    /* AE30 8001A630 2A002296 */  lhu        $v0, 0x2A($s1)
    /* AE34 8001A634 92690008 */  j          .L8001A648
    /* AE38 8001A638 0C004224 */   addiu     $v0, $v0, 0xC
  .L8001A63C:
    /* AE3C 8001A63C 2A002296 */  lhu        $v0, 0x2A($s1)
    /* AE40 8001A640 00000000 */  nop
    /* AE44 8001A644 F4FF4224 */  addiu      $v0, $v0, -0xC
  .L8001A648:
    /* AE48 8001A648 2A0022A6 */  sh         $v0, 0x2A($s1)
    /* AE4C 8001A64C 2A002286 */  lh         $v0, 0x2A($s1)
    /* AE50 8001A650 00000000 */  nop
    /* AE54 8001A654 03004104 */  bgez       $v0, .L8001A664
    /* AE58 8001A658 81004228 */   slti      $v0, $v0, 0x81
    /* AE5C 8001A65C 9D690008 */  j          .L8001A674
    /* AE60 8001A660 2A0020A6 */   sh        $zero, 0x2A($s1)
  .L8001A664:
    /* AE64 8001A664 04004014 */  bnez       $v0, .L8001A678
    /* AE68 8001A668 73000224 */   addiu     $v0, $zero, 0x73
    /* AE6C 8001A66C 80000224 */  addiu      $v0, $zero, 0x80
    /* AE70 8001A670 2A0022A6 */  sh         $v0, 0x2A($s1)
  .L8001A674:
    /* AE74 8001A674 73000224 */  addiu      $v0, $zero, 0x73
  .L8001A678:
    /* AE78 8001A678 0B001224 */  addiu      $s2, $zero, 0xB
    /* AE7C 8001A67C 2000B3A7 */  sh         $s3, 0x20($sp)
    /* AE80 8001A680 2200B4A7 */  sh         $s4, 0x22($sp)
    /* AE84 8001A684 2400A2A7 */  sh         $v0, 0x24($sp)
    /* AE88 8001A688 2600B2A7 */  sh         $s2, 0x26($sp)
    /* AE8C 8001A68C 26002386 */  lh         $v1, 0x26($s1)
    /* AE90 8001A690 2A002286 */  lh         $v0, 0x2A($s1)
    /* AE94 8001A694 26002496 */  lhu        $a0, 0x26($s1)
    /* AE98 8001A698 2A104300 */  slt        $v0, $v0, $v1
    /* AE9C 8001A69C 2A002396 */  lhu        $v1, 0x2A($s1)
    /* AEA0 8001A6A0 02004010 */  beqz       $v0, .L8001A6AC
    /* AEA4 8001A6A4 73001024 */   addiu     $s0, $zero, 0x73
    /* AEA8 8001A6A8 21206000 */  addu       $a0, $v1, $zero
  .L8001A6AC:
    /* AEAC 8001A6AC 00140400 */  sll        $v0, $a0, 16
    /* AEB0 8001A6B0 03140200 */  sra        $v0, $v0, 16
    /* AEB4 8001A6B4 18005000 */  mult       $v0, $s0
    /* AEB8 8001A6B8 12100000 */  mflo       $v0
    /* AEBC 8001A6BC 02004104 */  bgez       $v0, .L8001A6C8
    /* AEC0 8001A6C0 00000000 */   nop
    /* AEC4 8001A6C4 7F004224 */  addiu      $v0, $v0, 0x7F
  .L8001A6C8:
    /* AEC8 8001A6C8 C3110200 */  sra        $v0, $v0, 7
    /* AECC 8001A6CC 2400A2A7 */  sh         $v0, 0x24($sp)
    /* AED0 8001A6D0 24002786 */  lh         $a3, 0x24($s1)
    /* AED4 8001A6D4 08002286 */  lh         $v0, 0x8($s1)
    /* AED8 8001A6D8 2000A527 */  addiu      $a1, $sp, 0x20
    /* AEDC 8001A6DC 1400A0AF */  sw         $zero, 0x14($sp)
    /* AEE0 8001A6E0 1800A0AF */  sw         $zero, 0x18($sp)
    /* AEE4 8001A6E4 1000A2AF */  sw         $v0, 0x10($sp)
    /* AEE8 8001A6E8 0400248E */  lw         $a0, 0x4($s1)
    /* AEEC 8001A6EC 0668000C */  jal        MenuNFS4_DrawTextBox__FiR4RECTissbT5
    /* AEF0 8001A6F0 8C000624 */   addiu     $a2, $zero, 0x8C
    /* AEF4 8001A6F4 0000228E */  lw         $v0, 0x0($s1)
    /* AEF8 8001A6F8 00000000 */  nop
    /* AEFC 8001A6FC 00024230 */  andi       $v0, $v0, 0x200
    /* AF00 8001A700 25004010 */  beqz       $v0, .L8001A798
    /* AF04 8001A704 0580043C */   lui       $a0, %hi(FontUpsideDownBlit__FiiPviiP12charactertbli)
    /* AF08 8001A708 F32D030C */  jal        Font_SetBlitter__FPFiiPviiP12charactertbli_v
    /* AF0C 8001A70C B4EF8424 */   addiu     $a0, $a0, %lo(FontUpsideDownBlit__FiiPviiP12charactertbli)
    /* AF10 8001A710 18010224 */  addiu      $v0, $zero, 0x118
    /* AF14 8001A714 23105400 */  subu       $v0, $v0, $s4
    /* AF18 8001A718 2000B3A7 */  sh         $s3, 0x20($sp)
    /* AF1C 8001A71C 2200A2A7 */  sh         $v0, 0x22($sp)
    /* AF20 8001A720 2400B0A7 */  sh         $s0, 0x24($sp)
    /* AF24 8001A724 2600B2A7 */  sh         $s2, 0x26($sp)
    /* AF28 8001A728 26002386 */  lh         $v1, 0x26($s1)
    /* AF2C 8001A72C 2A002286 */  lh         $v0, 0x2A($s1)
    /* AF30 8001A730 26002496 */  lhu        $a0, 0x26($s1)
    /* AF34 8001A734 2A104300 */  slt        $v0, $v0, $v1
    /* AF38 8001A738 2A002396 */  lhu        $v1, 0x2A($s1)
    /* AF3C 8001A73C 03004010 */  beqz       $v0, .L8001A74C
    /* AF40 8001A740 00140400 */   sll       $v0, $a0, 16
    /* AF44 8001A744 21206000 */  addu       $a0, $v1, $zero
    /* AF48 8001A748 00140400 */  sll        $v0, $a0, 16
  .L8001A74C:
    /* AF4C 8001A74C 03140200 */  sra        $v0, $v0, 16
    /* AF50 8001A750 18005000 */  mult       $v0, $s0
    /* AF54 8001A754 12100000 */  mflo       $v0
    /* AF58 8001A758 02004104 */  bgez       $v0, .L8001A764
    /* AF5C 8001A75C 2000A527 */   addiu     $a1, $sp, 0x20
    /* AF60 8001A760 7F004224 */  addiu      $v0, $v0, 0x7F
  .L8001A764:
    /* AF64 8001A764 C3110200 */  sra        $v0, $v0, 7
    /* AF68 8001A768 2400A2A7 */  sh         $v0, 0x24($sp)
    /* AF6C 8001A76C 24002786 */  lh         $a3, 0x24($s1)
    /* AF70 8001A770 08002386 */  lh         $v1, 0x8($s1)
    /* AF74 8001A774 01000224 */  addiu      $v0, $zero, 0x1
    /* AF78 8001A778 1400A0AF */  sw         $zero, 0x14($sp)
    /* AF7C 8001A77C 1800A2AF */  sw         $v0, 0x18($sp)
    /* AF80 8001A780 1000A3AF */  sw         $v1, 0x10($sp)
    /* AF84 8001A784 0400248E */  lw         $a0, 0x4($s1)
    /* AF88 8001A788 0668000C */  jal        MenuNFS4_DrawTextBox__FiR4RECTissbT5
    /* AF8C 8001A78C 8C000624 */   addiu     $a2, $zero, 0x8C
    /* AF90 8001A790 F62D030C */  jal        Font_ReSetBlitter__Fv
    /* AF94 8001A794 00000000 */   nop
  .L8001A798:
    /* AF98 8001A798 7C00BF8F */  lw         $ra, 0x7C($sp)
    /* AF9C 8001A79C 7800B48F */  lw         $s4, 0x78($sp)
    /* AFA0 8001A7A0 7400B38F */  lw         $s3, 0x74($sp)
    /* AFA4 8001A7A4 7000B28F */  lw         $s2, 0x70($sp)
    /* AFA8 8001A7A8 6C00B18F */  lw         $s1, 0x6C($sp)
    /* AFAC 8001A7AC 6800B08F */  lw         $s0, 0x68($sp)
    /* AFB0 8001A7B0 0800E003 */  jr         $ra
    /* AFB4 8001A7B4 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel Draw__27tMenuItemGoToMenuNFS4Buttoniib
