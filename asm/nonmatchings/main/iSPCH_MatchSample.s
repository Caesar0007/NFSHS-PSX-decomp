.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_MatchSample, 0x104

glabel iSPCH_MatchSample
    /* F0F7C 8010077C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* F0F80 80100780 2800B6AF */  sw         $s6, 0x28($sp)
    /* F0F84 80100784 21B0A000 */  addu       $s6, $a1, $zero
    /* F0F88 80100788 2400B5AF */  sw         $s5, 0x24($sp)
    /* F0F8C 8010078C 21A8C000 */  addu       $s5, $a2, $zero
    /* F0F90 80100790 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* F0F94 80100794 21B8E000 */  addu       $s7, $a3, $zero
    /* F0F98 80100798 3000BFAF */  sw         $ra, 0x30($sp)
    /* F0F9C 8010079C 2000B4AF */  sw         $s4, 0x20($sp)
    /* F0FA0 801007A0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F0FA4 801007A4 1800B2AF */  sw         $s2, 0x18($sp)
    /* F0FA8 801007A8 1400B1AF */  sw         $s1, 0x14($sp)
    /* F0FAC 801007AC 1000B0AF */  sw         $s0, 0x10($sp)
    /* F0FB0 801007B0 0300B482 */  lb         $s4, 0x3($s5)
    /* F0FB4 801007B4 00000000 */  nop
    /* F0FB8 801007B8 0500822A */  slti       $v0, $s4, 0x5
    /* F0FBC 801007BC 03004014 */  bnez       $v0, .L801007CC
    /* F0FC0 801007C0 01001324 */   addiu     $s3, $zero, 0x1
    /* F0FC4 801007C4 14020408 */  j          .L80100850
    /* F0FC8 801007C8 21980000 */   addu      $s3, $zero, $zero
  .L801007CC:
    /* F0FCC 801007CC 2000801A */  blez       $s4, .L80100850
    /* F0FD0 801007D0 21880000 */   addu      $s1, $zero, $zero
    /* F0FD4 801007D4 2110D102 */  addu       $v0, $s6, $s1
  .L801007D8:
    /* F0FD8 801007D8 0C004490 */  lbu        $a0, 0xC($v0)
    /* F0FDC 801007DC 00000000 */  nop
    /* F0FE0 801007E0 2000822C */  sltiu      $v0, $a0, 0x20
    /* F0FE4 801007E4 1A004010 */  beqz       $v0, .L80100850
    /* F0FE8 801007E8 21980000 */   addu      $s3, $zero, $zero
    /* F0FEC 801007EC 01000324 */  addiu      $v1, $zero, 0x1
    /* F0FF0 801007F0 2110B102 */  addu       $v0, $s5, $s1
    /* F0FF4 801007F4 04004290 */  lbu        $v0, 0x4($v0)
    /* F0FF8 801007F8 04908300 */  sllv       $s2, $v1, $a0
    /* F0FFC 801007FC 2120A002 */  addu       $a0, $s5, $zero
    /* F1000 80100800 21282002 */  addu       $a1, $s1, $zero
    /* F1004 80100804 C401040C */  jal        func_80100710
    /* F1008 80100808 0F005030 */   andi      $s0, $v0, 0xF
    /* F100C 8010080C 24104202 */  and        $v0, $s2, $v0
    /* F1010 80100810 0A004010 */  beqz       $v0, .L8010083C
    /* F1014 80100814 00000000 */   nop
    /* F1018 80100818 07000012 */  beqz       $s0, .L80100838
    /* F101C 8010081C 80101000 */   sll       $v0, $s0, 2
    /* F1020 80100820 21105700 */  addu       $v0, $v0, $s7
    /* F1024 80100824 0000428C */  lw         $v0, 0x0($v0)
    /* F1028 80100828 00000000 */  nop
    /* F102C 8010082C 24104202 */  and        $v0, $s2, $v0
    /* F1030 80100830 02004010 */  beqz       $v0, .L8010083C
    /* F1034 80100834 00000000 */   nop
  .L80100838:
    /* F1038 80100838 01001324 */  addiu      $s3, $zero, 0x1
  .L8010083C:
    /* F103C 8010083C 04006012 */  beqz       $s3, .L80100850
    /* F1040 80100840 01003126 */   addiu     $s1, $s1, 0x1
    /* F1044 80100844 2A103402 */  slt        $v0, $s1, $s4
    /* F1048 80100848 E3FF4014 */  bnez       $v0, .L801007D8
    /* F104C 8010084C 2110D102 */   addu      $v0, $s6, $s1
  .L80100850:
    /* F1050 80100850 21106002 */  addu       $v0, $s3, $zero
    /* F1054 80100854 3000BF8F */  lw         $ra, 0x30($sp)
    /* F1058 80100858 2C00B78F */  lw         $s7, 0x2C($sp)
    /* F105C 8010085C 2800B68F */  lw         $s6, 0x28($sp)
    /* F1060 80100860 2400B58F */  lw         $s5, 0x24($sp)
    /* F1064 80100864 2000B48F */  lw         $s4, 0x20($sp)
    /* F1068 80100868 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F106C 8010086C 1800B28F */  lw         $s2, 0x18($sp)
    /* F1070 80100870 1400B18F */  lw         $s1, 0x14($sp)
    /* F1074 80100874 1000B08F */  lw         $s0, 0x10($sp)
    /* F1078 80100878 0800E003 */  jr         $ra
    /* F107C 8010087C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iSPCH_MatchSample
