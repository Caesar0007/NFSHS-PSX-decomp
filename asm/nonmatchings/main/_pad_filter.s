.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _pad_filter, 0x27C

glabel _pad_filter
    /* EE8B0 800FE0B0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EE8B4 800FE0B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* EE8B8 800FE0B8 21808000 */  addu       $s0, $a0, $zero
    /* EE8BC 800FE0BC 57000426 */  addiu      $a0, $s0, 0x57
    /* EE8C0 800FE0C0 1400BFAF */  sw         $ra, 0x14($sp)
    /* EE8C4 800FE0C4 5029040C */  jal        bzero
    /* EE8C8 800FE0C8 06000524 */   addiu     $a1, $zero, 0x6
    /* EE8CC 800FE0CC E6000296 */  lhu        $v0, 0xE6($s0)
    /* EE8D0 800FE0D0 00000000 */  nop
    /* EE8D4 800FE0D4 54004010 */  beqz       $v0, .L800FE228
    /* EE8D8 800FE0D8 00000000 */   nop
    /* EE8DC 800FE0DC 2800028E */  lw         $v0, 0x28($s0)
    /* EE8E0 800FE0E0 00000000 */  nop
    /* EE8E4 800FE0E4 50004010 */  beqz       $v0, .L800FE228
    /* EE8E8 800FE0E8 00000000 */   nop
    /* EE8EC 800FE0EC 34000292 */  lbu        $v0, 0x34($s0)
    /* EE8F0 800FE0F0 00000000 */  nop
    /* EE8F4 800FE0F4 0700422C */  sltiu      $v0, $v0, 0x7
    /* EE8F8 800FE0F8 02004010 */  beqz       $v0, .L800FE104
    /* EE8FC 800FE0FC 06000924 */   addiu     $t1, $zero, 0x6
    /* EE900 800FE100 34000992 */  lbu        $t1, 0x34($s0)
  .L800FE104:
    /* EE904 800FE104 E9000292 */  lbu        $v0, 0xE9($s0)
    /* EE908 800FE108 00000000 */  nop
    /* EE90C 800FE10C 83004010 */  beqz       $v0, .L800FE31C
    /* EE910 800FE110 21400000 */   addu      $t0, $zero, $zero
    /* EE914 800FE114 01000B24 */  addiu      $t3, $zero, 0x1
    /* EE918 800FE118 21500000 */  addu       $t2, $zero, $zero
  .L800FE11C:
    /* EE91C 800FE11C 0400028E */  lw         $v0, 0x4($s0)
    /* EE920 800FE120 21300000 */  addu       $a2, $zero, $zero
    /* EE924 800FE124 21104201 */  addu       $v0, $t2, $v0
    /* EE928 800FE128 02004290 */  lbu        $v0, 0x2($v0)
    /* EE92C 800FE12C 00000000 */  nop
    /* EE930 800FE130 02004010 */  beqz       $v0, .L800FE13C
    /* EE934 800FE134 01000724 */   addiu     $a3, $zero, 0x1
    /* EE938 800FE138 FF000724 */  addiu      $a3, $zero, 0xFF
  .L800FE13C:
    /* EE93C 800FE13C 5D000526 */  addiu      $a1, $s0, 0x5D
    /* EE940 800FE140 2800048E */  lw         $a0, 0x28($s0)
    /* EE944 800FE144 0F002011 */  beqz       $t1, .L800FE184
    /* EE948 800FE148 21180000 */   addu      $v1, $zero, $zero
  .L800FE14C:
    /* EE94C 800FE14C 0000A290 */  lbu        $v0, 0x0($a1)
    /* EE950 800FE150 00000000 */  nop
    /* EE954 800FE154 06004814 */  bne        $v0, $t0, .L800FE170
    /* EE958 800FE158 00000000 */   nop
    /* EE95C 800FE15C 00008290 */  lbu        $v0, 0x0($a0)
    /* EE960 800FE160 00000000 */  nop
    /* EE964 800FE164 24104700 */  and        $v0, $v0, $a3
    /* EE968 800FE168 16004014 */  bnez       $v0, .L800FE1C4
    /* EE96C 800FE16C 00000000 */   nop
  .L800FE170:
    /* EE970 800FE170 0100A524 */  addiu      $a1, $a1, 0x1
    /* EE974 800FE174 01006324 */  addiu      $v1, $v1, 0x1
    /* EE978 800FE178 2A106900 */  slt        $v0, $v1, $t1
    /* EE97C 800FE17C F3FF4014 */  bnez       $v0, .L800FE14C
    /* EE980 800FE180 01008424 */   addiu     $a0, $a0, 0x1
  .L800FE184:
    /* EE984 800FE184 2100C010 */  beqz       $a2, .L800FE20C
    /* EE988 800FE188 00000000 */   nop
    /* EE98C 800FE18C 0400028E */  lw         $v0, 0x4($s0)
    /* EE990 800FE190 00000000 */  nop
    /* EE994 800FE194 21104201 */  addu       $v0, $t2, $v0
    /* EE998 800FE198 03004390 */  lbu        $v1, 0x3($v0)
    /* EE99C 800FE19C 1380023C */  lui        $v0, %hi(_padTotalCurr)
    /* EE9A0 800FE1A0 C07C428C */  lw         $v0, %lo(_padTotalCurr)($v0)
    /* EE9A4 800FE1A4 00000000 */  nop
    /* EE9A8 800FE1A8 21184300 */  addu       $v1, $v0, $v1
    /* EE9AC 800FE1AC 3D006228 */  slti       $v0, $v1, 0x3D
    /* EE9B0 800FE1B0 06004010 */  beqz       $v0, .L800FE1CC
    /* EE9B4 800FE1B4 00000000 */   nop
    /* EE9B8 800FE1B8 1380013C */  lui        $at, %hi(_padTotalCurr)
    /* EE9BC 800FE1BC 74F80308 */  j          .L800FE1D0
    /* EE9C0 800FE1C0 C07C23AC */   sw        $v1, %lo(_padTotalCurr)($at)
  .L800FE1C4:
    /* EE9C4 800FE1C4 61F80308 */  j          .L800FE184
    /* EE9C8 800FE1C8 01000624 */   addiu     $a2, $zero, 0x1
  .L800FE1CC:
    /* EE9CC 800FE1CC 21300000 */  addu       $a2, $zero, $zero
  .L800FE1D0:
    /* EE9D0 800FE1D0 0E00C010 */  beqz       $a2, .L800FE20C
    /* EE9D4 800FE1D4 00000000 */   nop
    /* EE9D8 800FE1D8 5D000526 */  addiu      $a1, $s0, 0x5D
    /* EE9DC 800FE1DC 57000426 */  addiu      $a0, $s0, 0x57
    /* EE9E0 800FE1E0 0A002011 */  beqz       $t1, .L800FE20C
    /* EE9E4 800FE1E4 21180000 */   addu      $v1, $zero, $zero
  .L800FE1E8:
    /* EE9E8 800FE1E8 0000A290 */  lbu        $v0, 0x0($a1)
    /* EE9EC 800FE1EC 00000000 */  nop
    /* EE9F0 800FE1F0 02004814 */  bne        $v0, $t0, .L800FE1FC
    /* EE9F4 800FE1F4 0100A524 */   addiu     $a1, $a1, 0x1
    /* EE9F8 800FE1F8 00008BA0 */  sb         $t3, 0x0($a0)
  .L800FE1FC:
    /* EE9FC 800FE1FC 01006324 */  addiu      $v1, $v1, 0x1
    /* EEA00 800FE200 2A106900 */  slt        $v0, $v1, $t1
    /* EEA04 800FE204 F8FF4014 */  bnez       $v0, .L800FE1E8
    /* EEA08 800FE208 01008424 */   addiu     $a0, $a0, 0x1
  .L800FE20C:
    /* EEA0C 800FE20C E9000292 */  lbu        $v0, 0xE9($s0)
    /* EEA10 800FE210 01000825 */  addiu      $t0, $t0, 0x1
    /* EEA14 800FE214 2A100201 */  slt        $v0, $t0, $v0
    /* EEA18 800FE218 C0FF4014 */  bnez       $v0, .L800FE11C
    /* EEA1C 800FE21C 05004A25 */   addiu     $t2, $t2, 0x5
    /* EEA20 800FE220 C7F80308 */  j          .L800FE31C
    /* EEA24 800FE224 00000000 */   nop
  .L800FE228:
    /* EEA28 800FE228 E8000392 */  lbu        $v1, 0xE8($s0)
    /* EEA2C 800FE22C 00000000 */  nop
    /* EEA30 800FE230 FCFF6224 */  addiu      $v0, $v1, -0x4
    /* EEA34 800FE234 0200422C */  sltiu      $v0, $v0, 0x2
    /* EEA38 800FE238 03004014 */  bnez       $v0, .L800FE248
    /* EEA3C 800FE23C 07000224 */   addiu     $v0, $zero, 0x7
    /* EEA40 800FE240 26006214 */  bne        $v1, $v0, .L800FE2DC
    /* EEA44 800FE244 00000000 */   nop
  .L800FE248:
    /* EEA48 800FE248 E6000296 */  lhu        $v0, 0xE6($s0)
    /* EEA4C 800FE24C 00000000 */  nop
    /* EEA50 800FE250 22004014 */  bnez       $v0, .L800FE2DC
    /* EEA54 800FE254 00000000 */   nop
    /* EEA58 800FE258 34000292 */  lbu        $v0, 0x34($s0)
    /* EEA5C 800FE25C 00000000 */  nop
    /* EEA60 800FE260 0200422C */  sltiu      $v0, $v0, 0x2
    /* EEA64 800FE264 1D004014 */  bnez       $v0, .L800FE2DC
    /* EEA68 800FE268 40000324 */   addiu     $v1, $zero, 0x40
    /* EEA6C 800FE26C 2800048E */  lw         $a0, 0x28($s0)
    /* EEA70 800FE270 00000000 */  nop
    /* EEA74 800FE274 00008290 */  lbu        $v0, 0x0($a0)
    /* EEA78 800FE278 00000000 */  nop
    /* EEA7C 800FE27C C0004230 */  andi       $v0, $v0, 0xC0
    /* EEA80 800FE280 26004314 */  bne        $v0, $v1, .L800FE31C
    /* EEA84 800FE284 00000000 */   nop
    /* EEA88 800FE288 01008290 */  lbu        $v0, 0x1($a0)
    /* EEA8C 800FE28C 00000000 */  nop
    /* EEA90 800FE290 01004230 */  andi       $v0, $v0, 0x1
    /* EEA94 800FE294 21004010 */  beqz       $v0, .L800FE31C
    /* EEA98 800FE298 00000000 */   nop
    /* EEA9C 800FE29C 1380023C */  lui        $v0, %hi(_padTotalCurr)
    /* EEAA0 800FE2A0 C07C428C */  lw         $v0, %lo(_padTotalCurr)($v0)
    /* EEAA4 800FE2A4 00000000 */  nop
    /* EEAA8 800FE2A8 0A004224 */  addiu      $v0, $v0, 0xA
    /* EEAAC 800FE2AC 3D004228 */  slti       $v0, $v0, 0x3D
    /* EEAB0 800FE2B0 1A004010 */  beqz       $v0, .L800FE31C
    /* EEAB4 800FE2B4 01000224 */   addiu     $v0, $zero, 0x1
    /* EEAB8 800FE2B8 580002A2 */  sb         $v0, 0x58($s0)
    /* EEABC 800FE2BC 570002A2 */  sb         $v0, 0x57($s0)
    /* EEAC0 800FE2C0 1380023C */  lui        $v0, %hi(_padTotalCurr)
    /* EEAC4 800FE2C4 C07C428C */  lw         $v0, %lo(_padTotalCurr)($v0)
    /* EEAC8 800FE2C8 00000000 */  nop
    /* EEACC 800FE2CC 0A004224 */  addiu      $v0, $v0, 0xA
    /* EEAD0 800FE2D0 1380013C */  lui        $at, %hi(_padTotalCurr)
    /* EEAD4 800FE2D4 C7F80308 */  j          .L800FE31C
    /* EEAD8 800FE2D8 C07C22AC */   sw        $v0, %lo(_padTotalCurr)($at)
  .L800FE2DC:
    /* EEADC 800FE2DC E8000392 */  lbu        $v1, 0xE8($s0)
    /* EEAE0 800FE2E0 03000224 */  addiu      $v0, $zero, 0x3
    /* EEAE4 800FE2E4 03006214 */  bne        $v1, $v0, .L800FE2F4
    /* EEAE8 800FE2E8 01000224 */   addiu     $v0, $zero, 0x1
    /* EEAEC 800FE2EC C7F80308 */  j          .L800FE31C
    /* EEAF0 800FE2F0 570002A2 */   sb        $v0, 0x57($s0)
  .L800FE2F4:
    /* EEAF4 800FE2F4 E6000296 */  lhu        $v0, 0xE6($s0)
    /* EEAF8 800FE2F8 00000000 */  nop
    /* EEAFC 800FE2FC 07004014 */  bnez       $v0, .L800FE31C
    /* EEB00 800FE300 01000224 */   addiu     $v0, $zero, 0x1
    /* EEB04 800FE304 05000324 */  addiu      $v1, $zero, 0x5
    /* EEB08 800FE308 05000426 */  addiu      $a0, $s0, 0x5
  .L800FE30C:
    /* EEB0C 800FE30C 570082A0 */  sb         $v0, 0x57($a0)
    /* EEB10 800FE310 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* EEB14 800FE314 FDFF6104 */  bgez       $v1, .L800FE30C
    /* EEB18 800FE318 FFFF8424 */   addiu     $a0, $a0, -0x1
  .L800FE31C:
    /* EEB1C 800FE31C 1400BF8F */  lw         $ra, 0x14($sp)
    /* EEB20 800FE320 1000B08F */  lw         $s0, 0x10($sp)
    /* EEB24 800FE324 0800E003 */  jr         $ra
    /* EEB28 800FE328 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _pad_filter
