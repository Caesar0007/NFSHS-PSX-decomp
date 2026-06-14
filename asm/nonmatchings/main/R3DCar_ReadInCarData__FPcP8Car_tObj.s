.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_ReadInCarData__FPcP8Car_tObj, 0x508

glabel R3DCar_ReadInCarData__FPcP8Car_tObj
    /* 9E8A8 800AE0A8 68FFBD27 */  addiu      $sp, $sp, -0x98
    /* 9E8AC 800AE0AC 21108000 */  addu       $v0, $a0, $zero
    /* 9E8B0 800AE0B0 7400B1AF */  sw         $s1, 0x74($sp)
    /* 9E8B4 800AE0B4 2188A000 */  addu       $s1, $a1, $zero
    /* 9E8B8 800AE0B8 1800A427 */  addiu      $a0, $sp, 0x18
    /* 9E8BC 800AE0BC 21284000 */  addu       $a1, $v0, $zero
    /* 9E8C0 800AE0C0 9400BFAF */  sw         $ra, 0x94($sp)
    /* 9E8C4 800AE0C4 9000BEAF */  sw         $fp, 0x90($sp)
    /* 9E8C8 800AE0C8 8C00B7AF */  sw         $s7, 0x8C($sp)
    /* 9E8CC 800AE0CC 8800B6AF */  sw         $s6, 0x88($sp)
    /* 9E8D0 800AE0D0 8400B5AF */  sw         $s5, 0x84($sp)
    /* 9E8D4 800AE0D4 8000B4AF */  sw         $s4, 0x80($sp)
    /* 9E8D8 800AE0D8 7C00B3AF */  sw         $s3, 0x7C($sp)
    /* 9E8DC 800AE0DC 7800B2AF */  sw         $s2, 0x78($sp)
    /* 9E8E0 800AE0E0 CA96030C */  jal        strcpy
    /* 9E8E4 800AE0E4 7000B0AF */   sw        $s0, 0x70($sp)
    /* 9E8E8 800AE0E8 1800A427 */  addiu      $a0, $sp, 0x18
    /* 9E8EC 800AE0EC 1480053C */  lui        $a1, %hi(D_8013D338)
    /* 9E8F0 800AE0F0 3A9E030C */  jal        strcat
    /* 9E8F4 800AE0F4 38D3A524 */   addiu     $a1, $a1, %lo(D_8013D338)
    /* 9E8F8 800AE0F8 1800A527 */  addiu      $a1, $sp, 0x18
    /* 9E8FC 800AE0FC 4C021224 */  addiu      $s2, $zero, 0x24C
    /* 9E900 800AE100 21A00000 */  addu       $s4, $zero, $zero
    /* 9E904 800AE104 2800A927 */  addiu      $t1, $sp, 0x28
    /* 9E908 800AE108 6000A9AF */  sw         $t1, 0x60($sp)
    /* 9E90C 800AE10C 3800A927 */  addiu      $t1, $sp, 0x38
    /* 9E910 800AE110 6400A9AF */  sw         $t1, 0x64($sp)
    /* 9E914 800AE114 077E093C */  lui        $t1, (0x7E07E07F >> 16)
    /* 9E918 800AE118 640E848F */  lw         $a0, %gp_rel(R3DCar_BigFile)($gp)
    /* 9E91C 800AE11C 7FE02935 */  ori        $t1, $t1, (0x7E07E07F & 0xFFFF)
    /* 9E920 800AE120 8698030C */  jal        locatebig
    /* 9E924 800AE124 6800A9AF */   sw        $t1, 0x68($sp)
    /* 9E928 800AE128 1800A527 */  addiu      $a1, $sp, 0x18
    /* 9E92C 800AE12C 21308002 */  addu       $a2, $s4, $zero
    /* 9E930 800AE130 4000A327 */  addiu      $v1, $sp, 0x40
    /* 9E934 800AE134 21804000 */  addu       $s0, $v0, $zero
    /* 9E938 800AE138 640E848F */  lw         $a0, %gp_rel(R3DCar_BigFile)($gp)
    /* 9E93C 800AE13C 21388002 */  addu       $a3, $s4, $zero
    /* 9E940 800AE140 6E98030C */  jal        locatebigentry
    /* 9E944 800AE144 1000A3AF */   sw        $v1, 0x10($sp)
    /* 9E948 800AE148 1800A427 */  addiu      $a0, $sp, 0x18
    /* 9E94C 800AE14C 4000A58F */  lw         $a1, 0x40($sp)
    /* 9E950 800AE150 CF94030C */  jal        reservememadr
    /* 9E954 800AE154 21308002 */   addu      $a2, $s4, $zero
    /* 9E958 800AE158 21200002 */  addu       $a0, $s0, $zero
    /* 9E95C 800AE15C 21A84000 */  addu       $s5, $v0, $zero
    /* 9E960 800AE160 4000A68F */  lw         $a2, 0x40($sp)
    /* 9E964 800AE164 2128A002 */  addu       $a1, $s5, $zero
    /* 9E968 800AE168 B798030C */  jal        blockmove
    /* 9E96C 800AE16C 4400B5AF */   sw        $s5, 0x44($sp)
    /* 9E970 800AE170 1180023C */  lui        $v0, %hi(R3DCar_EnvMapInfo)
    /* 9E974 800AE174 BC082986 */  lh         $t1, 0x8BC($s1)
    /* 9E978 800AE178 BC6D4224 */  addiu      $v0, $v0, %lo(R3DCar_EnvMapInfo)
    /* 9E97C 800AE17C 00190900 */  sll        $v1, $t1, 4
    /* 9E980 800AE180 21186200 */  addu       $v1, $v1, $v0
    /* 9E984 800AE184 4800A9AF */  sw         $t1, 0x48($sp)
    /* 9E988 800AE188 0000698C */  lw         $t1, 0x0($v1)
    /* 9E98C 800AE18C 1180043C */  lui        $a0, %hi(R3DCar_ObjectInfo)
    /* 9E990 800AE190 4C00A9AF */  sw         $t1, 0x4C($sp)
    /* 9E994 800AE194 0800628C */  lw         $v0, 0x8($v1)
    /* 9E998 800AE198 0400698C */  lw         $t1, 0x4($v1)
    /* 9E99C 800AE19C C0110200 */  sll        $v0, $v0, 7
    /* 9E9A0 800AE1A0 5000A9AF */  sw         $t1, 0x50($sp)
    /* 9E9A4 800AE1A4 D00822AE */  sw         $v0, 0x8D0($s1)
    /* 9E9A8 800AE1A8 0C00628C */  lw         $v0, 0xC($v1)
    /* 9E9AC 800AE1AC E0659624 */  addiu      $s6, $a0, %lo(R3DCar_ObjectInfo)
    /* 9E9B0 800AE1B0 C0110200 */  sll        $v0, $v0, 7
    /* 9E9B4 800AE1B4 D40822AE */  sw         $v0, 0x8D4($s1)
  .L800AE1B8:
    /* 9E9B8 800AE1B8 3900822A */  slti       $v0, $s4, 0x39
    /* 9E9BC 800AE1BC EF004010 */  beqz       $v0, .L800AE57C
    /* 9E9C0 800AE1C0 80101400 */   sll       $v0, $s4, 2
    /* 9E9C4 800AE1C4 2118B202 */  addu       $v1, $s5, $s2
    /* 9E9C8 800AE1C8 1C005226 */  addiu      $s2, $s2, 0x1C
    /* 9E9CC 800AE1CC 4400A98F */  lw         $t1, 0x44($sp)
    /* 9E9D0 800AE1D0 00000000 */  nop
    /* 9E9D4 800AE1D4 21102201 */  addu       $v0, $t1, $v0
    /* 9E9D8 800AE1D8 000043AC */  sw         $v1, 0x0($v0)
    /* 9E9DC 800AE1DC 27000224 */  addiu      $v0, $zero, 0x27
    /* 9E9E0 800AE1E0 05008216 */  bne        $s4, $v0, .L800AE1F8
    /* 9E9E4 800AE1E4 21806000 */   addu      $s0, $v1, $zero
    /* 9E9E8 800AE1E8 0400028E */  lw         $v0, 0x4($s0)
    /* 9E9EC 800AE1EC 00000000 */  nop
    /* 9E9F0 800AE1F0 52F84224 */  addiu      $v0, $v0, -0x7AE
    /* 9E9F4 800AE1F4 040002AE */  sw         $v0, 0x4($s0)
  .L800AE1F8:
    /* 9E9F8 800AE1F8 28000224 */  addiu      $v0, $zero, 0x28
    /* 9E9FC 800AE1FC 05008216 */  bne        $s4, $v0, .L800AE214
    /* 9EA00 800AE200 00000000 */   nop
    /* 9EA04 800AE204 0400028E */  lw         $v0, 0x4($s0)
    /* 9EA08 800AE208 00000000 */  nop
    /* 9EA0C 800AE20C AE074224 */  addiu      $v0, $v0, 0x7AE
    /* 9EA10 800AE210 040002AE */  sw         $v0, 0x4($s0)
  .L800AE214:
    /* 9EA14 800AE214 00000296 */  lhu        $v0, 0x0($s0)
    /* 9EA18 800AE218 00000000 */  nop
    /* 9EA1C 800AE21C CA004010 */  beqz       $v0, .L800AE548
    /* 9EA20 800AE220 21184000 */   addu      $v1, $v0, $zero
    /* 9EA24 800AE224 2110B202 */  addu       $v0, $s5, $s2
    /* 9EA28 800AE228 100002AE */  sw         $v0, 0x10($s0)
    /* 9EA2C 800AE22C 40100300 */  sll        $v0, $v1, 1
    /* 9EA30 800AE230 21104300 */  addu       $v0, $v0, $v1
    /* 9EA34 800AE234 40100200 */  sll        $v0, $v0, 1
    /* 9EA38 800AE238 21904202 */  addu       $s2, $s2, $v0
    /* 9EA3C 800AE23C 21106000 */  addu       $v0, $v1, $zero
    /* 9EA40 800AE240 01006330 */  andi       $v1, $v1, 0x1
    /* 9EA44 800AE244 02006010 */  beqz       $v1, .L800AE250
    /* 9EA48 800AE248 00000000 */   nop
    /* 9EA4C 800AE24C 02005226 */  addiu      $s2, $s2, 0x2
  .L800AE250:
    /* 9EA50 800AE250 BD004010 */  beqz       $v0, .L800AE548
    /* 9EA54 800AE254 00000000 */   nop
    /* 9EA58 800AE258 0100C292 */  lbu        $v0, 0x1($s6)
    /* 9EA5C 800AE25C 00000000 */  nop
    /* 9EA60 800AE260 01004230 */  andi       $v0, $v0, 0x1
    /* 9EA64 800AE264 B8004010 */  beqz       $v0, .L800AE548
    /* 9EA68 800AE268 00000000 */   nop
    /* 9EA6C 800AE26C 4800A98F */  lw         $t1, 0x48($sp)
    /* 9EA70 800AE270 00000000 */  nop
    /* 9EA74 800AE274 1C002229 */  slti       $v0, $t1, 0x1C
    /* 9EA78 800AE278 B3004010 */  beqz       $v0, .L800AE548
    /* 9EA7C 800AE27C 2110B202 */   addu      $v0, $s5, $s2
    /* 9EA80 800AE280 00000396 */  lhu        $v1, 0x0($s0)
    /* 9EA84 800AE284 140002AE */  sw         $v0, 0x14($s0)
    /* 9EA88 800AE288 40100300 */  sll        $v0, $v1, 1
    /* 9EA8C 800AE28C 21104300 */  addu       $v0, $v0, $v1
    /* 9EA90 800AE290 40100200 */  sll        $v0, $v0, 1
    /* 9EA94 800AE294 01006330 */  andi       $v1, $v1, 0x1
    /* 9EA98 800AE298 02006010 */  beqz       $v1, .L800AE2A4
    /* 9EA9C 800AE29C 21904202 */   addu      $s2, $s2, $v0
    /* 9EAA0 800AE2A0 02005226 */  addiu      $s2, $s2, 0x2
  .L800AE2A4:
    /* 9EAA4 800AE2A4 21980000 */  addu       $s3, $zero, $zero
    /* 9EAA8 800AE2A8 0400028E */  lw         $v0, 0x4($s0)
    /* 9EAAC 800AE2AC 21886002 */  addu       $s1, $s3, $zero
    /* 9EAB0 800AE2B0 02120200 */  srl        $v0, $v0, 8
    /* 9EAB4 800AE2B4 5800A2A7 */  sh         $v0, 0x58($sp)
    /* 9EAB8 800AE2B8 0800028E */  lw         $v0, 0x8($s0)
    /* 9EABC 800AE2BC 0C00038E */  lw         $v1, 0xC($s0)
    /* 9EAC0 800AE2C0 02F20200 */  srl        $fp, $v0, 8
    /* 9EAC4 800AE2C4 02BA0300 */  srl        $s7, $v1, 8
  .L800AE2C8:
    /* 9EAC8 800AE2C8 00000296 */  lhu        $v0, 0x0($s0)
    /* 9EACC 800AE2CC 00000000 */  nop
    /* 9EAD0 800AE2D0 2A106202 */  slt        $v0, $s3, $v0
    /* 9EAD4 800AE2D4 9C004010 */  beqz       $v0, .L800AE548
    /* 9EAD8 800AE2D8 00000000 */   nop
    /* 9EADC 800AE2DC 1000028E */  lw         $v0, 0x10($s0)
    /* 9EAE0 800AE2E0 5800A997 */  lhu        $t1, 0x58($sp)
    /* 9EAE4 800AE2E4 6000A48F */  lw         $a0, 0x60($sp)
    /* 9EAE8 800AE2E8 6400A58F */  lw         $a1, 0x64($sp)
    /* 9EAEC 800AE2EC 21102202 */  addu       $v0, $s1, $v0
    /* 9EAF0 800AE2F0 001C0900 */  sll        $v1, $t1, 16
    /* 9EAF4 800AE2F4 00004284 */  lh         $v0, 0x0($v0)
    /* 9EAF8 800AE2F8 031C0300 */  sra        $v1, $v1, 16
    /* 9EAFC 800AE2FC 21104300 */  addu       $v0, $v0, $v1
    /* 9EB00 800AE300 2800A2AF */  sw         $v0, 0x28($sp)
    /* 9EB04 800AE304 1000038E */  lw         $v1, 0x10($s0)
    /* 9EB08 800AE308 00141E00 */  sll        $v0, $fp, 16
    /* 9EB0C 800AE30C 21182302 */  addu       $v1, $s1, $v1
    /* 9EB10 800AE310 02006384 */  lh         $v1, 0x2($v1)
    /* 9EB14 800AE314 03140200 */  sra        $v0, $v0, 16
    /* 9EB18 800AE318 21186200 */  addu       $v1, $v1, $v0
    /* 9EB1C 800AE31C 2C00A3AF */  sw         $v1, 0x2C($sp)
    /* 9EB20 800AE320 1000028E */  lw         $v0, 0x10($s0)
    /* 9EB24 800AE324 001C1700 */  sll        $v1, $s7, 16
    /* 9EB28 800AE328 21102202 */  addu       $v0, $s1, $v0
    /* 9EB2C 800AE32C 04004284 */  lh         $v0, 0x4($v0)
    /* 9EB30 800AE330 031C0300 */  sra        $v1, $v1, 16
    /* 9EB34 800AE334 21104300 */  addu       $v0, $v0, $v1
    /* 9EB38 800AE338 83100200 */  sra        $v0, $v0, 2
    /* 9EB3C 800AE33C B2C6030C */  jal        VectorNormalS
    /* 9EB40 800AE340 3000A2AF */   sw        $v0, 0x30($sp)
    /* 9EB44 800AE344 0100C292 */  lbu        $v0, 0x1($s6)
    /* 9EB48 800AE348 00000000 */  nop
    /* 9EB4C 800AE34C 40004230 */  andi       $v0, $v0, 0x40
    /* 9EB50 800AE350 1A004010 */  beqz       $v0, .L800AE3BC
    /* 9EB54 800AE354 00000000 */   nop
    /* 9EB58 800AE358 1400028E */  lw         $v0, 0x14($s0)
    /* 9EB5C 800AE35C 6000A48F */  lw         $a0, 0x60($sp)
    /* 9EB60 800AE360 6400A58F */  lw         $a1, 0x64($sp)
    /* 9EB64 800AE364 21102202 */  addu       $v0, $s1, $v0
    /* 9EB68 800AE368 00004784 */  lh         $a3, 0x0($v0)
    /* 9EB6C 800AE36C 00000000 */  nop
    /* 9EB70 800AE370 2800A7AF */  sw         $a3, 0x28($sp)
    /* 9EB74 800AE374 1400028E */  lw         $v0, 0x14($s0)
    /* 9EB78 800AE378 3800A387 */  lh         $v1, 0x38($sp)
    /* 9EB7C 800AE37C 21102202 */  addu       $v0, $s1, $v0
    /* 9EB80 800AE380 02004884 */  lh         $t0, 0x2($v0)
    /* 9EB84 800AE384 2138E300 */  addu       $a3, $a3, $v1
    /* 9EB88 800AE388 2C00A8AF */  sw         $t0, 0x2C($sp)
    /* 9EB8C 800AE38C 1400028E */  lw         $v0, 0x14($s0)
    /* 9EB90 800AE390 3C00A387 */  lh         $v1, 0x3C($sp)
    /* 9EB94 800AE394 21102202 */  addu       $v0, $s1, $v0
    /* 9EB98 800AE398 04004684 */  lh         $a2, 0x4($v0)
    /* 9EB9C 800AE39C 3A00A287 */  lh         $v0, 0x3A($sp)
    /* 9EBA0 800AE3A0 2800A7AF */  sw         $a3, 0x28($sp)
    /* 9EBA4 800AE3A4 21400201 */  addu       $t0, $t0, $v0
    /* 9EBA8 800AE3A8 3000A6AF */  sw         $a2, 0x30($sp)
    /* 9EBAC 800AE3AC 2130C300 */  addu       $a2, $a2, $v1
    /* 9EBB0 800AE3B0 2C00A8AF */  sw         $t0, 0x2C($sp)
    /* 9EBB4 800AE3B4 B2C6030C */  jal        VectorNormalS
    /* 9EBB8 800AE3B8 3000A6AF */   sw        $a2, 0x30($sp)
  .L800AE3BC:
    /* 9EBBC 800AE3BC 3800A497 */  lhu        $a0, 0x38($sp)
    /* 9EBC0 800AE3C0 4C00A98F */  lw         $t1, 0x4C($sp)
    /* 9EBC4 800AE3C4 00240400 */  sll        $a0, $a0, 16
    /* 9EBC8 800AE3C8 03140400 */  sra        $v0, $a0, 16
    /* 9EBCC 800AE3CC 1A004900 */  div        $zero, $v0, $t1
    /* 9EBD0 800AE3D0 02002015 */  bnez       $t1, .L800AE3DC
    /* 9EBD4 800AE3D4 00000000 */   nop
    /* 9EBD8 800AE3D8 0D000700 */  break      7
  .L800AE3DC:
    /* 9EBDC 800AE3DC FFFF0124 */  addiu      $at, $zero, -0x1
    /* 9EBE0 800AE3E0 04002115 */  bne        $t1, $at, .L800AE3F4
    /* 9EBE4 800AE3E4 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 9EBE8 800AE3E8 02004114 */  bne        $v0, $at, .L800AE3F4
    /* 9EBEC 800AE3EC 00000000 */   nop
    /* 9EBF0 800AE3F0 0D000600 */  break      6
  .L800AE3F4:
    /* 9EBF4 800AE3F4 12300000 */  mflo       $a2
    /* 9EBF8 800AE3F8 3A00A587 */  lh         $a1, 0x3A($sp)
    /* 9EBFC 800AE3FC 5000A98F */  lw         $t1, 0x50($sp)
    /* 9EC00 800AE400 00000000 */  nop
    /* 9EC04 800AE404 1A00A900 */  div        $zero, $a1, $t1
    /* 9EC08 800AE408 02002015 */  bnez       $t1, .L800AE414
    /* 9EC0C 800AE40C 00000000 */   nop
    /* 9EC10 800AE410 0D000700 */  break      7
  .L800AE414:
    /* 9EC14 800AE414 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 9EC18 800AE418 04002115 */  bne        $t1, $at, .L800AE42C
    /* 9EC1C 800AE41C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 9EC20 800AE420 0200A114 */  bne        $a1, $at, .L800AE42C
    /* 9EC24 800AE424 00000000 */   nop
    /* 9EC28 800AE428 0D000600 */  break      6
  .L800AE42C:
    /* 9EC2C 800AE42C 12280000 */  mflo       $a1
    /* 9EC30 800AE430 6800A98F */  lw         $t1, 0x68($sp)
    /* 9EC34 800AE434 00000000 */  nop
    /* 9EC38 800AE438 18004900 */  mult       $v0, $t1
    /* 9EC3C 800AE43C 3C00A397 */  lhu        $v1, 0x3C($sp)
    /* 9EC40 800AE440 10400000 */  mfhi       $t0
    /* 9EC44 800AE444 001C0300 */  sll        $v1, $v1, 16
    /* 9EC48 800AE448 03140300 */  sra        $v0, $v1, 16
    /* 9EC4C 800AE44C 18004900 */  mult       $v0, $t1
    /* 9EC50 800AE450 C3270400 */  sra        $a0, $a0, 31
    /* 9EC54 800AE454 10380000 */  mfhi       $a3
    /* 9EC58 800AE458 43110800 */  sra        $v0, $t0, 5
    /* 9EC5C 800AE45C 23104400 */  subu       $v0, $v0, $a0
    /* 9EC60 800AE460 1800A200 */  mult       $a1, $v0
    /* 9EC64 800AE464 C31F0300 */  sra        $v1, $v1, 31
    /* 9EC68 800AE468 3800A2A7 */  sh         $v0, 0x38($sp)
    /* 9EC6C 800AE46C 43110700 */  sra        $v0, $a3, 5
    /* 9EC70 800AE470 23104300 */  subu       $v0, $v0, $v1
    /* 9EC74 800AE474 3C00A2A7 */  sh         $v0, 0x3C($sp)
    /* 9EC78 800AE478 3A00A5A7 */  sh         $a1, 0x3A($sp)
    /* 9EC7C 800AE47C 12200000 */  mflo       $a0
    /* 9EC80 800AE480 00140400 */  sll        $v0, $a0, 16
    /* 9EC84 800AE484 05004104 */  bgez       $v0, .L800AE49C
    /* 9EC88 800AE488 3A00A4A7 */   sh        $a0, 0x3A($sp)
    /* 9EC8C 800AE48C FF008230 */  andi       $v0, $a0, 0xFF
    /* 9EC90 800AE490 02004010 */  beqz       $v0, .L800AE49C
    /* 9EC94 800AE494 00018224 */   addiu     $v0, $a0, 0x100
    /* 9EC98 800AE498 3A00A2A7 */  sh         $v0, 0x3A($sp)
  .L800AE49C:
    /* 9EC9C 800AE49C 3A00A297 */  lhu        $v0, 0x3A($sp)
    /* 9ECA0 800AE4A0 00000000 */  nop
    /* 9ECA4 800AE4A4 00140200 */  sll        $v0, $v0, 16
    /* 9ECA8 800AE4A8 031E0200 */  sra        $v1, $v0, 24
    /* 9ECAC 800AE4AC 00140600 */  sll        $v0, $a2, 16
    /* 9ECB0 800AE4B0 03140200 */  sra        $v0, $v0, 16
    /* 9ECB4 800AE4B4 C1FF4228 */  slti       $v0, $v0, -0x3F
    /* 9ECB8 800AE4B8 02004010 */  beqz       $v0, .L800AE4C4
    /* 9ECBC 800AE4BC 3A00A3A7 */   sh        $v1, 0x3A($sp)
    /* 9ECC0 800AE4C0 C1FF0624 */  addiu      $a2, $zero, -0x3F
  .L800AE4C4:
    /* 9ECC4 800AE4C4 00140600 */  sll        $v0, $a2, 16
    /* 9ECC8 800AE4C8 03140200 */  sra        $v0, $v0, 16
    /* 9ECCC 800AE4CC 40004228 */  slti       $v0, $v0, 0x40
    /* 9ECD0 800AE4D0 02004014 */  bnez       $v0, .L800AE4DC
    /* 9ECD4 800AE4D4 C1FF6228 */   slti      $v0, $v1, -0x3F
    /* 9ECD8 800AE4D8 3F000624 */  addiu      $a2, $zero, 0x3F
  .L800AE4DC:
    /* 9ECDC 800AE4DC 02004010 */  beqz       $v0, .L800AE4E8
    /* 9ECE0 800AE4E0 C1FF0224 */   addiu     $v0, $zero, -0x3F
    /* 9ECE4 800AE4E4 3A00A2A7 */  sh         $v0, 0x3A($sp)
  .L800AE4E8:
    /* 9ECE8 800AE4E8 3A00A287 */  lh         $v0, 0x3A($sp)
    /* 9ECEC 800AE4EC 00000000 */  nop
    /* 9ECF0 800AE4F0 40004228 */  slti       $v0, $v0, 0x40
    /* 9ECF4 800AE4F4 02004014 */  bnez       $v0, .L800AE500
    /* 9ECF8 800AE4F8 3F000224 */   addiu     $v0, $zero, 0x3F
    /* 9ECFC 800AE4FC 3A00A2A7 */  sh         $v0, 0x3A($sp)
  .L800AE500:
    /* 9ED00 800AE500 3A00A297 */  lhu        $v0, 0x3A($sp)
    /* 9ED04 800AE504 01007326 */  addiu      $s3, $s3, 0x1
    /* 9ED08 800AE508 2310C200 */  subu       $v0, $a2, $v0
    /* 9ED0C 800AE50C 3A00A2A7 */  sh         $v0, 0x3A($sp)
    /* 9ED10 800AE510 1400028E */  lw         $v0, 0x14($s0)
    /* 9ED14 800AE514 3800A397 */  lhu        $v1, 0x38($sp)
    /* 9ED18 800AE518 21102202 */  addu       $v0, $s1, $v0
    /* 9ED1C 800AE51C 000043A4 */  sh         $v1, 0x0($v0)
    /* 9ED20 800AE520 1400028E */  lw         $v0, 0x14($s0)
    /* 9ED24 800AE524 3A00A397 */  lhu        $v1, 0x3A($sp)
    /* 9ED28 800AE528 21102202 */  addu       $v0, $s1, $v0
    /* 9ED2C 800AE52C 020043A4 */  sh         $v1, 0x2($v0)
    /* 9ED30 800AE530 1400028E */  lw         $v0, 0x14($s0)
    /* 9ED34 800AE534 3C00A397 */  lhu        $v1, 0x3C($sp)
    /* 9ED38 800AE538 21102202 */  addu       $v0, $s1, $v0
    /* 9ED3C 800AE53C 06003126 */  addiu      $s1, $s1, 0x6
    /* 9ED40 800AE540 B2B80208 */  j          .L800AE2C8
    /* 9ED44 800AE544 040043A4 */   sh        $v1, 0x4($v0)
  .L800AE548:
    /* 9ED48 800AE548 02000296 */  lhu        $v0, 0x2($s0)
    /* 9ED4C 800AE54C 00000000 */  nop
    /* 9ED50 800AE550 07004010 */  beqz       $v0, .L800AE570
    /* 9ED54 800AE554 21184000 */   addu      $v1, $v0, $zero
    /* 9ED58 800AE558 2110B202 */  addu       $v0, $s5, $s2
    /* 9ED5C 800AE55C 180002AE */  sw         $v0, 0x18($s0)
    /* 9ED60 800AE560 40100300 */  sll        $v0, $v1, 1
    /* 9ED64 800AE564 21104300 */  addu       $v0, $v0, $v1
    /* 9ED68 800AE568 80100200 */  sll        $v0, $v0, 2
    /* 9ED6C 800AE56C 21904202 */  addu       $s2, $s2, $v0
  .L800AE570:
    /* 9ED70 800AE570 0600D626 */  addiu      $s6, $s6, 0x6
    /* 9ED74 800AE574 6EB80208 */  j          .L800AE1B8
    /* 9ED78 800AE578 01009426 */   addiu     $s4, $s4, 0x1
  .L800AE57C:
    /* 9ED7C 800AE57C 4400A28F */  lw         $v0, 0x44($sp)
    /* 9ED80 800AE580 9400BF8F */  lw         $ra, 0x94($sp)
    /* 9ED84 800AE584 9000BE8F */  lw         $fp, 0x90($sp)
    /* 9ED88 800AE588 8C00B78F */  lw         $s7, 0x8C($sp)
    /* 9ED8C 800AE58C 8800B68F */  lw         $s6, 0x88($sp)
    /* 9ED90 800AE590 8400B58F */  lw         $s5, 0x84($sp)
    /* 9ED94 800AE594 8000B48F */  lw         $s4, 0x80($sp)
    /* 9ED98 800AE598 7C00B38F */  lw         $s3, 0x7C($sp)
    /* 9ED9C 800AE59C 7800B28F */  lw         $s2, 0x78($sp)
    /* 9EDA0 800AE5A0 7400B18F */  lw         $s1, 0x74($sp)
    /* 9EDA4 800AE5A4 7000B08F */  lw         $s0, 0x70($sp)
    /* 9EDA8 800AE5A8 0800E003 */  jr         $ra
    /* 9EDAC 800AE5AC 9800BD27 */   addiu     $sp, $sp, 0x98
endlabel R3DCar_ReadInCarData__FPcP8Car_tObj
