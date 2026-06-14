.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_ReplayChooseCamera__Fii, 0x2A8

glabel Replay_ReplayChooseCamera__Fii
    /* A606C 800B586C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A6070 800B5870 21508000 */  addu       $t2, $a0, $zero
    /* A6074 800B5874 1180033C */  lui        $v1, %hi(Replay_ReplayCamera)
    /* A6078 800B5878 4C706324 */  addiu      $v1, $v1, %lo(Replay_ReplayCamera)
    /* A607C 800B587C 00110A00 */  sll        $v0, $t2, 4
    /* A6080 800B5880 21104300 */  addu       $v0, $v0, $v1
    /* A6084 800B5884 1000BFAF */  sw         $ra, 0x10($sp)
    /* A6088 800B5888 0C00498C */  lw         $t1, 0xC($v0)
    /* A608C 800B588C 00000000 */  nop
    /* A6090 800B5890 FFFF2725 */  addiu      $a3, $t1, -0x1
    /* A6094 800B5894 0400E104 */  bgez       $a3, .L800B58A8
    /* A6098 800B5898 00000000 */   nop
    /* A609C 800B589C A40E828F */  lw         $v0, %gp_rel(numValidCams)($gp)
    /* A60A0 800B58A0 00000000 */  nop
    /* A60A4 800B58A4 FFFF4724 */  addiu      $a3, $v0, -0x1
  .L800B58A8:
    /* A60A8 800B58A8 A40E828F */  lw         $v0, %gp_rel(numValidCams)($gp)
    /* A60AC 800B58AC 01002325 */  addiu      $v1, $t1, 0x1
    /* A60B0 800B58B0 2A106200 */  slt        $v0, $v1, $v0
    /* A60B4 800B58B4 02004010 */  beqz       $v0, .L800B58C0
    /* A60B8 800B58B8 21400000 */   addu      $t0, $zero, $zero
    /* A60BC 800B58BC 21406000 */  addu       $t0, $v1, $zero
  .L800B58C0:
    /* A60C0 800B58C0 1280043C */  lui        $a0, %hi(gReplayCameraSlots)
    /* A60C4 800B58C4 DCDB8424 */  addiu      $a0, $a0, %lo(gReplayCameraSlots)
    /* A60C8 800B58C8 40110900 */  sll        $v0, $t1, 5
    /* A60CC 800B58CC 21104400 */  addu       $v0, $v0, $a0
    /* A60D0 800B58D0 40190800 */  sll        $v1, $t0, 5
    /* A60D4 800B58D4 21186400 */  addu       $v1, $v1, $a0
    /* A60D8 800B58D8 1E004684 */  lh         $a2, 0x1E($v0)
    /* A60DC 800B58DC 1E006384 */  lh         $v1, 0x1E($v1)
    /* A60E0 800B58E0 2A10A600 */  slt        $v0, $a1, $a2
    /* A60E4 800B58E4 11004010 */  beqz       $v0, .L800B592C
    /* A60E8 800B58E8 2310A600 */   subu      $v0, $a1, $a2
    /* A60EC 800B58EC 05004018 */  blez       $v0, .L800B5904
    /* A60F0 800B58F0 C8004228 */   slti      $v0, $v0, 0xC8
    /* A60F4 800B58F4 07004014 */  bnez       $v0, .L800B5914
    /* A60F8 800B58F8 2A10A300 */   slt       $v0, $a1, $v1
    /* A60FC 800B58FC 4CD60208 */  j          .L800B5930
    /* A6100 800B5900 00000000 */   nop
  .L800B5904:
    /* A6104 800B5904 2310C500 */  subu       $v0, $a2, $a1
    /* A6108 800B5908 C8004228 */  slti       $v0, $v0, 0xC8
    /* A610C 800B590C 08004010 */  beqz       $v0, .L800B5930
    /* A6110 800B5910 2A10A300 */   slt       $v0, $a1, $v1
  .L800B5914:
    /* A6114 800B5914 1180033C */  lui        $v1, %hi(Replay_ReplayCamera)
    /* A6118 800B5918 4C706324 */  addiu      $v1, $v1, %lo(Replay_ReplayCamera)
    /* A611C 800B591C 00110A00 */  sll        $v0, $t2, 4
    /* A6120 800B5920 21104300 */  addu       $v0, $v0, $v1
    /* A6124 800B5924 5DD60208 */  j          .L800B5974
    /* A6128 800B5928 0C0047AC */   sw        $a3, 0xC($v0)
  .L800B592C:
    /* A612C 800B592C 2A10A300 */  slt        $v0, $a1, $v1
  .L800B5930:
    /* A6130 800B5930 11004014 */  bnez       $v0, .L800B5978
    /* A6134 800B5934 1180023C */   lui       $v0, %hi(Replay_ReplayCamera)
    /* A6138 800B5938 2310A300 */  subu       $v0, $a1, $v1
    /* A613C 800B593C 05004018 */  blez       $v0, .L800B5954
    /* A6140 800B5940 C8004228 */   slti      $v0, $v0, 0xC8
    /* A6144 800B5944 07004014 */  bnez       $v0, .L800B5964
    /* A6148 800B5948 1180033C */   lui       $v1, %hi(Replay_ReplayCamera)
    /* A614C 800B594C 5ED60208 */  j          .L800B5978
    /* A6150 800B5950 1180023C */   lui       $v0, %hi(Replay_ReplayCamera)
  .L800B5954:
    /* A6154 800B5954 23106500 */  subu       $v0, $v1, $a1
    /* A6158 800B5958 C8004228 */  slti       $v0, $v0, 0xC8
    /* A615C 800B595C 05004010 */  beqz       $v0, .L800B5974
    /* A6160 800B5960 1180033C */   lui       $v1, %hi(Replay_ReplayCamera)
  .L800B5964:
    /* A6164 800B5964 4C706324 */  addiu      $v1, $v1, %lo(Replay_ReplayCamera)
    /* A6168 800B5968 00110A00 */  sll        $v0, $t2, 4
    /* A616C 800B596C 21104300 */  addu       $v0, $v0, $v1
    /* A6170 800B5970 0C0048AC */  sw         $t0, 0xC($v0)
  .L800B5974:
    /* A6174 800B5974 1180023C */  lui        $v0, %hi(Replay_ReplayCamera)
  .L800B5978:
    /* A6178 800B5978 4C704224 */  addiu      $v0, $v0, %lo(Replay_ReplayCamera)
    /* A617C 800B597C 00190A00 */  sll        $v1, $t2, 4
    /* A6180 800B5980 21186200 */  addu       $v1, $v1, $v0
    /* A6184 800B5984 0C00628C */  lw         $v0, 0xC($v1)
    /* A6188 800B5988 00000000 */  nop
    /* A618C 800B598C 5D004910 */  beq        $v0, $t1, .L800B5B04
    /* A6190 800B5990 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* A6194 800B5994 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* A6198 800B5998 01000224 */  addiu      $v0, $zero, 0x1
    /* A619C 800B599C 03006210 */  beq        $v1, $v0, .L800B59AC
    /* A61A0 800B59A0 05000224 */   addiu     $v0, $zero, 0x5
    /* A61A4 800B59A4 16006214 */  bne        $v1, $v0, .L800B5A00
    /* A61A8 800B59A8 1180033C */   lui       $v1, %hi(Cars_gHumanRaceCarList)
  .L800B59AC:
    /* A61AC 800B59AC 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* A61B0 800B59B0 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* A61B4 800B59B4 00000000 */  nop
    /* A61B8 800B59B8 6002428C */  lw         $v0, 0x260($v0)
    /* A61BC 800B59BC 00000000 */  nop
    /* A61C0 800B59C0 00024230 */  andi       $v0, $v0, 0x200
    /* A61C4 800B59C4 17004014 */  bnez       $v0, .L800B5A24
    /* A61C8 800B59C8 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* A61CC 800B59CC 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* A61D0 800B59D0 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* A61D4 800B59D4 02000224 */  addiu      $v0, $zero, 0x2
    /* A61D8 800B59D8 09006214 */  bne        $v1, $v0, .L800B5A00
    /* A61DC 800B59DC 1180033C */   lui       $v1, %hi(Cars_gHumanRaceCarList)
    /* A61E0 800B59E0 0400828C */  lw         $v0, 0x4($a0)
    /* A61E4 800B59E4 00000000 */  nop
    /* A61E8 800B59E8 6002428C */  lw         $v0, 0x260($v0)
    /* A61EC 800B59EC 00000000 */  nop
    /* A61F0 800B59F0 00024230 */  andi       $v0, $v0, 0x200
    /* A61F4 800B59F4 0C004014 */  bnez       $v0, .L800B5A28
    /* A61F8 800B59F8 1280033C */   lui       $v1, %hi(gReplayCameraSlots)
    /* A61FC 800B59FC 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
  .L800B5A00:
    /* A6200 800B5A00 48FA6324 */  addiu      $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* A6204 800B5A04 80100A00 */  sll        $v0, $t2, 2
    /* A6208 800B5A08 21104300 */  addu       $v0, $v0, $v1
    /* A620C 800B5A0C 0000428C */  lw         $v0, 0x0($v0)
    /* A6210 800B5A10 00000000 */  nop
    /* A6214 800B5A14 F003428C */  lw         $v0, 0x3F0($v0)
    /* A6218 800B5A18 00000000 */  nop
    /* A621C 800B5A1C 2D004010 */  beqz       $v0, .L800B5AD4
    /* A6220 800B5A20 21204001 */   addu      $a0, $t2, $zero
  .L800B5A24:
    /* A6224 800B5A24 1280033C */  lui        $v1, %hi(gReplayCameraSlots)
  .L800B5A28:
    /* A6228 800B5A28 1180023C */  lui        $v0, %hi(Replay_ReplayCamera)
    /* A622C 800B5A2C 4C704224 */  addiu      $v0, $v0, %lo(Replay_ReplayCamera)
    /* A6230 800B5A30 00310A00 */  sll        $a2, $t2, 4
    /* A6234 800B5A34 2128C200 */  addu       $a1, $a2, $v0
    /* A6238 800B5A38 0C00A28C */  lw         $v0, 0xC($a1)
    /* A623C 800B5A3C DCDB6724 */  addiu      $a3, $v1, %lo(gReplayCameraSlots)
    /* A6240 800B5A40 40110200 */  sll        $v0, $v0, 5
    /* A6244 800B5A44 21104700 */  addu       $v0, $v0, $a3
    /* A6248 800B5A48 00004390 */  lbu        $v1, 0x0($v0)
    /* A624C 800B5A4C 0B000224 */  addiu      $v0, $zero, 0xB
    /* A6250 800B5A50 20006214 */  bne        $v1, $v0, .L800B5AD4
    /* A6254 800B5A54 21204001 */   addu      $a0, $t2, $zero
    /* A6258 800B5A58 FFF9043C */  lui        $a0, (0xF9FFFFFF >> 16)
    /* A625C 800B5A5C FFFF8434 */  ori        $a0, $a0, (0xF9FFFFFF & 0xFFFF)
    /* A6260 800B5A60 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* A6264 800B5A64 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* A6268 800B5A68 2130CA00 */  addu       $a2, $a2, $t2
    /* A626C 800B5A6C 00310600 */  sll        $a2, $a2, 4
    /* A6270 800B5A70 0C00A28C */  lw         $v0, 0xC($a1)
    /* A6274 800B5A74 2130C300 */  addu       $a2, $a2, $v1
    /* A6278 800B5A78 0000A0AC */  sw         $zero, 0x0($a1)
    /* A627C 800B5A7C 7400C38C */  lw         $v1, 0x74($a2)
    /* A6280 800B5A80 40110200 */  sll        $v0, $v0, 5
    /* A6284 800B5A84 21104700 */  addu       $v0, $v0, $a3
    /* A6288 800B5A88 0000428C */  lw         $v0, 0x0($v0)
    /* A628C 800B5A8C 24186400 */  and        $v1, $v1, $a0
    /* A6290 800B5A90 42120200 */  srl        $v0, $v0, 9
    /* A6294 800B5A94 03004230 */  andi       $v0, $v0, 0x3
    /* A6298 800B5A98 40160200 */  sll        $v0, $v0, 25
    /* A629C 800B5A9C 25186200 */  or         $v1, $v1, $v0
    /* A62A0 800B5AA0 7400C3AC */  sw         $v1, 0x74($a2)
    /* A62A4 800B5AA4 0C00A28C */  lw         $v0, 0xC($a1)
    /* A62A8 800B5AA8 21204001 */  addu       $a0, $t2, $zero
    /* A62AC 800B5AAC 40110200 */  sll        $v0, $v0, 5
    /* A62B0 800B5AB0 21104700 */  addu       $v0, $v0, $a3
    /* A62B4 800B5AB4 0000428C */  lw         $v0, 0x0($v0)
    /* A62B8 800B5AB8 0B000524 */  addiu      $a1, $zero, 0xB
    /* A62BC 800B5ABC 0610A200 */  srlv       $v0, $v0, $a1
    /* A62C0 800B5AC0 07004230 */  andi       $v0, $v0, 0x7
    /* A62C4 800B5AC4 8215020C */  jal        Camera_SetMode__Fii
    /* A62C8 800B5AC8 7E00C2A0 */   sb        $v0, 0x7E($a2)
    /* A62CC 800B5ACC C1D60208 */  j          .L800B5B04
    /* A62D0 800B5AD0 00000000 */   nop
  .L800B5AD4:
    /* A62D4 800B5AD4 1180023C */  lui        $v0, %hi(Replay_ReplayCamera)
    /* A62D8 800B5AD8 4C704224 */  addiu      $v0, $v0, %lo(Replay_ReplayCamera)
    /* A62DC 800B5ADC 00190400 */  sll        $v1, $a0, 4
    /* A62E0 800B5AE0 21186200 */  addu       $v1, $v1, $v0
    /* A62E4 800B5AE4 01000224 */  addiu      $v0, $zero, 0x1
    /* A62E8 800B5AE8 1280053C */  lui        $a1, %hi(gReplayCameraSlots)
    /* A62EC 800B5AEC 0C00668C */  lw         $a2, 0xC($v1)
    /* A62F0 800B5AF0 DCDBA524 */  addiu      $a1, $a1, %lo(gReplayCameraSlots)
    /* A62F4 800B5AF4 000062AC */  sw         $v0, 0x0($v1)
    /* A62F8 800B5AF8 40310600 */  sll        $a2, $a2, 5
    /* A62FC 800B5AFC F416020C */  jal        Camera_ReplayUpdate__FiP15Camera_tCamSlot
    /* A6300 800B5B00 2128C500 */   addu      $a1, $a2, $a1
  .L800B5B04:
    /* A6304 800B5B04 1000BF8F */  lw         $ra, 0x10($sp)
    /* A6308 800B5B08 00000000 */  nop
    /* A630C 800B5B0C 0800E003 */  jr         $ra
    /* A6310 800B5B10 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Replay_ReplayChooseCamera__Fii
