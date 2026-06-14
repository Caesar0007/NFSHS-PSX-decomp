.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_GetInterfaceKey__Fv, 0x490

glabel Replay_GetInterfaceKey__Fv
    /* A5870 800B5070 1180023C */  lui        $v0, %hi(D_801131F8)
    /* A5874 800B5074 F831428C */  lw         $v0, %lo(D_801131F8)($v0)
    /* A5878 800B5078 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* A587C 800B507C 2000B4AF */  sw         $s4, 0x20($sp)
    /* A5880 800B5080 01001424 */  addiu      $s4, $zero, 0x1
    /* A5884 800B5084 1400B1AF */  sw         $s1, 0x14($sp)
    /* A5888 800B5088 21888002 */  addu       $s1, $s4, $zero
    /* A588C 800B508C 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* A5890 800B5090 2800B6AF */  sw         $s6, 0x28($sp)
    /* A5894 800B5094 2400B5AF */  sw         $s5, 0x24($sp)
    /* A5898 800B5098 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A589C 800B509C 1800B2AF */  sw         $s2, 0x18($sp)
    /* A58A0 800B50A0 02005114 */  bne        $v0, $s1, .L800B50AC
    /* A58A4 800B50A4 1000B0AF */   sw        $s0, 0x10($sp)
    /* A58A8 800B50A8 02001424 */  addiu      $s4, $zero, 0x2
  .L800B50AC:
    /* A58AC 800B50AC 1180023C */  lui        $v0, %hi(Replay_ReplayInterface)
    /* A58B0 800B50B0 2C705024 */  addiu      $s0, $v0, %lo(Replay_ReplayInterface)
    /* A58B4 800B50B4 1400028E */  lw         $v0, 0x14($s0)
    /* A58B8 800B50B8 00000000 */  nop
    /* A58BC 800B50BC 04004018 */  blez       $v0, .L800B50D0
    /* A58C0 800B50C0 180000AE */   sw        $zero, 0x18($s0)
    /* A58C4 800B50C4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* A58C8 800B50C8 2FD50208 */  j          .L800B54BC
    /* A58CC 800B50CC 140002AE */   sw        $v0, 0x14($s0)
  .L800B50D0:
    /* A58D0 800B50D0 1C00028E */  lw         $v0, 0x1C($s0)
    /* A58D4 800B50D4 00000000 */  nop
    /* A58D8 800B50D8 1D004010 */  beqz       $v0, .L800B5150
    /* A58DC 800B50DC 05000424 */   addiu     $a0, $zero, 0x5
    /* A58E0 800B50E0 21800000 */  addu       $s0, $zero, $zero
    /* A58E4 800B50E4 C674020C */  jal        Input_Interface__FUli
    /* A58E8 800B50E8 01000524 */   addiu     $a1, $zero, 0x1
    /* A58EC 800B50EC 05004014 */  bnez       $v0, .L800B5104
    /* A58F0 800B50F0 06000424 */   addiu     $a0, $zero, 0x6
    /* A58F4 800B50F4 C674020C */  jal        Input_Interface__FUli
    /* A58F8 800B50F8 01000524 */   addiu     $a1, $zero, 0x1
    /* A58FC 800B50FC 02004010 */  beqz       $v0, .L800B5108
    /* A5900 800B5100 00000000 */   nop
  .L800B5104:
    /* A5904 800B5104 01001024 */  addiu      $s0, $zero, 0x1
  .L800B5108:
    /* A5908 800B5108 07000012 */  beqz       $s0, .L800B5128
    /* A590C 800B510C 1180023C */   lui       $v0, %hi(Replay_ReplayInterface)
    /* A5910 800B5110 2C704224 */  addiu      $v0, $v0, %lo(Replay_ReplayInterface)
    /* A5914 800B5114 18000324 */  addiu      $v1, $zero, 0x18
    /* A5918 800B5118 140043AC */  sw         $v1, 0x14($v0)
    /* A591C 800B511C 01000324 */  addiu      $v1, $zero, 0x1
    /* A5920 800B5120 2FD50208 */  j          .L800B54BC
    /* A5924 800B5124 080043AC */   sw        $v1, 0x8($v0)
  .L800B5128:
    /* A5928 800B5128 19000424 */  addiu      $a0, $zero, 0x19
    /* A592C 800B512C C674020C */  jal        Input_Interface__FUli
    /* A5930 800B5130 01000524 */   addiu     $a1, $zero, 0x1
    /* A5934 800B5134 E2004010 */  beqz       $v0, .L800B54C0
    /* A5938 800B5138 1280023C */   lui       $v0, %hi(D_8011E0D4)
    /* A593C 800B513C B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* A5940 800B5140 04000424 */   addiu     $a0, $zero, 0x4
    /* A5944 800B5144 1180023C */  lui        $v0, %hi(D_80117048)
    /* A5948 800B5148 2FD50208 */  j          .L800B54BC
    /* A594C 800B514C 487040AC */   sw        $zero, %lo(D_80117048)($v0)
  .L800B5150:
    /* A5950 800B5150 03000424 */  addiu      $a0, $zero, 0x3
    /* A5954 800B5154 C674020C */  jal        Input_Interface__FUli
    /* A5958 800B5158 01000524 */   addiu     $a1, $zero, 0x1
    /* A595C 800B515C 0C004010 */  beqz       $v0, .L800B5190
    /* A5960 800B5160 04000424 */   addiu     $a0, $zero, 0x4
    /* A5964 800B5164 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* A5968 800B5168 03000424 */   addiu     $a0, $zero, 0x3
    /* A596C 800B516C 1000028E */  lw         $v0, 0x10($s0)
    /* A5970 800B5170 00000000 */  nop
    /* A5974 800B5174 04004014 */  bnez       $v0, .L800B5188
    /* A5978 800B5178 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* A597C 800B517C 04000224 */  addiu      $v0, $zero, 0x4
    /* A5980 800B5180 2FD50208 */  j          .L800B54BC
    /* A5984 800B5184 100002AE */   sw        $v0, 0x10($s0)
  .L800B5188:
    /* A5988 800B5188 2FD50208 */  j          .L800B54BC
    /* A598C 800B518C 100002AE */   sw        $v0, 0x10($s0)
  .L800B5190:
    /* A5990 800B5190 C674020C */  jal        Input_Interface__FUli
    /* A5994 800B5194 01000524 */   addiu     $a1, $zero, 0x1
    /* A5998 800B5198 11004010 */  beqz       $v0, .L800B51E0
    /* A599C 800B519C 05000424 */   addiu     $a0, $zero, 0x5
    /* A59A0 800B51A0 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* A59A4 800B51A4 03000424 */   addiu     $a0, $zero, 0x3
    /* A59A8 800B51A8 6666023C */  lui        $v0, (0x66666667 >> 16)
    /* A59AC 800B51AC 1000048E */  lw         $a0, 0x10($s0)
    /* A59B0 800B51B0 67664234 */  ori        $v0, $v0, (0x66666667 & 0xFFFF)
    /* A59B4 800B51B4 01008424 */  addiu      $a0, $a0, 0x1
    /* A59B8 800B51B8 18008200 */  mult       $a0, $v0
    /* A59BC 800B51BC C3170400 */  sra        $v0, $a0, 31
    /* A59C0 800B51C0 10380000 */  mfhi       $a3
    /* A59C4 800B51C4 43180700 */  sra        $v1, $a3, 1
    /* A59C8 800B51C8 23186200 */  subu       $v1, $v1, $v0
    /* A59CC 800B51CC 80100300 */  sll        $v0, $v1, 2
    /* A59D0 800B51D0 21104300 */  addu       $v0, $v0, $v1
    /* A59D4 800B51D4 23208200 */  subu       $a0, $a0, $v0
    /* A59D8 800B51D8 2FD50208 */  j          .L800B54BC
    /* A59DC 800B51DC 100004AE */   sw        $a0, 0x10($s0)
  .L800B51E0:
    /* A59E0 800B51E0 C674020C */  jal        Input_Interface__FUli
    /* A59E4 800B51E4 01000524 */   addiu     $a1, $zero, 0x1
    /* A59E8 800B51E8 A2004010 */  beqz       $v0, .L800B5474
    /* A59EC 800B51EC 06000424 */   addiu     $a0, $zero, 0x6
    /* A59F0 800B51F0 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* A59F4 800B51F4 04000424 */   addiu     $a0, $zero, 0x4
    /* A59F8 800B51F8 1000038E */  lw         $v1, 0x10($s0)
    /* A59FC 800B51FC 08000224 */  addiu      $v0, $zero, 0x8
    /* A5A00 800B5200 140002AE */  sw         $v0, 0x14($s0)
    /* A5A04 800B5204 0500622C */  sltiu      $v0, $v1, 0x5
    /* A5A08 800B5208 AC004010 */  beqz       $v0, .L800B54BC
    /* A5A0C 800B520C 0580023C */   lui       $v0, %hi(jtbl_80056578)
    /* A5A10 800B5210 78654224 */  addiu      $v0, $v0, %lo(jtbl_80056578)
    /* A5A14 800B5214 80180300 */  sll        $v1, $v1, 2
    /* A5A18 800B5218 21186200 */  addu       $v1, $v1, $v0
    /* A5A1C 800B521C 0000628C */  lw         $v0, 0x0($v1)
    /* A5A20 800B5220 00000000 */  nop
    /* A5A24 800B5224 08004000 */  jr         $v0
    /* A5A28 800B5228 00000000 */   nop
  jlabel .L800B522C
    /* A5A2C 800B522C 1180023C */  lui        $v0, %hi(D_80117034)
    /* A5A30 800B5230 01000324 */  addiu      $v1, $zero, 0x1
    /* A5A34 800B5234 347043AC */  sw         $v1, %lo(D_80117034)($v0)
    /* A5A38 800B5238 1180023C */  lui        $v0, %hi(D_80113214)
    /* A5A3C 800B523C 2FD50208 */  j          .L800B54BC
    /* A5A40 800B5240 143243AC */   sw        $v1, %lo(D_80113214)($v0)
  jlabel .L800B5244
    /* A5A44 800B5244 1180033C */  lui        $v1, %hi(D_80117034)
    /* A5A48 800B5248 01000224 */  addiu      $v0, $zero, 0x1
    /* A5A4C 800B524C 2FD50208 */  j          .L800B54BC
    /* A5A50 800B5250 347062AC */   sw        $v0, %lo(D_80117034)($v1)
  jlabel .L800B5254
    /* A5A54 800B5254 1180033C */  lui        $v1, %hi(Replay_ReplayInterface)
    /* A5A58 800B5258 2C70628C */  lw         $v0, %lo(Replay_ReplayInterface)($v1)
    /* A5A5C 800B525C 00000000 */  nop
    /* A5A60 800B5260 01004238 */  xori       $v0, $v0, 0x1
    /* A5A64 800B5264 2FD50208 */  j          .L800B54BC
    /* A5A68 800B5268 2C7062AC */   sw        $v0, %lo(Replay_ReplayInterface)($v1)
  jlabel .L800B526C
    /* A5A6C 800B526C 1180023C */  lui        $v0, %hi(D_801131F8)
    /* A5A70 800B5270 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* A5A74 800B5274 01000224 */  addiu      $v0, $zero, 0x1
    /* A5A78 800B5278 10006214 */  bne        $v1, $v0, .L800B52BC
    /* A5A7C 800B527C 1180023C */   lui       $v0, %hi(Replay_ReplayInterface)
    /* A5A80 800B5280 5555023C */  lui        $v0, (0x55555556 >> 16)
    /* A5A84 800B5284 1180053C */  lui        $a1, %hi(Replay_ReplayInterface)
    /* A5A88 800B5288 2C70A524 */  addiu      $a1, $a1, %lo(Replay_ReplayInterface)
    /* A5A8C 800B528C 0400A48C */  lw         $a0, 0x4($a1)
    /* A5A90 800B5290 56554234 */  ori        $v0, $v0, (0x55555556 & 0xFFFF)
    /* A5A94 800B5294 01008424 */  addiu      $a0, $a0, 0x1
    /* A5A98 800B5298 18008200 */  mult       $a0, $v0
    /* A5A9C 800B529C C31F0400 */  sra        $v1, $a0, 31
    /* A5AA0 800B52A0 10380000 */  mfhi       $a3
    /* A5AA4 800B52A4 2318E300 */  subu       $v1, $a3, $v1
    /* A5AA8 800B52A8 40100300 */  sll        $v0, $v1, 1
    /* A5AAC 800B52AC 21104300 */  addu       $v0, $v0, $v1
    /* A5AB0 800B52B0 23208200 */  subu       $a0, $a0, $v0
    /* A5AB4 800B52B4 2FD50208 */  j          .L800B54BC
    /* A5AB8 800B52B8 0400A4AC */   sw        $a0, 0x4($a1)
  .L800B52BC:
    /* A5ABC 800B52BC 2C704524 */  addiu      $a1, $v0, %lo(Replay_ReplayInterface)
    /* A5AC0 800B52C0 0400A48C */  lw         $a0, 0x4($a1)
    /* A5AC4 800B52C4 00000000 */  nop
    /* A5AC8 800B52C8 01008324 */  addiu      $v1, $a0, 0x1
    /* A5ACC 800B52CC 02006104 */  bgez       $v1, .L800B52D8
    /* A5AD0 800B52D0 21106000 */   addu      $v0, $v1, $zero
    /* A5AD4 800B52D4 04008224 */  addiu      $v0, $a0, 0x4
  .L800B52D8:
    /* A5AD8 800B52D8 83100200 */  sra        $v0, $v0, 2
    /* A5ADC 800B52DC 80100200 */  sll        $v0, $v0, 2
    /* A5AE0 800B52E0 23106200 */  subu       $v0, $v1, $v0
    /* A5AE4 800B52E4 2FD50208 */  j          .L800B54BC
    /* A5AE8 800B52E8 0400A2AC */   sw        $v0, 0x4($a1)
  jlabel .L800B52EC
    /* A5AEC 800B52EC E338033C */  lui        $v1, (0x38E38E39 >> 16)
    /* A5AF0 800B52F0 1180023C */  lui        $v0, %hi(Replay_ReplayInterface)
    /* A5AF4 800B52F4 2C704524 */  addiu      $a1, $v0, %lo(Replay_ReplayInterface)
    /* A5AF8 800B52F8 0C00A48C */  lw         $a0, 0xC($a1)
    /* A5AFC 800B52FC 398E6334 */  ori        $v1, $v1, (0x38E38E39 & 0xFFFF)
    /* A5B00 800B5300 01008424 */  addiu      $a0, $a0, 0x1
    /* A5B04 800B5304 18008300 */  mult       $a0, $v1
    /* A5B08 800B5308 01000224 */  addiu      $v0, $zero, 0x1
    /* A5B0C 800B530C 1800A2AC */  sw         $v0, 0x18($a1)
    /* A5B10 800B5310 10380000 */  mfhi       $a3
    /* A5B14 800B5314 07184700 */  srav       $v1, $a3, $v0
    /* A5B18 800B5318 C3170400 */  sra        $v0, $a0, 31
    /* A5B1C 800B531C 23186200 */  subu       $v1, $v1, $v0
    /* A5B20 800B5320 C0100300 */  sll        $v0, $v1, 3
    /* A5B24 800B5324 21104300 */  addu       $v0, $v0, $v1
    /* A5B28 800B5328 23208200 */  subu       $a0, $a0, $v0
    /* A5B2C 800B532C 1180023C */  lui        $v0, %hi(ReplayCameraList)
    /* A5B30 800B5330 08704624 */  addiu      $a2, $v0, %lo(ReplayCameraList)
    /* A5B34 800B5334 0C00A4AC */  sw         $a0, 0xC($a1)
    /* A5B38 800B5338 80200400 */  sll        $a0, $a0, 2
    /* A5B3C 800B533C 21208600 */  addu       $a0, $a0, $a2
    /* A5B40 800B5340 0000838C */  lw         $v1, 0x0($a0)
    /* A5B44 800B5344 13000224 */  addiu      $v0, $zero, 0x13
    /* A5B48 800B5348 25006214 */  bne        $v1, $v0, .L800B53E0
    /* A5B4C 800B534C 00000000 */   nop
    /* A5B50 800B5350 5A008012 */  beqz       $s4, .L800B54BC
    /* A5B54 800B5354 21800000 */   addu      $s0, $zero, $zero
    /* A5B58 800B5358 1180023C */  lui        $v0, %hi(Replay_ReplayCamera)
    /* A5B5C 800B535C 4C705324 */  addiu      $s3, $v0, %lo(Replay_ReplayCamera)
    /* A5B60 800B5360 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* A5B64 800B5364 48FA5124 */  addiu      $s1, $v0, %lo(Cars_gHumanRaceCarList)
    /* A5B68 800B5368 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* A5B6C 800B536C ACF25224 */  addiu      $s2, $v0, %lo(Camera_gInfo)
  .L800B5370:
    /* A5B70 800B5370 A40E828F */  lw         $v0, %gp_rel(numValidCams)($gp)
    /* A5B74 800B5374 00000000 */  nop
    /* A5B78 800B5378 0F004010 */  beqz       $v0, .L800B53B8
    /* A5B7C 800B537C 21200002 */   addu      $a0, $s0, $zero
    /* A5B80 800B5380 0000228E */  lw         $v0, 0x0($s1)
    /* A5B84 800B5384 00000000 */  nop
    /* A5B88 800B5388 000042AE */  sw         $v0, 0x0($s2)
    /* A5B8C 800B538C 0000228E */  lw         $v0, 0x0($s1)
    /* A5B90 800B5390 00000000 */  nop
    /* A5B94 800B5394 040042AE */  sw         $v0, 0x4($s2)
    /* A5B98 800B5398 0000228E */  lw         $v0, 0x0($s1)
    /* A5B9C 800B539C 00000000 */  nop
    /* A5BA0 800B53A0 08004584 */  lh         $a1, 0x8($v0)
    /* A5BA4 800B53A4 C5D6020C */  jal        Replay_ReplayFindClosestCamera__Fii
    /* A5BA8 800B53A8 21200002 */   addu      $a0, $s0, $zero
    /* A5BAC 800B53AC 13000224 */  addiu      $v0, $zero, 0x13
    /* A5BB0 800B53B0 F0D40208 */  j          .L800B53C0
    /* A5BB4 800B53B4 080062AE */   sw        $v0, 0x8($s3)
  .L800B53B8:
    /* A5BB8 800B53B8 8215020C */  jal        Camera_SetMode__Fii
    /* A5BBC 800B53BC 0A000524 */   addiu     $a1, $zero, 0xA
  .L800B53C0:
    /* A5BC0 800B53C0 10007326 */  addiu      $s3, $s3, 0x10
    /* A5BC4 800B53C4 04003126 */  addiu      $s1, $s1, 0x4
    /* A5BC8 800B53C8 01001026 */  addiu      $s0, $s0, 0x1
    /* A5BCC 800B53CC 2A101402 */  slt        $v0, $s0, $s4
    /* A5BD0 800B53D0 E7FF4014 */  bnez       $v0, .L800B5370
    /* A5BD4 800B53D4 10015226 */   addiu     $s2, $s2, 0x110
    /* A5BD8 800B53D8 30D50208 */  j          .L800B54C0
    /* A5BDC 800B53DC 1280023C */   lui       $v0, %hi(D_8011E0D4)
  .L800B53E0:
    /* A5BE0 800B53E0 36008012 */  beqz       $s4, .L800B54BC
    /* A5BE4 800B53E4 21800000 */   addu      $s0, $zero, $zero
    /* A5BE8 800B53E8 21B0C000 */  addu       $s6, $a2, $zero
    /* A5BEC 800B53EC 21A8A000 */  addu       $s5, $a1, $zero
    /* A5BF0 800B53F0 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* A5BF4 800B53F4 48FA5324 */  addiu      $s3, $v0, %lo(Cars_gHumanRaceCarList)
    /* A5BF8 800B53F8 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* A5BFC 800B53FC ACF25124 */  addiu      $s1, $v0, %lo(Camera_gInfo)
    /* A5C00 800B5400 1180023C */  lui        $v0, %hi(Replay_ReplayCamera)
    /* A5C04 800B5404 4C705224 */  addiu      $s2, $v0, %lo(Replay_ReplayCamera)
  .L800B5408:
    /* A5C08 800B5408 000040AE */  sw         $zero, 0x0($s2)
    /* A5C0C 800B540C 540020AE */  sw         $zero, 0x54($s1)
    /* A5C10 800B5410 0000628E */  lw         $v0, 0x0($s3)
    /* A5C14 800B5414 00000000 */  nop
    /* A5C18 800B5418 000022AE */  sw         $v0, 0x0($s1)
    /* A5C1C 800B541C 0000628E */  lw         $v0, 0x0($s3)
    /* A5C20 800B5420 00000000 */  nop
    /* A5C24 800B5424 040022AE */  sw         $v0, 0x4($s1)
    /* A5C28 800B5428 0C00A28E */  lw         $v0, 0xC($s5)
    /* A5C2C 800B542C 21200002 */  addu       $a0, $s0, $zero
    /* A5C30 800B5430 80100200 */  sll        $v0, $v0, 2
    /* A5C34 800B5434 21105600 */  addu       $v0, $v0, $s6
    /* A5C38 800B5438 0000458C */  lw         $a1, 0x0($v0)
    /* A5C3C 800B543C 8215020C */  jal        Camera_SetMode__Fii
    /* A5C40 800B5440 01001026 */   addiu     $s0, $s0, 0x1
    /* A5C44 800B5444 0C00A28E */  lw         $v0, 0xC($s5)
    /* A5C48 800B5448 04007326 */  addiu      $s3, $s3, 0x4
    /* A5C4C 800B544C 80100200 */  sll        $v0, $v0, 2
    /* A5C50 800B5450 21105600 */  addu       $v0, $v0, $s6
    /* A5C54 800B5454 0000428C */  lw         $v0, 0x0($v0)
    /* A5C58 800B5458 10013126 */  addiu      $s1, $s1, 0x110
    /* A5C5C 800B545C 080042AE */  sw         $v0, 0x8($s2)
    /* A5C60 800B5460 2A101402 */  slt        $v0, $s0, $s4
    /* A5C64 800B5464 E8FF4014 */  bnez       $v0, .L800B5408
    /* A5C68 800B5468 10005226 */   addiu     $s2, $s2, 0x10
    /* A5C6C 800B546C 30D50208 */  j          .L800B54C0
    /* A5C70 800B5470 1280023C */   lui       $v0, %hi(D_8011E0D4)
  .L800B5474:
    /* A5C74 800B5474 C674020C */  jal        Input_Interface__FUli
    /* A5C78 800B5478 01000524 */   addiu     $a1, $zero, 0x1
    /* A5C7C 800B547C 04004010 */  beqz       $v0, .L800B5490
    /* A5C80 800B5480 08000224 */   addiu     $v0, $zero, 0x8
    /* A5C84 800B5484 140002AE */  sw         $v0, 0x14($s0)
    /* A5C88 800B5488 2FD50208 */  j          .L800B54BC
    /* A5C8C 800B548C 080011AE */   sw        $s1, 0x8($s0)
  .L800B5490:
    /* A5C90 800B5490 19000424 */  addiu      $a0, $zero, 0x19
    /* A5C94 800B5494 C674020C */  jal        Input_Interface__FUli
    /* A5C98 800B5498 01000524 */   addiu     $a1, $zero, 0x1
    /* A5C9C 800B549C 07004010 */  beqz       $v0, .L800B54BC
    /* A5CA0 800B54A0 04000424 */   addiu     $a0, $zero, 0x4
    /* A5CA4 800B54A4 1480013C */  lui        $at, %hi(StatsTimer)
    /* A5CA8 800B54A8 98D920AC */  sw         $zero, %lo(StatsTimer)($at)
    /* A5CAC 800B54AC 1480013C */  lui        $at, %hi(D_8013D99C)
    /* A5CB0 800B54B0 9CD920AC */  sw         $zero, %lo(D_8013D99C)($at)
    /* A5CB4 800B54B4 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* A5CB8 800B54B8 1C0011AE */   sw        $s1, 0x1C($s0)
  .L800B54BC:
    /* A5CBC 800B54BC 1280023C */  lui        $v0, %hi(D_8011E0D4)
  .L800B54C0:
    /* A5CC0 800B54C0 D4E0428C */  lw         $v0, %lo(D_8011E0D4)($v0)
    /* A5CC4 800B54C4 00000000 */  nop
    /* A5CC8 800B54C8 03004010 */  beqz       $v0, .L800B54D8
    /* A5CCC 800B54CC 00000000 */   nop
    /* A5CD0 800B54D0 F60C020C */  jal        Camera_Update__Fv
    /* A5CD4 800B54D4 00000000 */   nop
  .L800B54D8:
    /* A5CD8 800B54D8 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* A5CDC 800B54DC 2800B68F */  lw         $s6, 0x28($sp)
    /* A5CE0 800B54E0 2400B58F */  lw         $s5, 0x24($sp)
    /* A5CE4 800B54E4 2000B48F */  lw         $s4, 0x20($sp)
    /* A5CE8 800B54E8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* A5CEC 800B54EC 1800B28F */  lw         $s2, 0x18($sp)
    /* A5CF0 800B54F0 1400B18F */  lw         $s1, 0x14($sp)
    /* A5CF4 800B54F4 1000B08F */  lw         $s0, 0x10($sp)
    /* A5CF8 800B54F8 0800E003 */  jr         $ra
    /* A5CFC 800B54FC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Replay_GetInterfaceKey__Fv
