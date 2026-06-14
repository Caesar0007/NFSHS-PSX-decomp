.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetupChunkBuildList__FP13DRender_tView, 0x32C

glabel SetupChunkBuildList__FP13DRender_tView
    /* 6E574 8007DD74 70FFBD27 */  addiu      $sp, $sp, -0x90
    /* 6E578 8007DD78 1180033C */  lui        $v1, %hi(BWorld_gChunkBuildList)
    /* 6E57C 8007DD7C 6C00B1AF */  sw         $s1, 0x6C($sp)
    /* 6E580 8007DD80 ECEF7124 */  addiu      $s1, $v1, %lo(BWorld_gChunkBuildList)
    /* 6E584 8007DD84 4402828F */  lw         $v0, %gp_rel(gCurrContext)($gp)
    /* 6E588 8007DD88 1480033C */  lui        $v1, %hi(Track_gInViewList)
    /* 6E58C 8007DD8C ACD4638C */  lw         $v1, %lo(Track_gInViewList)($v1)
    /* 6E590 8007DD90 8000B6AF */  sw         $s6, 0x80($sp)
    /* 6E594 8007DD94 21B08000 */  addu       $s6, $a0, $zero
    /* 6E598 8007DD98 8400B7AF */  sw         $s7, 0x84($sp)
    /* 6E59C 8007DD9C 21B80000 */  addu       $s7, $zero, $zero
    /* 6E5A0 8007DDA0 7C00B5AF */  sw         $s5, 0x7C($sp)
    /* 6E5A4 8007DDA4 21A8E002 */  addu       $s5, $s7, $zero
    /* 6E5A8 8007DDA8 8800BEAF */  sw         $fp, 0x88($sp)
    /* 6E5AC 8007DDAC 5000BE27 */  addiu      $fp, $sp, 0x50
    /* 6E5B0 8007DDB0 8C00BFAF */  sw         $ra, 0x8C($sp)
    /* 6E5B4 8007DDB4 7800B4AF */  sw         $s4, 0x78($sp)
    /* 6E5B8 8007DDB8 7400B3AF */  sw         $s3, 0x74($sp)
    /* 6E5BC 8007DDBC 7000B2AF */  sw         $s2, 0x70($sp)
    /* 6E5C0 8007DDC0 6800B0AF */  sw         $s0, 0x68($sp)
    /* 6E5C4 8007DDC4 8800458C */  lw         $a1, 0x88($v0)
    /* 6E5C8 8007DDC8 1480023C */  lui        $v0, %hi(Track_gInViewCount)
    /* 6E5CC 8007DDCC B0D4428C */  lw         $v0, %lo(Track_gInViewCount)($v0)
    /* 6E5D0 8007DDD0 80210500 */  sll        $a0, $a1, 6
    /* 6E5D4 8007DDD4 21986400 */  addu       $s3, $v1, $a0
    /* 6E5D8 8007DDD8 21104500 */  addu       $v0, $v0, $a1
    /* 6E5DC 8007DDDC 00004290 */  lbu        $v0, 0x0($v0)
    /* 6E5E0 8007DDE0 00000000 */  nop
    /* 6E5E4 8007DDE4 6000A2AF */  sw         $v0, 0x60($sp)
  .L8007DDE8:
    /* 6E5E8 8007DDE8 6000A78F */  lw         $a3, 0x60($sp)
    /* 6E5EC 8007DDEC 00000000 */  nop
    /* 6E5F0 8007DDF0 2A10A702 */  slt        $v0, $s5, $a3
    /* 6E5F4 8007DDF4 9D004010 */  beqz       $v0, .L8007E06C
    /* 6E5F8 8007DDF8 0800C526 */   addiu     $a1, $s6, 0x8
    /* 6E5FC 8007DDFC 00006296 */  lhu        $v0, 0x0($s3)
    /* 6E600 8007DE00 1480033C */  lui        $v1, %hi(Chunk_chunkCenters)
    /* 6E604 8007DE04 1CC8638C */  lw         $v1, %lo(Chunk_chunkCenters)($v1)
    /* 6E608 8007DE08 FF035230 */  andi       $s2, $v0, 0x3FF
    /* 6E60C 8007DE0C 40101200 */  sll        $v0, $s2, 1
    /* 6E610 8007DE10 21105200 */  addu       $v0, $v0, $s2
    /* 6E614 8007DE14 80100200 */  sll        $v0, $v0, 2
    /* 6E618 8007DE18 21806200 */  addu       $s0, $v1, $v0
    /* 6E61C 8007DE1C 71F5010C */  jal        xzsquaredist32__FP8coorddefT0
    /* 6E620 8007DE20 21200002 */   addu      $a0, $s0, $zero
    /* 6E624 8007DE24 4402838F */  lw         $v1, %gp_rel(gCurrContext)($gp)
    /* 6E628 8007DE28 00000000 */  nop
    /* 6E62C 8007DE2C 8C00638C */  lw         $v1, 0x8C($v1)
    /* 6E630 8007DE30 21A04000 */  addu       $s4, $v0, $zero
    /* 6E634 8007DE34 2A187400 */  slt        $v1, $v1, $s4
    /* 6E638 8007DE38 89006014 */  bnez       $v1, .L8007E060
    /* 6E63C 8007DE3C 00000000 */   nop
    /* 6E640 8007DE40 00006296 */  lhu        $v0, 0x0($s3)
    /* 6E644 8007DE44 00000000 */  nop
    /* 6E648 8007DE48 00084230 */  andi       $v0, $v0, 0x800
    /* 6E64C 8007DE4C 84004014 */  bnez       $v0, .L8007E060
    /* 6E650 8007DE50 00000000 */   nop
    /* 6E654 8007DE54 0800C38E */  lw         $v1, 0x8($s6)
    /* 6E658 8007DE58 0000028E */  lw         $v0, 0x0($s0)
    /* 6E65C 8007DE5C 00000000 */  nop
    /* 6E660 8007DE60 23104300 */  subu       $v0, $v0, $v1
    /* 6E664 8007DE64 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 6E668 8007DE68 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 6E66C 8007DE6C 4000A2AF */  sw         $v0, 0x40($sp)
    /* 6E670 8007DE70 00121200 */  sll        $v0, $s2, 8
    /* 6E674 8007DE74 21104300 */  addu       $v0, $v0, $v1
    /* 6E678 8007DE78 0C00C38E */  lw         $v1, 0xC($s6)
    /* 6E67C 8007DE7C 0400428C */  lw         $v0, 0x4($v0)
    /* 6E680 8007DE80 00000000 */  nop
    /* 6E684 8007DE84 23104300 */  subu       $v0, $v0, $v1
    /* 6E688 8007DE88 4400A2AF */  sw         $v0, 0x44($sp)
    /* 6E68C 8007DE8C 1000C38E */  lw         $v1, 0x10($s6)
    /* 6E690 8007DE90 0800028E */  lw         $v0, 0x8($s0)
    /* 6E694 8007DE94 1480103C */  lui        $s0, %hi(Track_chunkList)
    /* 6E698 8007DE98 B8D4108E */  lw         $s0, %lo(Track_chunkList)($s0)
    /* 6E69C 8007DE9C 23104300 */  subu       $v0, $v0, $v1
    /* 6E6A0 8007DEA0 4800A2AF */  sw         $v0, 0x48($sp)
    /* 6E6A4 8007DEA4 C0101200 */  sll        $v0, $s2, 3
    /* 6E6A8 8007DEA8 23105200 */  subu       $v0, $v0, $s2
    /* 6E6AC 8007DEAC 00110200 */  sll        $v0, $v0, 4
    /* 6E6B0 8007DEB0 E786030C */  jal        TrsProj_SetPsxTransZero__Fv
    /* 6E6B4 8007DEB4 21800202 */   addu      $s0, $s0, $v0
    /* 6E6B8 8007DEB8 4000A427 */  addiu      $a0, $sp, 0x40
    /* 6E6BC 8007DEBC F386030C */  jal        TrsProj_TransPt__FP8coorddefT0
    /* 6E6C0 8007DEC0 2128C003 */   addu      $a1, $fp, $zero
    /* 6E6C4 8007DEC4 D386030C */  jal        TrsProj_SetPsxTrans__FP8coorddef
    /* 6E6C8 8007DEC8 2120C003 */   addu      $a0, $fp, $zero
    /* 6E6CC 8007DECC 21200002 */  addu       $a0, $s0, $zero
    /* 6E6D0 8007DED0 1000A527 */  addiu      $a1, $sp, 0x10
    /* 6E6D4 8007DED4 1687030C */  jal        TrsProj_TransPtN16__FP10RelCoord16P8coorddefi
    /* 6E6D8 8007DED8 04000624 */   addiu     $a2, $zero, 0x4
    /* 6E6DC 8007DEDC 1000A38F */  lw         $v1, 0x10($sp)
    /* 6E6E0 8007DEE0 1800A28F */  lw         $v0, 0x18($sp)
    /* 6E6E4 8007DEE4 00000000 */  nop
    /* 6E6E8 8007DEE8 2A104300 */  slt        $v0, $v0, $v1
    /* 6E6EC 8007DEEC 13004010 */  beqz       $v0, .L8007DF3C
    /* 6E6F0 8007DEF0 00000000 */   nop
    /* 6E6F4 8007DEF4 1C00A38F */  lw         $v1, 0x1C($sp)
    /* 6E6F8 8007DEF8 2400A28F */  lw         $v0, 0x24($sp)
    /* 6E6FC 8007DEFC 00000000 */  nop
    /* 6E700 8007DF00 2A104300 */  slt        $v0, $v0, $v1
    /* 6E704 8007DF04 0D004010 */  beqz       $v0, .L8007DF3C
    /* 6E708 8007DF08 00000000 */   nop
    /* 6E70C 8007DF0C 2800A38F */  lw         $v1, 0x28($sp)
    /* 6E710 8007DF10 3000A28F */  lw         $v0, 0x30($sp)
    /* 6E714 8007DF14 00000000 */  nop
    /* 6E718 8007DF18 2A104300 */  slt        $v0, $v0, $v1
    /* 6E71C 8007DF1C 07004010 */  beqz       $v0, .L8007DF3C
    /* 6E720 8007DF20 00000000 */   nop
    /* 6E724 8007DF24 3400A38F */  lw         $v1, 0x34($sp)
    /* 6E728 8007DF28 3C00A28F */  lw         $v0, 0x3C($sp)
    /* 6E72C 8007DF2C 00000000 */  nop
    /* 6E730 8007DF30 2A104300 */  slt        $v0, $v0, $v1
    /* 6E734 8007DF34 4A004014 */  bnez       $v0, .L8007E060
    /* 6E738 8007DF38 00000000 */   nop
  .L8007DF3C:
    /* 6E73C 8007DF3C 1000A28F */  lw         $v0, 0x10($sp)
    /* 6E740 8007DF40 1800A38F */  lw         $v1, 0x18($sp)
    /* 6E744 8007DF44 23100200 */  negu       $v0, $v0
    /* 6E748 8007DF48 2A186200 */  slt        $v1, $v1, $v0
    /* 6E74C 8007DF4C 13006010 */  beqz       $v1, .L8007DF9C
    /* 6E750 8007DF50 00000000 */   nop
    /* 6E754 8007DF54 1C00A28F */  lw         $v0, 0x1C($sp)
    /* 6E758 8007DF58 2400A38F */  lw         $v1, 0x24($sp)
    /* 6E75C 8007DF5C 23100200 */  negu       $v0, $v0
    /* 6E760 8007DF60 2A186200 */  slt        $v1, $v1, $v0
    /* 6E764 8007DF64 0D006010 */  beqz       $v1, .L8007DF9C
    /* 6E768 8007DF68 00000000 */   nop
    /* 6E76C 8007DF6C 2800A28F */  lw         $v0, 0x28($sp)
    /* 6E770 8007DF70 3000A38F */  lw         $v1, 0x30($sp)
    /* 6E774 8007DF74 23100200 */  negu       $v0, $v0
    /* 6E778 8007DF78 2A186200 */  slt        $v1, $v1, $v0
    /* 6E77C 8007DF7C 07006010 */  beqz       $v1, .L8007DF9C
    /* 6E780 8007DF80 00000000 */   nop
    /* 6E784 8007DF84 3400A28F */  lw         $v0, 0x34($sp)
    /* 6E788 8007DF88 3C00A38F */  lw         $v1, 0x3C($sp)
    /* 6E78C 8007DF8C 23100200 */  negu       $v0, $v0
    /* 6E790 8007DF90 2A186200 */  slt        $v1, $v1, $v0
    /* 6E794 8007DF94 32006014 */  bnez       $v1, .L8007E060
    /* 6E798 8007DF98 00000000 */   nop
  .L8007DF9C:
    /* 6E79C 8007DF9C 1800A28F */  lw         $v0, 0x18($sp)
    /* 6E7A0 8007DFA0 00000000 */  nop
    /* 6E7A4 8007DFA4 0D004104 */  bgez       $v0, .L8007DFDC
    /* 6E7A8 8007DFA8 03000224 */   addiu     $v0, $zero, 0x3
    /* 6E7AC 8007DFAC 2400A28F */  lw         $v0, 0x24($sp)
    /* 6E7B0 8007DFB0 00000000 */  nop
    /* 6E7B4 8007DFB4 09004104 */  bgez       $v0, .L8007DFDC
    /* 6E7B8 8007DFB8 03000224 */   addiu     $v0, $zero, 0x3
    /* 6E7BC 8007DFBC 3000A28F */  lw         $v0, 0x30($sp)
    /* 6E7C0 8007DFC0 00000000 */  nop
    /* 6E7C4 8007DFC4 05004104 */  bgez       $v0, .L8007DFDC
    /* 6E7C8 8007DFC8 03000224 */   addiu     $v0, $zero, 0x3
    /* 6E7CC 8007DFCC 3C00A28F */  lw         $v0, 0x3C($sp)
    /* 6E7D0 8007DFD0 00000000 */  nop
    /* 6E7D4 8007DFD4 22004004 */  bltz       $v0, .L8007E060
    /* 6E7D8 8007DFD8 03000224 */   addiu     $v0, $zero, 0x3
  .L8007DFDC:
    /* 6E7DC 8007DFDC 030022A2 */  sb         $v0, 0x3($s1)
    /* 6E7E0 8007DFE0 4402828F */  lw         $v0, %gp_rel(gCurrContext)($gp)
    /* 6E7E4 8007DFE4 00000000 */  nop
    /* 6E7E8 8007DFE8 9800428C */  lw         $v0, 0x98($v0)
    /* 6E7EC 8007DFEC 00000000 */  nop
    /* 6E7F0 8007DFF0 2A108202 */  slt        $v0, $s4, $v0
    /* 6E7F4 8007DFF4 02004010 */  beqz       $v0, .L8007E000
    /* 6E7F8 8007DFF8 07000224 */   addiu     $v0, $zero, 0x7
    /* 6E7FC 8007DFFC 030022A2 */  sb         $v0, 0x3($s1)
  .L8007E000:
    /* 6E800 8007E000 00006296 */  lhu        $v0, 0x0($s3)
    /* 6E804 8007E004 00000000 */  nop
    /* 6E808 8007E008 00404230 */  andi       $v0, $v0, 0x4000
    /* 6E80C 8007E00C 05004010 */  beqz       $v0, .L8007E024
    /* 6E810 8007E010 00000000 */   nop
    /* 6E814 8007E014 03002292 */  lbu        $v0, 0x3($s1)
    /* 6E818 8007E018 00000000 */  nop
    /* 6E81C 8007E01C FD004230 */  andi       $v0, $v0, 0xFD
    /* 6E820 8007E020 030022A2 */  sb         $v0, 0x3($s1)
  .L8007E024:
    /* 6E824 8007E024 00006296 */  lhu        $v0, 0x0($s3)
    /* 6E828 8007E028 00000000 */  nop
    /* 6E82C 8007E02C 00204230 */  andi       $v0, $v0, 0x2000
    /* 6E830 8007E030 05004010 */  beqz       $v0, .L8007E048
    /* 6E834 8007E034 00000000 */   nop
    /* 6E838 8007E038 03002292 */  lbu        $v0, 0x3($s1)
    /* 6E83C 8007E03C 00000000 */  nop
    /* 6E840 8007E040 FE004230 */  andi       $v0, $v0, 0xFE
    /* 6E844 8007E044 030022A2 */  sb         $v0, 0x3($s1)
  .L8007E048:
    /* 6E848 8007E048 55F7010C */  jal        GetRezIndex__Fi
    /* 6E84C 8007E04C 21208002 */   addu      $a0, $s4, $zero
    /* 6E850 8007E050 020022A2 */  sb         $v0, 0x2($s1)
    /* 6E854 8007E054 000032A6 */  sh         $s2, 0x0($s1)
    /* 6E858 8007E058 04003126 */  addiu      $s1, $s1, 0x4
    /* 6E85C 8007E05C 0100F726 */  addiu      $s7, $s7, 0x1
  .L8007E060:
    /* 6E860 8007E060 02007326 */  addiu      $s3, $s3, 0x2
    /* 6E864 8007E064 7AF70108 */  j          .L8007DDE8
    /* 6E868 8007E068 0100B526 */   addiu     $s5, $s5, 0x1
  .L8007E06C:
    /* 6E86C 8007E06C 2110E002 */  addu       $v0, $s7, $zero
    /* 6E870 8007E070 8C00BF8F */  lw         $ra, 0x8C($sp)
    /* 6E874 8007E074 8800BE8F */  lw         $fp, 0x88($sp)
    /* 6E878 8007E078 8400B78F */  lw         $s7, 0x84($sp)
    /* 6E87C 8007E07C 8000B68F */  lw         $s6, 0x80($sp)
    /* 6E880 8007E080 7C00B58F */  lw         $s5, 0x7C($sp)
    /* 6E884 8007E084 7800B48F */  lw         $s4, 0x78($sp)
    /* 6E888 8007E088 7400B38F */  lw         $s3, 0x74($sp)
    /* 6E88C 8007E08C 7000B28F */  lw         $s2, 0x70($sp)
    /* 6E890 8007E090 6C00B18F */  lw         $s1, 0x6C($sp)
    /* 6E894 8007E094 6800B08F */  lw         $s0, 0x68($sp)
    /* 6E898 8007E098 0800E003 */  jr         $ra
    /* 6E89C 8007E09C 9000BD27 */   addiu     $sp, $sp, 0x90
endlabel SetupChunkBuildList__FP13DRender_tView
