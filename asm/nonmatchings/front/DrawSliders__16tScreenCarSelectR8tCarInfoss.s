.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawSliders__16tScreenCarSelectR8tCarInfoss, 0x16C

glabel DrawSliders__16tScreenCarSelectR8tCarInfoss
    /* 2CE6C 8003C66C A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* 2CE70 8003C670 4800B4AF */  sw         $s4, 0x48($sp)
    /* 2CE74 8003C674 21A0A000 */  addu       $s4, $a1, $zero
    /* 2CE78 8003C678 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 2CE7C 8003C67C 2188E000 */  addu       $s1, $a3, $zero
    /* 2CE80 8003C680 4000B2AF */  sw         $s2, 0x40($sp)
    /* 2CE84 8003C684 21900000 */  addu       $s2, $zero, $zero
    /* 2CE88 8003C688 0580023C */  lui        $v0, %hi(D_80051F6C)
    /* 2CE8C 8003C68C 5000B6AF */  sw         $s6, 0x50($sp)
    /* 2CE90 8003C690 6C1F5624 */  addiu      $s6, $v0, %lo(D_80051F6C)
    /* 2CE94 8003C694 00340600 */  sll        $a2, $a2, 16
    /* 2CE98 8003C698 4400B3AF */  sw         $s3, 0x44($sp)
    /* 2CE9C 8003C69C 039C0600 */  sra        $s3, $a2, 16
    /* 2CEA0 8003C6A0 0580023C */  lui        $v0, %hi(D_80051F58)
    /* 2CEA4 8003C6A4 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* 2CEA8 8003C6A8 581F5524 */  addiu      $s5, $v0, %lo(D_80051F58)
    /* 2CEAC 8003C6AC 5400BFAF */  sw         $ra, 0x54($sp)
    /* 2CEB0 8003C6B0 3800B0AF */  sw         $s0, 0x38($sp)
  .L8003C6B4:
    /* 2CEB4 8003C6B4 00141200 */  sll        $v0, $s2, 16
    /* 2CEB8 8003C6B8 03840200 */  sra        $s0, $v0, 16
    /* 2CEBC 8003C6BC 0500022A */  slti       $v0, $s0, 0x5
    /* 2CEC0 8003C6C0 3B004010 */  beqz       $v0, .L8003C7B0
    /* 2CEC4 8003C6C4 21286002 */   addu      $a1, $s3, $zero
    /* 2CEC8 8003C6C8 04002626 */  addiu      $a2, $s1, 0x4
    /* 2CECC 8003C6CC 00340600 */  sll        $a2, $a2, 16
    /* 2CED0 8003C6D0 03340600 */  sra        $a2, $a2, 16
    /* 2CED4 8003C6D4 21380000 */  addu       $a3, $zero, $zero
    /* 2CED8 8003C6D8 40101000 */  sll        $v0, $s0, 1
    /* 2CEDC 8003C6DC 21105600 */  addu       $v0, $v0, $s6
    /* 2CEE0 8003C6E0 00004484 */  lh         $a0, 0x0($v0)
    /* 2CEE4 8003C6E4 0E000224 */  addiu      $v0, $zero, 0xE
    /* 2CEE8 8003C6E8 0584000C */  jal        FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
    /* 2CEEC 8003C6EC 1000A2AF */   sw        $v0, 0x10($sp)
    /* 2CEF0 8003C6F0 80101000 */  sll        $v0, $s0, 2
    /* 2CEF4 8003C6F4 21105500 */  addu       $v0, $v0, $s5
    /* 2CEF8 8003C6F8 0000428C */  lw         $v0, 0x0($v0)
    /* 2CEFC 8003C6FC C4008392 */  lbu        $v1, 0xC4($s4)
    /* 2CF00 8003C700 21288202 */  addu       $a1, $s4, $v0
    /* 2CF04 8003C704 01006230 */  andi       $v0, $v1, 0x1
    /* 2CF08 8003C708 3000A490 */  lbu        $a0, 0x30($a1)
    /* 2CF0C 8003C70C 05004010 */  beqz       $v0, .L8003C724
    /* 2CF10 8003C710 02006230 */   andi      $v0, $v1, 0x2
    /* 2CF14 8003C714 3500A290 */  lbu        $v0, 0x35($a1)
    /* 2CF18 8003C718 00000000 */  nop
    /* 2CF1C 8003C71C 21208200 */  addu       $a0, $a0, $v0
    /* 2CF20 8003C720 02006230 */  andi       $v0, $v1, 0x2
  .L8003C724:
    /* 2CF24 8003C724 05004010 */  beqz       $v0, .L8003C73C
    /* 2CF28 8003C728 04006230 */   andi      $v0, $v1, 0x4
    /* 2CF2C 8003C72C 3A00A290 */  lbu        $v0, 0x3A($a1)
    /* 2CF30 8003C730 00000000 */  nop
    /* 2CF34 8003C734 21208200 */  addu       $a0, $a0, $v0
    /* 2CF38 8003C738 04006230 */  andi       $v0, $v1, 0x4
  .L8003C73C:
    /* 2CF3C 8003C73C 04004010 */  beqz       $v0, .L8003C750
    /* 2CF40 8003C740 00000000 */   nop
    /* 2CF44 8003C744 3F00A290 */  lbu        $v0, 0x3F($a1)
    /* 2CF48 8003C748 00000000 */  nop
    /* 2CF4C 8003C74C 21208200 */  addu       $a0, $a0, $v0
  .L8003C750:
    /* 2CF50 8003C750 00240400 */  sll        $a0, $a0, 16
    /* 2CF54 8003C754 03240400 */  sra        $a0, $a0, 16
    /* 2CF58 8003C758 21280000 */  addu       $a1, $zero, $zero
    /* 2CF5C 8003C75C 0B000624 */  addiu      $a2, $zero, 0xB
    /* 2CF60 8003C760 21386002 */  addu       $a3, $s3, $zero
    /* 2CF64 8003C764 00141100 */  sll        $v0, $s1, 16
    /* 2CF68 8003C768 03140200 */  sra        $v0, $v0, 16
    /* 2CF6C 8003C76C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2CF70 8003C770 68000224 */  addiu      $v0, $zero, 0x68
    /* 2CF74 8003C774 03000324 */  addiu      $v1, $zero, 0x3
    /* 2CF78 8003C778 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2CF7C 8003C77C 07000224 */  addiu      $v0, $zero, 0x7
    /* 2CF80 8003C780 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 2CF84 8003C784 80000224 */  addiu      $v0, $zero, 0x80
    /* 2CF88 8003C788 1800A3AF */  sw         $v1, 0x18($sp)
    /* 2CF8C 8003C78C 2000A3AF */  sw         $v1, 0x20($sp)
    /* 2CF90 8003C790 2400A0AF */  sw         $zero, 0x24($sp)
    /* 2CF94 8003C794 2800A0AF */  sw         $zero, 0x28($sp)
    /* 2CF98 8003C798 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* 2CF9C 8003C79C 0B93000C */  jal        DrawSlider__FsssssssssbT9ss
    /* 2CFA0 8003C7A0 3000A0AF */   sw        $zero, 0x30($sp)
    /* 2CFA4 8003C7A4 0F003126 */  addiu      $s1, $s1, 0xF
    /* 2CFA8 8003C7A8 ADF10008 */  j          .L8003C6B4
    /* 2CFAC 8003C7AC 01005226 */   addiu     $s2, $s2, 0x1
  .L8003C7B0:
    /* 2CFB0 8003C7B0 5400BF8F */  lw         $ra, 0x54($sp)
    /* 2CFB4 8003C7B4 5000B68F */  lw         $s6, 0x50($sp)
    /* 2CFB8 8003C7B8 4C00B58F */  lw         $s5, 0x4C($sp)
    /* 2CFBC 8003C7BC 4800B48F */  lw         $s4, 0x48($sp)
    /* 2CFC0 8003C7C0 4400B38F */  lw         $s3, 0x44($sp)
    /* 2CFC4 8003C7C4 4000B28F */  lw         $s2, 0x40($sp)
    /* 2CFC8 8003C7C8 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 2CFCC 8003C7CC 3800B08F */  lw         $s0, 0x38($sp)
    /* 2CFD0 8003C7D0 0800E003 */  jr         $ra
    /* 2CFD4 8003C7D4 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel DrawSliders__16tScreenCarSelectR8tCarInfoss
