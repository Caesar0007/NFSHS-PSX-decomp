.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching csin, 0x138

glabel csin
    /* E3FF8 800F37F8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E3FFC 800F37FC 21188000 */  addu       $v1, $a0, $zero
    /* E4000 800F3800 27006104 */  bgez       $v1, .L800F38A0
    /* E4004 800F3804 1800BFAF */   sw        $ra, 0x18($sp)
    /* E4008 800F3808 23180300 */  negu       $v1, $v1
    /* E400C 800F380C 02006104 */  bgez       $v1, .L800F3818
    /* E4010 800F3810 21106000 */   addu      $v0, $v1, $zero
    /* E4014 800F3814 FF0F6224 */  addiu      $v0, $v1, 0xFFF
  .L800F3818:
    /* E4018 800F3818 03130200 */  sra        $v0, $v0, 12
    /* E401C 800F381C 00130200 */  sll        $v0, $v0, 12
    /* E4020 800F3820 23186200 */  subu       $v1, $v1, $v0
    /* E4024 800F3824 0004622C */  sltiu      $v0, $v1, 0x400
    /* E4028 800F3828 06004014 */  bnez       $v0, .L800F3844
    /* E402C 800F382C 21206000 */   addu      $a0, $v1, $zero
    /* E4030 800F3830 00FC6224 */  addiu      $v0, $v1, -0x400
    /* E4034 800F3834 0004422C */  sltiu      $v0, $v0, 0x400
    /* E4038 800F3838 08004010 */  beqz       $v0, .L800F385C
    /* E403C 800F383C FF070424 */   addiu     $a0, $zero, 0x7FF
    /* E4040 800F3840 23208300 */  subu       $a0, $a0, $v1
  .L800F3844:
    /* E4044 800F3844 1000A527 */  addiu      $a1, $sp, 0x10
    /* E4048 800F3848 B11A040C */  jal        csincos
    /* E404C 800F384C 1400A627 */   addiu     $a2, $sp, 0x14
    /* E4050 800F3850 1000A68F */  lw         $a2, 0x10($sp)
    /* E4054 800F3854 48CE0308 */  j          .L800F3920
    /* E4058 800F3858 23100600 */   negu      $v0, $a2
  .L800F385C:
    /* E405C 800F385C 00F86424 */  addiu      $a0, $v1, -0x800
    /* E4060 800F3860 0004822C */  sltiu      $v0, $a0, 0x400
    /* E4064 800F3864 07004014 */  bnez       $v0, .L800F3884
    /* E4068 800F3868 1000A527 */   addiu     $a1, $sp, 0x10
    /* E406C 800F386C 00F46224 */  addiu      $v0, $v1, -0xC00
    /* E4070 800F3870 0004422C */  sltiu      $v0, $v0, 0x400
    /* E4074 800F3874 08004010 */  beqz       $v0, .L800F3898
    /* E4078 800F3878 FF0F0424 */   addiu     $a0, $zero, 0xFFF
    /* E407C 800F387C 23208300 */  subu       $a0, $a0, $v1
    /* E4080 800F3880 1000A527 */  addiu      $a1, $sp, 0x10
  .L800F3884:
    /* E4084 800F3884 B11A040C */  jal        csincos
    /* E4088 800F3888 1400A627 */   addiu     $a2, $sp, 0x14
    /* E408C 800F388C 1000A28F */  lw         $v0, 0x10($sp)
    /* E4090 800F3890 00000000 */  nop
    /* E4094 800F3894 23300200 */  negu       $a2, $v0
  .L800F3898:
    /* E4098 800F3898 48CE0308 */  j          .L800F3920
    /* E409C 800F389C 23100600 */   negu      $v0, $a2
  .L800F38A0:
    /* E40A0 800F38A0 03130300 */  sra        $v0, $v1, 12
    /* E40A4 800F38A4 00130200 */  sll        $v0, $v0, 12
    /* E40A8 800F38A8 23186200 */  subu       $v1, $v1, $v0
    /* E40AC 800F38AC 0004622C */  sltiu      $v0, $v1, 0x400
    /* E40B0 800F38B0 06004014 */  bnez       $v0, .L800F38CC
    /* E40B4 800F38B4 21206000 */   addu      $a0, $v1, $zero
    /* E40B8 800F38B8 00FC6224 */  addiu      $v0, $v1, -0x400
    /* E40BC 800F38BC 0004422C */  sltiu      $v0, $v0, 0x400
    /* E40C0 800F38C0 08004010 */  beqz       $v0, .L800F38E4
    /* E40C4 800F38C4 FF070424 */   addiu     $a0, $zero, 0x7FF
    /* E40C8 800F38C8 23208300 */  subu       $a0, $a0, $v1
  .L800F38CC:
    /* E40CC 800F38CC 1000A527 */  addiu      $a1, $sp, 0x10
    /* E40D0 800F38D0 B11A040C */  jal        csincos
    /* E40D4 800F38D4 1400A627 */   addiu     $a2, $sp, 0x14
    /* E40D8 800F38D8 1000A58F */  lw         $a1, 0x10($sp)
    /* E40DC 800F38DC 48CE0308 */  j          .L800F3920
    /* E40E0 800F38E0 2110A000 */   addu      $v0, $a1, $zero
  .L800F38E4:
    /* E40E4 800F38E4 00F86424 */  addiu      $a0, $v1, -0x800
    /* E40E8 800F38E8 0004822C */  sltiu      $v0, $a0, 0x400
    /* E40EC 800F38EC 05004014 */  bnez       $v0, .L800F3904
    /* E40F0 800F38F0 00F46224 */   addiu     $v0, $v1, -0xC00
    /* E40F4 800F38F4 0004422C */  sltiu      $v0, $v0, 0x400
    /* E40F8 800F38F8 08004010 */  beqz       $v0, .L800F391C
    /* E40FC 800F38FC FF0F0424 */   addiu     $a0, $zero, 0xFFF
    /* E4100 800F3900 23208300 */  subu       $a0, $a0, $v1
  .L800F3904:
    /* E4104 800F3904 1000A527 */  addiu      $a1, $sp, 0x10
    /* E4108 800F3908 B11A040C */  jal        csincos
    /* E410C 800F390C 1400A627 */   addiu     $a2, $sp, 0x14
    /* E4110 800F3910 1000A28F */  lw         $v0, 0x10($sp)
    /* E4114 800F3914 00000000 */  nop
    /* E4118 800F3918 23280200 */  negu       $a1, $v0
  .L800F391C:
    /* E411C 800F391C 2110A000 */  addu       $v0, $a1, $zero
  .L800F3920:
    /* E4120 800F3920 1800BF8F */  lw         $ra, 0x18($sp)
    /* E4124 800F3924 2000BD27 */  addiu      $sp, $sp, 0x20
    /* E4128 800F3928 0800E003 */  jr         $ra
    /* E412C 800F392C 00000000 */   nop
endlabel csin
    /* E4130 800F3930 00000000 */  nop
    /* E4134 800F3934 00000000 */  nop
