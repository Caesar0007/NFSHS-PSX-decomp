.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_OnyxBuildFacets__FP13DRender_tView, 0x304

glabel BWorld_OnyxBuildFacets__FP13DRender_tView
    /* 6E8F4 8007E0F4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 6E8F8 8007E0F8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 6E8FC 8007E0FC 21988000 */  addu       $s3, $a0, $zero
    /* 6E900 8007E100 2400BFAF */  sw         $ra, 0x24($sp)
    /* 6E904 8007E104 2000B4AF */  sw         $s4, 0x20($sp)
    /* 6E908 8007E108 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6E90C 8007E10C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6E910 8007E110 482E020C */  jal        Chunk_UpdateSys__FP13DRender_tView
    /* 6E914 8007E114 1000B0AF */   sw        $s0, 0x10($sp)
    /* 6E918 8007E118 801F043C */  lui        $a0, (0x1F8003FC >> 16)
    /* 6E91C 8007E11C 6C0293AF */  sw         $s3, %gp_rel(gVi2)($gp)
    /* 6E920 8007E120 2B91030C */  jal        SetSp
    /* 6E924 8007E124 FC038434 */   ori       $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* 6E928 8007E128 6C02848F */  lw         $a0, %gp_rel(gVi2)($gp)
    /* 6E92C 8007E12C 01001424 */  addiu      $s4, $zero, 0x1
    /* 6E930 8007E130 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 6E934 8007E134 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 6E938 8007E138 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 6E93C 8007E13C 1CD834AC */  sw         $s4, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 6E940 8007E140 50F6010C */  jal        SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache
    /* 6E944 8007E144 801F053C */   lui       $a1, (0x1F800000 >> 16)
    /* 6E948 8007E148 1180043C */  lui        $a0, %hi(gWorldMat)
    /* 6E94C 8007E14C 40EE8424 */  addiu      $a0, $a0, %lo(gWorldMat)
    /* 6E950 8007E150 801F053C */  lui        $a1, (0x1F800014 >> 16)
    /* 6E954 8007E154 4F1D030C */  jal        DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
    /* 6E958 8007E158 1400A534 */   ori       $a1, $a1, (0x1F800014 & 0xFFFF)
    /* 6E95C 8007E15C 6C02848F */  lw         $a0, %gp_rel(gVi2)($gp)
    /* 6E960 8007E160 5DF7010C */  jal        SetupChunkBuildList__FP13DRender_tView
    /* 6E964 8007E164 801F123C */   lui       $s2, (0x1F80010D >> 16)
    /* 6E968 8007E168 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 6E96C 8007E16C 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 6E970 8007E170 5C0282AF */  sw         $v0, %gp_rel(BWorld_gChunkCount)($gp)
    /* 6E974 8007E174 2B91030C */  jal        SetSp
    /* 6E978 8007E178 00000000 */   nop
    /* 6E97C 8007E17C 1280043C */  lui        $a0, %hi(TrackSpec_gSpec)
    /* 6E980 8007E180 7C328324 */  addiu      $v1, $a0, %lo(TrackSpec_gSpec)
    /* 6E984 8007E184 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 6E988 8007E188 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 6E98C 8007E18C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 6E990 8007E190 EC315024 */  addiu      $s0, $v0, %lo(GameSetup_gData)
    /* 6E994 8007E194 18006294 */  lhu        $v0, 0x18($v1)
    /* 6E998 8007E198 1C006394 */  lhu        $v1, 0x1C($v1)
    /* 6E99C 8007E19C 7C328490 */  lbu        $a0, %lo(TrackSpec_gSpec)($a0)
    /* 6E9A0 8007E1A0 5400058E */  lw         $a1, 0x54($s0)
    /* 6E9A4 8007E1A4 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 6E9A8 8007E1A8 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 6E9AC 8007E1AC DC0042A6 */  sh         $v0, (0x1F8000DC & 0xFFFF)($s2)
    /* 6E9B0 8007E1B0 DE0043A6 */  sh         $v1, (0x1F8000DE & 0xFFFF)($s2)
    /* 6E9B4 8007E1B4 1000A010 */  beqz       $a1, .L8007E1F8
    /* 6E9B8 8007E1B8 0E0144A2 */   sb        $a0, (0x1F80010E & 0xFFFF)($s2)
    /* 6E9BC 8007E1BC 1480023C */  lui        $v0, %hi(Night_gZNear)
    /* 6E9C0 8007E1C0 30DA4294 */  lhu        $v0, %lo(Night_gZNear)($v0)
    /* 6E9C4 8007E1C4 1480033C */  lui        $v1, %hi(Night_gXDistShift)
    /* 6E9C8 8007E1C8 38DA6390 */  lbu        $v1, %lo(Night_gXDistShift)($v1)
    /* 6E9CC 8007E1CC 1480043C */  lui        $a0, %hi(Night_gZDistShift)
    /* 6E9D0 8007E1D0 3CDA8490 */  lbu        $a0, %lo(Night_gZDistShift)($a0)
    /* 6E9D4 8007E1D4 1480053C */  lui        $a1, %hi(Night_gDrawLightning)
    /* 6E9D8 8007E1D8 E0D9A590 */  lbu        $a1, %lo(Night_gDrawLightning)($a1)
    /* 6E9DC 8007E1DC 1480063C */  lui        $a2, %hi(Night_gLightningType)
    /* 6E9E0 8007E1E0 44DAC690 */  lbu        $a2, %lo(Night_gLightningType)($a2)
    /* 6E9E4 8007E1E4 080142A6 */  sh         $v0, (0x1F800108 & 0xFFFF)($s2)
    /* 6E9E8 8007E1E8 0A0143A2 */  sb         $v1, (0x1F80010A & 0xFFFF)($s2)
    /* 6E9EC 8007E1EC 0B0144A2 */  sb         $a0, (0x1F80010B & 0xFFFF)($s2)
    /* 6E9F0 8007E1F0 0C0145A2 */  sb         $a1, (0x1F80010C & 0xFFFF)($s2)
    /* 6E9F4 8007E1F4 0D0146A2 */  sb         $a2, (0x1F80010D & 0xFFFF)($s2)
  .L8007E1F8:
    /* 6E9F8 8007E1F8 801F043C */  lui        $a0, (0x1F8003FC >> 16)
    /* 6E9FC 8007E1FC 2B91030C */  jal        SetSp
    /* 6EA00 8007E200 FC038434 */   ori       $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* 6EA04 8007E204 21206002 */  addu       $a0, $s3, $zero
    /* 6EA08 8007E208 1180033C */  lui        $v1, %hi(BWorld_gChunkBuildList)
    /* 6EA0C 8007E20C ECEF7124 */  addiu      $s1, $v1, %lo(BWorld_gChunkBuildList)
    /* 6EA10 8007E210 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 6EA14 8007E214 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 6EA18 8007E218 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 6EA1C 8007E21C 1CD834AC */  sw         $s4, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 6EA20 8007E220 E81B030C */  jal        DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry
    /* 6EA24 8007E224 21282002 */   addu      $a1, $s1, $zero
    /* 6EA28 8007E228 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 6EA2C 8007E22C 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 6EA30 8007E230 2B91030C */  jal        SetSp
    /* 6EA34 8007E234 00000000 */   nop
    /* 6EA38 8007E238 3C00038E */  lw         $v1, 0x3C($s0)
    /* 6EA3C 8007E23C 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 6EA40 8007E240 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 6EA44 8007E244 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 6EA48 8007E248 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 6EA4C 8007E24C 05006014 */  bnez       $v1, .L8007E264
    /* 6EA50 8007E250 801F043C */   lui       $a0, (0x1F8003FC >> 16)
    /* 6EA54 8007E254 4800028E */  lw         $v0, 0x48($s0)
    /* 6EA58 8007E258 00000000 */  nop
    /* 6EA5C 8007E25C 13005410 */  beq        $v0, $s4, .L8007E2AC
    /* 6EA60 8007E260 00000000 */   nop
  .L8007E264:
    /* 6EA64 8007E264 2B91030C */  jal        SetSp
    /* 6EA68 8007E268 FC038434 */   ori       $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* 6EA6C 8007E26C 21206002 */  addu       $a0, $s3, $zero
    /* 6EA70 8007E270 21282002 */  addu       $a1, $s1, $zero
    /* 6EA74 8007E274 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 6EA78 8007E278 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 6EA7C 8007E27C 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 6EA80 8007E280 1CD834AC */  sw         $s4, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 6EA84 8007E284 8128030C */  jal        DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache
    /* 6EA88 8007E288 801F063C */   lui       $a2, (0x1F800000 >> 16)
    /* 6EA8C 8007E28C 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 6EA90 8007E290 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 6EA94 8007E294 2B91030C */  jal        SetSp
    /* 6EA98 8007E298 00000000 */   nop
    /* 6EA9C 8007E29C 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 6EAA0 8007E2A0 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 6EAA4 8007E2A4 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 6EAA8 8007E2A8 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
  .L8007E2AC:
    /* 6EAAC 8007E2AC 4802828F */  lw         $v0, %gp_rel(gSpikeBelt)($gp)
    /* 6EAB0 8007E2B0 00000000 */  nop
    /* 6EAB4 8007E2B4 15004010 */  beqz       $v0, .L8007E30C
    /* 6EAB8 8007E2B8 1180023C */   lui       $v0, %hi(D_801131F8)
    /* 6EABC 8007E2BC 5C02828F */  lw         $v0, %gp_rel(BWorld_gChunkCount)($gp)
    /* 6EAC0 8007E2C0 00000000 */  nop
    /* 6EAC4 8007E2C4 10004018 */  blez       $v0, .L8007E308
    /* 6EAC8 8007E2C8 21800000 */   addu      $s0, $zero, $zero
    /* 6EACC 8007E2CC 1180023C */  lui        $v0, %hi(BWorld_gChunkBuildList)
    /* 6EAD0 8007E2D0 ECEF5124 */  addiu      $s1, $v0, %lo(BWorld_gChunkBuildList)
  .L8007E2D4:
    /* 6EAD4 8007E2D4 00002386 */  lh         $v1, 0x0($s1)
    /* 6EAD8 8007E2D8 5002828F */  lw         $v0, %gp_rel(gSpikeBeltChunk)($gp)
    /* 6EADC 8007E2DC 00000000 */  nop
    /* 6EAE0 8007E2E0 04006214 */  bne        $v1, $v0, .L8007E2F4
    /* 6EAE4 8007E2E4 21206002 */   addu      $a0, $s3, $zero
    /* 6EAE8 8007E2E8 6002858F */  lw         $a1, %gp_rel(gSpikeBeltWidth)($gp)
    /* 6EAEC 8007E2EC 4829030C */  jal        DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache
    /* 6EAF0 8007E2F0 21304002 */   addu      $a2, $s2, $zero
  .L8007E2F4:
    /* 6EAF4 8007E2F4 5C02828F */  lw         $v0, %gp_rel(BWorld_gChunkCount)($gp)
    /* 6EAF8 8007E2F8 01001026 */  addiu      $s0, $s0, 0x1
    /* 6EAFC 8007E2FC 2A100202 */  slt        $v0, $s0, $v0
    /* 6EB00 8007E300 F4FF4014 */  bnez       $v0, .L8007E2D4
    /* 6EB04 8007E304 04003126 */   addiu     $s1, $s1, 0x4
  .L8007E308:
    /* 6EB08 8007E308 1180023C */  lui        $v0, %hi(D_801131F8)
  .L8007E30C:
    /* 6EB0C 8007E30C F831428C */  lw         $v0, %lo(D_801131F8)($v0)
    /* 6EB10 8007E310 00000000 */  nop
    /* 6EB14 8007E314 19004014 */  bnez       $v0, .L8007E37C
    /* 6EB18 8007E318 21880000 */   addu      $s1, $zero, $zero
    /* 6EB1C 8007E31C 1180023C */  lui        $v0, %hi(BWorld_gChunkBuildList)
    /* 6EB20 8007E320 ECEF5024 */  addiu      $s0, $v0, %lo(BWorld_gChunkBuildList)
  .L8007E324:
    /* 6EB24 8007E324 5C02828F */  lw         $v0, %gp_rel(BWorld_gChunkCount)($gp)
    /* 6EB28 8007E328 00000000 */  nop
    /* 6EB2C 8007E32C 2A102202 */  slt        $v0, $s1, $v0
    /* 6EB30 8007E330 12004010 */  beqz       $v0, .L8007E37C
    /* 6EB34 8007E334 00000000 */   nop
    /* 6EB38 8007E338 00000286 */  lh         $v0, 0x0($s0)
    /* 6EB3C 8007E33C 00000000 */  nop
    /* 6EB40 8007E340 C0180200 */  sll        $v1, $v0, 3
    /* 6EB44 8007E344 23186200 */  subu       $v1, $v1, $v0
    /* 6EB48 8007E348 1480023C */  lui        $v0, %hi(Track_chunkList)
    /* 6EB4C 8007E34C B8D4428C */  lw         $v0, %lo(Track_chunkList)($v0)
    /* 6EB50 8007E350 00190300 */  sll        $v1, $v1, 4
    /* 6EB54 8007E354 21104300 */  addu       $v0, $v0, $v1
    /* 6EB58 8007E358 5400468C */  lw         $a2, 0x54($v0)
    /* 6EB5C 8007E35C 00000000 */  nop
    /* 6EB60 8007E360 0300C010 */  beqz       $a2, .L8007E370
    /* 6EB64 8007E364 21206002 */   addu      $a0, $s3, $zero
    /* 6EB68 8007E368 B0F5010C */  jal        BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group
    /* 6EB6C 8007E36C 21284002 */   addu      $a1, $s2, $zero
  .L8007E370:
    /* 6EB70 8007E370 04001026 */  addiu      $s0, $s0, 0x4
    /* 6EB74 8007E374 C9F80108 */  j          .L8007E324
    /* 6EB78 8007E378 01003126 */   addiu     $s1, $s1, 0x1
  .L8007E37C:
    /* 6EB7C 8007E37C 1480023C */  lui        $v0, %hi(Object_customSFXInst)
    /* 6EB80 8007E380 D0D2428C */  lw         $v0, %lo(Object_customSFXInst)($v0)
    /* 6EB84 8007E384 00000000 */  nop
    /* 6EB88 8007E388 0C004010 */  beqz       $v0, .L8007E3BC
    /* 6EB8C 8007E38C 1180043C */   lui       $a0, %hi(gWorldMat)
    /* 6EB90 8007E390 1480043C */  lui        $a0, %hi(Object_customSliceNum)
    /* 6EB94 8007E394 D4D2848C */  lw         $a0, %lo(Object_customSliceNum)($a0)
    /* 6EB98 8007E398 28F8010C */  jal        BWorld_IsSliceInBuildList__Fi
    /* 6EB9C 8007E39C 00000000 */   nop
    /* 6EBA0 8007E3A0 05004010 */  beqz       $v0, .L8007E3B8
    /* 6EBA4 8007E3A4 21206002 */   addu      $a0, $s3, $zero
    /* 6EBA8 8007E3A8 1480063C */  lui        $a2, %hi(Object_customSFXInst)
    /* 6EBAC 8007E3AC D0D2C68C */  lw         $a2, %lo(Object_customSFXInst)($a2)
    /* 6EBB0 8007E3B0 B0F5010C */  jal        BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group
    /* 6EBB4 8007E3B4 21284002 */   addu      $a1, $s2, $zero
  .L8007E3B8:
    /* 6EBB8 8007E3B8 1180043C */  lui        $a0, %hi(gWorldMat)
  .L8007E3BC:
    /* 6EBBC 8007E3BC 40EE8424 */  addiu      $a0, $a0, %lo(gWorldMat)
    /* 6EBC0 8007E3C0 4F1D030C */  jal        DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
    /* 6EBC4 8007E3C4 14004536 */   ori       $a1, $s2, (0x1F800014 & 0xFFFF)
    /* 6EBC8 8007E3C8 21206002 */  addu       $a0, $s3, $zero
    /* 6EBCC 8007E3CC 1180053C */  lui        $a1, %hi(BWorld_gChunkBuildList)
    /* 6EBD0 8007E3D0 3123030C */  jal        DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry
    /* 6EBD4 8007E3D4 ECEFA524 */   addiu     $a1, $a1, %lo(BWorld_gChunkBuildList)
    /* 6EBD8 8007E3D8 2400BF8F */  lw         $ra, 0x24($sp)
    /* 6EBDC 8007E3DC 2000B48F */  lw         $s4, 0x20($sp)
    /* 6EBE0 8007E3E0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 6EBE4 8007E3E4 1800B28F */  lw         $s2, 0x18($sp)
    /* 6EBE8 8007E3E8 1400B18F */  lw         $s1, 0x14($sp)
    /* 6EBEC 8007E3EC 1000B08F */  lw         $s0, 0x10($sp)
    /* 6EBF0 8007E3F0 0800E003 */  jr         $ra
    /* 6EBF4 8007E3F4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel BWorld_OnyxBuildFacets__FP13DRender_tView
