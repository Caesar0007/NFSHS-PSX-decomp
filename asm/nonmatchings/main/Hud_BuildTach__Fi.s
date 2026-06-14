.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildTach__Fi, 0x434

glabel Hud_BuildTach__Fi
    /* C4694 800D3E94 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* C4698 800D3E98 3400B1AF */  sw         $s1, 0x34($sp)
    /* C469C 800D3E9C 21888000 */  addu       $s1, $a0, $zero
    /* C46A0 800D3EA0 5400BFAF */  sw         $ra, 0x54($sp)
    /* C46A4 800D3EA4 5000BEAF */  sw         $fp, 0x50($sp)
    /* C46A8 800D3EA8 4C00B7AF */  sw         $s7, 0x4C($sp)
    /* C46AC 800D3EAC 4800B6AF */  sw         $s6, 0x48($sp)
    /* C46B0 800D3EB0 4400B5AF */  sw         $s5, 0x44($sp)
    /* C46B4 800D3EB4 4000B4AF */  sw         $s4, 0x40($sp)
    /* C46B8 800D3EB8 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* C46BC 800D3EBC 3800B2AF */  sw         $s2, 0x38($sp)
    /* C46C0 800D3EC0 04002012 */  beqz       $s1, .L800D3ED4
    /* C46C4 800D3EC4 3000B0AF */   sw        $s0, 0x30($sp)
    /* C46C8 800D3EC8 C0188C8F */  lw         $t4, %gp_rel(D_8013DE0C)($gp)
    /* C46CC 800D3ECC B84F0308 */  j          .L800D3EE0
    /* C46D0 800D3ED0 2000ACAF */   sw        $t4, 0x20($sp)
  .L800D3ED4:
    /* C46D4 800D3ED4 BC188C8F */  lw         $t4, %gp_rel(D_8013DE08)($gp)
    /* C46D8 800D3ED8 00000000 */  nop
    /* C46DC 800D3EDC 2000ACAF */  sw         $t4, 0x20($sp)
  .L800D3EE0:
    /* C46E0 800D3EE0 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* C46E4 800D3EE4 EC314524 */  addiu      $a1, $v0, %lo(GameSetup_gData)
    /* C46E8 800D3EE8 40181100 */  sll        $v1, $s1, 1
    /* C46EC 800D3EEC 21187100 */  addu       $v1, $v1, $s1
    /* C46F0 800D3EF0 00110300 */  sll        $v0, $v1, 4
    /* C46F4 800D3EF4 23104300 */  subu       $v0, $v0, $v1
    /* C46F8 800D3EF8 80100200 */  sll        $v0, $v0, 2
    /* C46FC 800D3EFC 21104500 */  addu       $v0, $v0, $a1
    /* C4700 800D3F00 D403438C */  lw         $v1, 0x3D4($v0)
    /* C4704 800D3F04 00000000 */  nop
    /* C4708 800D3F08 1E006228 */  slti       $v0, $v1, 0x1E
    /* C470C 800D3F0C 02004010 */  beqz       $v0, .L800D3F18
    /* C4710 800D3F10 1D000424 */   addiu     $a0, $zero, 0x1D
    /* C4714 800D3F14 21206000 */  addu       $a0, $v1, $zero
  .L800D3F18:
    /* C4718 800D3F18 5400A28C */  lw         $v0, 0x54($a1)
    /* C471C 800D3F1C 00000000 */  nop
    /* C4720 800D3F20 03004010 */  beqz       $v0, .L800D3F30
    /* C4724 800D3F24 1280033C */   lui       $v1, %hi(D_80120A34)
    /* C4728 800D3F28 CE4F0308 */  j          .L800D3F38
    /* C472C 800D3F2C 340A6324 */   addiu     $v1, $v1, %lo(D_80120A34)
  .L800D3F30:
    /* C4730 800D3F30 1280033C */  lui        $v1, %hi(D_801209BC)
    /* C4734 800D3F34 BC096324 */  addiu      $v1, $v1, %lo(D_801209BC)
  .L800D3F38:
    /* C4738 800D3F38 80100400 */  sll        $v0, $a0, 2
    /* C473C 800D3F3C 21104300 */  addu       $v0, $v0, $v1
    /* C4740 800D3F40 0000428C */  lw         $v0, 0x0($v0)
    /* C4744 800D3F44 00000000 */  nop
    /* C4748 800D3F48 2800A2AF */  sw         $v0, 0x28($sp)
    /* C474C 800D3F4C 2EC2033C */  lui        $v1, (0xC22E4507 >> 16)
    /* C4750 800D3F50 1180023C */  lui        $v0, %hi(D_80112770)
    /* C4754 800D3F54 7027428C */  lw         $v0, %lo(D_80112770)($v0)
    /* C4758 800D3F58 07456334 */  ori        $v1, $v1, (0xC22E4507 & 0xFFFF)
    /* C475C 800D3F5C 00140200 */  sll        $v0, $v0, 16
    /* C4760 800D3F60 18004300 */  mult       $v0, $v1
    /* C4764 800D3F64 10600000 */  mfhi       $t4
    /* C4768 800D3F68 21188201 */  addu       $v1, $t4, $v0
    /* C476C 800D3F6C 431B0300 */  sra        $v1, $v1, 13
    /* C4770 800D3F70 C3170200 */  sra        $v0, $v0, 31
    /* C4774 800D3F74 23186200 */  subu       $v1, $v1, $v0
    /* C4778 800D3F78 99597E24 */  addiu      $fp, $v1, 0x5999
    /* C477C 800D3F7C 9959C22B */  slti       $v0, $fp, 0x5999
    /* C4780 800D3F80 02004010 */  beqz       $v0, .L800D3F8C
    /* C4784 800D3F84 0100023C */   lui       $v0, (0x13334 >> 16)
    /* C4788 800D3F88 99591E24 */  addiu      $fp, $zero, 0x5999
  .L800D3F8C:
    /* C478C 800D3F8C 34334234 */  ori        $v0, $v0, (0x13334 & 0xFFFF)
    /* C4790 800D3F90 2A105E00 */  slt        $v0, $v0, $fp
    /* C4794 800D3F94 04004010 */  beqz       $v0, .L800D3FA8
    /* C4798 800D3F98 2120C003 */   addu      $a0, $fp, $zero
    /* C479C 800D3F9C 01001E3C */  lui        $fp, (0x13334 >> 16)
    /* C47A0 800D3FA0 3433DE37 */  ori        $fp, $fp, (0x13334 & 0xFFFF)
    /* C47A4 800D3FA4 2120C003 */  addu       $a0, $fp, $zero
  .L800D3FA8:
    /* C47A8 800D3FA8 1800A527 */  addiu      $a1, $sp, 0x18
    /* C47AC 800D3FAC 9CCD030C */  jal        fixedsincos
    /* C47B0 800D3FB0 1C00A627 */   addiu     $a2, $sp, 0x1C
    /* C47B4 800D3FB4 03002012 */  beqz       $s1, .L800D3FC4
    /* C47B8 800D3FB8 1180023C */   lui       $v0, %hi(D_801116D4)
    /* C47BC 800D3FBC F34F0308 */  j          .L800D3FCC
    /* C47C0 800D3FC0 D4164224 */   addiu     $v0, $v0, %lo(D_801116D4)
  .L800D3FC4:
    /* C47C4 800D3FC4 1180023C */  lui        $v0, %hi(D_801116AC)
    /* C47C8 800D3FC8 AC164224 */  addiu      $v0, $v0, %lo(D_801116AC)
  .L800D3FCC:
    /* C47CC 800D3FCC 1D000524 */  addiu      $a1, $zero, 0x1D
    /* C47D0 800D3FD0 0000508C */  lw         $s0, 0x0($v0)
    /* C47D4 800D3FD4 FFFF023C */  lui        $v0, (0xFFFF0000 >> 16)
    /* C47D8 800D3FD8 1C00A48F */  lw         $a0, 0x1C($sp)
    /* C47DC 800D3FDC CA90030C */  jal        fixedmult
    /* C47E0 800D3FE0 24800202 */   and       $s0, $s0, $v0
    /* C47E4 800D3FE4 1D000524 */  addiu      $a1, $zero, 0x1D
    /* C47E8 800D3FE8 1800A48F */  lw         $a0, 0x18($sp)
    /* C47EC 800D3FEC CA90030C */  jal        fixedmult
    /* C47F0 800D3FF0 21B84000 */   addu      $s7, $v0, $zero
    /* C47F4 800D3FF4 21A04000 */  addu       $s4, $v0, $zero
    /* C47F8 800D3FF8 1D00E326 */  addiu      $v1, $s7, 0x1D
    /* C47FC 800D3FFC 9D008226 */  addiu      $v0, $s4, 0x9D
    /* C4800 800D4000 00120200 */  sll        $v0, $v0, 8
    /* C4804 800D4004 04002012 */  beqz       $s1, .L800D4018
    /* C4808 800D4008 25800202 */   or        $s0, $s0, $v0
    /* C480C 800D400C 7500E226 */  addiu      $v0, $s7, 0x75
    /* C4810 800D4010 07500308 */  j          .L800D401C
    /* C4814 800D4014 25800202 */   or        $s0, $s0, $v0
  .L800D4018:
    /* C4818 800D4018 25800302 */  or         $s0, $s0, $v1
  .L800D401C:
    /* C481C 800D401C 0A000524 */  addiu      $a1, $zero, 0xA
    /* C4820 800D4020 2000AC8F */  lw         $t4, 0x20($sp)
    /* C4824 800D4024 FF00133C */  lui        $s3, (0xFFFFFF >> 16)
    /* C4828 800D4028 340090AD */  sw         $s0, 0x34($t4)
    /* C482C 800D402C 1C00A48F */  lw         $a0, 0x1C($sp)
    /* C4830 800D4030 CA90030C */  jal        fixedmult
    /* C4834 800D4034 FFFF7336 */   ori       $s3, $s3, (0xFFFFFF & 0xFFFF)
    /* C4838 800D4038 0A000524 */  addiu      $a1, $zero, 0xA
    /* C483C 800D403C 1800A48F */  lw         $a0, 0x18($sp)
    /* C4840 800D4040 0E004224 */  addiu      $v0, $v0, 0xE
    /* C4844 800D4044 CA90030C */  jal        fixedmult
    /* C4848 800D4048 2400A2AF */   sw        $v0, 0x24($sp)
    /* C484C 800D404C 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* C4850 800D4050 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* C4854 800D4054 48000A3C */  lui        $t2, (0x484848 >> 16)
    /* C4858 800D4058 48484A35 */  ori        $t2, $t2, (0x484848 & 0xFFFF)
    /* C485C 800D405C 1180153C */  lui        $s5, %hi(D_801116C0)
    /* C4860 800D4060 C016B526 */  addiu      $s5, $s5, %lo(D_801116C0)
    /* C4864 800D4064 2128A002 */  addu       $a1, $s5, $zero
    /* C4868 800D4068 0E005624 */  addiu      $s6, $v0, 0xE
    /* C486C 800D406C 2138C002 */  addu       $a3, $s6, $zero
    /* C4870 800D4070 00FF0C3C */  lui        $t4, (0xFF000000 >> 16)
    /* C4874 800D4074 0E001124 */  addiu      $s1, $zero, 0xE
    /* C4878 800D4078 2400A68F */  lw         $a2, 0x24($sp)
    /* C487C 800D407C 0000728D */  lw         $s2, 0x0($t3)
    /* C4880 800D4080 801F093C */  lui        $t1, (0x1F800000 >> 16)
    /* C4884 800D4084 0000298D */  lw         $t1, (0x1F800000 & 0xFFFF)($t1)
    /* C4888 800D4088 14004826 */  addiu      $t0, $s2, 0x14
    /* C488C 800D408C 0000438E */  lw         $v1, 0x0($s2)
    /* C4890 800D4090 0000228D */  lw         $v0, 0x0($t1)
    /* C4894 800D4094 24186C00 */  and        $v1, $v1, $t4
    /* C4898 800D4098 24105300 */  and        $v0, $v0, $s3
    /* C489C 800D409C 25186200 */  or         $v1, $v1, $v0
    /* C48A0 800D40A0 000043AE */  sw         $v1, 0x0($s2)
    /* C48A4 800D40A4 0000228D */  lw         $v0, 0x0($t1)
    /* C48A8 800D40A8 24185302 */  and        $v1, $s2, $s3
    /* C48AC 800D40AC 000068AD */  sw         $t0, 0x0($t3)
    /* C48B0 800D40B0 24104C00 */  and        $v0, $v0, $t4
    /* C48B4 800D40B4 25104300 */  or         $v0, $v0, $v1
    /* C48B8 800D40B8 000022AD */  sw         $v0, 0x0($t1)
    /* C48BC 800D40BC 1400438E */  lw         $v1, 0x14($s2)
    /* C48C0 800D40C0 24105300 */  and        $v0, $v0, $s3
    /* C48C4 800D40C4 24186C00 */  and        $v1, $v1, $t4
    /* C48C8 800D40C8 25186200 */  or         $v1, $v1, $v0
    /* C48CC 800D40CC 140043AE */  sw         $v1, 0x14($s2)
    /* C48D0 800D40D0 0000228D */  lw         $v0, 0x0($t1)
    /* C48D4 800D40D4 24004326 */  addiu      $v1, $s2, 0x24
    /* C48D8 800D40D8 000063AD */  sw         $v1, 0x0($t3)
    /* C48DC 800D40DC 24181301 */  and        $v1, $t0, $s3
    /* C48E0 800D40E0 24104C00 */  and        $v0, $v0, $t4
    /* C48E4 800D40E4 25104300 */  or         $v0, $v0, $v1
    /* C48E8 800D40E8 000022AD */  sw         $v0, 0x0($t1)
    /* C48EC 800D40EC 03000224 */  addiu      $v0, $zero, 0x3
    /* C48F0 800D40F0 030002A1 */  sb         $v0, 0x3($t0)
    /* C48F4 800D40F4 2800AC8F */  lw         $t4, 0x28($sp)
    /* C48F8 800D40F8 0042023C */  lui        $v0, (0x42000000 >> 16)
    /* C48FC 800D40FC 21508A01 */  addu       $t2, $t4, $t2
    /* C4900 800D4100 25504201 */  or         $t2, $t2, $v0
    /* C4904 800D4104 23103702 */  subu       $v0, $s1, $s7
    /* C4908 800D4108 080002A5 */  sh         $v0, 0x8($t0)
    /* C490C 800D410C 23103402 */  subu       $v0, $s1, $s4
    /* C4910 800D4110 04000AAD */  sw         $t2, 0x4($t0)
    /* C4914 800D4114 0A0002A5 */  sh         $v0, 0xA($t0)
    /* C4918 800D4118 2400AC97 */  lhu        $t4, 0x24($sp)
    /* C491C 800D411C 0E0016A5 */  sh         $s6, 0xE($t0)
    /* C4920 800D4120 0C000CA5 */  sh         $t4, 0xC($t0)
    /* C4924 800D4124 00FF0C3C */  lui        $t4, (0xFF000000 >> 16)
    /* C4928 800D4128 0000708D */  lw         $s0, 0x0($t3)
    /* C492C 800D412C 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* C4930 800D4130 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* C4934 800D4134 0000038E */  lw         $v1, 0x0($s0)
    /* C4938 800D4138 0000028D */  lw         $v0, 0x0($t0)
    /* C493C 800D413C 24186C00 */  and        $v1, $v1, $t4
    /* C4940 800D4140 24105300 */  and        $v0, $v0, $s3
    /* C4944 800D4144 25186200 */  or         $v1, $v1, $v0
    /* C4948 800D4148 000003AE */  sw         $v1, 0x0($s0)
    /* C494C 800D414C 0000028D */  lw         $v0, 0x0($t0)
    /* C4950 800D4150 14000326 */  addiu      $v1, $s0, 0x14
    /* C4954 800D4154 000063AD */  sw         $v1, 0x0($t3)
    /* C4958 800D4158 24181302 */  and        $v1, $s0, $s3
    /* C495C 800D415C 24104C00 */  and        $v0, $v0, $t4
    /* C4960 800D4160 25104300 */  or         $v0, $v0, $v1
    /* C4964 800D4164 000002AD */  sw         $v0, 0x0($t0)
    /* C4968 800D4168 2800AC8F */  lw         $t4, 0x28($sp)
    /* C496C 800D416C 21204002 */  addu       $a0, $s2, $zero
    /* C4970 800D4170 7148030C */  jal        Hud_BuildF3__FP7POLY_F3P13HudPmx_tShapeiiUl
    /* C4974 800D4174 1000ACAF */   sw        $t4, 0x10($sp)
    /* C4978 800D4178 21200002 */  addu       $a0, $s0, $zero
    /* C497C 800D417C 2128A002 */  addu       $a1, $s5, $zero
    /* C4980 800D4180 2400A68F */  lw         $a2, 0x24($sp)
    /* C4984 800D4184 2138C002 */  addu       $a3, $s6, $zero
    /* C4988 800D4188 7148030C */  jal        Hud_BuildF3__FP7POLY_F3P13HudPmx_tShapeiiUl
    /* C498C 800D418C 1000A0AF */   sw        $zero, 0x10($sp)
    /* C4990 800D4190 00FEC427 */  addiu      $a0, $fp, -0x200
    /* C4994 800D4194 1800B627 */  addiu      $s6, $sp, 0x18
    /* C4998 800D4198 2128C002 */  addu       $a1, $s6, $zero
    /* C499C 800D419C 1C00B527 */  addiu      $s5, $sp, 0x1C
    /* C49A0 800D41A0 07004292 */  lbu        $v0, 0x7($s2)
    /* C49A4 800D41A4 2130A002 */  addu       $a2, $s5, $zero
    /* C49A8 800D41A8 FD004230 */  andi       $v0, $v0, 0xFD
    /* C49AC 800D41AC 9CCD030C */  jal        fixedsincos
    /* C49B0 800D41B0 070042A2 */   sb        $v0, 0x7($s2)
    /* C49B4 800D41B4 1C00A48F */  lw         $a0, 0x1C($sp)
    /* C49B8 800D41B8 CA90030C */  jal        fixedmult
    /* C49BC 800D41BC 20000524 */   addiu     $a1, $zero, 0x20
    /* C49C0 800D41C0 20000524 */  addiu      $a1, $zero, 0x20
    /* C49C4 800D41C4 1800A48F */  lw         $a0, 0x18($sp)
    /* C49C8 800D41C8 23102202 */  subu       $v0, $s1, $v0
    /* C49CC 800D41CC 0C0042A6 */  sh         $v0, 0xC($s2)
    /* C49D0 800D41D0 CA90030C */  jal        fixedmult
    /* C49D4 800D41D4 0C0002A6 */   sh        $v0, 0xC($s0)
    /* C49D8 800D41D8 0002C427 */  addiu      $a0, $fp, 0x200
    /* C49DC 800D41DC 2128C002 */  addu       $a1, $s6, $zero
    /* C49E0 800D41E0 2130A002 */  addu       $a2, $s5, $zero
    /* C49E4 800D41E4 23102202 */  subu       $v0, $s1, $v0
    /* C49E8 800D41E8 0E0042A6 */  sh         $v0, 0xE($s2)
    /* C49EC 800D41EC 9CCD030C */  jal        fixedsincos
    /* C49F0 800D41F0 0E0002A6 */   sh        $v0, 0xE($s0)
    /* C49F4 800D41F4 1C00A48F */  lw         $a0, 0x1C($sp)
    /* C49F8 800D41F8 CA90030C */  jal        fixedmult
    /* C49FC 800D41FC 20000524 */   addiu     $a1, $zero, 0x20
    /* C4A00 800D4200 20000524 */  addiu      $a1, $zero, 0x20
    /* C4A04 800D4204 1800A48F */  lw         $a0, 0x18($sp)
    /* C4A08 800D4208 23102202 */  subu       $v0, $s1, $v0
    /* C4A0C 800D420C 100042A6 */  sh         $v0, 0x10($s2)
    /* C4A10 800D4210 CA90030C */  jal        fixedmult
    /* C4A14 800D4214 100002A6 */   sh        $v0, 0x10($s0)
    /* C4A18 800D4218 23882202 */  subu       $s1, $s1, $v0
    /* C4A1C 800D421C 120051A6 */  sh         $s1, 0x12($s2)
    /* C4A20 800D4220 120011A6 */  sh         $s1, 0x12($s0)
    /* C4A24 800D4224 21182002 */  addu       $v1, $s1, $zero
    /* C4A28 800D4228 0A000296 */  lhu        $v0, 0xA($s0)
    /* C4A2C 800D422C 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C4A30 800D4230 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C4A34 800D4234 02004224 */  addiu      $v0, $v0, 0x2
    /* C4A38 800D4238 0A0002A6 */  sh         $v0, 0xA($s0)
    /* C4A3C 800D423C 0E000296 */  lhu        $v0, 0xE($s0)
    /* C4A40 800D4240 02006324 */  addiu      $v1, $v1, 0x2
    /* C4A44 800D4244 120003A6 */  sh         $v1, 0x12($s0)
    /* C4A48 800D4248 02004224 */  addiu      $v0, $v0, 0x2
    /* C4A4C 800D424C 0E0002A6 */  sh         $v0, 0xE($s0)
    /* C4A50 800D4250 2000AC8F */  lw         $t4, 0x20($sp)
    /* C4A54 800D4254 0000828C */  lw         $v0, 0x0($a0)
    /* C4A58 800D4258 2800838D */  lw         $v1, 0x28($t4)
    /* C4A5C 800D425C 00FF0C3C */  lui        $t4, (0xFF000000 >> 16)
    /* C4A60 800D4260 24105300 */  and        $v0, $v0, $s3
    /* C4A64 800D4264 24186C00 */  and        $v1, $v1, $t4
    /* C4A68 800D4268 2000AC8F */  lw         $t4, 0x20($sp)
    /* C4A6C 800D426C 25186200 */  or         $v1, $v1, $v0
    /* C4A70 800D4270 280083AD */  sw         $v1, 0x28($t4)
    /* C4A74 800D4274 0000838C */  lw         $v1, 0x0($a0)
    /* C4A78 800D4278 00FF0C3C */  lui        $t4, (0xFF000000 >> 16)
    /* C4A7C 800D427C 24186C00 */  and        $v1, $v1, $t4
    /* C4A80 800D4280 2000AC8F */  lw         $t4, 0x20($sp)
    /* C4A84 800D4284 00000000 */  nop
    /* C4A88 800D4288 28008225 */  addiu      $v0, $t4, 0x28
    /* C4A8C 800D428C 24105300 */  and        $v0, $v0, $s3
    /* C4A90 800D4290 25186200 */  or         $v1, $v1, $v0
    /* C4A94 800D4294 000083AC */  sw         $v1, 0x0($a0)
    /* C4A98 800D4298 5400BF8F */  lw         $ra, 0x54($sp)
    /* C4A9C 800D429C 5000BE8F */  lw         $fp, 0x50($sp)
    /* C4AA0 800D42A0 4C00B78F */  lw         $s7, 0x4C($sp)
    /* C4AA4 800D42A4 4800B68F */  lw         $s6, 0x48($sp)
    /* C4AA8 800D42A8 4400B58F */  lw         $s5, 0x44($sp)
    /* C4AAC 800D42AC 4000B48F */  lw         $s4, 0x40($sp)
    /* C4AB0 800D42B0 3C00B38F */  lw         $s3, 0x3C($sp)
    /* C4AB4 800D42B4 3800B28F */  lw         $s2, 0x38($sp)
    /* C4AB8 800D42B8 3400B18F */  lw         $s1, 0x34($sp)
    /* C4ABC 800D42BC 3000B08F */  lw         $s0, 0x30($sp)
    /* C4AC0 800D42C0 0800E003 */  jr         $ra
    /* C4AC4 800D42C4 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel Hud_BuildTach__Fi
