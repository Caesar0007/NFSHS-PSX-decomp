.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_ChangeIntensityBasedOnTime__Fv, 0xF8

glabel Weather_ChangeIntensityBasedOnTime__Fv
    /* D2AF0 800E22F0 B016828F */  lw         $v0, %gp_rel(Weather_gIntensityChangeFactor)($gp)
    /* D2AF4 800E22F4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D2AF8 800E22F8 0F004018 */  blez       $v0, .L800E2338
    /* D2AFC 800E22FC 1000BFAF */   sw        $ra, 0x10($sp)
    /* D2B00 800E2300 1280043C */  lui        $a0, %hi(D_80123412)
    /* D2B04 800E2304 1280023C */  lui        $v0, %hi(Weather_gIntensityTbl)
    /* D2B08 800E2308 A816838F */  lw         $v1, %gp_rel(Weather_gIntensityGoalState)($gp)
    /* D2B0C 800E230C 94334224 */  addiu      $v0, $v0, %lo(Weather_gIntensityTbl)
    /* D2B10 800E2310 80180300 */  sll        $v1, $v1, 2
    /* D2B14 800E2314 21186200 */  addu       $v1, $v1, $v0
    /* D2B18 800E2318 12348284 */  lh         $v0, %lo(D_80123412)($a0)
    /* D2B1C 800E231C 0000638C */  lw         $v1, 0x0($v1)
    /* D2B20 800E2320 00000000 */  nop
    /* D2B24 800E2324 2A104300 */  slt        $v0, $v0, $v1
    /* D2B28 800E2328 1C004014 */  bnez       $v0, .L800E239C
    /* D2B2C 800E232C 1280023C */   lui       $v0, %hi(Weather_gSys)
    /* D2B30 800E2330 E4880308 */  j          .L800E2390
    /* D2B34 800E2334 00000000 */   nop
  .L800E2338:
    /* D2B38 800E2338 0F004104 */  bgez       $v0, .L800E2378
    /* D2B3C 800E233C 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* D2B40 800E2340 1280043C */  lui        $a0, %hi(D_80123412)
    /* D2B44 800E2344 1280033C */  lui        $v1, %hi(Weather_gIntensityTbl)
    /* D2B48 800E2348 A816828F */  lw         $v0, %gp_rel(Weather_gIntensityGoalState)($gp)
    /* D2B4C 800E234C 94336324 */  addiu      $v1, $v1, %lo(Weather_gIntensityTbl)
    /* D2B50 800E2350 80100200 */  sll        $v0, $v0, 2
    /* D2B54 800E2354 21104300 */  addu       $v0, $v0, $v1
    /* D2B58 800E2358 12348384 */  lh         $v1, %lo(D_80123412)($a0)
    /* D2B5C 800E235C 0000428C */  lw         $v0, 0x0($v0)
    /* D2B60 800E2360 00000000 */  nop
    /* D2B64 800E2364 2A104300 */  slt        $v0, $v0, $v1
    /* D2B68 800E2368 0C004014 */  bnez       $v0, .L800E239C
    /* D2B6C 800E236C 1280023C */   lui       $v0, %hi(Weather_gSys)
    /* D2B70 800E2370 E4880308 */  j          .L800E2390
    /* D2B74 800E2374 00000000 */   nop
  .L800E2378:
    /* D2B78 800E2378 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* D2B7C 800E237C B816828F */  lw         $v0, %gp_rel(Weather_gIntensityTimerGoal)($gp)
    /* D2B80 800E2380 00000000 */  nop
    /* D2B84 800E2384 2A104300 */  slt        $v0, $v0, $v1
    /* D2B88 800E2388 04004010 */  beqz       $v0, .L800E239C
    /* D2B8C 800E238C 1280023C */   lui       $v0, %hi(Weather_gSys)
  .L800E2390:
    /* D2B90 800E2390 6888030C */  jal        Weather_ChangeIntensityState__Fv
    /* D2B94 800E2394 00000000 */   nop
    /* D2B98 800E2398 1280023C */  lui        $v0, %hi(Weather_gSys)
  .L800E239C:
    /* D2B9C 800E239C 08344224 */  addiu      $v0, $v0, %lo(Weather_gSys)
    /* D2BA0 800E23A0 0A004394 */  lhu        $v1, 0xA($v0)
    /* D2BA4 800E23A4 B0168497 */  lhu        $a0, %gp_rel(Weather_gIntensityChangeFactor)($gp)
    /* D2BA8 800E23A8 00000000 */  nop
    /* D2BAC 800E23AC 21186400 */  addu       $v1, $v1, $a0
    /* D2BB0 800E23B0 0A0043A4 */  sh         $v1, 0xA($v0)
    /* D2BB4 800E23B4 001C0300 */  sll        $v1, $v1, 16
    /* D2BB8 800E23B8 031C0300 */  sra        $v1, $v1, 16
    /* D2BBC 800E23BC E0FF6328 */  slti       $v1, $v1, -0x20
    /* D2BC0 800E23C0 04006010 */  beqz       $v1, .L800E23D4
    /* D2BC4 800E23C4 01000224 */   addiu     $v0, $zero, 0x1
    /* D2BC8 800E23C8 A01682AF */  sw         $v0, %gp_rel(Weather_gType)($gp)
    /* D2BCC 800E23CC F6880308 */  j          .L800E23D8
    /* D2BD0 800E23D0 00000000 */   nop
  .L800E23D4:
    /* D2BD4 800E23D4 A01680AF */  sw         $zero, %gp_rel(Weather_gType)($gp)
  .L800E23D8:
    /* D2BD8 800E23D8 1000BF8F */  lw         $ra, 0x10($sp)
    /* D2BDC 800E23DC 00000000 */  nop
    /* D2BE0 800E23E0 0800E003 */  jr         $ra
    /* D2BE4 800E23E4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Weather_ChangeIntensityBasedOnTime__Fv
