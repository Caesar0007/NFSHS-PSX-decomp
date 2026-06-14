.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_Init__FPc, 0x46C

glabel Track_Init__FPc
    /* AB008 800BA808 48FFBD27 */  addiu      $sp, $sp, -0xB8
    /* AB00C 800BA80C 9000B0AF */  sw         $s0, 0x90($sp)
    /* AB010 800BA810 21808000 */  addu       $s0, $a0, $zero
    /* AB014 800BA814 1000A427 */  addiu      $a0, $sp, 0x10
    /* AB018 800BA818 1480053C */  lui        $a1, %hi(D_8013D490)
    /* AB01C 800BA81C 90D4A524 */  addiu      $a1, $a1, %lo(D_8013D490)
    /* AB020 800BA820 B000BFAF */  sw         $ra, 0xB0($sp)
    /* AB024 800BA824 AC00B7AF */  sw         $s7, 0xAC($sp)
    /* AB028 800BA828 A800B6AF */  sw         $s6, 0xA8($sp)
    /* AB02C 800BA82C A400B5AF */  sw         $s5, 0xA4($sp)
    /* AB030 800BA830 A000B4AF */  sw         $s4, 0xA0($sp)
    /* AB034 800BA834 9C00B3AF */  sw         $s3, 0x9C($sp)
    /* AB038 800BA838 9800B2AF */  sw         $s2, 0x98($sp)
    /* AB03C 800BA83C 9400B1AF */  sw         $s1, 0x94($sp)
    /* AB040 800BA840 800F80AF */  sw         $zero, %gp_rel(Track_gSaveSurface)($gp)
    /* AB044 800BA844 880F80AF */  sw         $zero, %gp_rel(Track_gObjDefs)($gp)
    /* AB048 800BA848 2F91030C */  jal        sprintf
    /* AB04C 800BA84C 21300002 */   addu      $a2, $s0, $zero
    /* AB050 800BA850 9B95030C */  jal        filesize
    /* AB054 800BA854 21200002 */   addu      $a0, $s0, $zero
    /* AB058 800BA858 0580043C */  lui        $a0, %hi(D_80056668)
    /* AB05C 800BA85C 68668424 */  addiu      $a0, $a0, %lo(D_80056668)
    /* AB060 800BA860 04040524 */  addiu      $a1, $zero, 0x404
    /* AB064 800BA864 21300000 */  addu       $a2, $zero, $zero
    /* AB068 800BA868 CF94030C */  jal        reservememadr
    /* AB06C 800BA86C 21904000 */   addu      $s2, $v0, $zero
    /* AB070 800BA870 1480013C */  lui        $at, %hi(Chunk_lightTable)
    /* AB074 800BA874 18C822AC */  sw         $v0, %lo(Chunk_lightTable)($at)
    /* AB078 800BA878 4D84030C */  jal        TextureProcess_Init__Fv
    /* AB07C 800BA87C 80901334 */   ori       $s3, $zero, 0x9080
    /* AB080 800BA880 F6E4020C */  jal        InitArtResources__Fv
    /* AB084 800BA884 21885302 */   addu      $s1, $s2, $s3
    /* AB088 800BA888 0CE6020C */  jal        TexturesLoadInitial__Fv
    /* AB08C 800BA88C 00000000 */   nop
    /* AB090 800BA890 578F020C */  jal        __builtin_new
    /* AB094 800BA894 0C000424 */   addiu     $a0, $zero, 0xC
    /* AB098 800BA898 0580043C */  lui        $a0, %hi(D_80056674)
    /* AB09C 800BA89C 74668424 */  addiu      $a0, $a0, %lo(D_80056674)
    /* AB0A0 800BA8A0 21282002 */  addu       $a1, $s1, $zero
    /* AB0A4 800BA8A4 21300000 */  addu       $a2, $zero, $zero
    /* AB0A8 800BA8A8 CF94030C */  jal        reservememadr
    /* AB0AC 800BA8AC 21804000 */   addu      $s0, $v0, $zero
    /* AB0B0 800BA8B0 000002AE */  sw         $v0, 0x0($s0)
    /* AB0B4 800BA8B4 21184000 */  addu       $v1, $v0, $zero
    /* AB0B8 800BA8B8 02006014 */  bnez       $v1, .L800BA8C4
    /* AB0BC 800BA8BC 040002AE */   sw        $v0, 0x4($s0)
    /* AB0C0 800BA8C0 21880000 */  addu       $s1, $zero, $zero
  .L800BA8C4:
    /* AB0C4 800BA8C4 21200002 */  addu       $a0, $s0, $zero
    /* AB0C8 800BA8C8 080091AC */  sw         $s1, 0x8($a0)
    /* AB0CC 800BA8CC 8C0F84AF */  sw         $a0, %gp_rel(Track_mem)($gp)
    /* AB0D0 800BA8D0 A7DC020C */  jal        FeignAlloc__9SimpleMemi
    /* AB0D4 800BA8D4 21284002 */   addu      $a1, $s2, $zero
    /* AB0D8 800BA8D8 1000A427 */  addiu      $a0, $sp, 0x10
    /* AB0DC 800BA8DC 3C96030C */  jal        loadfileatadr
    /* AB0E0 800BA8E0 21285300 */   addu      $a1, $v0, $s3
    /* AB0E4 800BA8E4 21804000 */  addu       $s0, $v0, $zero
    /* AB0E8 800BA8E8 21200002 */  addu       $a0, $s0, $zero
    /* AB0EC 800BA8EC 1F000524 */  addiu      $a1, $zero, 0x1F
    /* AB0F0 800BA8F0 8C0F868F */  lw         $a2, %gp_rel(Track_mem)($gp)
    /* AB0F4 800BA8F4 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* AB0F8 800BA8F8 21380000 */   addu      $a3, $zero, $zero
    /* AB0FC 800BA8FC 21200002 */  addu       $a0, $s0, $zero
    /* AB100 800BA900 20000524 */  addiu      $a1, $zero, 0x20
    /* AB104 800BA904 8C0F868F */  lw         $a2, %gp_rel(Track_mem)($gp)
    /* AB108 800BA908 04004224 */  addiu      $v0, $v0, 0x4
    /* AB10C 800BA90C 680F82AF */  sw         $v0, %gp_rel(Track_header)($gp)
    /* AB110 800BA910 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* AB114 800BA914 21380000 */   addu      $a3, $zero, $zero
    /* AB118 800BA918 21200002 */  addu       $a0, $s0, $zero
    /* AB11C 800BA91C 23000524 */  addiu      $a1, $zero, 0x23
    /* AB120 800BA920 04004224 */  addiu      $v0, $v0, 0x4
    /* AB124 800BA924 1480013C */  lui        $at, %hi(Chunk_chunkCenters)
    /* AB128 800BA928 1CC822AC */  sw         $v0, %lo(Chunk_chunkCenters)($at)
    /* AB12C 800BA92C 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* AB130 800BA930 21300000 */   addu      $a2, $zero, $zero
    /* AB134 800BA934 21284000 */  addu       $a1, $v0, $zero
    /* AB138 800BA938 1480043C */  lui        $a0, %hi(Chunk_lightTable)
    /* AB13C 800BA93C 18C8848C */  lw         $a0, %lo(Chunk_lightTable)($a0)
    /* AB140 800BA940 1000A324 */  addiu      $v1, $a1, 0x10
    /* AB144 800BA944 25106400 */  or         $v0, $v1, $a0
    /* AB148 800BA948 03004230 */  andi       $v0, $v0, 0x3
    /* AB14C 800BA94C 16004010 */  beqz       $v0, .L800BA9A8
    /* AB150 800BA950 1004A224 */   addiu     $v0, $a1, 0x410
  .L800BA954:
    /* AB154 800BA954 03006B88 */  lwl        $t3, 0x3($v1)
    /* AB158 800BA958 00006B98 */  lwr        $t3, 0x0($v1)
    /* AB15C 800BA95C 07006C88 */  lwl        $t4, 0x7($v1)
    /* AB160 800BA960 04006C98 */  lwr        $t4, 0x4($v1)
    /* AB164 800BA964 0B006D88 */  lwl        $t5, 0xB($v1)
    /* AB168 800BA968 08006D98 */  lwr        $t5, 0x8($v1)
    /* AB16C 800BA96C 0F006E88 */  lwl        $t6, 0xF($v1)
    /* AB170 800BA970 0C006E98 */  lwr        $t6, 0xC($v1)
    /* AB174 800BA974 03008BA8 */  swl        $t3, 0x3($a0)
    /* AB178 800BA978 00008BB8 */  swr        $t3, 0x0($a0)
    /* AB17C 800BA97C 07008CA8 */  swl        $t4, 0x7($a0)
    /* AB180 800BA980 04008CB8 */  swr        $t4, 0x4($a0)
    /* AB184 800BA984 0B008DA8 */  swl        $t5, 0xB($a0)
    /* AB188 800BA988 08008DB8 */  swr        $t5, 0x8($a0)
    /* AB18C 800BA98C 0F008EA8 */  swl        $t6, 0xF($a0)
    /* AB190 800BA990 0C008EB8 */  swr        $t6, 0xC($a0)
    /* AB194 800BA994 10006324 */  addiu      $v1, $v1, 0x10
    /* AB198 800BA998 EEFF6214 */  bne        $v1, $v0, .L800BA954
    /* AB19C 800BA99C 10008424 */   addiu     $a0, $a0, 0x10
    /* AB1A0 800BA9A0 76EA0208 */  j          .L800BA9D8
    /* AB1A4 800BA9A4 21200002 */   addu      $a0, $s0, $zero
  .L800BA9A8:
    /* AB1A8 800BA9A8 00006B8C */  lw         $t3, 0x0($v1)
    /* AB1AC 800BA9AC 04006C8C */  lw         $t4, 0x4($v1)
    /* AB1B0 800BA9B0 08006D8C */  lw         $t5, 0x8($v1)
    /* AB1B4 800BA9B4 0C006E8C */  lw         $t6, 0xC($v1)
    /* AB1B8 800BA9B8 00008BAC */  sw         $t3, 0x0($a0)
    /* AB1BC 800BA9BC 04008CAC */  sw         $t4, 0x4($a0)
    /* AB1C0 800BA9C0 08008DAC */  sw         $t5, 0x8($a0)
    /* AB1C4 800BA9C4 0C008EAC */  sw         $t6, 0xC($a0)
    /* AB1C8 800BA9C8 10006324 */  addiu      $v1, $v1, 0x10
    /* AB1CC 800BA9CC F6FF6214 */  bne        $v1, $v0, .L800BA9A8
    /* AB1D0 800BA9D0 10008424 */   addiu     $a0, $a0, 0x10
    /* AB1D4 800BA9D4 21200002 */  addu       $a0, $s0, $zero
  .L800BA9D8:
    /* AB1D8 800BA9D8 23000524 */  addiu      $a1, $zero, 0x23
    /* AB1DC 800BA9DC 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* AB1E0 800BA9E0 21300000 */   addu      $a2, $zero, $zero
    /* AB1E4 800BA9E4 21300000 */  addu       $a2, $zero, $zero
    /* AB1E8 800BA9E8 2190C000 */  addu       $s2, $a2, $zero
    /* AB1EC 800BA9EC FF031624 */  addiu      $s6, $zero, 0x3FF
    /* AB1F0 800BA9F0 2198C000 */  addu       $s3, $a2, $zero
    /* AB1F4 800BA9F4 21A8C000 */  addu       $s5, $a2, $zero
    /* AB1F8 800BA9F8 8C0F848F */  lw         $a0, %gp_rel(Track_mem)($gp)
    /* AB1FC 800BA9FC 0400428C */  lw         $v0, 0x4($v0)
    /* AB200 800BAA00 680F838F */  lw         $v1, %gp_rel(Track_header)($gp)
    /* AB204 800BAA04 F0FF4224 */  addiu      $v0, $v0, -0x10
    /* AB208 800BAA08 1C00638C */  lw         $v1, 0x1C($v1)
    /* AB20C 800BAA0C 82100200 */  srl        $v0, $v0, 2
    /* AB210 800BAA10 A00F82AF */  sw         $v0, %gp_rel(Chunk_numLight)($gp)
    /* AB214 800BAA14 C0280300 */  sll        $a1, $v1, 3
    /* AB218 800BAA18 2128A300 */  addu       $a1, $a1, $v1
    /* AB21C 800BAA1C 94DC020C */  jal        Alloc__9SimpleMemii
    /* AB220 800BAA20 C0280500 */   sll       $a1, $a1, 3
    /* AB224 800BAA24 680F838F */  lw         $v1, %gp_rel(Track_header)($gp)
    /* AB228 800BAA28 8C0F848F */  lw         $a0, %gp_rel(Track_mem)($gp)
    /* AB22C 800BAA2C 1C00658C */  lw         $a1, 0x1C($v1)
    /* AB230 800BAA30 600F82AF */  sw         $v0, %gp_rel(Track_gInViewList)($gp)
    /* AB234 800BAA34 94DC020C */  jal        Alloc__9SimpleMemii
    /* AB238 800BAA38 21300000 */   addu      $a2, $zero, $zero
    /* AB23C 800BAA3C 680F838F */  lw         $v1, %gp_rel(Track_header)($gp)
    /* AB240 800BAA40 8C0F848F */  lw         $a0, %gp_rel(Track_mem)($gp)
    /* AB244 800BAA44 1C00638C */  lw         $v1, 0x1C($v1)
    /* AB248 800BAA48 21300000 */  addu       $a2, $zero, $zero
    /* AB24C 800BAA4C 640F82AF */  sw         $v0, %gp_rel(Track_gInViewCount)($gp)
    /* AB250 800BAA50 C0280300 */  sll        $a1, $v1, 3
    /* AB254 800BAA54 2328A300 */  subu       $a1, $a1, $v1
    /* AB258 800BAA58 94DC020C */  jal        Alloc__9SimpleMemii
    /* AB25C 800BAA5C 00290500 */   sll       $a1, $a1, 4
    /* AB260 800BAA60 6C0F82AF */  sw         $v0, %gp_rel(Track_chunkList)($gp)
    /* AB264 800BAA64 4A2E020C */  jal        Chunk_Init__Fv
    /* AB268 800BAA68 00000000 */   nop
    /* AB26C 800BAA6C 21200002 */  addu       $a0, $s0, $zero
    /* AB270 800BAA70 21000524 */  addiu      $a1, $zero, 0x21
    /* AB274 800BAA74 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* AB278 800BAA78 21300000 */   addu      $a2, $zero, $zero
    /* AB27C 800BAA7C 21200002 */  addu       $a0, $s0, $zero
    /* AB280 800BAA80 1D000524 */  addiu      $a1, $zero, 0x1D
    /* AB284 800BAA84 21300000 */  addu       $a2, $zero, $zero
    /* AB288 800BAA88 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* AB28C 800BAA8C 21B84000 */   addu      $s7, $v0, $zero
    /* AB290 800BAA90 21804000 */  addu       $s0, $v0, $zero
  .L800BAA94:
    /* AB294 800BAA94 680F828F */  lw         $v0, %gp_rel(Track_header)($gp)
    /* AB298 800BAA98 00000000 */  nop
    /* AB29C 800BAA9C 1C00438C */  lw         $v1, 0x1C($v0)
    /* AB2A0 800BAAA0 00000000 */  nop
    /* AB2A4 800BAAA4 2A104302 */  slt        $v0, $s2, $v1
    /* AB2A8 800BAAA8 42004010 */  beqz       $v0, .L800BABB4
    /* AB2AC 800BAAAC 00000000 */   nop
    /* AB2B0 800BAAB0 6C0F828F */  lw         $v0, %gp_rel(Track_chunkList)($gp)
    /* AB2B4 800BAAB4 00000000 */  nop
    /* AB2B8 800BAAB8 21885500 */  addu       $s1, $v0, $s5
    /* AB2BC 800BAABC FFFF6224 */  addiu      $v0, $v1, -0x1
    /* AB2C0 800BAAC0 2A104202 */  slt        $v0, $s2, $v0
    /* AB2C4 800BAAC4 05004010 */  beqz       $v0, .L800BAADC
    /* AB2C8 800BAAC8 21A00000 */   addu      $s4, $zero, $zero
    /* AB2CC 800BAACC 21200002 */  addu       $a0, $s0, $zero
    /* AB2D0 800BAAD0 4A70020C */  jal        LocateNextGroupType__15SerializedGroupi
    /* AB2D4 800BAAD4 1D000524 */   addiu     $a1, $zero, 0x1D
    /* AB2D8 800BAAD8 21A04000 */  addu       $s4, $v0, $zero
  .L800BAADC:
    /* AB2DC 800BAADC 21202002 */  addu       $a0, $s1, $zero
    /* AB2E0 800BAAE0 8C0F868F */  lw         $a2, %gp_rel(Track_mem)($gp)
    /* AB2E4 800BAAE4 FF2C020C */  jal        InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem
    /* AB2E8 800BAAE8 21280002 */   addu      $a1, $s0, $zero
    /* AB2EC 800BAAEC 21200002 */  addu       $a0, $s0, $zero
    /* AB2F0 800BAAF0 04000524 */  addiu      $a1, $zero, 0x4
    /* AB2F4 800BAAF4 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* AB2F8 800BAAF8 21300000 */   addu      $a2, $zero, $zero
    /* AB2FC 800BAAFC 0C00498C */  lw         $t1, 0xC($v0)
    /* AB300 800BAB00 10004324 */  addiu      $v1, $v0, 0x10
    /* AB304 800BAB04 25002229 */  slti       $v0, $t1, 0x25
    /* AB308 800BAB08 02004014 */  bnez       $v0, .L800BAB14
    /* AB30C 800BAB0C 21400000 */   addu      $t0, $zero, $zero
    /* AB310 800BAB10 24000924 */  addiu      $t1, $zero, 0x24
  .L800BAB14:
    /* AB314 800BAB14 12002019 */  blez       $t1, .L800BAB60
    /* AB318 800BAB18 21280001 */   addu      $a1, $t0, $zero
    /* AB31C 800BAB1C 21386000 */  addu       $a3, $v1, $zero
    /* AB320 800BAB20 600F828F */  lw         $v0, %gp_rel(Track_gInViewList)($gp)
    /* AB324 800BAB24 680F8A8F */  lw         $t2, %gp_rel(Track_header)($gp)
    /* AB328 800BAB28 21306202 */  addu       $a2, $s3, $v0
  .L800BAB2C:
    /* AB32C 800BAB2C 0000E494 */  lhu        $a0, 0x0($a3)
    /* AB330 800BAB30 1C00438D */  lw         $v1, 0x1C($t2)
    /* AB334 800BAB34 FF038230 */  andi       $v0, $a0, 0x3FF
    /* AB338 800BAB38 2A104300 */  slt        $v0, $v0, $v1
    /* AB33C 800BAB3C 04004010 */  beqz       $v0, .L800BAB50
    /* AB340 800BAB40 00000000 */   nop
    /* AB344 800BAB44 0000C4A4 */  sh         $a0, 0x0($a2)
    /* AB348 800BAB48 0200C624 */  addiu      $a2, $a2, 0x2
    /* AB34C 800BAB4C 0100A524 */  addiu      $a1, $a1, 0x1
  .L800BAB50:
    /* AB350 800BAB50 01000825 */  addiu      $t0, $t0, 0x1
    /* AB354 800BAB54 2A100901 */  slt        $v0, $t0, $t1
    /* AB358 800BAB58 F4FF4014 */  bnez       $v0, .L800BAB2C
    /* AB35C 800BAB5C 0200E724 */   addiu     $a3, $a3, 0x2
  .L800BAB60:
    /* AB360 800BAB60 640F828F */  lw         $v0, %gp_rel(Track_gInViewCount)($gp)
    /* AB364 800BAB64 00000000 */  nop
    /* AB368 800BAB68 21105200 */  addu       $v0, $v0, $s2
    /* AB36C 800BAB6C 000045A0 */  sb         $a1, 0x0($v0)
    /* AB370 800BAB70 2400A228 */  slti       $v0, $a1, 0x24
    /* AB374 800BAB74 0A004010 */  beqz       $v0, .L800BABA0
    /* AB378 800BAB78 40180500 */   sll       $v1, $a1, 1
    /* AB37C 800BAB7C 600F828F */  lw         $v0, %gp_rel(Track_gInViewList)($gp)
    /* AB380 800BAB80 00000000 */  nop
    /* AB384 800BAB84 21106202 */  addu       $v0, $s3, $v0
    /* AB388 800BAB88 21186200 */  addu       $v1, $v1, $v0
  .L800BAB8C:
    /* AB38C 800BAB8C 000076A4 */  sh         $s6, 0x0($v1)
    /* AB390 800BAB90 0100A524 */  addiu      $a1, $a1, 0x1
    /* AB394 800BAB94 2400A228 */  slti       $v0, $a1, 0x24
    /* AB398 800BAB98 FCFF4014 */  bnez       $v0, .L800BAB8C
    /* AB39C 800BAB9C 02006324 */   addiu     $v1, $v1, 0x2
  .L800BABA0:
    /* AB3A0 800BABA0 21808002 */  addu       $s0, $s4, $zero
    /* AB3A4 800BABA4 40007326 */  addiu      $s3, $s3, 0x40
    /* AB3A8 800BABA8 7000B526 */  addiu      $s5, $s5, 0x70
    /* AB3AC 800BABAC A5EA0208 */  j          .L800BAA94
    /* AB3B0 800BABB0 01005226 */   addiu     $s2, $s2, 0x1
  .L800BABB4:
    /* AB3B4 800BABB4 8BE9020C */  jal        Track_InitPersistentData__FP15SerializedGroup
    /* AB3B8 800BABB8 2120E002 */   addu      $a0, $s7, $zero
    /* AB3BC 800BABBC 8C0F848F */  lw         $a0, %gp_rel(Track_mem)($gp)
    /* AB3C0 800BABC0 AFDC020C */  jal        ResizeToFit__9SimpleMem
    /* AB3C4 800BABC4 00000000 */   nop
    /* AB3C8 800BABC8 1480043C */  lui        $a0, %hi(D_8013D494)
    /* AB3CC 800BABCC C2E4020C */  jal        Track_MakeTrackPathName__FPc
    /* AB3D0 800BABD0 94D48424 */   addiu     $a0, $a0, %lo(D_8013D494)
    /* AB3D4 800BABD4 1480043C */  lui        $a0, %hi(D_8013D49C)
    /* AB3D8 800BABD8 700F828F */  lw         $v0, %gp_rel(gPersistObjDef)($gp)
    /* AB3DC 800BABDC 9CD48424 */  addiu      $a0, $a0, %lo(D_8013D49C)
    /* AB3E0 800BABE0 0000458C */  lw         $a1, 0x0($v0)
    /* AB3E4 800BABE4 21300000 */  addu       $a2, $zero, $zero
    /* AB3E8 800BABE8 C0280500 */  sll        $a1, $a1, 3
    /* AB3EC 800BABEC CF94030C */  jal        reservememadr
    /* AB3F0 800BABF0 0400A534 */   ori       $a1, $a1, 0x4
    /* AB3F4 800BABF4 700F848F */  lw         $a0, %gp_rel(gPersistObjDef)($gp)
    /* AB3F8 800BABF8 21284000 */  addu       $a1, $v0, $zero
    /* AB3FC 800BABFC 7C0F85AF */  sw         $a1, %gp_rel(gPersistObjDefBoundingSpheres)($gp)
    /* AB400 800BAC00 DAE8020C */  jal        CalcObjectBoundingSphere__FP5GroupT0
    /* AB404 800BAC04 00000000 */   nop
    /* AB408 800BAC08 780F848F */  lw         $a0, %gp_rel(gPersistMidgroundObjInst)($gp)
    /* AB40C 800BAC0C 700F858F */  lw         $a1, %gp_rel(gPersistObjDef)($gp)
    /* AB410 800BAC10 97E8020C */  jal        ReduceObjectPrecision__FP5GroupT0i
    /* AB414 800BAC14 02000624 */   addiu     $a2, $zero, 0x2
    /* AB418 800BAC18 740F848F */  lw         $a0, %gp_rel(gPersistObjInst)($gp)
    /* AB41C 800BAC1C 700F858F */  lw         $a1, %gp_rel(gPersistObjDef)($gp)
    /* AB420 800BAC20 BFE8020C */  jal        InvalidatePersistentCollideBoomObjects__FP5GroupT0
    /* AB424 800BAC24 00000000 */   nop
    /* AB428 800BAC28 578F020C */  jal        __builtin_new
    /* AB42C 800BAC2C 08000424 */   addiu     $a0, $zero, 0x8
    /* AB430 800BAC30 21204000 */  addu       $a0, $v0, $zero
    /* AB434 800BAC34 DCEB020C */  jal        __11SaveSurfacei
    /* AB438 800BAC38 30000524 */   addiu     $a1, $zero, 0x30
    /* AB43C 800BAC3C 800F82AF */  sw         $v0, %gp_rel(Track_gSaveSurface)($gp)
    /* AB440 800BAC40 6DEB020C */  jal        Track_LoadObjectKillData__Fv
    /* AB444 800BAC44 00000000 */   nop
    /* AB448 800BAC48 B000BF8F */  lw         $ra, 0xB0($sp)
    /* AB44C 800BAC4C AC00B78F */  lw         $s7, 0xAC($sp)
    /* AB450 800BAC50 A800B68F */  lw         $s6, 0xA8($sp)
    /* AB454 800BAC54 A400B58F */  lw         $s5, 0xA4($sp)
    /* AB458 800BAC58 A000B48F */  lw         $s4, 0xA0($sp)
    /* AB45C 800BAC5C 9C00B38F */  lw         $s3, 0x9C($sp)
    /* AB460 800BAC60 9800B28F */  lw         $s2, 0x98($sp)
    /* AB464 800BAC64 9400B18F */  lw         $s1, 0x94($sp)
    /* AB468 800BAC68 9000B08F */  lw         $s0, 0x90($sp)
    /* AB46C 800BAC6C 0800E003 */  jr         $ra
    /* AB470 800BAC70 B800BD27 */   addiu     $sp, $sp, 0xB8
endlabel Track_Init__FPc
