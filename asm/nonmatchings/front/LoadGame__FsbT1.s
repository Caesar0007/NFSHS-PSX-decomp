.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadGame__FsbT1, 0x5D8

glabel LoadGame__FsbT1
    /* 25618 80034E18 40E9BD27 */  addiu      $sp, $sp, -0x16C0
    /* 2561C 80034E1C 21388000 */  addu       $a3, $a0, $zero
    /* 25620 80034E20 00140700 */  sll        $v0, $a3, 16
    /* 25624 80034E24 9C16B1AF */  sw         $s1, 0x169C($sp)
    /* 25628 80034E28 038C0200 */  sra        $s1, $v0, 16
    /* 2562C 80034E2C 80101100 */  sll        $v0, $s1, 2
    /* 25630 80034E30 A416B3AF */  sw         $s3, 0x16A4($sp)
    /* 25634 80034E34 01005334 */  ori        $s3, $v0, 0x1
    /* 25638 80034E38 9816B0AF */  sw         $s0, 0x1698($sp)
    /* 2563C 80034E3C C015B027 */  addiu      $s0, $sp, 0x15C0
    /* 25640 80034E40 21200002 */  addu       $a0, $s0, $zero
    /* 25644 80034E44 0580023C */  lui        $v0, %hi(CURRENTPLAYER)
    /* 25648 80034E48 0580033C */  lui        $v1, %hi(CURRENTLYUSINGMEMCARD)
    /* 2564C 80034E4C 681A51AC */  sw         $s1, %lo(CURRENTPLAYER)($v0)
    /* 25650 80034E50 01000224 */  addiu      $v0, $zero, 0x1
    /* 25654 80034E54 BC16BFAF */  sw         $ra, 0x16BC($sp)
    /* 25658 80034E58 B816BEAF */  sw         $fp, 0x16B8($sp)
    /* 2565C 80034E5C B416B7AF */  sw         $s7, 0x16B4($sp)
    /* 25660 80034E60 B016B6AF */  sw         $s6, 0x16B0($sp)
    /* 25664 80034E64 AC16B5AF */  sw         $s5, 0x16AC($sp)
    /* 25668 80034E68 A816B4AF */  sw         $s4, 0x16A8($sp)
    /* 2566C 80034E6C A016B2AF */  sw         $s2, 0x16A0($sp)
    /* 25670 80034E70 C416A5AF */  sw         $a1, 0x16C4($sp)
    /* 25674 80034E74 C816A6AF */  sw         $a2, 0x16C8($sp)
    /* 25678 80034E78 7C1A62AC */  sw         $v0, %lo(CURRENTLYUSINGMEMCARD)($v1)
    /* 2567C 80034E7C 0898000C */  jal        __7tScreen
    /* 25680 80034E80 8816A7A7 */   sh        $a3, 0x1688($sp)
    /* 25684 80034E84 0180023C */  lui        $v0, %hi(_vt_11tDialogBase)
    /* 25688 80034E88 B0054224 */  addiu      $v0, $v0, %lo(_vt_11tDialogBase)
    /* 2568C 80034E8C 2016A2AF */  sw         $v0, 0x1620($sp)
    /* 25690 80034E90 20010224 */  addiu      $v0, $zero, 0x120
    /* 25694 80034E94 3016A0AF */  sw         $zero, 0x1630($sp)
    /* 25698 80034E98 2E16A0A7 */  sh         $zero, 0x162E($sp)
    /* 2569C 80034E9C 4216A0A7 */  sh         $zero, 0x1642($sp)
    /* 256A0 80034EA0 3E16A0A7 */  sh         $zero, 0x163E($sp)
    /* 256A4 80034EA4 3C16A0A7 */  sh         $zero, 0x163C($sp)
    /* 256A8 80034EA8 2C16A0A7 */  sh         $zero, 0x162C($sp)
    /* 256AC 80034EAC 2A16A0A7 */  sh         $zero, 0x162A($sp)
    /* 256B0 80034EB0 2816A0A7 */  sh         $zero, 0x1628($sp)
    /* 256B4 80034EB4 2616A0A7 */  sh         $zero, 0x1626($sp)
    /* 256B8 80034EB8 800002A6 */  sh         $v0, 0x80($s0)
    /* 256BC 80034EBC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 256C0 80034EC0 640002A6 */  sh         $v0, 0x64($s0)
    /* 256C4 80034EC4 0180023C */  lui        $v0, %hi(_vt_20tDialogMessageString)
    /* 256C8 80034EC8 F0044224 */  addiu      $v0, $v0, %lo(_vt_20tDialogMessageString)
    /* 256CC 80034ECC 2016A2AF */  sw         $v0, 0x1620($sp)
    /* 256D0 80034ED0 80000224 */  addiu      $v0, $zero, 0x80
    /* 256D4 80034ED4 4816A0A7 */  sh         $zero, 0x1648($sp)
    /* 256D8 80034ED8 3816A0AF */  sw         $zero, 0x1638($sp)
    /* 256DC 80034EDC 5416A0AF */  sw         $zero, 0x1654($sp)
    /* 256E0 80034EE0 4416A0AF */  sw         $zero, 0x1644($sp)
    /* 256E4 80034EE4 3816A0AF */  sw         $zero, 0x1638($sp)
    /* 256E8 80034EE8 8C0002AE */  sw         $v0, 0x8C($s0)
    /* 256EC 80034EEC 0180023C */  lui        $v0, %hi(_vt_21tDialogNoInputMessage)
    /* 256F0 80034EF0 C816A88F */  lw         $t0, 0x16C8($sp)
    /* 256F4 80034EF4 30044224 */  addiu      $v0, $v0, %lo(_vt_21tDialogNoInputMessage)
    /* 256F8 80034EF8 05000015 */  bnez       $t0, .L80034F10
    /* 256FC 80034EFC 2016A2AF */   sw        $v0, 0x1620($sp)
    /* 25700 80034F00 C416A98F */  lw         $t1, 0x16C4($sp)
    /* 25704 80034F04 00000000 */  nop
    /* 25708 80034F08 1B002011 */  beqz       $t1, .L80034F78
    /* 2570C 80034F0C 0580023C */   lui       $v0, %hi(nomessage)
  .L80034F10:
    /* 25710 80034F10 94E4020C */  jal        TextSys_Word__Fi
    /* 25714 80034F14 76022426 */   addiu     $a0, $s1, 0x276
    /* 25718 80034F18 C416A88F */  lw         $t0, 0x16C4($sp)
    /* 2571C 80034F1C 00000000 */  nop
    /* 25720 80034F20 04000015 */  bnez       $t0, .L80034F34
    /* 25724 80034F24 5016A2AF */   sw        $v0, 0x1650($sp)
    /* 25728 80034F28 32000224 */  addiu      $v0, $zero, 0x32
    /* 2572C 80034F2C 3C16A0A7 */  sh         $zero, 0x163C($sp)
    /* 25730 80034F30 3E16A2A7 */  sh         $v0, 0x163E($sp)
  .L80034F34:
    /* 25734 80034F34 1062000C */  jal        Display__11tDialogBase
    /* 25738 80034F38 21200002 */   addu      $a0, $s0, $zero
    /* 2573C 80034F3C 0580103C */  lui        $s0, %hi(FEApp)
  .L80034F40:
    /* 25740 80034F40 4416A28F */  lw         $v0, 0x1644($sp)
    /* 25744 80034F44 00000000 */  nop
    /* 25748 80034F48 01004238 */  xori       $v0, $v0, 0x1
    /* 2574C 80034F4C 06004010 */  beqz       $v0, .L80034F68
    /* 25750 80034F50 0580023C */   lui       $v0, %hi(FEApp)
    /* 25754 80034F54 C014048E */  lw         $a0, %lo(FEApp)($s0)
    /* 25758 80034F58 CF4D000C */  jal        Redraw__14tFEApplication
    /* 2575C 80034F5C 00000000 */   nop
    /* 25760 80034F60 D0D30008 */  j          .L80034F40
    /* 25764 80034F64 00000000 */   nop
  .L80034F68:
    /* 25768 80034F68 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 2576C 80034F6C CF4D000C */  jal        Redraw__14tFEApplication
    /* 25770 80034F70 00000000 */   nop
    /* 25774 80034F74 0580023C */  lui        $v0, %hi(nomessage)
  .L80034F78:
    /* 25778 80034F78 21880000 */  addu       $s1, $zero, $zero
    /* 2577C 80034F7C 21A02002 */  addu       $s4, $s1, $zero
    /* 25780 80034F80 C816A98F */  lw         $t1, 0x16C8($sp)
    /* 25784 80034F84 2C001E24 */  addiu      $fp, $zero, 0x2C
    /* 25788 80034F88 02002011 */  beqz       $t1, .L80034F94
    /* 2578C 80034F8C 781A40AC */   sw        $zero, %lo(nomessage)($v0)
    /* 25790 80034F90 21F02002 */  addu       $fp, $s1, $zero
  .L80034F94:
    /* 25794 80034F94 8D021224 */  addiu      $s2, $zero, 0x28D
    /* 25798 80034F98 8816A897 */  lhu        $t0, 0x1688($sp)
    /* 2579C 80034F9C 00AC1300 */  sll        $s5, $s3, 16
    /* 257A0 80034FA0 00440800 */  sll        $t0, $t0, 16
    /* 257A4 80034FA4 9016A8AF */  sw         $t0, 0x1690($sp)
  .L80034FA8:
    /* 257A8 80034FA8 FCD0000C */  jal        MakeWayForMemoryCard__Fv
    /* 257AC 80034FAC 0100DE27 */   addiu     $fp, $fp, 0x1
    /* 257B0 80034FB0 5816A427 */  addiu      $a0, $sp, 0x1658
    /* 257B4 80034FB4 032C1500 */  sra        $a1, $s5, 16
    /* 257B8 80034FB8 28D2000C */  jal        Init_MemcardFile__FR12MCRDFILE_defsb
    /* 257BC 80034FBC 01000624 */   addiu     $a2, $zero, 0x1
  .L80034FC0:
    /* 257C0 80034FC0 A03F010C */  jal        MCRD_handlecardevents
    /* 257C4 80034FC4 03241500 */   sra       $a0, $s5, 16
    /* 257C8 80034FC8 15000924 */  addiu      $t1, $zero, 0x15
    /* 257CC 80034FCC 05004914 */  bne        $v0, $t1, .L80034FE4
    /* 257D0 80034FD0 1000A227 */   addiu     $v0, $sp, 0x10
    /* 257D4 80034FD4 C7C8030C */  jal        VSync
    /* 257D8 80034FD8 21200000 */   addu      $a0, $zero, $zero
    /* 257DC 80034FDC F0D30008 */  j          .L80034FC0
    /* 257E0 80034FE0 00000000 */   nop
  .L80034FE4:
    /* 257E4 80034FE4 9016A88F */  lw         $t0, 0x1690($sp)
    /* 257E8 80034FE8 6C16A2AF */  sw         $v0, 0x166C($sp)
    /* 257EC 80034FEC 6816A0AF */  sw         $zero, 0x1668($sp)
    /* 257F0 80034FF0 039C0800 */  sra        $s3, $t0, 16
    /* 257F4 80034FF4 C0B81300 */  sll        $s7, $s3, 3
    /* 257F8 80034FF8 80481300 */  sll        $t1, $s3, 2
    /* 257FC 80034FFC 1180083C */  lui        $t0, %hi(frontEnd)
    /* 25800 80035000 00460825 */  addiu      $t0, $t0, %lo(frontEnd)
    /* 25804 80035004 21B02801 */  addu       $s6, $t1, $t0
    /* 25808 80035008 9416A9AF */  sw         $t1, 0x1694($sp)
  jlabel .L8003500C
    /* 2580C 8003500C 8A002016 */  bnez       $s1, .L80035238
    /* 25810 80035010 16001024 */   addiu     $s0, $zero, 0x16
    /* 25814 80035014 A03F010C */  jal        MCRD_handlecardevents
    /* 25818 80035018 03241500 */   sra       $a0, $s5, 16
    /* 2581C 8003501C 21200000 */  addu       $a0, $zero, $zero
    /* 25820 80035020 019B030C */  jal        systemtask
    /* 25824 80035024 21804000 */   addu      $s0, $v0, $zero
    /* 25828 80035028 C7C8030C */  jal        VSync
    /* 2582C 8003502C 21200000 */   addu      $a0, $zero, $zero
    /* 25830 80035030 FEFF1026 */  addiu      $s0, $s0, -0x2
    /* 25834 80035034 1600022E */  sltiu      $v0, $s0, 0x16
    /* 25838 80035038 F4FF4010 */  beqz       $v0, .L8003500C
    /* 2583C 8003503C 80101000 */   sll       $v0, $s0, 2
    /* 25840 80035040 0180093C */  lui        $t1, %hi(jtbl_80011750)
    /* 25844 80035044 50172925 */  addiu      $t1, $t1, %lo(jtbl_80011750)
    /* 25848 80035048 21104900 */  addu       $v0, $v0, $t1
    /* 2584C 8003504C 0000428C */  lw         $v0, 0x0($v0)
    /* 25850 80035050 00000000 */  nop
    /* 25854 80035054 08004000 */  jr         $v0
    /* 25858 80035058 00000000 */   nop
  jlabel .L8003505C
    /* 2585C 8003505C 03241500 */  sra        $a0, $s5, 16
    /* 25860 80035060 5816A527 */  addiu      $a1, $sp, 0x1658
    /* 25864 80035064 AE3D010C */  jal        MCRD_loadfile
    /* 25868 80035068 21300000 */   addu      $a2, $zero, $zero
    /* 2586C 8003506C 03D40008 */  j          .L8003500C
    /* 25870 80035070 00000000 */   nop
  jlabel .L80035074
    /* 25874 80035074 C6D0000C */  jal        VerifySuccessfulRead__FP12tMemCardData
    /* 25878 80035078 1000A427 */   addiu     $a0, $sp, 0x10
    /* 2587C 8003507C 3D004010 */  beqz       $v0, .L80035174
    /* 25880 80035080 00000000 */   nop
    /* 25884 80035084 C416A88F */  lw         $t0, 0x16C4($sp)
    /* 25888 80035088 00000000 */  nop
    /* 2588C 8003508C 25000015 */  bnez       $t0, .L80035124
    /* 25890 80035090 21A00000 */   addu      $s4, $zero, $zero
    /* 25894 80035094 16006016 */  bnez       $s3, .L800350F0
    /* 25898 80035098 1800A427 */   addiu     $a0, $sp, 0x18
    /* 2589C 8003509C 1180093C */  lui        $t1, %hi(frontEnd)
    /* 258A0 800350A0 00462525 */  addiu      $a1, $t1, %lo(frontEnd)
    /* 258A4 800350A4 B798030C */  jal        blockmove
    /* 258A8 800350A8 50040624 */   addiu     $a2, $zero, 0x450
    /* 258AC 800350AC 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 258B0 800350B0 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 258B4 800350B4 51CD000C */  jal        LoadTournament__18tTournamentManagerR15tSaveTournament
    /* 258B8 800350B8 5805A527 */   addiu     $a1, $sp, 0x558
    /* 258BC 800350BC 1180043C */  lui        $a0, %hi(trackManager)
    /* 258C0 800350C0 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 258C4 800350C4 9486000C */  jal        LoadTracks__13tTrackManagerR14tSaveTrackInfo
    /* 258C8 800350C8 4805A527 */   addiu     $a1, $sp, 0x548
    /* 258CC 800350CC 0806A427 */  addiu      $a0, $sp, 0x608
    /* 258D0 800350D0 1180053C */  lui        $a1, %hi(Stats_gTrackRecords)
    /* 258D4 800350D4 944DA524 */  addiu      $a1, $a1, %lo(Stats_gTrackRecords)
    /* 258D8 800350D8 B798030C */  jal        blockmove
    /* 258DC 800350DC 9C0E0624 */   addiu     $a2, $zero, 0xE9C
    /* 258E0 800350E0 D68D000C */  jal        FECheat_LoadBonus__FRUl
    /* 258E4 800350E4 1400A427 */   addiu     $a0, $sp, 0x14
    /* 258E8 800350E8 42D40008 */  j          .L80035108
    /* 258EC 800350EC 1180043C */   lui       $a0, %hi(carManager)
  .L800350F0:
    /* 258F0 800350F0 1180043C */  lui        $a0, %hi(D_80114964)
    /* 258F4 800350F4 64498424 */  addiu      $a0, $a0, %lo(D_80114964)
    /* 258F8 800350F8 2120E402 */  addu       $a0, $s7, $a0
    /* 258FC 800350FC 2F91030C */  jal        sprintf
    /* 25900 80035100 7C03A527 */   addiu     $a1, $sp, 0x37C
    /* 25904 80035104 1180043C */  lui        $a0, %hi(carManager)
  .L80035108:
    /* 25908 80035108 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2590C 8003510C 9016A88F */  lw         $t0, 0x1690($sp)
    /* 25910 80035110 6804A527 */  addiu      $a1, $sp, 0x468
    /* 25914 80035114 955A000C */  jal        LoadCars__11tCarManagerR12tSaveCarInfos
    /* 25918 80035118 03340800 */   sra       $a2, $t0, 16
    /* 2591C 8003511C 59D40008 */  j          .L80035164
    /* 25920 80035120 00000000 */   nop
  .L80035124:
    /* 25924 80035124 1180043C */  lui        $a0, %hi(carManager)
    /* 25928 80035128 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2592C 8003512C 6804A527 */  addiu      $a1, $sp, 0x468
    /* 25930 80035130 A414A28F */  lw         $v0, 0x14A4($sp)
    /* 25934 80035134 21306002 */  addu       $a2, $s3, $zero
    /* 25938 80035138 DA5A000C */  jal        LoadPinkSlipsCars__11tCarManagerR12tSaveCarInfos
    /* 2593C 8003513C 3C04C2AE */   sw        $v0, 0x43C($s6)
    /* 25940 80035140 1180093C */  lui        $t1, %hi(frontEnd)
    /* 25944 80035144 00462925 */  addiu      $t1, $t1, %lo(frontEnd)
    /* 25948 80035148 64032425 */  addiu      $a0, $t1, 0x364
    /* 2594C 8003514C 2120E402 */  addu       $a0, $s7, $a0
    /* 25950 80035150 2F91030C */  jal        sprintf
    /* 25954 80035154 7C03A527 */   addiu     $a1, $sp, 0x37C
    /* 25958 80035158 5805A28F */  lw         $v0, 0x558($sp)
    /* 2595C 8003515C 00000000 */  nop
    /* 25960 80035160 4C00C2AE */  sw         $v0, 0x4C($s6)
  .L80035164:
    /* 25964 80035164 439D000C */  jal        SetPads__Fv
    /* 25968 80035168 8D021224 */   addiu     $s2, $zero, 0x28D
    /* 2596C 8003516C 03D40008 */  j          .L8003500C
    /* 25970 80035170 01001124 */   addiu     $s1, $zero, 0x1
  .L80035174:
    /* 25974 80035174 C816A88F */  lw         $t0, 0x16C8($sp)
    /* 25978 80035178 00000000 */  nop
    /* 2597C 8003517C 2C000011 */  beqz       $t0, .L80035230
    /* 25980 80035180 01001424 */   addiu     $s4, $zero, 0x1
    /* 25984 80035184 0580023C */  lui        $v0, %hi(nomessage)
    /* 25988 80035188 781A428C */  lw         $v0, %lo(nomessage)($v0)
    /* 2598C 8003518C 00000000 */  nop
    /* 25990 80035190 9EFF4014 */  bnez       $v0, .L8003500C
    /* 25994 80035194 01001124 */   addiu     $s1, $zero, 0x1
    /* 25998 80035198 0580113C */  lui        $s1, %hi(FEApp)
    /* 2599C 8003519C C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 259A0 800351A0 4162000C */  jal        Hide__11tDialogBase
    /* 259A4 800351A4 D0028424 */   addiu     $a0, $a0, 0x2D0
    /* 259A8 800351A8 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 259AC 800351AC 4162000C */  jal        Hide__11tDialogBase
    /* 259B0 800351B0 38028424 */   addiu     $a0, $a0, 0x238
    /* 259B4 800351B4 C014308E */  lw         $s0, %lo(FEApp)($s1)
    /* 259B8 800351B8 29036426 */  addiu      $a0, $s3, 0x329
    /* 259BC 800351BC 94E4020C */  jal        TextSys_Word__Fi
    /* 259C0 800351C0 38021026 */   addiu     $s0, $s0, 0x238
    /* 259C4 800351C4 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 259C8 800351C8 900002AE */  sw         $v0, 0x90($s0)
    /* 259CC 800351CC 1062000C */  jal        Display__11tDialogBase
    /* 259D0 800351D0 38028424 */   addiu     $a0, $a0, 0x238
    /* 259D4 800351D4 03D40008 */  j          .L8003500C
    /* 259D8 800351D8 01001124 */   addiu     $s1, $zero, 0x1
  jlabel .L800351DC
    /* 259DC 800351DC 9416A98F */  lw         $t1, 0x1694($sp)
    /* 259E0 800351E0 9140010C */  jal        MCRD_getcard
    /* 259E4 800351E4 01002425 */   addiu     $a0, $t1, 0x1
    /* 259E8 800351E8 0580033C */  lui        $v1, %hi(FEApp)
    /* 259EC 800351EC C014648C */  lw         $a0, %lo(FEApp)($v1)
    /* 259F0 800351F0 21804000 */  addu       $s0, $v0, $zero
    /* 259F4 800351F4 4162000C */  jal        Hide__11tDialogBase
    /* 259F8 800351F8 D0028424 */   addiu     $a0, $a0, 0x2D0
    /* 259FC 800351FC 0000108E */  lw         $s0, 0x0($s0)
    /* 25A00 80035200 FEFF0224 */  addiu      $v0, $zero, -0x2
    /* 25A04 80035204 04000216 */  bne        $s0, $v0, .L80035218
    /* 25A08 80035208 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 25A0C 8003520C 9F021224 */  addiu      $s2, $zero, 0x29F
    /* 25A10 80035210 8CD40008 */  j          .L80035230
    /* 25A14 80035214 02001424 */   addiu     $s4, $zero, 0x2
  .L80035218:
    /* 25A18 80035218 04000216 */  bne        $s0, $v0, .L8003522C
    /* 25A1C 8003521C 01001424 */   addiu     $s4, $zero, 0x1
    /* 25A20 80035220 03001424 */  addiu      $s4, $zero, 0x3
    /* 25A24 80035224 8CD40008 */  j          .L80035230
    /* 25A28 80035228 2B031224 */   addiu     $s2, $zero, 0x32B
  .L8003522C:
    /* 25A2C 8003522C 29031224 */  addiu      $s2, $zero, 0x329
  .L80035230:
    /* 25A30 80035230 03D40008 */  j          .L8003500C
    /* 25A34 80035234 01001124 */   addiu     $s1, $zero, 0x1
  .L80035238:
    /* 25A38 80035238 A03F010C */  jal        MCRD_handlecardevents
    /* 25A3C 8003523C 03241500 */   sra       $a0, $s5, 16
    /* 25A40 80035240 05005010 */  beq        $v0, $s0, .L80035258
    /* 25A44 80035244 00000000 */   nop
    /* 25A48 80035248 C7C8030C */  jal        VSync
    /* 25A4C 8003524C 21200000 */   addu      $a0, $zero, $zero
    /* 25A50 80035250 8ED40008 */  j          .L80035238
    /* 25A54 80035254 00000000 */   nop
  .L80035258:
    /* 25A58 80035258 05D1000C */  jal        BringThatBeatBack__Fv
    /* 25A5C 8003525C 00000000 */   nop
    /* 25A60 80035260 8D020224 */  addiu      $v0, $zero, 0x28D
    /* 25A64 80035264 03004212 */  beq        $s2, $v0, .L80035274
    /* 25A68 80035268 0300C22B */   slti      $v0, $fp, 0x3
    /* 25A6C 8003526C 4EFF4014 */  bnez       $v0, .L80034FA8
    /* 25A70 80035270 00000000 */   nop
  .L80035274:
    /* 25A74 80035274 C816A88F */  lw         $t0, 0x16C8($sp)
    /* 25A78 80035278 00000000 */  nop
    /* 25A7C 8003527C 24000011 */  beqz       $t0, .L80035310
    /* 25A80 80035280 0580023C */   lui       $v0, %hi(nomessage)
    /* 25A84 80035284 781A428C */  lw         $v0, %lo(nomessage)($v0)
    /* 25A88 80035288 00000000 */  nop
    /* 25A8C 8003528C 21004014 */  bnez       $v0, .L80035314
    /* 25A90 80035290 1180023C */   lui       $v0, %hi(frontEnd)
    /* 25A94 80035294 0580113C */  lui        $s1, %hi(FEApp)
    /* 25A98 80035298 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 25A9C 8003529C 4162000C */  jal        Hide__11tDialogBase
    /* 25AA0 800352A0 D0028424 */   addiu     $a0, $a0, 0x2D0
    /* 25AA4 800352A4 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 25AA8 800352A8 4162000C */  jal        Hide__11tDialogBase
    /* 25AAC 800352AC 38028424 */   addiu     $a0, $a0, 0x238
    /* 25AB0 800352B0 8816A997 */  lhu        $t1, 0x1688($sp)
    /* 25AB4 800352B4 C014308E */  lw         $s0, %lo(FEApp)($s1)
    /* 25AB8 800352B8 00240900 */  sll        $a0, $t1, 16
    /* 25ABC 800352BC 03240400 */  sra        $a0, $a0, 16
    /* 25AC0 800352C0 21204402 */  addu       $a0, $s2, $a0
    /* 25AC4 800352C4 94E4020C */  jal        TextSys_Word__Fi
    /* 25AC8 800352C8 38021026 */   addiu     $s0, $s0, 0x238
    /* 25ACC 800352CC C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 25AD0 800352D0 900002AE */  sw         $v0, 0x90($s0)
    /* 25AD4 800352D4 1062000C */  jal        Display__11tDialogBase
    /* 25AD8 800352D8 38028424 */   addiu     $a0, $a0, 0x238
  .L800352DC:
    /* 25ADC 800352DC C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 25AE0 800352E0 00000000 */  nop
    /* 25AE4 800352E4 BC02828C */  lw         $v0, 0x2BC($a0)
    /* 25AE8 800352E8 00000000 */  nop
    /* 25AEC 800352EC 01004238 */  xori       $v0, $v0, 0x1
    /* 25AF0 800352F0 05004010 */  beqz       $v0, .L80035308
    /* 25AF4 800352F4 00000000 */   nop
    /* 25AF8 800352F8 CF4D000C */  jal        Redraw__14tFEApplication
    /* 25AFC 800352FC 00000000 */   nop
    /* 25B00 80035300 B7D40008 */  j          .L800352DC
    /* 25B04 80035304 00000000 */   nop
  .L80035308:
    /* 25B08 80035308 CF4D000C */  jal        Redraw__14tFEApplication
    /* 25B0C 8003530C 00000000 */   nop
  .L80035310:
    /* 25B10 80035310 1180023C */  lui        $v0, %hi(frontEnd)
  .L80035314:
    /* 25B14 80035314 8816A897 */  lhu        $t0, 0x1688($sp)
    /* 25B18 80035318 00465024 */  addiu      $s0, $v0, %lo(frontEnd)
    /* 25B1C 8003531C 00240800 */  sll        $a0, $t0, 16
    /* 25B20 80035320 03240400 */  sra        $a0, $a0, 16
    /* 25B24 80035324 21109000 */  addu       $v0, $a0, $s0
    /* 25B28 80035328 62034590 */  lbu        $a1, 0x362($v0)
    /* 25B2C 8003532C 399C000C */  jal        Front_ResetPSXController__Fii
    /* 25B30 80035330 00000000 */   nop
    /* 25B34 80035334 C416A98F */  lw         $t1, 0x16C4($sp)
    /* 25B38 80035338 00000000 */  nop
    /* 25B3C 8003533C 09002015 */  bnez       $t1, .L80035364
    /* 25B40 80035340 06000224 */   addiu     $v0, $zero, 0x6
    /* 25B44 80035344 04000392 */  lbu        $v1, 0x4($s0)
    /* 25B48 80035348 00000000 */  nop
    /* 25B4C 8003534C 02006214 */  bne        $v1, $v0, .L80035358
    /* 25B50 80035350 00000000 */   nop
    /* 25B54 80035354 040000A2 */  sb         $zero, 0x4($s0)
  .L80035358:
    /* 25B58 80035358 42030392 */  lbu        $v1, 0x342($s0)
    /* 25B5C 8003535C 1480023C */  lui        $v0, %hi(gMasterSFXLevel)
    /* 25B60 80035360 54C643AC */  sw         $v1, %lo(gMasterSFXLevel)($v0)
  .L80035364:
    /* 25B64 80035364 C816A88F */  lw         $t0, 0x16C8($sp)
    /* 25B68 80035368 00000000 */  nop
    /* 25B6C 8003536C 05000015 */  bnez       $t0, .L80035384
    /* 25B70 80035370 00000000 */   nop
    /* 25B74 80035374 C416A98F */  lw         $t1, 0x16C4($sp)
    /* 25B78 80035378 00000000 */  nop
    /* 25B7C 8003537C 04002011 */  beqz       $t1, .L80035390
    /* 25B80 80035380 00000000 */   nop
  .L80035384:
    /* 25B84 80035384 4162000C */  jal        Hide__11tDialogBase
    /* 25B88 80035388 C015A427 */   addiu     $a0, $sp, 0x15C0
    /* 25B8C 8003538C C816A88F */  lw         $t0, 0x16C8($sp)
  .L80035390:
    /* 25B90 80035390 00000000 */  nop
    /* 25B94 80035394 04000011 */  beqz       $t0, .L800353A8
    /* 25B98 80035398 0580023C */   lui       $v0, %hi(FEApp)
    /* 25B9C 8003539C C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 25BA0 800353A0 CF4D000C */  jal        Redraw__14tFEApplication
    /* 25BA4 800353A4 00000000 */   nop
  .L800353A8:
    /* 25BA8 800353A8 0580023C */  lui        $v0, %hi(CURRENTLYUSINGMEMCARD)
    /* 25BAC 800353AC C015A427 */  addiu      $a0, $sp, 0x15C0
    /* 25BB0 800353B0 02000524 */  addiu      $a1, $zero, 0x2
    /* 25BB4 800353B4 1E98000C */  jal        ___7tScreen
    /* 25BB8 800353B8 7C1A40AC */   sw        $zero, %lo(CURRENTLYUSINGMEMCARD)($v0)
    /* 25BBC 800353BC 21108002 */  addu       $v0, $s4, $zero
    /* 25BC0 800353C0 BC16BF8F */  lw         $ra, 0x16BC($sp)
    /* 25BC4 800353C4 B816BE8F */  lw         $fp, 0x16B8($sp)
    /* 25BC8 800353C8 B416B78F */  lw         $s7, 0x16B4($sp)
    /* 25BCC 800353CC B016B68F */  lw         $s6, 0x16B0($sp)
    /* 25BD0 800353D0 AC16B58F */  lw         $s5, 0x16AC($sp)
    /* 25BD4 800353D4 A816B48F */  lw         $s4, 0x16A8($sp)
    /* 25BD8 800353D8 A416B38F */  lw         $s3, 0x16A4($sp)
    /* 25BDC 800353DC A016B28F */  lw         $s2, 0x16A0($sp)
    /* 25BE0 800353E0 9C16B18F */  lw         $s1, 0x169C($sp)
    /* 25BE4 800353E4 9816B08F */  lw         $s0, 0x1698($sp)
    /* 25BE8 800353E8 0800E003 */  jr         $ra
    /* 25BEC 800353EC C016BD27 */   addiu     $sp, $sp, 0x16C0
endlabel LoadGame__FsbT1
