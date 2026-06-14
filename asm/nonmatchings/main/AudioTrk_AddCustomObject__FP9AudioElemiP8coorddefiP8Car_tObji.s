.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji, 0x674

glabel AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji
    /* 6CF50 8007C750 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6CF54 8007C754 38FFBD27 */  addiu      $sp, $sp, -0xC8
    /* 6CF58 8007C758 B000B4AF */  sw         $s4, 0xB0($sp)
    /* 6CF5C 8007C75C 21A08000 */  addu       $s4, $a0, $zero
    /* 6CF60 8007C760 A000B0AF */  sw         $s0, 0xA0($sp)
    /* 6CF64 8007C764 2180A000 */  addu       $s0, $a1, $zero
    /* 6CF68 8007C768 C400BFAF */  sw         $ra, 0xC4($sp)
    /* 6CF6C 8007C76C C000BEAF */  sw         $fp, 0xC0($sp)
    /* 6CF70 8007C770 BC00B7AF */  sw         $s7, 0xBC($sp)
    /* 6CF74 8007C774 B800B6AF */  sw         $s6, 0xB8($sp)
    /* 6CF78 8007C778 B400B5AF */  sw         $s5, 0xB4($sp)
    /* 6CF7C 8007C77C AC00B3AF */  sw         $s3, 0xAC($sp)
    /* 6CF80 8007C780 A800B2AF */  sw         $s2, 0xA8($sp)
    /* 6CF84 8007C784 A400B1AF */  sw         $s1, 0xA4($sp)
    /* 6CF88 8007C788 D000A6AF */  sw         $a2, 0xD0($sp)
    /* 6CF8C 8007C78C 81014010 */  beqz       $v0, .L8007CD94
    /* 6CF90 8007C790 D400A7AF */   sw        $a3, 0xD4($sp)
    /* 6CF94 8007C794 1180053C */  lui        $a1, %hi(AudioClc_gRenderView)
    /* 6CF98 8007C798 0E75020C */  jal        Math_Dist3D__FP8coorddefT0
    /* 6CF9C 8007C79C 28E4A524 */   addiu     $a1, $a1, %lo(AudioClc_gRenderView)
    /* 6CFA0 8007C7A0 10008386 */  lh         $v1, 0x10($s4)
    /* 6CFA4 8007C7A4 21B84000 */  addu       $s7, $v0, $zero
    /* 6CFA8 8007C7A8 64006324 */  addiu      $v1, $v1, 0x64
    /* 6CFAC 8007C7AC 001C0300 */  sll        $v1, $v1, 16
    /* 6CFB0 8007C7B0 2A18E302 */  slt        $v1, $s7, $v1
    /* 6CFB4 8007C7B4 08006010 */  beqz       $v1, .L8007C7D8
    /* 6CFB8 8007C7B8 00000000 */   nop
    /* 6CFBC 8007C7BC 0E008292 */  lbu        $v0, 0xE($s4)
    /* 6CFC0 8007C7C0 1480033C */  lui        $v1, %hi(CopSpeak_gNumTrackSfx)
    /* 6CFC4 8007C7C4 D4D0638C */  lw         $v1, %lo(CopSpeak_gNumTrackSfx)($v1)
    /* 6CFC8 8007C7C8 00000000 */  nop
    /* 6CFCC 8007C7CC 2A104300 */  slt        $v0, $v0, $v1
    /* 6CFD0 8007C7D0 15004014 */  bnez       $v0, .L8007C828
    /* 6CFD4 8007C7D4 21900000 */   addu      $s2, $zero, $zero
  .L8007C7D8:
    /* 6CFD8 8007C7D8 15008482 */  lb         $a0, 0x15($s4)
    /* 6CFDC 8007C7DC 00000000 */  nop
    /* 6CFE0 8007C7E0 6C018004 */  bltz       $a0, .L8007CD94
    /* 6CFE4 8007C7E4 00190400 */   sll       $v1, $a0, 4
    /* 6CFE8 8007C7E8 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6CFEC 8007C7EC 00000000 */  nop
    /* 6CFF0 8007C7F0 21804300 */  addu       $s0, $v0, $v1
    /* 6CFF4 8007C7F4 0400028E */  lw         $v0, 0x4($s0)
    /* 6CFF8 8007C7F8 FFFF1124 */  addiu      $s1, $zero, -0x1
    /* 6CFFC 8007C7FC 04005110 */  beq        $v0, $s1, .L8007C810
    /* 6D000 8007C800 00000000 */   nop
    /* 6D004 8007C804 34E0010C */  jal        freeVoiceChannel__Fi
    /* 6D008 8007C808 37008424 */   addiu     $a0, $a0, 0x37
    /* 6D00C 8007C80C 040011AE */  sw         $s1, 0x4($s0)
  .L8007C810:
    /* 6D010 8007C810 0000028E */  lw         $v0, 0x0($s0)
    /* 6D014 8007C814 00000000 */  nop
    /* 6D018 8007C818 150051A0 */  sb         $s1, 0x15($v0)
    /* 6D01C 8007C81C 000000AE */  sw         $zero, 0x0($s0)
    /* 6D020 8007C820 65F30108 */  j          .L8007CD94
    /* 6D024 8007C824 0C0011A6 */   sh        $s1, 0xC($s0)
  .L8007C828:
    /* 6D028 8007C828 15008282 */  lb         $v0, 0x15($s4)
    /* 6D02C 8007C82C 00000000 */  nop
    /* 6D030 8007C830 06004004 */  bltz       $v0, .L8007C84C
    /* 6D034 8007C834 FFFF1624 */   addiu     $s6, $zero, -0x1
    /* 6D038 8007C838 21B04000 */  addu       $s6, $v0, $zero
    /* 6D03C 8007C83C 0802838F */  lw         $v1, %gp_rel(AudioTrk_g)($gp)
    /* 6D040 8007C840 00111600 */  sll        $v0, $s6, 4
    /* 6D044 8007C844 3CF20108 */  j          .L8007C8F0
    /* 6D048 8007C848 21906200 */   addu      $s2, $v1, $v0
  .L8007C84C:
    /* 6D04C 8007C84C 0C008296 */  lhu        $v0, 0xC($s4)
    /* 6D050 8007C850 00000000 */  nop
    /* 6D054 8007C854 03004010 */  beqz       $v0, .L8007C864
    /* 6D058 8007C858 21880000 */   addu      $s1, $zero, $zero
    /* 6D05C 8007C85C 4D015014 */  bne        $v0, $s0, .L8007CD94
    /* 6D060 8007C860 00000000 */   nop
  .L8007C864:
    /* 6D064 8007C864 FFFF1324 */  addiu      $s3, $zero, -0x1
  .L8007C868:
    /* 6D068 8007C868 1000222A */  slti       $v0, $s1, 0x10
    /* 6D06C 8007C86C 20004010 */  beqz       $v0, .L8007C8F0
    /* 6D070 8007C870 00191100 */   sll       $v1, $s1, 4
    /* 6D074 8007C874 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6D078 8007C878 00000000 */  nop
    /* 6D07C 8007C87C 21184300 */  addu       $v1, $v0, $v1
    /* 6D080 8007C880 0000628C */  lw         $v0, 0x0($v1)
    /* 6D084 8007C884 00000000 */  nop
    /* 6D088 8007C888 17004014 */  bnez       $v0, .L8007C8E8
    /* 6D08C 8007C88C 00000000 */   nop
    /* 6D090 8007C890 21906000 */  addu       $s2, $v1, $zero
    /* 6D094 8007C894 000074AC */  sw         $s4, 0x0($v1)
    /* 6D098 8007C898 080053AE */  sw         $s3, 0x8($s2)
    /* 6D09C 8007C89C 17008292 */  lbu        $v0, 0x17($s4)
    /* 6D0A0 8007C8A0 16009092 */  lbu        $s0, 0x16($s4)
    /* 6D0A4 8007C8A4 0D004010 */  beqz       $v0, .L8007C8DC
    /* 6D0A8 8007C8A8 21B02002 */   addu      $s6, $s1, $zero
    /* 6D0AC 8007C8AC EA9D030C */  jal        random
    /* 6D0B0 8007C8B0 00000000 */   nop
    /* 6D0B4 8007C8B4 17008392 */  lbu        $v1, 0x17($s4)
    /* 6D0B8 8007C8B8 00000000 */  nop
    /* 6D0BC 8007C8BC 01006324 */  addiu      $v1, $v1, 0x1
    /* 6D0C0 8007C8C0 1B004300 */  divu       $zero, $v0, $v1
    /* 6D0C4 8007C8C4 02006014 */  bnez       $v1, .L8007C8D0
    /* 6D0C8 8007C8C8 00000000 */   nop
    /* 6D0CC 8007C8CC 0D000700 */  break      7
  .L8007C8D0:
    /* 6D0D0 8007C8D0 10180000 */  mfhi       $v1
    /* 6D0D4 8007C8D4 00000000 */  nop
    /* 6D0D8 8007C8D8 21800302 */  addu       $s0, $s0, $v1
  .L8007C8DC:
    /* 6D0DC 8007C8DC 0000428E */  lw         $v0, 0x0($s2)
    /* 6D0E0 8007C8E0 0E0050A6 */  sh         $s0, 0xE($s2)
    /* 6D0E4 8007C8E4 150056A0 */  sb         $s6, 0x15($v0)
  .L8007C8E8:
    /* 6D0E8 8007C8E8 DFFF4012 */  beqz       $s2, .L8007C868
    /* 6D0EC 8007C8EC 01003126 */   addiu     $s1, $s1, 0x1
  .L8007C8F0:
    /* 6D0F0 8007C8F0 3B004016 */  bnez       $s2, .L8007C9E0
    /* 6D0F4 8007C8F4 21A80000 */   addu      $s5, $zero, $zero
    /* 6D0F8 8007C8F8 2198A002 */  addu       $s3, $s5, $zero
    /* 6D0FC 8007C8FC 2180A002 */  addu       $s0, $s5, $zero
    /* 6D100 8007C900 FFFF1E24 */  addiu      $fp, $zero, -0x1
  .L8007C904:
    /* 6D104 8007C904 17004016 */  bnez       $s2, .L8007C964
    /* 6D108 8007C908 1000022A */   slti      $v0, $s0, 0x10
    /* 6D10C 8007C90C 15004010 */  beqz       $v0, .L8007C964
    /* 6D110 8007C910 00191000 */   sll       $v1, $s0, 4
    /* 6D114 8007C914 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6D118 8007C918 1180083C */  lui        $t0, %hi(AudioClc_gRenderView)
    /* 6D11C 8007C91C 21104300 */  addu       $v0, $v0, $v1
    /* 6D120 8007C920 0000448C */  lw         $a0, 0x0($v0)
    /* 6D124 8007C924 0E75020C */  jal        Math_Dist3D__FP8coorddefT0
    /* 6D128 8007C928 28E40525 */   addiu     $a1, $t0, %lo(AudioClc_gRenderView)
    /* 6D12C 8007C92C 0400448E */  lw         $a0, 0x4($s2)
    /* 6D130 8007C930 00000000 */  nop
    /* 6D134 8007C934 09009E10 */  beq        $a0, $fp, .L8007C95C
    /* 6D138 8007C938 21884000 */   addu      $s1, $v0, $zero
    /* 6D13C 8007C93C C59E030C */  jal        SNDover
    /* 6D140 8007C940 00000000 */   nop
    /* 6D144 8007C944 05004010 */  beqz       $v0, .L8007C95C
    /* 6D148 8007C948 2A107102 */   slt       $v0, $s3, $s1
    /* 6D14C 8007C94C 03004010 */  beqz       $v0, .L8007C95C
    /* 6D150 8007C950 00000000 */   nop
    /* 6D154 8007C954 21A80002 */  addu       $s5, $s0, $zero
    /* 6D158 8007C958 21982002 */  addu       $s3, $s1, $zero
  .L8007C95C:
    /* 6D15C 8007C95C 41F20108 */  j          .L8007C904
    /* 6D160 8007C960 01001026 */   addiu     $s0, $s0, 0x1
  .L8007C964:
    /* 6D164 8007C964 2A10F302 */  slt        $v0, $s7, $s3
    /* 6D168 8007C968 1B004010 */  beqz       $v0, .L8007C9D8
    /* 6D16C 8007C96C 00000000 */   nop
    /* 6D170 8007C970 21B0A002 */  addu       $s6, $s5, $zero
    /* 6D174 8007C974 0802838F */  lw         $v1, %gp_rel(AudioTrk_g)($gp)
    /* 6D178 8007C978 00111600 */  sll        $v0, $s6, 4
    /* 6D17C 8007C97C 21906200 */  addu       $s2, $v1, $v0
    /* 6D180 8007C980 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6D184 8007C984 000054AE */  sw         $s4, 0x0($s2)
    /* 6D188 8007C988 080042AE */  sw         $v0, 0x8($s2)
    /* 6D18C 8007C98C 17008292 */  lbu        $v0, 0x17($s4)
    /* 6D190 8007C990 16009092 */  lbu        $s0, 0x16($s4)
    /* 6D194 8007C994 0D004010 */  beqz       $v0, .L8007C9CC
    /* 6D198 8007C998 00000000 */   nop
    /* 6D19C 8007C99C EA9D030C */  jal        random
    /* 6D1A0 8007C9A0 00000000 */   nop
    /* 6D1A4 8007C9A4 17008392 */  lbu        $v1, 0x17($s4)
    /* 6D1A8 8007C9A8 00000000 */  nop
    /* 6D1AC 8007C9AC 01006324 */  addiu      $v1, $v1, 0x1
    /* 6D1B0 8007C9B0 1B004300 */  divu       $zero, $v0, $v1
    /* 6D1B4 8007C9B4 02006014 */  bnez       $v1, .L8007C9C0
    /* 6D1B8 8007C9B8 00000000 */   nop
    /* 6D1BC 8007C9BC 0D000700 */  break      7
  .L8007C9C0:
    /* 6D1C0 8007C9C0 10180000 */  mfhi       $v1
    /* 6D1C4 8007C9C4 00000000 */  nop
    /* 6D1C8 8007C9C8 21800302 */  addu       $s0, $s0, $v1
  .L8007C9CC:
    /* 6D1CC 8007C9CC 0000428E */  lw         $v0, 0x0($s2)
    /* 6D1D0 8007C9D0 0E0050A6 */  sh         $s0, 0xE($s2)
    /* 6D1D4 8007C9D4 150056A0 */  sb         $s6, 0x15($v0)
  .L8007C9D8:
    /* 6D1D8 8007C9D8 EE004012 */  beqz       $s2, .L8007CD94
    /* 6D1DC 8007C9DC 00000000 */   nop
  .L8007C9E0:
    /* 6D1E0 8007C9E0 0C004386 */  lh         $v1, 0xC($s2)
    /* 6D1E4 8007C9E4 0E008292 */  lbu        $v0, 0xE($s4)
    /* 6D1E8 8007C9E8 00000000 */  nop
    /* 6D1EC 8007C9EC 0B006210 */  beq        $v1, $v0, .L8007CA1C
    /* 6D1F0 8007C9F0 FFFF1024 */   addiu     $s0, $zero, -0x1
    /* 6D1F4 8007C9F4 0400428E */  lw         $v0, 0x4($s2)
    /* 6D1F8 8007C9F8 00000000 */  nop
    /* 6D1FC 8007C9FC 04005010 */  beq        $v0, $s0, .L8007CA10
    /* 6D200 8007CA00 00000000 */   nop
    /* 6D204 8007CA04 34E0010C */  jal        freeVoiceChannel__Fi
    /* 6D208 8007CA08 3700C426 */   addiu     $a0, $s6, 0x37
    /* 6D20C 8007CA0C 040050AE */  sw         $s0, 0x4($s2)
  .L8007CA10:
    /* 6D210 8007CA10 0E008292 */  lbu        $v0, 0xE($s4)
    /* 6D214 8007CA14 00000000 */  nop
    /* 6D218 8007CA18 0C0042A6 */  sh         $v0, 0xC($s2)
  .L8007CA1C:
    /* 6D21C 8007CA1C 0400448E */  lw         $a0, 0x4($s2)
    /* 6D220 8007CA20 FFFF1024 */  addiu      $s0, $zero, -0x1
    /* 6D224 8007CA24 21009010 */  beq        $a0, $s0, .L8007CAAC
    /* 6D228 8007CA28 21880000 */   addu      $s1, $zero, $zero
    /* 6D22C 8007CA2C C59E030C */  jal        SNDover
    /* 6D230 8007CA30 00000000 */   nop
    /* 6D234 8007CA34 1D004010 */  beqz       $v0, .L8007CAAC
    /* 6D238 8007CA38 00000000 */   nop
    /* 6D23C 8007CA3C 0E004286 */  lh         $v0, 0xE($s2)
    /* 6D240 8007CA40 00000000 */  nop
    /* 6D244 8007CA44 07004010 */  beqz       $v0, .L8007CA64
    /* 6D248 8007CA48 01000224 */   addiu     $v0, $zero, 0x1
    /* 6D24C 8007CA4C 0E004296 */  lhu        $v0, 0xE($s2)
    /* 6D250 8007CA50 01001124 */  addiu      $s1, $zero, 0x1
    /* 6D254 8007CA54 040050AE */  sw         $s0, 0x4($s2)
    /* 6D258 8007CA58 21105000 */  addu       $v0, $v0, $s0
    /* 6D25C 8007CA5C ABF20108 */  j          .L8007CAAC
    /* 6D260 8007CA60 0E0042A6 */   sh        $v0, 0xE($s2)
  .L8007CA64:
    /* 6D264 8007CA64 14008392 */  lbu        $v1, 0x14($s4)
    /* 6D268 8007CA68 00000000 */  nop
    /* 6D26C 8007CA6C 07006214 */  bne        $v1, $v0, .L8007CA8C
    /* 6D270 8007CA70 00000000 */   nop
    /* 6D274 8007CA74 10008286 */  lh         $v0, 0x10($s4)
    /* 6D278 8007CA78 00000000 */  nop
    /* 6D27C 8007CA7C 00140200 */  sll        $v0, $v0, 16
    /* 6D280 8007CA80 2A105700 */  slt        $v0, $v0, $s7
    /* 6D284 8007CA84 09004010 */  beqz       $v0, .L8007CAAC
    /* 6D288 8007CA88 00000000 */   nop
  .L8007CA8C:
    /* 6D28C 8007CA8C 34E0010C */  jal        freeVoiceChannel__Fi
    /* 6D290 8007CA90 3700C426 */   addiu     $a0, $s6, 0x37
    /* 6D294 8007CA94 0000438E */  lw         $v1, 0x0($s2)
    /* 6D298 8007CA98 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6D29C 8007CA9C 040050AE */  sw         $s0, 0x4($s2)
    /* 6D2A0 8007CAA0 0C0050A6 */  sh         $s0, 0xC($s2)
    /* 6D2A4 8007CAA4 150062A0 */  sb         $v0, 0x15($v1)
    /* 6D2A8 8007CAA8 000040AE */  sw         $zero, 0x0($s2)
  .L8007CAAC:
    /* 6D2AC 8007CAAC 0000428E */  lw         $v0, 0x0($s2)
    /* 6D2B0 8007CAB0 00000000 */  nop
    /* 6D2B4 8007CAB4 B7004010 */  beqz       $v0, .L8007CD94
    /* 6D2B8 8007CAB8 21A80000 */   addu      $s5, $zero, $zero
    /* 6D2BC 8007CABC 0100133C */  lui        $s3, (0x10000 >> 16)
    /* 6D2C0 8007CAC0 14008392 */  lbu        $v1, 0x14($s4)
    /* 6D2C4 8007CAC4 01000224 */  addiu      $v0, $zero, 0x1
    /* 6D2C8 8007CAC8 31006214 */  bne        $v1, $v0, .L8007CB90
    /* 6D2CC 8007CACC 2180A002 */   addu      $s0, $s5, $zero
    /* 6D2D0 8007CAD0 2F002016 */  bnez       $s1, .L8007CB90
    /* 6D2D4 8007CAD4 FFFF1124 */   addiu     $s1, $zero, -0x1
    /* 6D2D8 8007CAD8 0400448E */  lw         $a0, 0x4($s2)
    /* 6D2DC 8007CADC 00000000 */  nop
    /* 6D2E0 8007CAE0 05009110 */  beq        $a0, $s1, .L8007CAF8
    /* 6D2E4 8007CAE4 00000000 */   nop
    /* 6D2E8 8007CAE8 C59E030C */  jal        SNDover
    /* 6D2EC 8007CAEC 00000000 */   nop
    /* 6D2F0 8007CAF0 A8004014 */  bnez       $v0, .L8007CD94
    /* 6D2F4 8007CAF4 00000000 */   nop
  .L8007CAF8:
    /* 6D2F8 8007CAF8 0F008292 */  lbu        $v0, 0xF($s4)
    /* 6D2FC 8007CAFC 00000000 */  nop
    /* 6D300 8007CB00 00140200 */  sll        $v0, $v0, 16
    /* 6D304 8007CB04 2A10E202 */  slt        $v0, $s7, $v0
    /* 6D308 8007CB08 10004010 */  beqz       $v0, .L8007CB4C
    /* 6D30C 8007CB0C 00000000 */   nop
    /* 6D310 8007CB10 0800428E */  lw         $v0, 0x8($s2)
    /* 6D314 8007CB14 00000000 */  nop
    /* 6D318 8007CB18 0C005114 */  bne        $v0, $s1, .L8007CB4C
    /* 6D31C 8007CB1C 00000000 */   nop
    /* 6D320 8007CB20 D800A88F */  lw         $t0, 0xD8($sp)
    /* 6D324 8007CB24 00000000 */  nop
    /* 6D328 8007CB28 08000485 */  lh         $a0, 0x8($t0)
    /* 6D32C 8007CB2C 59FB010C */  jal        BWorldSm_SetSlice__FiP12BWorldSm_Pos
    /* 6D330 8007CB30 1800A527 */   addiu     $a1, $sp, 0x18
    /* 6D334 8007CB34 21208002 */  addu       $a0, $s4, $zero
    /* 6D338 8007CB38 85FA010C */  jal        BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
    /* 6D33C 8007CB3C 1800A527 */   addiu     $a1, $sp, 0x18
    /* 6D340 8007CB40 1800A287 */  lh         $v0, 0x18($sp)
    /* 6D344 8007CB44 00000000 */  nop
    /* 6D348 8007CB48 080042AE */  sw         $v0, 0x8($s2)
  .L8007CB4C:
    /* 6D34C 8007CB4C D800A88F */  lw         $t0, 0xD8($sp)
    /* 6D350 8007CB50 0800428E */  lw         $v0, 0x8($s2)
    /* 6D354 8007CB54 08000385 */  lh         $v1, 0x8($t0)
    /* 6D358 8007CB58 00000000 */  nop
    /* 6D35C 8007CB5C 07006214 */  bne        $v1, $v0, .L8007CB7C
    /* 6D360 8007CB60 21200000 */   addu      $a0, $zero, $zero
    /* 6D364 8007CB64 0F008292 */  lbu        $v0, 0xF($s4)
    /* 6D368 8007CB68 00000000 */  nop
    /* 6D36C 8007CB6C 00140200 */  sll        $v0, $v0, 16
    /* 6D370 8007CB70 2A105700 */  slt        $v0, $v0, $s7
    /* 6D374 8007CB74 06004010 */  beqz       $v0, .L8007CB90
    /* 6D378 8007CB78 00000000 */   nop
  .L8007CB7C:
    /* 6D37C 8007CB7C 0C004586 */  lh         $a1, 0xC($s2)
    /* 6D380 8007CB80 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 6D384 8007CB84 21308000 */   addu      $a2, $a0, $zero
    /* 6D388 8007CB88 65F30108 */  j          .L8007CD94
    /* 6D38C 8007CB8C 00000000 */   nop
  .L8007CB90:
    /* 6D390 8007CB90 10008286 */  lh         $v0, 0x10($s4)
    /* 6D394 8007CB94 00000000 */  nop
    /* 6D398 8007CB98 00140200 */  sll        $v0, $v0, 16
    /* 6D39C 8007CB9C 2A10E202 */  slt        $v0, $s7, $v0
    /* 6D3A0 8007CBA0 62004010 */  beqz       $v0, .L8007CD2C
    /* 6D3A4 8007CBA4 03000224 */   addiu     $v0, $zero, 0x3
    /* 6D3A8 8007CBA8 14008392 */  lbu        $v1, 0x14($s4)
    /* 6D3AC 8007CBAC 00000000 */  nop
    /* 6D3B0 8007CBB0 04006214 */  bne        $v1, $v0, .L8007CBC4
    /* 6D3B4 8007CBB4 02000224 */   addiu     $v0, $zero, 0x2
    /* 6D3B8 8007CBB8 DC00A28F */  lw         $v0, 0xDC($sp)
    /* 6D3BC 8007CBBC FCF20108 */  j          .L8007CBF0
    /* 6D3C0 8007CBC0 21A8A202 */   addu      $s5, $s5, $v0
  .L8007CBC4:
    /* 6D3C4 8007CBC4 0A006210 */  beq        $v1, $v0, .L8007CBF0
    /* 6D3C8 8007CBC8 00000000 */   nop
    /* 6D3CC 8007CBCC 1180043C */  lui        $a0, %hi(AudioClc_gRenderView)
    /* 6D3D0 8007CBD0 28E48424 */  addiu      $a0, $a0, %lo(AudioClc_gRenderView)
    /* 6D3D4 8007CBD4 FAD2010C */  jal        AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef
    /* 6D3D8 8007CBD8 21288002 */   addu      $a1, $s4, $zero
    /* 6D3DC 8007CBDC 21A84000 */  addu       $s5, $v0, $zero
    /* 6D3E0 8007CBE0 D000A58F */  lw         $a1, 0xD0($sp)
    /* 6D3E4 8007CBE4 65D2010C */  jal        AudioClc_CalcDopplerShiftRatio__FP8coorddefT0
    /* 6D3E8 8007CBE8 21208002 */   addu      $a0, $s4, $zero
    /* 6D3EC 8007CBEC 21984000 */  addu       $s3, $v0, $zero
  .L8007CBF0:
    /* 6D3F0 8007CBF0 14008392 */  lbu        $v1, 0x14($s4)
    /* 6D3F4 8007CBF4 00000000 */  nop
    /* 6D3F8 8007CBF8 FCFF6224 */  addiu      $v0, $v1, -0x4
    /* 6D3FC 8007CBFC 2000422C */  sltiu      $v0, $v0, 0x20
    /* 6D400 8007CC00 03004014 */  bnez       $v0, .L8007CC10
    /* 6D404 8007CC04 01000224 */   addiu     $v0, $zero, 0x1
    /* 6D408 8007CC08 22006214 */  bne        $v1, $v0, .L8007CC94
    /* 6D40C 8007CC0C 00000000 */   nop
  .L8007CC10:
    /* 6D410 8007CC10 10009086 */  lh         $s0, 0x10($s4)
    /* 6D414 8007CC14 00000000 */  nop
    /* 6D418 8007CC18 18001002 */  mult       $s0, $s0
    /* 6D41C 8007CC1C 83201700 */  sra        $a0, $s7, 2
    /* 6D420 8007CC20 12800000 */  mflo       $s0
    /* 6D424 8007CC24 CA90030C */  jal        fixedmult
    /* 6D428 8007CC28 21288000 */   addu      $a1, $a0, $zero
    /* 6D42C 8007CC2C 03191000 */  sra        $v1, $s0, 4
    /* 6D430 8007CC30 001C0300 */  sll        $v1, $v1, 16
    /* 6D434 8007CC34 23186200 */  subu       $v1, $v1, $v0
    /* 6D438 8007CC38 1A007000 */  div        $zero, $v1, $s0
    /* 6D43C 8007CC3C 02000016 */  bnez       $s0, .L8007CC48
    /* 6D440 8007CC40 00000000 */   nop
    /* 6D444 8007CC44 0D000700 */  break      7
  .L8007CC48:
    /* 6D448 8007CC48 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6D44C 8007CC4C 04000116 */  bne        $s0, $at, .L8007CC60
    /* 6D450 8007CC50 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6D454 8007CC54 02006114 */  bne        $v1, $at, .L8007CC60
    /* 6D458 8007CC58 00000000 */   nop
    /* 6D45C 8007CC5C 0D000600 */  break      6
  .L8007CC60:
    /* 6D460 8007CC60 12180000 */  mflo       $v1
    /* 6D464 8007CC64 D400A88F */  lw         $t0, 0xD4($sp)
    /* 6D468 8007CC68 00000000 */  nop
    /* 6D46C 8007CC6C C0110800 */  sll        $v0, $t0, 7
    /* 6D470 8007CC70 23104800 */  subu       $v0, $v0, $t0
    /* 6D474 8007CC74 18006200 */  mult       $v1, $v0
    /* 6D478 8007CC78 12180000 */  mflo       $v1
    /* 6D47C 8007CC7C 2B006104 */  bgez       $v1, .L8007CD2C
    /* 6D480 8007CC80 C2840300 */   srl       $s0, $v1, 19
    /* 6D484 8007CC84 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 6D488 8007CC88 21186200 */  addu       $v1, $v1, $v0
    /* 6D48C 8007CC8C 4BF30108 */  j          .L8007CD2C
    /* 6D490 8007CC90 C2840300 */   srl       $s0, $v1, 19
  .L8007CC94:
    /* 6D494 8007CC94 0F008392 */  lbu        $v1, 0xF($s4)
    /* 6D498 8007CC98 00000000 */  nop
    /* 6D49C 8007CC9C 00240300 */  sll        $a0, $v1, 16
    /* 6D4A0 8007CCA0 2A10E402 */  slt        $v0, $s7, $a0
    /* 6D4A4 8007CCA4 21004014 */  bnez       $v0, .L8007CD2C
    /* 6D4A8 8007CCA8 7F001024 */   addiu     $s0, $zero, 0x7F
    /* 6D4AC 8007CCAC 10009086 */  lh         $s0, 0x10($s4)
    /* 6D4B0 8007CCB0 00000000 */  nop
    /* 6D4B4 8007CCB4 23800302 */  subu       $s0, $s0, $v1
    /* 6D4B8 8007CCB8 18001002 */  mult       $s0, $s0
    /* 6D4BC 8007CCBC 2320E402 */  subu       $a0, $s7, $a0
    /* 6D4C0 8007CCC0 83200400 */  sra        $a0, $a0, 2
    /* 6D4C4 8007CCC4 12800000 */  mflo       $s0
    /* 6D4C8 8007CCC8 CA90030C */  jal        fixedmult
    /* 6D4CC 8007CCCC 21288000 */   addu      $a1, $a0, $zero
    /* 6D4D0 8007CCD0 03191000 */  sra        $v1, $s0, 4
    /* 6D4D4 8007CCD4 001C0300 */  sll        $v1, $v1, 16
    /* 6D4D8 8007CCD8 23186200 */  subu       $v1, $v1, $v0
    /* 6D4DC 8007CCDC 1A007000 */  div        $zero, $v1, $s0
    /* 6D4E0 8007CCE0 02000016 */  bnez       $s0, .L8007CCEC
    /* 6D4E4 8007CCE4 00000000 */   nop
    /* 6D4E8 8007CCE8 0D000700 */  break      7
  .L8007CCEC:
    /* 6D4EC 8007CCEC FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6D4F0 8007CCF0 04000116 */  bne        $s0, $at, .L8007CD04
    /* 6D4F4 8007CCF4 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6D4F8 8007CCF8 02006114 */  bne        $v1, $at, .L8007CD04
    /* 6D4FC 8007CCFC 00000000 */   nop
    /* 6D500 8007CD00 0D000600 */  break      6
  .L8007CD04:
    /* 6D504 8007CD04 12180000 */  mflo       $v1
    /* 6D508 8007CD08 00000000 */  nop
    /* 6D50C 8007CD0C C0110300 */  sll        $v0, $v1, 7
    /* 6D510 8007CD10 23104300 */  subu       $v0, $v0, $v1
    /* 6D514 8007CD14 00190200 */  sll        $v1, $v0, 4
    /* 6D518 8007CD18 04006104 */  bgez       $v1, .L8007CD2C
    /* 6D51C 8007CD1C 02840300 */   srl       $s0, $v1, 16
    /* 6D520 8007CD20 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 6D524 8007CD24 21186200 */  addu       $v1, $v1, $v0
    /* 6D528 8007CD28 02840300 */  srl        $s0, $v1, 16
  .L8007CD2C:
    /* 6D52C 8007CD2C 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* 6D530 8007CD30 2A205300 */  slt        $a0, $v0, $s3
    /* 6D534 8007CD34 02008010 */  beqz       $a0, .L8007CD40
    /* 6D538 8007CD38 21186002 */   addu      $v1, $s3, $zero
    /* 6D53C 8007CD3C 21184000 */  addu       $v1, $v0, $zero
  .L8007CD40:
    /* 6D540 8007CD40 02008010 */  beqz       $a0, .L8007CD4C
    /* 6D544 8007CD44 21106002 */   addu      $v0, $s3, $zero
    /* 6D548 8007CD48 0A00023C */  lui        $v0, (0xA0000 >> 16)
  .L8007CD4C:
    /* 6D54C 8007CD4C 0300401C */  bgtz       $v0, .L8007CD5C
    /* 6D550 8007CD50 21986000 */   addu      $s3, $v1, $zero
    /* 6D554 8007CD54 01000324 */  addiu      $v1, $zero, 0x1
    /* 6D558 8007CD58 21986000 */  addu       $s3, $v1, $zero
  .L8007CD5C:
    /* 6D55C 8007CD5C 6B90030C */  jal        PAD_state
    /* 6D560 8007CD60 04000424 */   addiu     $a0, $zero, 0x4
    /* 6D564 8007CD64 00044230 */  andi       $v0, $v0, 0x400
    /* 6D568 8007CD68 0A004014 */  bnez       $v0, .L8007CD94
    /* 6D56C 8007CD6C 3700C426 */   addiu     $a0, $s6, 0x37
    /* 6D570 8007CD70 40000624 */  addiu      $a2, $zero, 0x40
    /* 6D574 8007CD74 0C004586 */  lh         $a1, 0xC($s2)
    /* 6D578 8007CD78 FF000232 */  andi       $v0, $s0, 0xFF
    /* 6D57C 8007CD7C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 6D580 8007CD80 FFFFA232 */  andi       $v0, $s5, 0xFFFF
    /* 6D584 8007CD84 21386002 */  addu       $a3, $s3, $zero
    /* 6D588 8007CD88 F3E0010C */  jal        AudioCmn_PlaySFX__Fiiiiii
    /* 6D58C 8007CD8C 1400A2AF */   sw        $v0, 0x14($sp)
    /* 6D590 8007CD90 040042AE */  sw         $v0, 0x4($s2)
  .L8007CD94:
    /* 6D594 8007CD94 C400BF8F */  lw         $ra, 0xC4($sp)
    /* 6D598 8007CD98 C000BE8F */  lw         $fp, 0xC0($sp)
    /* 6D59C 8007CD9C BC00B78F */  lw         $s7, 0xBC($sp)
    /* 6D5A0 8007CDA0 B800B68F */  lw         $s6, 0xB8($sp)
    /* 6D5A4 8007CDA4 B400B58F */  lw         $s5, 0xB4($sp)
    /* 6D5A8 8007CDA8 B000B48F */  lw         $s4, 0xB0($sp)
    /* 6D5AC 8007CDAC AC00B38F */  lw         $s3, 0xAC($sp)
    /* 6D5B0 8007CDB0 A800B28F */  lw         $s2, 0xA8($sp)
    /* 6D5B4 8007CDB4 A400B18F */  lw         $s1, 0xA4($sp)
    /* 6D5B8 8007CDB8 A000B08F */  lw         $s0, 0xA0($sp)
    /* 6D5BC 8007CDBC 0800E003 */  jr         $ra
    /* 6D5C0 8007CDC0 C800BD27 */   addiu     $sp, $sp, 0xC8
endlabel AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji
