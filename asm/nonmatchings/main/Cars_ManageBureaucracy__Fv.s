.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_ManageBureaucracy__Fv, 0x1C8

glabel Cars_ManageBureaucracy__Fv
    /* 7B7FC 8008AFFC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 7B800 8008B000 2000B4AF */  sw         $s4, 0x20($sp)
    /* 7B804 8008B004 21A00000 */  addu       $s4, $zero, $zero
    /* 7B808 8008B008 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7B80C 8008B00C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 7B810 8008B010 DCF95324 */  addiu      $s3, $v0, %lo(Cars_gList)
    /* 7B814 8008B014 2400BFAF */  sw         $ra, 0x24($sp)
    /* 7B818 8008B018 1800B2AF */  sw         $s2, 0x18($sp)
    /* 7B81C 8008B01C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7B820 8008B020 1000B0AF */  sw         $s0, 0x10($sp)
  .L8008B024:
    /* 7B824 8008B024 A802828F */  lw         $v0, %gp_rel(Cars_gNumCars)($gp)
    /* 7B828 8008B028 00000000 */  nop
    /* 7B82C 8008B02C 2A108202 */  slt        $v0, $s4, $v0
    /* 7B830 8008B030 54004010 */  beqz       $v0, .L8008B184
    /* 7B834 8008B034 00000000 */   nop
    /* 7B838 8008B038 0000728E */  lw         $s2, 0x0($s3)
    /* 7B83C 8008B03C 00000000 */  nop
    /* 7B840 8008B040 91004292 */  lbu        $v0, 0x91($s2)
    /* 7B844 8008B044 00000000 */  nop
    /* 7B848 8008B048 4B004010 */  beqz       $v0, .L8008B178
    /* 7B84C 8008B04C 00000000 */   nop
    /* 7B850 8008B050 202B020C */  jal        Cars_CalculateRoadSpan__FP8Car_tObj
    /* 7B854 8008B054 21204002 */   addu      $a0, $s2, $zero
    /* 7B858 8008B058 21204002 */  addu       $a0, $s2, $zero
    /* 7B85C 8008B05C B22B020C */  jal        Cars_CalculateRoadPosition__FP8Car_tObj
    /* 7B860 8008B060 6C0242AE */   sw        $v0, 0x26C($s2)
    /* 7B864 8008B064 21204002 */  addu       $a0, $s2, $zero
    /* 7B868 8008B068 65CD010C */  jal        AIWorld_CalculateLaneInfo__FP8Car_tObj
    /* 7B86C 8008B06C 740542AE */   sw        $v0, 0x574($s2)
    /* 7B870 8008B070 BBA7010C */  jal        AIPhysics_UseCoolPhysics__FP8Car_tObj
    /* 7B874 8008B074 21204002 */   addu      $a0, $s2, $zero
    /* 7B878 8008B078 04004010 */  beqz       $v0, .L8008B08C
    /* 7B87C 8008B07C 00000000 */   nop
    /* 7B880 8008B080 BA2B020C */  jal        Cars_CalcVelDownRoad__FP8Car_tObj
    /* 7B884 8008B084 21204002 */   addu      $a0, $s2, $zero
    /* 7B888 8008B088 640542AE */  sw         $v0, 0x564($s2)
  .L8008B08C:
    /* 7B88C 8008B08C 6002428E */  lw         $v0, 0x260($s2)
    /* 7B890 8008B090 00000000 */  nop
    /* 7B894 8008B094 04004230 */  andi       $v0, $v0, 0x4
    /* 7B898 8008B098 2F004010 */  beqz       $v0, .L8008B158
    /* 7B89C 8008B09C 0200023C */   lui       $v0, (0x2FFFF >> 16)
    /* 7B8A0 8008B0A0 FFFF4234 */  ori        $v0, $v0, (0x2FFFF & 0xFFFF)
    /* 7B8A4 8008B0A4 0500033C */  lui        $v1, (0x5FFFE >> 16)
    /* 7B8A8 8008B0A8 FEFF6334 */  ori        $v1, $v1, (0x5FFFE & 0xFFFF)
    /* 7B8AC 8008B0AC 6405458E */  lw         $a1, 0x564($s2)
    /* 7B8B0 8008B0B0 C000448E */  lw         $a0, 0xC0($s2)
    /* 7B8B4 8008B0B4 2110A200 */  addu       $v0, $a1, $v0
    /* 7B8B8 8008B0B8 2B186200 */  sltu       $v1, $v1, $v0
    /* 7B8BC 8008B0BC 22006014 */  bnez       $v1, .L8008B148
    /* 7B8C0 8008B0C0 680544AE */   sw        $a0, 0x568($s2)
    /* 7B8C4 8008B0C4 0801448E */  lw         $a0, 0x108($s2)
    /* 7B8C8 8008B0C8 08004286 */  lh         $v0, 0x8($s2)
    /* 7B8CC 8008B0CC 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 7B8D0 8008B0D0 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 7B8D4 8008B0D4 40110200 */  sll        $v0, $v0, 5
    /* 7B8D8 8008B0D8 21104300 */  addu       $v0, $v0, $v1
    /* 7B8DC 8008B0DC 0F004580 */  lb         $a1, 0xF($v0)
    /* 7B8E0 8008B0E0 CA90030C */  jal        fixedmult
    /* 7B8E4 8008B0E4 00000000 */   nop
    /* 7B8E8 8008B0E8 0C01448E */  lw         $a0, 0x10C($s2)
    /* 7B8EC 8008B0EC 08004386 */  lh         $v1, 0x8($s2)
    /* 7B8F0 8008B0F0 1480053C */  lui        $a1, %hi(BWorldSm_slices)
    /* 7B8F4 8008B0F4 C0C7A58C */  lw         $a1, %lo(BWorldSm_slices)($a1)
    /* 7B8F8 8008B0F8 40190300 */  sll        $v1, $v1, 5
    /* 7B8FC 8008B0FC 21186500 */  addu       $v1, $v1, $a1
    /* 7B900 8008B100 10006580 */  lb         $a1, 0x10($v1)
    /* 7B904 8008B104 CA90030C */  jal        fixedmult
    /* 7B908 8008B108 21884000 */   addu      $s1, $v0, $zero
    /* 7B90C 8008B10C 1001448E */  lw         $a0, 0x110($s2)
    /* 7B910 8008B110 08004386 */  lh         $v1, 0x8($s2)
    /* 7B914 8008B114 1480053C */  lui        $a1, %hi(BWorldSm_slices)
    /* 7B918 8008B118 C0C7A58C */  lw         $a1, %lo(BWorldSm_slices)($a1)
    /* 7B91C 8008B11C 40190300 */  sll        $v1, $v1, 5
    /* 7B920 8008B120 21186500 */  addu       $v1, $v1, $a1
    /* 7B924 8008B124 11006580 */  lb         $a1, 0x11($v1)
    /* 7B928 8008B128 CA90030C */  jal        fixedmult
    /* 7B92C 8008B12C 21804000 */   addu      $s0, $v0, $zero
    /* 7B930 8008B130 21883002 */  addu       $s1, $s1, $s0
    /* 7B934 8008B134 21882202 */  addu       $s1, $s1, $v0
    /* 7B938 8008B138 0600201E */  bgtz       $s1, .L8008B154
    /* 7B93C 8008B13C 01000224 */   addiu     $v0, $zero, 0x1
    /* 7B940 8008B140 552C0208 */  j          .L8008B154
    /* 7B944 8008B144 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L8008B148:
    /* 7B948 8008B148 0200A004 */  bltz       $a1, .L8008B154
    /* 7B94C 8008B14C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 7B950 8008B150 01000224 */  addiu      $v0, $zero, 0x1
  .L8008B154:
    /* 7B954 8008B154 540542AE */  sw         $v0, 0x554($s2)
  .L8008B158:
    /* 7B958 8008B158 60004282 */  lb         $v0, 0x60($s2)
    /* 7B95C 8008B15C 00000000 */  nop
    /* 7B960 8008B160 05004010 */  beqz       $v0, .L8008B178
    /* 7B964 8008B164 00000000 */   nop
    /* 7B968 8008B168 F22A020C */  jal        Cars_FindCurrentLap__FP8Car_tObj
    /* 7B96C 8008B16C 21204002 */   addu      $a0, $s2, $zero
    /* 7B970 8008B170 D825020C */  jal        Cars_FindTotalSlice__FP8Car_tObj
    /* 7B974 8008B174 21204002 */   addu      $a0, $s2, $zero
  .L8008B178:
    /* 7B978 8008B178 04007326 */  addiu      $s3, $s3, 0x4
    /* 7B97C 8008B17C 092C0208 */  j          .L8008B024
    /* 7B980 8008B180 01009426 */   addiu     $s4, $s4, 0x1
  .L8008B184:
    /* 7B984 8008B184 A32C020C */  jal        Cars_SortCars__Fv
    /* 7B988 8008B188 00000000 */   nop
    /* 7B98C 8008B18C E12B020C */  jal        Cars_Randomize__Fv
    /* 7B990 8008B190 00000000 */   nop
    /* 7B994 8008B194 E9BB010C */  jal        AISpeeds_MaintainLeaderBoard__Fv
    /* 7B998 8008B198 00000000 */   nop
    /* 7B99C 8008B19C 021E030C */  jal        DrawW_DoObjectAnimations__Fv
    /* 7B9A0 8008B1A0 00000000 */   nop
    /* 7B9A4 8008B1A4 2400BF8F */  lw         $ra, 0x24($sp)
    /* 7B9A8 8008B1A8 2000B48F */  lw         $s4, 0x20($sp)
    /* 7B9AC 8008B1AC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 7B9B0 8008B1B0 1800B28F */  lw         $s2, 0x18($sp)
    /* 7B9B4 8008B1B4 1400B18F */  lw         $s1, 0x14($sp)
    /* 7B9B8 8008B1B8 1000B08F */  lw         $s0, 0x10($sp)
    /* 7B9BC 8008B1BC 0800E003 */  jr         $ra
    /* 7B9C0 8008B1C0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Cars_ManageBureaucracy__Fv
