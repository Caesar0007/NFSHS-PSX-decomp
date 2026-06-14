.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi, 0x1CC

glabel BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 702C4 8007FAC4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 702C8 8007FAC8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 702CC 8007FACC 21908000 */  addu       $s2, $a0, $zero
    /* 702D0 8007FAD0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 702D4 8007FAD4 2188A000 */  addu       $s1, $a1, $zero
    /* 702D8 8007FAD8 03000224 */  addiu      $v0, $zero, 0x3
    /* 702DC 8007FADC 2000BFAF */  sw         $ra, 0x20($sp)
    /* 702E0 8007FAE0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 702E4 8007FAE4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 702E8 8007FAE8 5700C010 */  beqz       $a2, .L8007FC48
    /* 702EC 8007FAEC 5B0022A2 */   sb        $v0, 0x5B($s1)
    /* 702F0 8007FAF0 7800238E */  lw         $v1, 0x78($s1)
    /* 702F4 8007FAF4 02000224 */  addiu      $v0, $zero, 0x2
    /* 702F8 8007FAF8 4E006010 */  beqz       $v1, .L8007FC34
    /* 702FC 8007FAFC 760022A2 */   sb        $v0, 0x76($s1)
    /* 70300 8007FB00 21980000 */  addu       $s3, $zero, $zero
    /* 70304 8007FB04 1400238E */  lw         $v1, 0x14($s1)
    /* 70308 8007FB08 2000248E */  lw         $a0, 0x20($s1)
    /* 7030C 8007FB0C 0800428E */  lw         $v0, 0x8($s2)
    /* 70310 8007FB10 2800258E */  lw         $a1, 0x28($s1)
    /* 70314 8007FB14 23206400 */  subu       $a0, $v1, $a0
    /* 70318 8007FB18 CA90030C */  jal        fixedmult
    /* 7031C 8007FB1C 23284500 */   subu      $a1, $v0, $a1
    /* 70320 8007FB20 21804000 */  addu       $s0, $v0, $zero
    /* 70324 8007FB24 0000468E */  lw         $a2, 0x0($s2)
    /* 70328 8007FB28 2000248E */  lw         $a0, 0x20($s1)
    /* 7032C 8007FB2C 1C00238E */  lw         $v1, 0x1C($s1)
    /* 70330 8007FB30 2800258E */  lw         $a1, 0x28($s1)
    /* 70334 8007FB34 2320C400 */  subu       $a0, $a2, $a0
    /* 70338 8007FB38 CA90030C */  jal        fixedmult
    /* 7033C 8007FB3C 23286500 */   subu      $a1, $v1, $a1
    /* 70340 8007FB40 23800202 */  subu       $s0, $s0, $v0
    /* 70344 8007FB44 3600001E */  bgtz       $s0, .L8007FC20
    /* 70348 8007FB48 00000000 */   nop
    /* 7034C 8007FB4C 0800238E */  lw         $v1, 0x8($s1)
    /* 70350 8007FB50 1400248E */  lw         $a0, 0x14($s1)
    /* 70354 8007FB54 0800428E */  lw         $v0, 0x8($s2)
    /* 70358 8007FB58 1C00258E */  lw         $a1, 0x1C($s1)
    /* 7035C 8007FB5C 23206400 */  subu       $a0, $v1, $a0
    /* 70360 8007FB60 CA90030C */  jal        fixedmult
    /* 70364 8007FB64 23284500 */   subu      $a1, $v0, $a1
    /* 70368 8007FB68 21804000 */  addu       $s0, $v0, $zero
    /* 7036C 8007FB6C 0000468E */  lw         $a2, 0x0($s2)
    /* 70370 8007FB70 1400248E */  lw         $a0, 0x14($s1)
    /* 70374 8007FB74 1000238E */  lw         $v1, 0x10($s1)
    /* 70378 8007FB78 1C00258E */  lw         $a1, 0x1C($s1)
    /* 7037C 8007FB7C 2320C400 */  subu       $a0, $a2, $a0
    /* 70380 8007FB80 CA90030C */  jal        fixedmult
    /* 70384 8007FB84 23286500 */   subu      $a1, $v1, $a1
    /* 70388 8007FB88 23800202 */  subu       $s0, $s0, $v0
    /* 7038C 8007FB8C 2400001E */  bgtz       $s0, .L8007FC20
    /* 70390 8007FB90 00000000 */   nop
    /* 70394 8007FB94 2000238E */  lw         $v1, 0x20($s1)
    /* 70398 8007FB98 2C00248E */  lw         $a0, 0x2C($s1)
    /* 7039C 8007FB9C 0800428E */  lw         $v0, 0x8($s2)
    /* 703A0 8007FBA0 3400258E */  lw         $a1, 0x34($s1)
    /* 703A4 8007FBA4 23206400 */  subu       $a0, $v1, $a0
    /* 703A8 8007FBA8 CA90030C */  jal        fixedmult
    /* 703AC 8007FBAC 23284500 */   subu      $a1, $v0, $a1
    /* 703B0 8007FBB0 21804000 */  addu       $s0, $v0, $zero
    /* 703B4 8007FBB4 0000468E */  lw         $a2, 0x0($s2)
    /* 703B8 8007FBB8 2C00248E */  lw         $a0, 0x2C($s1)
    /* 703BC 8007FBBC 2800238E */  lw         $v1, 0x28($s1)
    /* 703C0 8007FBC0 3400258E */  lw         $a1, 0x34($s1)
    /* 703C4 8007FBC4 2320C400 */  subu       $a0, $a2, $a0
    /* 703C8 8007FBC8 CA90030C */  jal        fixedmult
    /* 703CC 8007FBCC 23286500 */   subu      $a1, $v1, $a1
    /* 703D0 8007FBD0 23800202 */  subu       $s0, $s0, $v0
    /* 703D4 8007FBD4 1200001E */  bgtz       $s0, .L8007FC20
    /* 703D8 8007FBD8 00000000 */   nop
    /* 703DC 8007FBDC 2C00238E */  lw         $v1, 0x2C($s1)
    /* 703E0 8007FBE0 0800248E */  lw         $a0, 0x8($s1)
    /* 703E4 8007FBE4 0800428E */  lw         $v0, 0x8($s2)
    /* 703E8 8007FBE8 1000258E */  lw         $a1, 0x10($s1)
    /* 703EC 8007FBEC 23206400 */  subu       $a0, $v1, $a0
    /* 703F0 8007FBF0 CA90030C */  jal        fixedmult
    /* 703F4 8007FBF4 23284500 */   subu      $a1, $v0, $a1
    /* 703F8 8007FBF8 21804000 */  addu       $s0, $v0, $zero
    /* 703FC 8007FBFC 0000468E */  lw         $a2, 0x0($s2)
    /* 70400 8007FC00 0800248E */  lw         $a0, 0x8($s1)
    /* 70404 8007FC04 3400238E */  lw         $v1, 0x34($s1)
    /* 70408 8007FC08 1000258E */  lw         $a1, 0x10($s1)
    /* 7040C 8007FC0C 2320C400 */  subu       $a0, $a2, $a0
    /* 70410 8007FC10 CA90030C */  jal        fixedmult
    /* 70414 8007FC14 23286500 */   subu      $a1, $v1, $a1
    /* 70418 8007FC18 23800202 */  subu       $s0, $s0, $v0
    /* 7041C 8007FC1C 0100132A */  slti       $s3, $s0, 0x1
  .L8007FC20:
    /* 70420 8007FC20 04006012 */  beqz       $s3, .L8007FC34
    /* 70424 8007FC24 21100000 */   addu      $v0, $zero, $zero
    /* 70428 8007FC28 590020A2 */  sb         $zero, 0x59($s1)
    /* 7042C 8007FC2C 1DFF0108 */  j          .L8007FC74
    /* 70430 8007FC30 580020A2 */   sb        $zero, 0x58($s1)
  .L8007FC34:
    /* 70434 8007FC34 21204002 */  addu       $a0, $s2, $zero
    /* 70438 8007FC38 3EFE010C */  jal        FindClosestQuad__FP8coorddefP12BWorldSm_Pos
    /* 7043C 8007FC3C 21282002 */   addu      $a1, $s1, $zero
    /* 70440 8007FC40 1DFF0108 */  j          .L8007FC74
    /* 70444 8007FC44 00000000 */   nop
  .L8007FC48:
    /* 70448 8007FC48 21204002 */  addu       $a0, $s2, $zero
    /* 7044C 8007FC4C 21282002 */  addu       $a1, $s1, $zero
    /* 70450 8007FC50 01000224 */  addiu      $v0, $zero, 0x1
    /* 70454 8007FC54 7600A2A0 */  sb         $v0, 0x76($a1)
    /* 70458 8007FC58 7700A2A0 */  sb         $v0, 0x77($a1)
    /* 7045C 8007FC5C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 70460 8007FC60 8000A0AC */  sw         $zero, 0x80($a1)
    /* 70464 8007FC64 7800A0AC */  sw         $zero, 0x78($a1)
    /* 70468 8007FC68 7400A2A0 */  sb         $v0, 0x74($a1)
    /* 7046C 8007FC6C 85FA010C */  jal        BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
    /* 70470 8007FC70 5B00A0A0 */   sb        $zero, 0x5B($a1)
  .L8007FC74:
    /* 70474 8007FC74 2000BF8F */  lw         $ra, 0x20($sp)
    /* 70478 8007FC78 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 7047C 8007FC7C 1800B28F */  lw         $s2, 0x18($sp)
    /* 70480 8007FC80 1400B18F */  lw         $s1, 0x14($sp)
    /* 70484 8007FC84 1000B08F */  lw         $s0, 0x10($sp)
    /* 70488 8007FC88 0800E003 */  jr         $ra
    /* 7048C 8007FC8C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
