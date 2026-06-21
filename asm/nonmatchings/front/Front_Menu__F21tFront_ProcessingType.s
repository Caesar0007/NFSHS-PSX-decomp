.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_Menu__F21tFront_ProcessingType, 0x2B4

glabel Front_Menu__F21tFront_ProcessingType
    /* 182F4 80027AF4 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 182F8 80027AF8 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 182FC 80027AFC 21888000 */  addu       $s1, $a0, $zero
    /* 18300 80027B00 2400B3AF */  sw         $s3, 0x24($sp)
    /* 18304 80027B04 21980000 */  addu       $s3, $zero, $zero
    /* 18308 80027B08 0580023C */  lui        $v0, %hi(_7tScreen_fSuppressLoadingText)
    /* 1830C 80027B0C 2800B4AF */  sw         $s4, 0x28($sp)
    /* 18310 80027B10 01001424 */  addiu      $s4, $zero, 0x1
    /* 18314 80027B14 3000BFAF */  sw         $ra, 0x30($sp)
    /* 18318 80027B18 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 1831C 80027B1C 2000B2AF */  sw         $s2, 0x20($sp)
    /* 18320 80027B20 1800B0AF */  sw         $s0, 0x18($sp)
    /* 18324 80027B24 A194030C */  jal        largestunused
    /* 18328 80027B28 C81754AC */   sw        $s4, %lo(_7tScreen_fSuppressLoadingText)($v0)
    /* 1832C 80027B2C 21286002 */  addu       $a1, $s3, $zero
    /* 18330 80027B30 21806002 */  addu       $s0, $s3, $zero
    /* 18334 80027B34 1180033C */  lui        $v1, %hi(frontEnd)
    /* 18338 80027B38 00467524 */  addiu      $s5, $v1, %lo(frontEnd)
    /* 1833C 80027B3C 4003A492 */  lbu        $a0, 0x340($s5)
    /* 18340 80027B40 0580033C */  lui        $v1, %hi(gLargestUnused)
    /* 18344 80027B44 3658000C */  jal        FeAudio_InitCommentary__Fii
    /* 18348 80027B48 B81462AC */   sw        $v0, %lo(gLargestUnused)($v1)
    /* 1834C 80027B4C 1436010C */  jal        InitializeSpinningCars__Fv
    /* 18350 80027B50 00000000 */   nop
    /* 18354 80027B54 969B000C */  jal        Front_ConstructAll__Fv
    /* 18358 80027B58 00000000 */   nop
    /* 1835C 80027B5C 1180023C */  lui        $v0, %hi(carManager)
    /* 18360 80027B60 74425224 */  addiu      $s2, $v0, %lo(carManager)
    /* 18364 80027B64 21204002 */  addu       $a0, $s2, $zero
    /* 18368 80027B68 CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 1836C 80027B6C 21286002 */   addu      $a1, $s3, $zero
    /* 18370 80027B70 00140200 */  sll        $v0, $v0, 16
    /* 18374 80027B74 0400401C */  bgtz       $v0, .L80027B88
    /* 18378 80027B78 1180023C */   lui       $v0, %hi(D_80114AEC)
    /* 1837C 80027B7C EC4A428C */  lw         $v0, %lo(D_80114AEC)($v0)
    /* 18380 80027B80 00000000 */  nop
    /* 18384 80027B84 2A805400 */  slt        $s0, $v0, $s4
  .L80027B88:
    /* 18388 80027B88 09000012 */  beqz       $s0, .L80027BB0
    /* 1838C 80027B8C 00000000 */   nop
    /* 18390 80027B90 BB58000C */  jal        CheapestCarStockPrice__11tCarManager
    /* 18394 80027B94 21204002 */   addu      $a0, $s2, $zero
    /* 18398 80027B98 1180033C */  lui        $v1, %hi(tournamentManager)
    /* 1839C 80027B9C D84A6324 */  addiu      $v1, $v1, %lo(tournamentManager)
    /* 183A0 80027BA0 1400648C */  lw         $a0, 0x14($v1)
    /* 183A4 80027BA4 01004224 */  addiu      $v0, $v0, 0x1
    /* 183A8 80027BA8 21208200 */  addu       $a0, $a0, $v0
    /* 183AC 80027BAC 140064AC */  sw         $a0, 0x14($v1)
  .L80027BB0:
    /* 183B0 80027BB0 0D003412 */  beq        $s1, $s4, .L80027BE8
    /* 183B4 80027BB4 0200222A */   slti      $v0, $s1, 0x2
    /* 183B8 80027BB8 05004010 */  beqz       $v0, .L80027BD0
    /* 183BC 80027BBC 02000224 */   addiu     $v0, $zero, 0x2
    /* 183C0 80027BC0 07002012 */  beqz       $s1, .L80027BE0
    /* 183C4 80027BC4 00000000 */   nop
    /* 183C8 80027BC8 4A9F0008 */  j          .L80027D28
    /* 183CC 80027BCC 00000000 */   nop
  .L80027BD0:
    /* 183D0 80027BD0 12002212 */  beq        $s1, $v0, .L80027C1C
    /* 183D4 80027BD4 1480023C */   lui       $v0, %hi(gCalculateVictory)
    /* 183D8 80027BD8 4A9F0008 */  j          .L80027D28
    /* 183DC 80027BDC 00000000 */   nop
  .L80027BE0:
    /* 183E0 80027BE0 509E000C */  jal        LoadConfig__Fv
    /* 183E4 80027BE4 00000000 */   nop
  .L80027BE8:
    /* 183E8 80027BE8 1480023C */  lui        $v0, %hi(gUseFrontend)
    /* 183EC 80027BEC 74D2428C */  lw         $v0, %lo(gUseFrontend)($v0)
    /* 183F0 80027BF0 00000000 */  nop
    /* 183F4 80027BF4 4C004010 */  beqz       $v0, .L80027D28
    /* 183F8 80027BF8 00000000 */   nop
    /* 183FC 80027BFC 25B1000C */  jal        MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand
    /* 18400 80027C00 1000A427 */   addiu     $a0, $sp, 0x10
    /* 18404 80027C04 0580023C */  lui        $v0, %hi(FEApp)
    /* 18408 80027C08 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 1840C 80027C0C CE55000C */  jal        RunFrontEnd__14tFEApplication
    /* 18410 80027C10 00000000 */   nop
    /* 18414 80027C14 4A9F0008 */  j          .L80027D28
    /* 18418 80027C18 21984000 */   addu      $s3, $v0, $zero
  .L80027C1C:
    /* 1841C 80027C1C 0400A392 */  lbu        $v1, 0x4($s5)
    /* 18420 80027C20 00000000 */  nop
    /* 18424 80027C24 0E007114 */  bne        $v1, $s1, .L80027C60
    /* 18428 80027C28 8DD254A0 */   sb        $s4, %lo(gCalculateVictory)($v0)
    /* 1842C 80027C2C 1180023C */  lui        $v0, %hi(D_80113210)
    /* 18430 80027C30 1032428C */  lw         $v0, %lo(D_80113210)($v0)
    /* 18434 80027C34 00000000 */  nop
    /* 18438 80027C38 0A004014 */  bnez       $v0, .L80027C64
    /* 1843C 80027C3C 1180023C */   lui       $v0, %hi(frontEnd)
    /* 18440 80027C40 1180103C */  lui        $s0, %hi(tournamentManager)
    /* 18444 80027C44 D84A1026 */  addiu      $s0, $s0, %lo(tournamentManager)
    /* 18448 80027C48 12CC000C */  jal        AdvanceToNextTrack__18tTournamentManager
    /* 1844C 80027C4C 21200002 */   addu      $a0, $s0, $zero
    /* 18450 80027C50 45CE000C */  jal        UpdateAwardInformation__18tTournamentManager
    /* 18454 80027C54 21200002 */   addu      $a0, $s0, $zero
    /* 18458 80027C58 469F0008 */  j          .L80027D18
    /* 1845C 80027C5C 0580023C */   lui       $v0, %hi(FEApp)
  .L80027C60:
    /* 18460 80027C60 1180023C */  lui        $v0, %hi(frontEnd)
  .L80027C64:
    /* 18464 80027C64 00464424 */  addiu      $a0, $v0, %lo(frontEnd)
    /* 18468 80027C68 04008390 */  lbu        $v1, 0x4($a0)
    /* 1846C 80027C6C 06000224 */  addiu      $v0, $zero, 0x6
    /* 18470 80027C70 29006214 */  bne        $v1, $v0, .L80027D18
    /* 18474 80027C74 0580023C */   lui       $v0, %hi(FEApp)
    /* 18478 80027C78 1180023C */  lui        $v0, %hi(D_80113210)
    /* 1847C 80027C7C 1032428C */  lw         $v0, %lo(D_80113210)($v0)
    /* 18480 80027C80 00000000 */  nop
    /* 18484 80027C84 24004014 */  bnez       $v0, .L80027D18
    /* 18488 80027C88 0580023C */   lui       $v0, %hi(FEApp)
    /* 1848C 80027C8C 1180023C */  lui        $v0, %hi(D_8010FBC8)
    /* 18490 80027C90 C8FB428C */  lw         $v0, %lo(D_8010FBC8)($v0)
    /* 18494 80027C94 00000000 */  nop
    /* 18498 80027C98 02004228 */  slti       $v0, $v0, 0x2
    /* 1849C 80027C9C 05004010 */  beqz       $v0, .L80027CB4
    /* 184A0 80027CA0 00000000 */   nop
    /* 184A4 80027CA4 5A008284 */  lh         $v0, 0x5A($a0)
    /* 184A8 80027CA8 00000000 */  nop
    /* 184AC 80027CAC 05004014 */  bnez       $v0, .L80027CC4
    /* 184B0 80027CB0 1180023C */   lui       $v0, %hi(frontEnd)
  .L80027CB4:
    /* 184B4 80027CB4 5A008284 */  lh         $v0, 0x5A($a0)
    /* 184B8 80027CB8 01000324 */  addiu      $v1, $zero, 0x1
    /* 184BC 80027CBC 0C004314 */  bne        $v0, $v1, .L80027CF0
    /* 184C0 80027CC0 1180023C */   lui       $v0, %hi(frontEnd)
  .L80027CC4:
    /* 184C4 80027CC4 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 184C8 80027CC8 46004390 */  lbu        $v1, 0x46($v0)
    /* 184CC 80027CCC 00000000 */  nop
    /* 184D0 80027CD0 40180300 */  sll        $v1, $v1, 1
    /* 184D4 80027CD4 21186200 */  addu       $v1, $v1, $v0
    /* 184D8 80027CD8 0C0060A4 */  sh         $zero, 0xC($v1)
    /* 184DC 80027CDC 48004390 */  lbu        $v1, 0x48($v0)
    /* 184E0 80027CE0 00000000 */  nop
    /* 184E4 80027CE4 01006324 */  addiu      $v1, $v1, 0x1
    /* 184E8 80027CE8 459F0008 */  j          .L80027D14
    /* 184EC 80027CEC 480043A0 */   sb        $v1, 0x48($v0)
  .L80027CF0:
    /* 184F0 80027CF0 46008290 */  lbu        $v0, 0x46($a0)
    /* 184F4 80027CF4 00000000 */  nop
    /* 184F8 80027CF8 40100200 */  sll        $v0, $v0, 1
    /* 184FC 80027CFC 21104400 */  addu       $v0, $v0, $a0
    /* 18500 80027D00 0C0043A4 */  sh         $v1, 0xC($v0)
    /* 18504 80027D04 49008290 */  lbu        $v0, 0x49($a0)
    /* 18508 80027D08 00000000 */  nop
    /* 1850C 80027D0C 01004224 */  addiu      $v0, $v0, 0x1
    /* 18510 80027D10 490082A0 */  sb         $v0, 0x49($a0)
  .L80027D14:
    /* 18514 80027D14 0580023C */  lui        $v0, %hi(FEApp)
  .L80027D18:
    /* 18518 80027D18 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 1851C 80027D1C 0C55000C */  jal        RunPostGame__14tFEApplication
    /* 18520 80027D20 00000000 */   nop
    /* 18524 80027D24 21984000 */  addu       $s3, $v0, $zero
  .L80027D28:
    /* 18528 80027D28 FA9B000C */  jal        Front_DeleteAll__Fv
    /* 1852C 80027D2C 1480103C */   lui       $s0, %hi(gFEBigHandle)
    /* 18530 80027D30 5E58000C */  jal        FeAudio_DeInitCommentary__Fv
    /* 18534 80027D34 1180113C */   lui       $s1, %hi(frontEnd)
    /* 18538 80027D38 47EF020C */  jal        Audio_FECleanUp__Fv
    /* 1853C 80027D3C 00463126 */   addiu     $s1, $s1, %lo(frontEnd)
    /* 18540 80027D40 B4E4020C */  jal        TextSys_UnloadWords__Fv
    /* 18544 80027D44 00000000 */   nop
    /* 18548 80027D48 249B000C */  jal        FeTools_deinit__Fv
    /* 1854C 80027D4C 00000000 */   nop
    /* 18550 80027D50 1C37010C */  jal        PSXExitFrontend__Fv
    /* 18554 80027D54 00000000 */   nop
    /* 18558 80027D58 80D2048E */  lw         $a0, %lo(gFEBigHandle)($s0)
    /* 1855C 80027D5C 9CAA030C */  jal        FILE_delbigsync
    /* 18560 80027D60 64000524 */   addiu     $a1, $zero, 0x64
    /* 18564 80027D64 23002492 */  lbu        $a0, 0x23($s1)
    /* 18568 80027D68 982B010C */  jal        Stattool_ReturnRecordLapTime__Fs
    /* 1856C 80027D6C 80D200AE */   sw        $zero, %lo(gFEBigHandle)($s0)
    /* 18570 80027D70 A194030C */  jal        largestunused
    /* 18574 80027D74 280022AE */   sw        $v0, 0x28($s1)
    /* 18578 80027D78 0580033C */  lui        $v1, %hi(gLargestUnused)
    /* 1857C 80027D7C B81462AC */  sw         $v0, %lo(gLargestUnused)($v1)
    /* 18580 80027D80 21106002 */  addu       $v0, $s3, $zero
    /* 18584 80027D84 3000BF8F */  lw         $ra, 0x30($sp)
    /* 18588 80027D88 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 1858C 80027D8C 2800B48F */  lw         $s4, 0x28($sp)
    /* 18590 80027D90 2400B38F */  lw         $s3, 0x24($sp)
    /* 18594 80027D94 2000B28F */  lw         $s2, 0x20($sp)
    /* 18598 80027D98 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 1859C 80027D9C 1800B08F */  lw         $s0, 0x18($sp)
    /* 185A0 80027DA0 0800E003 */  jr         $ra
    /* 185A4 80027DA4 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Front_Menu__F21tFront_ProcessingType
