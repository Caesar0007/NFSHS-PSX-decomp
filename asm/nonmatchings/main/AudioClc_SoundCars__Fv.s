.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_SoundCars__Fv, 0x2C0

glabel AudioClc_SoundCars__Fv
    /* 66960 80076160 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 66964 80076164 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 66968 80076168 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6696C 8007616C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 66970 80076170 4CD8010C */  jal        AudioClc_SoundSpeech__Fv
    /* 66974 80076174 1000B0AF */   sw        $s0, 0x10($sp)
    /* 66978 80076178 34D9010C */  jal        AudioCmn_UpdateThunder__Fv
    /* 6697C 8007617C 00000000 */   nop
    /* 66980 80076180 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 66984 80076184 EC314524 */  addiu      $a1, $v0, %lo(GameSetup_gData)
    /* 66988 80076188 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 6698C 8007618C 01000224 */  addiu      $v0, $zero, 0x1
    /* 66990 80076190 03006210 */  beq        $v1, $v0, .L800761A0
    /* 66994 80076194 05000224 */   addiu     $v0, $zero, 0x5
    /* 66998 80076198 35006214 */  bne        $v1, $v0, .L80076270
    /* 6699C 8007619C 1180023C */   lui       $v0, %hi(D_801131F8)
  .L800761A0:
    /* 669A0 800761A0 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 669A4 800761A4 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 669A8 800761A8 00000000 */  nop
    /* 669AC 800761AC 6002428C */  lw         $v0, 0x260($v0)
    /* 669B0 800761B0 00000000 */  nop
    /* 669B4 800761B4 00024230 */  andi       $v0, $v0, 0x200
    /* 669B8 800761B8 0D004014 */  bnez       $v0, .L800761F0
    /* 669BC 800761BC 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* 669C0 800761C0 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 669C4 800761C4 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 669C8 800761C8 02000224 */  addiu      $v0, $zero, 0x2
    /* 669CC 800761CC 28006214 */  bne        $v1, $v0, .L80076270
    /* 669D0 800761D0 1180023C */   lui       $v0, %hi(D_801131F8)
    /* 669D4 800761D4 0400828C */  lw         $v0, 0x4($a0)
    /* 669D8 800761D8 00000000 */  nop
    /* 669DC 800761DC 6002428C */  lw         $v0, 0x260($v0)
    /* 669E0 800761E0 00000000 */  nop
    /* 669E4 800761E4 00024230 */  andi       $v0, $v0, 0x200
    /* 669E8 800761E8 21004010 */  beqz       $v0, .L80076270
    /* 669EC 800761EC 1180023C */   lui       $v0, %hi(D_801131F8)
  .L800761F0:
    /* 669F0 800761F0 1480023C */  lui        $v0, %hi(HudBustedOverlay)
    /* 669F4 800761F4 28D9428C */  lw         $v0, %lo(HudBustedOverlay)($v0)
    /* 669F8 800761F8 00000000 */  nop
    /* 669FC 800761FC 1C004010 */  beqz       $v0, .L80076270
    /* 66A00 80076200 1180023C */   lui       $v0, %hi(D_801131F8)
    /* 66A04 80076204 AC01A28C */  lw         $v0, 0x1AC($a1)
    /* 66A08 80076208 00000000 */  nop
    /* 66A0C 8007620C 17004018 */  blez       $v0, .L8007626C
    /* 66A10 80076210 21880000 */   addu      $s1, $zero, $zero
    /* 66A14 80076214 2190A000 */  addu       $s2, $a1, $zero
    /* 66A18 80076218 21804002 */  addu       $s0, $s2, $zero
  .L8007621C:
    /* 66A1C 8007621C 21280000 */  addu       $a1, $zero, $zero
    /* 66A20 80076220 BC01048E */  lw         $a0, 0x1BC($s0)
    /* 66A24 80076224 B368020C */  jal        CopSpeak_GetEnginePatch__Fii
    /* 66A28 80076228 01003126 */   addiu     $s1, $s1, 0x1
    /* 66A2C 8007622C 01000424 */  addiu      $a0, $zero, 0x1
    /* 66A30 80076230 21284000 */  addu       $a1, $v0, $zero
    /* 66A34 80076234 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 66A38 80076238 21300000 */   addu      $a2, $zero, $zero
    /* 66A3C 8007623C BC01048E */  lw         $a0, 0x1BC($s0)
    /* 66A40 80076240 B368020C */  jal        CopSpeak_GetEnginePatch__Fii
    /* 66A44 80076244 01000524 */   addiu     $a1, $zero, 0x1
    /* 66A48 80076248 01000424 */  addiu      $a0, $zero, 0x1
    /* 66A4C 8007624C 21284000 */  addu       $a1, $v0, $zero
    /* 66A50 80076250 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 66A54 80076254 21300000 */   addu      $a2, $zero, $zero
    /* 66A58 80076258 AC01428E */  lw         $v0, 0x1AC($s2)
    /* 66A5C 8007625C 00000000 */  nop
    /* 66A60 80076260 2A102202 */  slt        $v0, $s1, $v0
    /* 66A64 80076264 EDFF4014 */  bnez       $v0, .L8007621C
    /* 66A68 80076268 34001026 */   addiu     $s0, $s0, 0x34
  .L8007626C:
    /* 66A6C 8007626C 1180023C */  lui        $v0, %hi(D_801131F8)
  .L80076270:
    /* 66A70 80076270 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 66A74 80076274 01000224 */  addiu      $v0, $zero, 0x1
    /* 66A78 80076278 3F006214 */  bne        $v1, $v0, .L80076378
    /* 66A7C 8007627C 1180103C */   lui       $s0, %hi(AudioClc_gRenderView)
    /* 66A80 80076280 21200000 */  addu       $a0, $zero, $zero
    /* 66A84 80076284 28E41126 */  addiu      $s1, $s0, %lo(AudioClc_gRenderView)
    /* 66A88 80076288 1480063C */  lui        $a2, %hi(AudioClc_gCameraVelocity)
    /* 66A8C 8007628C 08C6C624 */  addiu      $a2, $a2, %lo(AudioClc_gCameraVelocity)
    /* 66A90 80076290 CF14020C */  jal        Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef
    /* 66A94 80076294 21282002 */   addu      $a1, $s1, $zero
    /* 66A98 80076298 21200000 */  addu       $a0, $zero, $zero
    /* 66A9C 8007629C 21288000 */  addu       $a1, $a0, $zero
    /* 66AA0 800762A0 41D7010C */  jal        AudioClc_GetClosestCars__Fiii
    /* 66AA4 800762A4 02000624 */   addiu     $a2, $zero, 0x2
    /* 66AA8 800762A8 42D5010C */  jal        AudioClc_SoundPlayersCar__Fi
    /* 66AAC 800762AC 21200000 */   addu      $a0, $zero, $zero
    /* 66AB0 800762B0 1480023C */  lui        $v0, %hi(gMasterAmbientLevel)
    /* 66AB4 800762B4 60C6428C */  lw         $v0, %lo(gMasterAmbientLevel)($v0)
    /* 66AB8 800762B8 00000000 */  nop
    /* 66ABC 800762BC 08004018 */  blez       $v0, .L800762E0
    /* 66AC0 800762C0 21282002 */   addu      $a1, $s1, $zero
    /* 66AC4 800762C4 21200000 */  addu       $a0, $zero, $zero
    /* 66AC8 800762C8 0AD4010C */  jal        AudioClc_SoundCloseCar__Fii
    /* 66ACC 800762CC 21288000 */   addu      $a1, $a0, $zero
    /* 66AD0 800762D0 21200000 */  addu       $a0, $zero, $zero
    /* 66AD4 800762D4 0AD4010C */  jal        AudioClc_SoundCloseCar__Fii
    /* 66AD8 800762D8 01000524 */   addiu     $a1, $zero, 0x1
    /* 66ADC 800762DC 21282002 */  addu       $a1, $s1, $zero
  .L800762E0:
    /* 66AE0 800762E0 1480063C */  lui        $a2, %hi(AudioClc_gCameraVelocity)
    /* 66AE4 800762E4 08C6C624 */  addiu      $a2, $a2, %lo(AudioClc_gCameraVelocity)
    /* 66AE8 800762E8 1180023C */  lui        $v0, %hi(AudioClc_gPlayer)
    /* 66AEC 800762EC A8E25124 */  addiu      $s1, $v0, %lo(AudioClc_gPlayer)
    /* 66AF0 800762F0 28E40A26 */  addiu      $t2, $s0, %lo(AudioClc_gRenderView)
    /* 66AF4 800762F4 0000478D */  lw         $a3, 0x0($t2)
    /* 66AF8 800762F8 0400488D */  lw         $t0, 0x4($t2)
    /* 66AFC 800762FC 0800498D */  lw         $t1, 0x8($t2)
    /* 66B00 80076300 0C0027AE */  sw         $a3, 0xC($s1)
    /* 66B04 80076304 100028AE */  sw         $t0, 0x10($s1)
    /* 66B08 80076308 140029AE */  sw         $t1, 0x14($s1)
    /* 66B0C 8007630C CF14020C */  jal        Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef
    /* 66B10 80076310 01000424 */   addiu     $a0, $zero, 0x1
    /* 66B14 80076314 01000424 */  addiu      $a0, $zero, 0x1
    /* 66B18 80076318 02000524 */  addiu      $a1, $zero, 0x2
    /* 66B1C 8007631C 41D7010C */  jal        AudioClc_GetClosestCars__Fiii
    /* 66B20 80076320 2130A000 */   addu      $a2, $a1, $zero
    /* 66B24 80076324 42D5010C */  jal        AudioClc_SoundPlayersCar__Fi
    /* 66B28 80076328 01000424 */   addiu     $a0, $zero, 0x1
    /* 66B2C 8007632C 1480023C */  lui        $v0, %hi(gMasterAmbientLevel)
    /* 66B30 80076330 60C6428C */  lw         $v0, %lo(gMasterAmbientLevel)($v0)
    /* 66B34 80076334 00000000 */  nop
    /* 66B38 80076338 06004018 */  blez       $v0, .L80076354
    /* 66B3C 8007633C 01000424 */   addiu     $a0, $zero, 0x1
    /* 66B40 80076340 0AD4010C */  jal        AudioClc_SoundCloseCar__Fii
    /* 66B44 80076344 02000524 */   addiu     $a1, $zero, 0x2
    /* 66B48 80076348 01000424 */  addiu      $a0, $zero, 0x1
    /* 66B4C 8007634C 0AD4010C */  jal        AudioClc_SoundCloseCar__Fii
    /* 66B50 80076350 03000524 */   addiu     $a1, $zero, 0x3
  .L80076354:
    /* 66B54 80076354 28E40A26 */  addiu      $t2, $s0, %lo(AudioClc_gRenderView)
    /* 66B58 80076358 0000478D */  lw         $a3, 0x0($t2)
    /* 66B5C 8007635C 0400488D */  lw         $t0, 0x4($t2)
    /* 66B60 80076360 0800498D */  lw         $t1, 0x8($t2)
    /* 66B64 80076364 5C0027AE */  sw         $a3, 0x5C($s1)
    /* 66B68 80076368 600028AE */  sw         $t0, 0x60($s1)
    /* 66B6C 8007636C 640029AE */  sw         $t1, 0x64($s1)
    /* 66B70 80076370 02D90108 */  j          .L80076408
    /* 66B74 80076374 00000000 */   nop
  .L80076378:
    /* 66B78 80076378 21200000 */  addu       $a0, $zero, $zero
    /* 66B7C 8007637C 1480063C */  lui        $a2, %hi(AudioClc_gCameraVelocity)
    /* 66B80 80076380 08C6C624 */  addiu      $a2, $a2, %lo(AudioClc_gCameraVelocity)
    /* 66B84 80076384 CF14020C */  jal        Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef
    /* 66B88 80076388 28E40526 */   addiu     $a1, $s0, %lo(AudioClc_gRenderView)
    /* 66B8C 8007638C 21200000 */  addu       $a0, $zero, $zero
    /* 66B90 80076390 21288000 */  addu       $a1, $a0, $zero
    /* 66B94 80076394 41D7010C */  jal        AudioClc_GetClosestCars__Fiii
    /* 66B98 80076398 04000624 */   addiu     $a2, $zero, 0x4
    /* 66B9C 8007639C 42D5010C */  jal        AudioClc_SoundPlayersCar__Fi
    /* 66BA0 800763A0 21200000 */   addu      $a0, $zero, $zero
    /* 66BA4 800763A4 1480023C */  lui        $v0, %hi(gMasterAmbientLevel)
    /* 66BA8 800763A8 60C6428C */  lw         $v0, %lo(gMasterAmbientLevel)($v0)
    /* 66BAC 800763AC 00000000 */  nop
    /* 66BB0 800763B0 0C004018 */  blez       $v0, .L800763E4
    /* 66BB4 800763B4 21200000 */   addu      $a0, $zero, $zero
    /* 66BB8 800763B8 0AD4010C */  jal        AudioClc_SoundCloseCar__Fii
    /* 66BBC 800763BC 21288000 */   addu      $a1, $a0, $zero
    /* 66BC0 800763C0 21200000 */  addu       $a0, $zero, $zero
    /* 66BC4 800763C4 0AD4010C */  jal        AudioClc_SoundCloseCar__Fii
    /* 66BC8 800763C8 01000524 */   addiu     $a1, $zero, 0x1
    /* 66BCC 800763CC 21200000 */  addu       $a0, $zero, $zero
    /* 66BD0 800763D0 0AD4010C */  jal        AudioClc_SoundCloseCar__Fii
    /* 66BD4 800763D4 02000524 */   addiu     $a1, $zero, 0x2
    /* 66BD8 800763D8 21200000 */  addu       $a0, $zero, $zero
    /* 66BDC 800763DC 0AD4010C */  jal        AudioClc_SoundCloseCar__Fii
    /* 66BE0 800763E0 03000524 */   addiu     $a1, $zero, 0x3
  .L800763E4:
    /* 66BE4 800763E4 1180023C */  lui        $v0, %hi(AudioClc_gPlayer)
    /* 66BE8 800763E8 A8E24224 */  addiu      $v0, $v0, %lo(AudioClc_gPlayer)
    /* 66BEC 800763EC 28E40A26 */  addiu      $t2, $s0, %lo(AudioClc_gRenderView)
    /* 66BF0 800763F0 0000478D */  lw         $a3, 0x0($t2)
    /* 66BF4 800763F4 0400488D */  lw         $t0, 0x4($t2)
    /* 66BF8 800763F8 0800498D */  lw         $t1, 0x8($t2)
    /* 66BFC 800763FC 0C0047AC */  sw         $a3, 0xC($v0)
    /* 66C00 80076400 100048AC */  sw         $t0, 0x10($v0)
    /* 66C04 80076404 140049AC */  sw         $t1, 0x14($v0)
  .L80076408:
    /* 66C08 80076408 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 66C0C 8007640C 1800B28F */  lw         $s2, 0x18($sp)
    /* 66C10 80076410 1400B18F */  lw         $s1, 0x14($sp)
    /* 66C14 80076414 1000B08F */  lw         $s0, 0x10($sp)
    /* 66C18 80076418 0800E003 */  jr         $ra
    /* 66C1C 8007641C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioClc_SoundCars__Fv
