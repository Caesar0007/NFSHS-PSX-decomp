.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj, 0x168

glabel AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj
    /* 5E734 8006DF34 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 5E738 8006DF38 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 5E73C 8006DF3C 21988000 */  addu       $s3, $a0, $zero
    /* 5E740 8006DF40 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5E744 8006DF44 C8001224 */  addiu      $s2, $zero, 0xC8
    /* 5E748 8006DF48 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 5E74C 8006DF4C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 5E750 8006DF50 2400B5AF */  sw         $s5, 0x24($sp)
    /* 5E754 8006DF54 2000B4AF */  sw         $s4, 0x20($sp)
    /* 5E758 8006DF58 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5E75C 8006DF5C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5E760 8006DF60 6405638E */  lw         $v1, 0x564($s3)
    /* 5E764 8006DF64 EC315524 */  addiu      $s5, $v0, %lo(GameSetup_gData)
    /* 5E768 8006DF68 02006104 */  bgez       $v1, .L8006DF74
    /* 5E76C 8006DF6C 21A06000 */   addu      $s4, $v1, $zero
    /* 5E770 8006DF70 23A01400 */  negu       $s4, $s4
  .L8006DF74:
    /* 5E774 8006DF74 3F004006 */  bltz       $s2, .L8006E074
    /* 5E778 8006DF78 AA2A023C */   lui       $v0, (0x2AAAAAAB >> 16)
    /* 5E77C 8006DF7C ABAA4234 */  ori        $v0, $v0, (0x2AAAAAAB & 0xFFFF)
    /* 5E780 8006DF80 18004202 */  mult       $s2, $v0
    /* 5E784 8006DF84 C3171200 */  sra        $v0, $s2, 31
    /* 5E788 8006DF88 10480000 */  mfhi       $t1
    /* 5E78C 8006DF8C 5405638E */  lw         $v1, 0x554($s3)
    /* 5E790 8006DF90 23102201 */  subu       $v0, $t1, $v0
    /* 5E794 8006DF94 18004300 */  mult       $v0, $v1
    /* 5E798 8006DF98 12280000 */  mflo       $a1
    /* 5E79C 8006DF9C 0A00A004 */  bltz       $a1, .L8006DFC8
    /* 5E7A0 8006DFA0 00000000 */   nop
    /* 5E7A4 8006DFA4 08006286 */  lh         $v0, 0x8($s3)
    /* 5E7A8 8006DFA8 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 5E7AC 8006DFAC C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 5E7B0 8006DFB0 21284500 */  addu       $a1, $v0, $a1
    /* 5E7B4 8006DFB4 2A10A300 */  slt        $v0, $a1, $v1
    /* 5E7B8 8006DFB8 0C004014 */  bnez       $v0, .L8006DFEC
    /* 5E7BC 8006DFBC 00000000 */   nop
    /* 5E7C0 8006DFC0 FBB70108 */  j          .L8006DFEC
    /* 5E7C4 8006DFC4 2328A300 */   subu      $a1, $a1, $v1
  .L8006DFC8:
    /* 5E7C8 8006DFC8 08006286 */  lh         $v0, 0x8($s3)
    /* 5E7CC 8006DFCC 00000000 */  nop
    /* 5E7D0 8006DFD0 21284500 */  addu       $a1, $v0, $a1
    /* 5E7D4 8006DFD4 0500A104 */  bgez       $a1, .L8006DFEC
    /* 5E7D8 8006DFD8 00000000 */   nop
    /* 5E7DC 8006DFDC 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 5E7E0 8006DFE0 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 5E7E4 8006DFE4 00000000 */  nop
    /* 5E7E8 8006DFE8 2128A200 */  addu       $a1, $a1, $v0
  .L8006DFEC:
    /* 5E7EC 8006DFEC 1480043C */  lui        $a0, %hi(AIDataRecord_TrackCurve)
    /* 5E7F0 8006DFF0 A4C5848C */  lw         $a0, %lo(AIDataRecord_TrackCurve)($a0)
    /* 5E7F4 8006DFF4 E9B4010C */  jal        Get__25AIDataRecord_TrackCurve_ti
    /* 5E7F8 8006DFF8 00000000 */   nop
    /* 5E7FC 8006DFFC 21804000 */  addu       $s0, $v0, $zero
    /* 5E800 8006E000 B406648E */  lw         $a0, 0x6B4($s3)
    /* 5E804 8006E004 13B5010C */  jal        Get__30AIDataRecord_CurveSpeedTable_ti
    /* 5E808 8006E008 21280002 */   addu      $a1, $s0, $zero
    /* 5E80C 8006E00C 4800A38E */  lw         $v1, 0x48($s5)
    /* 5E810 8006E010 00000000 */  nop
    /* 5E814 8006E014 0D006010 */  beqz       $v1, .L8006E04C
    /* 5E818 8006E018 21884000 */   addu      $s1, $v0, $zero
    /* 5E81C 8006E01C 21100002 */  addu       $v0, $s0, $zero
    /* 5E820 8006E020 02004104 */  bgez       $v0, .L8006E02C
    /* 5E824 8006E024 00000000 */   nop
    /* 5E828 8006E028 03004224 */  addiu      $v0, $v0, 0x3
  .L8006E02C:
    /* 5E82C 8006E02C 83100200 */  sra        $v0, $v0, 2
    /* 5E830 8006E030 6400838F */  lw         $v1, %gp_rel(D_8013C5B0)($gp)
    /* 5E834 8006E034 80100200 */  sll        $v0, $v0, 2
    /* 5E838 8006E038 21104300 */  addu       $v0, $v0, $v1
    /* 5E83C 8006E03C 0000458C */  lw         $a1, 0x0($v0)
    /* 5E840 8006E040 CA90030C */  jal        fixedmult
    /* 5E844 8006E044 21202002 */   addu      $a0, $s1, $zero
    /* 5E848 8006E048 21884000 */  addu       $s1, $v0, $zero
  .L8006E04C:
    /* 5E84C 8006E04C 07004012 */  beqz       $s2, .L8006E06C
    /* 5E850 8006E050 21206002 */   addu      $a0, $s3, $zero
    /* 5E854 8006E054 002C1200 */  sll        $a1, $s2, 16
    /* 5E858 8006E058 21308002 */  addu       $a2, $s4, $zero
    /* 5E85C 8006E05C A4B7010C */  jal        AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii
    /* 5E860 8006E060 21382002 */   addu      $a3, $s1, $zero
    /* 5E864 8006E064 C3FF4010 */  beqz       $v0, .L8006DF74
    /* 5E868 8006E068 E7FF5226 */   addiu     $s2, $s2, -0x19
  .L8006E06C:
    /* 5E86C 8006E06C 1EB80108 */  j          .L8006E078
    /* 5E870 8006E070 21102002 */   addu      $v0, $s1, $zero
  .L8006E074:
    /* 5E874 8006E074 21100000 */  addu       $v0, $zero, $zero
  .L8006E078:
    /* 5E878 8006E078 2800BF8F */  lw         $ra, 0x28($sp)
    /* 5E87C 8006E07C 2400B58F */  lw         $s5, 0x24($sp)
    /* 5E880 8006E080 2000B48F */  lw         $s4, 0x20($sp)
    /* 5E884 8006E084 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5E888 8006E088 1800B28F */  lw         $s2, 0x18($sp)
    /* 5E88C 8006E08C 1400B18F */  lw         $s1, 0x14($sp)
    /* 5E890 8006E090 1000B08F */  lw         $s0, 0x10($sp)
    /* 5E894 8006E094 0800E003 */  jr         $ra
    /* 5E898 8006E098 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj
