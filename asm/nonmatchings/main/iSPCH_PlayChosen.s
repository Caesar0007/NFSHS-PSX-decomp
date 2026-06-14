.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_PlayChosen, 0xA0

glabel iSPCH_PlayChosen
    /* F1EB4 801016B4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F1EB8 801016B8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* F1EBC 801016BC 1800B2AF */  sw         $s2, 0x18($sp)
    /* F1EC0 801016C0 1400B1AF */  sw         $s1, 0x14($sp)
    /* F1EC4 801016C4 A905040C */  jal        iSPCH_OneChosen
    /* F1EC8 801016C8 1000B0AF */   sw        $s0, 0x10($sp)
    /* F1ECC 801016CC 19004010 */  beqz       $v0, .L80101734
    /* F1ED0 801016D0 1580103C */   lui       $s0, %hi(gSentenceChoice)
    /* F1ED4 801016D4 3C841126 */  addiu      $s1, $s0, %lo(gSentenceChoice)
    /* F1ED8 801016D8 3C84048E */  lw         $a0, %lo(gSentenceChoice)($s0)
    /* F1EDC 801016DC 0800258E */  lw         $a1, 0x8($s1)
    /* F1EE0 801016E0 1000328E */  lw         $s2, 0x10($s1)
    /* F1EE4 801016E4 A52C040C */  jal        iSPCH_RuleSet
    /* F1EE8 801016E8 10002626 */   addiu     $a2, $s1, 0x10
    /* F1EEC 801016EC 3C84048E */  lw         $a0, %lo(gSentenceChoice)($s0)
    /* F1EF0 801016F0 0400258E */  lw         $a1, 0x4($s1)
    /* F1EF4 801016F4 EF04040C */  jal        iSPCH_ConstantRuleSet
    /* F1EF8 801016F8 00000000 */   nop
    /* F1EFC 801016FC 0400248E */  lw         $a0, 0x4($s1)
    /* F1F00 80101700 4205040C */  jal        iSPCH_MakeSampleRequests
    /* F1F04 80101704 21284002 */   addu      $a1, $s2, $zero
    /* F1F08 80101708 1580033C */  lui        $v1, %hi(gVoxInGame)
    /* F1F0C 8010170C 5880628C */  lw         $v0, %lo(gVoxInGame)($v1)
    /* F1F10 80101710 00000000 */  nop
    /* F1F14 80101714 04004216 */  bne        $s2, $v0, .L80101728
    /* F1F18 80101718 58806424 */   addiu     $a0, $v1, %lo(gVoxInGame)
    /* F1F1C 8010171C 0400828C */  lw         $v0, 0x4($a0)
    /* F1F20 80101720 CC050408 */  j          .L80101730
    /* F1F24 80101724 01004224 */   addiu     $v0, $v0, 0x1
  .L80101728:
    /* F1F28 80101728 01000224 */  addiu      $v0, $zero, 0x1
    /* F1F2C 8010172C 588072AC */  sw         $s2, %lo(gVoxInGame)($v1)
  .L80101730:
    /* F1F30 80101730 040082AC */  sw         $v0, 0x4($a0)
  .L80101734:
    /* F1F34 80101734 9405040C */  jal        iSPCH_ClearChosen
    /* F1F38 80101738 00000000 */   nop
    /* F1F3C 8010173C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* F1F40 80101740 1800B28F */  lw         $s2, 0x18($sp)
    /* F1F44 80101744 1400B18F */  lw         $s1, 0x14($sp)
    /* F1F48 80101748 1000B08F */  lw         $s0, 0x10($sp)
    /* F1F4C 8010174C 0800E003 */  jr         $ra
    /* F1F50 80101750 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSPCH_PlayChosen
