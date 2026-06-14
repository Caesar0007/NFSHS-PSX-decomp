.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi, 0x550

glabel SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi
    /* 4F874 8005F074 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 4F878 8005F078 2000B2AF */  sw         $s2, 0x20($sp)
    /* 4F87C 8005F07C 21908000 */  addu       $s2, $a0, $zero
    /* 4F880 8005F080 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 4F884 8005F084 21A8A000 */  addu       $s5, $a1, $zero
    /* 4F888 8005F088 3000B6AF */  sw         $s6, 0x30($sp)
    /* 4F88C 8005F08C 3400BFAF */  sw         $ra, 0x34($sp)
    /* 4F890 8005F090 2800B4AF */  sw         $s4, 0x28($sp)
    /* 4F894 8005F094 2400B3AF */  sw         $s3, 0x24($sp)
    /* 4F898 8005F098 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 4F89C 8005F09C 1800B0AF */  sw         $s0, 0x18($sp)
    /* 4F8A0 8005F0A0 5800A48E */  lw         $a0, 0x58($s5)
    /* 4F8A4 8005F0A4 0000B38E */  lw         $s3, 0x0($s5)
    /* 4F8A8 8005F0A8 4F008010 */  beqz       $a0, .L8005F1E8
    /* 4F8AC 8005F0AC 21B0C000 */   addu      $s6, $a2, $zero
    /* 4F8B0 8005F0B0 0000908C */  lw         $s0, 0x0($a0)
    /* 4F8B4 8005F0B4 FFFF1124 */  addiu      $s1, $zero, -0x1
    /* 4F8B8 8005F0B8 6405028E */  lw         $v0, 0x564($s0)
    /* 4F8BC 8005F0BC 00000000 */  nop
    /* 4F8C0 8005F0C0 02004004 */  bltz       $v0, .L8005F0CC
    /* 4F8C4 8005F0C4 21A00002 */   addu      $s4, $s0, $zero
    /* 4F8C8 8005F0C8 01001124 */  addiu      $s1, $zero, 0x1
  .L8005F0CC:
    /* 4F8CC 8005F0CC 21200002 */  addu       $a0, $s0, $zero
    /* 4F8D0 8005F0D0 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 4F8D4 8005F0D4 21286002 */   addu      $a1, $s3, $zero
    /* 4F8D8 8005F0D8 F401033C */  lui        $v1, (0x1F40000 >> 16)
    /* 4F8DC 8005F0DC 21284000 */  addu       $a1, $v0, $zero
    /* 4F8E0 8005F0E0 0200A104 */  bgez       $a1, .L8005F0EC
    /* 4F8E4 8005F0E4 2120A000 */   addu      $a0, $a1, $zero
    /* 4F8E8 8005F0E8 23200400 */  negu       $a0, $a0
  .L8005F0EC:
    /* 4F8EC 8005F0EC 2A106400 */  slt        $v0, $v1, $a0
    /* 4F8F0 8005F0F0 02004010 */  beqz       $v0, .L8005F0FC
    /* 4F8F4 8005F0F4 00000000 */   nop
    /* 4F8F8 8005F0F8 21188000 */  addu       $v1, $a0, $zero
  .L8005F0FC:
    /* 4F8FC 8005F0FC DC05043C */  lui        $a0, (0x5DC0000 >> 16)
    /* 4F900 8005F100 2A106400 */  slt        $v0, $v1, $a0
    /* 4F904 8005F104 02004010 */  beqz       $v0, .L8005F110
    /* 4F908 8005F108 1800B100 */   mult      $a1, $s1
    /* 4F90C 8005F10C 21206000 */  addu       $a0, $v1, $zero
  .L8005F110:
    /* 4F910 8005F110 12400000 */  mflo       $t0
    /* 4F914 8005F114 12000105 */  bgez       $t0, .L8005F160
    /* 4F918 8005F118 21188000 */   addu      $v1, $a0, $zero
    /* 4F91C 8005F11C AA2A023C */  lui        $v0, (0x2AAAAAAB >> 16)
    /* 4F920 8005F120 ABAA4234 */  ori        $v0, $v0, (0x2AAAAAAB & 0xFFFF)
    /* 4F924 8005F124 18006200 */  mult       $v1, $v0
    /* 4F928 8005F128 C31F0300 */  sra        $v1, $v1, 31
    /* 4F92C 8005F12C 10480000 */  mfhi       $t1
    /* 4F930 8005F130 03140900 */  sra        $v0, $t1, 16
    /* 4F934 8005F134 23104300 */  subu       $v0, $v0, $v1
    /* 4F938 8005F138 18005100 */  mult       $v0, $s1
    /* 4F93C 8005F13C 12280000 */  mflo       $a1
    /* 4F940 8005F140 0400A004 */  bltz       $a1, .L8005F154
    /* 4F944 8005F144 00000000 */   nop
    /* 4F948 8005F148 08006286 */  lh         $v0, 0x8($s3)
    /* 4F94C 8005F14C 647C0108 */  j          .L8005F190
    /* 4F950 8005F150 00000000 */   nop
  .L8005F154:
    /* 4F954 8005F154 08006286 */  lh         $v0, 0x8($s3)
    /* 4F958 8005F158 6F7C0108 */  j          .L8005F1BC
    /* 4F95C 8005F15C 21804500 */   addu      $s0, $v0, $a1
  .L8005F160:
    /* 4F960 8005F160 AA2A023C */  lui        $v0, (0x2AAAAAAB >> 16)
    /* 4F964 8005F164 ABAA4234 */  ori        $v0, $v0, (0x2AAAAAAB & 0xFFFF)
    /* 4F968 8005F168 18006200 */  mult       $v1, $v0
    /* 4F96C 8005F16C C31F0300 */  sra        $v1, $v1, 31
    /* 4F970 8005F170 10480000 */  mfhi       $t1
    /* 4F974 8005F174 03140900 */  sra        $v0, $t1, 16
    /* 4F978 8005F178 23104300 */  subu       $v0, $v0, $v1
    /* 4F97C 8005F17C 18005100 */  mult       $v0, $s1
    /* 4F980 8005F180 12280000 */  mflo       $a1
    /* 4F984 8005F184 0A00A004 */  bltz       $a1, .L8005F1B0
    /* 4F988 8005F188 00000000 */   nop
    /* 4F98C 8005F18C 08000286 */  lh         $v0, 0x8($s0)
  .L8005F190:
    /* 4F990 8005F190 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 4F994 8005F194 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 4F998 8005F198 21804500 */  addu       $s0, $v0, $a1
    /* 4F99C 8005F19C 2A100302 */  slt        $v0, $s0, $v1
    /* 4F9A0 8005F1A0 0D004014 */  bnez       $v0, .L8005F1D8
    /* 4F9A4 8005F1A4 01000224 */   addiu     $v0, $zero, 0x1
    /* 4F9A8 8005F1A8 767C0108 */  j          .L8005F1D8
    /* 4F9AC 8005F1AC 23800302 */   subu      $s0, $s0, $v1
  .L8005F1B0:
    /* 4F9B0 8005F1B0 08008286 */  lh         $v0, 0x8($s4)
    /* 4F9B4 8005F1B4 00000000 */  nop
    /* 4F9B8 8005F1B8 21804500 */  addu       $s0, $v0, $a1
  .L8005F1BC:
    /* 4F9BC 8005F1BC 06000106 */  bgez       $s0, .L8005F1D8
    /* 4F9C0 8005F1C0 01000224 */   addiu     $v0, $zero, 0x1
    /* 4F9C4 8005F1C4 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4F9C8 8005F1C8 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4F9CC 8005F1CC 00000000 */  nop
    /* 4F9D0 8005F1D0 21800202 */  addu       $s0, $s0, $v0
    /* 4F9D4 8005F1D4 01000224 */  addiu      $v0, $zero, 0x1
  .L8005F1D8:
    /* 4F9D8 8005F1D8 500042A6 */  sh         $v0, 0x50($s2)
    /* 4F9DC 8005F1DC 5800A28E */  lw         $v0, 0x58($s5)
    /* 4F9E0 8005F1E0 9A7C0108 */  j          .L8005F268
    /* 4F9E4 8005F1E4 240042AE */   sw        $v0, 0x24($s2)
  .L8005F1E8:
    /* 4F9E8 8005F1E8 6405628E */  lw         $v0, 0x564($s3)
    /* 4F9EC 8005F1EC 00000000 */  nop
    /* 4F9F0 8005F1F0 02004004 */  bltz       $v0, .L8005F1FC
    /* 4F9F4 8005F1F4 FFFF0324 */   addiu     $v1, $zero, -0x1
    /* 4F9F8 8005F1F8 01000324 */  addiu      $v1, $zero, 0x1
  .L8005F1FC:
    /* 4F9FC 8005F1FC 53000224 */  addiu      $v0, $zero, 0x53
    /* 4FA00 8005F200 18006200 */  mult       $v1, $v0
    /* 4FA04 8005F204 12180000 */  mflo       $v1
    /* 4FA08 8005F208 0C006004 */  bltz       $v1, .L8005F23C
    /* 4FA0C 8005F20C 00000000 */   nop
    /* 4FA10 8005F210 08006286 */  lh         $v0, 0x8($s3)
    /* 4FA14 8005F214 00000000 */  nop
    /* 4FA18 8005F218 21104300 */  addu       $v0, $v0, $v1
    /* 4FA1C 8005F21C 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 4FA20 8005F220 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 4FA24 8005F224 21804000 */  addu       $s0, $v0, $zero
    /* 4FA28 8005F228 2A100302 */  slt        $v0, $s0, $v1
    /* 4FA2C 8005F22C 0C004014 */  bnez       $v0, .L8005F260
    /* 4FA30 8005F230 00000000 */   nop
    /* 4FA34 8005F234 987C0108 */  j          .L8005F260
    /* 4FA38 8005F238 23800302 */   subu      $s0, $s0, $v1
  .L8005F23C:
    /* 4FA3C 8005F23C 08006286 */  lh         $v0, 0x8($s3)
    /* 4FA40 8005F240 00000000 */  nop
    /* 4FA44 8005F244 21284300 */  addu       $a1, $v0, $v1
    /* 4FA48 8005F248 0500A104 */  bgez       $a1, .L8005F260
    /* 4FA4C 8005F24C 2180A000 */   addu      $s0, $a1, $zero
    /* 4FA50 8005F250 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4FA54 8005F254 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4FA58 8005F258 00000000 */  nop
    /* 4FA5C 8005F25C 2180A200 */  addu       $s0, $a1, $v0
  .L8005F260:
    /* 4FA60 8005F260 500040A6 */  sh         $zero, 0x50($s2)
    /* 4FA64 8005F264 240040AE */  sw         $zero, 0x24($s2)
  .L8005F268:
    /* 4FA68 8005F268 5405638E */  lw         $v1, 0x554($s3)
    /* 4FA6C 8005F26C 00000000 */  nop
    /* 4FA70 8005F270 23100300 */  negu       $v0, $v1
    /* 4FA74 8005F274 09004004 */  bltz       $v0, .L8005F29C
    /* 4FA78 8005F278 380043AE */   sw        $v1, 0x38($s2)
    /* 4FA7C 8005F27C 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 4FA80 8005F280 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 4FA84 8005F284 23280302 */  subu       $a1, $s0, $v1
    /* 4FA88 8005F288 2A10A400 */  slt        $v0, $a1, $a0
    /* 4FA8C 8005F28C 0A004014 */  bnez       $v0, .L8005F2B8
    /* 4FA90 8005F290 00000000 */   nop
    /* 4FA94 8005F294 AE7C0108 */  j          .L8005F2B8
    /* 4FA98 8005F298 2328A400 */   subu      $a1, $a1, $a0
  .L8005F29C:
    /* 4FA9C 8005F29C 23280302 */  subu       $a1, $s0, $v1
    /* 4FAA0 8005F2A0 0500A104 */  bgez       $a1, .L8005F2B8
    /* 4FAA4 8005F2A4 00000000 */   nop
    /* 4FAA8 8005F2A8 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4FAAC 8005F2AC C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4FAB0 8005F2B0 00000000 */  nop
    /* 4FAB4 8005F2B4 2128A200 */  addu       $a1, $a1, $v0
  .L8005F2B8:
    /* 4FAB8 8005F2B8 1480023C */  lui        $v0, %hi(fastRandom)
    /* 4FABC 8005F2BC FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 4FAC0 8005F2C0 1480033C */  lui        $v1, %hi(randSeed)
    /* 4FAC4 8005F2C4 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 4FAC8 8005F2C8 00000000 */  nop
    /* 4FACC 8005F2CC 18004300 */  mult       $v0, $v1
    /* 4FAD0 8005F2D0 CCCC033C */  lui        $v1, (0xCCCCCCCD >> 16)
    /* 4FAD4 8005F2D4 CDCC6334 */  ori        $v1, $v1, (0xCCCCCCCD & 0xFFFF)
    /* 4FAD8 8005F2D8 12100000 */  mflo       $v0
    /* 4FADC 8005F2DC 02220200 */  srl        $a0, $v0, 8
    /* 4FAE0 8005F2E0 FFFF8430 */  andi       $a0, $a0, 0xFFFF
    /* 4FAE4 8005F2E4 19008300 */  multu      $a0, $v1
    /* 4FAE8 8005F2E8 01001124 */  addiu      $s1, $zero, 0x1
    /* 4FAEC 8005F2EC 340045AE */  sw         $a1, 0x34($s2)
    /* 4FAF0 8005F2F0 1480013C */  lui        $at, %hi(AICop_gRoadBlockState)
    /* 4FAF4 8005F2F4 74C531AC */  sw         $s1, %lo(AICop_gRoadBlockState)($at)
    /* 4FAF8 8005F2F8 1480013C */  lui        $at, %hi(randtemp)
    /* 4FAFC 8005F2FC 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 4FB00 8005F300 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 4FB04 8005F304 1480013C */  lui        $at, %hi(fastRandom)
    /* 4FB08 8005F308 FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 4FB0C 8005F30C 10180000 */  mfhi       $v1
    /* 4FB10 8005F310 82180300 */  srl        $v1, $v1, 2
    /* 4FB14 8005F314 80100300 */  sll        $v0, $v1, 2
    /* 4FB18 8005F318 21104300 */  addu       $v0, $v0, $v1
    /* 4FB1C 8005F31C 23188200 */  subu       $v1, $a0, $v0
    /* 4FB20 8005F320 1480023C */  lui        $v0, %hi(gBlockadeTypes)
    /* 4FB24 8005F324 68C54224 */  addiu      $v0, $v0, %lo(gBlockadeTypes)
    /* 4FB28 8005F328 21106200 */  addu       $v0, $v1, $v0
    /* 4FB2C 8005F32C 00004290 */  lbu        $v0, 0x0($v0)
    /* 4FB30 8005F330 00000000 */  nop
    /* 4FB34 8005F334 1D004010 */  beqz       $v0, .L8005F3AC
    /* 4FB38 8005F338 280042AE */   sw        $v0, 0x28($s2)
    /* 4FB3C 8005F33C 1480023C */  lui        $v0, %hi(stackSpeedUpEnbabledFlag)
    /* 4FB40 8005F340 1CD8428C */  lw         $v0, %lo(stackSpeedUpEnbabledFlag)($v0)
    /* 4FB44 8005F344 00000000 */  nop
    /* 4FB48 8005F348 16004010 */  beqz       $v0, .L8005F3A4
    /* 4FB4C 8005F34C 21204002 */   addu      $a0, $s2, $zero
    /* 4FB50 8005F350 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 4FB54 8005F354 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 4FB58 8005F358 2B91030C */  jal        SetSp
    /* 4FB5C 8005F35C 00000000 */   nop
    /* 4FB60 8005F360 21204002 */  addu       $a0, $s2, $zero
    /* 4FB64 8005F364 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 4FB68 8005F368 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 4FB6C 8005F36C 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 4FB70 8005F370 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 4FB74 8005F374 E471010C */  jal        SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t
    /* 4FB78 8005F378 20004526 */   addiu     $a1, $s2, 0x20
    /* 4FB7C 8005F37C 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 4FB80 8005F380 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 4FB84 8005F384 2B91030C */  jal        SetSp
    /* 4FB88 8005F388 00000000 */   nop
    /* 4FB8C 8005F38C 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 4FB90 8005F390 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 4FB94 8005F394 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 4FB98 8005F398 1CD831AC */  sw         $s1, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 4FB9C 8005F39C EC7C0108 */  j          .L8005F3B0
    /* 4FBA0 8005F3A0 21280002 */   addu      $a1, $s0, $zero
  .L8005F3A4:
    /* 4FBA4 8005F3A4 E471010C */  jal        SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t
    /* 4FBA8 8005F3A8 20004526 */   addiu     $a1, $s2, 0x20
  .L8005F3AC:
    /* 4FBAC 8005F3AC 21280002 */  addu       $a1, $s0, $zero
  .L8005F3B0:
    /* 4FBB0 8005F3B0 0000A38E */  lw         $v1, 0x0($s5)
    /* 4FBB4 8005F3B4 00010224 */  addiu      $v0, $zero, 0x100
    /* 4FBB8 8005F3B8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 4FBBC 8005F3BC 0000448E */  lw         $a0, 0x0($s2)
    /* 4FBC0 8005F3C0 5405668C */  lw         $a2, 0x554($v1)
    /* 4FBC4 8005F3C4 35A1010C */  jal        AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii
    /* 4FBC8 8005F3C8 21380000 */   addu      $a3, $zero, $zero
    /* 4FBCC 8005F3CC 6A00C012 */  beqz       $s6, .L8005F578
    /* 4FBD0 8005F3D0 00000000 */   nop
    /* 4FBD4 8005F3D4 0000448E */  lw         $a0, 0x0($s2)
    /* 4FBD8 8005F3D8 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 4FBDC 8005F3DC 21286002 */   addu      $a1, $s3, $zero
    /* 4FBE0 8005F3E0 02004004 */  bltz       $v0, .L8005F3EC
    /* 4FBE4 8005F3E4 FFFF0324 */   addiu     $v1, $zero, -0x1
    /* 4FBE8 8005F3E8 01000324 */  addiu      $v1, $zero, 0x1
  .L8005F3EC:
    /* 4FBEC 8005F3EC 40100300 */  sll        $v0, $v1, 1
    /* 4FBF0 8005F3F0 21104300 */  addu       $v0, $v0, $v1
    /* 4FBF4 8005F3F4 40180200 */  sll        $v1, $v0, 1
    /* 4FBF8 8005F3F8 0C006004 */  bltz       $v1, .L8005F42C
    /* 4FBFC 8005F3FC 00000000 */   nop
    /* 4FC00 8005F400 0000428E */  lw         $v0, 0x0($s2)
    /* 4FC04 8005F404 00000000 */  nop
    /* 4FC08 8005F408 08004284 */  lh         $v0, 0x8($v0)
    /* 4FC0C 8005F40C 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 4FC10 8005F410 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 4FC14 8005F414 21184300 */  addu       $v1, $v0, $v1
    /* 4FC18 8005F418 2A106400 */  slt        $v0, $v1, $a0
    /* 4FC1C 8005F41C 0E004014 */  bnez       $v0, .L8005F458
    /* 4FC20 8005F420 00000000 */   nop
    /* 4FC24 8005F424 167D0108 */  j          .L8005F458
    /* 4FC28 8005F428 23186400 */   subu      $v1, $v1, $a0
  .L8005F42C:
    /* 4FC2C 8005F42C 0000428E */  lw         $v0, 0x0($s2)
    /* 4FC30 8005F430 00000000 */  nop
    /* 4FC34 8005F434 08004284 */  lh         $v0, 0x8($v0)
    /* 4FC38 8005F438 00000000 */  nop
    /* 4FC3C 8005F43C 21184300 */  addu       $v1, $v0, $v1
    /* 4FC40 8005F440 05006104 */  bgez       $v1, .L8005F458
    /* 4FC44 8005F444 00000000 */   nop
    /* 4FC48 8005F448 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4FC4C 8005F44C C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4FC50 8005F450 00000000 */  nop
    /* 4FC54 8005F454 21186200 */  addu       $v1, $v1, $v0
  .L8005F458:
    /* 4FC58 8005F458 740043AE */  sw         $v1, 0x74($s2)
    /* 4FC5C 8005F45C 1480033C */  lui        $v1, %hi(fastRandom)
    /* 4FC60 8005F460 FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 4FC64 8005F464 1480023C */  lui        $v0, %hi(randSeed)
    /* 4FC68 8005F468 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 4FC6C 8005F46C 00000000 */  nop
    /* 4FC70 8005F470 18006200 */  mult       $v1, $v0
    /* 4FC74 8005F474 12180000 */  mflo       $v1
    /* 4FC78 8005F478 FFFF6230 */  andi       $v0, $v1, 0xFFFF
    /* 4FC7C 8005F47C 1480013C */  lui        $at, %hi(randtemp)
    /* 4FC80 8005F480 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 4FC84 8005F484 021A0300 */  srl        $v1, $v1, 8
    /* 4FC88 8005F488 FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* 4FC8C 8005F48C 1480013C */  lui        $at, %hi(fastRandom)
    /* 4FC90 8005F490 FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 4FC94 8005F494 C0110300 */  sll        $v0, $v1, 7
    /* 4FC98 8005F498 23104300 */  subu       $v0, $v0, $v1
    /* 4FC9C 8005F49C 80100200 */  sll        $v0, $v0, 2
    /* 4FCA0 8005F4A0 23104300 */  subu       $v0, $v0, $v1
    /* 4FCA4 8005F4A4 C0100200 */  sll        $v0, $v0, 3
    /* 4FCA8 8005F4A8 21104300 */  addu       $v0, $v0, $v1
    /* 4FCAC 8005F4AC 80180200 */  sll        $v1, $v0, 2
    /* 4FCB0 8005F4B0 23186200 */  subu       $v1, $v1, $v0
    /* 4FCB4 8005F4B4 C0100300 */  sll        $v0, $v1, 3
    /* 4FCB8 8005F4B8 23104300 */  subu       $v0, $v0, $v1
    /* 4FCBC 8005F4BC 02140200 */  srl        $v0, $v0, 16
    /* 4FCC0 8005F4C0 99D90334 */  ori        $v1, $zero, 0xD999
    /* 4FCC4 8005F4C4 21104300 */  addu       $v0, $v0, $v1
    /* 4FCC8 8005F4C8 780042AE */  sw         $v0, 0x78($s2)
    /* 4FCCC 8005F4CC 7400428E */  lw         $v0, 0x74($s2)
    /* 4FCD0 8005F4D0 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 4FCD4 8005F4D4 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 4FCD8 8005F4D8 40110200 */  sll        $v0, $v0, 5
    /* 4FCDC 8005F4DC 21104300 */  addu       $v0, $v0, $v1
    /* 4FCE0 8005F4E0 1E004390 */  lbu        $v1, 0x1E($v0)
    /* 4FCE4 8005F4E4 1D004490 */  lbu        $a0, 0x1D($v0)
    /* 4FCE8 8005F4E8 C01B0300 */  sll        $v1, $v1, 15
    /* 4FCEC 8005F4EC 02210400 */  srl        $a0, $a0, 4
    /* 4FCF0 8005F4F0 18006400 */  mult       $v1, $a0
    /* 4FCF4 8005F4F4 12200000 */  mflo       $a0
    /* 4FCF8 8005F4F8 CA90030C */  jal        fixedmult
    /* 4FCFC 8005F4FC CCCC0534 */   ori       $a1, $zero, 0xCCCC
    /* 4FD00 8005F500 7400438E */  lw         $v1, 0x74($s2)
    /* 4FD04 8005F504 1480043C */  lui        $a0, %hi(BWorldSm_slices)
    /* 4FD08 8005F508 C0C7848C */  lw         $a0, %lo(BWorldSm_slices)($a0)
    /* 4FD0C 8005F50C 40190300 */  sll        $v1, $v1, 5
    /* 4FD10 8005F510 21186400 */  addu       $v1, $v1, $a0
    /* 4FD14 8005F514 1F006590 */  lbu        $a1, 0x1F($v1)
    /* 4FD18 8005F518 1D006490 */  lbu        $a0, 0x1D($v1)
    /* 4FD1C 8005F51C C02B0500 */  sll        $a1, $a1, 15
    /* 4FD20 8005F520 0F008430 */  andi       $a0, $a0, 0xF
    /* 4FD24 8005F524 1800A400 */  mult       $a1, $a0
    /* 4FD28 8005F528 21884000 */  addu       $s1, $v0, $zero
    /* 4FD2C 8005F52C 12200000 */  mflo       $a0
    /* 4FD30 8005F530 CA90030C */  jal        fixedmult
    /* 4FD34 8005F534 CCCC0534 */   ori       $a1, $zero, 0xCCCC
    /* 4FD38 8005F538 23281100 */  negu       $a1, $s1
    /* 4FD3C 8005F53C 1180063C */  lui        $a2, %hi(AICop_spikeBelt)
    /* 4FD40 8005F540 4CD5C424 */  addiu      $a0, $a2, %lo(AICop_spikeBelt)
    /* 4FD44 8005F544 7400478E */  lw         $a3, 0x74($s2)
    /* 4FD48 8005F548 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* 4FD4C 8005F54C 080085AC */  sw         $a1, 0x8($a0)
    /* 4FD50 8005F550 0C0082AC */  sw         $v0, 0xC($a0)
    /* 4FD54 8005F554 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* 4FD58 8005F558 01001024 */  addiu      $s0, $zero, 0x1
    /* 4FD5C 8005F55C 4CD5D0AC */  sw         $s0, %lo(AICop_spikeBelt)($a2)
    /* 4FD60 8005F560 040087AC */  sw         $a3, 0x4($a0)
    /* 4FD64 8005F564 100083AC */  sw         $v1, 0x10($a0)
    /* 4FD68 8005F568 7400448E */  lw         $a0, 0x74($s2)
    /* 4FD6C 8005F56C 31F6010C */  jal        BWorld_SetSpikeBelt__Fiii
    /* 4FD70 8005F570 21302202 */   addu      $a2, $s1, $v0
    /* 4FD74 8005F574 700050AE */  sw         $s0, 0x70($s2)
  .L8005F578:
    /* 4FD78 8005F578 BC57020C */  jal        Dispatch__6Speech
    /* 4FD7C 8005F57C 00000000 */   nop
    /* 4FD80 8005F580 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4FD84 8005F584 0000458E */  lw         $a1, 0x0($s2)
    /* 4FD88 8005F588 28006484 */  lh         $a0, 0x28($v1)
    /* 4FD8C 8005F58C 2C00638C */  lw         $v1, 0x2C($v1)
    /* 4FD90 8005F590 00000000 */  nop
    /* 4FD94 8005F594 09F86000 */  jalr       $v1
    /* 4FD98 8005F598 21204400 */   addu      $a0, $v0, $a0
    /* 4FD9C 8005F59C 3400BF8F */  lw         $ra, 0x34($sp)
    /* 4FDA0 8005F5A0 3000B68F */  lw         $s6, 0x30($sp)
    /* 4FDA4 8005F5A4 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 4FDA8 8005F5A8 2800B48F */  lw         $s4, 0x28($sp)
    /* 4FDAC 8005F5AC 2400B38F */  lw         $s3, 0x24($sp)
    /* 4FDB0 8005F5B0 2000B28F */  lw         $s2, 0x20($sp)
    /* 4FDB4 8005F5B4 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 4FDB8 8005F5B8 1800B08F */  lw         $s0, 0x18($sp)
    /* 4FDBC 8005F5BC 0800E003 */  jr         $ra
    /* 4FDC0 8005F5C0 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi
