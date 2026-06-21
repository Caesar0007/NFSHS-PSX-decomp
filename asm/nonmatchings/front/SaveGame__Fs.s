.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SaveGame__Fs, 0x490

glabel SaveGame__Fs
    /* 25188 80034988 08E9BD27 */  addiu      $sp, $sp, -0x16F8
    /* 2518C 8003498C E416B5AF */  sw         $s5, 0x16E4($sp)
    /* 25190 80034990 21A88000 */  addu       $s5, $a0, $zero
    /* 25194 80034994 21300000 */  addu       $a2, $zero, $zero
    /* 25198 80034998 01000924 */  addiu      $t1, $zero, 0x1
    /* 2519C 8003499C 1480023C */  lui        $v0, %hi(gPadinfo)
    /* 251A0 800349A0 9CE84824 */  addiu      $t0, $v0, %lo(gPadinfo)
    /* 251A4 800349A4 73000724 */  addiu      $a3, $zero, 0x73
    /* 251A8 800349A8 1180023C */  lui        $v0, %hi(frontEnd)
    /* 251AC 800349AC 00464524 */  addiu      $a1, $v0, %lo(frontEnd)
    /* 251B0 800349B0 0580023C */  lui        $v0, %hi(CURRENTPLAYER)
    /* 251B4 800349B4 00240400 */  sll        $a0, $a0, 16
    /* 251B8 800349B8 03240400 */  sra        $a0, $a0, 16
    /* 251BC 800349BC 0580033C */  lui        $v1, %hi(CURRENTLYUSINGMEMCARD)
    /* 251C0 800349C0 681A44AC */  sw         $a0, %lo(CURRENTPLAYER)($v0)
    /* 251C4 800349C4 21102001 */  addu       $v0, $t1, $zero
    /* 251C8 800349C8 F416BFAF */  sw         $ra, 0x16F4($sp)
    /* 251CC 800349CC F016BEAF */  sw         $fp, 0x16F0($sp)
    /* 251D0 800349D0 EC16B7AF */  sw         $s7, 0x16EC($sp)
    /* 251D4 800349D4 E816B6AF */  sw         $s6, 0x16E8($sp)
    /* 251D8 800349D8 E016B4AF */  sw         $s4, 0x16E0($sp)
    /* 251DC 800349DC DC16B3AF */  sw         $s3, 0x16DC($sp)
    /* 251E0 800349E0 D816B2AF */  sw         $s2, 0x16D8($sp)
    /* 251E4 800349E4 D416B1AF */  sw         $s1, 0x16D4($sp)
    /* 251E8 800349E8 D016B0AF */  sw         $s0, 0x16D0($sp)
    /* 251EC 800349EC 7C1A62AC */  sw         $v0, %lo(CURRENTLYUSINGMEMCARD)($v1)
  .L800349F0:
    /* 251F0 800349F0 2B100600 */  sltu       $v0, $zero, $a2
    /* 251F4 800349F4 40110200 */  sll        $v0, $v0, 5
    /* 251F8 800349F8 21104800 */  addu       $v0, $v0, $t0
    /* 251FC 800349FC 4804A9AC */  sw         $t1, 0x448($a1)
    /* 25200 80034A00 05004290 */  lbu        $v0, 0x5($v0)
    /* 25204 80034A04 00000000 */  nop
    /* 25208 80034A08 02004710 */  beq        $v0, $a3, .L80034A14
    /* 2520C 80034A0C 00000000 */   nop
    /* 25210 80034A10 4804A0AC */  sw         $zero, 0x448($a1)
  .L80034A14:
    /* 25214 80034A14 0100C624 */  addiu      $a2, $a2, 0x1
    /* 25218 80034A18 0200C228 */  slti       $v0, $a2, 0x2
    /* 2521C 80034A1C F4FF4014 */  bnez       $v0, .L800349F0
    /* 25220 80034A20 0400A524 */   addiu     $a1, $a1, 0x4
    /* 25224 80034A24 C015B027 */  addiu      $s0, $sp, 0x15C0
    /* 25228 80034A28 0898000C */  jal        __7tScreen
    /* 2522C 80034A2C 21200002 */   addu      $a0, $s0, $zero
    /* 25230 80034A30 00241500 */  sll        $a0, $s5, 16
    /* 25234 80034A34 03240400 */  sra        $a0, $a0, 16
    /* 25238 80034A38 76028424 */  addiu      $a0, $a0, 0x276
    /* 2523C 80034A3C 0180023C */  lui        $v0, %hi(_vt_11tDialogBase)
    /* 25240 80034A40 B0054224 */  addiu      $v0, $v0, %lo(_vt_11tDialogBase)
    /* 25244 80034A44 2016A2AF */  sw         $v0, 0x1620($sp)
    /* 25248 80034A48 20010224 */  addiu      $v0, $zero, 0x120
    /* 2524C 80034A4C 3016A0AF */  sw         $zero, 0x1630($sp)
    /* 25250 80034A50 2E16A0A7 */  sh         $zero, 0x162E($sp)
    /* 25254 80034A54 4216A0A7 */  sh         $zero, 0x1642($sp)
    /* 25258 80034A58 3E16A0A7 */  sh         $zero, 0x163E($sp)
    /* 2525C 80034A5C 3C16A0A7 */  sh         $zero, 0x163C($sp)
    /* 25260 80034A60 2C16A0A7 */  sh         $zero, 0x162C($sp)
    /* 25264 80034A64 2A16A0A7 */  sh         $zero, 0x162A($sp)
    /* 25268 80034A68 2816A0A7 */  sh         $zero, 0x1628($sp)
    /* 2526C 80034A6C 2616A0A7 */  sh         $zero, 0x1626($sp)
    /* 25270 80034A70 800002A6 */  sh         $v0, 0x80($s0)
    /* 25274 80034A74 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 25278 80034A78 640002A6 */  sh         $v0, 0x64($s0)
    /* 2527C 80034A7C 0180023C */  lui        $v0, %hi(_vt_20tDialogMessageString)
    /* 25280 80034A80 F0044224 */  addiu      $v0, $v0, %lo(_vt_20tDialogMessageString)
    /* 25284 80034A84 2016A2AF */  sw         $v0, 0x1620($sp)
    /* 25288 80034A88 80000224 */  addiu      $v0, $zero, 0x80
    /* 2528C 80034A8C 4816A0A7 */  sh         $zero, 0x1648($sp)
    /* 25290 80034A90 3816A0AF */  sw         $zero, 0x1638($sp)
    /* 25294 80034A94 5416A0AF */  sw         $zero, 0x1654($sp)
    /* 25298 80034A98 4416A0AF */  sw         $zero, 0x1644($sp)
    /* 2529C 80034A9C 3816A0AF */  sw         $zero, 0x1638($sp)
    /* 252A0 80034AA0 8C0002AE */  sw         $v0, 0x8C($s0)
    /* 252A4 80034AA4 0180023C */  lui        $v0, %hi(_vt_21tDialogNoInputMessage)
    /* 252A8 80034AA8 30044224 */  addiu      $v0, $v0, %lo(_vt_21tDialogNoInputMessage)
    /* 252AC 80034AAC 94E4020C */  jal        TextSys_Word__Fi
    /* 252B0 80034AB0 2016A2AF */   sw        $v0, 0x1620($sp)
    /* 252B4 80034AB4 21200002 */  addu       $a0, $s0, $zero
    /* 252B8 80034AB8 5016A2AF */  sw         $v0, 0x1650($sp)
    /* 252BC 80034ABC 32000224 */  addiu      $v0, $zero, 0x32
    /* 252C0 80034AC0 3C16A0A7 */  sh         $zero, 0x163C($sp)
    /* 252C4 80034AC4 1062000C */  jal        Display__11tDialogBase
    /* 252C8 80034AC8 3E16A2A7 */   sh        $v0, 0x163E($sp)
    /* 252CC 80034ACC 0580103C */  lui        $s0, %hi(FEApp)
  .L80034AD0:
    /* 252D0 80034AD0 4416A28F */  lw         $v0, 0x1644($sp)
    /* 252D4 80034AD4 00000000 */  nop
    /* 252D8 80034AD8 01004238 */  xori       $v0, $v0, 0x1
    /* 252DC 80034ADC 06004010 */  beqz       $v0, .L80034AF8
    /* 252E0 80034AE0 21980000 */   addu      $s3, $zero, $zero
    /* 252E4 80034AE4 C014048E */  lw         $a0, %lo(FEApp)($s0)
    /* 252E8 80034AE8 CF4D000C */  jal        Redraw__14tFEApplication
    /* 252EC 80034AEC 00000000 */   nop
    /* 252F0 80034AF0 B4D20008 */  j          .L80034AD0
    /* 252F4 80034AF4 00000000 */   nop
  .L80034AF8:
    /* 252F8 80034AF8 21B06002 */  addu       $s6, $s3, $zero
    /* 252FC 80034AFC 8B021224 */  addiu      $s2, $zero, 0x28B
    /* 25300 80034B00 0580023C */  lui        $v0, %hi(FEApp)
    /* 25304 80034B04 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 25308 80034B08 CF4D000C */  jal        Redraw__14tFEApplication
    /* 2530C 80034B0C 15001124 */   addiu     $s1, $zero, 0x15
    /* 25310 80034B10 00841500 */  sll        $s0, $s5, 16
    /* 25314 80034B14 83831000 */  sra        $s0, $s0, 14
    /* 25318 80034B18 01001026 */  addiu      $s0, $s0, 0x1
    /* 2531C 80034B1C 0580023C */  lui        $v0, %hi(nomessage)
    /* 25320 80034B20 C816B0A7 */  sh         $s0, 0x16C8($sp)
    /* 25324 80034B24 FCD0000C */  jal        MakeWayForMemoryCard__Fv
    /* 25328 80034B28 781A40AC */   sw        $zero, %lo(nomessage)($v0)
    /* 2532C 80034B2C 5816A427 */  addiu      $a0, $sp, 0x1658
    /* 25330 80034B30 00841000 */  sll        $s0, $s0, 16
    /* 25334 80034B34 032C1000 */  sra        $a1, $s0, 16
    /* 25338 80034B38 28D2000C */  jal        Init_MemcardFile__FR12MCRDFILE_defsb
    /* 2533C 80034B3C 21306002 */   addu      $a2, $s3, $zero
    /* 25340 80034B40 1000A227 */  addiu      $v0, $sp, 0x10
    /* 25344 80034B44 6C16A2AF */  sw         $v0, 0x166C($sp)
  .L80034B48:
    /* 25348 80034B48 A03F010C */  jal        MCRD_handlecardevents
    /* 2534C 80034B4C 03241000 */   sra       $a0, $s0, 16
    /* 25350 80034B50 05005114 */  bne        $v0, $s1, .L80034B68
    /* 25354 80034B54 1180043C */   lui       $a0, %hi(frontEnd)
    /* 25358 80034B58 C7C8030C */  jal        VSync
    /* 2535C 80034B5C 21200000 */   addu      $a0, $zero, $zero
    /* 25360 80034B60 D2D20008 */  j          .L80034B48
    /* 25364 80034B64 00000000 */   nop
  .L80034B68:
    /* 25368 80034B68 00468424 */  addiu      $a0, $a0, %lo(frontEnd)
    /* 2536C 80034B6C 1800A527 */  addiu      $a1, $sp, 0x18
    /* 25370 80034B70 B798030C */  jal        blockmove
    /* 25374 80034B74 50040624 */   addiu     $a2, $zero, 0x450
    /* 25378 80034B78 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 2537C 80034B7C D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 25380 80034B80 3FCD000C */  jal        SaveTournament__18tTournamentManagerR15tSaveTournament
    /* 25384 80034B84 5805A527 */   addiu     $a1, $sp, 0x558
    /* 25388 80034B88 1180043C */  lui        $a0, %hi(trackManager)
    /* 2538C 80034B8C 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 25390 80034B90 9F86000C */  jal        SaveTracks__13tTrackManagerR14tSaveTrackInfo
    /* 25394 80034B94 4805A527 */   addiu     $a1, $sp, 0x548
    /* 25398 80034B98 1180043C */  lui        $a0, %hi(carManager)
    /* 2539C 80034B9C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 253A0 80034BA0 BC5A000C */  jal        SaveCars__11tCarManagerR12tSaveCarInfo
    /* 253A4 80034BA4 6804A527 */   addiu     $a1, $sp, 0x468
    /* 253A8 80034BA8 1180043C */  lui        $a0, %hi(Stats_gTrackRecords)
    /* 253AC 80034BAC 944D8424 */  addiu      $a0, $a0, %lo(Stats_gTrackRecords)
    /* 253B0 80034BB0 0806A527 */  addiu      $a1, $sp, 0x608
    /* 253B4 80034BB4 B798030C */  jal        blockmove
    /* 253B8 80034BB8 9C0E0624 */   addiu     $a2, $zero, 0xE9C
    /* 253BC 80034BBC B5AA030C */  jal        rand
    /* 253C0 80034BC0 00000000 */   nop
    /* 253C4 80034BC4 1400A427 */  addiu      $a0, $sp, 0x14
    /* 253C8 80034BC8 D28D000C */  jal        FECheat_SaveBonus__FRUl
    /* 253CC 80034BCC A414A2AF */   sw        $v0, 0x14A4($sp)
    /* 253D0 80034BD0 8816B027 */  addiu      $s0, $sp, 0x1688
    /* 253D4 80034BD4 21200002 */  addu       $a0, $s0, $zero
    /* 253D8 80034BD8 0180053C */  lui        $a1, %hi(D_800116EC)
    /* 253DC 80034BDC EC16A524 */  addiu      $a1, $a1, %lo(D_800116EC)
    /* 253E0 80034BE0 1180023C */  lui        $v0, %hi(D_801164E8)
    /* 253E4 80034BE4 C816AA97 */  lhu        $t2, 0x16C8($sp)
    /* 253E8 80034BE8 E864468C */  lw         $a2, %lo(D_801164E8)($v0)
    /* 253EC 80034BEC 2F91030C */  jal        sprintf
    /* 253F0 80034BF0 008C0A00 */   sll       $s1, $t2, 16
    /* 253F4 80034BF4 21200002 */  addu       $a0, $s0, $zero
    /* 253F8 80034BF8 0FC7030C */  jal        loadshapeadr
    /* 253FC 80034BFC 21280000 */   addu      $a1, $zero, $zero
    /* 25400 80034C00 21B84000 */  addu       $s7, $v0, $zero
    /* 25404 80034C04 2120E002 */  addu       $a0, $s7, $zero
    /* 25408 80034C08 21280000 */  addu       $a1, $zero, $zero
    /* 2540C 80034C0C 00020224 */  addiu      $v0, $zero, 0x200
    /* 25410 80034C10 AEC2030C */  jal        shapepointer
    /* 25414 80034C14 6816A2AF */   sw        $v0, 0x1668($sp)
    /* 25418 80034C18 1000A427 */  addiu      $a0, $sp, 0x10
    /* 2541C 80034C1C 7016A2AF */  sw         $v0, 0x1670($sp)
    /* 25420 80034C20 7416A0AF */  sw         $zero, 0x1674($sp)
    /* 25424 80034C24 A8D0000C */  jal        func_800342A0
    /* 25428 80034C28 7816A0AF */   sw        $zero, 0x1678($sp)
    /* 2542C 80034C2C 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 25430 80034C30 682D5E24 */  addiu      $fp, $v0, %lo(gMemCardInfo)
    /* 25434 80034C34 00141500 */  sll        $v0, $s5, 16
    /* 25438 80034C38 83A30200 */  sra        $s4, $v0, 14
  jlabel .L80034C3C
    /* 2543C 80034C3C 2B006016 */  bnez       $s3, .L80034CEC
    /* 25440 80034C40 00000000 */   nop
    /* 25444 80034C44 A03F010C */  jal        MCRD_handlecardevents
    /* 25448 80034C48 03241100 */   sra       $a0, $s1, 16
    /* 2544C 80034C4C 21200000 */  addu       $a0, $zero, $zero
    /* 25450 80034C50 019B030C */  jal        systemtask
    /* 25454 80034C54 21804000 */   addu      $s0, $v0, $zero
    /* 25458 80034C58 C7C8030C */  jal        VSync
    /* 2545C 80034C5C 21200000 */   addu      $a0, $zero, $zero
    /* 25460 80034C60 FEFF1026 */  addiu      $s0, $s0, -0x2
    /* 25464 80034C64 1600022E */  sltiu      $v0, $s0, 0x16
    /* 25468 80034C68 F4FF4010 */  beqz       $v0, .L80034C3C
    /* 2546C 80034C6C 80101000 */   sll       $v0, $s0, 2
    /* 25470 80034C70 01800A3C */  lui        $t2, %hi(jtbl_800116F8)
    /* 25474 80034C74 F8164A25 */  addiu      $t2, $t2, %lo(jtbl_800116F8)
    /* 25478 80034C78 21104A00 */  addu       $v0, $v0, $t2
    /* 2547C 80034C7C 0000428C */  lw         $v0, 0x0($v0)
    /* 25480 80034C80 00000000 */  nop
    /* 25484 80034C84 08004000 */  jr         $v0
    /* 25488 80034C88 00000000 */   nop
  jlabel .L80034C8C
    /* 2548C 80034C8C 3400C28F */  lw         $v0, 0x34($fp)
    /* 25490 80034C90 00000000 */  nop
    /* 25494 80034C94 E9FF4010 */  beqz       $v0, .L80034C3C
    /* 25498 80034C98 03241100 */   sra       $a0, $s1, 16
    /* 2549C 80034C9C 933E010C */  jal        MCRD_savefile
    /* 254A0 80034CA0 5816A527 */   addiu     $a1, $sp, 0x1658
    /* 254A4 80034CA4 0FD30008 */  j          .L80034C3C
    /* 254A8 80034CA8 00000000 */   nop
  jlabel .L80034CAC
    /* 254AC 80034CAC 8B021224 */  addiu      $s2, $zero, 0x28B
    /* 254B0 80034CB0 01001324 */  addiu      $s3, $zero, 0x1
    /* 254B4 80034CB4 0FD30008 */  j          .L80034C3C
    /* 254B8 80034CB8 21B06002 */   addu      $s6, $s3, $zero
  jlabel .L80034CBC
    /* 254BC 80034CBC 9140010C */  jal        MCRD_getcard
    /* 254C0 80034CC0 01008426 */   addiu     $a0, $s4, 0x1
    /* 254C4 80034CC4 0000438C */  lw         $v1, 0x0($v0)
    /* 254C8 80034CC8 FDFF0224 */  addiu      $v0, $zero, -0x3
    /* 254CC 80034CCC 05006210 */  beq        $v1, $v0, .L80034CE4
    /* 254D0 80034CD0 9D021224 */   addiu     $s2, $zero, 0x29D
    /* 254D4 80034CD4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 254D8 80034CD8 02006214 */  bne        $v1, $v0, .L80034CE4
    /* 254DC 80034CDC 25031224 */   addiu     $s2, $zero, 0x325
    /* 254E0 80034CE0 2B031224 */  addiu      $s2, $zero, 0x32B
  .L80034CE4:
    /* 254E4 80034CE4 0FD30008 */  j          .L80034C3C
    /* 254E8 80034CE8 01001324 */   addiu     $s3, $zero, 0x1
  .L80034CEC:
    /* 254EC 80034CEC C816AA97 */  lhu        $t2, 0x16C8($sp)
    /* 254F0 80034CF0 16001124 */  addiu      $s1, $zero, 0x16
    /* 254F4 80034CF4 00840A00 */  sll        $s0, $t2, 16
  .L80034CF8:
    /* 254F8 80034CF8 A03F010C */  jal        MCRD_handlecardevents
    /* 254FC 80034CFC 03241000 */   sra       $a0, $s0, 16
    /* 25500 80034D00 05005110 */  beq        $v0, $s1, .L80034D18
    /* 25504 80034D04 00000000 */   nop
    /* 25508 80034D08 C7C8030C */  jal        VSync
    /* 2550C 80034D0C 21200000 */   addu      $a0, $zero, $zero
    /* 25510 80034D10 3ED30008 */  j          .L80034CF8
    /* 25514 80034D14 00000000 */   nop
  .L80034D18:
    /* 25518 80034D18 5095030C */  jal        purgememadr
    /* 2551C 80034D1C 2120E002 */   addu      $a0, $s7, $zero
    /* 25520 80034D20 05D1000C */  jal        BringThatBeatBack__Fv
    /* 25524 80034D24 00000000 */   nop
    /* 25528 80034D28 0580023C */  lui        $v0, %hi(nomessage)
    /* 2552C 80034D2C 781A428C */  lw         $v0, %lo(nomessage)($v0)
    /* 25530 80034D30 00000000 */  nop
    /* 25534 80034D34 1B004014 */  bnez       $v0, .L80034DA4
    /* 25538 80034D38 0580113C */   lui       $s1, %hi(FEApp)
    /* 2553C 80034D3C C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 25540 80034D40 4162000C */  jal        Hide__11tDialogBase
    /* 25544 80034D44 D0028424 */   addiu     $a0, $a0, 0x2D0
    /* 25548 80034D48 00241500 */  sll        $a0, $s5, 16
    /* 2554C 80034D4C 03240400 */  sra        $a0, $a0, 16
    /* 25550 80034D50 C014308E */  lw         $s0, %lo(FEApp)($s1)
    /* 25554 80034D54 21204402 */  addu       $a0, $s2, $a0
    /* 25558 80034D58 94E4020C */  jal        TextSys_Word__Fi
    /* 2555C 80034D5C 38021026 */   addiu     $s0, $s0, 0x238
    /* 25560 80034D60 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 25564 80034D64 900002AE */  sw         $v0, 0x90($s0)
    /* 25568 80034D68 1062000C */  jal        Display__11tDialogBase
    /* 2556C 80034D6C 38028424 */   addiu     $a0, $a0, 0x238
  .L80034D70:
    /* 25570 80034D70 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 25574 80034D74 00000000 */  nop
    /* 25578 80034D78 BC02828C */  lw         $v0, 0x2BC($a0)
    /* 2557C 80034D7C 00000000 */  nop
    /* 25580 80034D80 01004238 */  xori       $v0, $v0, 0x1
    /* 25584 80034D84 05004010 */  beqz       $v0, .L80034D9C
    /* 25588 80034D88 00000000 */   nop
    /* 2558C 80034D8C CF4D000C */  jal        Redraw__14tFEApplication
    /* 25590 80034D90 00000000 */   nop
    /* 25594 80034D94 5CD30008 */  j          .L80034D70
    /* 25598 80034D98 00000000 */   nop
  .L80034D9C:
    /* 2559C 80034D9C CF4D000C */  jal        Redraw__14tFEApplication
    /* 255A0 80034DA0 00000000 */   nop
  .L80034DA4:
    /* 255A4 80034DA4 C015B027 */  addiu      $s0, $sp, 0x15C0
    /* 255A8 80034DA8 21200002 */  addu       $a0, $s0, $zero
    /* 255AC 80034DAC 0580023C */  lui        $v0, %hi(screenMemcard)
    /* 255B0 80034DB0 F028438C */  lw         $v1, %lo(screenMemcard)($v0)
    /* 255B4 80034DB4 01000224 */  addiu      $v0, $zero, 0x1
    /* 255B8 80034DB8 4162000C */  jal        Hide__11tDialogBase
    /* 255BC 80034DBC A00562AC */   sw        $v0, 0x5A0($v1)
    /* 255C0 80034DC0 0580023C */  lui        $v0, %hi(FEApp)
    /* 255C4 80034DC4 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 255C8 80034DC8 CF4D000C */  jal        Redraw__14tFEApplication
    /* 255CC 80034DCC 00000000 */   nop
    /* 255D0 80034DD0 21200002 */  addu       $a0, $s0, $zero
    /* 255D4 80034DD4 02000524 */  addiu      $a1, $zero, 0x2
    /* 255D8 80034DD8 0580023C */  lui        $v0, %hi(CURRENTLYUSINGMEMCARD)
    /* 255DC 80034DDC 1E98000C */  jal        ___7tScreen
    /* 255E0 80034DE0 7C1A40AC */   sw        $zero, %lo(CURRENTLYUSINGMEMCARD)($v0)
    /* 255E4 80034DE4 2110C002 */  addu       $v0, $s6, $zero
    /* 255E8 80034DE8 F416BF8F */  lw         $ra, 0x16F4($sp)
    /* 255EC 80034DEC F016BE8F */  lw         $fp, 0x16F0($sp)
    /* 255F0 80034DF0 EC16B78F */  lw         $s7, 0x16EC($sp)
    /* 255F4 80034DF4 E816B68F */  lw         $s6, 0x16E8($sp)
    /* 255F8 80034DF8 E416B58F */  lw         $s5, 0x16E4($sp)
    /* 255FC 80034DFC E016B48F */  lw         $s4, 0x16E0($sp)
    /* 25600 80034E00 DC16B38F */  lw         $s3, 0x16DC($sp)
    /* 25604 80034E04 D816B28F */  lw         $s2, 0x16D8($sp)
    /* 25608 80034E08 D416B18F */  lw         $s1, 0x16D4($sp)
    /* 2560C 80034E0C D016B08F */  lw         $s0, 0x16D0($sp)
    /* 25610 80034E10 0800E003 */  jr         $ra
    /* 25614 80034E14 F816BD27 */   addiu     $sp, $sp, 0x16F8
endlabel SaveGame__Fs
