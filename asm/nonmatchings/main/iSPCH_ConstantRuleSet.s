.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_ConstantRuleSet, 0x14C

glabel iSPCH_ConstantRuleSet
    /* F1BBC 801013BC 1380023C */  lui        $v0, %hi(gSentenceRuleSet)
    /* F1BC0 801013C0 9C70428C */  lw         $v0, %lo(gSentenceRuleSet)($v0)
    /* F1BC4 801013C4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* F1BC8 801013C8 3800B6AF */  sw         $s6, 0x38($sp)
    /* F1BCC 801013CC 21B08000 */  addu       $s6, $a0, $zero
    /* F1BD0 801013D0 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* F1BD4 801013D4 21B8A000 */  addu       $s7, $a1, $zero
    /* F1BD8 801013D8 4400BFAF */  sw         $ra, 0x44($sp)
    /* F1BDC 801013DC 4000BEAF */  sw         $fp, 0x40($sp)
    /* F1BE0 801013E0 3400B5AF */  sw         $s5, 0x34($sp)
    /* F1BE4 801013E4 3000B4AF */  sw         $s4, 0x30($sp)
    /* F1BE8 801013E8 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* F1BEC 801013EC 2800B2AF */  sw         $s2, 0x28($sp)
    /* F1BF0 801013F0 2400B1AF */  sw         $s1, 0x24($sp)
    /* F1BF4 801013F4 38004010 */  beqz       $v0, .L801014D8
    /* F1BF8 801013F8 2000B0AF */   sw        $s0, 0x20($sp)
    /* F1BFC 801013FC CC01040C */  jal        func_80100730
    /* F1C00 80101400 2120E002 */   addu      $a0, $s7, $zero
    /* F1C04 80101404 21A84000 */  addu       $s5, $v0, $zero
    /* F1C08 80101408 3300A01A */  blez       $s5, .L801014D8
    /* F1C0C 8010140C 21980000 */   addu      $s3, $zero, $zero
    /* F1C10 80101410 1580023C */  lui        $v0, %hi(ispch_gPickSamples)
    /* F1C14 80101414 7C845E24 */  addiu      $fp, $v0, %lo(ispch_gPickSamples)
    /* F1C18 80101418 1580023C */  lui        $v0, %hi(ispch_gChoice)
    /* F1C1C 8010141C E4845224 */  addiu      $s2, $v0, %lo(ispch_gChoice)
  .L80101420:
    /* F1C20 80101420 2120E002 */  addu       $a0, $s7, $zero
    /* F1C24 80101424 0400E526 */  addiu      $a1, $s7, 0x4
    /* F1C28 80101428 D201040C */  jal        func_80100748
    /* F1C2C 8010142C 21306002 */   addu      $a2, $s3, $zero
    /* F1C30 80101430 21A04000 */  addu       $s4, $v0, $zero
    /* F1C34 80101434 21880000 */  addu       $s1, $zero, $zero
    /* F1C38 80101438 21109102 */  addu       $v0, $s4, $s1
  .L8010143C:
    /* F1C3C 8010143C 04004290 */  lbu        $v0, 0x4($v0)
    /* F1C40 80101440 00000000 */  nop
    /* F1C44 80101444 02290200 */  srl        $a1, $v0, 4
    /* F1C48 80101448 0F000224 */  addiu      $v0, $zero, 0xF
    /* F1C4C 8010144C 1A00A210 */  beq        $a1, $v0, .L801014B8
    /* F1C50 80101450 00000000 */   nop
    /* F1C54 80101454 882C040C */  jal        iSPCH_GetRuleID
    /* F1C58 80101458 2120C002 */   addu      $a0, $s6, $zero
    /* F1C5C 8010145C 1000A627 */  addiu      $a2, $sp, 0x10
    /* F1C60 80101460 1380043C */  lui        $a0, %hi(gVoxBanks)
    /* F1C64 80101464 00004386 */  lh         $v1, 0x0($s2)
    /* F1C68 80101468 B470848C */  lw         $a0, %lo(gVoxBanks)($a0)
    /* F1C6C 8010146C 08004586 */  lh         $a1, 0x8($s2)
    /* F1C70 80101470 80180300 */  sll        $v1, $v1, 2
    /* F1C74 80101474 21186400 */  addu       $v1, $v1, $a0
    /* F1C78 80101478 2128BE00 */  addu       $a1, $a1, $fp
    /* F1C7C 8010147C 0000648C */  lw         $a0, 0x0($v1)
    /* F1C80 80101480 0000A590 */  lbu        $a1, 0x0($a1)
    /* F1C84 80101484 752D040C */  jal        iSPCH_UnPackSample
    /* F1C88 80101488 21804000 */   addu      $s0, $v0, $zero
    /* F1C8C 8010148C 0A004010 */  beqz       $v0, .L801014B8
    /* F1C90 80101490 21280002 */   addu      $a1, $s0, $zero
    /* F1C94 80101494 2118B103 */  addu       $v1, $sp, $s1
    /* F1C98 80101498 01000724 */  addiu      $a3, $zero, 0x1
    /* F1C9C 8010149C 1380023C */  lui        $v0, %hi(gSentenceRuleSet)
    /* F1CA0 801014A0 0000C496 */  lhu        $a0, 0x0($s6)
    /* F1CA4 801014A4 1C006690 */  lbu        $a2, 0x1C($v1)
    /* F1CA8 801014A8 9C70428C */  lw         $v0, %lo(gSentenceRuleSet)($v0)
    /* F1CAC 801014AC 00000000 */  nop
    /* F1CB0 801014B0 09F84000 */  jalr       $v0
    /* F1CB4 801014B4 0430C700 */   sllv      $a2, $a3, $a2
  .L801014B8:
    /* F1CB8 801014B8 01003126 */  addiu      $s1, $s1, 0x1
    /* F1CBC 801014BC 0400222A */  slti       $v0, $s1, 0x4
    /* F1CC0 801014C0 DEFF4014 */  bnez       $v0, .L8010143C
    /* F1CC4 801014C4 21109102 */   addu      $v0, $s4, $s1
    /* F1CC8 801014C8 01007326 */  addiu      $s3, $s3, 0x1
    /* F1CCC 801014CC 2A107502 */  slt        $v0, $s3, $s5
    /* F1CD0 801014D0 D3FF4014 */  bnez       $v0, .L80101420
    /* F1CD4 801014D4 0C005226 */   addiu     $s2, $s2, 0xC
  .L801014D8:
    /* F1CD8 801014D8 4400BF8F */  lw         $ra, 0x44($sp)
    /* F1CDC 801014DC 4000BE8F */  lw         $fp, 0x40($sp)
    /* F1CE0 801014E0 3C00B78F */  lw         $s7, 0x3C($sp)
    /* F1CE4 801014E4 3800B68F */  lw         $s6, 0x38($sp)
    /* F1CE8 801014E8 3400B58F */  lw         $s5, 0x34($sp)
    /* F1CEC 801014EC 3000B48F */  lw         $s4, 0x30($sp)
    /* F1CF0 801014F0 2C00B38F */  lw         $s3, 0x2C($sp)
    /* F1CF4 801014F4 2800B28F */  lw         $s2, 0x28($sp)
    /* F1CF8 801014F8 2400B18F */  lw         $s1, 0x24($sp)
    /* F1CFC 801014FC 2000B08F */  lw         $s0, 0x20($sp)
    /* F1D00 80101500 0800E003 */  jr         $ra
    /* F1D04 80101504 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel iSPCH_ConstantRuleSet
