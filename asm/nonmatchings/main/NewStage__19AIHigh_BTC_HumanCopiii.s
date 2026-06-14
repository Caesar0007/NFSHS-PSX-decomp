.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NewStage__19AIHigh_BTC_HumanCopiii, 0x370

glabel NewStage__19AIHigh_BTC_HumanCopiii
    /* 4DE50 8005D650 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 4DE54 8005D654 2800B2AF */  sw         $s2, 0x28($sp)
    /* 4DE58 8005D658 21908000 */  addu       $s2, $a0, $zero
    /* 4DE5C 8005D65C 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 4DE60 8005D660 2198A000 */  addu       $s3, $a1, $zero
    /* 4DE64 8005D664 3000B4AF */  sw         $s4, 0x30($sp)
    /* 4DE68 8005D668 21A0C000 */  addu       $s4, $a2, $zero
    /* 4DE6C 8005D66C 3800BFAF */  sw         $ra, 0x38($sp)
    /* 4DE70 8005D670 3400B5AF */  sw         $s5, 0x34($sp)
    /* 4DE74 8005D674 2400B1AF */  sw         $s1, 0x24($sp)
    /* 4DE78 8005D678 2000B0AF */  sw         $s0, 0x20($sp)
    /* 4DE7C 8005D67C 6400428E */  lw         $v0, 0x64($s2)
    /* 4DE80 8005D680 00000000 */  nop
    /* 4DE84 8005D684 01004224 */  addiu      $v0, $v0, 0x1
    /* 4DE88 8005D688 640042AE */  sw         $v0, 0x64($s2)
    /* 4DE8C 8005D68C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 4DE90 8005D690 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* 4DE94 8005D694 B401628C */  lw         $v0, 0x1B4($v1)
    /* 4DE98 8005D698 1480043C */  lui        $a0, %hi(AIHigh_CopGameType)
    /* 4DE9C 8005D69C 5CC5848C */  lw         $a0, %lo(AIHigh_CopGameType)($a0)
    /* 4DEA0 8005D6A0 01004224 */  addiu      $v0, $v0, 0x1
    /* 4DEA4 8005D6A4 B40162AC */  sw         $v0, 0x1B4($v1)
    /* 4DEA8 8005D6A8 FEFF8224 */  addiu      $v0, $a0, -0x2
    /* 4DEAC 8005D6AC 0200422C */  sltiu      $v0, $v0, 0x2
    /* 4DEB0 8005D6B0 07004010 */  beqz       $v0, .L8005D6D0
    /* 4DEB4 8005D6B4 2180E000 */   addu      $s0, $a3, $zero
    /* 4DEB8 8005D6B8 6400428E */  lw         $v0, 0x64($s2)
    /* 4DEBC 8005D6BC AC01638C */  lw         $v1, 0x1AC($v1)
    /* 4DEC0 8005D6C0 00000000 */  nop
    /* 4DEC4 8005D6C4 2A104300 */  slt        $v0, $v0, $v1
    /* 4DEC8 8005D6C8 09004010 */  beqz       $v0, .L8005D6F0
    /* 4DECC 8005D6CC 1280033C */   lui       $v1, %hi(D_8011E0C8)
  .L8005D6D0:
    /* 4DED0 8005D6D0 04000224 */  addiu      $v0, $zero, 0x4
    /* 4DED4 8005D6D4 09008214 */  bne        $a0, $v0, .L8005D6FC
    /* 4DED8 8005D6D8 00000000 */   nop
    /* 4DEDC 8005D6DC 6400428E */  lw         $v0, 0x64($s2)
    /* 4DEE0 8005D6E0 00000000 */  nop
    /* 4DEE4 8005D6E4 03004228 */  slti       $v0, $v0, 0x3
    /* 4DEE8 8005D6E8 04004014 */  bnez       $v0, .L8005D6FC
    /* 4DEEC 8005D6EC 1280033C */   lui       $v1, %hi(D_8011E0C8)
  .L8005D6F0:
    /* 4DEF0 8005D6F0 01000224 */  addiu      $v0, $zero, 0x1
    /* 4DEF4 8005D6F4 67760108 */  j          .L8005D99C
    /* 4DEF8 8005D6F8 C8E062AC */   sw        $v0, %lo(D_8011E0C8)($v1)
  .L8005D6FC:
    /* 4DEFC 8005D6FC 06F6010C */  jal        BWorld_InitSpikeBelt__Fv
    /* 4DF00 8005D700 00000000 */   nop
    /* 4DF04 8005D704 1180023C */  lui        $v0, %hi(AICop_spikeBelt)
    /* 4DF08 8005D708 9B95020C */  jal        Object_ClearCustomObjects__Fv
    /* 4DF0C 8005D70C 4CD540AC */   sw        $zero, %lo(AICop_spikeBelt)($v0)
    /* 4DF10 8005D710 0000428E */  lw         $v0, 0x0($s2)
    /* 4DF14 8005D714 800054AE */  sw         $s4, 0x80($s2)
    /* 4DF18 8005D718 840050AE */  sw         $s0, 0x84($s2)
    /* 4DF1C 8005D71C 080053A4 */  sh         $s3, 0x8($v0)
    /* 4DF20 8005D720 0000428E */  lw         $v0, 0x0($s2)
    /* 4DF24 8005D724 1800A527 */  addiu      $a1, $sp, 0x18
    /* 4DF28 8005D728 540554AC */  sw         $s4, 0x554($v0)
    /* 4DF2C 8005D72C 0000448E */  lw         $a0, 0x0($s2)
    /* 4DF30 8005D730 1C00A627 */  addiu      $a2, $sp, 0x1C
    /* 4DF34 8005D734 1480013C */  lui        $at, %hi(AICop_gRoadBlockState)
    /* 4DF38 8005D738 74C520AC */  sw         $zero, %lo(AICop_gRoadBlockState)($at)
    /* 4DF3C 8005D73C 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 4DF40 8005D740 5ECE010C */  jal        AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1
    /* 4DF44 8005D744 1800A0AF */   sw        $zero, 0x18($sp)
    /* 4DF48 8005D748 1480033C */  lui        $v1, %hi(AIHigh_CopGameType)
    /* 4DF4C 8005D74C 5CC5638C */  lw         $v1, %lo(AIHigh_CopGameType)($v1)
    /* 4DF50 8005D750 04000224 */  addiu      $v0, $zero, 0x4
    /* 4DF54 8005D754 05006214 */  bne        $v1, $v0, .L8005D76C
    /* 4DF58 8005D758 21286002 */   addu      $a1, $s3, $zero
    /* 4DF5C 8005D75C 1C00A68F */  lw         $a2, 0x1C($sp)
    /* 4DF60 8005D760 1000A0AF */  sw         $zero, 0x10($sp)
    /* 4DF64 8005D764 33760108 */  j          .L8005D8CC
    /* 4DF68 8005D768 1400A0AF */   sw        $zero, 0x14($sp)
  .L8005D76C:
    /* 4DF6C 8005D76C 09000012 */  beqz       $s0, .L8005D794
    /* 4DF70 8005D770 0D00023C */   lui       $v0, (0xD5555 >> 16)
    /* 4DF74 8005D774 55554234 */  ori        $v0, $v0, (0xD5555 & 0xFFFF)
    /* 4DF78 8005D778 18008202 */  mult       $s4, $v0
    /* 4DF7C 8005D77C 1C00A68F */  lw         $a2, 0x1C($sp)
    /* 4DF80 8005D780 21286002 */  addu       $a1, $s3, $zero
    /* 4DF84 8005D784 1400A0AF */  sw         $zero, 0x14($sp)
    /* 4DF88 8005D788 12480000 */  mflo       $t1
    /* 4DF8C 8005D78C 33760108 */  j          .L8005D8CC
    /* 4DF90 8005D790 1000A9AF */   sw        $t1, 0x10($sp)
  .L8005D794:
    /* 4DF94 8005D794 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 4DF98 8005D798 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 4DF9C 8005D79C 40A91300 */  sll        $s5, $s3, 5
    /* 4DFA0 8005D7A0 2130A202 */  addu       $a2, $s5, $v0
    /* 4DFA4 8005D7A4 1F00C290 */  lbu        $v0, 0x1F($a2)
    /* 4DFA8 8005D7A8 1D00C490 */  lbu        $a0, 0x1D($a2)
    /* 4DFAC 8005D7AC C0130200 */  sll        $v0, $v0, 15
    /* 4DFB0 8005D7B0 0F008330 */  andi       $v1, $a0, 0xF
    /* 4DFB4 8005D7B4 18004300 */  mult       $v0, $v1
    /* 4DFB8 8005D7B8 1E00C390 */  lbu        $v1, 0x1E($a2)
    /* 4DFBC 8005D7BC 12880000 */  mflo       $s1
    /* 4DFC0 8005D7C0 02390400 */  srl        $a3, $a0, 4
    /* 4DFC4 8005D7C4 C01B0300 */  sll        $v1, $v1, 15
    /* 4DFC8 8005D7C8 18006700 */  mult       $v1, $a3
    /* 4DFCC 8005D7CC 1A00C284 */  lh         $v0, 0x1A($a2)
    /* 4DFD0 8005D7D0 00800824 */  addiu      $t0, $zero, -0x8000
    /* 4DFD4 8005D7D4 00120200 */  sll        $v0, $v0, 8
    /* 4DFD8 8005D7D8 21284800 */  addu       $a1, $v0, $t0
    /* 4DFDC 8005D7DC 2A102502 */  slt        $v0, $s1, $a1
    /* 4DFE0 8005D7E0 12800000 */  mflo       $s0
    /* 4DFE4 8005D7E4 02004010 */  beqz       $v0, .L8005D7F0
    /* 4DFE8 8005D7E8 00000000 */   nop
    /* 4DFEC 8005D7EC 21282002 */  addu       $a1, $s1, $zero
  .L8005D7F0:
    /* 4DFF0 8005D7F0 1800C284 */  lh         $v0, 0x18($a2)
    /* 4DFF4 8005D7F4 00000000 */  nop
    /* 4DFF8 8005D7F8 00120200 */  sll        $v0, $v0, 8
    /* 4DFFC 8005D7FC 21184800 */  addu       $v1, $v0, $t0
    /* 4E000 8005D800 2A100302 */  slt        $v0, $s0, $v1
    /* 4E004 8005D804 02004010 */  beqz       $v0, .L8005D810
    /* 4E008 8005D808 2188A000 */   addu      $s1, $a1, $zero
    /* 4E00C 8005D80C 21180002 */  addu       $v1, $s0, $zero
  .L8005D810:
    /* 4E010 8005D810 21806000 */  addu       $s0, $v1, $zero
    /* 4E014 8005D814 21206002 */  addu       $a0, $s3, $zero
    /* 4E018 8005D818 06000524 */  addiu      $a1, $zero, 0x6
    /* 4E01C 8005D81C EACC010C */  jal        AIWorld_IsDriveableLane__Fii
    /* 4E020 8005D820 2328A700 */   subu      $a1, $a1, $a3
    /* 4E024 8005D824 02004014 */  bnez       $v0, .L8005D830
    /* 4E028 8005D828 FEFF023C */   lui       $v0, (0xFFFE0000 >> 16)
    /* 4E02C 8005D82C 21800202 */  addu       $s0, $s0, $v0
  .L8005D830:
    /* 4E030 8005D830 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 4E034 8005D834 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 4E038 8005D838 00000000 */  nop
    /* 4E03C 8005D83C 2110A202 */  addu       $v0, $s5, $v0
    /* 4E040 8005D840 1D004590 */  lbu        $a1, 0x1D($v0)
    /* 4E044 8005D844 21206002 */  addu       $a0, $s3, $zero
    /* 4E048 8005D848 0F00A530 */  andi       $a1, $a1, 0xF
    /* 4E04C 8005D84C EACC010C */  jal        AIWorld_IsDriveableLane__Fii
    /* 4E050 8005D850 0700A524 */   addiu     $a1, $a1, 0x7
    /* 4E054 8005D854 02004014 */  bnez       $v0, .L8005D860
    /* 4E058 8005D858 FEFF023C */   lui       $v0, (0xFFFE0000 >> 16)
    /* 4E05C 8005D85C 21882202 */  addu       $s1, $s1, $v0
  .L8005D860:
    /* 4E060 8005D860 1C00428E */  lw         $v0, 0x1C($s2)
    /* 4E064 8005D864 00000000 */  nop
    /* 4E068 8005D868 08004014 */  bnez       $v0, .L8005D88C
    /* 4E06C 8005D86C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 4E070 8005D870 1480033C */  lui        $v1, %hi(AITune_driveSide)
    /* 4E074 8005D874 F4C5638C */  lw         $v1, %lo(AITune_driveSide)($v1)
    /* 4E078 8005D878 01000224 */  addiu      $v0, $zero, 0x1
    /* 4E07C 8005D87C 08006210 */  beq        $v1, $v0, .L8005D8A0
    /* 4E080 8005D880 21286002 */   addu      $a1, $s3, $zero
    /* 4E084 8005D884 2E760108 */  j          .L8005D8B8
    /* 4E088 8005D888 23301000 */   negu      $a2, $s0
  .L8005D88C:
    /* 4E08C 8005D88C 1480033C */  lui        $v1, %hi(AITune_driveSide)
    /* 4E090 8005D890 F4C5638C */  lw         $v1, %lo(AITune_driveSide)($v1)
    /* 4E094 8005D894 00000000 */  nop
    /* 4E098 8005D898 06006214 */  bne        $v1, $v0, .L8005D8B4
    /* 4E09C 8005D89C 21286002 */   addu      $a1, $s3, $zero
  .L8005D8A0:
    /* 4E0A0 8005D8A0 21286002 */  addu       $a1, $s3, $zero
    /* 4E0A4 8005D8A4 21302002 */  addu       $a2, $s1, $zero
    /* 4E0A8 8005D8A8 00121400 */  sll        $v0, $s4, 8
    /* 4E0AC 8005D8AC 31760108 */  j          .L8005D8C4
    /* 4E0B0 8005D8B0 00024224 */   addiu     $v0, $v0, 0x200
  .L8005D8B4:
    /* 4E0B4 8005D8B4 23301000 */  negu       $a2, $s0
  .L8005D8B8:
    /* 4E0B8 8005D8B8 001A1400 */  sll        $v1, $s4, 8
    /* 4E0BC 8005D8BC 00020224 */  addiu      $v0, $zero, 0x200
    /* 4E0C0 8005D8C0 23104300 */  subu       $v0, $v0, $v1
  .L8005D8C4:
    /* 4E0C4 8005D8C4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 4E0C8 8005D8C8 1400A2AF */  sw         $v0, 0x14($sp)
  .L8005D8CC:
    /* 4E0CC 8005D8CC 0000448E */  lw         $a0, 0x0($s2)
    /* 4E0D0 8005D8D0 149F010C */  jal        AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
    /* 4E0D4 8005D8D4 21388002 */   addu      $a3, $s4, $zero
    /* 4E0D8 8005D8D8 1480033C */  lui        $v1, %hi(AIHigh_CopGameType)
    /* 4E0DC 8005D8DC 5CC5638C */  lw         $v1, %lo(AIHigh_CopGameType)($v1)
    /* 4E0E0 8005D8E0 04000224 */  addiu      $v0, $zero, 0x4
    /* 4E0E4 8005D8E4 09006214 */  bne        $v1, $v0, .L8005D90C
    /* 4E0E8 8005D8E8 1180043C */   lui       $a0, %hi(GameSetup_gData)
    /* 4E0EC 8005D8EC 1180023C */  lui        $v0, %hi(AIH_BTC_Cop_1HC1HP_StageTimes)
    /* 4E0F0 8005D8F0 6400438E */  lw         $v1, 0x64($s2)
    /* 4E0F4 8005D8F4 98CD4224 */  addiu      $v0, $v0, %lo(AIH_BTC_Cop_1HC1HP_StageTimes)
    /* 4E0F8 8005D8F8 80180300 */  sll        $v1, $v1, 2
    /* 4E0FC 8005D8FC 21186200 */  addu       $v1, $v1, $v0
    /* 4E100 8005D900 0000628C */  lw         $v0, 0x0($v1)
    /* 4E104 8005D904 4E760108 */  j          .L8005D938
    /* 4E108 8005D908 40810200 */   sll       $s0, $v0, 5
  .L8005D90C:
    /* 4E10C 8005D90C 6400438E */  lw         $v1, 0x64($s2)
    /* 4E110 8005D910 EC318424 */  addiu      $a0, $a0, %lo(GameSetup_gData)
    /* 4E114 8005D914 40100300 */  sll        $v0, $v1, 1
    /* 4E118 8005D918 21104300 */  addu       $v0, $v0, $v1
    /* 4E11C 8005D91C 80100200 */  sll        $v0, $v0, 2
    /* 4E120 8005D920 21104300 */  addu       $v0, $v0, $v1
    /* 4E124 8005D924 80100200 */  sll        $v0, $v0, 2
    /* 4E128 8005D928 21104400 */  addu       $v0, $v0, $a0
    /* 4E12C 8005D92C D001428C */  lw         $v0, 0x1D0($v0)
    /* 4E130 8005D930 00000000 */  nop
    /* 4E134 8005D934 40810200 */  sll        $s0, $v0, 5
  .L8005D938:
    /* 4E138 8005D938 02000106 */  bgez       $s0, .L8005D944
    /* 4E13C 8005D93C 00000000 */   nop
    /* 4E140 8005D940 21800000 */  addu       $s0, $zero, $zero
  .L8005D944:
    /* 4E144 8005D944 6C00428E */  lw         $v0, 0x6C($s2)
    /* 4E148 8005D948 00000000 */  nop
    /* 4E14C 8005D94C 18000202 */  mult       $s0, $v0
    /* 4E150 8005D950 12200000 */  mflo       $a0
    /* 4E154 8005D954 02008104 */  bgez       $a0, .L8005D960
    /* 4E158 8005D958 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 4E15C 8005D95C 21208200 */  addu       $a0, $a0, $v0
  .L8005D960:
    /* 4E160 8005D960 1C00428E */  lw         $v0, 0x1C($s2)
    /* 4E164 8005D964 00000000 */  nop
    /* 4E168 8005D968 03004014 */  bnez       $v0, .L8005D978
    /* 4E16C 8005D96C 03840400 */   sra       $s0, $a0, 16
    /* 4E170 8005D970 4366030C */  jal        Hud_BTC_BonusTime__Fl
    /* 4E174 8005D974 40201000 */   sll       $a0, $s0, 1
  .L8005D978:
    /* 4E178 8005D978 7000428E */  lw         $v0, 0x70($s2)
    /* 4E17C 8005D97C 01000324 */  addiu      $v1, $zero, 0x1
    /* 4E180 8005D980 7C0043AE */  sw         $v1, 0x7C($s2)
    /* 4E184 8005D984 740040AE */  sw         $zero, 0x74($s2)
    /* 4E188 8005D988 780040AE */  sw         $zero, 0x78($s2)
    /* 4E18C 8005D98C 600043AE */  sw         $v1, 0x60($s2)
    /* 4E190 8005D990 21105000 */  addu       $v0, $v0, $s0
    /* 4E194 8005D994 76EE020C */  jal        TrgSfx_RestartTrgSfx__Fv
    /* 4E198 8005D998 700042AE */   sw        $v0, 0x70($s2)
  .L8005D99C:
    /* 4E19C 8005D99C 3800BF8F */  lw         $ra, 0x38($sp)
    /* 4E1A0 8005D9A0 3400B58F */  lw         $s5, 0x34($sp)
    /* 4E1A4 8005D9A4 3000B48F */  lw         $s4, 0x30($sp)
    /* 4E1A8 8005D9A8 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 4E1AC 8005D9AC 2800B28F */  lw         $s2, 0x28($sp)
    /* 4E1B0 8005D9B0 2400B18F */  lw         $s1, 0x24($sp)
    /* 4E1B4 8005D9B4 2000B08F */  lw         $s0, 0x20($sp)
    /* 4E1B8 8005D9B8 0800E003 */  jr         $ra
    /* 4E1BC 8005D9BC 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel NewStage__19AIHigh_BTC_HumanCopiii
