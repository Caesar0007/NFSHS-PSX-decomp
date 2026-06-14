.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DashHUD_HUDCalc__Fi, 0x2C0

glabel DashHUD_HUDCalc__Fi
    /* 8B908 8009B108 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 8B90C 8009B10C 1180023C */  lui        $v0, %hi(D_8011274C)
    /* 8B910 8009B110 4C274524 */  addiu      $a1, $v0, %lo(D_8011274C)
    /* 8B914 8009B114 1800BFAF */  sw         $ra, 0x18($sp)
    /* 8B918 8009B118 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8B91C 8009B11C A500A010 */  beqz       $a1, .L8009B3B4
    /* 8B920 8009B120 1000B0AF */   sw        $s0, 0x10($sp)
    /* 8B924 8009B124 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 8B928 8009B128 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* 8B92C 8009B12C 80180400 */  sll        $v1, $a0, 2
    /* 8B930 8009B130 21186200 */  addu       $v1, $v1, $v0
    /* 8B934 8009B134 0000718C */  lw         $s1, 0x0($v1)
    /* 8B938 8009B138 00000000 */  nop
    /* 8B93C 8009B13C 6003228E */  lw         $v0, 0x360($s1)
    /* 8B940 8009B140 E4FFA424 */  addiu      $a0, $a1, -0x1C
    /* 8B944 8009B144 01004224 */  addiu      $v0, $v0, 0x1
    /* 8B948 8009B148 0300401C */  bgtz       $v0, .L8009B158
    /* 8B94C 8009B14C 380082AC */   sw        $v0, 0x38($a0)
    /* 8B950 8009B150 01000224 */  addiu      $v0, $zero, 0x1
    /* 8B954 8009B154 380082AC */  sw         $v0, 0x38($a0)
  .L8009B158:
    /* 8B958 8009B158 3800828C */  lw         $v0, 0x38($a0)
    /* 8B95C 8009B15C 3C00838C */  lw         $v1, 0x3C($a0)
    /* 8B960 8009B160 00000000 */  nop
    /* 8B964 8009B164 2A106200 */  slt        $v0, $v1, $v0
    /* 8B968 8009B168 02004010 */  beqz       $v0, .L8009B174
    /* 8B96C 8009B16C 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 8B970 8009B170 380083AC */  sw         $v1, 0x38($a0)
  .L8009B174:
    /* 8B974 8009B174 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* 8B978 8009B178 00000000 */  nop
    /* 8B97C 8009B17C 00026228 */  slti       $v0, $v1, 0x200
    /* 8B980 8009B180 04004010 */  beqz       $v0, .L8009B194
    /* 8B984 8009B184 00000000 */   nop
    /* 8B988 8009B188 340080AC */  sw         $zero, 0x34($a0)
    /* 8B98C 8009B18C C36C0208 */  j          .L8009B30C
    /* 8B990 8009B190 140080AC */   sw        $zero, 0x14($a0)
  .L8009B194:
    /* 8B994 8009B194 6003258E */  lw         $a1, 0x360($s1)
    /* 8B998 8009B198 00000000 */  nop
    /* 8B99C 8009B19C 5000A010 */  beqz       $a1, .L8009B2E0
    /* 8B9A0 8009B1A0 00000000 */   nop
    /* 8B9A4 8009B1A4 6403228E */  lw         $v0, 0x364($s1)
    /* 8B9A8 8009B1A8 00000000 */  nop
    /* 8B9AC 8009B1AC 23106200 */  subu       $v0, $v1, $v0
    /* 8B9B0 8009B1B0 40014228 */  slti       $v0, $v0, 0x140
    /* 8B9B4 8009B1B4 06004014 */  bnez       $v0, .L8009B1D0
    /* 8B9B8 8009B1B8 FFFFA224 */   addiu     $v0, $a1, -0x1
    /* 8B9BC 8009B1BC 9003238E */  lw         $v1, 0x390($s1)
    /* 8B9C0 8009B1C0 02000224 */  addiu      $v0, $zero, 0x2
    /* 8B9C4 8009B1C4 47006214 */  bne        $v1, $v0, .L8009B2E4
    /* 8B9C8 8009B1C8 1180033C */   lui       $v1, %hi(DashHUD_gInfo)
    /* 8B9CC 8009B1CC FFFFA224 */  addiu      $v0, $a1, -0x1
  .L8009B1D0:
    /* 8B9D0 8009B1D0 80100200 */  sll        $v0, $v0, 2
    /* 8B9D4 8009B1D4 21102202 */  addu       $v0, $s1, $v0
    /* 8B9D8 8009B1D8 6803438C */  lw         $v1, 0x368($v0)
    /* 8B9DC 8009B1DC 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 8B9E0 8009B1E0 EC314624 */  addiu      $a2, $v0, %lo(GameSetup_gData)
    /* 8B9E4 8009B1E4 340083AC */  sw         $v1, 0x34($a0)
    /* 8B9E8 8009B1E8 EC31428C */  lw         $v0, %lo(GameSetup_gData)($v0)
    /* 8B9EC 8009B1EC 04000524 */  addiu      $a1, $zero, 0x4
    /* 8B9F0 8009B1F0 18004510 */  beq        $v0, $a1, .L8009B254
    /* 8B9F4 8009B1F4 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* 8B9F8 8009B1F8 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* 8B9FC 8009B1FC F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* 8BA00 8009B200 00000000 */  nop
    /* 8BA04 8009B204 02004228 */  slti       $v0, $v0, 0x2
    /* 8BA08 8009B208 12004010 */  beqz       $v0, .L8009B254
    /* 8BA0C 8009B20C 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* 8BA10 8009B210 5C00828C */  lw         $v0, 0x5C($a0)
    /* 8BA14 8009B214 00000000 */  nop
    /* 8BA18 8009B218 07004010 */  beqz       $v0, .L8009B238
    /* 8BA1C 8009B21C 2A106200 */   slt       $v0, $v1, $v0
    /* 8BA20 8009B220 06004014 */  bnez       $v0, .L8009B23C
    /* 8BA24 8009B224 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* 8BA28 8009B228 BC00C28C */  lw         $v0, 0xBC($a2)
    /* 8BA2C 8009B22C 00000000 */  nop
    /* 8BA30 8009B230 08004514 */  bne        $v0, $a1, .L8009B254
    /* 8BA34 8009B234 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
  .L8009B238:
    /* 8BA38 8009B238 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
  .L8009B23C:
    /* 8BA3C 8009B23C 30274224 */  addiu      $v0, $v0, %lo(DashHUD_gInfo)
    /* 8BA40 8009B240 3400448C */  lw         $a0, 0x34($v0)
    /* 8BA44 8009B244 01000324 */  addiu      $v1, $zero, 0x1
    /* 8BA48 8009B248 140043AC */  sw         $v1, 0x14($v0)
    /* 8BA4C 8009B24C C36C0208 */  j          .L8009B30C
    /* 8BA50 8009B250 5C0044AC */   sw        $a0, 0x5C($v0)
  .L8009B254:
    /* 8BA54 8009B254 30274424 */  addiu      $a0, $v0, %lo(DashHUD_gInfo)
    /* 8BA58 8009B258 5C00838C */  lw         $v1, 0x5C($a0)
    /* 8BA5C 8009B25C 3400828C */  lw         $v0, 0x34($a0)
    /* 8BA60 8009B260 00000000 */  nop
    /* 8BA64 8009B264 03006214 */  bne        $v1, $v0, .L8009B274
    /* 8BA68 8009B268 1280033C */   lui       $v1, %hi(D_8011E0B0)
    /* 8BA6C 8009B26C 01000224 */  addiu      $v0, $zero, 0x1
    /* 8BA70 8009B270 140082AC */  sw         $v0, 0x14($a0)
  .L8009B274:
    /* 8BA74 8009B274 5403228E */  lw         $v0, 0x354($s1)
    /* 8BA78 8009B278 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* 8BA7C 8009B27C C0004224 */  addiu      $v0, $v0, 0xC0
    /* 8BA80 8009B280 2A104300 */  slt        $v0, $v0, $v1
    /* 8BA84 8009B284 02004010 */  beqz       $v0, .L8009B290
    /* 8BA88 8009B288 00000000 */   nop
    /* 8BA8C 8009B28C 140080AC */  sw         $zero, 0x14($a0)
  .L8009B290:
    /* 8BA90 8009B290 1400828C */  lw         $v0, 0x14($a0)
    /* 8BA94 8009B294 00000000 */  nop
    /* 8BA98 8009B298 0B004010 */  beqz       $v0, .L8009B2C8
    /* 8BA9C 8009B29C 10006230 */   andi      $v0, $v1, 0x10
    /* 8BAA0 8009B2A0 09004010 */  beqz       $v0, .L8009B2C8
    /* 8BAA4 8009B2A4 00000000 */   nop
    /* 8BAA8 8009B2A8 6418828F */  lw         $v0, %gp_rel(D_8013DDB0)($gp)
    /* 8BAAC 8009B2AC 00000000 */  nop
    /* 8BAB0 8009B2B0 17004014 */  bnez       $v0, .L8009B310
    /* 8BAB4 8009B2B4 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 8BAB8 8009B2B8 01000224 */  addiu      $v0, $zero, 0x1
    /* 8BABC 8009B2BC 641882AF */  sw         $v0, %gp_rel(D_8013DDB0)($gp)
    /* 8BAC0 8009B2C0 C46C0208 */  j          .L8009B310
    /* 8BAC4 8009B2C4 1280023C */   lui       $v0, %hi(D_8011E0B0)
  .L8009B2C8:
    /* 8BAC8 8009B2C8 6418828F */  lw         $v0, %gp_rel(D_8013DDB0)($gp)
    /* 8BACC 8009B2CC 00000000 */  nop
    /* 8BAD0 8009B2D0 0F004010 */  beqz       $v0, .L8009B310
    /* 8BAD4 8009B2D4 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 8BAD8 8009B2D8 C26C0208 */  j          .L8009B308
    /* 8BADC 8009B2DC 00000000 */   nop
  .L8009B2E0:
    /* 8BAE0 8009B2E0 1180033C */  lui        $v1, %hi(DashHUD_gInfo)
  .L8009B2E4:
    /* 8BAE4 8009B2E4 30276324 */  addiu      $v1, $v1, %lo(DashHUD_gInfo)
    /* 8BAE8 8009B2E8 6403258E */  lw         $a1, 0x364($s1)
    /* 8BAEC 8009B2EC 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 8BAF0 8009B2F0 140060AC */  sw         $zero, 0x14($v1)
    /* 8BAF4 8009B2F4 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 8BAF8 8009B2F8 6418848F */  lw         $a0, %gp_rel(D_8013DDB0)($gp)
    /* 8BAFC 8009B2FC 23104500 */  subu       $v0, $v0, $a1
    /* 8BB00 8009B300 02008010 */  beqz       $a0, .L8009B30C
    /* 8BB04 8009B304 340062AC */   sw        $v0, 0x34($v1)
  .L8009B308:
    /* 8BB08 8009B308 641880AF */  sw         $zero, %gp_rel(D_8013DDB0)($gp)
  .L8009B30C:
    /* 8BB0C 8009B30C 1280023C */  lui        $v0, %hi(D_8011E0B0)
  .L8009B310:
    /* 8BB10 8009B310 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 8BB14 8009B314 6403238E */  lw         $v1, 0x364($s1)
    /* 8BB18 8009B318 00000000 */  nop
    /* 8BB1C 8009B31C 23104300 */  subu       $v0, $v0, $v1
    /* 8BB20 8009B320 40014228 */  slti       $v0, $v0, 0x140
    /* 8BB24 8009B324 0A004010 */  beqz       $v0, .L8009B350
    /* 8BB28 8009B328 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* 8BB2C 8009B32C 30274424 */  addiu      $a0, $v0, %lo(DashHUD_gInfo)
    /* 8BB30 8009B330 3800838C */  lw         $v1, 0x38($a0)
    /* 8BB34 8009B334 3C00828C */  lw         $v0, 0x3C($a0)
    /* 8BB38 8009B338 00000000 */  nop
    /* 8BB3C 8009B33C 05006214 */  bne        $v1, $v0, .L8009B354
    /* 8BB40 8009B340 1180023C */   lui       $v0, %hi(D_80112748)
    /* 8BB44 8009B344 01000224 */  addiu      $v0, $zero, 0x1
    /* 8BB48 8009B348 D66C0208 */  j          .L8009B358
    /* 8BB4C 8009B34C 180082AC */   sw        $v0, 0x18($a0)
  .L8009B350:
    /* 8BB50 8009B350 1180023C */  lui        $v0, %hi(D_80112748)
  .L8009B354:
    /* 8BB54 8009B354 482740AC */  sw         $zero, %lo(D_80112748)($v0)
  .L8009B358:
    /* 8BB58 8009B358 55E0020C */  jal        Stats_GetPosition__FP8Car_tObj
    /* 8BB5C 8009B35C 21202002 */   addu      $a0, $s1, $zero
    /* 8BB60 8009B360 1180103C */  lui        $s0, %hi(DashHUD_gInfo)
    /* 8BB64 8009B364 30271026 */  addiu      $s0, $s0, %lo(DashHUD_gInfo)
    /* 8BB68 8009B368 6AE0020C */  jal        Stats_GetNumOpponents__Fv
    /* 8BB6C 8009B36C 540002AE */   sw        $v0, 0x54($s0)
    /* 8BB70 8009B370 21202002 */  addu       $a0, $s1, $zero
    /* 8BB74 8009B374 44000526 */  addiu      $a1, $s0, 0x44
    /* 8BB78 8009B378 50000626 */  addiu      $a2, $s0, 0x50
    /* 8BB7C 8009B37C D917020C */  jal        Cars_InitDashData__FP8Car_tObjPiT1
    /* 8BB80 8009B380 580002AE */   sw        $v0, 0x58($s0)
    /* 8BB84 8009B384 21202002 */  addu       $a0, $s1, $zero
    /* 8BB88 8009B388 40000526 */  addiu      $a1, $s0, 0x40
    /* 8BB8C 8009B38C 48000626 */  addiu      $a2, $s0, 0x48
    /* 8BB90 8009B390 B117020C */  jal        Cars_GetDashData__FP8Car_tObjPiN21
    /* 8BB94 8009B394 4C000726 */   addiu     $a3, $s0, 0x4C
    /* 8BB98 8009B398 4C00028E */  lw         $v0, 0x4C($s0)
    /* 8BB9C 8009B39C 52000386 */  lh         $v1, 0x52($s0)
    /* 8BBA0 8009B3A0 02004104 */  bgez       $v0, .L8009B3AC
    /* 8BBA4 8009B3A4 00000000 */   nop
    /* 8BBA8 8009B3A8 23100200 */  negu       $v0, $v0
  .L8009B3AC:
    /* 8BBAC 8009B3AC 4C0002AE */  sw         $v0, 0x4C($s0)
    /* 8BBB0 8009B3B0 500003AE */  sw         $v1, 0x50($s0)
  .L8009B3B4:
    /* 8BBB4 8009B3B4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 8BBB8 8009B3B8 1400B18F */  lw         $s1, 0x14($sp)
    /* 8BBBC 8009B3BC 1000B08F */  lw         $s0, 0x10($sp)
    /* 8BBC0 8009B3C0 0800E003 */  jr         $ra
    /* 8BBC4 8009B3C4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel DashHUD_HUDCalc__Fi
