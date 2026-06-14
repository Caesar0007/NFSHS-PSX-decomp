.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __divdf3, 0x2E0

glabel __divdf3
    /* E65D4 800F5DD4 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* E65D8 800F5DD8 21408000 */  addu       $t0, $a0, $zero
    /* E65DC 800F5DDC 2148A000 */  addu       $t1, $a1, $zero
    /* E65E0 800F5DE0 2150C000 */  addu       $t2, $a2, $zero
    /* E65E4 800F5DE4 2158E000 */  addu       $t3, $a3, $zero
    /* E65E8 800F5DE8 031D0900 */  sra        $v1, $t1, 20
    /* E65EC 800F5DEC FF076330 */  andi       $v1, $v1, 0x7FF
    /* E65F0 800F5DF0 03150B00 */  sra        $v0, $t3, 20
    /* E65F4 800F5DF4 FF074230 */  andi       $v0, $v0, 0x7FF
    /* E65F8 800F5DF8 23186200 */  subu       $v1, $v1, $v0
    /* E65FC 800F5DFC 4C00B1AF */  sw         $s1, 0x4C($sp)
    /* E6600 800F5E00 FE037124 */  addiu      $s1, $v1, 0x3FE
    /* E6604 800F5E04 FF7F033C */  lui        $v1, (0x7FFFFFFF >> 16)
    /* E6608 800F5E08 FFFF6334 */  ori        $v1, $v1, (0x7FFFFFFF & 0xFFFF)
    /* E660C 800F5E0C 0080023C */  lui        $v0, (0x80000000 >> 16)
    /* E6610 800F5E10 24202201 */  and        $a0, $t1, $v0
    /* E6614 800F5E14 24106201 */  and        $v0, $t3, $v0
    /* E6618 800F5E18 5800B4AF */  sw         $s4, 0x58($sp)
    /* E661C 800F5E1C 26A08200 */  xor        $s4, $a0, $v0
    /* E6620 800F5E20 24186301 */  and        $v1, $t3, $v1
    /* E6624 800F5E24 6000BFAF */  sw         $ra, 0x60($sp)
    /* E6628 800F5E28 5C00B5AF */  sw         $s5, 0x5C($sp)
    /* E662C 800F5E2C 5400B3AF */  sw         $s3, 0x54($sp)
    /* E6630 800F5E30 5000B2AF */  sw         $s2, 0x50($sp)
    /* E6634 800F5E34 09006014 */  bnez       $v1, .L800F5E5C
    /* E6638 800F5E38 4800B0AF */   sw        $s0, 0x48($sp)
    /* E663C 800F5E3C 08004015 */  bnez       $t2, .L800F5E60
    /* E6640 800F5E40 FF7F023C */   lui       $v0, (0x7FFFFFFF >> 16)
    /* E6644 800F5E44 03008016 */  bnez       $s4, .L800F5E54
    /* E6648 800F5E48 FFFF1324 */   addiu     $s3, $zero, -0x1
    /* E664C 800F5E4C FF7F133C */  lui        $s3, (0x7FFFFFFF >> 16)
    /* E6650 800F5E50 FFFF7336 */  ori        $s3, $s3, (0x7FFFFFFF & 0xFFFF)
  .L800F5E54:
    /* E6654 800F5E54 22D80308 */  j          .L800F6088
    /* E6658 800F5E58 FFFF1224 */   addiu     $s2, $zero, -0x1
  .L800F5E5C:
    /* E665C 800F5E5C FF7F023C */  lui        $v0, (0x7FFFFFFF >> 16)
  .L800F5E60:
    /* E6660 800F5E60 FFFF4234 */  ori        $v0, $v0, (0x7FFFFFFF & 0xFFFF)
    /* E6664 800F5E64 24102201 */  and        $v0, $t1, $v0
    /* E6668 800F5E68 06004014 */  bnez       $v0, .L800F5E84
    /* E666C 800F5E6C 0F00073C */   lui       $a3, (0xFFFFF >> 16)
    /* E6670 800F5E70 05000015 */  bnez       $t0, .L800F5E88
    /* E6674 800F5E74 FFFFE734 */   ori       $a3, $a3, (0xFFFFF & 0xFFFF)
    /* E6678 800F5E78 21988002 */  addu       $s3, $s4, $zero
    /* E667C 800F5E7C 22D80308 */  j          .L800F6088
    /* E6680 800F5E80 21900000 */   addu      $s2, $zero, $zero
  .L800F5E84:
    /* E6684 800F5E84 FFFFE734 */  ori        $a3, $a3, (0xFFFFF & 0xFFFF)
  .L800F5E88:
    /* E6688 800F5E88 21200001 */  addu       $a0, $t0, $zero
    /* E668C 800F5E8C 24282701 */  and        $a1, $t1, $a3
    /* E6690 800F5E90 1000023C */  lui        $v0, (0x100000 >> 16)
    /* E6694 800F5E94 2528A200 */  or         $a1, $a1, $v0
    /* E6698 800F5E98 21304001 */  addu       $a2, $t2, $zero
    /* E669C 800F5E9C 24386701 */  and        $a3, $t3, $a3
    /* E66A0 800F5EA0 2538E200 */  or         $a3, $a3, $v0
    /* E66A4 800F5EA4 3400A5AF */  sw         $a1, 0x34($sp)
    /* E66A8 800F5EA8 3000A8AF */  sw         $t0, 0x30($sp)
    /* E66AC 800F5EAC 3C00A7AF */  sw         $a3, 0x3C($sp)
    /* E66B0 800F5EB0 2DD8030C */  jal        _comp_mant
    /* E66B4 800F5EB4 3800AAAF */   sw        $t2, 0x38($sp)
    /* E66B8 800F5EB8 0A004104 */  bgez       $v0, .L800F5EE4
    /* E66BC 800F5EBC 3000B527 */   addiu     $s5, $sp, 0x30
    /* E66C0 800F5EC0 3000A427 */  addiu      $a0, $sp, 0x30
    /* E66C4 800F5EC4 21280000 */  addu       $a1, $zero, $zero
    /* E66C8 800F5EC8 01000224 */  addiu      $v0, $zero, 0x1
    /* E66CC 800F5ECC 1000A2AF */  sw         $v0, 0x10($sp)
    /* E66D0 800F5ED0 3000A68F */  lw         $a2, 0x30($sp)
    /* E66D4 800F5ED4 3400A78F */  lw         $a3, 0x34($sp)
    /* E66D8 800F5ED8 901B040C */  jal        _dbl_shift
    /* E66DC 800F5EDC FFFF3126 */   addiu     $s1, $s1, -0x1
    /* E66E0 800F5EE0 3000B527 */  addiu      $s5, $sp, 0x30
  .L800F5EE4:
    /* E66E4 800F5EE4 01001024 */  addiu      $s0, $zero, 0x1
    /* E66E8 800F5EE8 2000023C */  lui        $v0, (0x200000 >> 16)
    /* E66EC 800F5EEC 2400A2AF */  sw         $v0, 0x24($sp)
    /* E66F0 800F5EF0 2000A0AF */  sw         $zero, 0x20($sp)
    /* E66F4 800F5EF4 1800A0AF */  sw         $zero, 0x18($sp)
    /* E66F8 800F5EF8 1C00A0AF */  sw         $zero, 0x1C($sp)
  .L800F5EFC:
    /* E66FC 800F5EFC 3000A48F */  lw         $a0, 0x30($sp)
    /* E6700 800F5F00 3400A58F */  lw         $a1, 0x34($sp)
    /* E6704 800F5F04 3800A68F */  lw         $a2, 0x38($sp)
    /* E6708 800F5F08 3C00A78F */  lw         $a3, 0x3C($sp)
    /* E670C 800F5F0C 2DD8030C */  jal        _comp_mant
    /* E6710 800F5F10 00000000 */   nop
    /* E6714 800F5F14 14004004 */  bltz       $v0, .L800F5F68
    /* E6718 800F5F18 4000A427 */   addiu     $a0, $sp, 0x40
    /* E671C 800F5F1C 3800A58F */  lw         $a1, 0x38($sp)
    /* E6720 800F5F20 3C00A68F */  lw         $a2, 0x3C($sp)
    /* E6724 800F5F24 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E6728 800F5F28 2400A78F */  lw         $a3, 0x24($sp)
    /* E672C 800F5F2C 1800A38F */  lw         $v1, 0x18($sp)
    /* E6730 800F5F30 2000A88F */  lw         $t0, 0x20($sp)
    /* E6734 800F5F34 25104700 */  or         $v0, $v0, $a3
    /* E6738 800F5F38 25186800 */  or         $v1, $v1, $t0
    /* E673C 800F5F3C 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* E6740 800F5F40 C01B040C */  jal        _mainasu
    /* E6744 800F5F44 1800A3AF */   sw        $v1, 0x18($sp)
    /* E6748 800F5F48 4400A28F */  lw         $v0, 0x44($sp)
    /* E674C 800F5F4C 00000000 */  nop
    /* E6750 800F5F50 1000A2AF */  sw         $v0, 0x10($sp)
    /* E6754 800F5F54 4000A78F */  lw         $a3, 0x40($sp)
    /* E6758 800F5F58 3000A58F */  lw         $a1, 0x30($sp)
    /* E675C 800F5F5C 3400A68F */  lw         $a2, 0x34($sp)
    /* E6760 800F5F60 DC1B040C */  jal        _add_mant_d
    /* E6764 800F5F64 2120A002 */   addu      $a0, $s5, $zero
  .L800F5F68:
    /* E6768 800F5F68 3000A427 */  addiu      $a0, $sp, 0x30
    /* E676C 800F5F6C 1000B0AF */  sw         $s0, 0x10($sp)
    /* E6770 800F5F70 3000A68F */  lw         $a2, 0x30($sp)
    /* E6774 800F5F74 3400A78F */  lw         $a3, 0x34($sp)
    /* E6778 800F5F78 901B040C */  jal        _dbl_shift
    /* E677C 800F5F7C 21280000 */   addu      $a1, $zero, $zero
    /* E6780 800F5F80 2000A427 */  addiu      $a0, $sp, 0x20
    /* E6784 800F5F84 1000B0AF */  sw         $s0, 0x10($sp)
    /* E6788 800F5F88 2000A68F */  lw         $a2, 0x20($sp)
    /* E678C 800F5F8C 2400A78F */  lw         $a3, 0x24($sp)
    /* E6790 800F5F90 3A12040C */  jal        _dbl_shift_us
    /* E6794 800F5F94 01000524 */   addiu     $a1, $zero, 0x1
    /* E6798 800F5F98 2400A28F */  lw         $v0, 0x24($sp)
    /* E679C 800F5F9C 00000000 */  nop
    /* E67A0 800F5FA0 D6FF4014 */  bnez       $v0, .L800F5EFC
    /* E67A4 800F5FA4 00000000 */   nop
    /* E67A8 800F5FA8 2000A28F */  lw         $v0, 0x20($sp)
    /* E67AC 800F5FAC 00000000 */  nop
    /* E67B0 800F5FB0 D2FF4014 */  bnez       $v0, .L800F5EFC
    /* E67B4 800F5FB4 00000000 */   nop
    /* E67B8 800F5FB8 0C002006 */  bltz       $s1, .L800F5FEC
    /* E67BC 800F5FBC 1800A427 */   addiu     $a0, $sp, 0x18
    /* E67C0 800F5FC0 01001024 */  addiu      $s0, $zero, 0x1
    /* E67C4 800F5FC4 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* E67C8 800F5FC8 2800B0AF */  sw         $s0, 0x28($sp)
    /* E67CC 800F5FCC 1000A0AF */  sw         $zero, 0x10($sp)
    /* E67D0 800F5FD0 2800A78F */  lw         $a3, 0x28($sp)
    /* E67D4 800F5FD4 1800A58F */  lw         $a1, 0x18($sp)
    /* E67D8 800F5FD8 1C00A68F */  lw         $a2, 0x1C($sp)
    /* E67DC 800F5FDC DC1B040C */  jal        _add_mant_d
    /* E67E0 800F5FE0 01003126 */   addiu     $s1, $s1, 0x1
    /* E67E4 800F5FE4 08D80308 */  j          .L800F6020
    /* E67E8 800F5FE8 1800A427 */   addiu     $a0, $sp, 0x18
  .L800F5FEC:
    /* E67EC 800F5FEC 23801100 */  negu       $s0, $s1
    /* E67F0 800F5FF0 01000224 */  addiu      $v0, $zero, 0x1
    /* E67F4 800F5FF4 04100202 */  sllv       $v0, $v0, $s0
    /* E67F8 800F5FF8 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* E67FC 800F5FFC 2800A2AF */  sw         $v0, 0x28($sp)
    /* E6800 800F6000 1000A0AF */  sw         $zero, 0x10($sp)
    /* E6804 800F6004 2800A78F */  lw         $a3, 0x28($sp)
    /* E6808 800F6008 1800A58F */  lw         $a1, 0x18($sp)
    /* E680C 800F600C 1C00A68F */  lw         $a2, 0x1C($sp)
    /* E6810 800F6010 DC1B040C */  jal        _add_mant_d
    /* E6814 800F6014 21880000 */   addu      $s1, $zero, $zero
    /* E6818 800F6018 1800A427 */  addiu      $a0, $sp, 0x18
    /* E681C 800F601C 01001026 */  addiu      $s0, $s0, 0x1
  .L800F6020:
    /* E6820 800F6020 1000B0AF */  sw         $s0, 0x10($sp)
    /* E6824 800F6024 1800A68F */  lw         $a2, 0x18($sp)
    /* E6828 800F6028 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E682C 800F602C 3A12040C */  jal        _dbl_shift_us
    /* E6830 800F6030 01000524 */   addiu     $a1, $zero, 0x1
    /* E6834 800F6034 EFFF033C */  lui        $v1, (0xFFEFFFFF >> 16)
    /* E6838 800F6038 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E683C 800F603C FFFF6334 */  ori        $v1, $v1, (0xFFEFFFFF & 0xFFFF)
    /* E6840 800F6040 24184300 */  and        $v1, $v0, $v1
    /* E6844 800F6044 FF07222A */  slti       $v0, $s1, 0x7FF
    /* E6848 800F6048 0A004014 */  bnez       $v0, .L800F6074
    /* E684C 800F604C 1C00A3AF */   sw        $v1, 0x1C($sp)
    /* E6850 800F6050 22000424 */  addiu      $a0, $zero, 0x22
    /* E6854 800F6054 951A040C */  jal        _err_math
    /* E6858 800F6058 0F000524 */   addiu     $a1, $zero, 0xF
    /* E685C 800F605C 02008012 */  beqz       $s4, .L800F6068
    /* E6860 800F6060 F07F023C */   lui       $v0, (0x7FF00000 >> 16)
    /* E6864 800F6064 F0FF023C */  lui        $v0, (0xFFF00000 >> 16)
  .L800F6068:
    /* E6868 800F6068 21984000 */  addu       $s3, $v0, $zero
    /* E686C 800F606C 22D80308 */  j          .L800F6088
    /* E6870 800F6070 21900000 */   addu      $s2, $zero, $zero
  .L800F6074:
    /* E6874 800F6074 00151100 */  sll        $v0, $s1, 20
    /* E6878 800F6078 25108202 */  or         $v0, $s4, $v0
    /* E687C 800F607C 25984300 */  or         $s3, $v0, $v1
    /* E6880 800F6080 1800B28F */  lw         $s2, 0x18($sp)
    /* E6884 800F6084 00000000 */  nop
  .L800F6088:
    /* E6888 800F6088 21104002 */  addu       $v0, $s2, $zero
    /* E688C 800F608C 21186002 */  addu       $v1, $s3, $zero
    /* E6890 800F6090 6000BF8F */  lw         $ra, 0x60($sp)
    /* E6894 800F6094 5C00B58F */  lw         $s5, 0x5C($sp)
    /* E6898 800F6098 5800B48F */  lw         $s4, 0x58($sp)
    /* E689C 800F609C 5400B38F */  lw         $s3, 0x54($sp)
    /* E68A0 800F60A0 5000B28F */  lw         $s2, 0x50($sp)
    /* E68A4 800F60A4 4C00B18F */  lw         $s1, 0x4C($sp)
    /* E68A8 800F60A8 4800B08F */  lw         $s0, 0x48($sp)
    /* E68AC 800F60AC 0800E003 */  jr         $ra
    /* E68B0 800F60B0 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel __divdf3
