.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_SentenceMakeChoice, 0xAC

glabel iSPCH_SentenceMakeChoice
    /* F1B10 80101310 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F1B14 80101314 1000B0AF */  sw         $s0, 0x10($sp)
    /* F1B18 80101318 21808000 */  addu       $s0, $a0, $zero
    /* F1B1C 8010131C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F1B20 80101320 21980000 */  addu       $s3, $zero, $zero
    /* F1B24 80101324 01000224 */  addiu      $v0, $zero, 0x1
    /* F1B28 80101328 2000BFAF */  sw         $ra, 0x20($sp)
    /* F1B2C 8010132C 1800B2AF */  sw         $s2, 0x18($sp)
    /* F1B30 80101330 0700A214 */  bne        $a1, $v0, .L80101350
    /* F1B34 80101334 1400B1AF */   sw        $s1, 0x14($sp)
    /* F1B38 80101338 3304040C */  jal        iSPCH_RandomizeSentencePicks
    /* F1B3C 8010133C 00000000 */   nop
    /* F1B40 80101340 9704040C */  jal        iSPCH_ChooseShortSentence
    /* F1B44 80101344 21200002 */   addu      $a0, $s0, $zero
    /* F1B48 80101348 E7040408 */  j          .L8010139C
    /* F1B4C 8010134C 21984000 */   addu      $s3, $v0, $zero
  .L80101350:
    /* F1B50 80101350 CC01040C */  jal        VoxSentence_GetNumPhrases
    /* F1B54 80101354 21200002 */   addu      $a0, $s0, $zero
    /* F1B58 80101358 21904000 */  addu       $s2, $v0, $zero
    /* F1B5C 8010135C 2A107202 */  slt        $v0, $s3, $s2
    /* F1B60 80101360 0E004010 */  beqz       $v0, .L8010139C
    /* F1B64 80101364 21880000 */   addu      $s1, $zero, $zero
    /* F1B68 80101368 01001324 */  addiu      $s3, $zero, 0x1
    /* F1B6C 8010136C 1580023C */  lui        $v0, %hi(ispch_gChoice)
    /* F1B70 80101370 E4845024 */  addiu      $s0, $v0, %lo(ispch_gChoice)
  .L80101374:
    /* F1B74 80101374 04000486 */  lh         $a0, 0x4($s0)
    /* F1B78 80101378 CCAE030C */  jal        iSPCH_Rand
    /* F1B7C 8010137C 01003126 */   addiu     $s1, $s1, 0x1
    /* F1B80 80101380 06000396 */  lhu        $v1, 0x6($s0)
    /* F1B84 80101384 00000000 */  nop
    /* F1B88 80101388 21186200 */  addu       $v1, $v1, $v0
    /* F1B8C 8010138C 080003A6 */  sh         $v1, 0x8($s0)
    /* F1B90 80101390 2A103202 */  slt        $v0, $s1, $s2
    /* F1B94 80101394 F7FF4014 */  bnez       $v0, .L80101374
    /* F1B98 80101398 0C001026 */   addiu     $s0, $s0, 0xC
  .L8010139C:
    /* F1B9C 8010139C 21106002 */  addu       $v0, $s3, $zero
    /* F1BA0 801013A0 2000BF8F */  lw         $ra, 0x20($sp)
    /* F1BA4 801013A4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F1BA8 801013A8 1800B28F */  lw         $s2, 0x18($sp)
    /* F1BAC 801013AC 1400B18F */  lw         $s1, 0x14($sp)
    /* F1BB0 801013B0 1000B08F */  lw         $s0, 0x10($sp)
    /* F1BB4 801013B4 0800E003 */  jr         $ra
    /* F1BB8 801013B8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSPCH_SentenceMakeChoice
