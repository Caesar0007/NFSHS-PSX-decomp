.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_DoSplats__FiP18Weather_tSplatInfo, 0x1C4

glabel Weather_DoSplats__FiP18Weather_tSplatInfo
    /* D4058 800E3858 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D405C 800E385C 2000B4AF */  sw         $s4, 0x20($sp)
    /* D4060 800E3860 21A08000 */  addu       $s4, $a0, $zero
    /* D4064 800E3864 5416828F */  lw         $v0, %gp_rel(gCurrentNumSplats)($gp)
    /* D4068 800E3868 2120A000 */  addu       $a0, $a1, $zero
    /* D406C 800E386C 2800BFAF */  sw         $ra, 0x28($sp)
    /* D4070 800E3870 2400B5AF */  sw         $s5, 0x24($sp)
    /* D4074 800E3874 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D4078 800E3878 1800B2AF */  sw         $s2, 0x18($sp)
    /* D407C 800E387C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D4080 800E3880 2A105400 */  slt        $v0, $v0, $s4
    /* D4084 800E3884 02004010 */  beqz       $v0, .L800E3890
    /* D4088 800E3888 1000B0AF */   sw        $s0, 0x10($sp)
    /* D408C 800E388C 541694AF */  sw         $s4, %gp_rel(gCurrentNumSplats)($gp)
  .L800E3890:
    /* D4090 800E3890 5416868F */  lw         $a2, %gp_rel(gCurrentNumSplats)($gp)
    /* D4094 800E3894 00000000 */  nop
    /* D4098 800E3898 5700C018 */  blez       $a2, .L800E39F8
    /* D409C 800E389C 21880000 */   addu      $s1, $zero, $zero
    /* D40A0 800E38A0 1280023C */  lui        $v0, %hi(simGlobal)
    /* D40A4 800E38A4 ACE05324 */  addiu      $s3, $v0, %lo(simGlobal)
    /* D40A8 800E38A8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* D40AC 800E38AC EC315524 */  addiu      $s5, $v0, %lo(GameSetup_gData)
    /* D40B0 800E38B0 21808000 */  addu       $s0, $a0, $zero
  .L800E38B4:
    /* D40B4 800E38B4 0400648E */  lw         $a0, 0x4($s3)
    /* D40B8 800E38B8 0400038E */  lw         $v1, 0x4($s0)
    /* D40BC 800E38BC 00000000 */  nop
    /* D40C0 800E38C0 2A108300 */  slt        $v0, $a0, $v1
    /* D40C4 800E38C4 46004014 */  bnez       $v0, .L800E39E0
    /* D40C8 800E38C8 20006224 */   addiu     $v0, $v1, 0x20
    /* D40CC 800E38CC 2A104400 */  slt        $v0, $v0, $a0
    /* D40D0 800E38D0 41004010 */  beqz       $v0, .L800E39D8
    /* D40D4 800E38D4 2A108602 */   slt       $v0, $s4, $a2
    /* D40D8 800E38D8 06004010 */  beqz       $v0, .L800E38F4
    /* D40DC 800E38DC FFFFC224 */   addiu     $v0, $a2, -0x1
    /* D40E0 800E38E0 04002216 */  bne        $s1, $v0, .L800E38F4
    /* D40E4 800E38E4 00000000 */   nop
    /* D40E8 800E38E8 541691AF */  sw         $s1, %gp_rel(gCurrentNumSplats)($gp)
    /* D40EC 800E38EC 798E0308 */  j          .L800E39E4
    /* D40F0 800E38F0 08001026 */   addiu     $s0, $s0, 0x8
  .L800E38F4:
    /* D40F4 800E38F4 EA9D030C */  jal        random
    /* D40F8 800E38F8 21900002 */   addu      $s2, $s0, $zero
    /* D40FC 800E38FC CCCC033C */  lui        $v1, (0xCCCCCCCD >> 16)
    /* D4100 800E3900 CDCC6334 */  ori        $v1, $v1, (0xCCCCCCCD & 0xFFFF)
    /* D4104 800E3904 19004300 */  multu      $v0, $v1
    /* D4108 800E3908 10380000 */  mfhi       $a3
    /* D410C 800E390C 02220700 */  srl        $a0, $a3, 8
    /* D4110 800E3910 80180400 */  sll        $v1, $a0, 2
    /* D4114 800E3914 21186400 */  addu       $v1, $v1, $a0
    /* D4118 800E3918 80190300 */  sll        $v1, $v1, 6
    /* D411C 800E391C 23104300 */  subu       $v0, $v0, $v1
    /* D4120 800E3920 000002A6 */  sh         $v0, 0x0($s0)
    /* D4124 800E3924 0C00A38E */  lw         $v1, 0xC($s5)
    /* D4128 800E3928 01000224 */  addiu      $v0, $zero, 0x1
    /* D412C 800E392C 0E006214 */  bne        $v1, $v0, .L800E3968
    /* D4130 800E3930 00000000 */   nop
    /* D4134 800E3934 EA9D030C */  jal        random
    /* D4138 800E3938 00000000 */   nop
    /* D413C 800E393C 8888033C */  lui        $v1, (0x88888889 >> 16)
    /* D4140 800E3940 89886334 */  ori        $v1, $v1, (0x88888889 & 0xFFFF)
    /* D4144 800E3944 19004300 */  multu      $v0, $v1
    /* D4148 800E3948 10380000 */  mfhi       $a3
    /* D414C 800E394C C2210700 */  srl        $a0, $a3, 7
    /* D4150 800E3950 00190400 */  sll        $v1, $a0, 4
    /* D4154 800E3954 23186400 */  subu       $v1, $v1, $a0
    /* D4158 800E3958 00190300 */  sll        $v1, $v1, 4
    /* D415C 800E395C 23104300 */  subu       $v0, $v0, $v1
    /* D4160 800E3960 658E0308 */  j          .L800E3994
    /* D4164 800E3964 42100200 */   srl       $v0, $v0, 1
  .L800E3968:
    /* D4168 800E3968 EA9D030C */  jal        random
    /* D416C 800E396C 00000000 */   nop
    /* D4170 800E3970 8888033C */  lui        $v1, (0x88888889 >> 16)
    /* D4174 800E3974 89886334 */  ori        $v1, $v1, (0x88888889 & 0xFFFF)
    /* D4178 800E3978 19004300 */  multu      $v0, $v1
    /* D417C 800E397C 10380000 */  mfhi       $a3
    /* D4180 800E3980 C2210700 */  srl        $a0, $a3, 7
    /* D4184 800E3984 00190400 */  sll        $v1, $a0, 4
    /* D4188 800E3988 23186400 */  subu       $v1, $v1, $a0
    /* D418C 800E398C 00190300 */  sll        $v1, $v1, 4
    /* D4190 800E3990 23104300 */  subu       $v0, $v0, $v1
  .L800E3994:
    /* D4194 800E3994 EA9D030C */  jal        random
    /* D4198 800E3998 020042A6 */   sh        $v0, 0x2($s2)
    /* D419C 800E399C EB51033C */  lui        $v1, (0x51EB851F >> 16)
    /* D41A0 800E39A0 1F856334 */  ori        $v1, $v1, (0x51EB851F & 0xFFFF)
    /* D41A4 800E39A4 19004300 */  multu      $v0, $v1
    /* D41A8 800E39A8 10380000 */  mfhi       $a3
    /* D41AC 800E39AC 42210700 */  srl        $a0, $a3, 5
    /* D41B0 800E39B0 40180400 */  sll        $v1, $a0, 1
    /* D41B4 800E39B4 21186400 */  addu       $v1, $v1, $a0
    /* D41B8 800E39B8 C0180300 */  sll        $v1, $v1, 3
    /* D41BC 800E39BC 21186400 */  addu       $v1, $v1, $a0
    /* D41C0 800E39C0 80180300 */  sll        $v1, $v1, 2
    /* D41C4 800E39C4 0400648E */  lw         $a0, 0x4($s3)
    /* D41C8 800E39C8 23104300 */  subu       $v0, $v0, $v1
    /* D41CC 800E39CC 21208200 */  addu       $a0, $a0, $v0
    /* D41D0 800E39D0 788E0308 */  j          .L800E39E0
    /* D41D4 800E39D4 040004AE */   sw        $a0, 0x4($s0)
  .L800E39D8:
    /* D41D8 800E39D8 CC8D030C */  jal        Weather_CreateSplat__FP18Weather_tSplatInfo
    /* D41DC 800E39DC 21200002 */   addu      $a0, $s0, $zero
  .L800E39E0:
    /* D41E0 800E39E0 08001026 */  addiu      $s0, $s0, 0x8
  .L800E39E4:
    /* D41E4 800E39E4 5416868F */  lw         $a2, %gp_rel(gCurrentNumSplats)($gp)
    /* D41E8 800E39E8 01003126 */  addiu      $s1, $s1, 0x1
    /* D41EC 800E39EC 2A102602 */  slt        $v0, $s1, $a2
    /* D41F0 800E39F0 B0FF4014 */  bnez       $v0, .L800E38B4
    /* D41F4 800E39F4 00000000 */   nop
  .L800E39F8:
    /* D41F8 800E39F8 2800BF8F */  lw         $ra, 0x28($sp)
    /* D41FC 800E39FC 2400B58F */  lw         $s5, 0x24($sp)
    /* D4200 800E3A00 2000B48F */  lw         $s4, 0x20($sp)
    /* D4204 800E3A04 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D4208 800E3A08 1800B28F */  lw         $s2, 0x18($sp)
    /* D420C 800E3A0C 1400B18F */  lw         $s1, 0x14($sp)
    /* D4210 800E3A10 1000B08F */  lw         $s0, 0x10($sp)
    /* D4214 800E3A14 0800E003 */  jr         $ra
    /* D4218 800E3A18 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Weather_DoSplats__FiP18Weather_tSplatInfo
