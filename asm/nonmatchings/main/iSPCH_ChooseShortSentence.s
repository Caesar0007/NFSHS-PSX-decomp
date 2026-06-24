.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_ChooseShortSentence, 0xB4

glabel iSPCH_ChooseShortSentence
    /* F1A5C 8010125C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F1A60 80101260 1800B2AF */  sw         $s2, 0x18($sp)
    /* F1A64 80101264 21908000 */  addu       $s2, $a0, $zero
    /* F1A68 80101268 1000B0AF */  sw         $s0, 0x10($sp)
    /* F1A6C 8010126C 21800000 */  addu       $s0, $zero, $zero
    /* F1A70 80101270 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* F1A74 80101274 CC01040C */  jal        VoxSentence_GetNumPhrases
    /* F1A78 80101278 1400B1AF */   sw        $s1, 0x14($sp)
    /* F1A7C 8010127C 21200002 */  addu       $a0, $s0, $zero
    /* F1A80 80101280 21284000 */  addu       $a1, $v0, $zero
    /* F1A84 80101284 1800A018 */  blez       $a1, .L801012E8
    /* F1A88 80101288 21880002 */   addu      $s1, $s0, $zero
    /* F1A8C 8010128C 1580023C */  lui        $v0, %hi(ispch_gChoice)
    /* F1A90 80101290 E4844324 */  addiu      $v1, $v0, %lo(ispch_gChoice)
  .L80101294:
    /* F1A94 80101294 06006294 */  lhu        $v0, 0x6($v1)
    /* F1A98 80101298 01008424 */  addiu      $a0, $a0, 0x1
    /* F1A9C 8010129C 080062A4 */  sh         $v0, 0x8($v1)
    /* F1AA0 801012A0 2A108500 */  slt        $v0, $a0, $a1
    /* F1AA4 801012A4 FBFF4014 */  bnez       $v0, .L80101294
    /* F1AA8 801012A8 0C006324 */   addiu     $v1, $v1, 0xC
    /* F1AAC 801012AC BA040408 */  j          .L801012E8
    /* F1AB0 801012B0 00000000 */   nop
  .L801012B4:
    /* F1AB4 801012B4 4803040C */  jal        iSPCH_SentenceLength
    /* F1AB8 801012B8 21204002 */   addu      $a0, $s2, $zero
    /* F1ABC 801012BC F99B030C */  jal        GetFilterLength
    /* F1AC0 801012C0 21804000 */   addu      $s0, $v0, $zero
    /* F1AC4 801012C4 2A800202 */  slt        $s0, $s0, $v0
    /* F1AC8 801012C8 04000012 */  beqz       $s0, .L801012DC
    /* F1ACC 801012CC 00000000 */   nop
    /* F1AD0 801012D0 01001124 */  addiu      $s1, $zero, 0x1
    /* F1AD4 801012D4 BA040408 */  j          .L801012E8
    /* F1AD8 801012D8 21802002 */   addu      $s0, $s1, $zero
  .L801012DC:
    /* F1ADC 801012DC 6B04040C */  jal        iSPCH_IterateChoice
    /* F1AE0 801012E0 21204002 */   addu      $a0, $s2, $zero
    /* F1AE4 801012E4 21804000 */  addu       $s0, $v0, $zero
  .L801012E8:
    /* F1AE8 801012E8 03000016 */  bnez       $s0, .L801012F8
    /* F1AEC 801012EC 21102002 */   addu      $v0, $s1, $zero
    /* F1AF0 801012F0 F0FF2012 */  beqz       $s1, .L801012B4
    /* F1AF4 801012F4 00000000 */   nop
  .L801012F8:
    /* F1AF8 801012F8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* F1AFC 801012FC 1800B28F */  lw         $s2, 0x18($sp)
    /* F1B00 80101300 1400B18F */  lw         $s1, 0x14($sp)
    /* F1B04 80101304 1000B08F */  lw         $s0, 0x10($sp)
    /* F1B08 80101308 0800E003 */  jr         $ra
    /* F1B0C 8010130C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSPCH_ChooseShortSentence
