.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawForeground__20tScreenCarSelectDuel, 0x1D8

glabel DrawForeground__20tScreenCarSelectDuel
    /* 2E668 8003DE68 D0FEBD27 */  addiu      $sp, $sp, -0x130
    /* 2E66C 8003DE6C 1001B2AF */  sw         $s2, 0x110($sp)
    /* 2E670 8003DE70 2D001224 */  addiu      $s2, $zero, 0x2D
    /* 2E674 8003DE74 3800A527 */  addiu      $a1, $sp, 0x38
    /* 2E678 8003DE78 1401B3AF */  sw         $s3, 0x114($sp)
    /* 2E67C 8003DE7C 21980000 */  addu       $s3, $zero, $zero
    /* 2E680 8003DE80 2801BFAF */  sw         $ra, 0x128($sp)
    /* 2E684 8003DE84 2401B7AF */  sw         $s7, 0x124($sp)
    /* 2E688 8003DE88 2001B6AF */  sw         $s6, 0x120($sp)
    /* 2E68C 8003DE8C 1C01B5AF */  sw         $s5, 0x11C($sp)
    /* 2E690 8003DE90 1801B4AF */  sw         $s4, 0x118($sp)
    /* 2E694 8003DE94 0C01B1AF */  sw         $s1, 0x10C($sp)
    /* 2E698 8003DE98 0801B0AF */  sw         $s0, 0x108($sp)
    /* 2E69C 8003DE9C 6000828C */  lw         $v0, 0x60($a0)
    /* 2E6A0 8003DEA0 04001524 */  addiu      $s5, $zero, 0x4
    /* 2E6A4 8003DEA4 68004384 */  lh         $v1, 0x68($v0)
    /* 2E6A8 8003DEA8 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2E6AC 8003DEAC 00000000 */  nop
    /* 2E6B0 8003DEB0 09F84000 */  jalr       $v0
    /* 2E6B4 8003DEB4 21208300 */   addu      $a0, $a0, $v1
    /* 2E6B8 8003DEB8 21A04000 */  addu       $s4, $v0, $zero
    /* 2E6BC 8003DEBC 0580023C */  lui        $v0, %hi(D_80051F78)
    /* 2E6C0 8003DEC0 781F5724 */  addiu      $s7, $v0, %lo(D_80051F78)
    /* 2E6C4 8003DEC4 00141300 */  sll        $v0, $s3, 16
  .L8003DEC8:
    /* 2E6C8 8003DEC8 03140200 */  sra        $v0, $v0, 16
    /* 2E6CC 8003DECC 02004228 */  slti       $v0, $v0, 0x2
    /* 2E6D0 8003DED0 50004010 */  beqz       $v0, .L8003E014
    /* 2E6D4 8003DED4 21880000 */   addu      $s1, $zero, $zero
    /* 2E6D8 8003DED8 0580023C */  lui        $v0, %hi(D_80051F58)
    /* 2E6DC 8003DEDC 581F5624 */  addiu      $s6, $v0, %lo(D_80051F58)
  .L8003DEE0:
    /* 2E6E0 8003DEE0 00141100 */  sll        $v0, $s1, 16
    /* 2E6E4 8003DEE4 03840200 */  sra        $s0, $v0, 16
    /* 2E6E8 8003DEE8 0500022A */  slti       $v0, $s0, 0x5
    /* 2E6EC 8003DEEC 3F004010 */  beqz       $v0, .L8003DFEC
    /* 2E6F0 8003DEF0 F4010524 */   addiu     $a1, $zero, 0x1F4
    /* 2E6F4 8003DEF4 04004626 */  addiu      $a2, $s2, 0x4
    /* 2E6F8 8003DEF8 00340600 */  sll        $a2, $a2, 16
    /* 2E6FC 8003DEFC 03340600 */  sra        $a2, $a2, 16
    /* 2E700 8003DF00 40101000 */  sll        $v0, $s0, 1
    /* 2E704 8003DF04 21105700 */  addu       $v0, $v0, $s7
    /* 2E708 8003DF08 00004484 */  lh         $a0, 0x0($v0)
    /* 2E70C 8003DF0C 01000724 */  addiu      $a3, $zero, 0x1
    /* 2E710 8003DF10 1000A0AF */  sw         $zero, 0x10($sp)
    /* 2E714 8003DF14 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 2E718 8003DF18 1400B5AF */   sw        $s5, 0x14($sp)
    /* 2E71C 8003DF1C 1C008012 */  beqz       $s4, .L8003DF90
    /* 2E720 8003DF20 80101000 */   sll       $v0, $s0, 2
    /* 2E724 8003DF24 21105600 */  addu       $v0, $v0, $s6
    /* 2E728 8003DF28 0000438C */  lw         $v1, 0x0($v0)
    /* 2E72C 8003DF2C 3800A227 */  addiu      $v0, $sp, 0x38
    /* 2E730 8003DF30 C4004490 */  lbu        $a0, 0xC4($v0)
    /* 2E734 8003DF34 21284300 */  addu       $a1, $v0, $v1
    /* 2E738 8003DF38 01008230 */  andi       $v0, $a0, 0x1
    /* 2E73C 8003DF3C 3000A390 */  lbu        $v1, 0x30($a1)
    /* 2E740 8003DF40 05004010 */  beqz       $v0, .L8003DF58
    /* 2E744 8003DF44 02008230 */   andi      $v0, $a0, 0x2
    /* 2E748 8003DF48 3500A290 */  lbu        $v0, 0x35($a1)
    /* 2E74C 8003DF4C 00000000 */  nop
    /* 2E750 8003DF50 21186200 */  addu       $v1, $v1, $v0
    /* 2E754 8003DF54 02008230 */  andi       $v0, $a0, 0x2
  .L8003DF58:
    /* 2E758 8003DF58 05004010 */  beqz       $v0, .L8003DF70
    /* 2E75C 8003DF5C 04008230 */   andi      $v0, $a0, 0x4
    /* 2E760 8003DF60 3A00A290 */  lbu        $v0, 0x3A($a1)
    /* 2E764 8003DF64 00000000 */  nop
    /* 2E768 8003DF68 21186200 */  addu       $v1, $v1, $v0
    /* 2E76C 8003DF6C 04008230 */  andi       $v0, $a0, 0x4
  .L8003DF70:
    /* 2E770 8003DF70 05004010 */  beqz       $v0, .L8003DF88
    /* 2E774 8003DF74 00140300 */   sll       $v0, $v1, 16
    /* 2E778 8003DF78 3F00A290 */  lbu        $v0, 0x3F($a1)
    /* 2E77C 8003DF7C 00000000 */  nop
    /* 2E780 8003DF80 21186200 */  addu       $v1, $v1, $v0
    /* 2E784 8003DF84 00140300 */  sll        $v0, $v1, 16
  .L8003DF88:
    /* 2E788 8003DF88 E5F70008 */  j          .L8003DF94
    /* 2E78C 8003DF8C 03240200 */   sra       $a0, $v0, 16
  .L8003DF90:
    /* 2E790 8003DF90 21200000 */  addu       $a0, $zero, $zero
  .L8003DF94:
    /* 2E794 8003DF94 21280000 */  addu       $a1, $zero, $zero
    /* 2E798 8003DF98 0B000624 */  addiu      $a2, $zero, 0xB
    /* 2E79C 8003DF9C A1010724 */  addiu      $a3, $zero, 0x1A1
    /* 2E7A0 8003DFA0 00141200 */  sll        $v0, $s2, 16
    /* 2E7A4 8003DFA4 03140200 */  sra        $v0, $v0, 16
    /* 2E7A8 8003DFA8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2E7AC 8003DFAC 49000224 */  addiu      $v0, $zero, 0x49
    /* 2E7B0 8003DFB0 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2E7B4 8003DFB4 03000224 */  addiu      $v0, $zero, 0x3
    /* 2E7B8 8003DFB8 1800A2AF */  sw         $v0, 0x18($sp)
    /* 2E7BC 8003DFBC 2000A2AF */  sw         $v0, 0x20($sp)
    /* 2E7C0 8003DFC0 01000224 */  addiu      $v0, $zero, 0x1
    /* 2E7C4 8003DFC4 2400A2AF */  sw         $v0, 0x24($sp)
    /* 2E7C8 8003DFC8 80000224 */  addiu      $v0, $zero, 0x80
    /* 2E7CC 8003DFCC 1C00B5AF */  sw         $s5, 0x1C($sp)
    /* 2E7D0 8003DFD0 2800A0AF */  sw         $zero, 0x28($sp)
    /* 2E7D4 8003DFD4 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* 2E7D8 8003DFD8 0B93000C */  jal        DrawSlider__FsssssssssbT9ss
    /* 2E7DC 8003DFDC 3000A0AF */   sw        $zero, 0x30($sp)
    /* 2E7E0 8003DFE0 0F005226 */  addiu      $s2, $s2, 0xF
    /* 2E7E4 8003DFE4 B8F70008 */  j          .L8003DEE0
    /* 2E7E8 8003DFE8 01003126 */   addiu     $s1, $s1, 0x1
  .L8003DFEC:
    /* 2E7EC 8003DFEC 96001224 */  addiu      $s2, $zero, 0x96
    /* 2E7F0 8003DFF0 1180043C */  lui        $a0, %hi(carManager)
    /* 2E7F4 8003DFF4 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2E7F8 8003DFF8 1180023C */  lui        $v0, %hi(D_8011491D)
    /* 2E7FC 8003DFFC 1D494590 */  lbu        $a1, %lo(D_8011491D)($v0)
    /* 2E800 8003E000 3800A627 */  addiu      $a2, $sp, 0x38
    /* 2E804 8003E004 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2E808 8003E008 01007326 */   addiu     $s3, $s3, 0x1
    /* 2E80C 8003E00C B2F70008 */  j          .L8003DEC8
    /* 2E810 8003E010 00141300 */   sll       $v0, $s3, 16
  .L8003E014:
    /* 2E814 8003E014 2801BF8F */  lw         $ra, 0x128($sp)
    /* 2E818 8003E018 2401B78F */  lw         $s7, 0x124($sp)
    /* 2E81C 8003E01C 2001B68F */  lw         $s6, 0x120($sp)
    /* 2E820 8003E020 1C01B58F */  lw         $s5, 0x11C($sp)
    /* 2E824 8003E024 1801B48F */  lw         $s4, 0x118($sp)
    /* 2E828 8003E028 1401B38F */  lw         $s3, 0x114($sp)
    /* 2E82C 8003E02C 1001B28F */  lw         $s2, 0x110($sp)
    /* 2E830 8003E030 0C01B18F */  lw         $s1, 0x10C($sp)
    /* 2E834 8003E034 0801B08F */  lw         $s0, 0x108($sp)
    /* 2E838 8003E038 0800E003 */  jr         $ra
    /* 2E83C 8003E03C 3001BD27 */   addiu     $sp, $sp, 0x130
endlabel DrawForeground__20tScreenCarSelectDuel
