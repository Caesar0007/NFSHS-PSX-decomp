.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RunDemoVideo__14tFEApplication, 0x290

glabel RunDemoVideo__14tFEApplication
    /* 4814 80014014 0580023C */  lui        $v0, %hi(menuDefs)
    /* 4818 80014018 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 481C 8001401C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 4820 80014020 4000B2AF */  sw         $s2, 0x40($sp)
    /* 4824 80014024 21908000 */  addu       $s2, $a0, $zero
    /* 4828 80014028 4400BFAF */  sw         $ra, 0x44($sp)
    /* 482C 8001402C 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 4830 80014030 3800B0AF */  sw         $s0, 0x38($sp)
    /* 4834 80014034 0400438E */  lw         $v1, 0x4($s2)
    /* 4838 80014038 B0004224 */  addiu      $v0, $v0, 0xB0
    /* 483C 8001403C 93006214 */  bne        $v1, $v0, .L8001428C
    /* 4840 80014040 00000000 */   nop
    /* 4844 80014044 81EB010C */  jal        AudioMus_StopSong__Fi
    /* 4848 80014048 78000424 */   addiu     $a0, $zero, 0x78
    /* 484C 8001404C 5256000C */  jal        FeAudio_systemtask__Fi
    /* 4850 80014050 21200000 */   addu      $a0, $zero, $zero
    /* 4854 80014054 0400438E */  lw         $v1, 0x4($s2)
    /* 4858 80014058 00000000 */  nop
    /* 485C 8001405C 6800628C */  lw         $v0, 0x68($v1)
    /* 4860 80014060 00000000 */  nop
    /* 4864 80014064 28004484 */  lh         $a0, 0x28($v0)
    /* 4868 80014068 2C00428C */  lw         $v0, 0x2C($v0)
    /* 486C 8001406C 00000000 */  nop
    /* 4870 80014070 09F84000 */  jalr       $v0
    /* 4874 80014074 21206400 */   addu      $a0, $v1, $a0
    /* 4878 80014078 02000524 */  addiu      $a1, $zero, 0x2
    /* 487C 8001407C 0C00448E */  lw         $a0, 0xC($s2)
    /* 4880 80014080 019A000C */  jal        TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
    /* 4884 80014084 21300000 */   addu      $a2, $zero, $zero
  .L80014088:
    /* 4888 80014088 0400438E */  lw         $v1, 0x4($s2)
    /* 488C 8001408C 00000000 */  nop
    /* 4890 80014090 6800628C */  lw         $v0, 0x68($v1)
    /* 4894 80014094 21800000 */  addu       $s0, $zero, $zero
    /* 4898 80014098 38004484 */  lh         $a0, 0x38($v0)
    /* 489C 8001409C 3C00428C */  lw         $v0, 0x3C($v0)
    /* 48A0 800140A0 00000000 */  nop
    /* 48A4 800140A4 09F84000 */  jalr       $v0
    /* 48A8 800140A8 21206400 */   addu      $a0, $v1, $a0
    /* 48AC 800140AC 0C004010 */  beqz       $v0, .L800140E0
    /* 48B0 800140B0 00000000 */   nop
    /* 48B4 800140B4 0C00438E */  lw         $v1, 0xC($s2)
    /* 48B8 800140B8 00000000 */  nop
    /* 48BC 800140BC 6000628C */  lw         $v0, 0x60($v1)
    /* 48C0 800140C0 00000000 */  nop
    /* 48C4 800140C4 40004484 */  lh         $a0, 0x40($v0)
    /* 48C8 800140C8 4400428C */  lw         $v0, 0x44($v0)
    /* 48CC 800140CC 00000000 */  nop
    /* 48D0 800140D0 09F84000 */  jalr       $v0
    /* 48D4 800140D4 21206400 */   addu      $a0, $v1, $a0
    /* 48D8 800140D8 02004014 */  bnez       $v0, .L800140E4
    /* 48DC 800140DC 00000000 */   nop
  .L800140E0:
    /* 48E0 800140E0 01001024 */  addiu      $s0, $zero, 0x1
  .L800140E4:
    /* 48E4 800140E4 07000012 */  beqz       $s0, .L80014104
    /* 48E8 800140E8 00000000 */   nop
    /* 48EC 800140EC CF4D000C */  jal        Redraw__14tFEApplication
    /* 48F0 800140F0 21204002 */   addu      $a0, $s2, $zero
    /* 48F4 800140F4 5256000C */  jal        FeAudio_systemtask__Fi
    /* 48F8 800140F8 21200000 */   addu      $a0, $zero, $zero
    /* 48FC 800140FC 22500008 */  j          .L80014088
    /* 4900 80014100 00000000 */   nop
  .L80014104:
    /* 4904 80014104 0C00438E */  lw         $v1, 0xC($s2)
    /* 4908 80014108 00000000 */  nop
    /* 490C 8001410C 6000628C */  lw         $v0, 0x60($v1)
    /* 4910 80014110 00000000 */  nop
    /* 4914 80014114 38004484 */  lh         $a0, 0x38($v0)
    /* 4918 80014118 3C00428C */  lw         $v0, 0x3C($v0)
    /* 491C 8001411C 00000000 */  nop
    /* 4920 80014120 09F84000 */  jalr       $v0
    /* 4924 80014124 21206400 */   addu      $a0, $v1, $a0
    /* 4928 80014128 47EF020C */  jal        Audio_FECleanUp__Fv
    /* 492C 8001412C 0580113C */   lui       $s1, %hi(D_800514BC)
    /* 4930 80014130 19EF020C */  jal        Audio_DeInitDriver__Fv
    /* 4934 80014134 0580103C */   lui       $s0, %hi(gLargestUnused)
    /* 4938 80014138 0C36010C */  jal        PSXFront_FreeDrawMemory__Fv
    /* 493C 8001413C 00000000 */   nop
    /* 4940 80014140 249B000C */  jal        FeTools_deinit__Fv
    /* 4944 80014144 00000000 */   nop
    /* 4948 80014148 E64F000C */  jal        func_80013F98
    /* 494C 8001414C 00000000 */   nop
    /* 4950 80014150 A194030C */  jal        largestunused
    /* 4954 80014154 00000000 */   nop
    /* 4958 80014158 BC142492 */  lbu        $a0, %lo(D_800514BC)($s1)
    /* 495C 8001415C B81402AE */  sw         $v0, %lo(gLargestUnused)($s0)
    /* 4960 80014160 01008424 */  addiu      $a0, $a0, 0x1
    /* 4964 80014164 BD33010C */  jal        play_movie__Fc
    /* 4968 80014168 FF008430 */   andi      $a0, $a0, 0xFF
    /* 496C 8001416C A194030C */  jal        largestunused
    /* 4970 80014170 00000000 */   nop
    /* 4974 80014174 EF35010C */  jal        PSXFront_AllocateDrawMemory__Fv
    /* 4978 80014178 B81402AE */   sw        $v0, %lo(gLargestUnused)($s0)
    /* 497C 8001417C EA9A000C */  jal        FeTools_init__Fv
    /* 4980 80014180 00000000 */   nop
    /* 4984 80014184 AE96000C */  jal        DisplayLoadingText__7tScreen
    /* 4988 80014188 00000000 */   nop
    /* 498C 8001418C 00D80434 */  ori        $a0, $zero, 0xD800
    /* 4990 80014190 0100053C */  lui        $a1, (0x18000 >> 16)
    /* 4994 80014194 E1EE020C */  jal        Audio_InitDriver__Fii
    /* 4998 80014198 0080A534 */   ori       $a1, $a1, (0x18000 & 0xFFFF)
    /* 499C 8001419C CEDD010C */  jal        AudioCmn_LoadFESamples__Fv
    /* 49A0 800141A0 00000000 */   nop
    /* 49A4 800141A4 ED3A010C */  jal        LoadAllHelpShapes__Fv
    /* 49A8 800141A8 00000000 */   nop
    /* 49AC 800141AC 584F000C */  jal        UpdateMusic__14tFEApplication
    /* 49B0 800141B0 21204002 */   addu      $a0, $s2, $zero
    /* 49B4 800141B4 1180023C */  lui        $v0, %hi(D_80114941)
    /* 49B8 800141B8 41494290 */  lbu        $v0, %lo(D_80114941)($v0)
    /* 49BC 800141BC 00000000 */  nop
    /* 49C0 800141C0 C0200200 */  sll        $a0, $v0, 3
    /* 49C4 800141C4 21208200 */  addu       $a0, $a0, $v0
    /* 49C8 800141C8 80200400 */  sll        $a0, $a0, 2
    /* 49CC 800141CC 23208200 */  subu       $a0, $a0, $v0
    /* 49D0 800141D0 ACEC010C */  jal        AudioMus_Volume__Fi
    /* 49D4 800141D4 83210400 */   sra       $a0, $a0, 6
    /* 49D8 800141D8 A194030C */  jal        largestunused
    /* 49DC 800141DC 00000000 */   nop
    /* 49E0 800141E0 0400458E */  lw         $a1, 0x4($s2)
    /* 49E4 800141E4 00000000 */  nop
    /* 49E8 800141E8 6800A38C */  lw         $v1, 0x68($a1)
    /* 49EC 800141EC B81402AE */  sw         $v0, %lo(gLargestUnused)($s0)
    /* 49F0 800141F0 10006484 */  lh         $a0, 0x10($v1)
    /* 49F4 800141F4 1400628C */  lw         $v0, 0x14($v1)
    /* 49F8 800141F8 00000000 */  nop
    /* 49FC 800141FC 09F84000 */  jalr       $v0
    /* 4A00 80014200 2120A400 */   addu      $a0, $a1, $a0
    /* 4A04 80014204 0C00438E */  lw         $v1, 0xC($s2)
    /* 4A08 80014208 00000000 */  nop
    /* 4A0C 8001420C 6000628C */  lw         $v0, 0x60($v1)
    /* 4A10 80014210 00000000 */  nop
    /* 4A14 80014214 30004484 */  lh         $a0, 0x30($v0)
    /* 4A18 80014218 3400428C */  lw         $v0, 0x34($v0)
    /* 4A1C 8001421C 00000000 */  nop
    /* 4A20 80014220 09F84000 */  jalr       $v0
    /* 4A24 80014224 21206400 */   addu      $a0, $v1, $a0
    /* 4A28 80014228 0400438E */  lw         $v1, 0x4($s2)
    /* 4A2C 8001422C 00000000 */  nop
    /* 4A30 80014230 6800628C */  lw         $v0, 0x68($v1)
    /* 4A34 80014234 00000000 */  nop
    /* 4A38 80014238 30004484 */  lh         $a0, 0x30($v0)
    /* 4A3C 8001423C 3400428C */  lw         $v0, 0x34($v0)
    /* 4A40 80014240 00000000 */  nop
    /* 4A44 80014244 09F84000 */  jalr       $v0
    /* 4A48 80014248 21206400 */   addu      $a0, $v1, $a0
    /* 4A4C 8001424C 02000524 */  addiu      $a1, $zero, 0x2
    /* 4A50 80014250 0C00448E */  lw         $a0, 0xC($s2)
    /* 4A54 80014254 099A000C */  jal        TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu
    /* 4A58 80014258 21300000 */   addu      $a2, $zero, $zero
    /* 4A5C 8001425C 5555023C */  lui        $v0, (0x55555556 >> 16)
    /* 4A60 80014260 BC14248E */  lw         $a0, %lo(D_800514BC)($s1)
    /* 4A64 80014264 56554234 */  ori        $v0, $v0, (0x55555556 & 0xFFFF)
    /* 4A68 80014268 01008424 */  addiu      $a0, $a0, 0x1
    /* 4A6C 8001426C 18008200 */  mult       $a0, $v0
    /* 4A70 80014270 C31F0400 */  sra        $v1, $a0, 31
    /* 4A74 80014274 10380000 */  mfhi       $a3
    /* 4A78 80014278 2318E300 */  subu       $v1, $a3, $v1
    /* 4A7C 8001427C 40100300 */  sll        $v0, $v1, 1
    /* 4A80 80014280 21104300 */  addu       $v0, $v0, $v1
    /* 4A84 80014284 23208200 */  subu       $a0, $a0, $v0
    /* 4A88 80014288 BC1424AE */  sw         $a0, %lo(D_800514BC)($s1)
  .L8001428C:
    /* 4A8C 8001428C 4400BF8F */  lw         $ra, 0x44($sp)
    /* 4A90 80014290 4000B28F */  lw         $s2, 0x40($sp)
    /* 4A94 80014294 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 4A98 80014298 3800B08F */  lw         $s0, 0x38($sp)
    /* 4A9C 8001429C 0800E003 */  jr         $ra
    /* 4AA0 800142A0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel RunDemoVideo__14tFEApplication
