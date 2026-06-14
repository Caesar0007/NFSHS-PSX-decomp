.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckSpikeBelt__15AIHigh_BasicCop, 0xC8

glabel CheckSpikeBelt__15AIHigh_BasicCop
    /* 4C9EC 8005C1EC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4C9F0 8005C1F0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4C9F4 8005C1F4 1180113C */  lui        $s1, %hi(AICop_spikeBelt)
    /* 4C9F8 8005C1F8 4CD5228E */  lw         $v0, %lo(AICop_spikeBelt)($s1)
    /* 4C9FC 8005C1FC 21180000 */  addu       $v1, $zero, $zero
    /* 4CA00 8005C200 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4CA04 8005C204 4CD53026 */  addiu      $s0, $s1, %lo(AICop_spikeBelt)
    /* 4CA08 8005C208 08004010 */  beqz       $v0, .L8005C22C
    /* 4CA0C 8005C20C 1800BFAF */   sw        $ra, 0x18($sp)
    /* 4CA10 8005C210 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 4CA14 8005C214 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 4CA18 8005C218 1000038E */  lw         $v1, 0x10($s0)
    /* 4CA1C 8005C21C 00000000 */  nop
    /* 4CA20 8005C220 23104300 */  subu       $v0, $v0, $v1
    /* 4CA24 8005C224 40014228 */  slti       $v0, $v0, 0x140
    /* 4CA28 8005C228 0100432C */  sltiu      $v1, $v0, 0x1
  .L8005C22C:
    /* 4CA2C 8005C22C 0D006010 */  beqz       $v1, .L8005C264
    /* 4CA30 8005C230 00000000 */   nop
    /* 4CA34 8005C234 0400048E */  lw         $a0, 0x4($s0)
    /* 4CA38 8005C238 03A2010C */  jal        AILife_IsSliceInAnyVisibleArea__Fi
    /* 4CA3C 8005C23C 00000000 */   nop
    /* 4CA40 8005C240 05004014 */  bnez       $v0, .L8005C258
    /* 4CA44 8005C244 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 4CA48 8005C248 06F6010C */  jal        BWorld_InitSpikeBelt__Fv
    /* 4CA4C 8005C24C 00000000 */   nop
    /* 4CA50 8005C250 99700108 */  j          .L8005C264
    /* 4CA54 8005C254 4CD520AE */   sw        $zero, %lo(AICop_spikeBelt)($s1)
  .L8005C258:
    /* 4CA58 8005C258 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 4CA5C 8005C25C 00000000 */  nop
    /* 4CA60 8005C260 100002AE */  sw         $v0, 0x10($s0)
  .L8005C264:
    /* 4CA64 8005C264 1480033C */  lui        $v1, %hi(AICop_gRoadBlockState)
    /* 4CA68 8005C268 74C5638C */  lw         $v1, %lo(AICop_gRoadBlockState)($v1)
    /* 4CA6C 8005C26C 02000224 */  addiu      $v0, $zero, 0x2
    /* 4CA70 8005C270 0B006214 */  bne        $v1, $v0, .L8005C2A0
    /* 4CA74 8005C274 00000000 */   nop
    /* 4CA78 8005C278 1480043C */  lui        $a0, %hi(Object_customSliceNum)
    /* 4CA7C 8005C27C D4D2848C */  lw         $a0, %lo(Object_customSliceNum)($a0)
    /* 4CA80 8005C280 03A2010C */  jal        AILife_IsSliceInAnyVisibleArea__Fi
    /* 4CA84 8005C284 00000000 */   nop
    /* 4CA88 8005C288 05004014 */  bnez       $v0, .L8005C2A0
    /* 4CA8C 8005C28C 00000000 */   nop
    /* 4CA90 8005C290 9B95020C */  jal        Object_ClearCustomObjects__Fv
    /* 4CA94 8005C294 00000000 */   nop
    /* 4CA98 8005C298 1480013C */  lui        $at, %hi(AICop_gRoadBlockState)
    /* 4CA9C 8005C29C 74C520AC */  sw         $zero, %lo(AICop_gRoadBlockState)($at)
  .L8005C2A0:
    /* 4CAA0 8005C2A0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 4CAA4 8005C2A4 1400B18F */  lw         $s1, 0x14($sp)
    /* 4CAA8 8005C2A8 1000B08F */  lw         $s0, 0x10($sp)
    /* 4CAAC 8005C2AC 0800E003 */  jr         $ra
    /* 4CAB0 8005C2B0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CheckSpikeBelt__15AIHigh_BasicCop
