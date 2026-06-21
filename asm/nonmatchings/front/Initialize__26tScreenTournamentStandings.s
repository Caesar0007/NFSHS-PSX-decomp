.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__26tScreenTournamentStandings, 0x18C

glabel Initialize__26tScreenTournamentStandings
    /* 2A160 80039960 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* 2A164 80039964 5800B0AF */  sw         $s0, 0x58($sp)
    /* 2A168 80039968 21808000 */  addu       $s0, $a0, $zero
    /* 2A16C 8003996C 6000BFAF */  sw         $ra, 0x60($sp)
    /* 2A170 80039970 2B98000C */  jal        Initialize__7tScreen
    /* 2A174 80039974 5C00B1AF */   sw        $s1, 0x5C($sp)
    /* 2A178 80039978 1180023C */  lui        $v0, %hi(tournamentManager)
    /* 2A17C 8003997C D84A5124 */  addiu      $s1, $v0, %lo(tournamentManager)
    /* 2A180 80039980 21202002 */  addu       $a0, $s1, $zero
    /* 2A184 80039984 35CE000C */  jal        GetAwardInformation__18tTournamentManagerR17tAwardInformation
    /* 2A188 80039988 1000A527 */   addiu     $a1, $sp, 0x10
    /* 2A18C 8003998C 8400028E */  lw         $v0, 0x84($s0)
    /* 2A190 80039990 780000AE */  sw         $zero, 0x78($s0)
    /* 2A194 80039994 7C0000AE */  sw         $zero, 0x7C($s0)
    /* 2A198 80039998 46004010 */  beqz       $v0, .L80039AB4
    /* 2A19C 8003999C 800000AE */   sw        $zero, 0x80($s0)
    /* 2A1A0 800399A0 1000A28F */  lw         $v0, 0x10($sp)
    /* 2A1A4 800399A4 00000000 */  nop
    /* 2A1A8 800399A8 02004010 */  beqz       $v0, .L800399B4
    /* 2A1AC 800399AC 01000224 */   addiu     $v0, $zero, 0x1
    /* 2A1B0 800399B0 780002AE */  sw         $v0, 0x78($s0)
  .L800399B4:
    /* 2A1B4 800399B4 1400228E */  lw         $v0, 0x14($s1)
    /* 2A1B8 800399B8 1400A38F */  lw         $v1, 0x14($sp)
    /* 2A1BC 800399BC 00000000 */  nop
    /* 2A1C0 800399C0 23184300 */  subu       $v1, $v0, $v1
    /* 2A1C4 800399C4 640003AE */  sw         $v1, 0x64($s0)
    /* 2A1C8 800399C8 4C00A28F */  lw         $v0, 0x4C($sp)
    /* 2A1CC 800399CC 00000000 */  nop
    /* 2A1D0 800399D0 05004010 */  beqz       $v0, .L800399E8
    /* 2A1D4 800399D4 21202002 */   addu      $a0, $s1, $zero
    /* 2A1D8 800399D8 5000A28F */  lw         $v0, 0x50($sp)
    /* 2A1DC 800399DC 00000000 */  nop
    /* 2A1E0 800399E0 23106200 */  subu       $v0, $v1, $v0
    /* 2A1E4 800399E4 640002AE */  sw         $v0, 0x64($s0)
  .L800399E8:
    /* 2A1E8 800399E8 21280000 */  addu       $a1, $zero, $zero
    /* 2A1EC 800399EC 6C000626 */  addiu      $a2, $s0, 0x6C
    /* 2A1F0 800399F0 1000A28F */  lw         $v0, 0x10($sp)
    /* 2A1F4 800399F4 70000726 */  addiu      $a3, $s0, 0x70
    /* 2A1F8 800399F8 1BCB000C */  jal        CalcTrackFinishDamageBill__18tTournamentManagerbRlT2
    /* 2A1FC 800399FC 680002AE */   sw        $v0, 0x68($s0)
    /* 2A200 80039A00 7000028E */  lw         $v0, 0x70($s0)
    /* 2A204 80039A04 00000000 */  nop
    /* 2A208 80039A08 02004018 */  blez       $v0, .L80039A14
    /* 2A20C 80039A0C 01000224 */   addiu     $v0, $zero, 0x1
    /* 2A210 80039A10 7C0002AE */  sw         $v0, 0x7C($s0)
  .L80039A14:
    /* 2A214 80039A14 6C00028E */  lw         $v0, 0x6C($s0)
    /* 2A218 80039A18 00000000 */  nop
    /* 2A21C 80039A1C 02004018 */  blez       $v0, .L80039A28
    /* 2A220 80039A20 01000224 */   addiu     $v0, $zero, 0x1
    /* 2A224 80039A24 800002AE */  sw         $v0, 0x80($s0)
  .L80039A28:
    /* 2A228 80039A28 7000028E */  lw         $v0, 0x70($s0)
    /* 2A22C 80039A2C 00000000 */  nop
    /* 2A230 80039A30 0A004014 */  bnez       $v0, .L80039A5C
    /* 2A234 80039A34 880000AE */   sw        $zero, 0x88($s0)
    /* 2A238 80039A38 6C00028E */  lw         $v0, 0x6C($s0)
    /* 2A23C 80039A3C 00000000 */  nop
    /* 2A240 80039A40 06004014 */  bnez       $v0, .L80039A5C
    /* 2A244 80039A44 00000000 */   nop
    /* 2A248 80039A48 6800028E */  lw         $v0, 0x68($s0)
    /* 2A24C 80039A4C 00000000 */  nop
    /* 2A250 80039A50 02004014 */  bnez       $v0, .L80039A5C
    /* 2A254 80039A54 01000224 */   addiu     $v0, $zero, 0x1
    /* 2A258 80039A58 880002AE */  sw         $v0, 0x88($s0)
  .L80039A5C:
    /* 2A25C 80039A5C 7000048E */  lw         $a0, 0x70($s0)
    /* 2A260 80039A60 8C0000AE */  sw         $zero, 0x8C($s0)
    /* 2A264 80039A64 1000A38F */  lw         $v1, 0x10($sp)
    /* 2A268 80039A68 00000000 */  nop
    /* 2A26C 80039A6C 2A108300 */  slt        $v0, $a0, $v1
    /* 2A270 80039A70 02004010 */  beqz       $v0, .L80039A7C
    /* 2A274 80039A74 00000000 */   nop
    /* 2A278 80039A78 21206000 */  addu       $a0, $v1, $zero
  .L80039A7C:
    /* 2A27C 80039A7C 6C00038E */  lw         $v1, 0x6C($s0)
    /* 2A280 80039A80 00000000 */  nop
    /* 2A284 80039A84 2A106400 */  slt        $v0, $v1, $a0
    /* 2A288 80039A88 02004010 */  beqz       $v0, .L80039A94
    /* 2A28C 80039A8C AA2A023C */   lui       $v0, (0x2AAAAAAB >> 16)
    /* 2A290 80039A90 21188000 */  addu       $v1, $a0, $zero
  .L80039A94:
    /* 2A294 80039A94 ABAA4234 */  ori        $v0, $v0, (0x2AAAAAAB & 0xFFFF)
    /* 2A298 80039A98 18006200 */  mult       $v1, $v0
    /* 2A29C 80039A9C C31F0300 */  sra        $v1, $v1, 31
    /* 2A2A0 80039AA0 10400000 */  mfhi       $t0
    /* 2A2A4 80039AA4 83100800 */  sra        $v0, $t0, 2
    /* 2A2A8 80039AA8 23104300 */  subu       $v0, $v0, $v1
    /* 2A2AC 80039AAC B2E60008 */  j          .L80039AC8
    /* 2A2B0 80039AB0 900002AE */   sw        $v0, 0x90($s0)
  .L80039AB4:
    /* 2A2B4 80039AB4 1400228E */  lw         $v0, 0x14($s1)
    /* 2A2B8 80039AB8 1400A38F */  lw         $v1, 0x14($sp)
    /* 2A2BC 80039ABC 00000000 */  nop
    /* 2A2C0 80039AC0 23104300 */  subu       $v0, $v0, $v1
    /* 2A2C4 80039AC4 640002AE */  sw         $v0, 0x64($s0)
  .L80039AC8:
    /* 2A2C8 80039AC8 1480023C */  lui        $v0, %hi(ticks)
    /* 2A2CC 80039ACC ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2A2D0 80039AD0 00000000 */  nop
    /* 2A2D4 80039AD4 740002AE */  sw         $v0, 0x74($s0)
    /* 2A2D8 80039AD8 6000BF8F */  lw         $ra, 0x60($sp)
    /* 2A2DC 80039ADC 5C00B18F */  lw         $s1, 0x5C($sp)
    /* 2A2E0 80039AE0 5800B08F */  lw         $s0, 0x58($sp)
    /* 2A2E4 80039AE4 0800E003 */  jr         $ra
    /* 2A2E8 80039AE8 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel Initialize__26tScreenTournamentStandings
