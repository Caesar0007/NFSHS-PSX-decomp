.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Math_VectorLength2__FP8coorddef, 0x194

glabel Math_VectorLength2__FP8coorddef
    /* 8E088 8009D888 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 8E08C 8009D88C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 8E090 8009D890 21980000 */  addu       $s3, $zero, $zero
    /* 8E094 8009D894 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 8E098 8009D898 2800B6AF */  sw         $s6, 0x28($sp)
    /* 8E09C 8009D89C 2400B5AF */  sw         $s5, 0x24($sp)
    /* 8E0A0 8009D8A0 2000B4AF */  sw         $s4, 0x20($sp)
    /* 8E0A4 8009D8A4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8E0A8 8009D8A8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8E0AC 8009D8AC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8E0B0 8009D8B0 0000928C */  lw         $s2, 0x0($a0)
    /* 8E0B4 8009D8B4 0400918C */  lw         $s1, 0x4($a0)
    /* 8E0B8 8009D8B8 0800908C */  lw         $s0, 0x8($a0)
    /* 8E0BC 8009D8BC 02004106 */  bgez       $s2, .L8009D8C8
    /* 8E0C0 8009D8C0 21104002 */   addu      $v0, $s2, $zero
    /* 8E0C4 8009D8C4 23100200 */  negu       $v0, $v0
  .L8009D8C8:
    /* 8E0C8 8009D8C8 3C760208 */  j          .L8009D8F0
    /* 8E0CC 8009D8CC 0001033C */   lui       $v1, (0x1000000 >> 16)
  .L8009D8D0:
    /* 8E0D0 8009D8D0 43901200 */  sra        $s2, $s2, 1
    /* 8E0D4 8009D8D4 43881100 */  sra        $s1, $s1, 1
    /* 8E0D8 8009D8D8 43801000 */  sra        $s0, $s0, 1
    /* 8E0DC 8009D8DC 01007326 */  addiu      $s3, $s3, 0x1
    /* 8E0E0 8009D8E0 02004106 */  bgez       $s2, .L8009D8EC
    /* 8E0E4 8009D8E4 21104002 */   addu      $v0, $s2, $zero
    /* 8E0E8 8009D8E8 23100200 */  negu       $v0, $v0
  .L8009D8EC:
    /* 8E0EC 8009D8EC 0001033C */  lui        $v1, (0x1000000 >> 16)
  .L8009D8F0:
    /* 8E0F0 8009D8F0 2A106200 */  slt        $v0, $v1, $v0
    /* 8E0F4 8009D8F4 F6FF4014 */  bnez       $v0, .L8009D8D0
    /* 8E0F8 8009D8F8 00000000 */   nop
    /* 8E0FC 8009D8FC 02002106 */  bgez       $s1, .L8009D908
    /* 8E100 8009D900 21102002 */   addu      $v0, $s1, $zero
    /* 8E104 8009D904 23100200 */  negu       $v0, $v0
  .L8009D908:
    /* 8E108 8009D908 2A106200 */  slt        $v0, $v1, $v0
    /* 8E10C 8009D90C F0FF4014 */  bnez       $v0, .L8009D8D0
    /* 8E110 8009D910 00000000 */   nop
    /* 8E114 8009D914 02000106 */  bgez       $s0, .L8009D920
    /* 8E118 8009D918 21100002 */   addu      $v0, $s0, $zero
    /* 8E11C 8009D91C 23100200 */  negu       $v0, $v0
  .L8009D920:
    /* 8E120 8009D920 2A106200 */  slt        $v0, $v1, $v0
    /* 8E124 8009D924 EAFF4014 */  bnez       $v0, .L8009D8D0
    /* 8E128 8009D928 21204002 */   addu      $a0, $s2, $zero
    /* 8E12C 8009D92C CA90030C */  jal        fixedmult
    /* 8E130 8009D930 21284002 */   addu      $a1, $s2, $zero
    /* 8E134 8009D934 21A84000 */  addu       $s5, $v0, $zero
    /* 8E138 8009D938 21202002 */  addu       $a0, $s1, $zero
    /* 8E13C 8009D93C CA90030C */  jal        fixedmult
    /* 8E140 8009D940 21282002 */   addu      $a1, $s1, $zero
    /* 8E144 8009D944 21A04000 */  addu       $s4, $v0, $zero
    /* 8E148 8009D948 21200002 */  addu       $a0, $s0, $zero
    /* 8E14C 8009D94C CA90030C */  jal        fixedmult
    /* 8E150 8009D950 21280002 */   addu      $a1, $s0, $zero
    /* 8E154 8009D954 21304000 */  addu       $a2, $v0, $zero
    /* 8E158 8009D958 82101500 */  srl        $v0, $s5, 2
    /* 8E15C 8009D95C 82201400 */  srl        $a0, $s4, 2
    /* 8E160 8009D960 82280600 */  srl        $a1, $a2, 2
    /* 8E164 8009D964 21184400 */  addu       $v1, $v0, $a0
    /* 8E168 8009D968 21186500 */  addu       $v1, $v1, $a1
    /* 8E16C 8009D96C 0040023C */  lui        $v0, (0x40000000 >> 16)
    /* 8E170 8009D970 2B104300 */  sltu       $v0, $v0, $v1
    /* 8E174 8009D974 1A004010 */  beqz       $v0, .L8009D9E0
    /* 8E178 8009D978 2110B402 */   addu      $v0, $s5, $s4
    /* 8E17C 8009D97C 0040163C */  lui        $s6, (0x40000000 >> 16)
  .L8009D980:
    /* 8E180 8009D980 43901200 */  sra        $s2, $s2, 1
    /* 8E184 8009D984 43881100 */  sra        $s1, $s1, 1
    /* 8E188 8009D988 43801000 */  sra        $s0, $s0, 1
    /* 8E18C 8009D98C 01007326 */  addiu      $s3, $s3, 0x1
    /* 8E190 8009D990 21204002 */  addu       $a0, $s2, $zero
    /* 8E194 8009D994 CA90030C */  jal        fixedmult
    /* 8E198 8009D998 21284002 */   addu      $a1, $s2, $zero
    /* 8E19C 8009D99C 21A84000 */  addu       $s5, $v0, $zero
    /* 8E1A0 8009D9A0 21202002 */  addu       $a0, $s1, $zero
    /* 8E1A4 8009D9A4 CA90030C */  jal        fixedmult
    /* 8E1A8 8009D9A8 21282002 */   addu      $a1, $s1, $zero
    /* 8E1AC 8009D9AC 21A04000 */  addu       $s4, $v0, $zero
    /* 8E1B0 8009D9B0 21200002 */  addu       $a0, $s0, $zero
    /* 8E1B4 8009D9B4 CA90030C */  jal        fixedmult
    /* 8E1B8 8009D9B8 21280002 */   addu      $a1, $s0, $zero
    /* 8E1BC 8009D9BC 21304000 */  addu       $a2, $v0, $zero
    /* 8E1C0 8009D9C0 82101500 */  srl        $v0, $s5, 2
    /* 8E1C4 8009D9C4 82201400 */  srl        $a0, $s4, 2
    /* 8E1C8 8009D9C8 82280600 */  srl        $a1, $a2, 2
    /* 8E1CC 8009D9CC 21104400 */  addu       $v0, $v0, $a0
    /* 8E1D0 8009D9D0 21104500 */  addu       $v0, $v0, $a1
    /* 8E1D4 8009D9D4 2B10C202 */  sltu       $v0, $s6, $v0
    /* 8E1D8 8009D9D8 E9FF4014 */  bnez       $v0, .L8009D980
    /* 8E1DC 8009D9DC 2110B402 */   addu      $v0, $s5, $s4
  .L8009D9E0:
    /* 8E1E0 8009D9E0 04006012 */  beqz       $s3, .L8009D9F4
    /* 8E1E4 8009D9E4 21104600 */   addu      $v0, $v0, $a2
  .L8009D9E8:
    /* 8E1E8 8009D9E8 FFFF7326 */  addiu      $s3, $s3, -0x1
    /* 8E1EC 8009D9EC FEFF6016 */  bnez       $s3, .L8009D9E8
    /* 8E1F0 8009D9F0 80100200 */   sll       $v0, $v0, 2
  .L8009D9F4:
    /* 8E1F4 8009D9F4 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 8E1F8 8009D9F8 2800B68F */  lw         $s6, 0x28($sp)
    /* 8E1FC 8009D9FC 2400B58F */  lw         $s5, 0x24($sp)
    /* 8E200 8009DA00 2000B48F */  lw         $s4, 0x20($sp)
    /* 8E204 8009DA04 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 8E208 8009DA08 1800B28F */  lw         $s2, 0x18($sp)
    /* 8E20C 8009DA0C 1400B18F */  lw         $s1, 0x14($sp)
    /* 8E210 8009DA10 1000B08F */  lw         $s0, 0x10($sp)
    /* 8E214 8009DA14 0800E003 */  jr         $ra
    /* 8E218 8009DA18 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Math_VectorLength2__FP8coorddef
