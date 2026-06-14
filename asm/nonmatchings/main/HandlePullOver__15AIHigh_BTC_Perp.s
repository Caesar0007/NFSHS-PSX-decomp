.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HandlePullOver__15AIHigh_BTC_Perp, 0x1D8

glabel HandlePullOver__15AIHigh_BTC_Perp
    /* 50258 8005FA58 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5025C 8005FA5C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 50260 8005FA60 21808000 */  addu       $s0, $a0, $zero
    /* 50264 8005FA64 1800BFAF */  sw         $ra, 0x18($sp)
    /* 50268 8005FA68 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5026C 8005FA6C 1800028E */  lw         $v0, 0x18($s0)
    /* 50270 8005FA70 00000000 */  nop
    /* 50274 8005FA74 52004010 */  beqz       $v0, .L8005FBC0
    /* 50278 8005FA78 00000000 */   nop
    /* 5027C 8005FA7C 0C7F010C */  jal        NotifyCopsOfArrest__15AIHigh_BTC_Perp
    /* 50280 8005FA80 00000000 */   nop
    /* 50284 8005FA84 6400028E */  lw         $v0, 0x64($s0)
    /* 50288 8005FA88 1480033C */  lui        $v1, %hi(AI_elapsedTime)
    /* 5028C 8005FA8C 54C5638C */  lw         $v1, %lo(AI_elapsedTime)($v1)
    /* 50290 8005FA90 00000000 */  nop
    /* 50294 8005FA94 23104300 */  subu       $v0, $v0, $v1
    /* 50298 8005FA98 2700401C */  bgtz       $v0, .L8005FB38
    /* 5029C 8005FA9C 640002AE */   sw        $v0, 0x64($s0)
    /* 502A0 8005FAA0 8000028E */  lw         $v0, 0x80($s0)
    /* 502A4 8005FAA4 00000000 */  nop
    /* 502A8 8005FAA8 23004014 */  bnez       $v0, .L8005FB38
    /* 502AC 8005FAAC 00000000 */   nop
    /* 502B0 8005FAB0 E67D010C */  jal        IsFalseArrest__15AIHigh_BTC_Perp
    /* 502B4 8005FAB4 21200002 */   addu      $a0, $s0, $zero
    /* 502B8 8005FAB8 17004010 */  beqz       $v0, .L8005FB18
    /* 502BC 8005FABC 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 502C0 8005FAC0 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 502C4 8005FAC4 21200002 */  addu       $a0, $s0, $zero
    /* 502C8 8005FAC8 80FD4224 */  addiu      $v0, $v0, -0x280
    /* 502CC 8005FACC 687F010C */  jal        NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp
    /* 502D0 8005FAD0 680002AE */   sw        $v0, 0x68($s0)
    /* 502D4 8005FAD4 0000028E */  lw         $v0, 0x0($s0)
    /* 502D8 8005FAD8 00000000 */  nop
    /* 502DC 8005FADC 780240AC */  sw         $zero, 0x278($v0)
    /* 502E0 8005FAE0 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 502E4 8005FAE4 180000AE */  sw         $zero, 0x18($s0)
    /* 502E8 8005FAE8 DCF9448C */  lw         $a0, %lo(Cars_gList)($v0)
    /* 502EC 8005FAEC 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 502F0 8005FAF0 00000000 */   nop
    /* 502F4 8005FAF4 4C00438C */  lw         $v1, 0x4C($v0)
    /* 502F8 8005FAF8 00000000 */  nop
    /* 502FC 8005FAFC 38006484 */  lh         $a0, 0x38($v1)
    /* 50300 8005FB00 3C00638C */  lw         $v1, 0x3C($v1)
    /* 50304 8005FB04 00000000 */  nop
    /* 50308 8005FB08 09F86000 */  jalr       $v1
    /* 5030C 8005FB0C 21204400 */   addu      $a0, $v0, $a0
    /* 50310 8005FB10 CE7E0108 */  j          .L8005FB38
    /* 50314 8005FB14 00000000 */   nop
  .L8005FB18:
    /* 50318 8005FB18 8000028E */  lw         $v0, 0x80($s0)
    /* 5031C 8005FB1C 00000000 */  nop
    /* 50320 8005FB20 05004014 */  bnez       $v0, .L8005FB38
    /* 50324 8005FB24 00000000 */   nop
    /* 50328 8005FB28 967F010C */  jal        NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp
    /* 5032C 8005FB2C 21200002 */   addu      $a0, $s0, $zero
    /* 50330 8005FB30 01000224 */  addiu      $v0, $zero, 0x1
    /* 50334 8005FB34 800002AE */  sw         $v0, 0x80($s0)
  .L8005FB38:
    /* 50338 8005FB38 6E7E010C */  jal        CheckForControlsPressed__15AIHigh_BTC_Perp
    /* 5033C 8005FB3C 21200002 */   addu      $a0, $s0, $zero
    /* 50340 8005FB40 6400038E */  lw         $v1, 0x64($s0)
    /* 50344 8005FB44 00000000 */  nop
    /* 50348 8005FB48 3400601C */  bgtz       $v1, .L8005FC1C
    /* 5034C 8005FB4C 21204000 */   addu      $a0, $v0, $zero
    /* 50350 8005FB50 1800028E */  lw         $v0, 0x18($s0)
    /* 50354 8005FB54 00000000 */  nop
    /* 50358 8005FB58 30004010 */  beqz       $v0, .L8005FC1C
    /* 5035C 8005FB5C 00000000 */   nop
    /* 50360 8005FB60 2E008010 */  beqz       $a0, .L8005FC1C
    /* 50364 8005FB64 01000224 */   addiu     $v0, $zero, 0x1
    /* 50368 8005FB68 8000118E */  lw         $s1, 0x80($s0)
    /* 5036C 8005FB6C 00000000 */  nop
    /* 50370 8005FB70 2A002216 */  bne        $s1, $v0, .L8005FC1C
    /* 50374 8005FB74 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 50378 8005FB78 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* 5037C 8005FB7C 6800028E */  lw         $v0, 0x68($s0)
    /* 50380 8005FB80 00000000 */  nop
    /* 50384 8005FB84 23106200 */  subu       $v0, $v1, $v0
    /* 50388 8005FB88 41014228 */  slti       $v0, $v0, 0x141
    /* 5038C 8005FB8C 23004014 */  bnez       $v0, .L8005FC1C
    /* 50390 8005FB90 00000000 */   nop
    /* 50394 8005FB94 21200002 */  addu       $a0, $s0, $zero
    /* 50398 8005FB98 680003AE */  sw         $v1, 0x68($s0)
    /* 5039C 8005FB9C 3A7F010C */  jal        NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp
    /* 503A0 8005FBA0 780000AE */   sw        $zero, 0x78($s0)
    /* 503A4 8005FBA4 0000028E */  lw         $v0, 0x0($s0)
    /* 503A8 8005FBA8 00000000 */  nop
    /* 503AC 8005FBAC 780240AC */  sw         $zero, 0x278($v0)
    /* 503B0 8005FBB0 180000AE */  sw         $zero, 0x18($s0)
    /* 503B4 8005FBB4 7C0011AE */  sw         $s1, 0x7C($s0)
    /* 503B8 8005FBB8 077F0108 */  j          .L8005FC1C
    /* 503BC 8005FBBC 800000AE */   sw        $zero, 0x80($s0)
  .L8005FBC0:
    /* 503C0 8005FBC0 8400028E */  lw         $v0, 0x84($s0)
    /* 503C4 8005FBC4 00000000 */  nop
    /* 503C8 8005FBC8 7000428C */  lw         $v0, 0x70($v0)
    /* 503CC 8005FBCC 00000000 */  nop
    /* 503D0 8005FBD0 06004228 */  slti       $v0, $v0, 0x6
    /* 503D4 8005FBD4 01004238 */  xori       $v0, $v0, 0x1
    /* 503D8 8005FBD8 04004010 */  beqz       $v0, .L8005FBEC
    /* 503DC 8005FBDC 21180000 */   addu      $v1, $zero, $zero
    /* 503E0 8005FBE0 E36D010C */  jal        CheckIfCaught__16AIHigh_BasicPerp
    /* 503E4 8005FBE4 21200002 */   addu      $a0, $s0, $zero
    /* 503E8 8005FBE8 2B180200 */  sltu       $v1, $zero, $v0
  .L8005FBEC:
    /* 503EC 8005FBEC 0B006010 */  beqz       $v1, .L8005FC1C
    /* 503F0 8005FBF0 01000224 */   addiu     $v0, $zero, 0x1
    /* 503F4 8005FBF4 0000038E */  lw         $v1, 0x0($s0)
    /* 503F8 8005FBF8 00000000 */  nop
    /* 503FC 8005FBFC 780262AC */  sw         $v0, 0x278($v1)
    /* 50400 8005FC00 60000224 */  addiu      $v0, $zero, 0x60
    /* 50404 8005FC04 640002AE */  sw         $v0, 0x64($s0)
    /* 50408 8005FC08 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 5040C 8005FC0C B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* 50410 8005FC10 02000224 */  addiu      $v0, $zero, 0x2
    /* 50414 8005FC14 180002AE */  sw         $v0, 0x18($s0)
    /* 50418 8005FC18 680003AE */  sw         $v1, 0x68($s0)
  .L8005FC1C:
    /* 5041C 8005FC1C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 50420 8005FC20 1400B18F */  lw         $s1, 0x14($sp)
    /* 50424 8005FC24 1000B08F */  lw         $s0, 0x10($sp)
    /* 50428 8005FC28 0800E003 */  jr         $ra
    /* 5042C 8005FC2C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel HandlePullOver__15AIHigh_BTC_Perp
