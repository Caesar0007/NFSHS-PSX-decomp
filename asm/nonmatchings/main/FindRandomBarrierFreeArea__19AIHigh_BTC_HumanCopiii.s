.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii, 0x1D0

glabel FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii
    /* 4D950 8005D150 1480033C */  lui        $v1, %hi(fastRandom)
    /* 4D954 8005D154 FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 4D958 8005D158 1480023C */  lui        $v0, %hi(randSeed)
    /* 4D95C 8005D15C 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 4D960 8005D160 00000000 */  nop
    /* 4D964 8005D164 18006200 */  mult       $v1, $v0
    /* 4D968 8005D168 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 4D96C 8005D16C 12180000 */  mflo       $v1
    /* 4D970 8005D170 02120300 */  srl        $v0, $v1, 8
    /* 4D974 8005D174 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 4D978 8005D178 40100200 */  sll        $v0, $v0, 1
    /* 4D97C 8005D17C 1800E200 */  mult       $a3, $v0
    /* 4D980 8005D180 2400B5AF */  sw         $s5, 0x24($sp)
    /* 4D984 8005D184 2800BFAF */  sw         $ra, 0x28($sp)
    /* 4D988 8005D188 2000B4AF */  sw         $s4, 0x20($sp)
    /* 4D98C 8005D18C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 4D990 8005D190 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4D994 8005D194 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4D998 8005D198 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4D99C 8005D19C 1480013C */  lui        $at, %hi(randtemp)
    /* 4D9A0 8005D1A0 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 4D9A4 8005D1A4 FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* 4D9A8 8005D1A8 1480013C */  lui        $at, %hi(fastRandom)
    /* 4D9AC 8005D1AC FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 4D9B0 8005D1B0 12480000 */  mflo       $t1
    /* 4D9B4 8005D1B4 02140900 */  srl        $v0, $t1, 16
    /* 4D9B8 8005D1B8 23104700 */  subu       $v0, $v0, $a3
    /* 4D9BC 8005D1BC 09004004 */  bltz       $v0, .L8005D1E4
    /* 4D9C0 8005D1C0 21A8C000 */   addu      $s5, $a2, $zero
    /* 4D9C4 8005D1C4 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 4D9C8 8005D1C8 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 4D9CC 8005D1CC 2188A200 */  addu       $s1, $a1, $v0
    /* 4D9D0 8005D1D0 2A102302 */  slt        $v0, $s1, $v1
    /* 4D9D4 8005D1D4 0B004014 */  bnez       $v0, .L8005D204
    /* 4D9D8 8005D1D8 6666023C */   lui       $v0, (0x66666667 >> 16)
    /* 4D9DC 8005D1DC 81740108 */  j          .L8005D204
    /* 4D9E0 8005D1E0 23882302 */   subu      $s1, $s1, $v1
  .L8005D1E4:
    /* 4D9E4 8005D1E4 2188A200 */  addu       $s1, $a1, $v0
    /* 4D9E8 8005D1E8 06002106 */  bgez       $s1, .L8005D204
    /* 4D9EC 8005D1EC 6666023C */   lui       $v0, (0x66666667 >> 16)
    /* 4D9F0 8005D1F0 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4D9F4 8005D1F4 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4D9F8 8005D1F8 00000000 */  nop
    /* 4D9FC 8005D1FC 21882202 */  addu       $s1, $s1, $v0
    /* 4DA00 8005D200 6666023C */  lui        $v0, (0x66666667 >> 16)
  .L8005D204:
    /* 4DA04 8005D204 67664234 */  ori        $v0, $v0, (0x66666667 & 0xFFFF)
    /* 4DA08 8005D208 1800A202 */  mult       $s5, $v0
    /* 4DA0C 8005D20C 21980000 */  addu       $s3, $zero, $zero
    /* 4DA10 8005D210 40A01500 */  sll        $s4, $s5, 1
    /* 4DA14 8005D214 C3171500 */  sra        $v0, $s5, 31
    /* 4DA18 8005D218 10400000 */  mfhi       $t0
    /* 4DA1C 8005D21C 43180800 */  sra        $v1, $t0, 1
    /* 4DA20 8005D220 23906200 */  subu       $s2, $v1, $v0
  .L8005D224:
    /* 4DA24 8005D224 1E00622A */  slti       $v0, $s3, 0x1E
    /* 4DA28 8005D228 33004010 */  beqz       $v0, .L8005D2F8
    /* 4DA2C 8005D22C 23101500 */   negu      $v0, $s5
    /* 4DA30 8005D230 09004004 */  bltz       $v0, .L8005D258
    /* 4DA34 8005D234 23803502 */   subu      $s0, $s1, $s5
    /* 4DA38 8005D238 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 4DA3C 8005D23C C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 4DA40 8005D240 00000000 */  nop
    /* 4DA44 8005D244 2A100302 */  slt        $v0, $s0, $v1
    /* 4DA48 8005D248 0A004014 */  bnez       $v0, .L8005D274
    /* 4DA4C 8005D24C 21200002 */   addu      $a0, $s0, $zero
    /* 4DA50 8005D250 9C740108 */  j          .L8005D270
    /* 4DA54 8005D254 23800302 */   subu      $s0, $s0, $v1
  .L8005D258:
    /* 4DA58 8005D258 06000106 */  bgez       $s0, .L8005D274
    /* 4DA5C 8005D25C 21200002 */   addu      $a0, $s0, $zero
    /* 4DA60 8005D260 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4DA64 8005D264 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4DA68 8005D268 00000000 */  nop
    /* 4DA6C 8005D26C 21800202 */  addu       $s0, $s0, $v0
  .L8005D270:
    /* 4DA70 8005D270 21200002 */  addu       $a0, $s0, $zero
  .L8005D274:
    /* 4DA74 8005D274 21288002 */  addu       $a1, $s4, $zero
    /* 4DA78 8005D278 01000624 */  addiu      $a2, $zero, 0x1
    /* 4DA7C 8005D27C BCCC010C */  jal        AIWorld_IsDriveableLaneInSliceRange__Fiiii
    /* 4DA80 8005D280 06000724 */   addiu     $a3, $zero, 0x6
    /* 4DA84 8005D284 21200002 */  addu       $a0, $s0, $zero
    /* 4DA88 8005D288 21288002 */  addu       $a1, $s4, $zero
    /* 4DA8C 8005D28C 01000624 */  addiu      $a2, $zero, 0x1
    /* 4DA90 8005D290 07000724 */  addiu      $a3, $zero, 0x7
    /* 4DA94 8005D294 BCCC010C */  jal        AIWorld_IsDriveableLaneInSliceRange__Fiiii
    /* 4DA98 8005D298 21804000 */   addu      $s0, $v0, $zero
    /* 4DA9C 8005D29C 03000012 */  beqz       $s0, .L8005D2AC
    /* 4DAA0 8005D2A0 00000000 */   nop
    /* 4DAA4 8005D2A4 15004014 */  bnez       $v0, .L8005D2FC
    /* 4DAA8 8005D2A8 21102002 */   addu      $v0, $s1, $zero
  .L8005D2AC:
    /* 4DAAC 8005D2AC 09004006 */  bltz       $s2, .L8005D2D4
    /* 4DAB0 8005D2B0 21283202 */   addu      $a1, $s1, $s2
    /* 4DAB4 8005D2B4 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 4DAB8 8005D2B8 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 4DABC 8005D2BC 00000000 */  nop
    /* 4DAC0 8005D2C0 2A10A300 */  slt        $v0, $a1, $v1
    /* 4DAC4 8005D2C4 0A004014 */  bnez       $v0, .L8005D2F0
    /* 4DAC8 8005D2C8 2188A000 */   addu      $s1, $a1, $zero
    /* 4DACC 8005D2CC BB740108 */  j          .L8005D2EC
    /* 4DAD0 8005D2D0 2328A300 */   subu      $a1, $a1, $v1
  .L8005D2D4:
    /* 4DAD4 8005D2D4 0600A104 */  bgez       $a1, .L8005D2F0
    /* 4DAD8 8005D2D8 2188A000 */   addu      $s1, $a1, $zero
    /* 4DADC 8005D2DC 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4DAE0 8005D2E0 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4DAE4 8005D2E4 00000000 */  nop
    /* 4DAE8 8005D2E8 2128A200 */  addu       $a1, $a1, $v0
  .L8005D2EC:
    /* 4DAEC 8005D2EC 2188A000 */  addu       $s1, $a1, $zero
  .L8005D2F0:
    /* 4DAF0 8005D2F0 89740108 */  j          .L8005D224
    /* 4DAF4 8005D2F4 01007326 */   addiu     $s3, $s3, 0x1
  .L8005D2F8:
    /* 4DAF8 8005D2F8 21102002 */  addu       $v0, $s1, $zero
  .L8005D2FC:
    /* 4DAFC 8005D2FC 2800BF8F */  lw         $ra, 0x28($sp)
    /* 4DB00 8005D300 2400B58F */  lw         $s5, 0x24($sp)
    /* 4DB04 8005D304 2000B48F */  lw         $s4, 0x20($sp)
    /* 4DB08 8005D308 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 4DB0C 8005D30C 1800B28F */  lw         $s2, 0x18($sp)
    /* 4DB10 8005D310 1400B18F */  lw         $s1, 0x14($sp)
    /* 4DB14 8005D314 1000B08F */  lw         $s0, 0x10($sp)
    /* 4DB18 8005D318 0800E003 */  jr         $ra
    /* 4DB1C 8005D31C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii
