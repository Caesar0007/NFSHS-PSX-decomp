.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8002BAF4, 0x418

glabel func_8002BAF4
    /* 1C2F4 8002BAF4 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 1C2F8 8002BAF8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1C2FC 8002BAFC 21888000 */  addu       $s1, $a0, $zero
    /* 1C300 8002BB00 3400BFAF */  sw         $ra, 0x34($sp)
    /* 1C304 8002BB04 3000BEAF */  sw         $fp, 0x30($sp)
    /* 1C308 8002BB08 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 1C30C 8002BB0C 2800B6AF */  sw         $s6, 0x28($sp)
    /* 1C310 8002BB10 2400B5AF */  sw         $s5, 0x24($sp)
    /* 1C314 8002BB14 2000B4AF */  sw         $s4, 0x20($sp)
    /* 1C318 8002BB18 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 1C31C 8002BB1C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 1C320 8002BB20 0898000C */  jal        __7tScreen
    /* 1C324 8002BB24 1000B0AF */   sw        $s0, 0x10($sp)
    /* 1C328 8002BB28 B8052426 */  addiu      $a0, $s1, 0x5B8
    /* 1C32C 8002BB2C 0180023C */  lui        $v0, %hi(_vt_11tScreenMain)
    /* 1C330 8002BB30 B0184224 */  addiu      $v0, $v0, %lo(_vt_11tScreenMain)
    /* 1C334 8002BB34 E0EA000C */  jal        __16tScreenCarSelect
    /* 1C338 8002BB38 600022AE */   sw        $v0, 0x60($s1)
    /* 1C33C 8002BB3C 58093026 */  addiu      $s0, $s1, 0x958
    /* 1C340 8002BB40 E0EA000C */  jal        __16tScreenCarSelect
    /* 1C344 8002BB44 21200002 */   addu      $a0, $s0, $zero
    /* 1C348 8002BB48 280D3226 */  addiu      $s2, $s1, 0xD28
    /* 1C34C 8002BB4C 21204002 */  addu       $a0, $s2, $zero
    /* 1C350 8002BB50 0180023C */  lui        $v0, %hi(_vt_20tScreenCarSelectDuel)
    /* 1C354 8002BB54 801C4224 */  addiu      $v0, $v0, %lo(_vt_20tScreenCarSelectDuel)
    /* 1C358 8002BB58 E0EA000C */  jal        __16tScreenCarSelect
    /* 1C35C 8002BB5C 600002AE */   sw        $v0, 0x60($s0)
    /* 1C360 8002BB60 C8103026 */  addiu      $s0, $s1, 0x10C8
    /* 1C364 8002BB64 21200002 */  addu       $a0, $s0, $zero
    /* 1C368 8002BB68 0180053C */  lui        $a1, %hi(_vt_25tScreenCarSelectTwoPlayer)
    /* 1C36C 8002BB6C F01BA524 */  addiu      $a1, $a1, %lo(_vt_25tScreenCarSelectTwoPlayer)
    /* 1C370 8002BB70 0898000C */  jal        __7tScreen
    /* 1C374 8002BB74 600045AE */   sw        $a1, 0x60($s2)
    /* 1C378 8002BB78 60113226 */  addiu      $s2, $s1, 0x1160
    /* 1C37C 8002BB7C 21204002 */  addu       $a0, $s2, $zero
    /* 1C380 8002BB80 0180173C */  lui        $s7, %hi(_vt_11tDialogBase)
    /* 1C384 8002BB84 B005F726 */  addiu      $s7, $s7, %lo(_vt_11tDialogBase)
    /* 1C388 8002BB88 20010524 */  addiu      $a1, $zero, 0x120
    /* 1C38C 8002BB8C 800005A6 */  sh         $a1, 0x80($s0)
    /* 1C390 8002BB90 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1C394 8002BB94 0180143C */  lui        $s4, %hi(_vt_20tDialogMessageString)
    /* 1C398 8002BB98 F0049426 */  addiu      $s4, $s4, %lo(_vt_20tDialogMessageString)
    /* 1C39C 8002BB9C 80001E24 */  addiu      $fp, $zero, 0x80
    /* 1C3A0 8002BBA0 0180133C */  lui        $s3, %hi(_vt_17tDialogBackUpOnly)
    /* 1C3A4 8002BBA4 90047326 */  addiu      $s3, $s3, %lo(_vt_17tDialogBackUpOnly)
    /* 1C3A8 8002BBA8 600017AE */  sw         $s7, 0x60($s0)
    /* 1C3AC 8002BBAC 700000AE */  sw         $zero, 0x70($s0)
    /* 1C3B0 8002BBB0 6E0000A6 */  sh         $zero, 0x6E($s0)
    /* 1C3B4 8002BBB4 820000A6 */  sh         $zero, 0x82($s0)
    /* 1C3B8 8002BBB8 7E0000A6 */  sh         $zero, 0x7E($s0)
    /* 1C3BC 8002BBBC 7C0000A6 */  sh         $zero, 0x7C($s0)
    /* 1C3C0 8002BBC0 6C0000A6 */  sh         $zero, 0x6C($s0)
    /* 1C3C4 8002BBC4 6A0000A6 */  sh         $zero, 0x6A($s0)
    /* 1C3C8 8002BBC8 680000A6 */  sh         $zero, 0x68($s0)
    /* 1C3CC 8002BBCC 660000A6 */  sh         $zero, 0x66($s0)
    /* 1C3D0 8002BBD0 640005A6 */  sh         $a1, 0x64($s0)
    /* 1C3D4 8002BBD4 880000A6 */  sh         $zero, 0x88($s0)
    /* 1C3D8 8002BBD8 780000AE */  sw         $zero, 0x78($s0)
    /* 1C3DC 8002BBDC 600014AE */  sw         $s4, 0x60($s0)
    /* 1C3E0 8002BBE0 940000AE */  sw         $zero, 0x94($s0)
    /* 1C3E4 8002BBE4 840000AE */  sw         $zero, 0x84($s0)
    /* 1C3E8 8002BBE8 780000AE */  sw         $zero, 0x78($s0)
    /* 1C3EC 8002BBEC 8C001EAE */  sw         $fp, 0x8C($s0)
    /* 1C3F0 8002BBF0 E0EA000C */  jal        __16tScreenCarSelect
    /* 1C3F4 8002BBF4 600013AE */   sw        $s3, 0x60($s0)
    /* 1C3F8 8002BBF8 00153026 */  addiu      $s0, $s1, 0x1500
    /* 1C3FC 8002BBFC 21200002 */  addu       $a0, $s0, $zero
    /* 1C400 8002BC00 0180053C */  lui        $a1, %hi(_vt_25tScreenCarSelectTwoPlayer)
    /* 1C404 8002BC04 F01BA524 */  addiu      $a1, $a1, %lo(_vt_25tScreenCarSelectTwoPlayer)
    /* 1C408 8002BC08 0898000C */  jal        __7tScreen
    /* 1C40C 8002BC0C 600045AE */   sw        $a1, 0x60($s2)
    /* 1C410 8002BC10 98153526 */  addiu      $s5, $s1, 0x1598
    /* 1C414 8002BC14 2120A002 */  addu       $a0, $s5, $zero
    /* 1C418 8002BC18 20010524 */  addiu      $a1, $zero, 0x120
    /* 1C41C 8002BC1C 800005A6 */  sh         $a1, 0x80($s0)
    /* 1C420 8002BC20 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1C424 8002BC24 600017AE */  sw         $s7, 0x60($s0)
    /* 1C428 8002BC28 700000AE */  sw         $zero, 0x70($s0)
    /* 1C42C 8002BC2C 6E0000A6 */  sh         $zero, 0x6E($s0)
    /* 1C430 8002BC30 820000A6 */  sh         $zero, 0x82($s0)
    /* 1C434 8002BC34 7E0000A6 */  sh         $zero, 0x7E($s0)
    /* 1C438 8002BC38 7C0000A6 */  sh         $zero, 0x7C($s0)
    /* 1C43C 8002BC3C 6C0000A6 */  sh         $zero, 0x6C($s0)
    /* 1C440 8002BC40 6A0000A6 */  sh         $zero, 0x6A($s0)
    /* 1C444 8002BC44 680000A6 */  sh         $zero, 0x68($s0)
    /* 1C448 8002BC48 660000A6 */  sh         $zero, 0x66($s0)
    /* 1C44C 8002BC4C 640005A6 */  sh         $a1, 0x64($s0)
    /* 1C450 8002BC50 880000A6 */  sh         $zero, 0x88($s0)
    /* 1C454 8002BC54 780000AE */  sw         $zero, 0x78($s0)
    /* 1C458 8002BC58 600014AE */  sw         $s4, 0x60($s0)
    /* 1C45C 8002BC5C 940000AE */  sw         $zero, 0x94($s0)
    /* 1C460 8002BC60 840000AE */  sw         $zero, 0x84($s0)
    /* 1C464 8002BC64 780000AE */  sw         $zero, 0x78($s0)
    /* 1C468 8002BC68 8C001EAE */  sw         $fp, 0x8C($s0)
    /* 1C46C 8002BC6C E0EA000C */  jal        __16tScreenCarSelect
    /* 1C470 8002BC70 600013AE */   sw        $s3, 0x60($s0)
    /* 1C474 8002BC74 38193026 */  addiu      $s0, $s1, 0x1938
    /* 1C478 8002BC78 21200002 */  addu       $a0, $s0, $zero
    /* 1C47C 8002BC7C 0180053C */  lui        $a1, %hi(_vt_25tScreenCarSelectTwoPlayer)
    /* 1C480 8002BC80 F01BA524 */  addiu      $a1, $a1, %lo(_vt_25tScreenCarSelectTwoPlayer)
    /* 1C484 8002BC84 0898000C */  jal        __7tScreen
    /* 1C488 8002BC88 6000A5AE */   sw        $a1, 0x60($s5)
    /* 1C48C 8002BC8C E4193626 */  addiu      $s6, $s1, 0x19E4
    /* 1C490 8002BC90 2120C002 */  addu       $a0, $s6, $zero
    /* 1C494 8002BC94 20010524 */  addiu      $a1, $zero, 0x120
    /* 1C498 8002BC98 800005A6 */  sh         $a1, 0x80($s0)
    /* 1C49C 8002BC9C FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1C4A0 8002BCA0 0180123C */  lui        $s2, %hi(_vt_25tScreenPinkSlipsCarSelect)
    /* 1C4A4 8002BCA4 601B5226 */  addiu      $s2, $s2, %lo(_vt_25tScreenPinkSlipsCarSelect)
    /* 1C4A8 8002BCA8 600017AE */  sw         $s7, 0x60($s0)
    /* 1C4AC 8002BCAC 700000AE */  sw         $zero, 0x70($s0)
    /* 1C4B0 8002BCB0 6E0000A6 */  sh         $zero, 0x6E($s0)
    /* 1C4B4 8002BCB4 820000A6 */  sh         $zero, 0x82($s0)
    /* 1C4B8 8002BCB8 7E0000A6 */  sh         $zero, 0x7E($s0)
    /* 1C4BC 8002BCBC 7C0000A6 */  sh         $zero, 0x7C($s0)
    /* 1C4C0 8002BCC0 6C0000A6 */  sh         $zero, 0x6C($s0)
    /* 1C4C4 8002BCC4 6A0000A6 */  sh         $zero, 0x6A($s0)
    /* 1C4C8 8002BCC8 680000A6 */  sh         $zero, 0x68($s0)
    /* 1C4CC 8002BCCC 660000A6 */  sh         $zero, 0x66($s0)
    /* 1C4D0 8002BCD0 640005A6 */  sh         $a1, 0x64($s0)
    /* 1C4D4 8002BCD4 880000A6 */  sh         $zero, 0x88($s0)
    /* 1C4D8 8002BCD8 780000AE */  sw         $zero, 0x78($s0)
    /* 1C4DC 8002BCDC 600014AE */  sw         $s4, 0x60($s0)
    /* 1C4E0 8002BCE0 940000AE */  sw         $zero, 0x94($s0)
    /* 1C4E4 8002BCE4 840000AE */  sw         $zero, 0x84($s0)
    /* 1C4E8 8002BCE8 780000AE */  sw         $zero, 0x78($s0)
    /* 1C4EC 8002BCEC 8C001EAE */  sw         $fp, 0x8C($s0)
    /* 1C4F0 8002BCF0 600013AE */  sw         $s3, 0x60($s0)
    /* 1C4F4 8002BCF4 E0EA000C */  jal        __16tScreenCarSelect
    /* 1C4F8 8002BCF8 6000B2AE */   sw        $s2, 0x60($s5)
    /* 1C4FC 8002BCFC 841D3026 */  addiu      $s0, $s1, 0x1D84
    /* 1C500 8002BD00 21200002 */  addu       $a0, $s0, $zero
    /* 1C504 8002BD04 0180053C */  lui        $a1, %hi(_vt_25tScreenCarSelectTwoPlayer)
    /* 1C508 8002BD08 F01BA524 */  addiu      $a1, $a1, %lo(_vt_25tScreenCarSelectTwoPlayer)
    /* 1C50C 8002BD0C 0898000C */  jal        __7tScreen
    /* 1C510 8002BD10 6000C5AE */   sw        $a1, 0x60($s6)
    /* 1C514 8002BD14 301E3526 */  addiu      $s5, $s1, 0x1E30
    /* 1C518 8002BD18 2120A002 */  addu       $a0, $s5, $zero
    /* 1C51C 8002BD1C 20010524 */  addiu      $a1, $zero, 0x120
    /* 1C520 8002BD20 800005A6 */  sh         $a1, 0x80($s0)
    /* 1C524 8002BD24 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1C528 8002BD28 600017AE */  sw         $s7, 0x60($s0)
    /* 1C52C 8002BD2C 700000AE */  sw         $zero, 0x70($s0)
    /* 1C530 8002BD30 6E0000A6 */  sh         $zero, 0x6E($s0)
    /* 1C534 8002BD34 820000A6 */  sh         $zero, 0x82($s0)
    /* 1C538 8002BD38 7E0000A6 */  sh         $zero, 0x7E($s0)
    /* 1C53C 8002BD3C 7C0000A6 */  sh         $zero, 0x7C($s0)
    /* 1C540 8002BD40 6C0000A6 */  sh         $zero, 0x6C($s0)
    /* 1C544 8002BD44 6A0000A6 */  sh         $zero, 0x6A($s0)
    /* 1C548 8002BD48 680000A6 */  sh         $zero, 0x68($s0)
    /* 1C54C 8002BD4C 660000A6 */  sh         $zero, 0x66($s0)
    /* 1C550 8002BD50 640005A6 */  sh         $a1, 0x64($s0)
    /* 1C554 8002BD54 880000A6 */  sh         $zero, 0x88($s0)
    /* 1C558 8002BD58 780000AE */  sw         $zero, 0x78($s0)
    /* 1C55C 8002BD5C 600014AE */  sw         $s4, 0x60($s0)
    /* 1C560 8002BD60 940000AE */  sw         $zero, 0x94($s0)
    /* 1C564 8002BD64 840000AE */  sw         $zero, 0x84($s0)
    /* 1C568 8002BD68 780000AE */  sw         $zero, 0x78($s0)
    /* 1C56C 8002BD6C 8C001EAE */  sw         $fp, 0x8C($s0)
    /* 1C570 8002BD70 600013AE */  sw         $s3, 0x60($s0)
    /* 1C574 8002BD74 0898000C */  jal        __7tScreen
    /* 1C578 8002BD78 6000D2AE */   sw        $s2, 0x60($s6)
    /* 1C57C 8002BD7C A41E3226 */  addiu      $s2, $s1, 0x1EA4
    /* 1C580 8002BD80 21204002 */  addu       $a0, $s2, $zero
    /* 1C584 8002BD84 0180023C */  lui        $v0, %hi(_vt_19tScreenTrackRecords)
    /* 1C588 8002BD88 F01F4224 */  addiu      $v0, $v0, %lo(_vt_19tScreenTrackRecords)
    /* 1C58C 8002BD8C 0898000C */  jal        __7tScreen
    /* 1C590 8002BD90 6000A2AE */   sw        $v0, 0x60($s5)
    /* 1C594 8002BD94 48213026 */  addiu      $s0, $s1, 0x2148
    /* 1C598 8002BD98 21200002 */  addu       $a0, $s0, $zero
    /* 1C59C 8002BD9C 0180023C */  lui        $v0, %hi(_vt_16tScreenTrackInfo)
    /* 1C5A0 8002BDA0 781F4224 */  addiu      $v0, $v0, %lo(_vt_16tScreenTrackInfo)
    /* 1C5A4 8002BDA4 0898000C */  jal        __7tScreen
    /* 1C5A8 8002BDA8 600042AE */   sw        $v0, 0x60($s2)
    /* 1C5AC 8002BDAC E8232426 */  addiu      $a0, $s1, 0x23E8
    /* 1C5B0 8002BDB0 0180023C */  lui        $v0, %hi(_vt_18tScreenTrackSelect)
    /* 1C5B4 8002BDB4 081F4224 */  addiu      $v0, $v0, %lo(_vt_18tScreenTrackSelect)
    /* 1C5B8 8002BDB8 DEFD000C */  jal        __18tScreenTournSelect
    /* 1C5BC 8002BDBC 600002AE */   sw        $v0, 0x60($s0)
    /* 1C5C0 8002BDC0 4AE6000C */  jal        __26tScreenTournamentStandings
    /* 1C5C4 8002BDC4 B0262426 */   addiu     $a0, $s1, 0x26B0
    /* 1C5C8 8002BDC8 44273026 */  addiu      $s0, $s1, 0x2744
    /* 1C5CC 8002BDCC 0898000C */  jal        __7tScreen
    /* 1C5D0 8002BDD0 21200002 */   addu      $a0, $s0, $zero
    /* 1C5D4 8002BDD4 CC282426 */  addiu      $a0, $s1, 0x28CC
    /* 1C5D8 8002BDD8 0180023C */  lui        $v0, %hi(_vt_23tScreenTournamentTrophy)
    /* 1C5DC 8002BDDC E0234224 */  addiu      $v0, $v0, %lo(_vt_23tScreenTournamentTrophy)
    /* 1C5E0 8002BDE0 5C01010C */  jal        __17tScreenTrophyRoom
    /* 1C5E4 8002BDE4 600002AE */   sw        $v0, 0x60($s0)
    /* 1C5E8 8002BDE8 242A3026 */  addiu      $s0, $s1, 0x2A24
    /* 1C5EC 8002BDEC 0898000C */  jal        __7tScreen
    /* 1C5F0 8002BDF0 21200002 */   addu      $a0, $s0, $zero
    /* 1C5F4 8002BDF4 8C2A2426 */  addiu      $a0, $s1, 0x2A8C
    /* 1C5F8 8002BDF8 0180023C */  lui        $v0, %hi(_vt_17tScreenTrophyInfo)
    /* 1C5FC 8002BDFC 901E4224 */  addiu      $v0, $v0, %lo(_vt_17tScreenTrophyInfo)
    /* 1C600 8002BE00 1716010C */  jal        __23tScreenControllerConfig
    /* 1C604 8002BE04 600002AE */   sw        $v0, 0x60($s0)
    /* 1C608 8002BE08 082C3026 */  addiu      $s0, $s1, 0x2C08
    /* 1C60C 8002BE0C 0898000C */  jal        __7tScreen
    /* 1C610 8002BE10 21200002 */   addu      $a0, $s0, $zero
    /* 1C614 8002BE14 6C2C2426 */  addiu      $a0, $s1, 0x2C6C
    /* 1C618 8002BE18 0180023C */  lui        $v0, %hi(_vt_14tScreenDisplay)
    /* 1C61C 8002BE1C D0204224 */  addiu      $v0, $v0, %lo(_vt_14tScreenDisplay)
    /* 1C620 8002BE20 5918010C */  jal        __12tScreenAudio
    /* 1C624 8002BE24 600002AE */   sw        $v0, 0x60($s0)
    /* 1C628 8002BE28 DD1E010C */  jal        __14tScreenMemcard
    /* 1C62C 8002BE2C E82C2426 */   addiu     $a0, $s1, 0x2CE8
    /* 1C630 8002BE30 8C323026 */  addiu      $s0, $s1, 0x328C
    /* 1C634 8002BE34 0898000C */  jal        __7tScreen
    /* 1C638 8002BE38 21200002 */   addu      $a0, $s0, $zero
    /* 1C63C 8002BE3C 58333226 */  addiu      $s2, $s1, 0x3358
    /* 1C640 8002BE40 21204002 */  addu       $a0, $s2, $zero
    /* 1C644 8002BE44 0180023C */  lui        $v0, %hi(_vt_15tScreenUserName)
    /* 1C648 8002BE48 E8264224 */  addiu      $v0, $v0, %lo(_vt_15tScreenUserName)
    /* 1C64C 8002BE4C 0898000C */  jal        __7tScreen
    /* 1C650 8002BE50 600002AE */   sw        $v0, 0x60($s0)
    /* 1C654 8002BE54 E0343026 */  addiu      $s0, $s1, 0x34E0
    /* 1C658 8002BE58 21200002 */  addu       $a0, $s0, $zero
    /* 1C65C 8002BE5C 0180023C */  lui        $v0, %hi(_vt_23tScreenPinkSlipCongrats)
    /* 1C660 8002BE60 78234224 */  addiu      $v0, $v0, %lo(_vt_23tScreenPinkSlipCongrats)
    /* 1C664 8002BE64 4AE6000C */  jal        __26tScreenTournamentStandings
    /* 1C668 8002BE68 600042AE */   sw        $v0, 0x60($s2)
    /* 1C66C 8002BE6C 74353326 */  addiu      $s3, $s1, 0x3574
    /* 1C670 8002BE70 21206002 */  addu       $a0, $s3, $zero
    /* 1C674 8002BE74 0180023C */  lui        $v0, %hi(_vt_24tScreenPinkSlipStandings)
    /* 1C678 8002BE78 A8194224 */  addiu      $v0, $v0, %lo(_vt_24tScreenPinkSlipStandings)
    /* 1C67C 8002BE7C 600002AE */  sw         $v0, 0x60($s0)
    /* 1C680 8002BE80 0180103C */  lui        $s0, %hi(_vt_31tScreenTournamentStandings3item)
    /* 1C684 8002BE84 4AE6000C */  jal        __26tScreenTournamentStandings
    /* 1C688 8002BE88 F8191026 */   addiu     $s0, $s0, %lo(_vt_31tScreenTournamentStandings3item)
    /* 1C68C 8002BE8C 08363226 */  addiu      $s2, $s1, 0x3608
    /* 1C690 8002BE90 21204002 */  addu       $a0, $s2, $zero
    /* 1C694 8002BE94 0898000C */  jal        __7tScreen
    /* 1C698 8002BE98 600070AE */   sw        $s0, 0x60($s3)
    /* 1C69C 8002BE9C D0383326 */  addiu      $s3, $s1, 0x38D0
    /* 1C6A0 8002BEA0 21206002 */  addu       $a0, $s3, $zero
    /* 1C6A4 8002BEA4 0180023C */  lui        $v0, %hi(_vt_16tScreenPinkSlips)
    /* 1C6A8 8002BEA8 30194224 */  addiu      $v0, $v0, %lo(_vt_16tScreenPinkSlips)
    /* 1C6AC 8002BEAC 0898000C */  jal        __7tScreen
    /* 1C6B0 8002BEB0 600042AE */   sw        $v0, 0x60($s2)
    /* 1C6B4 8002BEB4 543A3026 */  addiu      $s0, $s1, 0x3A54
    /* 1C6B8 8002BEB8 21200002 */  addu       $a0, $s0, $zero
    /* 1C6BC 8002BEBC 0180023C */  lui        $v0, %hi(_vt_23tScreenBeTheCopCongrats)
    /* 1C6C0 8002BEC0 10234224 */  addiu      $v0, $v0, %lo(_vt_23tScreenBeTheCopCongrats)
    /* 1C6C4 8002BEC4 0898000C */  jal        __7tScreen
    /* 1C6C8 8002BEC8 600062AE */   sw        $v0, 0x60($s3)
    /* 1C6CC 8002BECC 21102002 */  addu       $v0, $s1, $zero
    /* 1C6D0 8002BED0 0180033C */  lui        $v1, %hi(_vt_25tScreenTournamentCongrats)
    /* 1C6D4 8002BED4 A8226324 */  addiu      $v1, $v1, %lo(_vt_25tScreenTournamentCongrats)
    /* 1C6D8 8002BED8 600003AE */  sw         $v1, 0x60($s0)
    /* 1C6DC 8002BEDC 3400BF8F */  lw         $ra, 0x34($sp)
    /* 1C6E0 8002BEE0 3000BE8F */  lw         $fp, 0x30($sp)
    /* 1C6E4 8002BEE4 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 1C6E8 8002BEE8 2800B68F */  lw         $s6, 0x28($sp)
    /* 1C6EC 8002BEEC 2400B58F */  lw         $s5, 0x24($sp)
    /* 1C6F0 8002BEF0 2000B48F */  lw         $s4, 0x20($sp)
    /* 1C6F4 8002BEF4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 1C6F8 8002BEF8 1800B28F */  lw         $s2, 0x18($sp)
    /* 1C6FC 8002BEFC 1400B18F */  lw         $s1, 0x14($sp)
    /* 1C700 8002BF00 1000B08F */  lw         $s0, 0x10($sp)
    /* 1C704 8002BF04 0800E003 */  jr         $ra
    /* 1C708 8002BF08 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel func_8002BAF4
