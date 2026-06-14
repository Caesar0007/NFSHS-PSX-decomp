.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching locatebigentryz, 0x1BC

glabel locatebigentryz
    /* D67FC 800E5FFC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D6800 800E6000 1000B0AF */  sw         $s0, 0x10($sp)
    /* D6804 800E6004 21808000 */  addu       $s0, $a0, $zero
    /* D6808 800E6008 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D680C 800E600C 2198A000 */  addu       $s3, $a1, $zero
    /* D6810 800E6010 2800B6AF */  sw         $s6, 0x28($sp)
    /* D6814 800E6014 21B0C000 */  addu       $s6, $a2, $zero
    /* D6818 800E6018 2000B4AF */  sw         $s4, 0x20($sp)
    /* D681C 800E601C 21A0E000 */  addu       $s4, $a3, $zero
    /* D6820 800E6020 1400B1AF */  sw         $s1, 0x14($sp)
    /* D6824 800E6024 21880000 */  addu       $s1, $zero, $zero
    /* D6828 800E6028 2400B5AF */  sw         $s5, 0x24($sp)
    /* D682C 800E602C 4000B58F */  lw         $s5, 0x40($sp)
    /* D6830 800E6030 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* D6834 800E6034 E197030C */  jal        sizeofbigfileheader
    /* D6838 800E6038 1800B2AF */   sw        $s2, 0x18($sp)
    /* D683C 800E603C 21200002 */  addu       $a0, $s0, $zero
    /* D6840 800E6040 C797030C */  jal        typeofbigfile
    /* D6844 800E6044 21900202 */   addu      $s2, $s0, $v0
    /* D6848 800E6048 21184000 */  addu       $v1, $v0, $zero
    /* D684C 800E604C 01000224 */  addiu      $v0, $zero, 0x1
    /* D6850 800E6050 05006210 */  beq        $v1, $v0, .L800E6068
    /* D6854 800E6054 02000224 */   addiu     $v0, $zero, 0x2
    /* D6858 800E6058 26006210 */  beq        $v1, $v0, .L800E60F4
    /* D685C 800E605C 00000000 */   nop
    /* D6860 800E6060 5E980308 */  j          .L800E6178
    /* D6864 800E6064 00000000 */   nop
  .L800E6068:
    /* D6868 800E6068 06001026 */  addiu      $s0, $s0, 0x6
    /* D686C 800E606C 2B101202 */  sltu       $v0, $s0, $s2
    /* D6870 800E6070 41004010 */  beqz       $v0, .L800E6178
    /* D6874 800E6074 00000000 */   nop
  .L800E6078:
    /* D6878 800E6078 05006016 */  bnez       $s3, .L800E6090
    /* D687C 800E607C 06000426 */   addiu     $a0, $s0, 0x6
    /* D6880 800E6080 07003612 */  beq        $s1, $s6, .L800E60A0
    /* D6884 800E6084 00000000 */   nop
    /* D6888 800E6088 34980308 */  j          .L800E60D0
    /* D688C 800E608C 00000000 */   nop
  .L800E6090:
    /* D6890 800E6090 48F9030C */  jal        stricmp
    /* D6894 800E6094 21286002 */   addu      $a1, $s3, $zero
    /* D6898 800E6098 0D004014 */  bnez       $v0, .L800E60D0
    /* D689C 800E609C 00000000 */   nop
  .L800E60A0:
    /* D68A0 800E60A0 04008012 */  beqz       $s4, .L800E60B4
    /* D68A4 800E60A4 21200002 */   addu      $a0, $s0, $zero
    /* D68A8 800E60A8 09CC030C */  jal        getm
    /* D68AC 800E60AC 03000524 */   addiu     $a1, $zero, 0x3
    /* D68B0 800E60B0 000082AE */  sw         $v0, 0x0($s4)
  .L800E60B4:
    /* D68B4 800E60B4 0400A012 */  beqz       $s5, .L800E60C8
    /* D68B8 800E60B8 03000426 */   addiu     $a0, $s0, 0x3
    /* D68BC 800E60BC 09CC030C */  jal        getm
    /* D68C0 800E60C0 03000524 */   addiu     $a1, $zero, 0x3
    /* D68C4 800E60C4 0000A2AE */  sw         $v0, 0x0($s5)
  .L800E60C8:
    /* D68C8 800E60C8 64980308 */  j          .L800E6190
    /* D68CC 800E60CC 06000226 */   addiu     $v0, $s0, 0x6
  .L800E60D0:
    /* D68D0 800E60D0 DDA7030C */  jal        strlen
    /* D68D4 800E60D4 06000426 */   addiu     $a0, $s0, 0x6
    /* D68D8 800E60D8 21100202 */  addu       $v0, $s0, $v0
    /* D68DC 800E60DC 07005024 */  addiu      $s0, $v0, 0x7
    /* D68E0 800E60E0 2B101202 */  sltu       $v0, $s0, $s2
    /* D68E4 800E60E4 E4FF4014 */  bnez       $v0, .L800E6078
    /* D68E8 800E60E8 01003126 */   addiu     $s1, $s1, 0x1
    /* D68EC 800E60EC 5E980308 */  j          .L800E6178
    /* D68F0 800E60F0 00000000 */   nop
  .L800E60F4:
    /* D68F4 800E60F4 10001026 */  addiu      $s0, $s0, 0x10
    /* D68F8 800E60F8 2B101202 */  sltu       $v0, $s0, $s2
    /* D68FC 800E60FC 1E004010 */  beqz       $v0, .L800E6178
    /* D6900 800E6100 00000000 */   nop
  .L800E6104:
    /* D6904 800E6104 05006016 */  bnez       $s3, .L800E611C
    /* D6908 800E6108 08000426 */   addiu     $a0, $s0, 0x8
    /* D690C 800E610C 07003612 */  beq        $s1, $s6, .L800E612C
    /* D6910 800E6110 00000000 */   nop
    /* D6914 800E6114 57980308 */  j          .L800E615C
    /* D6918 800E6118 00000000 */   nop
  .L800E611C:
    /* D691C 800E611C 48F9030C */  jal        stricmp
    /* D6920 800E6120 21286002 */   addu      $a1, $s3, $zero
    /* D6924 800E6124 0D004014 */  bnez       $v0, .L800E615C
    /* D6928 800E6128 00000000 */   nop
  .L800E612C:
    /* D692C 800E612C 04008012 */  beqz       $s4, .L800E6140
    /* D6930 800E6130 21200002 */   addu      $a0, $s0, $zero
    /* D6934 800E6134 09CC030C */  jal        getm
    /* D6938 800E6138 04000524 */   addiu     $a1, $zero, 0x4
    /* D693C 800E613C 000082AE */  sw         $v0, 0x0($s4)
  .L800E6140:
    /* D6940 800E6140 0400A012 */  beqz       $s5, .L800E6154
    /* D6944 800E6144 04000426 */   addiu     $a0, $s0, 0x4
    /* D6948 800E6148 09CC030C */  jal        getm
    /* D694C 800E614C 04000524 */   addiu     $a1, $zero, 0x4
    /* D6950 800E6150 0000A2AE */  sw         $v0, 0x0($s5)
  .L800E6154:
    /* D6954 800E6154 64980308 */  j          .L800E6190
    /* D6958 800E6158 08000226 */   addiu     $v0, $s0, 0x8
  .L800E615C:
    /* D695C 800E615C DDA7030C */  jal        strlen
    /* D6960 800E6160 08000426 */   addiu     $a0, $s0, 0x8
    /* D6964 800E6164 21100202 */  addu       $v0, $s0, $v0
    /* D6968 800E6168 09005024 */  addiu      $s0, $v0, 0x9
    /* D696C 800E616C 2B101202 */  sltu       $v0, $s0, $s2
    /* D6970 800E6170 E4FF4014 */  bnez       $v0, .L800E6104
    /* D6974 800E6174 01003126 */   addiu     $s1, $s1, 0x1
  .L800E6178:
    /* D6978 800E6178 02008012 */  beqz       $s4, .L800E6184
    /* D697C 800E617C 00000000 */   nop
    /* D6980 800E6180 000080AE */  sw         $zero, 0x0($s4)
  .L800E6184:
    /* D6984 800E6184 0200A012 */  beqz       $s5, .L800E6190
    /* D6988 800E6188 21100000 */   addu      $v0, $zero, $zero
    /* D698C 800E618C 0000A0AE */  sw         $zero, 0x0($s5)
  .L800E6190:
    /* D6990 800E6190 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* D6994 800E6194 2800B68F */  lw         $s6, 0x28($sp)
    /* D6998 800E6198 2400B58F */  lw         $s5, 0x24($sp)
    /* D699C 800E619C 2000B48F */  lw         $s4, 0x20($sp)
    /* D69A0 800E61A0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D69A4 800E61A4 1800B28F */  lw         $s2, 0x18($sp)
    /* D69A8 800E61A8 1400B18F */  lw         $s1, 0x14($sp)
    /* D69AC 800E61AC 1000B08F */  lw         $s0, 0x10($sp)
    /* D69B0 800E61B0 0800E003 */  jr         $ra
    /* D69B4 800E61B4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel locatebigentryz
