.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching main, 0x3B4

glabel main
    /* 94F30 800A4730 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 94F34 800A4734 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 94F38 800A4738 2800B6AF */  sw         $s6, 0x28($sp)
    /* 94F3C 800A473C 2400B5AF */  sw         $s5, 0x24($sp)
    /* 94F40 800A4740 2000B4AF */  sw         $s4, 0x20($sp)
    /* 94F44 800A4744 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 94F48 800A4748 1800B2AF */  sw         $s2, 0x18($sp)
    /* 94F4C 800A474C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 94F50 800A4750 0990030C */  jal        __main
    /* 94F54 800A4754 1000B0AF */   sw        $s0, 0x10($sp)
    /* 94F58 800A4758 1471030C */  jal        Platform_DebuggerPollHost__Fv
    /* 94F5C 800A475C 21A80000 */   addu      $s5, $zero, $zero
    /* 94F60 800A4760 7B8F020C */  jal        Nfs2_SystemNLibStartUp__Fv
    /* 94F64 800A4764 1180103C */   lui       $s0, %hi(carManager)
    /* 94F68 800A4768 21200000 */  addu       $a0, $zero, $zero
    /* 94F6C 800A476C E1EE020C */  jal        Audio_InitDriver__Fii
    /* 94F70 800A4770 21288000 */   addu      $a1, $a0, $zero
    /* 94F74 800A4774 19EF020C */  jal        Audio_DeInitDriver__Fv
    /* 94F78 800A4778 74421026 */   addiu     $s0, $s0, %lo(carManager)
    /* 94F7C 800A477C DCC5030C */  jal        SetVideoMode
    /* 94F80 800A4780 21200000 */   addu      $a0, $zero, $zero
    /* 94F84 800A4784 1180033C */  lui        $v1, %hi(D_80114940)
    /* 94F88 800A4788 FF000224 */  addiu      $v0, $zero, 0xFF
    /* 94F8C 800A478C 3E91020C */  jal        LoadFrontendOverlay__Fv
    /* 94F90 800A4790 404962A0 */   sb        $v0, %lo(D_80114940)($v1)
    /* 94F94 800A4794 01000224 */  addiu      $v0, $zero, 0x1
    /* 94F98 800A4798 0580013C */  lui        $at, %hi(ComingIntoTheFrontEndTheVeryFirstTime)
    /* 94F9C 800A479C EC1722AC */  sw         $v0, %lo(ComingIntoTheFrontEndTheVeryFirstTime)($at)
    /* 94FA0 800A47A0 6C58000C */  jal        Initialize__11tCarManager
    /* 94FA4 800A47A4 21200002 */   addu      $a0, $s0, $zero
    /* 94FA8 800A47A8 4D5C000C */  jal        LoadDescription__11tCarManager
    /* 94FAC 800A47AC 21200002 */   addu      $a0, $s0, $zero
    /* 94FB0 800A47B0 768D000C */  jal        FECheat_ActivateBonus__F10tCheatCode
    /* 94FB4 800A47B4 21200000 */   addu      $a0, $zero, $zero
    /* 94FB8 800A47B8 21200002 */  addu       $a0, $s0, $zero
    /* 94FBC 800A47BC 21280000 */  addu       $a1, $zero, $zero
    /* 94FC0 800A47C0 825B000C */  jal        SetClassViewable__11tCarManager13tCarClassTypeb
    /* 94FC4 800A47C4 01000624 */   addiu     $a2, $zero, 0x1
    /* 94FC8 800A47C8 21200002 */  addu       $a0, $s0, $zero
    /* 94FCC 800A47CC 01000524 */  addiu      $a1, $zero, 0x1
    /* 94FD0 800A47D0 825B000C */  jal        SetClassViewable__11tCarManager13tCarClassTypeb
    /* 94FD4 800A47D4 2130A000 */   addu      $a2, $a1, $zero
    /* 94FD8 800A47D8 21200002 */  addu       $a0, $s0, $zero
    /* 94FDC 800A47DC 02000524 */  addiu      $a1, $zero, 0x2
    /* 94FE0 800A47E0 825B000C */  jal        SetClassViewable__11tCarManager13tCarClassTypeb
    /* 94FE4 800A47E4 01000624 */   addiu     $a2, $zero, 0x1
    /* 94FE8 800A47E8 21200002 */  addu       $a0, $s0, $zero
    /* 94FEC 800A47EC 03000524 */  addiu      $a1, $zero, 0x3
    /* 94FF0 800A47F0 825B000C */  jal        SetClassViewable__11tCarManager13tCarClassTypeb
    /* 94FF4 800A47F4 01000624 */   addiu     $a2, $zero, 0x1
    /* 94FF8 800A47F8 21200002 */  addu       $a0, $s0, $zero
    /* 94FFC 800A47FC 04000524 */  addiu      $a1, $zero, 0x4
    /* 95000 800A4800 825B000C */  jal        SetClassViewable__11tCarManager13tCarClassTypeb
    /* 95004 800A4804 01000624 */   addiu     $a2, $zero, 0x1
    /* 95008 800A4808 21200002 */  addu       $a0, $s0, $zero
    /* 9500C 800A480C 05000524 */  addiu      $a1, $zero, 0x5
    /* 95010 800A4810 825B000C */  jal        SetClassViewable__11tCarManager13tCarClassTypeb
    /* 95014 800A4814 01000624 */   addiu     $a2, $zero, 0x1
    /* 95018 800A4818 1180113C */  lui        $s1, %hi(tournamentManager)
    /* 9501C 800A481C D84A3126 */  addiu      $s1, $s1, %lo(tournamentManager)
    /* 95020 800A4820 8AC8000C */  jal        Initialize__18tTournamentManager
    /* 95024 800A4824 21202002 */   addu      $a0, $s1, $zero
    /* 95028 800A4828 1480043C */  lui        $a0, %hi(missionManager)
    /* 9502C 800A482C B8D28424 */  addiu      $a0, $a0, %lo(missionManager)
    /* 95030 800A4830 18D0000C */  jal        Initialize__15tMissionManager
    /* 95034 800A4834 1180103C */   lui       $s0, %hi(trackManager)
    /* 95038 800A4838 504A1026 */  addiu      $s0, $s0, %lo(trackManager)
    /* 9503C 800A483C 8486000C */  jal        Initialize__13tTrackManager
    /* 95040 800A4840 21200002 */   addu      $a0, $s0, $zero
    /* 95044 800A4844 BFC8000C */  jal        LoadDescription__18tTournamentManager
    /* 95048 800A4848 21202002 */   addu      $a0, $s1, $zero
    /* 9504C 800A484C C586000C */  jal        LoadDescription__13tTrackManager
    /* 95050 800A4850 21200002 */   addu      $a0, $s0, $zero
    /* 95054 800A4854 979E000C */  jal        Front_InitGraphics__Fv
    /* 95058 800A4858 1280133C */   lui       $s3, %hi(simVar)
    /* 9505C 800A485C BD9E000C */  jal        Front_Menu__F21tFront_ProcessingType
    /* 95060 800A4860 21200000 */   addu      $a0, $zero, $zero
    /* 95064 800A4864 1180163C */  lui        $s6, %hi(GameSetup_gData)
    /* 95068 800A4868 EC31D126 */  addiu      $s1, $s6, %lo(GameSetup_gData)
    /* 9506C 800A486C 02001424 */  addiu      $s4, $zero, 0x2
  .L800A4870:
    /* 95070 800A4870 B791020C */  jal        NFS3_CheckForFileOperations__Fv
    /* 95074 800A4874 00000000 */   nop
    /* 95078 800A4878 3C4A000C */  jal        MinFront_ParseOptions__Fv
    /* 9507C 800A487C 00000000 */   nop
    /* 95080 800A4880 280D838F */  lw         $v1, %gp_rel(gUseFrontend)($gp)
    /* 95084 800A4884 00000000 */  nop
    /* 95088 800A4888 04006010 */  beqz       $v1, .L800A489C
    /* 9508C 800A488C 21804000 */   addu      $s0, $v0, $zero
    /* 95090 800A4890 CEA9000C */  jal        Front_BuildStream__FPi
    /* 95094 800A4894 21200002 */   addu      $a0, $s0, $zero
    /* 95098 800A4898 21804000 */  addu       $s0, $v0, $zero
  .L800A489C:
    /* 9509C 800A489C 1180043C */  lui        $a0, %hi(trackManager)
    /* 950A0 800A48A0 1387000C */  jal        ReleaseDescription__13tTrackManager
    /* 950A4 800A48A4 504A8424 */   addiu     $a0, $a0, %lo(trackManager)
    /* 950A8 800A48A8 1480043C */  lui        $a0, %hi(missionManager)
    /* 950AC 800A48AC B8D28424 */  addiu      $a0, $a0, %lo(missionManager)
    /* 950B0 800A48B0 6ED0000C */  jal        ReleaseDescription__15tMissionManager
    /* 950B4 800A48B4 00000000 */   nop
    /* 950B8 800A48B8 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 950BC 800A48BC 52C9000C */  jal        ReleaseDescription__18tTournamentManager
    /* 950C0 800A48C0 D84A8424 */   addiu     $a0, $a0, %lo(tournamentManager)
    /* 950C4 800A48C4 1180043C */  lui        $a0, %hi(carManager)
    /* 950C8 800A48C8 BD5C000C */  jal        ReleaseDescription__11tCarManager
    /* 950CC 800A48CC 74428424 */   addiu     $a0, $a0, %lo(carManager)
    /* 950D0 800A48D0 21200000 */  addu       $a0, $zero, $zero
    /* 950D4 800A48D4 01000524 */  addiu      $a1, $zero, 0x1
    /* 950D8 800A48D8 7DC1030C */  jal        initlinkmode
    /* 950DC 800A48DC 2130A000 */   addu      $a2, $a1, $zero
    /* 950E0 800A48E0 B791020C */  jal        NFS3_CheckForFileOperations__Fv
    /* 950E4 800A48E4 00000000 */   nop
    /* 950E8 800A48E8 6A90020C */  jal        Nfs2_GameModuleStartUp__FPi
    /* 950EC 800A48EC 21200002 */   addu      $a0, $s0, $zero
    /* 950F0 800A48F0 B791020C */  jal        NFS3_CheckForFileOperations__Fv
    /* 950F4 800A48F4 00000000 */   nop
    /* 950F8 800A48F8 C4E0628E */  lw         $v0, %lo(simVar)($s3)
    /* 950FC 800A48FC 00000000 */  nop
    /* 95100 800A4900 54004010 */  beqz       $v0, .L800A4A54
    /* 95104 800A4904 1180023C */   lui       $v0, %hi(Replay_ReplayInterface)
    /* 95108 800A4908 2C705224 */  addiu      $s2, $v0, %lo(Replay_ReplayInterface)
    /* 9510C 800A490C 01001024 */  addiu      $s0, $zero, 0x1
  .L800A4910:
    /* 95110 800A4910 AA8F020C */  jal        Nfs2_ResetGame__Fv
    /* 95114 800A4914 C4E060AE */   sw        $zero, %lo(simVar)($s3)
    /* 95118 800A4918 53DB020C */  jal        Sim_MainGameLoop__Fv
    /* 9511C 800A491C 00000000 */   nop
    /* 95120 800A4920 2400228E */  lw         $v0, 0x24($s1)
    /* 95124 800A4924 00000000 */  nop
    /* 95128 800A4928 02004228 */  slti       $v0, $v0, 0x2
    /* 9512C 800A492C 05004014 */  bnez       $v0, .L800A4944
    /* 95130 800A4930 00000000 */   nop
    /* 95134 800A4934 2800228E */  lw         $v0, 0x28($s1)
    /* 95138 800A4938 00000000 */  nop
    /* 9513C 800A493C 3F004010 */  beqz       $v0, .L800A4A3C
    /* 95140 800A4940 00000000 */   nop
  .L800A4944:
    /* 95144 800A4944 C4E0628E */  lw         $v0, %lo(simVar)($s3)
    /* 95148 800A4948 00000000 */  nop
    /* 9514C 800A494C 05004010 */  beqz       $v0, .L800A4964
    /* 95150 800A4950 00000000 */   nop
    /* 95154 800A4954 2800228E */  lw         $v0, 0x28($s1)
    /* 95158 800A4958 00000000 */  nop
    /* 9515C 800A495C 39004010 */  beqz       $v0, .L800A4A44
    /* 95160 800A4960 1280023C */   lui       $v0, %hi(simVar)
  .L800A4964:
    /* 95164 800A4964 2800228E */  lw         $v0, 0x28($s1)
    /* 95168 800A4968 00000000 */  nop
    /* 9516C 800A496C 03004010 */  beqz       $v0, .L800A497C
    /* 95170 800A4970 240034AE */   sw        $s4, 0x24($s1)
    /* 95174 800A4974 8A920208 */  j          .L800A4A28
    /* 95178 800A4978 1C0040AE */   sw        $zero, 0x1C($s2)
  .L800A497C:
    /* 9517C 800A497C 6AE0020C */  jal        Stats_GetNumOpponents__Fv
    /* 95180 800A4980 1C0050AE */   sw        $s0, 0x1C($s2)
    /* 95184 800A4984 02004228 */  slti       $v0, $v0, 0x2
    /* 95188 800A4988 27004014 */  bnez       $v0, .L800A4A28
    /* 9518C 800A498C 00000000 */   nop
    /* 95190 800A4990 EC31C38E */  lw         $v1, %lo(GameSetup_gData)($s6)
    /* 95194 800A4994 00000000 */  nop
    /* 95198 800A4998 03007010 */  beq        $v1, $s0, .L800A49A8
    /* 9519C 800A499C 05000224 */   addiu     $v0, $zero, 0x5
    /* 951A0 800A49A0 15006214 */  bne        $v1, $v0, .L800A49F8
    /* 951A4 800A49A4 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
  .L800A49A8:
    /* 951A8 800A49A8 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 951AC 800A49AC 48FA438C */  lw         $v1, %lo(Cars_gHumanRaceCarList)($v0)
    /* 951B0 800A49B0 00000000 */  nop
    /* 951B4 800A49B4 6002638C */  lw         $v1, 0x260($v1)
    /* 951B8 800A49B8 00000000 */  nop
    /* 951BC 800A49BC 00026330 */  andi       $v1, $v1, 0x200
    /* 951C0 800A49C0 19006014 */  bnez       $v1, .L800A4A28
    /* 951C4 800A49C4 48FA4424 */   addiu     $a0, $v0, %lo(Cars_gHumanRaceCarList)
    /* 951C8 800A49C8 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 951CC 800A49CC 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 951D0 800A49D0 00000000 */  nop
    /* 951D4 800A49D4 08005414 */  bne        $v0, $s4, .L800A49F8
    /* 951D8 800A49D8 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* 951DC 800A49DC 0400828C */  lw         $v0, 0x4($a0)
    /* 951E0 800A49E0 00000000 */  nop
    /* 951E4 800A49E4 6002428C */  lw         $v0, 0x260($v0)
    /* 951E8 800A49E8 00000000 */  nop
    /* 951EC 800A49EC 00024230 */  andi       $v0, $v0, 0x200
    /* 951F0 800A49F0 0D004014 */  bnez       $v0, .L800A4A28
    /* 951F4 800A49F4 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
  .L800A49F8:
    /* 951F8 800A49F8 48FA428C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v0)
    /* 951FC 800A49FC 00000000 */  nop
    /* 95200 800A4A00 D003428C */  lw         $v0, 0x3D0($v0)
    /* 95204 800A4A04 00000000 */  nop
    /* 95208 800A4A08 03005014 */  bne        $v0, $s0, .L800A4A18
    /* 9520C 800A4A0C 1480043C */   lui       $a0, %hi(D_8013D2A4)
    /* 95210 800A4A10 88920208 */  j          .L800A4A20
    /* 95214 800A4A14 A4D28424 */   addiu     $a0, $a0, %lo(D_8013D2A4)
  .L800A4A18:
    /* 95218 800A4A18 1480043C */  lui        $a0, %hi(D_8013D2AC)
    /* 9521C 800A4A1C ACD28424 */  addiu      $a0, $a0, %lo(D_8013D2AC)
  .L800A4A20:
    /* 95220 800A4A20 0CEC010C */  jal        AudioMus_PlaySong__FPc
    /* 95224 800A4A24 00000000 */   nop
  .L800A4A28:
    /* 95228 800A4A28 1480013C */  lui        $at, %hi(Replay_ReplayMode)
    /* 9522C 800A4A2C F4D334AC */  sw         $s4, %lo(Replay_ReplayMode)($at)
    /* 95230 800A4A30 C4E070AE */  sw         $s0, %lo(simVar)($s3)
    /* 95234 800A4A34 90920208 */  j          .L800A4A40
    /* 95238 800A4A38 280020AE */   sw        $zero, 0x28($s1)
  .L800A4A3C:
    /* 9523C 800A4A3C 1C0040AE */  sw         $zero, 0x1C($s2)
  .L800A4A40:
    /* 95240 800A4A40 1280023C */  lui        $v0, %hi(simVar)
  .L800A4A44:
    /* 95244 800A4A44 C4E0428C */  lw         $v0, %lo(simVar)($v0)
    /* 95248 800A4A48 00000000 */  nop
    /* 9524C 800A4A4C B0FF4014 */  bnez       $v0, .L800A4910
    /* 95250 800A4A50 00000000 */   nop
  .L800A4A54:
    /* 95254 800A4A54 D590020C */  jal        Nfs2_CleanUpGameModule__Fv
    /* 95258 800A4A58 00000000 */   nop
    /* 9525C 800A4A5C 6E91020C */  jal        NFS4_LoadingIcon__Fv
    /* 95260 800A4A60 00000000 */   nop
    /* 95264 800A4A64 5391020C */  jal        LoadOverlay__Fv
    /* 95268 800A4A68 00000000 */   nop
    /* 9526C 800A4A6C B791020C */  jal        NFS3_CheckForFileOperations__Fv
    /* 95270 800A4A70 00000000 */   nop
    /* 95274 800A4A74 B59E000C */  jal        Front_InitGraphicsAndDisplayLoading__Fv
    /* 95278 800A4A78 00000000 */   nop
    /* 9527C 800A4A7C 00141500 */  sll        $v0, $s5, 16
    /* 95280 800A4A80 03140200 */  sra        $v0, $v0, 16
    /* 95284 800A4A84 B6AD000C */  jal        Front_GetInGameVars__Fv
    /* 95288 800A4A88 240022AE */   sw        $v0, 0x24($s1)
    /* 9528C 800A4A8C 1180043C */  lui        $a0, %hi(carManager)
    /* 95290 800A4A90 4D5C000C */  jal        LoadDescription__11tCarManager
    /* 95294 800A4A94 74428424 */   addiu     $a0, $a0, %lo(carManager)
    /* 95298 800A4A98 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 9529C 800A4A9C BFC8000C */  jal        LoadDescription__18tTournamentManager
    /* 952A0 800A4AA0 D84A8424 */   addiu     $a0, $a0, %lo(tournamentManager)
    /* 952A4 800A4AA4 1180043C */  lui        $a0, %hi(trackManager)
    /* 952A8 800A4AA8 C586000C */  jal        LoadDescription__13tTrackManager
    /* 952AC 800A4AAC 504A8424 */   addiu     $a0, $a0, %lo(trackManager)
    /* 952B0 800A4AB0 1480023C */  lui        $v0, %hi(quitType)
    /* 952B4 800A4AB4 30D4428C */  lw         $v0, %lo(quitType)($v0)
    /* 952B8 800A4AB8 01000424 */  addiu      $a0, $zero, 0x1
    /* 952BC 800A4ABC 02004414 */  bne        $v0, $a0, .L800A4AC8
    /* 952C0 800A4AC0 00000000 */   nop
    /* 952C4 800A4AC4 02000424 */  addiu      $a0, $zero, 0x2
  .L800A4AC8:
    /* 952C8 800A4AC8 BD9E000C */  jal        Front_Menu__F21tFront_ProcessingType
    /* 952CC 800A4ACC 00000000 */   nop
    /* 952D0 800A4AD0 24003596 */  lhu        $s5, 0x24($s1)
    /* 952D4 800A4AD4 B791020C */  jal        NFS3_CheckForFileOperations__Fv
    /* 952D8 800A4AD8 00000000 */   nop
    /* 952DC 800A4ADC 1C920208 */  j          .L800A4870
    /* 952E0 800A4AE0 00000000 */   nop
endlabel main
