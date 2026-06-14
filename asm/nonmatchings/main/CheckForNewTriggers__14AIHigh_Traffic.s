.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForNewTriggers__14AIHigh_Traffic, 0x254

glabel CheckForNewTriggers__14AIHigh_Traffic
    /* 56F38 80066738 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 56F3C 8006673C 1180023C */  lui        $v0, %hi(Cars_gTotalSortedList)
    /* 56F40 80066740 1480033C */  lui        $v1, %hi(Cars_gNumCars)
    /* 56F44 80066744 F4C7638C */  lw         $v1, %lo(Cars_gNumCars)($v1)
    /* 56F48 80066748 20FB4224 */  addiu      $v0, $v0, %lo(Cars_gTotalSortedList)
    /* 56F4C 8006674C 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* 56F50 80066750 3800BEAF */  sw         $fp, 0x38($sp)
    /* 56F54 80066754 3400B7AF */  sw         $s7, 0x34($sp)
    /* 56F58 80066758 3000B6AF */  sw         $s6, 0x30($sp)
    /* 56F5C 8006675C 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 56F60 80066760 2800B4AF */  sw         $s4, 0x28($sp)
    /* 56F64 80066764 2400B3AF */  sw         $s3, 0x24($sp)
    /* 56F68 80066768 2000B2AF */  sw         $s2, 0x20($sp)
    /* 56F6C 8006676C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 56F70 80066770 1800B0AF */  sw         $s0, 0x18($sp)
    /* 56F74 80066774 FFFF7724 */  addiu      $s7, $v1, -0x1
    /* 56F78 80066778 80181700 */  sll        $v1, $s7, 2
    /* 56F7C 8006677C 21186200 */  addu       $v1, $v1, $v0
    /* 56F80 80066780 1400A3AF */  sw         $v1, 0x14($sp)
  .L80066784:
    /* 56F84 80066784 7500E006 */  bltz       $s7, .L8006695C
    /* 56F88 80066788 21100000 */   addu      $v0, $zero, $zero
    /* 56F8C 8006678C 1400A88F */  lw         $t0, 0x14($sp)
    /* 56F90 80066790 00000000 */  nop
    /* 56F94 80066794 0000158D */  lw         $s5, 0x0($t0)
    /* 56F98 80066798 00000000 */  nop
    /* 56F9C 8006679C 6002A28E */  lw         $v0, 0x260($s5)
    /* 56FA0 800667A0 00000000 */  nop
    /* 56FA4 800667A4 04024230 */  andi       $v0, $v0, 0x204
    /* 56FA8 800667A8 68004010 */  beqz       $v0, .L8006694C
    /* 56FAC 800667AC FFFF0424 */   addiu     $a0, $zero, -0x1
    /* 56FB0 800667B0 1180083C */  lui        $t0, %hi(highLevelAIObjs)
    /* 56FB4 800667B4 38CD0825 */  addiu      $t0, $t0, %lo(highLevelAIObjs)
    /* 56FB8 800667B8 5402A28E */  lw         $v0, 0x254($s5)
    /* 56FBC 800667BC 6405A38E */  lw         $v1, 0x564($s5)
    /* 56FC0 800667C0 80100200 */  sll        $v0, $v0, 2
    /* 56FC4 800667C4 21104800 */  addu       $v0, $v0, $t0
    /* 56FC8 800667C8 0000468C */  lw         $a2, 0x0($v0)
    /* 56FCC 800667CC 02006004 */  bltz       $v1, .L800667D8
    /* 56FD0 800667D0 3200073C */   lui       $a3, (0x320000 >> 16)
    /* 56FD4 800667D4 01000424 */  addiu      $a0, $zero, 0x1
  .L800667D8:
    /* 56FD8 800667D8 40100400 */  sll        $v0, $a0, 1
    /* 56FDC 800667DC 21104400 */  addu       $v0, $v0, $a0
    /* 56FE0 800667E0 00190200 */  sll        $v1, $v0, 4
    /* 56FE4 800667E4 23186200 */  subu       $v1, $v1, $v0
    /* 56FE8 800667E8 0A006004 */  bltz       $v1, .L80066814
    /* 56FEC 800667EC 00000000 */   nop
    /* 56FF0 800667F0 0800A286 */  lh         $v0, 0x8($s5)
    /* 56FF4 800667F4 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 56FF8 800667F8 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 56FFC 800667FC 21184300 */  addu       $v1, $v0, $v1
    /* 57000 80066800 2A106400 */  slt        $v0, $v1, $a0
    /* 57004 80066804 0C004014 */  bnez       $v0, .L80066838
    /* 57008 80066808 00000000 */   nop
    /* 5700C 8006680C 0E9A0108 */  j          .L80066838
    /* 57010 80066810 23186400 */   subu      $v1, $v1, $a0
  .L80066814:
    /* 57014 80066814 0800A286 */  lh         $v0, 0x8($s5)
    /* 57018 80066818 00000000 */  nop
    /* 5701C 8006681C 21184300 */  addu       $v1, $v0, $v1
    /* 57020 80066820 05006104 */  bgez       $v1, .L80066838
    /* 57024 80066824 00000000 */   nop
    /* 57028 80066828 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 5702C 8006682C C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 57030 80066830 00000000 */  nop
    /* 57034 80066834 21186200 */  addu       $v1, $v1, $v0
  .L80066838:
    /* 57038 80066838 1000C58C */  lw         $a1, 0x10($a2)
    /* 5703C 8006683C 00000000 */  nop
    /* 57040 80066840 2A10A300 */  slt        $v0, $a1, $v1
    /* 57044 80066844 04004010 */  beqz       $v0, .L80066858
    /* 57048 80066848 1000C3AC */   sw        $v1, 0x10($a2)
    /* 5704C 8006684C 2120A000 */  addu       $a0, $a1, $zero
    /* 57050 80066850 189A0108 */  j          .L80066860
    /* 57054 80066854 21A06000 */   addu      $s4, $v1, $zero
  .L80066858:
    /* 57058 80066858 21206000 */  addu       $a0, $v1, $zero
    /* 5705C 8006685C 21A0A000 */  addu       $s4, $a1, $zero
  .L80066860:
    /* 57060 80066860 21888000 */  addu       $s1, $a0, $zero
    /* 57064 80066864 23109102 */  subu       $v0, $s4, $s1
    /* 57068 80066868 32005E28 */  slti       $fp, $v0, 0x32
    /* 5706C 8006686C 40100700 */  sll        $v0, $a3, 1
    /* 57070 80066870 21104700 */  addu       $v0, $v0, $a3
    /* 57074 80066874 C0100200 */  sll        $v0, $v0, 3
    /* 57078 80066878 21B04700 */  addu       $s6, $v0, $a3
  .L8006687C:
    /* 5707C 8006687C 2A103402 */  slt        $v0, $s1, $s4
    /* 57080 80066880 31004010 */  beqz       $v0, .L80066948
    /* 57084 80066884 00000000 */   nop
    /* 57088 80066888 2F00C013 */  beqz       $fp, .L80066948
    /* 5708C 8006688C 00000000 */   nop
    /* 57090 80066890 1480043C */  lui        $a0, %hi(triggerManagerTraffic)
    /* 57094 80066894 ECC5848C */  lw         $a0, %lo(triggerManagerTraffic)($a0)
    /* 57098 80066898 5402A58E */  lw         $a1, 0x254($s5)
    /* 5709C 8006689C C9CA010C */  jal        CheckForTriggerAtSlice__24AITrigger_TriggerManagerii
    /* 570A0 800668A0 21302002 */   addu      $a2, $s1, $zero
    /* 570A4 800668A4 21984000 */  addu       $s3, $v0, $zero
    /* 570A8 800668A8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 570AC 800668AC 24006212 */  beq        $s3, $v0, .L80066940
    /* 570B0 800668B0 80281600 */   sll       $a1, $s6, 2
    /* 570B4 800668B4 0200A104 */  bgez       $a1, .L800668C0
    /* 570B8 800668B8 00000000 */   nop
    /* 570BC 800668BC FFFFA534 */  ori        $a1, $a1, 0xFFFF
  .L800668C0:
    /* 570C0 800668C0 1480033C */  lui        $v1, %hi(fastRandom)
    /* 570C4 800668C4 FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 570C8 800668C8 1480023C */  lui        $v0, %hi(randSeed)
    /* 570CC 800668CC 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 570D0 800668D0 00000000 */  nop
    /* 570D4 800668D4 18006200 */  mult       $v1, $v0
    /* 570D8 800668D8 21202002 */  addu       $a0, $s1, $zero
    /* 570DC 800668DC 03940500 */  sra        $s2, $a1, 16
    /* 570E0 800668E0 12180000 */  mflo       $v1
    /* 570E4 800668E4 FFFF6230 */  andi       $v0, $v1, 0xFFFF
    /* 570E8 800668E8 1480013C */  lui        $at, %hi(randtemp)
    /* 570EC 800668EC 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 570F0 800668F0 021A0300 */  srl        $v1, $v1, 8
    /* 570F4 800668F4 FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* 570F8 800668F8 1480013C */  lui        $at, %hi(fastRandom)
    /* 570FC 800668FC FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 57100 80066900 40100300 */  sll        $v0, $v1, 1
    /* 57104 80066904 21104300 */  addu       $v0, $v0, $v1
    /* 57108 80066908 C0100200 */  sll        $v0, $v0, 3
    /* 5710C 8006690C 21104300 */  addu       $v0, $v0, $v1
    /* 57110 80066910 03A2010C */  jal        AILife_IsSliceInAnyVisibleArea__Fi
    /* 57114 80066914 82830200 */   srl       $s0, $v0, 14
    /* 57118 80066918 09004014 */  bnez       $v0, .L80066940
    /* 5711C 8006691C 2A101202 */   slt       $v0, $s0, $s2
    /* 57120 80066920 07004010 */  beqz       $v0, .L80066940
    /* 57124 80066924 21286002 */   addu      $a1, $s3, $zero
    /* 57128 80066928 1480043C */  lui        $a0, %hi(triggerManagerTraffic)
    /* 5712C 8006692C ECC5848C */  lw         $a0, %lo(triggerManagerTraffic)($a0)
    /* 57130 80066930 36CB010C */  jal        GetTrigger__24AITrigger_TriggerManageriPi
    /* 57134 80066934 1000A627 */   addiu     $a2, $sp, 0x10
    /* 57138 80066938 579A0108 */  j          .L8006695C
    /* 5713C 8006693C 00000000 */   nop
  .L80066940:
    /* 57140 80066940 1F9A0108 */  j          .L8006687C
    /* 57144 80066944 01003126 */   addiu     $s1, $s1, 0x1
  .L80066948:
    /* 57148 80066948 1400A88F */  lw         $t0, 0x14($sp)
  .L8006694C:
    /* 5714C 8006694C FFFFF726 */  addiu      $s7, $s7, -0x1
    /* 57150 80066950 FCFF0825 */  addiu      $t0, $t0, -0x4
    /* 57154 80066954 E1990108 */  j          .L80066784
    /* 57158 80066958 1400A8AF */   sw        $t0, 0x14($sp)
  .L8006695C:
    /* 5715C 8006695C 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* 57160 80066960 3800BE8F */  lw         $fp, 0x38($sp)
    /* 57164 80066964 3400B78F */  lw         $s7, 0x34($sp)
    /* 57168 80066968 3000B68F */  lw         $s6, 0x30($sp)
    /* 5716C 8006696C 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 57170 80066970 2800B48F */  lw         $s4, 0x28($sp)
    /* 57174 80066974 2400B38F */  lw         $s3, 0x24($sp)
    /* 57178 80066978 2000B28F */  lw         $s2, 0x20($sp)
    /* 5717C 8006697C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 57180 80066980 1800B08F */  lw         $s0, 0x18($sp)
    /* 57184 80066984 0800E003 */  jr         $ra
    /* 57188 80066988 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel CheckForNewTriggers__14AIHigh_Traffic
