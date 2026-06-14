.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_Init__Fv, 0x178

glabel AudioCmn_Init__Fv
    /* 67274 80076A74 F800828F */  lw         $v0, %gp_rel(AudioCmn_kAudioOn)($gp)
    /* 67278 80076A78 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6727C 80076A7C 1C004010 */  beqz       $v0, .L80076AF0
    /* 67280 80076A80 1000BFAF */   sw        $ra, 0x10($sp)
    /* 67284 80076A84 2CDE010C */  jal        AudioCmn_InitChannelArray__Fv
    /* 67288 80076A88 00000000 */   nop
    /* 6728C 80076A8C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 67290 80076A90 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 67294 80076A94 3C00448C */  lw         $a0, 0x3C($v0)
    /* 67298 80076A98 3000438C */  lw         $v1, 0x30($v0)
    /* 6729C 80076A9C 10008230 */  andi       $v0, $a0, 0x10
    /* 672A0 80076AA0 E00083AF */  sw         $v1, %gp_rel(audioBackwardsDirection)($gp)
    /* 672A4 80076AA4 02004010 */  beqz       $v0, .L80076AB0
    /* 672A8 80076AA8 0F008230 */   andi      $v0, $a0, 0xF
    /* 672AC 80076AAC 05004424 */  addiu      $a0, $v0, 0x5
  .L80076AB0:
    /* 672B0 80076AB0 E000828F */  lw         $v0, %gp_rel(audioBackwardsDirection)($gp)
    /* 672B4 80076AB4 00000000 */  nop
    /* 672B8 80076AB8 03004014 */  bnez       $v0, .L80076AC8
    /* 672BC 80076ABC 1180033C */   lui       $v1, %hi(falseLapTrigNumsForward)
    /* 672C0 80076AC0 B4DA0108 */  j          .L80076AD0
    /* 672C4 80076AC4 ECE56324 */   addiu     $v1, $v1, %lo(falseLapTrigNumsForward)
  .L80076AC8:
    /* 672C8 80076AC8 1180033C */  lui        $v1, %hi(falseLapTrigNumsBackward)
    /* 672CC 80076ACC 3CE66324 */  addiu      $v1, $v1, %lo(falseLapTrigNumsBackward)
  .L80076AD0:
    /* 672D0 80076AD0 C0100400 */  sll        $v0, $a0, 3
    /* 672D4 80076AD4 21104300 */  addu       $v0, $v0, $v1
    /* 672D8 80076AD8 0000438C */  lw         $v1, 0x0($v0)
    /* 672DC 80076ADC 0400428C */  lw         $v0, 0x4($v0)
    /* 672E0 80076AE0 680183AF */  sw         $v1, %gp_rel(falseLapTrigCur)($gp)
    /* 672E4 80076AE4 6C0182AF */  sw         $v0, %gp_rel(flaseLapTrigTrack)($gp)
    /* 672E8 80076AE8 E40080AF */  sw         $zero, %gp_rel(intensityFalseLapCounter)($gp)
    /* 672EC 80076AEC E80080AF */  sw         $zero, %gp_rel(falseLapCounter)($gp)
  .L80076AF0:
    /* 672F0 80076AF0 21180000 */  addu       $v1, $zero, $zero
    /* 672F4 80076AF4 14800C3C */  lui        $t4, %hi(fAmbientRangeON)
    /* 672F8 80076AF8 F4C68C25 */  addiu      $t4, $t4, %lo(fAmbientRangeON)
    /* 672FC 80076AFC 14800B3C */  lui        $t3, %hi(fMysticWindON)
    /* 67300 80076B00 F0C66B25 */  addiu      $t3, $t3, %lo(fMysticWindON)
    /* 67304 80076B04 14800A3C */  lui        $t2, %hi(currentLap)
    /* 67308 80076B08 BCC64A25 */  addiu      $t2, $t2, %lo(currentLap)
    /* 6730C 80076B0C 00020924 */  addiu      $t1, $zero, 0x200
    /* 67310 80076B10 1480083C */  lui        $t0, %hi(AudioCmn_gPlayerArrested)
    /* 67314 80076B14 D0C60825 */  addiu      $t0, $t0, %lo(AudioCmn_gPlayerArrested)
    /* 67318 80076B18 1480073C */  lui        $a3, %hi(gtotallaptimes)
    /* 6731C 80076B1C C8C6E724 */  addiu      $a3, $a3, %lo(gtotallaptimes)
    /* 67320 80076B20 1480063C */  lui        $a2, %hi(D_8013DD80)
    /* 67324 80076B24 80DDC624 */  addiu      $a2, $a2, %lo(D_8013DD80)
    /* 67328 80076B28 1480053C */  lui        $a1, %hi(bestLapTime)
    /* 6732C 80076B2C C0C6A524 */  addiu      $a1, $a1, %lo(bestLapTime)
    /* 67330 80076B30 1180023C */  lui        $v0, %hi(AudioCmn_gReTrig)
    /* 67334 80076B34 68E84424 */  addiu      $a0, $v0, %lo(AudioCmn_gReTrig)
  .L80076B38:
    /* 67338 80076B38 21106C00 */  addu       $v0, $v1, $t4
    /* 6733C 80076B3C 000080AC */  sw         $zero, 0x0($a0)
    /* 67340 80076B40 000040A0 */  sb         $zero, 0x0($v0)
    /* 67344 80076B44 21106B00 */  addu       $v0, $v1, $t3
    /* 67348 80076B48 000040A0 */  sb         $zero, 0x0($v0)
    /* 6734C 80076B4C 21106A00 */  addu       $v0, $v1, $t2
    /* 67350 80076B50 000040A0 */  sb         $zero, 0x0($v0)
    /* 67354 80076B54 0000A0AC */  sw         $zero, 0x0($a1)
    /* 67358 80076B58 0000C0AC */  sw         $zero, 0x0($a2)
    /* 6735C 80076B5C 0000E9AC */  sw         $t1, 0x0($a3)
    /* 67360 80076B60 000000AD */  sw         $zero, 0x0($t0)
    /* 67364 80076B64 04000825 */  addiu      $t0, $t0, 0x4
    /* 67368 80076B68 0400E724 */  addiu      $a3, $a3, 0x4
    /* 6736C 80076B6C 0400C624 */  addiu      $a2, $a2, 0x4
    /* 67370 80076B70 0400A524 */  addiu      $a1, $a1, 0x4
    /* 67374 80076B74 01006324 */  addiu      $v1, $v1, 0x1
    /* 67378 80076B78 02006228 */  slti       $v0, $v1, 0x2
    /* 6737C 80076B7C EEFF4014 */  bnez       $v0, .L80076B38
    /* 67380 80076B80 20008424 */   addiu     $a0, $a0, 0x20
    /* 67384 80076B84 24D9010C */  jal        AudioCmn_InitThunder__Fv
    /* 67388 80076B88 00000000 */   nop
    /* 6738C 80076B8C 5FD9010C */  jal        AudioCmn_InitAsyncSfx__Fv
    /* 67390 80076B90 00000000 */   nop
    /* 67394 80076B94 BDF1010C */  jal        AudioTrk_StartUp__Fv
    /* 67398 80076B98 00000000 */   nop
    /* 6739C 80076B9C 2C0180A3 */  sb         $zero, %gp_rel(fReverbOn)($gp)
    /* 673A0 80076BA0 2D0180A3 */  sb         $zero, %gp_rel(fReverbLevel)($gp)
    /* 673A4 80076BA4 F10080A3 */  sb         $zero, %gp_rel(FadingMusic)($gp)
    /* 673A8 80076BA8 F20080A3 */  sb         $zero, %gp_rel(StartedNewMusic)($gp)
    /* 673AC 80076BAC 20D9010C */  jal        AudioCmn_GetTrackRecordLapTime__Fv
    /* 673B0 80076BB0 00000000 */   nop
    /* 673B4 80076BB4 0801838F */  lw         $v1, %gp_rel(gMasterSFXLevel)($gp)
    /* 673B8 80076BB8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 673BC 80076BBC F40082AF */  sw         $v0, %gp_rel(recordLapTime)($gp)
    /* 673C0 80076BC0 04000224 */  addiu      $v0, $zero, 0x4
    /* 673C4 80076BC4 DC0082A3 */  sb         $v0, %gp_rel(trackMusicState)($gp)
    /* 673C8 80076BC8 7F000224 */  addiu      $v0, $zero, 0x7F
    /* 673CC 80076BCC 900182AF */  sw         $v0, %gp_rel(AudioCmn_gLastFade)($gp)
    /* 673D0 80076BD0 1180023C */  lui        $v0, %hi(D_801132E0)
    /* 673D4 80076BD4 9C0180AF */  sw         $zero, %gp_rel(AudioCmn_gResume)($gp)
    /* 673D8 80076BD8 A00180AF */  sw         $zero, %gp_rel(AudioCmn_gStreamRestartTimer)($gp)
    /* 673DC 80076BDC C40180AF */  sw         $zero, %gp_rel(gQuickSirenCount)($gp)
    /* 673E0 80076BE0 E03243AC */  sw         $v1, %lo(D_801132E0)($v0)
    /* 673E4 80076BE4 0800E003 */  jr         $ra
    /* 673E8 80076BE8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioCmn_Init__Fv
