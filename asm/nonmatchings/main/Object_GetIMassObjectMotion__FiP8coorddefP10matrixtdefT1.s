.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_GetIMassObjectMotion__FiP8coorddefP10matrixtdefT1, 0x1BC

glabel Object_GetIMassObjectMotion__FiP8coorddefP10matrixtdefT1
    /* 9683C 800A603C 8C0D828F */  lw         $v0, %gp_rel(Object_IMassObjInst)($gp)
    /* 96840 800A6040 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 96844 800A6044 2800B4AF */  sw         $s4, 0x28($sp)
    /* 96848 800A6048 21A08000 */  addu       $s4, $a0, $zero
    /* 9684C 800A604C 2400B3AF */  sw         $s3, 0x24($sp)
    /* 96850 800A6050 2198A000 */  addu       $s3, $a1, $zero
    /* 96854 800A6054 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 96858 800A6058 2188C000 */  addu       $s1, $a2, $zero
    /* 9685C 800A605C 1800B0AF */  sw         $s0, 0x18($sp)
    /* 96860 800A6060 40811400 */  sll        $s0, $s4, 5
    /* 96864 800A6064 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 96868 800A6068 2000B2AF */  sw         $s2, 0x20($sp)
    /* 9686C 800A606C 21100202 */  addu       $v0, $s0, $v0
    /* 96870 800A6070 0000448C */  lw         $a0, 0x0($v0)
    /* 96874 800A6074 911D030C */  jal        DrawW_GetAnimationTime__FP15Trk_AnimateInst
    /* 96878 800A6078 2190E000 */   addu      $s2, $a3, $zero
    /* 9687C 800A607C 1000B1AF */  sw         $s1, 0x10($sp)
    /* 96880 800A6080 21884000 */  addu       $s1, $v0, $zero
    /* 96884 800A6084 01000524 */  addiu      $a1, $zero, 0x1
    /* 96888 800A6088 8C0D838F */  lw         $v1, %gp_rel(Object_IMassObjInst)($gp)
    /* 9688C 800A608C 21302002 */  addu       $a2, $s1, $zero
    /* 96890 800A6090 21180302 */  addu       $v1, $s0, $v1
    /* 96894 800A6094 0000648C */  lw         $a0, 0x0($v1)
    /* 96898 800A6098 C6CF010C */  jal        Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef
    /* 9689C 800A609C 21386002 */   addu      $a3, $s3, $zero
    /* 968A0 800A60A0 8C0D828F */  lw         $v0, %gp_rel(Object_IMassObjInst)($gp)
    /* 968A4 800A60A4 00000000 */  nop
    /* 968A8 800A60A8 21800202 */  addu       $s0, $s0, $v0
    /* 968AC 800A60AC 1C00028E */  lw         $v0, 0x1C($s0)
    /* 968B0 800A60B0 00000000 */  nop
    /* 968B4 800A60B4 23202202 */  subu       $a0, $s1, $v0
    /* 968B8 800A60B8 38008018 */  blez       $a0, .L800A619C
    /* 968BC 800A60BC 00000000 */   nop
    /* 968C0 800A60C0 0000628E */  lw         $v0, 0x0($s3)
    /* 968C4 800A60C4 1000038E */  lw         $v1, 0x10($s0)
    /* 968C8 800A60C8 00000000 */  nop
    /* 968CC 800A60CC 23104300 */  subu       $v0, $v0, $v1
    /* 968D0 800A60D0 1A004400 */  div        $zero, $v0, $a0
    /* 968D4 800A60D4 02008014 */  bnez       $a0, .L800A60E0
    /* 968D8 800A60D8 00000000 */   nop
    /* 968DC 800A60DC 0D000700 */  break      7
  .L800A60E0:
    /* 968E0 800A60E0 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 968E4 800A60E4 04008114 */  bne        $a0, $at, .L800A60F8
    /* 968E8 800A60E8 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 968EC 800A60EC 02004114 */  bne        $v0, $at, .L800A60F8
    /* 968F0 800A60F0 00000000 */   nop
    /* 968F4 800A60F4 0D000600 */  break      6
  .L800A60F8:
    /* 968F8 800A60F8 12100000 */  mflo       $v0
    /* 968FC 800A60FC 00000000 */  nop
    /* 96900 800A6100 80110200 */  sll        $v0, $v0, 6
    /* 96904 800A6104 000042AE */  sw         $v0, 0x0($s2)
    /* 96908 800A6108 0400628E */  lw         $v0, 0x4($s3)
    /* 9690C 800A610C 1400038E */  lw         $v1, 0x14($s0)
    /* 96910 800A6110 00000000 */  nop
    /* 96914 800A6114 23104300 */  subu       $v0, $v0, $v1
    /* 96918 800A6118 1A004400 */  div        $zero, $v0, $a0
    /* 9691C 800A611C 02008014 */  bnez       $a0, .L800A6128
    /* 96920 800A6120 00000000 */   nop
    /* 96924 800A6124 0D000700 */  break      7
  .L800A6128:
    /* 96928 800A6128 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 9692C 800A612C 04008114 */  bne        $a0, $at, .L800A6140
    /* 96930 800A6130 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 96934 800A6134 02004114 */  bne        $v0, $at, .L800A6140
    /* 96938 800A6138 00000000 */   nop
    /* 9693C 800A613C 0D000600 */  break      6
  .L800A6140:
    /* 96940 800A6140 12100000 */  mflo       $v0
    /* 96944 800A6144 00000000 */  nop
    /* 96948 800A6148 80110200 */  sll        $v0, $v0, 6
    /* 9694C 800A614C 040042AE */  sw         $v0, 0x4($s2)
    /* 96950 800A6150 0800628E */  lw         $v0, 0x8($s3)
    /* 96954 800A6154 1800038E */  lw         $v1, 0x18($s0)
    /* 96958 800A6158 00000000 */  nop
    /* 9695C 800A615C 23104300 */  subu       $v0, $v0, $v1
    /* 96960 800A6160 1A004400 */  div        $zero, $v0, $a0
    /* 96964 800A6164 02008014 */  bnez       $a0, .L800A6170
    /* 96968 800A6168 00000000 */   nop
    /* 9696C 800A616C 0D000700 */  break      7
  .L800A6170:
    /* 96970 800A6170 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 96974 800A6174 04008114 */  bne        $a0, $at, .L800A6188
    /* 96978 800A6178 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 9697C 800A617C 02004114 */  bne        $v0, $at, .L800A6188
    /* 96980 800A6180 00000000 */   nop
    /* 96984 800A6184 0D000600 */  break      6
  .L800A6188:
    /* 96988 800A6188 12100000 */  mflo       $v0
    /* 9698C 800A618C 00000000 */  nop
    /* 96990 800A6190 80110200 */  sll        $v0, $v0, 6
    /* 96994 800A6194 6A980208 */  j          .L800A61A8
    /* 96998 800A6198 080042AE */   sw        $v0, 0x8($s2)
  .L800A619C:
    /* 9699C 800A619C 000040AE */  sw         $zero, 0x0($s2)
    /* 969A0 800A61A0 040040AE */  sw         $zero, 0x4($s2)
    /* 969A4 800A61A4 080040AE */  sw         $zero, 0x8($s2)
  .L800A61A8:
    /* 969A8 800A61A8 8C0D828F */  lw         $v0, %gp_rel(Object_IMassObjInst)($gp)
    /* 969AC 800A61AC 40191400 */  sll        $v1, $s4, 5
    /* 969B0 800A61B0 21204000 */  addu       $a0, $v0, $zero
    /* 969B4 800A61B4 21106200 */  addu       $v0, $v1, $v0
    /* 969B8 800A61B8 21186400 */  addu       $v1, $v1, $a0
    /* 969BC 800A61BC 0000688E */  lw         $t0, 0x0($s3)
    /* 969C0 800A61C0 0400698E */  lw         $t1, 0x4($s3)
    /* 969C4 800A61C4 08006A8E */  lw         $t2, 0x8($s3)
    /* 969C8 800A61C8 100048AC */  sw         $t0, 0x10($v0)
    /* 969CC 800A61CC 140049AC */  sw         $t1, 0x14($v0)
    /* 969D0 800A61D0 18004AAC */  sw         $t2, 0x18($v0)
    /* 969D4 800A61D4 1C0071AC */  sw         $s1, 0x1C($v1)
    /* 969D8 800A61D8 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 969DC 800A61DC 2800B48F */  lw         $s4, 0x28($sp)
    /* 969E0 800A61E0 2400B38F */  lw         $s3, 0x24($sp)
    /* 969E4 800A61E4 2000B28F */  lw         $s2, 0x20($sp)
    /* 969E8 800A61E8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 969EC 800A61EC 1800B08F */  lw         $s0, 0x18($sp)
    /* 969F0 800A61F0 0800E003 */  jr         $ra
    /* 969F4 800A61F4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Object_GetIMassObjectMotion__FiP8coorddefP10matrixtdefT1
