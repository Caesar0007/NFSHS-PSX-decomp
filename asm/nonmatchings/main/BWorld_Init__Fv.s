.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_Init__Fv, 0x2EC

glabel BWorld_Init__Fv
    /* 6EDC8 8007E5C8 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* 6EDCC 8007E5CC F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* 6EDD0 8007E5D0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6EDD4 8007E5D4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 6EDD8 8007E5D8 51004014 */  bnez       $v0, .L8007E720
    /* 6EDDC 8007E5DC 1000B0AF */   sw        $s0, 0x10($sp)
    /* 6EDE0 8007E5E0 1180043C */  lui        $a0, %hi(GameSetup_gData)
    /* 6EDE4 8007E5E4 EC319024 */  addiu      $s0, $a0, %lo(GameSetup_gData)
    /* 6EDE8 8007E5E8 0C00038E */  lw         $v1, 0xC($s0)
    /* 6EDEC 8007E5EC 01000224 */  addiu      $v0, $zero, 0x1
    /* 6EDF0 8007E5F0 45006210 */  beq        $v1, $v0, .L8007E708
    /* 6EDF4 8007E5F4 02000224 */   addiu     $v0, $zero, 0x2
    /* 6EDF8 8007E5F8 EC31838C */  lw         $v1, %lo(GameSetup_gData)($a0)
    /* 6EDFC 8007E5FC 00000000 */  nop
    /* 6EE00 8007E600 42006210 */  beq        $v1, $v0, .L8007E70C
    /* 6EE04 8007E604 1180033C */   lui       $v1, %hi(GameSetup_gData)
    /* 6EE08 8007E608 B5AA030C */  jal        rand
    /* 6EE0C 8007E60C 00000000 */   nop
    /* 6EE10 8007E610 02004104 */  bgez       $v0, .L8007E61C
    /* 6EE14 8007E614 00000000 */   nop
    /* 6EE18 8007E618 FF3F4224 */  addiu      $v0, $v0, 0x3FFF
  .L8007E61C:
    /* 6EE1C 8007E61C 83130200 */  sra        $v0, $v0, 14
    /* 6EE20 8007E620 B5AA030C */  jal        rand
    /* 6EE24 8007E624 D40002AE */   sw        $v0, 0xD4($s0)
    /* 6EE28 8007E628 0400048E */  lw         $a0, 0x4($s0)
    /* 6EE2C 8007E62C 21184000 */  addu       $v1, $v0, $zero
    /* 6EE30 8007E630 02008228 */  slti       $v0, $a0, 0x2
    /* 6EE34 8007E634 08004014 */  bnez       $v0, .L8007E658
    /* 6EE38 8007E638 21106000 */   addu      $v0, $v1, $zero
    /* 6EE3C 8007E63C 18006400 */  mult       $v1, $a0
    /* 6EE40 8007E640 12100000 */  mflo       $v0
    /* 6EE44 8007E644 02004104 */  bgez       $v0, .L8007E650
    /* 6EE48 8007E648 00000000 */   nop
    /* 6EE4C 8007E64C FF7F4224 */  addiu      $v0, $v0, 0x7FFF
  .L8007E650:
    /* 6EE50 8007E650 9AF90108 */  j          .L8007E668
    /* 6EE54 8007E654 C3130200 */   sra       $v0, $v0, 15
  .L8007E658:
    /* 6EE58 8007E658 02004104 */  bgez       $v0, .L8007E664
    /* 6EE5C 8007E65C 00000000 */   nop
    /* 6EE60 8007E660 FF3F4224 */  addiu      $v0, $v0, 0x3FFF
  .L8007E664:
    /* 6EE64 8007E664 83130200 */  sra        $v0, $v0, 14
  .L8007E668:
    /* 6EE68 8007E668 B5AA030C */  jal        rand
    /* 6EE6C 8007E66C D80002AE */   sw        $v0, 0xD8($s0)
    /* 6EE70 8007E670 1180033C */  lui        $v1, %hi(GameSetup_gData)
    /* 6EE74 8007E674 EC316424 */  addiu      $a0, $v1, %lo(GameSetup_gData)
    /* 6EE78 8007E678 0400838C */  lw         $v1, 0x4($a0)
    /* 6EE7C 8007E67C 00000000 */  nop
    /* 6EE80 8007E680 18004300 */  mult       $v0, $v1
    /* 6EE84 8007E684 12100000 */  mflo       $v0
    /* 6EE88 8007E688 02004104 */  bgez       $v0, .L8007E694
    /* 6EE8C 8007E68C 00000000 */   nop
    /* 6EE90 8007E690 FF7F4224 */  addiu      $v0, $v0, 0x7FFF
  .L8007E694:
    /* 6EE94 8007E694 D800838C */  lw         $v1, 0xD8($a0)
    /* 6EE98 8007E698 C3130200 */  sra        $v0, $v0, 15
    /* 6EE9C 8007E69C 21106200 */  addu       $v0, $v1, $v0
    /* 6EEA0 8007E6A0 03006214 */  bne        $v1, $v0, .L8007E6B0
    /* 6EEA4 8007E6A4 DC0082AC */   sw        $v0, 0xDC($a0)
    /* 6EEA8 8007E6A8 01006224 */  addiu      $v0, $v1, 0x1
    /* 6EEAC 8007E6AC DC0082AC */  sw         $v0, 0xDC($a0)
  .L8007E6B0:
    /* 6EEB0 8007E6B0 4800828C */  lw         $v0, 0x48($a0)
    /* 6EEB4 8007E6B4 00000000 */  nop
    /* 6EEB8 8007E6B8 08004010 */  beqz       $v0, .L8007E6DC
    /* 6EEBC 8007E6BC 00000000 */   nop
    /* 6EEC0 8007E6C0 D400828C */  lw         $v0, 0xD4($a0)
    /* 6EEC4 8007E6C4 DC00838C */  lw         $v1, 0xDC($a0)
    /* 6EEC8 8007E6C8 0A004224 */  addiu      $v0, $v0, 0xA
    /* 6EECC 8007E6CC 05006324 */  addiu      $v1, $v1, 0x5
    /* 6EED0 8007E6D0 D40082AC */  sw         $v0, 0xD4($a0)
    /* 6EED4 8007E6D4 BFF90108 */  j          .L8007E6FC
    /* 6EED8 8007E6D8 DC0083AC */   sw        $v1, 0xDC($a0)
  .L8007E6DC:
    /* 6EEDC 8007E6DC 1800828C */  lw         $v0, 0x18($a0)
    /* 6EEE0 8007E6E0 00000000 */  nop
    /* 6EEE4 8007E6E4 05004010 */  beqz       $v0, .L8007E6FC
    /* 6EEE8 8007E6E8 00000000 */   nop
    /* 6EEEC 8007E6EC D400828C */  lw         $v0, 0xD4($a0)
    /* 6EEF0 8007E6F0 00000000 */  nop
    /* 6EEF4 8007E6F4 14004224 */  addiu      $v0, $v0, 0x14
    /* 6EEF8 8007E6F8 D40082AC */  sw         $v0, 0xD4($a0)
  .L8007E6FC:
    /* 6EEFC 8007E6FC 0C0280AF */  sw         $zero, %gp_rel(SceneLoaded)($gp)
    /* 6EF00 8007E700 C8F90108 */  j          .L8007E720
    /* 6EF04 8007E704 00000000 */   nop
  .L8007E708:
    /* 6EF08 8007E708 1180033C */  lui        $v1, %hi(GameSetup_gData)
  .L8007E70C:
    /* 6EF0C 8007E70C EC316324 */  addiu      $v1, $v1, %lo(GameSetup_gData)
    /* 6EF10 8007E710 63000224 */  addiu      $v0, $zero, 0x63
    /* 6EF14 8007E714 D40062AC */  sw         $v0, 0xD4($v1)
    /* 6EF18 8007E718 D80062AC */  sw         $v0, 0xD8($v1)
    /* 6EF1C 8007E71C DC0062AC */  sw         $v0, 0xDC($v1)
  .L8007E720:
    /* 6EF20 8007E720 8C94020C */  jal        Object_InitStatus__Fv
    /* 6EF24 8007E724 1180103C */   lui       $s0, %hi(GameSetup_gData)
    /* 6EF28 8007E728 EC311026 */  addiu      $s0, $s0, %lo(GameSetup_gData)
    /* 6EF2C 8007E72C 3C00048E */  lw         $a0, 0x3C($s0)
    /* 6EF30 8007E730 BEE4020C */  jal        Track_SetTrackNumber__Fi
    /* 6EF34 8007E734 00000000 */   nop
    /* 6EF38 8007E738 0AF9010C */  jal        BWorld_InitContexts__Fv
    /* 6EF3C 8007E73C 00000000 */   nop
    /* 6EF40 8007E740 0C00038E */  lw         $v1, 0xC($s0)
    /* 6EF44 8007E744 01000224 */  addiu      $v0, $zero, 0x1
    /* 6EF48 8007E748 06006214 */  bne        $v1, $v0, .L8007E764
    /* 6EF4C 8007E74C 00000000 */   nop
    /* 6EF50 8007E750 21204000 */  addu       $a0, $v0, $zero
    /* 6EF54 8007E754 2BF9010C */  jal        BWorld_OpenContext__Fii
    /* 6EF58 8007E758 21280000 */   addu      $a1, $zero, $zero
    /* 6EF5C 8007E75C DAF90108 */  j          .L8007E768
    /* 6EF60 8007E760 01000424 */   addiu     $a0, $zero, 0x1
  .L8007E764:
    /* 6EF64 8007E764 21200000 */  addu       $a0, $zero, $zero
  .L8007E768:
    /* 6EF68 8007E768 2BF9010C */  jal        BWorld_OpenContext__Fii
    /* 6EF6C 8007E76C 21288000 */   addu      $a1, $a0, $zero
    /* 6EF70 8007E770 20F9010C */  jal        SetContext__Fi
    /* 6EF74 8007E774 21200000 */   addu      $a0, $zero, $zero
    /* 6EF78 8007E778 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 6EF7C 8007E77C EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* 6EF80 8007E780 5400628C */  lw         $v0, 0x54($v1)
    /* 6EF84 8007E784 00000000 */  nop
    /* 6EF88 8007E788 0B004010 */  beqz       $v0, .L8007E7B8
    /* 6EF8C 8007E78C 00000000 */   nop
    /* 6EF90 8007E790 4800628C */  lw         $v0, 0x48($v1)
    /* 6EF94 8007E794 00000000 */  nop
    /* 6EF98 8007E798 04004010 */  beqz       $v0, .L8007E7AC
    /* 6EF9C 8007E79C 00000000 */   nop
    /* 6EFA0 8007E7A0 1480043C */  lui        $a0, %hi(D_8013C76C)
    /* 6EFA4 8007E7A4 F7F90108 */  j          .L8007E7DC
    /* 6EFA8 8007E7A8 6CC78424 */   addiu     $a0, $a0, %lo(D_8013C76C)
  .L8007E7AC:
    /* 6EFAC 8007E7AC 1480043C */  lui        $a0, %hi(D_8013C774)
    /* 6EFB0 8007E7B0 F7F90108 */  j          .L8007E7DC
    /* 6EFB4 8007E7B4 74C78424 */   addiu     $a0, $a0, %lo(D_8013C774)
  .L8007E7B8:
    /* 6EFB8 8007E7B8 4800628C */  lw         $v0, 0x48($v1)
    /* 6EFBC 8007E7BC 00000000 */  nop
    /* 6EFC0 8007E7C0 04004010 */  beqz       $v0, .L8007E7D4
    /* 6EFC4 8007E7C4 00000000 */   nop
    /* 6EFC8 8007E7C8 1480043C */  lui        $a0, %hi(D_8013C77C)
    /* 6EFCC 8007E7CC F7F90108 */  j          .L8007E7DC
    /* 6EFD0 8007E7D0 7CC78424 */   addiu     $a0, $a0, %lo(D_8013C77C)
  .L8007E7D4:
    /* 6EFD4 8007E7D4 1480043C */  lui        $a0, %hi(D_8013C784)
    /* 6EFD8 8007E7D8 84C78424 */  addiu      $a0, $a0, %lo(D_8013C784)
  .L8007E7DC:
    /* 6EFDC 8007E7DC C2E4020C */  jal        Track_MakeTrackPathName__FPc
    /* 6EFE0 8007E7E0 00000000 */   nop
    /* 6EFE4 8007E7E4 02EA020C */  jal        Track_Init__FPc
    /* 6EFE8 8007E7E8 21204000 */   addu      $a0, $v0, $zero
    /* 6EFEC 8007E7EC 6295020C */  jal        Object_InitCustomObjects__Fv
    /* 6EFF0 8007E7F0 00000000 */   nop
    /* 6EFF4 8007E7F4 B497020C */  jal        Object_InitIMassObjectInfo__Fv
    /* 6EFF8 8007E7F8 00000000 */   nop
    /* 6EFFC 8007E7FC 1480043C */  lui        $a0, %hi(gPersistObjDef)
    /* 6F000 8007E800 BCD4848C */  lw         $a0, %lo(gPersistObjDef)($a0)
    /* 6F004 8007E804 00000000 */  nop
    /* 6F008 8007E808 04008010 */  beqz       $a0, .L8007E81C
    /* 6F00C 8007E80C 00000000 */   nop
    /* 6F010 8007E810 0000848C */  lw         $a0, 0x0($a0)
    /* 6F014 8007E814 DFD7020C */  jal        Scene_Init__Fi
    /* 6F018 8007E818 00000000 */   nop
  .L8007E81C:
    /* 6F01C 8007E81C 806C030C */  jal        Loading_UpdateLoadingScreen__Fi
    /* 6F020 8007E820 05000424 */   addiu     $a0, $zero, 0x5
    /* 6F024 8007E824 1480043C */  lui        $a0, %hi(D_8013C78C)
    /* 6F028 8007E828 D4E4020C */  jal        Track_MakeTrackDataPathName__FPc
    /* 6F02C 8007E82C 8CC78424 */   addiu     $a0, $a0, %lo(D_8013C78C)
    /* 6F030 8007E830 C7CE010C */  jal        Anim_InitSystem__FPc
    /* 6F034 8007E834 21204000 */   addu      $a0, $v0, $zero
    /* 6F038 8007E838 1180033C */  lui        $v1, %hi(GameSetup_gData)
    /* 6F03C 8007E83C EC316524 */  addiu      $a1, $v1, %lo(GameSetup_gData)
    /* 6F040 8007E840 0C00A28C */  lw         $v0, 0xC($a1)
    /* 6F044 8007E844 01000424 */  addiu      $a0, $zero, 0x1
    /* 6F048 8007E848 0B004410 */  beq        $v0, $a0, .L8007E878
    /* 6F04C 8007E84C 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 6F050 8007E850 EC31638C */  lw         $v1, %lo(GameSetup_gData)($v1)
    /* 6F054 8007E854 00000000 */  nop
    /* 6F058 8007E858 06006410 */  beq        $v1, $a0, .L8007E874
    /* 6F05C 8007E85C 05000224 */   addiu     $v0, $zero, 0x5
    /* 6F060 8007E860 05006210 */  beq        $v1, $v0, .L8007E878
    /* 6F064 8007E864 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 6F068 8007E868 D400A48C */  lw         $a0, 0xD4($a1)
    /* 6F06C 8007E86C 21D8020C */  jal        Scene_LoadSceneFile__Fi
    /* 6F070 8007E870 00000000 */   nop
  .L8007E874:
    /* 6F074 8007E874 1180023C */  lui        $v0, %hi(GameSetup_gData)
  .L8007E878:
    /* 6F078 8007E878 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 6F07C 8007E87C 5400438C */  lw         $v1, 0x54($v0)
    /* 6F080 8007E880 4800428C */  lw         $v0, 0x48($v0)
    /* 6F084 8007E884 00000000 */  nop
    /* 6F088 8007E888 02004010 */  beqz       $v0, .L8007E894
    /* 6F08C 8007E88C 2B200300 */   sltu      $a0, $zero, $v1
    /* 6F090 8007E890 02008424 */  addiu      $a0, $a0, 0x2
  .L8007E894:
    /* 6F094 8007E894 55ED010C */  jal        AudList_LoadAudioFile__Fi
    /* 6F098 8007E898 00000000 */   nop
    /* 6F09C 8007E89C 06F6010C */  jal        BWorld_InitSpikeBelt__Fv
    /* 6F0A0 8007E8A0 00000000 */   nop
    /* 6F0A4 8007E8A4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 6F0A8 8007E8A8 1000B08F */  lw         $s0, 0x10($sp)
    /* 6F0AC 8007E8AC 0800E003 */  jr         $ra
    /* 6F0B0 8007E8B0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel BWorld_Init__Fv
