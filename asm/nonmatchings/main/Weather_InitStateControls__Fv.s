.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_InitStateControls__Fv, 0xCC

glabel Weather_InitStateControls__Fv
    /* D2BE8 800E23E8 1180023C */  lui        $v0, %hi(D_80113228)
    /* D2BEC 800E23EC 1280033C */  lui        $v1, %hi(Weather_gTrackIntensityLimitTbl)
    /* D2BF0 800E23F0 2832448C */  lw         $a0, %lo(D_80113228)($v0)
    /* D2BF4 800E23F4 A4336324 */  addiu      $v1, $v1, %lo(Weather_gTrackIntensityLimitTbl)
    /* D2BF8 800E23F8 80100400 */  sll        $v0, $a0, 2
    /* D2BFC 800E23FC 21104300 */  addu       $v0, $v0, $v1
    /* D2C00 800E2400 0000428C */  lw         $v0, 0x0($v0)
    /* D2C04 800E2404 00000000 */  nop
    /* D2C08 800E2408 C01682AF */  sw         $v0, %gp_rel(Weather_gTrackIntensityLimit)($gp)
    /* D2C0C 800E240C 03008010 */  beqz       $a0, .L800E241C
    /* D2C10 800E2410 04000224 */   addiu     $v0, $zero, 0x4
    /* D2C14 800E2414 07008214 */  bne        $a0, $v0, .L800E2434
    /* D2C18 800E2418 1280033C */   lui       $v1, %hi(Weather_gIntensityTbl)
  .L800E241C:
    /* D2C1C 800E241C 01000224 */  addiu      $v0, $zero, 0x1
    /* D2C20 800E2420 BC1682AF */  sw         $v0, %gp_rel(Weather_gSnowTrack)($gp)
    /* D2C24 800E2424 03000224 */  addiu      $v0, $zero, 0x3
    /* D2C28 800E2428 A81682AF */  sw         $v0, %gp_rel(Weather_gIntensityGoalState)($gp)
    /* D2C2C 800E242C 0F890308 */  j          .L800E243C
    /* D2C30 800E2430 1280033C */   lui       $v1, %hi(Weather_gIntensityTbl)
  .L800E2434:
    /* D2C34 800E2434 BC1680AF */  sw         $zero, %gp_rel(Weather_gSnowTrack)($gp)
    /* D2C38 800E2438 A81680AF */  sw         $zero, %gp_rel(Weather_gIntensityGoalState)($gp)
  .L800E243C:
    /* D2C3C 800E243C A816848F */  lw         $a0, %gp_rel(Weather_gIntensityGoalState)($gp)
    /* D2C40 800E2440 94336324 */  addiu      $v1, $v1, %lo(Weather_gIntensityTbl)
    /* D2C44 800E2444 80100400 */  sll        $v0, $a0, 2
    /* D2C48 800E2448 21104300 */  addu       $v0, $v0, $v1
    /* D2C4C 800E244C 00004394 */  lhu        $v1, 0x0($v0)
    /* D2C50 800E2450 1280023C */  lui        $v0, %hi(D_80123412)
    /* D2C54 800E2454 123443A4 */  sh         $v1, %lo(D_80123412)($v0)
    /* D2C58 800E2458 03000224 */  addiu      $v0, $zero, 0x3
    /* D2C5C 800E245C 04008214 */  bne        $a0, $v0, .L800E2470
    /* D2C60 800E2460 01000224 */   addiu     $v0, $zero, 0x1
    /* D2C64 800E2464 A01680AF */  sw         $zero, %gp_rel(Weather_gType)($gp)
    /* D2C68 800E2468 1E890308 */  j          .L800E2478
    /* D2C6C 800E246C 1280023C */   lui       $v0, %hi(D_8011E0B0)
  .L800E2470:
    /* D2C70 800E2470 A01682AF */  sw         $v0, %gp_rel(Weather_gType)($gp)
    /* D2C74 800E2474 1280023C */  lui        $v0, %hi(D_8011E0B0)
  .L800E2478:
    /* D2C78 800E2478 B0E0458C */  lw         $a1, %lo(D_8011E0B0)($v0)
    /* D2C7C 800E247C 03000224 */  addiu      $v0, $zero, 0x3
    /* D2C80 800E2480 A41682AF */  sw         $v0, %gp_rel(Weather_gDensityGoalState)($gp)
    /* D2C84 800E2484 1280023C */  lui        $v0, %hi(D_80123390)
    /* D2C88 800E2488 9033438C */  lw         $v1, %lo(D_80123390)($v0)
    /* D2C8C 800E248C 1280023C */  lui        $v0, %hi(Weather_gSys)
    /* D2C90 800E2490 B01680AF */  sw         $zero, %gp_rel(Weather_gIntensityChangeFactor)($gp)
    /* D2C94 800E2494 AC1680AF */  sw         $zero, %gp_rel(Weather_gDensityChangeFactor)($gp)
    /* D2C98 800E2498 0004A424 */  addiu      $a0, $a1, 0x400
    /* D2C9C 800E249C B81684AF */  sw         $a0, %gp_rel(Weather_gIntensityTimerGoal)($gp)
    /* D2CA0 800E24A0 083443AC */  sw         $v1, %lo(Weather_gSys)($v0)
    /* D2CA4 800E24A4 B41684AF */  sw         $a0, %gp_rel(Weather_gDensityTimerGoal)($gp)
    /* D2CA8 800E24A8 001985AF */  sw         $a1, %gp_rel(D_8013DE4C)($gp)
    /* D2CAC 800E24AC 0800E003 */  jr         $ra
    /* D2CB0 800E24B0 00000000 */   nop
endlabel Weather_InitStateControls__Fv
