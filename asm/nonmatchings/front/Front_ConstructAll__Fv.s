.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_ConstructAll__Fv, 0x190

glabel Front_ConstructAll__Fv
    /* 17658 80026E58 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1765C 80026E5C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 17660 80026E60 578F020C */  jal        __builtin_new
    /* 17664 80026E64 D83B0424 */   addiu     $a0, $zero, 0x3BD8
    /* 17668 80026E68 BDAE000C */  jal        func_8002BAF4
    /* 1766C 80026E6C 21204000 */   addu      $a0, $v0, $zero
    /* 17670 80026E70 80030424 */  addiu      $a0, $zero, 0x380
    /* 17674 80026E74 0580033C */  lui        $v1, %hi(gAllScreens)
    /* 17678 80026E78 341962AC */  sw         $v0, %lo(gAllScreens)($v1)
    /* 1767C 80026E7C 0580033C */  lui        $v1, %hi(screenMain)
    /* 17680 80026E80 0580053C */  lui        $a1, %hi(screenCarSelect)
    /* 17684 80026E84 581E62AC */  sw         $v0, %lo(screenMain)($v1)
    /* 17688 80026E88 B8054324 */  addiu      $v1, $v0, 0x5B8
    /* 1768C 80026E8C 3C20A3AC */  sw         $v1, %lo(screenCarSelect)($a1)
    /* 17690 80026E90 0580053C */  lui        $a1, %hi(screenCarSelectDuel)
    /* 17694 80026E94 58094324 */  addiu      $v1, $v0, 0x958
    /* 17698 80026E98 4020A3AC */  sw         $v1, %lo(screenCarSelectDuel)($a1)
    /* 1769C 80026E9C 0580053C */  lui        $a1, %hi(screenCarSelectTwoPlayer)
    /* 176A0 80026EA0 280D4324 */  addiu      $v1, $v0, 0xD28
    /* 176A4 80026EA4 4420A3AC */  sw         $v1, %lo(screenCarSelectTwoPlayer)($a1)
    /* 176A8 80026EA8 0580053C */  lui        $a1, %hi(screenCarSelectPlayerTwo)
    /* 176AC 80026EAC 60114324 */  addiu      $v1, $v0, 0x1160
    /* 176B0 80026EB0 4820A3AC */  sw         $v1, %lo(screenCarSelectPlayerTwo)($a1)
    /* 176B4 80026EB4 0580053C */  lui        $a1, %hi(screenPinkSlipsCarSelectTwoPlayer)
    /* 176B8 80026EB8 98154324 */  addiu      $v1, $v0, 0x1598
    /* 176BC 80026EBC 4C20A3AC */  sw         $v1, %lo(screenPinkSlipsCarSelectTwoPlayer)($a1)
    /* 176C0 80026EC0 0580053C */  lui        $a1, %hi(screenPinkSlipsCarSelectPlayerTwo)
    /* 176C4 80026EC4 E4194324 */  addiu      $v1, $v0, 0x19E4
    /* 176C8 80026EC8 5020A3AC */  sw         $v1, %lo(screenPinkSlipsCarSelectPlayerTwo)($a1)
    /* 176CC 80026ECC 0580053C */  lui        $a1, %hi(screenTrackRecords)
    /* 176D0 80026ED0 301E4324 */  addiu      $v1, $v0, 0x1E30
    /* 176D4 80026ED4 D020A3AC */  sw         $v1, %lo(screenTrackRecords)($a1)
    /* 176D8 80026ED8 0580053C */  lui        $a1, %hi(screenTrackInfo)
    /* 176DC 80026EDC A41E4324 */  addiu      $v1, $v0, 0x1EA4
    /* 176E0 80026EE0 CC20A3AC */  sw         $v1, %lo(screenTrackInfo)($a1)
    /* 176E4 80026EE4 0580053C */  lui        $a1, %hi(screenTrackSelect)
    /* 176E8 80026EE8 48214324 */  addiu      $v1, $v0, 0x2148
    /* 176EC 80026EEC B420A3AC */  sw         $v1, %lo(screenTrackSelect)($a1)
    /* 176F0 80026EF0 0580053C */  lui        $a1, %hi(screenTournSelect)
    /* 176F4 80026EF4 E8234324 */  addiu      $v1, $v0, 0x23E8
    /* 176F8 80026EF8 5C20A3AC */  sw         $v1, %lo(screenTournSelect)($a1)
    /* 176FC 80026EFC 0580053C */  lui        $a1, %hi(screenTournamentStandings)
    /* 17700 80026F00 B0264324 */  addiu      $v1, $v0, 0x26B0
    /* 17704 80026F04 681EA3AC */  sw         $v1, %lo(screenTournamentStandings)($a1)
    /* 17708 80026F08 0580053C */  lui        $a1, %hi(screenTournamentTrophy)
    /* 1770C 80026F0C 44274324 */  addiu      $v1, $v0, 0x2744
    /* 17710 80026F10 4829A3AC */  sw         $v1, %lo(screenTournamentTrophy)($a1)
    /* 17714 80026F14 0580053C */  lui        $a1, %hi(screenTrophyRoom)
    /* 17718 80026F18 CC284324 */  addiu      $v1, $v0, 0x28CC
    /* 1771C 80026F1C 6020A3AC */  sw         $v1, %lo(screenTrophyRoom)($a1)
    /* 17720 80026F20 0580053C */  lui        $a1, %hi(screenTrophyInfo)
    /* 17724 80026F24 242A4324 */  addiu      $v1, $v0, 0x2A24
    /* 17728 80026F28 8820A3AC */  sw         $v1, %lo(screenTrophyInfo)($a1)
    /* 1772C 80026F2C 0580053C */  lui        $a1, %hi(screenControllerConfig)
    /* 17730 80026F30 8C2A4324 */  addiu      $v1, $v0, 0x2A8C
    /* 17734 80026F34 D028A3AC */  sw         $v1, %lo(screenControllerConfig)($a1)
    /* 17738 80026F38 0580053C */  lui        $a1, %hi(screenDisplay)
    /* 1773C 80026F3C 082C4324 */  addiu      $v1, $v0, 0x2C08
    /* 17740 80026F40 D828A3AC */  sw         $v1, %lo(screenDisplay)($a1)
    /* 17744 80026F44 0580053C */  lui        $a1, %hi(screenAudio)
    /* 17748 80026F48 6C2C4324 */  addiu      $v1, $v0, 0x2C6C
    /* 1774C 80026F4C E828A3AC */  sw         $v1, %lo(screenAudio)($a1)
    /* 17750 80026F50 0580053C */  lui        $a1, %hi(screenMemcard)
    /* 17754 80026F54 E82C4324 */  addiu      $v1, $v0, 0x2CE8
    /* 17758 80026F58 F028A3AC */  sw         $v1, %lo(screenMemcard)($a1)
    /* 1775C 80026F5C 0580053C */  lui        $a1, %hi(screenUserName)
    /* 17760 80026F60 8C324324 */  addiu      $v1, $v0, 0x328C
    /* 17764 80026F64 B429A3AC */  sw         $v1, %lo(screenUserName)($a1)
    /* 17768 80026F68 0580053C */  lui        $a1, %hi(screenPinkSlipCongrats)
    /* 1776C 80026F6C 58334324 */  addiu      $v1, $v0, 0x3358
    /* 17770 80026F70 4429A3AC */  sw         $v1, %lo(screenPinkSlipCongrats)($a1)
    /* 17774 80026F74 0580053C */  lui        $a1, %hi(screenPinkSlipStandings)
    /* 17778 80026F78 E0344324 */  addiu      $v1, $v0, 0x34E0
    /* 1777C 80026F7C 701EA3AC */  sw         $v1, %lo(screenPinkSlipStandings)($a1)
    /* 17780 80026F80 0580053C */  lui        $a1, %hi(screenTournamentStandings3item)
    /* 17784 80026F84 74354324 */  addiu      $v1, $v0, 0x3574
    /* 17788 80026F88 6C1EA3AC */  sw         $v1, %lo(screenTournamentStandings3item)($a1)
    /* 1778C 80026F8C 0580053C */  lui        $a1, %hi(screenPinkSlips)
    /* 17790 80026F90 08364324 */  addiu      $v1, $v0, 0x3608
    /* 17794 80026F94 641EA3AC */  sw         $v1, %lo(screenPinkSlips)($a1)
    /* 17798 80026F98 0580053C */  lui        $a1, %hi(screenBeTheCopCongrats)
    /* 1779C 80026F9C D0384324 */  addiu      $v1, $v0, 0x38D0
    /* 177A0 80026FA0 4C29A3AC */  sw         $v1, %lo(screenBeTheCopCongrats)($a1)
    /* 177A4 80026FA4 0580033C */  lui        $v1, %hi(screenTournamentCongrats)
    /* 177A8 80026FA8 543A4224 */  addiu      $v0, $v0, 0x3A54
    /* 177AC 80026FAC 578F020C */  jal        __builtin_new
    /* 177B0 80026FB0 502962AC */   sw        $v0, %lo(screenTournamentCongrats)($v1)
    /* 177B4 80026FB4 E84B000C */  jal        __14tFEApplication
    /* 177B8 80026FB8 21204000 */   addu      $a0, $v0, $zero
    /* 177BC 80026FBC 183B0424 */  addiu      $a0, $zero, 0x3B18
    /* 177C0 80026FC0 0580033C */  lui        $v1, %hi(FEApp)
    /* 177C4 80026FC4 578F020C */  jal        __builtin_new
    /* 177C8 80026FC8 C01462AC */   sw        $v0, %lo(FEApp)($v1)
    /* 177CC 80026FCC EEB8000C */  jal        __15tGlobalMenuDefs
    /* 177D0 80026FD0 21204000 */   addu      $a0, $v0, $zero
    /* 177D4 80026FD4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 177D8 80026FD8 0580033C */  lui        $v1, %hi(menuDefs)
    /* 177DC 80026FDC 581A62AC */  sw         $v0, %lo(menuDefs)($v1)
    /* 177E0 80026FE0 0800E003 */  jr         $ra
    /* 177E4 80026FE4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Front_ConstructAll__Fv
