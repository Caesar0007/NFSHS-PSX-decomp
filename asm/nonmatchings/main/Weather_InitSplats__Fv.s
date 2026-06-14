.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_InitSplats__Fv, 0x114

glabel Weather_InitSplats__Fv
    /* D27D8 800E1FD8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D27DC 800E1FDC 1800B2AF */  sw         $s2, 0x18($sp)
    /* D27E0 800E1FE0 21900000 */  addu       $s2, $zero, $zero
    /* D27E4 800E1FE4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* D27E8 800E1FE8 2000B4AF */  sw         $s4, 0x20($sp)
    /* D27EC 800E1FEC EC315424 */  addiu      $s4, $v0, %lo(GameSetup_gData)
    /* D27F0 800E1FF0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D27F4 800E1FF4 01001324 */  addiu      $s3, $zero, 0x1
    /* D27F8 800E1FF8 2400BFAF */  sw         $ra, 0x24($sp)
    /* D27FC 800E1FFC 1400B1AF */  sw         $s1, 0x14($sp)
    /* D2800 800E2000 1000B0AF */  sw         $s0, 0x10($sp)
  .L800E2004:
    /* D2804 800E2004 1300422A */  slti       $v0, $s2, 0x13
    /* D2808 800E2008 30004010 */  beqz       $v0, .L800E20CC
    /* D280C 800E200C 00000000 */   nop
    /* D2810 800E2010 0C00828E */  lw         $v0, 0xC($s4)
    /* D2814 800E2014 00000000 */  nop
    /* D2818 800E2018 02005314 */  bne        $v0, $s3, .L800E2024
    /* D281C 800E201C F0001124 */   addiu     $s1, $zero, 0xF0
    /* D2820 800E2020 78001124 */  addiu      $s1, $zero, 0x78
  .L800E2024:
    /* D2824 800E2024 EA9D030C */  jal        random
    /* D2828 800E2028 C0801200 */   sll       $s0, $s2, 3
    /* D282C 800E202C CCCC033C */  lui        $v1, (0xCCCCCCCD >> 16)
    /* D2830 800E2030 CDCC6334 */  ori        $v1, $v1, (0xCCCCCCCD & 0xFFFF)
    /* D2834 800E2034 19004300 */  multu      $v0, $v1
    /* D2838 800E2038 6016858F */  lw         $a1, %gp_rel(Weather_gSplatInfo)($gp)
    /* D283C 800E203C 00000000 */  nop
    /* D2840 800E2040 21280502 */  addu       $a1, $s0, $a1
    /* D2844 800E2044 10180000 */  mfhi       $v1
    /* D2848 800E2048 02220300 */  srl        $a0, $v1, 8
    /* D284C 800E204C 80180400 */  sll        $v1, $a0, 2
    /* D2850 800E2050 21186400 */  addu       $v1, $v1, $a0
    /* D2854 800E2054 80190300 */  sll        $v1, $v1, 6
    /* D2858 800E2058 23104300 */  subu       $v0, $v0, $v1
    /* D285C 800E205C EA9D030C */  jal        random
    /* D2860 800E2060 0000A2A4 */   sh        $v0, 0x0($a1)
    /* D2864 800E2064 1B005100 */  divu       $zero, $v0, $s1
    /* D2868 800E2068 02002016 */  bnez       $s1, .L800E2074
    /* D286C 800E206C 00000000 */   nop
    /* D2870 800E2070 0D000700 */  break      7
  .L800E2074:
    /* D2874 800E2074 10180000 */  mfhi       $v1
    /* D2878 800E2078 6016828F */  lw         $v0, %gp_rel(Weather_gSplatInfo)($gp)
    /* D287C 800E207C 00000000 */  nop
    /* D2880 800E2080 21100202 */  addu       $v0, $s0, $v0
    /* D2884 800E2084 EA9D030C */  jal        random
    /* D2888 800E2088 020043A4 */   sh        $v1, 0x2($v0)
    /* D288C 800E208C 4E1B033C */  lui        $v1, (0x1B4E81B5 >> 16)
    /* D2890 800E2090 B5816334 */  ori        $v1, $v1, (0x1B4E81B5 & 0xFFFF)
    /* D2894 800E2094 19004300 */  multu      $v0, $v1
    /* D2898 800E2098 6016838F */  lw         $v1, %gp_rel(Weather_gSplatInfo)($gp)
    /* D289C 800E209C 01005226 */  addiu      $s2, $s2, 0x1
    /* D28A0 800E20A0 21800302 */  addu       $s0, $s0, $v1
    /* D28A4 800E20A4 10200000 */  mfhi       $a0
    /* D28A8 800E20A8 42190400 */  srl        $v1, $a0, 5
    /* D28AC 800E20AC 80200300 */  sll        $a0, $v1, 2
    /* D28B0 800E20B0 21208300 */  addu       $a0, $a0, $v1
    /* D28B4 800E20B4 00190400 */  sll        $v1, $a0, 4
    /* D28B8 800E20B8 23186400 */  subu       $v1, $v1, $a0
    /* D28BC 800E20BC 80180300 */  sll        $v1, $v1, 2
    /* D28C0 800E20C0 23104300 */  subu       $v0, $v0, $v1
    /* D28C4 800E20C4 01880308 */  j          .L800E2004
    /* D28C8 800E20C8 040002AE */   sw        $v0, 0x4($s0)
  .L800E20CC:
    /* D28CC 800E20CC 2400BF8F */  lw         $ra, 0x24($sp)
    /* D28D0 800E20D0 2000B48F */  lw         $s4, 0x20($sp)
    /* D28D4 800E20D4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D28D8 800E20D8 1800B28F */  lw         $s2, 0x18($sp)
    /* D28DC 800E20DC 1400B18F */  lw         $s1, 0x14($sp)
    /* D28E0 800E20E0 1000B08F */  lw         $s0, 0x10($sp)
    /* D28E4 800E20E4 0800E003 */  jr         $ra
    /* D28E8 800E20E8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Weather_InitSplats__Fv
