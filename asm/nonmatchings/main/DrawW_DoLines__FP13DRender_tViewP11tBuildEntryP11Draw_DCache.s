.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache, 0x31C

glabel DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache
    /* BAA04 800CA204 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* BAA08 800CA208 4000B0AF */  sw         $s0, 0x40($sp)
    /* BAA0C 800CA20C 21808000 */  addu       $s0, $a0, $zero
    /* BAA10 800CA210 4800B2AF */  sw         $s2, 0x48($sp)
    /* BAA14 800CA214 2190C000 */  addu       $s2, $a2, $zero
    /* BAA18 800CA218 1480083C */  lui        $t0, %hi(BWorld_gChunkCount)
    /* BAA1C 800CA21C A8C7088D */  lw         $t0, %lo(BWorld_gChunkCount)($t0)
    /* BAA20 800CA220 14004226 */  addiu      $v0, $s2, 0x14
    /* BAA24 800CA224 6400BFAF */  sw         $ra, 0x64($sp)
    /* BAA28 800CA228 6000BEAF */  sw         $fp, 0x60($sp)
    /* BAA2C 800CA22C 5C00B7AF */  sw         $s7, 0x5C($sp)
    /* BAA30 800CA230 5800B6AF */  sw         $s6, 0x58($sp)
    /* BAA34 800CA234 5400B5AF */  sw         $s5, 0x54($sp)
    /* BAA38 800CA238 5000B4AF */  sw         $s4, 0x50($sp)
    /* BAA3C 800CA23C 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* BAA40 800CA240 4400B1AF */  sw         $s1, 0x44($sp)
    /* BAA44 800CA244 DA0040A6 */  sh         $zero, 0xDA($s2)
    /* BAA48 800CA248 1C0040AC */  sw         $zero, 0x1C($v0)
    /* BAA4C 800CA24C 180040AC */  sw         $zero, 0x18($v0)
    /* BAA50 800CA250 280040AE */  sw         $zero, 0x28($s2)
    /* BAA54 800CA254 3800A8AF */  sw         $t0, 0x38($sp)
    /* BAA58 800CA258 14004C8C */  lw         $t4, 0x14($v0)
    /* BAA5C 800CA25C 18004D8C */  lw         $t5, 0x18($v0)
    /* BAA60 800CA260 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BAA64 800CA264 1C004E8C */  lw         $t6, 0x1C($v0)
    /* BAA68 800CA268 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BAA6C 800CA26C 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* BAA70 800CA270 21B00000 */  addu       $s6, $zero, $zero
    /* BAA74 800CA274 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* BAA78 800CA278 ACF25E24 */  addiu      $fp, $v0, %lo(Camera_gInfo)
    /* BAA7C 800CA27C 1800B727 */  addiu      $s7, $sp, 0x18
    /* BAA80 800CA280 2800B327 */  addiu      $s3, $sp, 0x28
    /* BAA84 800CA284 2188A000 */  addu       $s1, $a1, $zero
  .L800CA288:
    /* BAA88 800CA288 3800A88F */  lw         $t0, 0x38($sp)
    /* BAA8C 800CA28C 00000000 */  nop
    /* BAA90 800CA290 2A10C802 */  slt        $v0, $s6, $t0
    /* BAA94 800CA294 96004010 */  beqz       $v0, .L800CA4F0
    /* BAA98 800CA298 04000224 */   addiu     $v0, $zero, 0x4
    /* BAA9C 800CA29C 02002382 */  lb         $v1, 0x2($s1)
    /* BAAA0 800CA2A0 00000000 */  nop
    /* BAAA4 800CA2A4 8F006214 */  bne        $v1, $v0, .L800CA4E4
    /* BAAA8 800CA2A8 00000000 */   nop
    /* BAAAC 800CA2AC 00002286 */  lh         $v0, 0x0($s1)
    /* BAAB0 800CA2B0 00000000 */  nop
    /* BAAB4 800CA2B4 C0180200 */  sll        $v1, $v0, 3
    /* BAAB8 800CA2B8 23186200 */  subu       $v1, $v1, $v0
    /* BAABC 800CA2BC 1480023C */  lui        $v0, %hi(Track_chunkList)
    /* BAAC0 800CA2C0 B8D4428C */  lw         $v0, %lo(Track_chunkList)($v0)
    /* BAAC4 800CA2C4 00190300 */  sll        $v1, $v1, 4
    /* BAAC8 800CA2C8 21A04300 */  addu       $s4, $v0, $v1
    /* BAACC 800CA2CC 5800958E */  lw         $s5, 0x58($s4)
    /* BAAD0 800CA2D0 00000000 */  nop
    /* BAAD4 800CA2D4 8300A012 */  beqz       $s5, .L800CA4E4
    /* BAAD8 800CA2D8 00000000 */   nop
    /* BAADC 800CA2DC 03002292 */  lbu        $v0, 0x3($s1)
    /* BAAE0 800CA2E0 00000000 */  nop
    /* BAAE4 800CA2E4 04004230 */  andi       $v0, $v0, 0x4
    /* BAAE8 800CA2E8 7E004010 */  beqz       $v0, .L800CA4E4
    /* BAAEC 800CA2EC 00000000 */   nop
    /* BAAF0 800CA2F0 1480023C */  lui        $v0, %hi(gNight_renderNight)
    /* BAAF4 800CA2F4 28DA428C */  lw         $v0, %lo(gNight_renderNight)($v0)
    /* BAAF8 800CA2F8 00000000 */  nop
    /* BAAFC 800CA2FC 5E004010 */  beqz       $v0, .L800CA478
    /* BAB00 800CA300 1180083C */   lui       $t0, %hi(Cars_gList)
    /* BAB04 800CA304 06014392 */  lbu        $v1, 0x106($s2)
    /* BAB08 800CA308 00000000 */  nop
    /* BAB0C 800CA30C 04006234 */  ori        $v0, $v1, 0x4
    /* BAB10 800CA310 060142A2 */  sb         $v0, 0x106($s2)
    /* BAB14 800CA314 0400028E */  lw         $v0, 0x4($s0)
    /* BAB18 800CA318 DCF90825 */  addiu      $t0, $t0, %lo(Cars_gList)
    /* BAB1C 800CA31C 80100200 */  sll        $v0, $v0, 2
    /* BAB20 800CA320 21104800 */  addu       $v0, $v0, $t0
    /* BAB24 800CA324 0000428C */  lw         $v0, 0x0($v0)
    /* BAB28 800CA328 00000000 */  nop
    /* BAB2C 800CA32C 47044290 */  lbu        $v0, 0x447($v0)
    /* BAB30 800CA330 00000000 */  nop
    /* BAB34 800CA334 06004230 */  andi       $v0, $v0, 0x6
    /* BAB38 800CA338 02004010 */  beqz       $v0, .L800CA344
    /* BAB3C 800CA33C 05006234 */   ori       $v0, $v1, 0x5
    /* BAB40 800CA340 060142A2 */  sb         $v0, 0x106($s2)
  .L800CA344:
    /* BAB44 800CA344 0400038E */  lw         $v1, 0x4($s0)
    /* BAB48 800CA348 00000000 */  nop
    /* BAB4C 800CA34C 00110300 */  sll        $v0, $v1, 4
    /* BAB50 800CA350 21104300 */  addu       $v0, $v0, $v1
    /* BAB54 800CA354 00110200 */  sll        $v0, $v0, 4
    /* BAB58 800CA358 21105E00 */  addu       $v0, $v0, $fp
    /* BAB5C 800CA35C 0400428C */  lw         $v0, 0x4($v0)
    /* BAB60 800CA360 00000000 */  nop
    /* BAB64 800CA364 A000438C */  lw         $v1, 0xA0($v0)
    /* BAB68 800CA368 0800028E */  lw         $v0, 0x8($s0)
    /* BAB6C 800CA36C 00000000 */  nop
    /* BAB70 800CA370 23104300 */  subu       $v0, $v0, $v1
    /* BAB74 800CA374 1800A2AF */  sw         $v0, 0x18($sp)
    /* BAB78 800CA378 0400038E */  lw         $v1, 0x4($s0)
    /* BAB7C 800CA37C 00000000 */  nop
    /* BAB80 800CA380 00110300 */  sll        $v0, $v1, 4
    /* BAB84 800CA384 21104300 */  addu       $v0, $v0, $v1
    /* BAB88 800CA388 00110200 */  sll        $v0, $v0, 4
    /* BAB8C 800CA38C 21105E00 */  addu       $v0, $v0, $fp
    /* BAB90 800CA390 0400428C */  lw         $v0, 0x4($v0)
    /* BAB94 800CA394 00000000 */  nop
    /* BAB98 800CA398 A400438C */  lw         $v1, 0xA4($v0)
    /* BAB9C 800CA39C 0C00028E */  lw         $v0, 0xC($s0)
    /* BABA0 800CA3A0 2120E002 */  addu       $a0, $s7, $zero
    /* BABA4 800CA3A4 23104300 */  subu       $v0, $v0, $v1
    /* BABA8 800CA3A8 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* BABAC 800CA3AC 0400038E */  lw         $v1, 0x4($s0)
    /* BABB0 800CA3B0 1180053C */  lui        $a1, %hi(gNightMat)
    /* BABB4 800CA3B4 00110300 */  sll        $v0, $v1, 4
    /* BABB8 800CA3B8 21104300 */  addu       $v0, $v0, $v1
    /* BABBC 800CA3BC 00110200 */  sll        $v0, $v0, 4
    /* BABC0 800CA3C0 21105E00 */  addu       $v0, $v0, $fp
    /* BABC4 800CA3C4 0400428C */  lw         $v0, 0x4($v0)
    /* BABC8 800CA3C8 64EEA524 */  addiu      $a1, $a1, %lo(gNightMat)
    /* BABCC 800CA3CC A800438C */  lw         $v1, 0xA8($v0)
    /* BABD0 800CA3D0 1000028E */  lw         $v0, 0x10($s0)
    /* BABD4 800CA3D4 21306002 */  addu       $a2, $s3, $zero
    /* BABD8 800CA3D8 23104300 */  subu       $v0, $v0, $v1
    /* BABDC 800CA3DC B6AB030C */  jal        transform
    /* BABE0 800CA3E0 2000A2AF */   sw        $v0, 0x20($sp)
    /* BABE4 800CA3E4 21206002 */  addu       $a0, $s3, $zero
    /* BABE8 800CA3E8 761D030C */  jal        DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* BABEC 800CA3EC 34004526 */   addiu     $a1, $s2, 0x34
    /* BABF0 800CA3F0 1480063C */  lui        $a2, %hi(BW_gCopCarObj)
    /* BABF4 800CA3F4 B4C7C68C */  lw         $a2, %lo(BW_gCopCarObj)($a2)
    /* BABF8 800CA3F8 00000000 */  nop
    /* BABFC 800CA3FC 1400C010 */  beqz       $a2, .L800CA450
    /* BAC00 800CA400 2120E002 */   addu      $a0, $s7, $zero
    /* BAC04 800CA404 A000C38C */  lw         $v1, 0xA0($a2)
    /* BAC08 800CA408 0800028E */  lw         $v0, 0x8($s0)
    /* BAC0C 800CA40C 1180053C */  lui        $a1, %hi(gCopMat)
    /* BAC10 800CA410 23104300 */  subu       $v0, $v0, $v1
    /* BAC14 800CA414 1800A2AF */  sw         $v0, 0x18($sp)
    /* BAC18 800CA418 A400C38C */  lw         $v1, 0xA4($a2)
    /* BAC1C 800CA41C 0C00028E */  lw         $v0, 0xC($s0)
    /* BAC20 800CA420 88EEA524 */  addiu      $a1, $a1, %lo(gCopMat)
    /* BAC24 800CA424 23104300 */  subu       $v0, $v0, $v1
    /* BAC28 800CA428 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* BAC2C 800CA42C A800C38C */  lw         $v1, 0xA8($a2)
    /* BAC30 800CA430 1000028E */  lw         $v0, 0x10($s0)
    /* BAC34 800CA434 21306002 */  addu       $a2, $s3, $zero
    /* BAC38 800CA438 23104300 */  subu       $v0, $v0, $v1
    /* BAC3C 800CA43C B6AB030C */  jal        transform
    /* BAC40 800CA440 2000A2AF */   sw        $v0, 0x20($sp)
    /* BAC44 800CA444 21206002 */  addu       $a0, $s3, $zero
    /* BAC48 800CA448 761D030C */  jal        DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* BAC4C 800CA44C 54004526 */   addiu     $a1, $s2, 0x54
  .L800CA450:
    /* BAC50 800CA450 14004226 */  addiu      $v0, $s2, 0x14
    /* BAC54 800CA454 1C0040AC */  sw         $zero, 0x1C($v0)
    /* BAC58 800CA458 180040AC */  sw         $zero, 0x18($v0)
    /* BAC5C 800CA45C 280040AE */  sw         $zero, 0x28($s2)
    /* BAC60 800CA460 14004C8C */  lw         $t4, 0x14($v0)
    /* BAC64 800CA464 18004D8C */  lw         $t5, 0x18($v0)
    /* BAC68 800CA468 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BAC6C 800CA46C 1C004E8C */  lw         $t6, 0x1C($v0)
    /* BAC70 800CA470 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BAC74 800CA474 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
  .L800CA478:
    /* BAC78 800CA478 21208002 */  addu       $a0, $s4, $zero
    /* BAC7C 800CA47C 00002386 */  lh         $v1, 0x0($s1)
    /* BAC80 800CA480 1480063C */  lui        $a2, %hi(Chunk_chunkCenters)
    /* BAC84 800CA484 1CC8C68C */  lw         $a2, %lo(Chunk_chunkCenters)($a2)
    /* BAC88 800CA488 40100300 */  sll        $v0, $v1, 1
    /* BAC8C 800CA48C 21104300 */  addu       $v0, $v0, $v1
    /* BAC90 800CA490 80100200 */  sll        $v0, $v0, 2
    /* BAC94 800CA494 2130C200 */  addu       $a2, $a2, $v0
    /* BAC98 800CA498 0800038E */  lw         $v1, 0x8($s0)
    /* BAC9C 800CA49C 0000C28C */  lw         $v0, 0x0($a2)
    /* BACA0 800CA4A0 2128A002 */  addu       $a1, $s5, $zero
    /* BACA4 800CA4A4 23104300 */  subu       $v0, $v0, $v1
    /* BACA8 800CA4A8 83120200 */  sra        $v0, $v0, 10
    /* BACAC 800CA4AC 1000A2A7 */  sh         $v0, 0x10($sp)
    /* BACB0 800CA4B0 0C00038E */  lw         $v1, 0xC($s0)
    /* BACB4 800CA4B4 0400C28C */  lw         $v0, 0x4($a2)
    /* BACB8 800CA4B8 1000A727 */  addiu      $a3, $sp, 0x10
    /* BACBC 800CA4BC 23104300 */  subu       $v0, $v0, $v1
    /* BACC0 800CA4C0 83120200 */  sra        $v0, $v0, 10
    /* BACC4 800CA4C4 1200A2A7 */  sh         $v0, 0x12($sp)
    /* BACC8 800CA4C8 1000038E */  lw         $v1, 0x10($s0)
    /* BACCC 800CA4CC 0800C28C */  lw         $v0, 0x8($a2)
    /* BACD0 800CA4D0 21304002 */  addu       $a2, $s2, $zero
    /* BACD4 800CA4D4 23104300 */  subu       $v0, $v0, $v1
    /* BACD8 800CA4D8 83120200 */  sra        $v0, $v0, 10
    /* BACDC 800CA4DC 2928030C */  jal        DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16
    /* BACE0 800CA4E0 1400A2A7 */   sh        $v0, 0x14($sp)
  .L800CA4E4:
    /* BACE4 800CA4E4 04003126 */  addiu      $s1, $s1, 0x4
    /* BACE8 800CA4E8 A2280308 */  j          .L800CA288
    /* BACEC 800CA4EC 0100D626 */   addiu     $s6, $s6, 0x1
  .L800CA4F0:
    /* BACF0 800CA4F0 6400BF8F */  lw         $ra, 0x64($sp)
    /* BACF4 800CA4F4 6000BE8F */  lw         $fp, 0x60($sp)
    /* BACF8 800CA4F8 5C00B78F */  lw         $s7, 0x5C($sp)
    /* BACFC 800CA4FC 5800B68F */  lw         $s6, 0x58($sp)
    /* BAD00 800CA500 5400B58F */  lw         $s5, 0x54($sp)
    /* BAD04 800CA504 5000B48F */  lw         $s4, 0x50($sp)
    /* BAD08 800CA508 4C00B38F */  lw         $s3, 0x4C($sp)
    /* BAD0C 800CA50C 4800B28F */  lw         $s2, 0x48($sp)
    /* BAD10 800CA510 4400B18F */  lw         $s1, 0x44($sp)
    /* BAD14 800CA514 4000B08F */  lw         $s0, 0x40($sp)
    /* BAD18 800CA518 0800E003 */  jr         $ra
    /* BAD1C 800CA51C 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache
