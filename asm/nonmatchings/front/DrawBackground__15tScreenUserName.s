.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__15tScreenUserName, 0x628

glabel DrawBackground__15tScreenUserName
    /* 3B9AC 8004B1AC 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 3B9B0 8004B1B0 6C00BFAF */  sw         $ra, 0x6C($sp)
    /* 3B9B4 8004B1B4 6800BEAF */  sw         $fp, 0x68($sp)
    /* 3B9B8 8004B1B8 6400B7AF */  sw         $s7, 0x64($sp)
    /* 3B9BC 8004B1BC 6000B6AF */  sw         $s6, 0x60($sp)
    /* 3B9C0 8004B1C0 5C00B5AF */  sw         $s5, 0x5C($sp)
    /* 3B9C4 8004B1C4 5800B4AF */  sw         $s4, 0x58($sp)
    /* 3B9C8 8004B1C8 5400B3AF */  sw         $s3, 0x54($sp)
    /* 3B9CC 8004B1CC 5000B2AF */  sw         $s2, 0x50($sp)
    /* 3B9D0 8004B1D0 4C00B1AF */  sw         $s1, 0x4C($sp)
    /* 3B9D4 8004B1D4 4800B0AF */  sw         $s0, 0x48($sp)
    /* 3B9D8 8004B1D8 7000A4AF */  sw         $a0, 0x70($sp)
    /* 3B9DC 8004B1DC 6400828C */  lw         $v0, 0x64($a0)
    /* 3B9E0 8004B1E0 00000000 */  nop
    /* 3B9E4 8004B1E4 7400428C */  lw         $v0, 0x74($v0)
    /* 3B9E8 8004B1E8 00000000 */  nop
    /* 3B9EC 8004B1EC 21284000 */  addu       $a1, $v0, $zero
    /* 3B9F0 8004B1F0 00140200 */  sll        $v0, $v0, 16
    /* 3B9F4 8004B1F4 43140200 */  sra        $v0, $v0, 17
    /* 3B9F8 8004B1F8 80FF4424 */  addiu      $a0, $v0, -0x80
    /* 3B9FC 8004B1FC 21188000 */  addu       $v1, $a0, $zero
    /* 3BA00 8004B200 80006228 */  slti       $v0, $v1, 0x80
    /* 3BA04 8004B204 03004010 */  beqz       $v0, .L8004B214
    /* 3BA08 8004B208 81006228 */   slti      $v0, $v1, 0x81
    /* 3BA0C 8004B20C 05006018 */  blez       $v1, .L8004B224
    /* 3BA10 8004B210 00000000 */   nop
  .L8004B214:
    /* 3BA14 8004B214 04004014 */  bnez       $v0, .L8004B228
    /* 3BA18 8004B218 00000000 */   nop
    /* 3BA1C 8004B21C 8A2C0108 */  j          .L8004B228
    /* 3BA20 8004B220 80000424 */   addiu     $a0, $zero, 0x80
  .L8004B224:
    /* 3BA24 8004B224 21200000 */  addu       $a0, $zero, $zero
  .L8004B228:
    /* 3BA28 8004B228 2800A4A7 */  sh         $a0, 0x28($sp)
    /* 3BA2C 8004B22C 00140500 */  sll        $v0, $a1, 16
    /* 3BA30 8004B230 83240200 */  sra        $a0, $v0, 18
    /* 3BA34 8004B234 21188000 */  addu       $v1, $a0, $zero
    /* 3BA38 8004B238 80006228 */  slti       $v0, $v1, 0x80
    /* 3BA3C 8004B23C 03004010 */  beqz       $v0, .L8004B24C
    /* 3BA40 8004B240 81006228 */   slti      $v0, $v1, 0x81
    /* 3BA44 8004B244 04006018 */  blez       $v1, .L8004B258
    /* 3BA48 8004B248 21380000 */   addu      $a3, $zero, $zero
  .L8004B24C:
    /* 3BA4C 8004B24C 02004014 */  bnez       $v0, .L8004B258
    /* 3BA50 8004B250 21388000 */   addu      $a3, $a0, $zero
    /* 3BA54 8004B254 80000724 */  addiu      $a3, $zero, 0x80
  .L8004B258:
    /* 3BA58 8004B258 00140500 */  sll        $v0, $a1, 16
    /* 3BA5C 8004B25C 031C0200 */  sra        $v1, $v0, 16
    /* 3BA60 8004B260 80006228 */  slti       $v0, $v1, 0x80
    /* 3BA64 8004B264 03004010 */  beqz       $v0, .L8004B274
    /* 3BA68 8004B268 3000A7A7 */   sh        $a3, 0x30($sp)
    /* 3BA6C 8004B26C 08006018 */  blez       $v1, .L8004B290
    /* 3BA70 8004B270 00000000 */   nop
  .L8004B274:
    /* 3BA74 8004B274 81006228 */  slti       $v0, $v1, 0x81
    /* 3BA78 8004B278 02004014 */  bnez       $v0, .L8004B284
    /* 3BA7C 8004B27C 2120A000 */   addu      $a0, $a1, $zero
    /* 3BA80 8004B280 80000424 */  addiu      $a0, $zero, 0x80
  .L8004B284:
    /* 3BA84 8004B284 7000A88F */  lw         $t0, 0x70($sp)
    /* 3BA88 8004B288 A72C0108 */  j          .L8004B29C
    /* 3BA8C 8004B28C 680004A5 */   sh        $a0, 0x68($t0)
  .L8004B290:
    /* 3BA90 8004B290 7000A98F */  lw         $t1, 0x70($sp)
    /* 3BA94 8004B294 00000000 */  nop
    /* 3BA98 8004B298 680020A5 */  sh         $zero, 0x68($t1)
  .L8004B29C:
    /* 3BA9C 8004B29C 0800103C */  lui        $s0, (0x80808 >> 16)
    /* 3BAA0 8004B2A0 08081036 */  ori        $s0, $s0, (0x80808 & 0xFFFF)
    /* 3BAA4 8004B2A4 F0000424 */  addiu      $a0, $zero, 0xF0
    /* 3BAA8 8004B2A8 2A000524 */  addiu      $a1, $zero, 0x2A
    /* 3BAAC 8004B2AC C2000624 */  addiu      $a2, $zero, 0xC2
    /* 3BAB0 8004B2B0 55000724 */  addiu      $a3, $zero, 0x55
    /* 3BAB4 8004B2B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3BAB8 8004B2B8 1400B0AF */  sw         $s0, 0x14($sp)
    /* 3BABC 8004B2BC 1800A0AF */  sw         $zero, 0x18($sp)
    /* 3BAC0 8004B2C0 3F70000C */  jal        SubtractiveBox__Fiiiiiiii
    /* 3BAC4 8004B2C4 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* 3BAC8 8004B2C8 F0000424 */  addiu      $a0, $zero, 0xF0
    /* 3BACC 8004B2CC 7F000524 */  addiu      $a1, $zero, 0x7F
    /* 3BAD0 8004B2D0 C2000624 */  addiu      $a2, $zero, 0xC2
    /* 3BAD4 8004B2D4 55000724 */  addiu      $a3, $zero, 0x55
    /* 3BAD8 8004B2D8 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3BADC 8004B2DC 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3BAE0 8004B2E0 1800B0AF */  sw         $s0, 0x18($sp)
    /* 3BAE4 8004B2E4 3F70000C */  jal        SubtractiveBox__Fiiiiiiii
    /* 3BAE8 8004B2E8 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 3BAEC 8004B2EC 7000AA8F */  lw         $t2, 0x70($sp)
    /* 3BAF0 8004B2F0 01001E24 */  addiu      $fp, $zero, 0x1
    /* 3BAF4 8004B2F4 02001724 */  addiu      $s7, $zero, 0x2
    /* 3BAF8 8004B2F8 0E001624 */  addiu      $s6, $zero, 0xE
    /* 3BAFC 8004B2FC 0580023C */  lui        $v0, %hi(MENUUSERNAME_STARTY)
    /* 3BB00 8004B300 B2295594 */  lhu        $s5, %lo(MENUUSERNAME_STARTY)($v0)
    /* 3BB04 8004B304 0180023C */  lui        $v0, %hi(D_800125E8)
    /* 3BB08 8004B308 3800A0A7 */  sh         $zero, 0x38($sp)
    /* 3BB0C 8004B30C E8254A24 */  addiu      $t2, $v0, %lo(D_800125E8)
    /* 3BB10 8004B310 00004B81 */  lb         $t3, 0x0($t2)
    /* 3BB14 8004B314 01004881 */  lb         $t0, 0x1($t2)
    /* 3BB18 8004B318 2000ABA3 */  sb         $t3, 0x20($sp)
    /* 3BB1C 8004B31C 2100A8A3 */  sb         $t0, 0x21($sp)
  .L8004B320:
    /* 3BB20 8004B320 0580023C */  lui        $v0, %hi(menu_kUserNameRows)
    /* 3BB24 8004B324 3800AB97 */  lhu        $t3, 0x38($sp)
    /* 3BB28 8004B328 B0294284 */  lh         $v0, %lo(menu_kUserNameRows)($v0)
    /* 3BB2C 8004B32C 001C0B00 */  sll        $v1, $t3, 16
    /* 3BB30 8004B330 031C0300 */  sra        $v1, $v1, 16
    /* 3BB34 8004B334 2A186200 */  slt        $v1, $v1, $v0
    /* 3BB38 8004B338 BC006010 */  beqz       $v1, .L8004B62C
    /* 3BB3C 8004B33C FFFFA226 */   addiu     $v0, $s5, -0x1
    /* 3BB40 8004B340 02011124 */  addiu      $s1, $zero, 0x102
    /* 3BB44 8004B344 4000A0A7 */  sh         $zero, 0x40($sp)
    /* 3BB48 8004B348 00A40200 */  sll        $s4, $v0, 16
    /* 3BB4C 8004B34C 00141500 */  sll        $v0, $s5, 16
    /* 3BB50 8004B350 039C0200 */  sra        $s3, $v0, 16
  .L8004B354:
    /* 3BB54 8004B354 4000A897 */  lhu        $t0, 0x40($sp)
    /* 3BB58 8004B358 3800A997 */  lhu        $t1, 0x38($sp)
    /* 3BB5C 8004B35C 7000AA8F */  lw         $t2, 0x70($sp)
    /* 3BB60 8004B360 00240800 */  sll        $a0, $t0, 16
    /* 3BB64 8004B364 03240400 */  sra        $a0, $a0, 16
    /* 3BB68 8004B368 001C0900 */  sll        $v1, $t1, 16
    /* 3BB6C 8004B36C 031C0300 */  sra        $v1, $v1, 16
    /* 3BB70 8004B370 C0100300 */  sll        $v0, $v1, 3
    /* 3BB74 8004B374 21104300 */  addu       $v0, $v0, $v1
    /* 3BB78 8004B378 21208200 */  addu       $a0, $a0, $v0
    /* 3BB7C 8004B37C 21204401 */  addu       $a0, $t2, $a0
    /* 3BB80 8004B380 70008290 */  lbu        $v0, 0x70($a0)
    /* 3BB84 8004B384 00000000 */  nop
    /* 3BB88 8004B388 A3004010 */  beqz       $v0, .L8004B618
    /* 3BB8C 8004B38C B500043C */   lui       $a0, (0xB54200 >> 16)
    /* 3BB90 8004B390 2000A2A3 */  sb         $v0, 0x20($sp)
    /* 3BB94 8004B394 68004585 */  lh         $a1, 0x68($t2)
    /* 3BB98 8004B398 222E010C */  jal        CalcFadeVal__Fii
    /* 3BB9C 8004B39C 00428434 */   ori       $a0, $a0, (0xB54200 & 0xFFFF)
    /* 3BBA0 8004B3A0 2000A393 */  lbu        $v1, 0x20($sp)
    /* 3BBA4 8004B3A4 21804000 */  addu       $s0, $v0, $zero
    /* 3BBA8 8004B3A8 DFFF6324 */  addiu      $v1, $v1, -0x21
    /* 3BBAC 8004B3AC 3E00622C */  sltiu      $v0, $v1, 0x3E
    /* 3BBB0 8004B3B0 8B004010 */  beqz       $v0, .L8004B5E0
    /* 3BBB4 8004B3B4 0180023C */   lui       $v0, %hi(jtbl_800125F0)
    /* 3BBB8 8004B3B8 F0254224 */  addiu      $v0, $v0, %lo(jtbl_800125F0)
    /* 3BBBC 8004B3BC 80180300 */  sll        $v1, $v1, 2
    /* 3BBC0 8004B3C0 21186200 */  addu       $v1, $v1, $v0
    /* 3BBC4 8004B3C4 0000628C */  lw         $v0, 0x0($v1)
    /* 3BBC8 8004B3C8 00000000 */  nop
    /* 3BBCC 8004B3CC 08004000 */  jr         $v0
    /* 3BBD0 8004B3D0 00000000 */   nop
  jlabel .L8004B3D4
    /* 3BBD4 8004B3D4 402D0108 */  j          .L8004B500
    /* 3BBD8 8004B3D8 05020424 */   addiu     $a0, $zero, 0x205
  jlabel .L8004B3DC
    /* 3BBDC 8004B3DC 94E4020C */  jal        TextSys_Word__Fi
    /* 3BBE0 8004B3E0 05020424 */   addiu     $a0, $zero, 0x205
    /* 3BBE4 8004B3E4 21204000 */  addu       $a0, $v0, $zero
    /* 3BBE8 8004B3E8 24002526 */  addiu      $a1, $s1, 0x24
    /* 3BBEC 8004B3EC 002C0500 */  sll        $a1, $a1, 16
    /* 3BBF0 8004B3F0 032C0500 */  sra        $a1, $a1, 16
    /* 3BBF4 8004B3F4 03341400 */  sra        $a2, $s4, 16
    /* 3BBF8 8004B3F8 21380002 */  addu       $a3, $s0, $zero
    /* 3BBFC 8004B3FC 1000BEAF */  sw         $fp, 0x10($sp)
    /* 3BC00 8004B400 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 3BC04 8004B404 1400B7AF */   sw        $s7, 0x14($sp)
    /* 3BC08 8004B408 01001024 */  addiu      $s0, $zero, 0x1
    /* 3BC0C 8004B40C 00141100 */  sll        $v0, $s1, 16
    /* 3BC10 8004B410 03940200 */  sra        $s2, $v0, 16
    /* 3BC14 8004B414 1000B6AF */  sw         $s6, 0x10($sp)
  .L8004B418:
    /* 3BC18 8004B418 21200000 */  addu       $a0, $zero, $zero
    /* 3BC1C 8004B41C 00141000 */  sll        $v0, $s0, 16
    /* 3BC20 8004B420 03140200 */  sra        $v0, $v0, 16
    /* 3BC24 8004B424 C0280200 */  sll        $a1, $v0, 3
    /* 3BC28 8004B428 2328A200 */  subu       $a1, $a1, $v0
    /* 3BC2C 8004B42C 80280500 */  sll        $a1, $a1, 2
    /* 3BC30 8004B430 21284502 */  addu       $a1, $s2, $a1
    /* 3BC34 8004B434 FAFFA524 */  addiu      $a1, $a1, -0x6
    /* 3BC38 8004B438 FEFF6626 */  addiu      $a2, $s3, -0x2
    /* 3BC3C 8004B43C 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 3BC40 8004B440 02000724 */   addiu     $a3, $zero, 0x2
    /* 3BC44 8004B444 01000226 */  addiu      $v0, $s0, 0x1
    /* 3BC48 8004B448 21804000 */  addu       $s0, $v0, $zero
    /* 3BC4C 8004B44C 00140200 */  sll        $v0, $v0, 16
    /* 3BC50 8004B450 03140200 */  sra        $v0, $v0, 16
    /* 3BC54 8004B454 03004228 */  slti       $v0, $v0, 0x3
    /* 3BC58 8004B458 6A004010 */  beqz       $v0, .L8004B604
    /* 3BC5C 8004B45C 00000000 */   nop
    /* 3BC60 8004B460 062D0108 */  j          .L8004B418
    /* 3BC64 8004B464 1000B6AF */   sw        $s6, 0x10($sp)
  jlabel .L8004B468
    /* 3BC68 8004B468 402D0108 */  j          .L8004B500
    /* 3BC6C 8004B46C 06020424 */   addiu     $a0, $zero, 0x206
  jlabel .L8004B470
    /* 3BC70 8004B470 94E4020C */  jal        TextSys_Word__Fi
    /* 3BC74 8004B474 06020424 */   addiu     $a0, $zero, 0x206
    /* 3BC78 8004B478 21204000 */  addu       $a0, $v0, $zero
    /* 3BC7C 8004B47C 24002526 */  addiu      $a1, $s1, 0x24
    /* 3BC80 8004B480 002C0500 */  sll        $a1, $a1, 16
    /* 3BC84 8004B484 032C0500 */  sra        $a1, $a1, 16
    /* 3BC88 8004B488 03341400 */  sra        $a2, $s4, 16
    /* 3BC8C 8004B48C 21380002 */  addu       $a3, $s0, $zero
    /* 3BC90 8004B490 1000BEAF */  sw         $fp, 0x10($sp)
    /* 3BC94 8004B494 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 3BC98 8004B498 1400B7AF */   sw        $s7, 0x14($sp)
    /* 3BC9C 8004B49C 01001024 */  addiu      $s0, $zero, 0x1
    /* 3BCA0 8004B4A0 00141100 */  sll        $v0, $s1, 16
    /* 3BCA4 8004B4A4 03940200 */  sra        $s2, $v0, 16
    /* 3BCA8 8004B4A8 1000B6AF */  sw         $s6, 0x10($sp)
  .L8004B4AC:
    /* 3BCAC 8004B4AC 21200000 */  addu       $a0, $zero, $zero
    /* 3BCB0 8004B4B0 00141000 */  sll        $v0, $s0, 16
    /* 3BCB4 8004B4B4 03140200 */  sra        $v0, $v0, 16
    /* 3BCB8 8004B4B8 C0280200 */  sll        $a1, $v0, 3
    /* 3BCBC 8004B4BC 2328A200 */  subu       $a1, $a1, $v0
    /* 3BCC0 8004B4C0 80280500 */  sll        $a1, $a1, 2
    /* 3BCC4 8004B4C4 21284502 */  addu       $a1, $s2, $a1
    /* 3BCC8 8004B4C8 FAFFA524 */  addiu      $a1, $a1, -0x6
    /* 3BCCC 8004B4CC FEFF6626 */  addiu      $a2, $s3, -0x2
    /* 3BCD0 8004B4D0 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 3BCD4 8004B4D4 02000724 */   addiu     $a3, $zero, 0x2
    /* 3BCD8 8004B4D8 01000226 */  addiu      $v0, $s0, 0x1
    /* 3BCDC 8004B4DC 21804000 */  addu       $s0, $v0, $zero
    /* 3BCE0 8004B4E0 00140200 */  sll        $v0, $v0, 16
    /* 3BCE4 8004B4E4 03140200 */  sra        $v0, $v0, 16
    /* 3BCE8 8004B4E8 03004228 */  slti       $v0, $v0, 0x3
    /* 3BCEC 8004B4EC 45004010 */  beqz       $v0, .L8004B604
    /* 3BCF0 8004B4F0 00000000 */   nop
    /* 3BCF4 8004B4F4 2B2D0108 */  j          .L8004B4AC
    /* 3BCF8 8004B4F8 1000B6AF */   sw        $s6, 0x10($sp)
  jlabel .L8004B4FC
    /* 3BCFC 8004B4FC 07020424 */  addiu      $a0, $zero, 0x207
  .L8004B500:
    /* 3BD00 8004B500 94E4020C */  jal        TextSys_Word__Fi
    /* 3BD04 8004B504 00000000 */   nop
    /* 3BD08 8004B508 21204000 */  addu       $a0, $v0, $zero
    /* 3BD0C 8004B50C 16002526 */  addiu      $a1, $s1, 0x16
    /* 3BD10 8004B510 002C0500 */  sll        $a1, $a1, 16
    /* 3BD14 8004B514 032C0500 */  sra        $a1, $a1, 16
    /* 3BD18 8004B518 03341400 */  sra        $a2, $s4, 16
    /* 3BD1C 8004B51C 21380002 */  addu       $a3, $s0, $zero
    /* 3BD20 8004B520 1000BEAF */  sw         $fp, 0x10($sp)
    /* 3BD24 8004B524 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 3BD28 8004B528 1400B7AF */   sw        $s7, 0x14($sp)
    /* 3BD2C 8004B52C 21200000 */  addu       $a0, $zero, $zero
    /* 3BD30 8004B530 002C1100 */  sll        $a1, $s1, 16
    /* 3BD34 8004B534 032C0500 */  sra        $a1, $a1, 16
    /* 3BD38 8004B538 1600A524 */  addiu      $a1, $a1, 0x16
    /* 3BD3C 8004B53C FEFF6626 */  addiu      $a2, $s3, -0x2
    /* 3BD40 8004B540 02000724 */  addiu      $a3, $zero, 0x2
    /* 3BD44 8004B544 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 3BD48 8004B548 1000B6AF */   sw        $s6, 0x10($sp)
    /* 3BD4C 8004B54C 812D0108 */  j          .L8004B604
    /* 3BD50 8004B550 00000000 */   nop
  jlabel .L8004B554
    /* 3BD54 8004B554 94E4020C */  jal        TextSys_Word__Fi
    /* 3BD58 8004B558 07020424 */   addiu     $a0, $zero, 0x207
    /* 3BD5C 8004B55C 21204000 */  addu       $a0, $v0, $zero
    /* 3BD60 8004B560 4E002526 */  addiu      $a1, $s1, 0x4E
    /* 3BD64 8004B564 002C0500 */  sll        $a1, $a1, 16
    /* 3BD68 8004B568 032C0500 */  sra        $a1, $a1, 16
    /* 3BD6C 8004B56C 03341400 */  sra        $a2, $s4, 16
    /* 3BD70 8004B570 21380002 */  addu       $a3, $s0, $zero
    /* 3BD74 8004B574 1000BEAF */  sw         $fp, 0x10($sp)
    /* 3BD78 8004B578 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 3BD7C 8004B57C 1400B7AF */   sw        $s7, 0x14($sp)
    /* 3BD80 8004B580 01001024 */  addiu      $s0, $zero, 0x1
    /* 3BD84 8004B584 00141100 */  sll        $v0, $s1, 16
    /* 3BD88 8004B588 03940200 */  sra        $s2, $v0, 16
    /* 3BD8C 8004B58C 1000B6AF */  sw         $s6, 0x10($sp)
  .L8004B590:
    /* 3BD90 8004B590 21200000 */  addu       $a0, $zero, $zero
    /* 3BD94 8004B594 00141000 */  sll        $v0, $s0, 16
    /* 3BD98 8004B598 03140200 */  sra        $v0, $v0, 16
    /* 3BD9C 8004B59C C0280200 */  sll        $a1, $v0, 3
    /* 3BDA0 8004B5A0 2328A200 */  subu       $a1, $a1, $v0
    /* 3BDA4 8004B5A4 80280500 */  sll        $a1, $a1, 2
    /* 3BDA8 8004B5A8 21284502 */  addu       $a1, $s2, $a1
    /* 3BDAC 8004B5AC FAFFA524 */  addiu      $a1, $a1, -0x6
    /* 3BDB0 8004B5B0 FEFF6626 */  addiu      $a2, $s3, -0x2
    /* 3BDB4 8004B5B4 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 3BDB8 8004B5B8 02000724 */   addiu     $a3, $zero, 0x2
    /* 3BDBC 8004B5BC 01000226 */  addiu      $v0, $s0, 0x1
    /* 3BDC0 8004B5C0 21804000 */  addu       $s0, $v0, $zero
    /* 3BDC4 8004B5C4 00140200 */  sll        $v0, $v0, 16
    /* 3BDC8 8004B5C8 03140200 */  sra        $v0, $v0, 16
    /* 3BDCC 8004B5CC 06004228 */  slti       $v0, $v0, 0x6
    /* 3BDD0 8004B5D0 0C004010 */  beqz       $v0, .L8004B604
    /* 3BDD4 8004B5D4 00000000 */   nop
    /* 3BDD8 8004B5D8 642D0108 */  j          .L8004B590
    /* 3BDDC 8004B5DC 1000B6AF */   sw        $s6, 0x10($sp)
  jlabel .L8004B5E0
    /* 3BDE0 8004B5E0 2000A427 */  addiu      $a0, $sp, 0x20
    /* 3BDE4 8004B5E4 08002526 */  addiu      $a1, $s1, 0x8
    /* 3BDE8 8004B5E8 002C0500 */  sll        $a1, $a1, 16
    /* 3BDEC 8004B5EC 032C0500 */  sra        $a1, $a1, 16
    /* 3BDF0 8004B5F0 03341400 */  sra        $a2, $s4, 16
    /* 3BDF4 8004B5F4 21380002 */  addu       $a3, $s0, $zero
    /* 3BDF8 8004B5F8 1000BEAF */  sw         $fp, 0x10($sp)
    /* 3BDFC 8004B5FC 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 3BE00 8004B600 1400B7AF */   sw        $s7, 0x14($sp)
  jlabel .L8004B604
    /* 3BE04 8004B604 4000AB97 */  lhu        $t3, 0x40($sp)
    /* 3BE08 8004B608 1C003126 */  addiu      $s1, $s1, 0x1C
    /* 3BE0C 8004B60C 01006B25 */  addiu      $t3, $t3, 0x1
    /* 3BE10 8004B610 D52C0108 */  j          .L8004B354
    /* 3BE14 8004B614 4000ABA7 */   sh        $t3, 0x40($sp)
  .L8004B618:
    /* 3BE18 8004B618 3800A897 */  lhu        $t0, 0x38($sp)
    /* 3BE1C 8004B61C 0F00B526 */  addiu      $s5, $s5, 0xF
    /* 3BE20 8004B620 01000825 */  addiu      $t0, $t0, 0x1
    /* 3BE24 8004B624 C82C0108 */  j          .L8004B320
    /* 3BE28 8004B628 3800A8A7 */   sh        $t0, 0x38($sp)
  .L8004B62C:
    /* 3BE2C 8004B62C 5000103C */  lui        $s0, (0x505050 >> 16)
    /* 3BE30 8004B630 50501036 */  ori        $s0, $s0, (0x505050 & 0xFFFF)
    /* 3BE34 8004B634 F0000424 */  addiu      $a0, $zero, 0xF0
    /* 3BE38 8004B638 2A000524 */  addiu      $a1, $zero, 0x2A
    /* 3BE3C 8004B63C C2000624 */  addiu      $a2, $zero, 0xC2
    /* 3BE40 8004B640 55000724 */  addiu      $a3, $zero, 0x55
    /* 3BE44 8004B644 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3BE48 8004B648 1400B0AF */  sw         $s0, 0x14($sp)
    /* 3BE4C 8004B64C 1800A0AF */  sw         $zero, 0x18($sp)
    /* 3BE50 8004B650 3F70000C */  jal        SubtractiveBox__Fiiiiiiii
    /* 3BE54 8004B654 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* 3BE58 8004B658 F0000424 */  addiu      $a0, $zero, 0xF0
    /* 3BE5C 8004B65C 7F000524 */  addiu      $a1, $zero, 0x7F
    /* 3BE60 8004B660 C2000624 */  addiu      $a2, $zero, 0xC2
    /* 3BE64 8004B664 55000724 */  addiu      $a3, $zero, 0x55
    /* 3BE68 8004B668 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3BE6C 8004B66C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3BE70 8004B670 1800B0AF */  sw         $s0, 0x18($sp)
    /* 3BE74 8004B674 3F70000C */  jal        SubtractiveBox__Fiiiiiiii
    /* 3BE78 8004B678 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 3BE7C 8004B67C FC001124 */  addiu      $s1, $zero, 0xFC
    /* 3BE80 8004B680 21800000 */  addu       $s0, $zero, $zero
  .L8004B684:
    /* 3BE84 8004B684 002C1100 */  sll        $a1, $s1, 16
    /* 3BE88 8004B688 032C0500 */  sra        $a1, $a1, 16
    /* 3BE8C 8004B68C 2E000624 */  addiu      $a2, $zero, 0x2E
    /* 3BE90 8004B690 003C1000 */  sll        $a3, $s0, 16
    /* 3BE94 8004B694 C33B0700 */  sra        $a3, $a3, 15
    /* 3BE98 8004B698 3000A997 */  lhu        $t1, 0x30($sp)
    /* 3BE9C 8004B69C 7000A48F */  lw         $a0, 0x70($sp)
    /* 3BEA0 8004B6A0 23382701 */  subu       $a3, $t1, $a3
    /* 3BEA4 8004B6A4 003C0700 */  sll        $a3, $a3, 16
    /* 3BEA8 8004B6A8 2A2C010C */  jal        DrawVerticalLine__15tScreenUserNamesss
    /* 3BEAC 8004B6AC 033C0700 */   sra       $a3, $a3, 16
    /* 3BEB0 8004B6B0 01000226 */  addiu      $v0, $s0, 0x1
    /* 3BEB4 8004B6B4 21804000 */  addu       $s0, $v0, $zero
    /* 3BEB8 8004B6B8 00140200 */  sll        $v0, $v0, 16
    /* 3BEBC 8004B6BC 03140200 */  sra        $v0, $v0, 16
    /* 3BEC0 8004B6C0 07004228 */  slti       $v0, $v0, 0x7
    /* 3BEC4 8004B6C4 EFFF4014 */  bnez       $v0, .L8004B684
    /* 3BEC8 8004B6C8 1C003126 */   addiu     $s1, $s1, 0x1C
    /* 3BECC 8004B6CC 21800000 */  addu       $s0, $zero, $zero
    /* 3BED0 8004B6D0 0580023C */  lui        $v0, %hi(MENUUSERNAME_STARTY)
    /* 3BED4 8004B6D4 0580043C */  lui        $a0, %hi(menu_kUserNameRows)
    /* 3BED8 8004B6D8 B2294394 */  lhu        $v1, %lo(MENUUSERNAME_STARTY)($v0)
    /* 3BEDC 8004B6DC B0298284 */  lh         $v0, %lo(menu_kUserNameRows)($a0)
    /* 3BEE0 8004B6E0 00000000 */  nop
    /* 3BEE4 8004B6E4 01004224 */  addiu      $v0, $v0, 0x1
    /* 3BEE8 8004B6E8 1A004018 */  blez       $v0, .L8004B754
    /* 3BEEC 8004B6EC FDFF7524 */   addiu     $s5, $v1, -0x3
    /* 3BEF0 8004B6F0 21888000 */  addu       $s1, $a0, $zero
    /* 3BEF4 8004B6F4 F0000524 */  addiu      $a1, $zero, 0xF0
  .L8004B6F8:
    /* 3BEF8 8004B6F8 00341500 */  sll        $a2, $s5, 16
    /* 3BEFC 8004B6FC 03340600 */  sra        $a2, $a2, 16
    /* 3BF00 8004B700 0F00B526 */  addiu      $s5, $s5, 0xF
    /* 3BF04 8004B704 00141000 */  sll        $v0, $s0, 16
    /* 3BF08 8004B708 03140200 */  sra        $v0, $v0, 16
    /* 3BF0C 8004B70C 7000A48F */  lw         $a0, 0x70($sp)
    /* 3BF10 8004B710 B0292786 */  lh         $a3, %lo(menu_kUserNameRows)($s1)
    /* 3BF14 8004B714 3000AA97 */  lhu        $t2, 0x30($sp)
    /* 3BF18 8004B718 2338E200 */  subu       $a3, $a3, $v0
    /* 3BF1C 8004B71C 40380700 */  sll        $a3, $a3, 1
    /* 3BF20 8004B720 23384701 */  subu       $a3, $t2, $a3
    /* 3BF24 8004B724 003C0700 */  sll        $a3, $a3, 16
    /* 3BF28 8004B728 4A2C010C */  jal        DrawHorizontalLine__15tScreenUserNamesss
    /* 3BF2C 8004B72C 033C0700 */   sra       $a3, $a3, 16
    /* 3BF30 8004B730 01000226 */  addiu      $v0, $s0, 0x1
    /* 3BF34 8004B734 21804000 */  addu       $s0, $v0, $zero
    /* 3BF38 8004B738 00140200 */  sll        $v0, $v0, 16
    /* 3BF3C 8004B73C B0292386 */  lh         $v1, %lo(menu_kUserNameRows)($s1)
    /* 3BF40 8004B740 03140200 */  sra        $v0, $v0, 16
    /* 3BF44 8004B744 01006324 */  addiu      $v1, $v1, 0x1
    /* 3BF48 8004B748 2A104300 */  slt        $v0, $v0, $v1
    /* 3BF4C 8004B74C EAFF4014 */  bnez       $v0, .L8004B6F8
    /* 3BF50 8004B750 F0000524 */   addiu     $a1, $zero, 0xF0
  .L8004B754:
    /* 3BF54 8004B754 2800AB97 */  lhu        $t3, 0x28($sp)
    /* 3BF58 8004B758 21800000 */  addu       $s0, $zero, $zero
    /* 3BF5C 8004B75C 00140B00 */  sll        $v0, $t3, 16
    /* 3BF60 8004B760 038C0200 */  sra        $s1, $v0, 16
    /* 3BF64 8004B764 00241000 */  sll        $a0, $s0, 16
  .L8004B768:
    /* 3BF68 8004B768 03240400 */  sra        $a0, $a0, 16
    /* 3BF6C 8004B76C 21280000 */  addu       $a1, $zero, $zero
    /* 3BF70 8004B770 2130A000 */  addu       $a2, $a1, $zero
    /* 3BF74 8004B774 2138A000 */  addu       $a3, $a1, $zero
    /* 3BF78 8004B778 1000B1AF */  sw         $s1, 0x10($sp)
    /* 3BF7C 8004B77C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3BF80 8004B780 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3BF84 8004B784 1800A0AF */   sw        $zero, 0x18($sp)
    /* 3BF88 8004B788 01000226 */  addiu      $v0, $s0, 0x1
    /* 3BF8C 8004B78C 21804000 */  addu       $s0, $v0, $zero
    /* 3BF90 8004B790 00140200 */  sll        $v0, $v0, 16
    /* 3BF94 8004B794 03140200 */  sra        $v0, $v0, 16
    /* 3BF98 8004B798 20004228 */  slti       $v0, $v0, 0x20
    /* 3BF9C 8004B79C F2FF4014 */  bnez       $v0, .L8004B768
    /* 3BFA0 8004B7A0 00241000 */   sll       $a0, $s0, 16
    /* 3BFA4 8004B7A4 6C00BF8F */  lw         $ra, 0x6C($sp)
    /* 3BFA8 8004B7A8 6800BE8F */  lw         $fp, 0x68($sp)
    /* 3BFAC 8004B7AC 6400B78F */  lw         $s7, 0x64($sp)
    /* 3BFB0 8004B7B0 6000B68F */  lw         $s6, 0x60($sp)
    /* 3BFB4 8004B7B4 5C00B58F */  lw         $s5, 0x5C($sp)
    /* 3BFB8 8004B7B8 5800B48F */  lw         $s4, 0x58($sp)
    /* 3BFBC 8004B7BC 5400B38F */  lw         $s3, 0x54($sp)
    /* 3BFC0 8004B7C0 5000B28F */  lw         $s2, 0x50($sp)
    /* 3BFC4 8004B7C4 4C00B18F */  lw         $s1, 0x4C($sp)
    /* 3BFC8 8004B7C8 4800B08F */  lw         $s0, 0x48($sp)
    /* 3BFCC 8004B7CC 0800E003 */  jr         $ra
    /* 3BFD0 8004B7D0 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel DrawBackground__15tScreenUserName
