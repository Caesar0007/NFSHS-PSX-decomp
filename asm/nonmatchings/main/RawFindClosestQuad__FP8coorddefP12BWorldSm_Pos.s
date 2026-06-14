.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos, 0x7AC

glabel RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos
    /* 6F94C 8007F14C C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 6F950 8007F150 3800BEAF */  sw         $fp, 0x38($sp)
    /* 6F954 8007F154 21F08000 */  addu       $fp, $a0, $zero
    /* 6F958 8007F158 1800B0AF */  sw         $s0, 0x18($sp)
    /* 6F95C 8007F15C 2180A000 */  addu       $s0, $a1, $zero
    /* 6F960 8007F160 2400B3AF */  sw         $s3, 0x24($sp)
    /* 6F964 8007F164 21980000 */  addu       $s3, $zero, $zero
    /* 6F968 8007F168 21200002 */  addu       $a0, $s0, $zero
    /* 6F96C 8007F16C 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* 6F970 8007F170 3400B7AF */  sw         $s7, 0x34($sp)
    /* 6F974 8007F174 3000B6AF */  sw         $s6, 0x30($sp)
    /* 6F978 8007F178 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 6F97C 8007F17C 2800B4AF */  sw         $s4, 0x28($sp)
    /* 6F980 8007F180 2000B2AF */  sw         $s2, 0x20($sp)
    /* 6F984 8007F184 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 6F988 8007F188 780000AE */  sw         $zero, 0x78($s0)
    /* 6F98C 8007F18C 0DFC010C */  jal        BWorld_SetSimSlice__FP12BWorldSm_Pos
    /* 6F990 8007F190 040000A6 */   sh        $zero, 0x4($s0)
    /* 6F994 8007F194 74000382 */  lb         $v1, 0x74($s0)
    /* 6F998 8007F198 00000000 */  nop
    /* 6F99C 8007F19C 17006004 */  bltz       $v1, .L8007F1FC
    /* 6F9A0 8007F1A0 21B06002 */   addu      $s6, $s3, $zero
    /* 6F9A4 8007F1A4 8000028E */  lw         $v0, 0x80($s0)
    /* 6F9A8 8007F1A8 00000000 */  nop
    /* 6F9AC 8007F1AC 01004290 */  lbu        $v0, 0x1($v0)
    /* 6F9B0 8007F1B0 00000000 */  nop
    /* 6F9B4 8007F1B4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 6F9B8 8007F1B8 2A106200 */  slt        $v0, $v1, $v0
    /* 6F9BC 8007F1BC 0F004010 */  beqz       $v0, .L8007F1FC
    /* 6F9C0 8007F1C0 00000000 */   nop
    /* 6F9C4 8007F1C4 5A000282 */  lb         $v0, 0x5A($s0)
    /* 6F9C8 8007F1C8 00000000 */  nop
    /* 6F9CC 8007F1CC 0B004014 */  bnez       $v0, .L8007F1FC
    /* 6F9D0 8007F1D0 21A86000 */   addu      $s5, $v1, $zero
    /* 6F9D4 8007F1D4 8BFC0108 */  j          .L8007F22C
    /* 6F9D8 8007F1D8 21B80000 */   addu      $s7, $zero, $zero
  .L8007F1DC:
    /* 6F9DC 8007F1DC 21200002 */  addu       $a0, $s0, $zero
    /* 6F9E0 8007F1E0 21288002 */  addu       $a1, $s4, $zero
    /* 6F9E4 8007F1E4 02000224 */  addiu      $v0, $zero, 0x2
    /* 6F9E8 8007F1E8 770082A0 */  sb         $v0, 0x77($a0)
    /* 6F9EC 8007F1EC 6EFB010C */  jal        GetStmQuadPts__FP12BWorldSm_PosP8coorddef
    /* 6F9F0 8007F1F0 5A0080A0 */   sb        $zero, 0x5A($a0)
    /* 6F9F4 8007F1F4 32FE0108 */  j          .L8007F8C8
    /* 6F9F8 8007F1F8 01000224 */   addiu     $v0, $zero, 0x1
  .L8007F1FC:
    /* 6F9FC 8007F1FC 8000028E */  lw         $v0, 0x80($s0)
    /* 6FA00 8007F200 00000000 */  nop
    /* 6FA04 8007F204 01004290 */  lbu        $v0, 0x1($v0)
    /* 6FA08 8007F208 00000000 */  nop
    /* 6FA0C 8007F20C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 6FA10 8007F210 C21F0200 */  srl        $v1, $v0, 31
    /* 6FA14 8007F214 21104300 */  addu       $v0, $v0, $v1
    /* 6FA18 8007F218 43100200 */  sra        $v0, $v0, 1
    /* 6FA1C 8007F21C 001E0200 */  sll        $v1, $v0, 24
    /* 6FA20 8007F220 03AE0300 */  sra        $s5, $v1, 24
    /* 6FA24 8007F224 740002A2 */  sb         $v0, 0x74($s0)
    /* 6FA28 8007F228 21B80000 */  addu       $s7, $zero, $zero
  .L8007F22C:
    /* 6FA2C 8007F22C 5A0000A2 */  sb         $zero, 0x5A($s0)
    /* 6FA30 8007F230 740015A2 */  sb         $s5, 0x74($s0)
  .L8007F234:
    /* 6FA34 8007F234 8802828F */  lw         $v0, %gp_rel(gMaxFindQuadSliceIterations)($gp)
    /* 6FA38 8007F238 00000000 */  nop
    /* 6FA3C 8007F23C 2A106202 */  slt        $v0, $s3, $v0
    /* 6FA40 8007F240 90014010 */  beqz       $v0, .L8007F884
    /* 6FA44 8007F244 00000000 */   nop
    /* 6FA48 8007F248 0DFC010C */  jal        BWorld_SetSimSlice__FP12BWorldSm_Pos
    /* 6FA4C 8007F24C 21200002 */   addu      $a0, $s0, $zero
    /* 6FA50 8007F250 8000028E */  lw         $v0, 0x80($s0)
    /* 6FA54 8007F254 740015A2 */  sb         $s5, 0x74($s0)
    /* 6FA58 8007F258 01004390 */  lbu        $v1, 0x1($v0)
    /* 6FA5C 8007F25C 00000000 */  nop
    /* 6FA60 8007F260 FFFF6224 */  addiu      $v0, $v1, -0x1
    /* 6FA64 8007F264 2A105500 */  slt        $v0, $v0, $s5
    /* 6FA68 8007F268 02004010 */  beqz       $v0, .L8007F274
    /* 6FA6C 8007F26C FEFF6224 */   addiu     $v0, $v1, -0x2
    /* 6FA70 8007F270 740002A2 */  sb         $v0, 0x74($s0)
  .L8007F274:
    /* 6FA74 8007F274 75000392 */  lbu        $v1, 0x75($s0)
    /* 6FA78 8007F278 00000000 */  nop
    /* 6FA7C 8007F27C 40100300 */  sll        $v0, $v1, 1
    /* 6FA80 8007F280 21104300 */  addu       $v0, $v0, $v1
    /* 6FA84 8007F284 1480033C */  lui        $v1, %hi(Chunk_chunkCenters)
    /* 6FA88 8007F288 1CC8638C */  lw         $v1, %lo(Chunk_chunkCenters)($v1)
    /* 6FA8C 8007F28C 80100200 */  sll        $v0, $v0, 2
    /* 6FA90 8007F290 21A06200 */  addu       $s4, $v1, $v0
    /* 6FA94 8007F294 0000C28F */  lw         $v0, 0x0($fp)
    /* 6FA98 8007F298 0000838E */  lw         $v1, 0x0($s4)
    /* 6FA9C 8007F29C 00000000 */  nop
    /* 6FAA0 8007F2A0 23104300 */  subu       $v0, $v0, $v1
    /* 6FAA4 8007F2A4 83120200 */  sra        $v0, $v0, 10
    /* 6FAA8 8007F2A8 1000A2A7 */  sh         $v0, 0x10($sp)
    /* 6FAAC 8007F2AC 0800C28F */  lw         $v0, 0x8($fp)
    /* 6FAB0 8007F2B0 0800838E */  lw         $v1, 0x8($s4)
    /* 6FAB4 8007F2B4 00000000 */  nop
    /* 6FAB8 8007F2B8 23104300 */  subu       $v0, $v0, $v1
    /* 6FABC 8007F2BC 83120200 */  sra        $v0, $v0, 10
    /* 6FAC0 8007F2C0 1400A2A7 */  sh         $v0, 0x14($sp)
    /* 6FAC4 8007F2C4 75000392 */  lbu        $v1, 0x75($s0)
    /* 6FAC8 8007F2C8 FF7F113C */  lui        $s1, (0x7FFFFFFF >> 16)
    /* 6FACC 8007F2CC C0100300 */  sll        $v0, $v1, 3
    /* 6FAD0 8007F2D0 23104300 */  subu       $v0, $v0, $v1
    /* 6FAD4 8007F2D4 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* 6FAD8 8007F2D8 B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* 6FADC 8007F2DC 00110200 */  sll        $v0, $v0, 4
    /* 6FAE0 8007F2E0 21104300 */  addu       $v0, $v0, $v1
    /* 6FAE4 8007F2E4 6C00428C */  lw         $v0, 0x6C($v0)
    /* 6FAE8 8007F2E8 21200002 */  addu       $a0, $s0, $zero
    /* 6FAEC 8007F2EC 04005224 */  addiu      $s2, $v0, 0x4
    /* 6FAF0 8007F2F0 E6FB010C */  jal        GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
    /* 6FAF4 8007F2F4 21284002 */   addu      $a1, $s2, $zero
    /* 6FAF8 8007F2F8 25FC010C */  jal        BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
    /* 6FAFC 8007F2FC 21200002 */   addu      $a0, $s0, $zero
    /* 6FB00 8007F300 8000028E */  lw         $v0, 0x80($s0)
    /* 6FB04 8007F304 55FD0108 */  j          .L8007F554
    /* 6FB08 8007F308 FFFF3136 */   ori       $s1, $s1, (0x7FFFFFFF & 0xFFFF)
  .L8007F30C:
    /* 6FB0C 8007F30C E6FB010C */  jal        GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
    /* 6FB10 8007F310 21284002 */   addu      $a1, $s2, $zero
    /* 6FB14 8007F314 40000686 */  lh         $a2, 0x40($s0)
    /* 6FB18 8007F318 48000A86 */  lh         $t2, 0x48($s0)
    /* 6FB1C 8007F31C 1400AB87 */  lh         $t3, 0x14($sp)
    /* 6FB20 8007F320 4C000C86 */  lh         $t4, 0x4C($s0)
    /* 6FB24 8007F324 2318CA00 */  subu       $v1, $a2, $t2
    /* 6FB28 8007F328 23106C01 */  subu       $v0, $t3, $t4
    /* 6FB2C 8007F32C 18006200 */  mult       $v1, $v0
    /* 6FB30 8007F330 1000A987 */  lh         $t1, 0x10($sp)
    /* 6FB34 8007F334 44000486 */  lh         $a0, 0x44($s0)
    /* 6FB38 8007F338 12280000 */  mflo       $a1
    /* 6FB3C 8007F33C 23182A01 */  subu       $v1, $t1, $t2
    /* 6FB40 8007F340 23108C00 */  subu       $v0, $a0, $t4
    /* 6FB44 8007F344 18006200 */  mult       $v1, $v0
    /* 6FB48 8007F348 12180000 */  mflo       $v1
    /* 6FB4C 8007F34C 2310A300 */  subu       $v0, $a1, $v1
    /* 6FB50 8007F350 2900401C */  bgtz       $v0, .L8007F3F8
    /* 6FB54 8007F354 23106401 */   subu      $v0, $t3, $a0
    /* 6FB58 8007F358 38000886 */  lh         $t0, 0x38($s0)
    /* 6FB5C 8007F35C 00000000 */  nop
    /* 6FB60 8007F360 23180601 */  subu       $v1, $t0, $a2
    /* 6FB64 8007F364 18006200 */  mult       $v1, $v0
    /* 6FB68 8007F368 3C000786 */  lh         $a3, 0x3C($s0)
    /* 6FB6C 8007F36C 12280000 */  mflo       $a1
    /* 6FB70 8007F370 23182601 */  subu       $v1, $t1, $a2
    /* 6FB74 8007F374 2310E400 */  subu       $v0, $a3, $a0
    /* 6FB78 8007F378 18006200 */  mult       $v1, $v0
    /* 6FB7C 8007F37C 12180000 */  mflo       $v1
    /* 6FB80 8007F380 2310A300 */  subu       $v0, $a1, $v1
    /* 6FB84 8007F384 1C00401C */  bgtz       $v0, .L8007F3F8
    /* 6FB88 8007F388 00000000 */   nop
    /* 6FB8C 8007F38C 50000486 */  lh         $a0, 0x50($s0)
    /* 6FB90 8007F390 54000586 */  lh         $a1, 0x54($s0)
    /* 6FB94 8007F394 23184401 */  subu       $v1, $t2, $a0
    /* 6FB98 8007F398 23106501 */  subu       $v0, $t3, $a1
    /* 6FB9C 8007F39C 18006200 */  mult       $v1, $v0
    /* 6FBA0 8007F3A0 12300000 */  mflo       $a2
    /* 6FBA4 8007F3A4 23182401 */  subu       $v1, $t1, $a0
    /* 6FBA8 8007F3A8 23108501 */  subu       $v0, $t4, $a1
    /* 6FBAC 8007F3AC 18006200 */  mult       $v1, $v0
    /* 6FBB0 8007F3B0 12180000 */  mflo       $v1
    /* 6FBB4 8007F3B4 2310C300 */  subu       $v0, $a2, $v1
    /* 6FBB8 8007F3B8 0F00401C */  bgtz       $v0, .L8007F3F8
    /* 6FBBC 8007F3BC 23188800 */   subu      $v1, $a0, $t0
    /* 6FBC0 8007F3C0 23106701 */  subu       $v0, $t3, $a3
    /* 6FBC4 8007F3C4 18006200 */  mult       $v1, $v0
    /* 6FBC8 8007F3C8 12200000 */  mflo       $a0
    /* 6FBCC 8007F3CC 23182801 */  subu       $v1, $t1, $t0
    /* 6FBD0 8007F3D0 2310A700 */  subu       $v0, $a1, $a3
    /* 6FBD4 8007F3D4 18006200 */  mult       $v1, $v0
    /* 6FBD8 8007F3D8 12180000 */  mflo       $v1
    /* 6FBDC 8007F3DC 23108300 */  subu       $v0, $a0, $v1
    /* 6FBE0 8007F3E0 0500401C */  bgtz       $v0, .L8007F3F8
    /* 6FBE4 8007F3E4 00000000 */   nop
    /* 6FBE8 8007F3E8 47FC010C */  jal        BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
    /* 6FBEC 8007F3EC 21200002 */   addu      $a0, $s0, $zero
    /* 6FBF0 8007F3F0 7AFF4014 */  bnez       $v0, .L8007F1DC
    /* 6FBF4 8007F3F4 00000000 */   nop
  .L8007F3F8:
    /* 6FBF8 8007F3F8 8000028E */  lw         $v0, 0x80($s0)
    /* 6FBFC 8007F3FC 00000000 */  nop
    /* 6FC00 8007F400 01004290 */  lbu        $v0, 0x1($v0)
    /* 6FC04 8007F404 74000382 */  lb         $v1, 0x74($s0)
    /* 6FC08 8007F408 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 6FC0C 8007F40C 64006210 */  beq        $v1, $v0, .L8007F5A0
    /* 6FC10 8007F410 02000224 */   addiu     $v0, $zero, 0x2
    /* 6FC14 8007F414 47FC010C */  jal        BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
    /* 6FC18 8007F418 21200002 */   addu      $a0, $s0, $zero
    /* 6FC1C 8007F41C 47004010 */  beqz       $v0, .L8007F53C
    /* 6FC20 8007F420 00000000 */   nop
    /* 6FC24 8007F424 1000A387 */  lh         $v1, 0x10($sp)
    /* 6FC28 8007F428 50000286 */  lh         $v0, 0x50($s0)
    /* 6FC2C 8007F42C 00000000 */  nop
    /* 6FC30 8007F430 23406200 */  subu       $t0, $v1, $v0
    /* 6FC34 8007F434 0200001D */  bgtz       $t0, .L8007F440
    /* 6FC38 8007F438 00000000 */   nop
    /* 6FC3C 8007F43C 23404300 */  subu       $t0, $v0, $v1
  .L8007F440:
    /* 6FC40 8007F440 48000286 */  lh         $v0, 0x48($s0)
    /* 6FC44 8007F444 00000000 */  nop
    /* 6FC48 8007F448 23386200 */  subu       $a3, $v1, $v0
    /* 6FC4C 8007F44C 0200E01C */  bgtz       $a3, .L8007F458
    /* 6FC50 8007F450 00000000 */   nop
    /* 6FC54 8007F454 23384300 */  subu       $a3, $v0, $v1
  .L8007F458:
    /* 6FC58 8007F458 40000286 */  lh         $v0, 0x40($s0)
    /* 6FC5C 8007F45C 00000000 */  nop
    /* 6FC60 8007F460 23306200 */  subu       $a2, $v1, $v0
    /* 6FC64 8007F464 0200C01C */  bgtz       $a2, .L8007F470
    /* 6FC68 8007F468 00000000 */   nop
    /* 6FC6C 8007F46C 23304300 */  subu       $a2, $v0, $v1
  .L8007F470:
    /* 6FC70 8007F470 38000286 */  lh         $v0, 0x38($s0)
    /* 6FC74 8007F474 00000000 */  nop
    /* 6FC78 8007F478 23286200 */  subu       $a1, $v1, $v0
    /* 6FC7C 8007F47C 0200A01C */  bgtz       $a1, .L8007F488
    /* 6FC80 8007F480 00000000 */   nop
    /* 6FC84 8007F484 23284300 */  subu       $a1, $v0, $v1
  .L8007F488:
    /* 6FC88 8007F488 1400A487 */  lh         $a0, 0x14($sp)
    /* 6FC8C 8007F48C 3C000286 */  lh         $v0, 0x3C($s0)
    /* 6FC90 8007F490 00000000 */  nop
    /* 6FC94 8007F494 23188200 */  subu       $v1, $a0, $v0
    /* 6FC98 8007F498 03006018 */  blez       $v1, .L8007F4A8
    /* 6FC9C 8007F49C 23104400 */   subu      $v0, $v0, $a0
    /* 6FCA0 8007F4A0 2CFD0108 */  j          .L8007F4B0
    /* 6FCA4 8007F4A4 2128A300 */   addu      $a1, $a1, $v1
  .L8007F4A8:
    /* 6FCA8 8007F4A8 2128A200 */  addu       $a1, $a1, $v0
    /* 6FCAC 8007F4AC 1400A487 */  lh         $a0, 0x14($sp)
  .L8007F4B0:
    /* 6FCB0 8007F4B0 44000286 */  lh         $v0, 0x44($s0)
    /* 6FCB4 8007F4B4 00000000 */  nop
    /* 6FCB8 8007F4B8 23188200 */  subu       $v1, $a0, $v0
    /* 6FCBC 8007F4BC 03006018 */  blez       $v1, .L8007F4CC
    /* 6FCC0 8007F4C0 23104400 */   subu      $v0, $v0, $a0
    /* 6FCC4 8007F4C4 34FD0108 */  j          .L8007F4D0
    /* 6FCC8 8007F4C8 2110C300 */   addu      $v0, $a2, $v1
  .L8007F4CC:
    /* 6FCCC 8007F4CC 2110C200 */  addu       $v0, $a2, $v0
  .L8007F4D0:
    /* 6FCD0 8007F4D0 2128A200 */  addu       $a1, $a1, $v0
    /* 6FCD4 8007F4D4 1400A487 */  lh         $a0, 0x14($sp)
    /* 6FCD8 8007F4D8 4C000286 */  lh         $v0, 0x4C($s0)
    /* 6FCDC 8007F4DC 00000000 */  nop
    /* 6FCE0 8007F4E0 23188200 */  subu       $v1, $a0, $v0
    /* 6FCE4 8007F4E4 03006018 */  blez       $v1, .L8007F4F4
    /* 6FCE8 8007F4E8 23104400 */   subu      $v0, $v0, $a0
    /* 6FCEC 8007F4EC 3EFD0108 */  j          .L8007F4F8
    /* 6FCF0 8007F4F0 2110E300 */   addu      $v0, $a3, $v1
  .L8007F4F4:
    /* 6FCF4 8007F4F4 2110E200 */  addu       $v0, $a3, $v0
  .L8007F4F8:
    /* 6FCF8 8007F4F8 2128A200 */  addu       $a1, $a1, $v0
    /* 6FCFC 8007F4FC 1400A487 */  lh         $a0, 0x14($sp)
    /* 6FD00 8007F500 54000286 */  lh         $v0, 0x54($s0)
    /* 6FD04 8007F504 00000000 */  nop
    /* 6FD08 8007F508 23188200 */  subu       $v1, $a0, $v0
    /* 6FD0C 8007F50C 03006018 */  blez       $v1, .L8007F51C
    /* 6FD10 8007F510 23104400 */   subu      $v0, $v0, $a0
    /* 6FD14 8007F514 48FD0108 */  j          .L8007F520
    /* 6FD18 8007F518 21100301 */   addu      $v0, $t0, $v1
  .L8007F51C:
    /* 6FD1C 8007F51C 21100201 */  addu       $v0, $t0, $v0
  .L8007F520:
    /* 6FD20 8007F520 2110A200 */  addu       $v0, $a1, $v0
    /* 6FD24 8007F524 21184000 */  addu       $v1, $v0, $zero
    /* 6FD28 8007F528 23107100 */  subu       $v0, $v1, $s1
    /* 6FD2C 8007F52C 29004228 */  slti       $v0, $v0, 0x29
    /* 6FD30 8007F530 10004010 */  beqz       $v0, .L8007F574
    /* 6FD34 8007F534 FF7F113C */   lui       $s1, (0x7FFFFFFF >> 16)
    /* 6FD38 8007F538 21886000 */  addu       $s1, $v1, $zero
  .L8007F53C:
    /* 6FD3C 8007F53C 74000292 */  lbu        $v0, 0x74($s0)
    /* 6FD40 8007F540 21200002 */  addu       $a0, $s0, $zero
    /* 6FD44 8007F544 01004224 */  addiu      $v0, $v0, 0x1
    /* 6FD48 8007F548 25FC010C */  jal        BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
    /* 6FD4C 8007F54C 740002A2 */   sb        $v0, 0x74($s0)
    /* 6FD50 8007F550 8000028E */  lw         $v0, 0x80($s0)
  .L8007F554:
    /* 6FD54 8007F554 00000000 */  nop
    /* 6FD58 8007F558 01004290 */  lbu        $v0, 0x1($v0)
    /* 6FD5C 8007F55C 74000382 */  lb         $v1, 0x74($s0)
    /* 6FD60 8007F560 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 6FD64 8007F564 2A104300 */  slt        $v0, $v0, $v1
    /* 6FD68 8007F568 68FF4010 */  beqz       $v0, .L8007F30C
    /* 6FD6C 8007F56C 21200002 */   addu      $a0, $s0, $zero
  .L8007F570:
    /* 6FD70 8007F570 FF7F113C */  lui        $s1, (0x7FFFFFFF >> 16)
  .L8007F574:
    /* 6FD74 8007F574 5A000282 */  lb         $v0, 0x5A($s0)
    /* 6FD78 8007F578 00000000 */  nop
    /* 6FD7C 8007F57C 0C004010 */  beqz       $v0, .L8007F5B0
    /* 6FD80 8007F580 FFFF3136 */   ori       $s1, $s1, (0x7FFFFFFF & 0xFFFF)
    /* 6FD84 8007F584 0A006016 */  bnez       $s3, .L8007F5B0
    /* 6FD88 8007F588 00000000 */   nop
    /* 6FD8C 8007F58C 8000028E */  lw         $v0, 0x80($s0)
    /* 6FD90 8007F590 00000000 */  nop
    /* 6FD94 8007F594 01004290 */  lbu        $v0, 0x1($v0)
    /* 6FD98 8007F598 6DFD0108 */  j          .L8007F5B4
    /* 6FD9C 8007F59C FFFF4224 */   addiu     $v0, $v0, -0x1
  .L8007F5A0:
    /* 6FDA0 8007F5A0 5CFD0108 */  j          .L8007F570
    /* 6FDA4 8007F5A4 5A0002A2 */   sb        $v0, 0x5A($s0)
  .L8007F5A8:
    /* 6FDA8 8007F5A8 0BFE0108 */  j          .L8007F82C
    /* 6FDAC 8007F5AC 5A0002A2 */   sb        $v0, 0x5A($s0)
  .L8007F5B0:
    /* 6FDB0 8007F5B0 FFFFA226 */  addiu      $v0, $s5, -0x1
  .L8007F5B4:
    /* 6FDB4 8007F5B4 740002A2 */  sb         $v0, 0x74($s0)
    /* 6FDB8 8007F5B8 74000282 */  lb         $v0, 0x74($s0)
    /* 6FDBC 8007F5BC 00000000 */  nop
    /* 6FDC0 8007F5C0 02004104 */  bgez       $v0, .L8007F5CC
    /* 6FDC4 8007F5C4 00000000 */   nop
    /* 6FDC8 8007F5C8 740000A2 */  sb         $zero, 0x74($s0)
  .L8007F5CC:
    /* 6FDCC 8007F5CC 21200002 */  addu       $a0, $s0, $zero
    /* 6FDD0 8007F5D0 E6FB010C */  jal        GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
    /* 6FDD4 8007F5D4 21284002 */   addu      $a1, $s2, $zero
    /* 6FDD8 8007F5D8 05FE0108 */  j          .L8007F814
    /* 6FDDC 8007F5DC 21200002 */   addu      $a0, $s0, $zero
  .L8007F5E0:
    /* 6FDE0 8007F5E0 E6FB010C */  jal        GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
    /* 6FDE4 8007F5E4 21284002 */   addu      $a1, $s2, $zero
    /* 6FDE8 8007F5E8 40000686 */  lh         $a2, 0x40($s0)
    /* 6FDEC 8007F5EC 48000A86 */  lh         $t2, 0x48($s0)
    /* 6FDF0 8007F5F0 1400AB87 */  lh         $t3, 0x14($sp)
    /* 6FDF4 8007F5F4 4C000C86 */  lh         $t4, 0x4C($s0)
    /* 6FDF8 8007F5F8 2318CA00 */  subu       $v1, $a2, $t2
    /* 6FDFC 8007F5FC 23106C01 */  subu       $v0, $t3, $t4
    /* 6FE00 8007F600 18006200 */  mult       $v1, $v0
    /* 6FE04 8007F604 1000A987 */  lh         $t1, 0x10($sp)
    /* 6FE08 8007F608 44000486 */  lh         $a0, 0x44($s0)
    /* 6FE0C 8007F60C 12280000 */  mflo       $a1
    /* 6FE10 8007F610 23182A01 */  subu       $v1, $t1, $t2
    /* 6FE14 8007F614 23108C00 */  subu       $v0, $a0, $t4
    /* 6FE18 8007F618 18006200 */  mult       $v1, $v0
    /* 6FE1C 8007F61C 12180000 */  mflo       $v1
    /* 6FE20 8007F620 2310A300 */  subu       $v0, $a1, $v1
    /* 6FE24 8007F624 2900401C */  bgtz       $v0, .L8007F6CC
    /* 6FE28 8007F628 23106401 */   subu      $v0, $t3, $a0
    /* 6FE2C 8007F62C 38000886 */  lh         $t0, 0x38($s0)
    /* 6FE30 8007F630 00000000 */  nop
    /* 6FE34 8007F634 23180601 */  subu       $v1, $t0, $a2
    /* 6FE38 8007F638 18006200 */  mult       $v1, $v0
    /* 6FE3C 8007F63C 3C000786 */  lh         $a3, 0x3C($s0)
    /* 6FE40 8007F640 12280000 */  mflo       $a1
    /* 6FE44 8007F644 23182601 */  subu       $v1, $t1, $a2
    /* 6FE48 8007F648 2310E400 */  subu       $v0, $a3, $a0
    /* 6FE4C 8007F64C 18006200 */  mult       $v1, $v0
    /* 6FE50 8007F650 12180000 */  mflo       $v1
    /* 6FE54 8007F654 2310A300 */  subu       $v0, $a1, $v1
    /* 6FE58 8007F658 1C00401C */  bgtz       $v0, .L8007F6CC
    /* 6FE5C 8007F65C 00000000 */   nop
    /* 6FE60 8007F660 50000486 */  lh         $a0, 0x50($s0)
    /* 6FE64 8007F664 54000586 */  lh         $a1, 0x54($s0)
    /* 6FE68 8007F668 23184401 */  subu       $v1, $t2, $a0
    /* 6FE6C 8007F66C 23106501 */  subu       $v0, $t3, $a1
    /* 6FE70 8007F670 18006200 */  mult       $v1, $v0
    /* 6FE74 8007F674 12300000 */  mflo       $a2
    /* 6FE78 8007F678 23182401 */  subu       $v1, $t1, $a0
    /* 6FE7C 8007F67C 23108501 */  subu       $v0, $t4, $a1
    /* 6FE80 8007F680 18006200 */  mult       $v1, $v0
    /* 6FE84 8007F684 12180000 */  mflo       $v1
    /* 6FE88 8007F688 2310C300 */  subu       $v0, $a2, $v1
    /* 6FE8C 8007F68C 0F00401C */  bgtz       $v0, .L8007F6CC
    /* 6FE90 8007F690 23188800 */   subu      $v1, $a0, $t0
    /* 6FE94 8007F694 23106701 */  subu       $v0, $t3, $a3
    /* 6FE98 8007F698 18006200 */  mult       $v1, $v0
    /* 6FE9C 8007F69C 12200000 */  mflo       $a0
    /* 6FEA0 8007F6A0 23182801 */  subu       $v1, $t1, $t0
    /* 6FEA4 8007F6A4 2310A700 */  subu       $v0, $a1, $a3
    /* 6FEA8 8007F6A8 18006200 */  mult       $v1, $v0
    /* 6FEAC 8007F6AC 12180000 */  mflo       $v1
    /* 6FEB0 8007F6B0 23108300 */  subu       $v0, $a0, $v1
    /* 6FEB4 8007F6B4 0500401C */  bgtz       $v0, .L8007F6CC
    /* 6FEB8 8007F6B8 00000000 */   nop
    /* 6FEBC 8007F6BC 47FC010C */  jal        BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
    /* 6FEC0 8007F6C0 21200002 */   addu      $a0, $s0, $zero
    /* 6FEC4 8007F6C4 C5FE4014 */  bnez       $v0, .L8007F1DC
    /* 6FEC8 8007F6C8 00000000 */   nop
  .L8007F6CC:
    /* 6FECC 8007F6CC 74000282 */  lb         $v0, 0x74($s0)
    /* 6FED0 8007F6D0 00000000 */  nop
    /* 6FED4 8007F6D4 B4FF4010 */  beqz       $v0, .L8007F5A8
    /* 6FED8 8007F6D8 01000224 */   addiu     $v0, $zero, 0x1
    /* 6FEDC 8007F6DC 47FC010C */  jal        BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
    /* 6FEE0 8007F6E0 21200002 */   addu      $a0, $s0, $zero
    /* 6FEE4 8007F6E4 47004010 */  beqz       $v0, .L8007F804
    /* 6FEE8 8007F6E8 00000000 */   nop
    /* 6FEEC 8007F6EC 1000A387 */  lh         $v1, 0x10($sp)
    /* 6FEF0 8007F6F0 50000286 */  lh         $v0, 0x50($s0)
    /* 6FEF4 8007F6F4 00000000 */  nop
    /* 6FEF8 8007F6F8 23406200 */  subu       $t0, $v1, $v0
    /* 6FEFC 8007F6FC 0200001D */  bgtz       $t0, .L8007F708
    /* 6FF00 8007F700 00000000 */   nop
    /* 6FF04 8007F704 23404300 */  subu       $t0, $v0, $v1
  .L8007F708:
    /* 6FF08 8007F708 48000286 */  lh         $v0, 0x48($s0)
    /* 6FF0C 8007F70C 00000000 */  nop
    /* 6FF10 8007F710 23386200 */  subu       $a3, $v1, $v0
    /* 6FF14 8007F714 0200E01C */  bgtz       $a3, .L8007F720
    /* 6FF18 8007F718 00000000 */   nop
    /* 6FF1C 8007F71C 23384300 */  subu       $a3, $v0, $v1
  .L8007F720:
    /* 6FF20 8007F720 40000286 */  lh         $v0, 0x40($s0)
    /* 6FF24 8007F724 00000000 */  nop
    /* 6FF28 8007F728 23306200 */  subu       $a2, $v1, $v0
    /* 6FF2C 8007F72C 0200C01C */  bgtz       $a2, .L8007F738
    /* 6FF30 8007F730 00000000 */   nop
    /* 6FF34 8007F734 23304300 */  subu       $a2, $v0, $v1
  .L8007F738:
    /* 6FF38 8007F738 38000286 */  lh         $v0, 0x38($s0)
    /* 6FF3C 8007F73C 00000000 */  nop
    /* 6FF40 8007F740 23286200 */  subu       $a1, $v1, $v0
    /* 6FF44 8007F744 0200A01C */  bgtz       $a1, .L8007F750
    /* 6FF48 8007F748 00000000 */   nop
    /* 6FF4C 8007F74C 23284300 */  subu       $a1, $v0, $v1
  .L8007F750:
    /* 6FF50 8007F750 1400A487 */  lh         $a0, 0x14($sp)
    /* 6FF54 8007F754 3C000286 */  lh         $v0, 0x3C($s0)
    /* 6FF58 8007F758 00000000 */  nop
    /* 6FF5C 8007F75C 23188200 */  subu       $v1, $a0, $v0
    /* 6FF60 8007F760 03006018 */  blez       $v1, .L8007F770
    /* 6FF64 8007F764 23104400 */   subu      $v0, $v0, $a0
    /* 6FF68 8007F768 DEFD0108 */  j          .L8007F778
    /* 6FF6C 8007F76C 2128A300 */   addu      $a1, $a1, $v1
  .L8007F770:
    /* 6FF70 8007F770 2128A200 */  addu       $a1, $a1, $v0
    /* 6FF74 8007F774 1400A487 */  lh         $a0, 0x14($sp)
  .L8007F778:
    /* 6FF78 8007F778 44000286 */  lh         $v0, 0x44($s0)
    /* 6FF7C 8007F77C 00000000 */  nop
    /* 6FF80 8007F780 23188200 */  subu       $v1, $a0, $v0
    /* 6FF84 8007F784 03006018 */  blez       $v1, .L8007F794
    /* 6FF88 8007F788 23104400 */   subu      $v0, $v0, $a0
    /* 6FF8C 8007F78C E6FD0108 */  j          .L8007F798
    /* 6FF90 8007F790 2110C300 */   addu      $v0, $a2, $v1
  .L8007F794:
    /* 6FF94 8007F794 2110C200 */  addu       $v0, $a2, $v0
  .L8007F798:
    /* 6FF98 8007F798 2128A200 */  addu       $a1, $a1, $v0
    /* 6FF9C 8007F79C 1400A487 */  lh         $a0, 0x14($sp)
    /* 6FFA0 8007F7A0 4C000286 */  lh         $v0, 0x4C($s0)
    /* 6FFA4 8007F7A4 00000000 */  nop
    /* 6FFA8 8007F7A8 23188200 */  subu       $v1, $a0, $v0
    /* 6FFAC 8007F7AC 03006018 */  blez       $v1, .L8007F7BC
    /* 6FFB0 8007F7B0 23104400 */   subu      $v0, $v0, $a0
    /* 6FFB4 8007F7B4 F0FD0108 */  j          .L8007F7C0
    /* 6FFB8 8007F7B8 2110E300 */   addu      $v0, $a3, $v1
  .L8007F7BC:
    /* 6FFBC 8007F7BC 2110E200 */  addu       $v0, $a3, $v0
  .L8007F7C0:
    /* 6FFC0 8007F7C0 2128A200 */  addu       $a1, $a1, $v0
    /* 6FFC4 8007F7C4 1400A487 */  lh         $a0, 0x14($sp)
    /* 6FFC8 8007F7C8 54000286 */  lh         $v0, 0x54($s0)
    /* 6FFCC 8007F7CC 00000000 */  nop
    /* 6FFD0 8007F7D0 23188200 */  subu       $v1, $a0, $v0
    /* 6FFD4 8007F7D4 03006018 */  blez       $v1, .L8007F7E4
    /* 6FFD8 8007F7D8 23104400 */   subu      $v0, $v0, $a0
    /* 6FFDC 8007F7DC FAFD0108 */  j          .L8007F7E8
    /* 6FFE0 8007F7E0 21100301 */   addu      $v0, $t0, $v1
  .L8007F7E4:
    /* 6FFE4 8007F7E4 21100201 */  addu       $v0, $t0, $v0
  .L8007F7E8:
    /* 6FFE8 8007F7E8 2110A200 */  addu       $v0, $a1, $v0
    /* 6FFEC 8007F7EC 21184000 */  addu       $v1, $v0, $zero
    /* 6FFF0 8007F7F0 23107100 */  subu       $v0, $v1, $s1
    /* 6FFF4 8007F7F4 29004228 */  slti       $v0, $v0, 0x29
    /* 6FFF8 8007F7F8 0C004010 */  beqz       $v0, .L8007F82C
    /* 6FFFC 8007F7FC 00000000 */   nop
    /* 70000 8007F800 21886000 */  addu       $s1, $v1, $zero
  .L8007F804:
    /* 70004 8007F804 74000292 */  lbu        $v0, 0x74($s0)
    /* 70008 8007F808 21200002 */  addu       $a0, $s0, $zero
    /* 7000C 8007F80C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 70010 8007F810 740002A2 */  sb         $v0, 0x74($s0)
  .L8007F814:
    /* 70014 8007F814 25FC010C */  jal        BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
    /* 70018 8007F818 00000000 */   nop
    /* 7001C 8007F81C 74000282 */  lb         $v0, 0x74($s0)
    /* 70020 8007F820 00000000 */  nop
    /* 70024 8007F824 6EFF4104 */  bgez       $v0, .L8007F5E0
    /* 70028 8007F828 21200002 */   addu      $a0, $s0, $zero
  .L8007F82C:
    /* 7002C 8007F82C 02006016 */  bnez       $s3, .L8007F838
    /* 70030 8007F830 1180023C */   lui       $v0, %hi(D_8010F07C)
    /* 70034 8007F834 5A001782 */  lb         $s7, 0x5A($s0)
  .L8007F838:
    /* 70038 8007F838 7CF04224 */  addiu      $v0, $v0, %lo(D_8010F07C)
    /* 7003C 8007F83C 80181300 */  sll        $v1, $s3, 2
    /* 70040 8007F840 21186200 */  addu       $v1, $v1, $v0
    /* 70044 8007F844 00000486 */  lh         $a0, 0x0($s0)
    /* 70048 8007F848 0000628C */  lw         $v0, 0x0($v1)
    /* 7004C 8007F84C 7C02858F */  lw         $a1, %gp_rel(gNumSlices)($gp)
    /* 70050 8007F850 21208200 */  addu       $a0, $a0, $v0
    /* 70054 8007F854 2A108500 */  slt        $v0, $a0, $a1
    /* 70058 8007F858 02004014 */  bnez       $v0, .L8007F864
    /* 7005C 8007F85C 00000000 */   nop
    /* 70060 8007F860 23208500 */  subu       $a0, $a0, $a1
  .L8007F864:
    /* 70064 8007F864 02008104 */  bgez       $a0, .L8007F870
    /* 70068 8007F868 00000000 */   nop
    /* 7006C 8007F86C 21208500 */  addu       $a0, $a0, $a1
  .L8007F870:
    /* 70070 8007F870 000004A6 */  sh         $a0, 0x0($s0)
    /* 70074 8007F874 0000628C */  lw         $v0, 0x0($v1)
    /* 70078 8007F878 01007326 */  addiu      $s3, $s3, 0x1
    /* 7007C 8007F87C 8DFC0108 */  j          .L8007F234
    /* 70080 8007F880 21B0C202 */   addu      $s6, $s6, $v0
  .L8007F884:
    /* 70084 8007F884 00000386 */  lh         $v1, 0x0($s0)
    /* 70088 8007F888 7C02848F */  lw         $a0, %gp_rel(gNumSlices)($gp)
    /* 7008C 8007F88C 23187600 */  subu       $v1, $v1, $s6
    /* 70090 8007F890 2A106400 */  slt        $v0, $v1, $a0
    /* 70094 8007F894 02004014 */  bnez       $v0, .L8007F8A0
    /* 70098 8007F898 00000000 */   nop
    /* 7009C 8007F89C 23186400 */  subu       $v1, $v1, $a0
  .L8007F8A0:
    /* 700A0 8007F8A0 02006104 */  bgez       $v1, .L8007F8AC
    /* 700A4 8007F8A4 00000000 */   nop
    /* 700A8 8007F8A8 21186400 */  addu       $v1, $v1, $a0
  .L8007F8AC:
    /* 700AC 8007F8AC 21200002 */  addu       $a0, $s0, $zero
    /* 700B0 8007F8B0 0DFC010C */  jal        BWorld_SetSimSlice__FP12BWorldSm_Pos
    /* 700B4 8007F8B4 000003A6 */   sh        $v1, 0x0($s0)
    /* 700B8 8007F8B8 21100000 */  addu       $v0, $zero, $zero
    /* 700BC 8007F8BC 5A0017A2 */  sb         $s7, 0x5A($s0)
    /* 700C0 8007F8C0 780000AE */  sw         $zero, 0x78($s0)
    /* 700C4 8007F8C4 5B0000A2 */  sb         $zero, 0x5B($s0)
  .L8007F8C8:
    /* 700C8 8007F8C8 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* 700CC 8007F8CC 3800BE8F */  lw         $fp, 0x38($sp)
    /* 700D0 8007F8D0 3400B78F */  lw         $s7, 0x34($sp)
    /* 700D4 8007F8D4 3000B68F */  lw         $s6, 0x30($sp)
    /* 700D8 8007F8D8 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 700DC 8007F8DC 2800B48F */  lw         $s4, 0x28($sp)
    /* 700E0 8007F8E0 2400B38F */  lw         $s3, 0x24($sp)
    /* 700E4 8007F8E4 2000B28F */  lw         $s2, 0x20($sp)
    /* 700E8 8007F8E8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 700EC 8007F8EC 1800B08F */  lw         $s0, 0x18($sp)
    /* 700F0 8007F8F0 0800E003 */  jr         $ra
    /* 700F4 8007F8F4 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos
