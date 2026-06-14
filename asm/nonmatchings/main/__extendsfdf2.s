.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __extendsfdf2, 0x15C

glabel __extendsfdf2
    /* E5FC4 800F57C4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* E5FC8 800F57C8 FF7F023C */  lui        $v0, (0x7FFFFFFF >> 16)
    /* E5FCC 800F57CC FFFF4234 */  ori        $v0, $v0, (0x7FFFFFFF & 0xFFFF)
    /* E5FD0 800F57D0 3400B3AF */  sw         $s3, 0x34($sp)
    /* E5FD4 800F57D4 21988000 */  addu       $s3, $a0, $zero
    /* E5FD8 800F57D8 24106202 */  and        $v0, $s3, $v0
    /* E5FDC 800F57DC 4000BFAF */  sw         $ra, 0x40($sp)
    /* E5FE0 800F57E0 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* E5FE4 800F57E4 3800B4AF */  sw         $s4, 0x38($sp)
    /* E5FE8 800F57E8 3000B2AF */  sw         $s2, 0x30($sp)
    /* E5FEC 800F57EC 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* E5FF0 800F57F0 05004014 */  bnez       $v0, .L800F5808
    /* E5FF4 800F57F4 2800B0AF */   sw        $s0, 0x28($sp)
    /* E5FF8 800F57F8 0080023C */  lui        $v0, (0x80000000 >> 16)
    /* E5FFC 800F57FC 24886202 */  and        $s1, $s3, $v0
    /* E6000 800F5800 3DD60308 */  j          .L800F58F4
    /* E6004 800F5804 21800000 */   addu      $s0, $zero, $zero
  .L800F5808:
    /* E6008 800F5808 7F00023C */  lui        $v0, (0x7FFFFF >> 16)
    /* E600C 800F580C FFFF4234 */  ori        $v0, $v0, (0x7FFFFF & 0xFFFF)
    /* E6010 800F5810 24186202 */  and        $v1, $s3, $v0
    /* E6014 800F5814 C3151300 */  sra        $v0, $s3, 23
    /* E6018 800F5818 FF004230 */  andi       $v0, $v0, 0xFF
    /* E601C 800F581C 1C00A3AF */  sw         $v1, 0x1C($sp)
    /* E6020 800F5820 0B004010 */  beqz       $v0, .L800F5850
    /* E6024 800F5824 1800A0AF */   sw        $zero, 0x18($sp)
    /* E6028 800F5828 80035224 */  addiu      $s2, $v0, 0x380
    /* E602C 800F582C 1800A427 */  addiu      $a0, $sp, 0x18
    /* E6030 800F5830 03000224 */  addiu      $v0, $zero, 0x3
    /* E6034 800F5834 1000A2AF */  sw         $v0, 0x10($sp)
    /* E6038 800F5838 1800A68F */  lw         $a2, 0x18($sp)
    /* E603C 800F583C 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E6040 800F5840 901B040C */  jal        _dbl_shift
    /* E6044 800F5844 01000524 */   addiu     $a1, $zero, 0x1
    /* E6048 800F5848 36D60308 */  j          .L800F58D8
    /* E604C 800F584C 0080023C */   lui       $v0, (0x80000000 >> 16)
  .L800F5850:
    /* E6050 800F5850 E0FF023C */  lui        $v0, (0xFFE00000 >> 16)
    /* E6054 800F5854 24106200 */  and        $v0, $v1, $v0
    /* E6058 800F5858 0E004010 */  beqz       $v0, .L800F5894
    /* E605C 800F585C 7E031224 */   addiu     $s2, $zero, 0x37E
    /* E6060 800F5860 01001524 */  addiu      $s5, $zero, 0x1
    /* E6064 800F5864 E0FF143C */  lui        $s4, (0xFFE00000 >> 16)
  .L800F5868:
    /* E6068 800F5868 1800A427 */  addiu      $a0, $sp, 0x18
    /* E606C 800F586C 1000B5AF */  sw         $s5, 0x10($sp)
    /* E6070 800F5870 1800A68F */  lw         $a2, 0x18($sp)
    /* E6074 800F5874 1C00A78F */  lw         $a3, 0x1C($sp)
    /* E6078 800F5878 901B040C */  jal        _dbl_shift
    /* E607C 800F587C 01000524 */   addiu     $a1, $zero, 0x1
    /* E6080 800F5880 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E6084 800F5884 00000000 */  nop
    /* E6088 800F5888 24105400 */  and        $v0, $v0, $s4
    /* E608C 800F588C F6FF4014 */  bnez       $v0, .L800F5868
    /* E6090 800F5890 01005226 */   addiu     $s2, $s2, 0x1
  .L800F5894:
    /* E6094 800F5894 1C00A38F */  lw         $v1, 0x1C($sp)
    /* E6098 800F5898 1000023C */  lui        $v0, (0x100000 >> 16)
    /* E609C 800F589C 24106200 */  and        $v0, $v1, $v0
    /* E60A0 800F58A0 07004014 */  bnez       $v0, .L800F58C0
    /* E60A4 800F58A4 1000043C */   lui       $a0, (0x100000 >> 16)
  .L800F58A8:
    /* E60A8 800F58A8 40100300 */  sll        $v0, $v1, 1
    /* E60AC 800F58AC 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* E60B0 800F58B0 21184000 */  addu       $v1, $v0, $zero
    /* E60B4 800F58B4 24106400 */  and        $v0, $v1, $a0
    /* E60B8 800F58B8 FBFF4010 */  beqz       $v0, .L800F58A8
    /* E60BC 800F58BC FFFF5226 */   addiu     $s2, $s2, -0x1
  .L800F58C0:
    /* E60C0 800F58C0 EFFF033C */  lui        $v1, (0xFFEFFFFF >> 16)
    /* E60C4 800F58C4 1C00A28F */  lw         $v0, 0x1C($sp)
    /* E60C8 800F58C8 FFFF6334 */  ori        $v1, $v1, (0xFFEFFFFF & 0xFFFF)
    /* E60CC 800F58CC 24104300 */  and        $v0, $v0, $v1
    /* E60D0 800F58D0 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* E60D4 800F58D4 0080023C */  lui        $v0, (0x80000000 >> 16)
  .L800F58D8:
    /* E60D8 800F58D8 24106202 */  and        $v0, $s3, $v0
    /* E60DC 800F58DC 001D1200 */  sll        $v1, $s2, 20
    /* E60E0 800F58E0 1C00A48F */  lw         $a0, 0x1C($sp)
    /* E60E4 800F58E4 25104300 */  or         $v0, $v0, $v1
    /* E60E8 800F58E8 25884400 */  or         $s1, $v0, $a0
    /* E60EC 800F58EC 1800B08F */  lw         $s0, 0x18($sp)
    /* E60F0 800F58F0 00000000 */  nop
  .L800F58F4:
    /* E60F4 800F58F4 21100002 */  addu       $v0, $s0, $zero
    /* E60F8 800F58F8 21182002 */  addu       $v1, $s1, $zero
    /* E60FC 800F58FC 4000BF8F */  lw         $ra, 0x40($sp)
    /* E6100 800F5900 3C00B58F */  lw         $s5, 0x3C($sp)
    /* E6104 800F5904 3800B48F */  lw         $s4, 0x38($sp)
    /* E6108 800F5908 3400B38F */  lw         $s3, 0x34($sp)
    /* E610C 800F590C 3000B28F */  lw         $s2, 0x30($sp)
    /* E6110 800F5910 2C00B18F */  lw         $s1, 0x2C($sp)
    /* E6114 800F5914 2800B08F */  lw         $s0, 0x28($sp)
    /* E6118 800F5918 0800E003 */  jr         $ra
    /* E611C 800F591C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel __extendsfdf2
    /* E6120 800F5920 00000000 */  nop
