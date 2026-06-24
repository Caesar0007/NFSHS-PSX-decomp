.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_MakeSampleRequests, 0x148

glabel iSPCH_MakeSampleRequests
    /* F1D08 80101508 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* F1D0C 8010150C 4000BEAF */  sw         $fp, 0x40($sp)
    /* F1D10 80101510 21F0A000 */  addu       $fp, $a1, $zero
    /* F1D14 80101514 3000B4AF */  sw         $s4, 0x30($sp)
    /* F1D18 80101518 21A00000 */  addu       $s4, $zero, $zero
    /* F1D1C 8010151C 4400BFAF */  sw         $ra, 0x44($sp)
    /* F1D20 80101520 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* F1D24 80101524 3800B6AF */  sw         $s6, 0x38($sp)
    /* F1D28 80101528 3400B5AF */  sw         $s5, 0x34($sp)
    /* F1D2C 8010152C 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* F1D30 80101530 2800B2AF */  sw         $s2, 0x28($sp)
    /* F1D34 80101534 2400B1AF */  sw         $s1, 0x24($sp)
    /* F1D38 80101538 CC01040C */  jal        VoxSentence_GetNumPhrases
    /* F1D3C 8010153C 2000B0AF */   sw        $s0, 0x20($sp)
    /* F1D40 80101540 21A84000 */  addu       $s5, $v0, $zero
    /* F1D44 80101544 3400A01A */  blez       $s5, .L80101618
    /* F1D48 80101548 21988002 */   addu      $s3, $s4, $zero
    /* F1D4C 8010154C 1580023C */  lui        $v0, %hi(ispch_gPickSamples)
    /* F1D50 80101550 7C845724 */  addiu      $s7, $v0, %lo(ispch_gPickSamples)
    /* F1D54 80101554 1380163C */  lui        $s6, %hi(gSampleRequest)
    /* F1D58 80101558 1580023C */  lui        $v0, %hi(ispch_gChoice)
    /* F1D5C 8010155C E4845224 */  addiu      $s2, $v0, %lo(ispch_gChoice)
  .L80101560:
    /* F1D60 80101560 1380033C */  lui        $v1, %hi(gVoxBanks)
    /* F1D64 80101564 00004286 */  lh         $v0, 0x0($s2)
    /* F1D68 80101568 B470638C */  lw         $v1, %lo(gVoxBanks)($v1)
    /* F1D6C 8010156C 80100200 */  sll        $v0, $v0, 2
    /* F1D70 80101570 21104300 */  addu       $v0, $v0, $v1
    /* F1D74 80101574 0000508C */  lw         $s0, 0x0($v0)
    /* F1D78 80101578 08004286 */  lh         $v0, 0x8($s2)
    /* F1D7C 8010157C 00000000 */  nop
    /* F1D80 80101580 21105700 */  addu       $v0, $v0, $s7
    /* F1D84 80101584 02000392 */  lbu        $v1, 0x2($s0)
    /* F1D88 80101588 00005190 */  lbu        $s1, 0x0($v0)
    /* F1D8C 8010158C F0006330 */  andi       $v1, $v1, 0xF0
    /* F1D90 80101590 07006010 */  beqz       $v1, .L801015B0
    /* F1D94 80101594 1380023C */   lui       $v0, %hi(gClearCycle)
    /* F1D98 80101598 BC70428C */  lw         $v0, %lo(gClearCycle)($v0)
    /* F1D9C 8010159C 00000000 */  nop
    /* F1DA0 801015A0 03004010 */  beqz       $v0, .L801015B0
    /* F1DA4 801015A4 21200002 */   addu      $a0, $s0, $zero
    /* F1DA8 801015A8 6E02040C */  jal        iSPCH_ClearCycleBit
    /* F1DAC 801015AC 21282002 */   addu      $a1, $s1, $zero
  .L801015B0:
    /* F1DB0 801015B0 21200002 */  addu       $a0, $s0, $zero
    /* F1DB4 801015B4 21282002 */  addu       $a1, $s1, $zero
    /* F1DB8 801015B8 752D040C */  jal        iSPCH_UnPackSample
    /* F1DBC 801015BC 1000A627 */   addiu     $a2, $sp, 0x10
    /* F1DC0 801015C0 11004010 */  beqz       $v0, .L80101608
    /* F1DC4 801015C4 00000000 */   nop
    /* F1DC8 801015C8 04000296 */  lhu        $v0, 0x4($s0)
    /* F1DCC 801015CC 1400A58F */  lw         $a1, 0x14($sp)
    /* F1DD0 801015D0 02004386 */  lh         $v1, 0x2($s2)
    /* F1DD4 801015D4 00220200 */  sll        $a0, $v0, 8
    /* F1DD8 801015D8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* F1DDC 801015DC 03006210 */  beq        $v1, $v0, .L801015EC
    /* F1DE0 801015E0 18006400 */   mult      $v1, $a0
    /* F1DE4 801015E4 12400000 */  mflo       $t0
    /* F1DE8 801015E8 2128A800 */  addu       $a1, $a1, $t0
  .L801015EC:
    /* F1DEC 801015EC 2138C003 */  addu       $a3, $fp, $zero
    /* F1DF0 801015F0 1000A68F */  lw         $a2, 0x10($sp)
    /* F1DF4 801015F4 00004486 */  lh         $a0, 0x0($s2)
    /* F1DF8 801015F8 9470C28E */  lw         $v0, %lo(gSampleRequest)($s6)
    /* F1DFC 801015FC 00000000 */  nop
    /* F1E00 80101600 09F84000 */  jalr       $v0
    /* F1E04 80101604 21A08602 */   addu      $s4, $s4, $a2
  .L80101608:
    /* F1E08 80101608 01007326 */  addiu      $s3, $s3, 0x1
    /* F1E0C 8010160C 2A107502 */  slt        $v0, $s3, $s5
    /* F1E10 80101610 D3FF4014 */  bnez       $v0, .L80101560
    /* F1E14 80101614 0C005226 */   addiu     $s2, $s2, 0xC
  .L80101618:
    /* F1E18 80101618 3103040C */  jal        iSPCH_ConvertTime
    /* F1E1C 8010161C 21208002 */   addu      $a0, $s4, $zero
    /* F1E20 80101620 4400BF8F */  lw         $ra, 0x44($sp)
    /* F1E24 80101624 4000BE8F */  lw         $fp, 0x40($sp)
    /* F1E28 80101628 3C00B78F */  lw         $s7, 0x3C($sp)
    /* F1E2C 8010162C 3800B68F */  lw         $s6, 0x38($sp)
    /* F1E30 80101630 3400B58F */  lw         $s5, 0x34($sp)
    /* F1E34 80101634 3000B48F */  lw         $s4, 0x30($sp)
    /* F1E38 80101638 2C00B38F */  lw         $s3, 0x2C($sp)
    /* F1E3C 8010163C 2800B28F */  lw         $s2, 0x28($sp)
    /* F1E40 80101640 2400B18F */  lw         $s1, 0x24($sp)
    /* F1E44 80101644 2000B08F */  lw         $s0, 0x20($sp)
    /* F1E48 80101648 0800E003 */  jr         $ra
    /* F1E4C 8010164C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel iSPCH_MakeSampleRequests
