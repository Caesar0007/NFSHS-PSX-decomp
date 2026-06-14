.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj, 0x4EC

glabel Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj
    /* 93E74 800A3674 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* 93E78 800A3678 6800B2AF */  sw         $s2, 0x68($sp)
    /* 93E7C 800A367C 21908000 */  addu       $s2, $a0, $zero
    /* 93E80 800A3680 7800BFAF */  sw         $ra, 0x78($sp)
    /* 93E84 800A3684 7400B5AF */  sw         $s5, 0x74($sp)
    /* 93E88 800A3688 7000B4AF */  sw         $s4, 0x70($sp)
    /* 93E8C 800A368C 6C00B3AF */  sw         $s3, 0x6C($sp)
    /* 93E90 800A3690 6400B1AF */  sw         $s1, 0x64($sp)
    /* 93E94 800A3694 6000B0AF */  sw         $s0, 0x60($sp)
    /* 93E98 800A3698 91004292 */  lbu        $v0, 0x91($s2)
    /* 93E9C 800A369C 00000000 */  nop
    /* 93EA0 800A36A0 26014010 */  beqz       $v0, .L800A3B3C
    /* 93EA4 800A36A4 00481524 */   addiu     $s5, $zero, 0x4800
    /* 93EA8 800A36A8 5000A227 */  addiu      $v0, $sp, 0x50
    /* 93EAC 800A36AC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 93EB0 800A36B0 5400A227 */  addiu      $v0, $sp, 0x54
    /* 93EB4 800A36B4 1400A2AF */  sw         $v0, 0x14($sp)
    /* 93EB8 800A36B8 5800A227 */  addiu      $v0, $sp, 0x58
    /* 93EBC 800A36BC 1800A2AF */  sw         $v0, 0x18($sp)
    /* 93EC0 800A36C0 5C07428E */  lw         $v0, 0x75C($s2)
    /* 93EC4 800A36C4 01000424 */  addiu      $a0, $zero, 0x1
    /* 93EC8 800A36C8 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 93ECC 800A36CC 8C00468E */  lw         $a2, 0x8C($s2)
    /* 93ED0 800A36D0 0000478E */  lw         $a3, 0x0($s2)
    /* 93ED4 800A36D4 6FD8020C */  jal        Sched_ExecuteCheck__FiiiiPiN24i
    /* 93ED8 800A36D8 03000524 */   addiu     $a1, $zero, 0x3
    /* 93EDC 800A36DC 17014010 */  beqz       $v0, .L800A3B3C
    /* 93EE0 800A36E0 00000000 */   nop
    /* 93EE4 800A36E4 90004292 */  lbu        $v0, 0x90($s2)
    /* 93EE8 800A36E8 00000000 */  nop
    /* 93EEC 800A36EC 0200422C */  sltiu      $v0, $v0, 0x2
    /* 93EF0 800A36F0 0A004014 */  bnez       $v0, .L800A371C
    /* 93EF4 800A36F4 21204002 */   addu      $a0, $s2, $zero
    /* 93EF8 800A36F8 2000A527 */  addiu      $a1, $sp, 0x20
    /* 93EFC 800A36FC B00040AE */  sw         $zero, 0xB0($s2)
    /* 93F00 800A3700 987F020C */  jal        Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef
    /* 93F04 800A3704 7C0140A6 */   sh        $zero, 0x17C($s2)
    /* 93F08 800A3708 3801438E */  lw         $v1, 0x138($s2)
    /* 93F0C 800A370C 00000000 */  nop
    /* 93F10 800A3710 21104300 */  addu       $v0, $v0, $v1
    /* 93F14 800A3714 CF8E0208 */  j          .L800A3B3C
    /* 93F18 800A3718 A40042AE */   sw        $v0, 0xA4($s2)
  .L800A371C:
    /* 93F1C 800A371C E07F020C */  jal        Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
    /* 93F20 800A3720 2000A527 */   addiu     $a1, $sp, 0x20
    /* 93F24 800A3724 5400A48F */  lw         $a0, 0x54($sp)
    /* 93F28 800A3728 00000000 */  nop
    /* 93F2C 800A372C 18009500 */  mult       $a0, $s5
    /* 93F30 800A3730 2000A88F */  lw         $t0, 0x20($sp)
    /* 93F34 800A3734 2400A98F */  lw         $t1, 0x24($sp)
    /* 93F38 800A3738 2800AA8F */  lw         $t2, 0x28($sp)
    /* 93F3C 800A373C 3000A8AF */  sw         $t0, 0x30($sp)
    /* 93F40 800A3740 3400A9AF */  sw         $t1, 0x34($sp)
    /* 93F44 800A3744 3800AAAF */  sw         $t2, 0x38($sp)
    /* 93F48 800A3748 8001468E */  lw         $a2, 0x180($s2)
    /* 93F4C 800A374C 800142AE */  sw         $v0, 0x180($s2)
    /* 93F50 800A3750 12200000 */  mflo       $a0
    /* 93F54 800A3754 5000A38F */  lw         $v1, 0x50($sp)
    /* 93F58 800A3758 23104600 */  subu       $v0, $v0, $a2
    /* 93F5C 800A375C 18004300 */  mult       $v0, $v1
    /* 93F60 800A3760 8801548E */  lw         $s4, 0x188($s2)
    /* 93F64 800A3764 9400458E */  lw         $a1, 0x94($s2)
    /* 93F68 800A3768 12980000 */  mflo       $s3
    /* 93F6C 800A376C CA90030C */  jal        fixedmult
    /* 93F70 800A3770 00000000 */   nop
    /* 93F74 800A3774 B000438E */  lw         $v1, 0xB0($s2)
    /* 93F78 800A3778 FC00448E */  lw         $a0, 0xFC($s2)
    /* 93F7C 800A377C 23186200 */  subu       $v1, $v1, $v0
    /* 93F80 800A3780 B00043AE */  sw         $v1, 0xB0($s2)
    /* 93F84 800A3784 2000A58F */  lw         $a1, 0x20($sp)
    /* 93F88 800A3788 CA90030C */  jal        fixedmult
    /* 93F8C 800A378C 00000000 */   nop
    /* 93F90 800A3790 0001448E */  lw         $a0, 0x100($s2)
    /* 93F94 800A3794 2400A58F */  lw         $a1, 0x24($sp)
    /* 93F98 800A3798 CA90030C */  jal        fixedmult
    /* 93F9C 800A379C 21804000 */   addu      $s0, $v0, $zero
    /* 93FA0 800A37A0 0401448E */  lw         $a0, 0x104($s2)
    /* 93FA4 800A37A4 2800A58F */  lw         $a1, 0x28($sp)
    /* 93FA8 800A37A8 CA90030C */  jal        fixedmult
    /* 93FAC 800A37AC 21884000 */   addu      $s1, $v0, $zero
    /* 93FB0 800A37B0 21204002 */  addu       $a0, $s2, $zero
    /* 93FB4 800A37B4 3000A527 */  addiu      $a1, $sp, 0x30
    /* 93FB8 800A37B8 21801102 */  addu       $s0, $s0, $s1
    /* 93FBC 800A37BC 21800202 */  addu       $s0, $s0, $v0
    /* 93FC0 800A37C0 21300002 */  addu       $a2, $s0, $zero
    /* 93FC4 800A37C4 C688020C */  jal        Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi
    /* 93FC8 800A37C8 2C0146AE */   sw        $a2, 0x12C($s2)
    /* 93FCC 800A37CC AC00448E */  lw         $a0, 0xAC($s2)
    /* 93FD0 800A37D0 B400458E */  lw         $a1, 0xB4($s2)
    /* 93FD4 800A37D4 02008104 */  bgez       $a0, .L800A37E0
    /* 93FD8 800A37D8 00000000 */   nop
    /* 93FDC 800A37DC 23200400 */  negu       $a0, $a0
  .L800A37E0:
    /* 93FE0 800A37E0 0200A104 */  bgez       $a1, .L800A37EC
    /* 93FE4 800A37E4 00000000 */   nop
    /* 93FE8 800A37E8 23280500 */  negu       $a1, $a1
  .L800A37EC:
    /* 93FEC 800A37EC 3275020C */  jal        Math_BetterDist__Fii
    /* 93FF0 800A37F0 00000000 */   nop
    /* 93FF4 800A37F4 7401448E */  lw         $a0, 0x174($s2)
    /* 93FF8 800A37F8 C00042AE */  sw         $v0, 0xC0($s2)
    /* 93FFC 800A37FC 8401428E */  lw         $v0, 0x184($s2)
    /* 94000 800A3800 C0180400 */  sll        $v1, $a0, 3
    /* 94004 800A3804 23186400 */  subu       $v1, $v1, $a0
    /* 94008 800A3808 23106202 */  subu       $v0, $s3, $v0
    /* 9400C 800A380C 21106200 */  addu       $v0, $v1, $v0
    /* 94010 800A3810 02004104 */  bgez       $v0, .L800A381C
    /* 94014 800A3814 2000B027 */   addiu     $s0, $sp, 0x20
    /* 94018 800A3818 07004224 */  addiu      $v0, $v0, 0x7
  .L800A381C:
    /* 9401C 800A381C C3100200 */  sra        $v0, $v0, 3
    /* 94020 800A3820 740142AE */  sw         $v0, 0x174($s2)
    /* 94024 800A3824 3333822A */  slti       $v0, $s4, 0x3333
    /* 94028 800A3828 11004014 */  bnez       $v0, .L800A3870
    /* 9402C 800A382C 840153AE */   sw        $s3, 0x184($s2)
    /* 94030 800A3830 5400A48F */  lw         $a0, 0x54($sp)
    /* 94034 800A3834 00000000 */  nop
    /* 94038 800A3838 18009500 */  mult       $a0, $s5
    /* 9403C 800A383C 9400458E */  lw         $a1, 0x94($s2)
    /* 94040 800A3840 7C014296 */  lhu        $v0, 0x17C($s2)
    /* 94044 800A3844 5400A397 */  lhu        $v1, 0x54($sp)
    /* 94048 800A3848 740140AE */  sw         $zero, 0x174($s2)
    /* 9404C 800A384C 21104300 */  addu       $v0, $v0, $v1
    /* 94050 800A3850 12200000 */  mflo       $a0
    /* 94054 800A3854 CA90030C */  jal        fixedmult
    /* 94058 800A3858 7C0142A6 */   sh        $v0, 0x17C($s2)
    /* 9405C 800A385C B000438E */  lw         $v1, 0xB0($s2)
    /* 94060 800A3860 00000000 */  nop
    /* 94064 800A3864 23186200 */  subu       $v1, $v1, $v0
    /* 94068 800A3868 BB8E0208 */  j          .L800A3AEC
    /* 9406C 800A386C B00043AE */   sw        $v1, 0xB0($s2)
  .L800A3870:
    /* 94070 800A3870 7C014296 */  lhu        $v0, 0x17C($s2)
    /* 94074 800A3874 00000000 */  nop
    /* 94078 800A3878 64004010 */  beqz       $v0, .L800A3A0C
    /* 9407C 800A387C 00000000 */   nop
    /* 94080 800A3880 6002428E */  lw         $v0, 0x260($s2)
    /* 94084 800A3884 00000000 */  nop
    /* 94088 800A3888 04004230 */  andi       $v0, $v0, 0x4
    /* 9408C 800A388C 03004010 */  beqz       $v0, .L800A389C
    /* 94090 800A3890 00000000 */   nop
    /* 94094 800A3894 39A9020C */  jal        Physics_FixEngineRpm__FP8Car_tObj
    /* 94098 800A3898 21204002 */   addu      $a0, $s2, $zero
  .L800A389C:
    /* 9409C 800A389C B000428E */  lw         $v0, 0xB0($s2)
    /* 940A0 800A38A0 2C01438E */  lw         $v1, 0x12C($s2)
    /* 940A4 800A38A4 23306202 */  subu       $a2, $s3, $v0
    /* 940A8 800A38A8 33B30234 */  ori        $v0, $zero, 0xB333
    /* 940AC 800A38AC 2A104300 */  slt        $v0, $v0, $v1
    /* 940B0 800A38B0 20004014 */  bnez       $v0, .L800A3934
    /* 940B4 800A38B4 21180000 */   addu      $v1, $zero, $zero
    /* 940B8 800A38B8 21204002 */  addu       $a0, $s2, $zero
    /* 940BC 800A38BC 21280002 */  addu       $a1, $s0, $zero
    /* 940C0 800A38C0 6801488E */  lw         $t0, 0x168($s2)
    /* 940C4 800A38C4 6C01498E */  lw         $t1, 0x16C($s2)
    /* 940C8 800A38C8 70014A8E */  lw         $t2, 0x170($s2)
    /* 940CC 800A38CC 4000A8AF */  sw         $t0, 0x40($sp)
    /* 940D0 800A38D0 4400A9AF */  sw         $t1, 0x44($sp)
    /* 940D4 800A38D4 4800AAAF */  sw         $t2, 0x48($sp)
    /* 940D8 800A38D8 4400A28F */  lw         $v0, 0x44($sp)
    /* 940DC 800A38DC 4000A627 */  addiu      $a2, $sp, 0x40
    /* 940E0 800A38E0 67E64224 */  addiu      $v0, $v0, -0x1999
    /* 940E4 800A38E4 6A36020C */  jal        Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1
    /* 940E8 800A38E8 4400A2AF */   sw        $v0, 0x44($sp)
    /* 940EC 800A38EC 9001438E */  lw         $v1, 0x190($s2)
    /* 940F0 800A38F0 0500023C */  lui        $v0, (0x50000 >> 16)
    /* 940F4 800A38F4 2A104300 */  slt        $v0, $v0, $v1
    /* 940F8 800A38F8 07004010 */  beqz       $v0, .L800A3918
    /* 940FC 800A38FC 1300023C */   lui       $v0, (0x13FFFF >> 16)
    /* 94100 800A3900 FFFF4234 */  ori        $v0, $v0, (0x13FFFF & 0xFFFF)
    /* 94104 800A3904 2A104300 */  slt        $v0, $v0, $v1
    /* 94108 800A3908 02004010 */  beqz       $v0, .L800A3914
    /* 9410C 800A390C 1400043C */   lui       $a0, (0x140000 >> 16)
    /* 94110 800A3910 21206000 */  addu       $a0, $v1, $zero
  .L800A3914:
    /* 94114 800A3914 900144AE */  sw         $a0, 0x190($s2)
  .L800A3918:
    /* 94118 800A3918 2C01428E */  lw         $v0, 0x12C($s2)
    /* 9411C 800A391C 00000000 */  nop
    /* 94120 800A3920 33334228 */  slti       $v0, $v0, 0x3333
    /* 94124 800A3924 35004010 */  beqz       $v0, .L800A39FC
    /* 94128 800A3928 01000224 */   addiu     $v0, $zero, 0x1
    /* 9412C 800A392C 7F8E0208 */  j          .L800A39FC
    /* 94130 800A3930 8C0742AE */   sw        $v0, 0x78C($s2)
  .L800A3934:
    /* 94134 800A3934 21286000 */  addu       $a1, $v1, $zero
    /* 94138 800A3938 21204002 */  addu       $a0, $s2, $zero
  .L800A393C:
    /* 9413C 800A393C A802828C */  lw         $v0, 0x2A8($a0)
    /* 94140 800A3940 0100A524 */  addiu      $a1, $a1, 0x1
    /* 94144 800A3944 21186200 */  addu       $v1, $v1, $v0
    /* 94148 800A3948 0400A228 */  slti       $v0, $a1, 0x4
    /* 9414C 800A394C FBFF4014 */  bnez       $v0, .L800A393C
    /* 94150 800A3950 30008424 */   addiu     $a0, $a0, 0x30
    /* 94154 800A3954 29006018 */  blez       $v1, .L800A39FC
    /* 94158 800A3958 40100300 */   sll       $v0, $v1, 1
    /* 9415C 800A395C 21104300 */  addu       $v0, $v0, $v1
    /* 94160 800A3960 02004104 */  bgez       $v0, .L800A396C
    /* 94164 800A3964 00000000 */   nop
    /* 94168 800A3968 03004224 */  addiu      $v0, $v0, 0x3
  .L800A396C:
    /* 9416C 800A396C 83100200 */  sra        $v0, $v0, 2
    /* 94170 800A3970 A400438E */  lw         $v1, 0xA4($s2)
    /* 94174 800A3974 21106202 */  addu       $v0, $s3, $v0
    /* 94178 800A3978 B00042AE */  sw         $v0, 0xB0($s2)
    /* 9417C 800A397C 40100600 */  sll        $v0, $a2, 1
    /* 94180 800A3980 900142AE */  sw         $v0, 0x190($s2)
    /* 94184 800A3984 7C0140A6 */  sh         $zero, 0x17C($s2)
    /* 94188 800A3988 23187400 */  subu       $v1, $v1, $s4
    /* 9418C 800A398C CC0C1424 */  addiu      $s4, $zero, 0xCCC
    /* 94190 800A3990 A40043AE */  sw         $v1, 0xA4($s2)
    /* 94194 800A3994 21184000 */  addu       $v1, $v0, $zero
    /* 94198 800A3998 1400023C */  lui        $v0, (0x140000 >> 16)
    /* 9419C 800A399C 2A104300 */  slt        $v0, $v0, $v1
    /* 941A0 800A39A0 0F004010 */  beqz       $v0, .L800A39E0
    /* 941A4 800A39A4 880154AE */   sw        $s4, 0x188($s2)
    /* 941A8 800A39A8 21204002 */  addu       $a0, $s2, $zero
    /* 941AC 800A39AC 09000624 */  addiu      $a2, $zero, 0x9
    /* 941B0 800A39B0 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 941B4 800A39B4 980142AE */  sw         $v0, 0x198($s2)
    /* 941B8 800A39B8 940140AE */  sw         $zero, 0x194($s2)
    /* 941BC 800A39BC A000488E */  lw         $t0, 0xA0($s2)
    /* 941C0 800A39C0 A400498E */  lw         $t1, 0xA4($s2)
    /* 941C4 800A39C4 A8004A8E */  lw         $t2, 0xA8($s2)
    /* 941C8 800A39C8 A00148AE */  sw         $t0, 0x1A0($s2)
    /* 941CC 800A39CC A40149AE */  sw         $t1, 0x1A4($s2)
    /* 941D0 800A39D0 A8014AAE */  sw         $t2, 0x1A8($s2)
    /* 941D4 800A39D4 9001458E */  lw         $a1, 0x190($s2)
    /* 941D8 800A39D8 CB7B020C */  jal        Newton_AddDamageZone__FP13BO_tNewtonObjiii
    /* 941DC 800A39DC 21380000 */   addu      $a3, $zero, $zero
  .L800A39E0:
    /* 941E0 800A39E0 562C030C */  jal        Force_IsForceOn__FP8Car_tObj
    /* 941E4 800A39E4 21204002 */   addu      $a0, $s2, $zero
    /* 941E8 800A39E8 04004010 */  beqz       $v0, .L800A39FC
    /* 941EC 800A39EC 00000000 */   nop
    /* 941F0 800A39F0 9001448E */  lw         $a0, 0x190($s2)
    /* 941F4 800A39F4 812C030C */  jal        Force_HitWall__Fi
    /* 941F8 800A39F8 00000000 */   nop
  .L800A39FC:
    /* 941FC 800A39FC 778D020C */  jal        Newton_LimitAngularVelocity__FP13BO_tNewtonObj
    /* 94200 800A3A00 21204002 */   addu      $a0, $s2, $zero
    /* 94204 800A3A04 868E0208 */  j          .L800A3A18
    /* 94208 800A3A08 3D0A822A */   slti      $v0, $s4, 0xA3D
  .L800A3A0C:
    /* 9420C 800A3A0C 8B8A020C */  jal        Newton_CheckForSpikeBelts__FP13BO_tNewtonObj
    /* 94210 800A3A10 21204002 */   addu      $a0, $s2, $zero
    /* 94214 800A3A14 3D0A822A */  slti       $v0, $s4, 0xA3D
  .L800A3A18:
    /* 94218 800A3A18 35004010 */  beqz       $v0, .L800A3AF0
    /* 9421C 800A3A1C 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 94220 800A3A20 A400428E */  lw         $v0, 0xA4($s2)
    /* 94224 800A3A24 6002438E */  lw         $v1, 0x260($s2)
    /* 94228 800A3A28 880140AE */  sw         $zero, 0x188($s2)
    /* 9422C 800A3A2C 23105400 */  subu       $v0, $v0, $s4
    /* 94230 800A3A30 00046330 */  andi       $v1, $v1, 0x400
    /* 94234 800A3A34 07006014 */  bnez       $v1, .L800A3A54
    /* 94238 800A3A38 A40042AE */   sw        $v0, 0xA4($s2)
    /* 9423C 800A3A3C 2C01438E */  lw         $v1, 0x12C($s2)
    /* 94240 800A3A40 66E60234 */  ori        $v0, $zero, 0xE666
    /* 94244 800A3A44 2A104300 */  slt        $v0, $v0, $v1
    /* 94248 800A3A48 03004010 */  beqz       $v0, .L800A3A58
    /* 9424C 800A3A4C 0500023C */   lui       $v0, (0x5FFFF >> 16)
    /* 94250 800A3A50 7C0140A6 */  sh         $zero, 0x17C($s2)
  .L800A3A54:
    /* 94254 800A3A54 0500023C */  lui        $v0, (0x5FFFF >> 16)
  .L800A3A58:
    /* 94258 800A3A58 FFFF4234 */  ori        $v0, $v0, (0x5FFFF & 0xFFFF)
    /* 9425C 800A3A5C 2A105300 */  slt        $v0, $v0, $s3
    /* 94260 800A3A60 0D004010 */  beqz       $v0, .L800A3A98
    /* 94264 800A3A64 0C00023C */   lui       $v0, (0xC0000 >> 16)
    /* 94268 800A3A68 2A105300 */  slt        $v0, $v0, $s3
    /* 9426C 800A3A6C 02004010 */  beqz       $v0, .L800A3A78
    /* 94270 800A3A70 DFFF1034 */   ori       $s0, $zero, 0xFFDF
    /* 94274 800A3A74 BEFF1034 */  ori        $s0, $zero, 0xFFBE
  .L800A3A78:
    /* 94278 800A3A78 AC00448E */  lw         $a0, 0xAC($s2)
    /* 9427C 800A3A7C CA90030C */  jal        fixedmult
    /* 94280 800A3A80 21280002 */   addu      $a1, $s0, $zero
    /* 94284 800A3A84 B400448E */  lw         $a0, 0xB4($s2)
    /* 94288 800A3A88 21280002 */  addu       $a1, $s0, $zero
    /* 9428C 800A3A8C CA90030C */  jal        fixedmult
    /* 94290 800A3A90 AC0042AE */   sw        $v0, 0xAC($s2)
    /* 94294 800A3A94 B40042AE */  sw         $v0, 0xB4($s2)
  .L800A3A98:
    /* 94298 800A3A98 0400023C */  lui        $v0, (0x4FFFF >> 16)
    /* 9429C 800A3A9C C000438E */  lw         $v1, 0xC0($s2)
    /* 942A0 800A3AA0 FFFF4234 */  ori        $v0, $v0, (0x4FFFF & 0xFFFF)
    /* 942A4 800A3AA4 2A104300 */  slt        $v0, $v0, $v1
    /* 942A8 800A3AA8 07004014 */  bnez       $v0, .L800A3AC8
    /* 942AC 800A3AAC 0900023C */   lui       $v0, (0x9FFFF >> 16)
    /* 942B0 800A3AB0 02006106 */  bgez       $s3, .L800A3ABC
    /* 942B4 800A3AB4 21106002 */   addu      $v0, $s3, $zero
    /* 942B8 800A3AB8 03006226 */  addiu      $v0, $s3, 0x3
  .L800A3ABC:
    /* 942BC 800A3ABC 83100200 */  sra        $v0, $v0, 2
    /* 942C0 800A3AC0 BB8E0208 */  j          .L800A3AEC
    /* 942C4 800A3AC4 B00042AE */   sw        $v0, 0xB0($s2)
  .L800A3AC8:
    /* 942C8 800A3AC8 FFFF4234 */  ori        $v0, $v0, (0x9FFFF & 0xFFFF)
    /* 942CC 800A3ACC 2A104300 */  slt        $v0, $v0, $v1
    /* 942D0 800A3AD0 05004014 */  bnez       $v0, .L800A3AE8
    /* 942D4 800A3AD4 C2171300 */   srl       $v0, $s3, 31
    /* 942D8 800A3AD8 21106202 */  addu       $v0, $s3, $v0
    /* 942DC 800A3ADC 43100200 */  sra        $v0, $v0, 1
    /* 942E0 800A3AE0 BB8E0208 */  j          .L800A3AEC
    /* 942E4 800A3AE4 B00042AE */   sw        $v0, 0xB0($s2)
  .L800A3AE8:
    /* 942E8 800A3AE8 B00053AE */  sw         $s3, 0xB0($s2)
  .L800A3AEC:
    /* 942EC 800A3AEC 1280023C */  lui        $v0, %hi(D_8011E0B0)
  .L800A3AF0:
    /* 942F0 800A3AF0 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 942F4 800A3AF4 08004426 */  addiu      $a0, $s2, 0x8
    /* 942F8 800A3AF8 F5FF010C */  jal        BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
    /* 942FC 800A3AFC 9C0042AE */   sw        $v0, 0x9C($s2)
    /* 94300 800A3B00 0E004010 */  beqz       $v0, .L800A3B3C
    /* 94304 800A3B04 00000000 */   nop
    /* 94308 800A3B08 B000448E */  lw         $a0, 0xB0($s2)
    /* 9430C 800A3B0C 00000000 */  nop
    /* 94310 800A3B10 0A008018 */  blez       $a0, .L800A3B3C
    /* 94314 800A3B14 00000000 */   nop
    /* 94318 800A3B18 A400428E */  lw         $v0, 0xA4($s2)
    /* 9431C 800A3B1C 6C01438E */  lw         $v1, 0x16C($s2)
    /* 94320 800A3B20 00000000 */  nop
    /* 94324 800A3B24 23104300 */  subu       $v0, $v0, $v1
    /* 94328 800A3B28 0800033C */  lui        $v1, (0x80000 >> 16)
    /* 9432C 800A3B2C 2A186200 */  slt        $v1, $v1, $v0
    /* 94330 800A3B30 02006010 */  beqz       $v1, .L800A3B3C
    /* 94334 800A3B34 23100400 */   negu      $v0, $a0
    /* 94338 800A3B38 B00042AE */  sw         $v0, 0xB0($s2)
  .L800A3B3C:
    /* 9433C 800A3B3C 7800BF8F */  lw         $ra, 0x78($sp)
    /* 94340 800A3B40 7400B58F */  lw         $s5, 0x74($sp)
    /* 94344 800A3B44 7000B48F */  lw         $s4, 0x70($sp)
    /* 94348 800A3B48 6C00B38F */  lw         $s3, 0x6C($sp)
    /* 9434C 800A3B4C 6800B28F */  lw         $s2, 0x68($sp)
    /* 94350 800A3B50 6400B18F */  lw         $s1, 0x64($sp)
    /* 94354 800A3B54 6000B08F */  lw         $s0, 0x60($sp)
    /* 94358 800A3B58 0800E003 */  jr         $ra
    /* 9435C 800A3B5C 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj
