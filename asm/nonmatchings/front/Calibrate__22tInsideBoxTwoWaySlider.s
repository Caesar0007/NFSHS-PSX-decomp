.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Calibrate__22tInsideBoxTwoWaySlider, 0x320

glabel Calibrate__22tInsideBoxTwoWaySlider
    /* 10118 8001F918 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 1011C 8001F91C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 10120 8001F920 21808000 */  addu       $s0, $a0, $zero
    /* 10124 8001F924 0580023C */  lui        $v0, %hi(screenControllerConfig)
    /* 10128 8001F928 D028448C */  lw         $a0, %lo(screenControllerConfig)($v0)
    /* 1012C 8001F92C 0580023C */  lui        $v0, %hi(FEApp)
    /* 10130 8001F930 C014438C */  lw         $v1, %lo(FEApp)($v0)
    /* 10134 8001F934 1480023C */  lui        $v0, %hi(gPadinfo)
    /* 10138 8001F938 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 1013C 8001F93C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 10140 8001F940 1400B1AF */  sw         $s1, 0x14($sp)
    /* 10144 8001F944 2D027290 */  lbu        $s2, 0x22D($v1)
    /* 10148 8001F948 9CE84224 */  addiu      $v0, $v0, %lo(gPadinfo)
    /* 1014C 8001F94C 40191200 */  sll        $v1, $s2, 5
    /* 10150 8001F950 2B16010C */  jal        GetHelpText__23tScreenControllerConfig
    /* 10154 8001F954 21886200 */   addu      $s1, $v1, $v0
    /* 10158 8001F958 0580033C */  lui        $v1, %hi(fHelpText)
    /* 1015C 8001F95C B01562AC */  sw         $v0, %lo(fHelpText)($v1)
    /* 10160 8001F960 28000386 */  lh         $v1, 0x28($s0)
    /* 10164 8001F964 01000224 */  addiu      $v0, $zero, 0x1
    /* 10168 8001F968 37006210 */  beq        $v1, $v0, .L8001FA48
    /* 1016C 8001F96C 02006228 */   slti      $v0, $v1, 0x2
    /* 10170 8001F970 05004010 */  beqz       $v0, .L8001F988
    /* 10174 8001F974 02000224 */   addiu     $v0, $zero, 0x2
    /* 10178 8001F978 09006010 */  beqz       $v1, .L8001F9A0
    /* 1017C 8001F97C 23000224 */   addiu     $v0, $zero, 0x23
    /* 10180 8001F980 087F0008 */  j          .L8001FC20
    /* 10184 8001F984 00000000 */   nop
  .L8001F988:
    /* 10188 8001F988 5F006210 */  beq        $v1, $v0, .L8001FB08
    /* 1018C 8001F98C 03000224 */   addiu     $v0, $zero, 0x3
    /* 10190 8001F990 81006210 */  beq        $v1, $v0, .L8001FB98
    /* 10194 8001F994 23000224 */   addiu     $v0, $zero, 0x23
    /* 10198 8001F998 087F0008 */  j          .L8001FC20
    /* 1019C 8001F99C 00000000 */   nop
  .L8001F9A0:
    /* 101A0 8001F9A0 05002392 */  lbu        $v1, 0x5($s1)
    /* 101A4 8001F9A4 00000000 */  nop
    /* 101A8 8001F9A8 15006214 */  bne        $v1, $v0, .L8001FA00
    /* 101AC 8001F9AC 53000224 */   addiu     $v0, $zero, 0x53
    /* 101B0 8001F9B0 08002592 */  lbu        $a1, 0x8($s1)
    /* 101B4 8001F9B4 00000000 */  nop
    /* 101B8 8001F9B8 8000A228 */  slti       $v0, $a1, 0x80
    /* 101BC 8001F9BC 03004010 */  beqz       $v0, .L8001F9CC
    /* 101C0 8001F9C0 80000224 */   addiu     $v0, $zero, 0x80
    /* 101C4 8001F9C4 747E0008 */  j          .L8001F9D0
    /* 101C8 8001F9C8 23184500 */   subu      $v1, $v0, $a1
  .L8001F9CC:
    /* 101CC 8001F9CC 80FFA324 */  addiu      $v1, $a1, -0x80
  .L8001F9D0:
    /* 101D0 8001F9D0 1180023C */  lui        $v0, %hi(frontEnd)
    /* 101D4 8001F9D4 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 101D8 8001F9D8 21204202 */  addu       $a0, $s2, $v0
    /* 101DC 8001F9DC 4B038290 */  lbu        $v0, 0x34B($a0)
    /* 101E0 8001F9E0 21286000 */  addu       $a1, $v1, $zero
    /* 101E4 8001F9E4 0A004624 */  addiu      $a2, $v0, 0xA
    /* 101E8 8001F9E8 2A10A600 */  slt        $v0, $a1, $a2
    /* 101EC 8001F9EC 02004010 */  beqz       $v0, .L8001F9F8
    /* 101F0 8001F9F0 00000000 */   nop
    /* 101F4 8001F9F4 2128C000 */  addu       $a1, $a2, $zero
  .L8001F9F8:
    /* 101F8 8001F9F8 087F0008 */  j          .L8001FC20
    /* 101FC 8001F9FC 490385A0 */   sb        $a1, 0x349($a0)
  .L8001FA00:
    /* 10200 8001FA00 03006210 */  beq        $v1, $v0, .L8001FA10
    /* 10204 8001FA04 73000224 */   addiu     $v0, $zero, 0x73
    /* 10208 8001FA08 85006214 */  bne        $v1, $v0, .L8001FC20
    /* 1020C 8001FA0C 00000000 */   nop
  .L8001FA10:
    /* 10210 8001FA10 187E000C */  jal        GetCurrentStickRange__Fi
    /* 10214 8001FA14 21204002 */   addu      $a0, $s2, $zero
    /* 10218 8001FA18 1180033C */  lui        $v1, %hi(frontEnd)
    /* 1021C 8001FA1C 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* 10220 8001FA20 21204302 */  addu       $a0, $s2, $v1
    /* 10224 8001FA24 53038390 */  lbu        $v1, 0x353($a0)
    /* 10228 8001FA28 FF004530 */  andi       $a1, $v0, 0xFF
    /* 1022C 8001FA2C 0A006324 */  addiu      $v1, $v1, 0xA
    /* 10230 8001FA30 2A10A300 */  slt        $v0, $a1, $v1
    /* 10234 8001FA34 02004010 */  beqz       $v0, .L8001FA40
    /* 10238 8001FA38 00000000 */   nop
    /* 1023C 8001FA3C 21286000 */  addu       $a1, $v1, $zero
  .L8001FA40:
    /* 10240 8001FA40 087F0008 */  j          .L8001FC20
    /* 10244 8001FA44 510385A0 */   sb        $a1, 0x351($a0)
  .L8001FA48:
    /* 10248 8001FA48 05002392 */  lbu        $v1, 0x5($s1)
    /* 1024C 8001FA4C 23000224 */  addiu      $v0, $zero, 0x23
    /* 10250 8001FA50 18006214 */  bne        $v1, $v0, .L8001FAB4
    /* 10254 8001FA54 53000224 */   addiu     $v0, $zero, 0x53
    /* 10258 8001FA58 08002592 */  lbu        $a1, 0x8($s1)
    /* 1025C 8001FA5C 00000000 */  nop
    /* 10260 8001FA60 8000A228 */  slti       $v0, $a1, 0x80
    /* 10264 8001FA64 03004010 */  beqz       $v0, .L8001FA74
    /* 10268 8001FA68 80000224 */   addiu     $v0, $zero, 0x80
    /* 1026C 8001FA6C 9E7E0008 */  j          .L8001FA78
    /* 10270 8001FA70 23184500 */   subu      $v1, $v0, $a1
  .L8001FA74:
    /* 10274 8001FA74 80FFA324 */  addiu      $v1, $a1, -0x80
  .L8001FA78:
    /* 10278 8001FA78 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1027C 8001FA7C 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 10280 8001FA80 21204202 */  addu       $a0, $s2, $v0
    /* 10284 8001FA84 49038290 */  lbu        $v0, 0x349($a0)
    /* 10288 8001FA88 21286000 */  addu       $a1, $v1, $zero
    /* 1028C 8001FA8C F6FF4624 */  addiu      $a2, $v0, -0xA
    /* 10290 8001FA90 2A10C500 */  slt        $v0, $a2, $a1
    /* 10294 8001FA94 02004010 */  beqz       $v0, .L8001FAA0
    /* 10298 8001FA98 00000000 */   nop
    /* 1029C 8001FA9C 2128C000 */  addu       $a1, $a2, $zero
  .L8001FAA0:
    /* 102A0 8001FAA0 0200A104 */  bgez       $a1, .L8001FAAC
    /* 102A4 8001FAA4 2110A000 */   addu      $v0, $a1, $zero
    /* 102A8 8001FAA8 21100000 */  addu       $v0, $zero, $zero
  .L8001FAAC:
    /* 102AC 8001FAAC 087F0008 */  j          .L8001FC20
    /* 102B0 8001FAB0 4B0382A0 */   sb        $v0, 0x34B($a0)
  .L8001FAB4:
    /* 102B4 8001FAB4 03006210 */  beq        $v1, $v0, .L8001FAC4
    /* 102B8 8001FAB8 73000224 */   addiu     $v0, $zero, 0x73
    /* 102BC 8001FABC 58006214 */  bne        $v1, $v0, .L8001FC20
    /* 102C0 8001FAC0 00000000 */   nop
  .L8001FAC4:
    /* 102C4 8001FAC4 187E000C */  jal        GetCurrentStickRange__Fi
    /* 102C8 8001FAC8 21204002 */   addu      $a0, $s2, $zero
    /* 102CC 8001FACC 1180033C */  lui        $v1, %hi(frontEnd)
    /* 102D0 8001FAD0 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* 102D4 8001FAD4 21204302 */  addu       $a0, $s2, $v1
    /* 102D8 8001FAD8 51038390 */  lbu        $v1, 0x351($a0)
    /* 102DC 8001FADC FF004530 */  andi       $a1, $v0, 0xFF
    /* 102E0 8001FAE0 F6FF6324 */  addiu      $v1, $v1, -0xA
    /* 102E4 8001FAE4 2A106500 */  slt        $v0, $v1, $a1
    /* 102E8 8001FAE8 02004010 */  beqz       $v0, .L8001FAF4
    /* 102EC 8001FAEC 00000000 */   nop
    /* 102F0 8001FAF0 21286000 */  addu       $a1, $v1, $zero
  .L8001FAF4:
    /* 102F4 8001FAF4 0200A104 */  bgez       $a1, .L8001FB00
    /* 102F8 8001FAF8 2110A000 */   addu      $v0, $a1, $zero
    /* 102FC 8001FAFC 21100000 */  addu       $v0, $zero, $zero
  .L8001FB00:
    /* 10300 8001FB00 087F0008 */  j          .L8001FC20
    /* 10304 8001FB04 530382A0 */   sb        $v0, 0x353($a0)
  .L8001FB08:
    /* 10308 8001FB08 05002392 */  lbu        $v1, 0x5($s1)
    /* 1030C 8001FB0C 23000224 */  addiu      $v0, $zero, 0x23
    /* 10310 8001FB10 0B006214 */  bne        $v1, $v0, .L8001FB40
    /* 10314 8001FB14 53000224 */   addiu     $v0, $zero, 0x53
    /* 10318 8001FB18 09002592 */  lbu        $a1, 0x9($s1)
    /* 1031C 8001FB1C 00000000 */  nop
    /* 10320 8001FB20 0200A104 */  bgez       $a1, .L8001FB2C
    /* 10324 8001FB24 2118A000 */   addu      $v1, $a1, $zero
    /* 10328 8001FB28 21180000 */  addu       $v1, $zero, $zero
  .L8001FB2C:
    /* 1032C 8001FB2C 1180023C */  lui        $v0, %hi(frontEnd)
    /* 10330 8001FB30 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 10334 8001FB34 21104202 */  addu       $v0, $s2, $v0
    /* 10338 8001FB38 087F0008 */  j          .L8001FC20
    /* 1033C 8001FB3C 4D0343A0 */   sb        $v1, 0x34D($v0)
  .L8001FB40:
    /* 10340 8001FB40 03006210 */  beq        $v1, $v0, .L8001FB50
    /* 10344 8001FB44 73000224 */   addiu     $v0, $zero, 0x73
    /* 10348 8001FB48 35006214 */  bne        $v1, $v0, .L8001FC20
    /* 1034C 8001FB4C 00000000 */   nop
  .L8001FB50:
    /* 10350 8001FB50 2F7E000C */  jal        GetCurrentStickRange2__Fi
    /* 10354 8001FB54 21204002 */   addu      $a0, $s2, $zero
    /* 10358 8001FB58 1180033C */  lui        $v1, %hi(frontEnd)
    /* 1035C 8001FB5C 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* 10360 8001FB60 21204302 */  addu       $a0, $s2, $v1
    /* 10364 8001FB64 57038390 */  lbu        $v1, 0x357($a0)
    /* 10368 8001FB68 FF004530 */  andi       $a1, $v0, 0xFF
    /* 1036C 8001FB6C 0A006324 */  addiu      $v1, $v1, 0xA
    /* 10370 8001FB70 2A10A300 */  slt        $v0, $a1, $v1
    /* 10374 8001FB74 02004010 */  beqz       $v0, .L8001FB80
    /* 10378 8001FB78 00000000 */   nop
    /* 1037C 8001FB7C 21286000 */  addu       $a1, $v1, $zero
  .L8001FB80:
    /* 10380 8001FB80 550385A0 */  sb         $a1, 0x355($a0)
    /* 10384 8001FB84 0200A104 */  bgez       $a1, .L8001FB90
    /* 10388 8001FB88 2110A000 */   addu      $v0, $a1, $zero
    /* 1038C 8001FB8C 21100000 */  addu       $v0, $zero, $zero
  .L8001FB90:
    /* 10390 8001FB90 087F0008 */  j          .L8001FC20
    /* 10394 8001FB94 550382A0 */   sb        $v0, 0x355($a0)
  .L8001FB98:
    /* 10398 8001FB98 05002392 */  lbu        $v1, 0x5($s1)
    /* 1039C 8001FB9C 00000000 */  nop
    /* 103A0 8001FBA0 0B006214 */  bne        $v1, $v0, .L8001FBD0
    /* 103A4 8001FBA4 53000224 */   addiu     $v0, $zero, 0x53
    /* 103A8 8001FBA8 0A002592 */  lbu        $a1, 0xA($s1)
    /* 103AC 8001FBAC 0A000324 */  addiu      $v1, $zero, 0xA
    /* 103B0 8001FBB0 2A10A300 */  slt        $v0, $a1, $v1
    /* 103B4 8001FBB4 02004014 */  bnez       $v0, .L8001FBC0
    /* 103B8 8001FBB8 1180023C */   lui       $v0, %hi(frontEnd)
    /* 103BC 8001FBBC 2118A000 */  addu       $v1, $a1, $zero
  .L8001FBC0:
    /* 103C0 8001FBC0 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 103C4 8001FBC4 21104202 */  addu       $v0, $s2, $v0
    /* 103C8 8001FBC8 087F0008 */  j          .L8001FC20
    /* 103CC 8001FBCC 4F0343A0 */   sb        $v1, 0x34F($v0)
  .L8001FBD0:
    /* 103D0 8001FBD0 03006210 */  beq        $v1, $v0, .L8001FBE0
    /* 103D4 8001FBD4 73000224 */   addiu     $v0, $zero, 0x73
    /* 103D8 8001FBD8 11006214 */  bne        $v1, $v0, .L8001FC20
    /* 103DC 8001FBDC 00000000 */   nop
  .L8001FBE0:
    /* 103E0 8001FBE0 2F7E000C */  jal        GetCurrentStickRange2__Fi
    /* 103E4 8001FBE4 21204002 */   addu      $a0, $s2, $zero
    /* 103E8 8001FBE8 1180033C */  lui        $v1, %hi(frontEnd)
    /* 103EC 8001FBEC 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* 103F0 8001FBF0 21204302 */  addu       $a0, $s2, $v1
    /* 103F4 8001FBF4 55038390 */  lbu        $v1, 0x355($a0)
    /* 103F8 8001FBF8 FF004530 */  andi       $a1, $v0, 0xFF
    /* 103FC 8001FBFC F6FF6324 */  addiu      $v1, $v1, -0xA
    /* 10400 8001FC00 2A106500 */  slt        $v0, $v1, $a1
    /* 10404 8001FC04 02004010 */  beqz       $v0, .L8001FC10
    /* 10408 8001FC08 00000000 */   nop
    /* 1040C 8001FC0C 21286000 */  addu       $a1, $v1, $zero
  .L8001FC10:
    /* 10410 8001FC10 0200A104 */  bgez       $a1, .L8001FC1C
    /* 10414 8001FC14 2110A000 */   addu      $v0, $a1, $zero
    /* 10418 8001FC18 21100000 */  addu       $v0, $zero, $zero
  .L8001FC1C:
    /* 1041C 8001FC1C 570382A0 */  sb         $v0, 0x357($a0)
  .L8001FC20:
    /* 10420 8001FC20 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 10424 8001FC24 1800B28F */  lw         $s2, 0x18($sp)
    /* 10428 8001FC28 1400B18F */  lw         $s1, 0x14($sp)
    /* 1042C 8001FC2C 1000B08F */  lw         $s0, 0x10($sp)
    /* 10430 8001FC30 0800E003 */  jr         $ra
    /* 10434 8001FC34 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Calibrate__22tInsideBoxTwoWaySlider
