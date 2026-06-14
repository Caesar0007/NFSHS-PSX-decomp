.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_SortCars__Fv, 0x170

glabel Cars_SortCars__Fv
    /* 7BA8C 8008B28C A802838F */  lw         $v1, %gp_rel(Cars_gNumCars)($gp)
    /* 7BA90 8008B290 1180023C */  lui        $v0, %hi(Cars_gSortedList)
    /* 7BA94 8008B294 FCFA4B24 */  addiu      $t3, $v0, %lo(Cars_gSortedList)
    /* 7BA98 8008B298 FFFF6C24 */  addiu      $t4, $v1, -0x1
    /* 7BA9C 8008B29C 21180000 */  addu       $v1, $zero, $zero
  .L8008B2A0:
    /* 7BAA0 8008B2A0 17008019 */  blez       $t4, .L8008B300
    /* 7BAA4 8008B2A4 21486000 */   addu      $t1, $v1, $zero
    /* 7BAA8 8008B2A8 A802828F */  lw         $v0, %gp_rel(Cars_gNumCars)($gp)
    /* 7BAAC 8008B2AC 00000000 */  nop
    /* 7BAB0 8008B2B0 FFFF4A24 */  addiu      $t2, $v0, -0x1
    /* 7BAB4 8008B2B4 80100300 */  sll        $v0, $v1, 2
  .L8008B2B8:
    /* 7BAB8 8008B2B8 21384B00 */  addu       $a3, $v0, $t3
    /* 7BABC 8008B2BC 01006824 */  addiu      $t0, $v1, 0x1
    /* 7BAC0 8008B2C0 80100800 */  sll        $v0, $t0, 2
    /* 7BAC4 8008B2C4 21304B00 */  addu       $a2, $v0, $t3
    /* 7BAC8 8008B2C8 0000E58C */  lw         $a1, 0x0($a3)
    /* 7BACC 8008B2CC 0000C48C */  lw         $a0, 0x0($a2)
    /* 7BAD0 8008B2D0 0800A384 */  lh         $v1, 0x8($a1)
    /* 7BAD4 8008B2D4 08008284 */  lh         $v0, 0x8($a0)
    /* 7BAD8 8008B2D8 00000000 */  nop
    /* 7BADC 8008B2DC 2A104300 */  slt        $v0, $v0, $v1
    /* 7BAE0 8008B2E0 04004010 */  beqz       $v0, .L8008B2F4
    /* 7BAE4 8008B2E4 21180001 */   addu      $v1, $t0, $zero
    /* 7BAE8 8008B2E8 01000924 */  addiu      $t1, $zero, 0x1
    /* 7BAEC 8008B2EC 0000E4AC */  sw         $a0, 0x0($a3)
    /* 7BAF0 8008B2F0 0000C5AC */  sw         $a1, 0x0($a2)
  .L8008B2F4:
    /* 7BAF4 8008B2F4 2A106A00 */  slt        $v0, $v1, $t2
    /* 7BAF8 8008B2F8 EFFF4014 */  bnez       $v0, .L8008B2B8
    /* 7BAFC 8008B2FC 80100300 */   sll       $v0, $v1, 2
  .L8008B300:
    /* 7BB00 8008B300 E7FF2015 */  bnez       $t1, .L8008B2A0
    /* 7BB04 8008B304 21180000 */   addu      $v1, $zero, $zero
    /* 7BB08 8008B308 A802858F */  lw         $a1, %gp_rel(Cars_gNumCars)($gp)
    /* 7BB0C 8008B30C 00000000 */  nop
    /* 7BB10 8008B310 2A102501 */  slt        $v0, $t1, $a1
    /* 7BB14 8008B314 09004010 */  beqz       $v0, .L8008B33C
    /* 7BB18 8008B318 1180023C */   lui       $v0, %hi(Cars_gSortedList)
    /* 7BB1C 8008B31C FCFA4424 */  addiu      $a0, $v0, %lo(Cars_gSortedList)
  .L8008B320:
    /* 7BB20 8008B320 0000828C */  lw         $v0, 0x0($a0)
    /* 7BB24 8008B324 00000000 */  nop
    /* 7BB28 8008B328 5C0243AC */  sw         $v1, 0x25C($v0)
    /* 7BB2C 8008B32C 01006324 */  addiu      $v1, $v1, 0x1
    /* 7BB30 8008B330 2A106500 */  slt        $v0, $v1, $a1
    /* 7BB34 8008B334 FAFF4014 */  bnez       $v0, .L8008B320
    /* 7BB38 8008B338 04008424 */   addiu     $a0, $a0, 0x4
  .L8008B33C:
    /* 7BB3C 8008B33C 1180023C */  lui        $v0, %hi(Cars_gTotalSortedList)
    /* 7BB40 8008B340 20FB4B24 */  addiu      $t3, $v0, %lo(Cars_gTotalSortedList)
    /* 7BB44 8008B344 A802838F */  lw         $v1, %gp_rel(Cars_gNumCars)($gp)
    /* 7BB48 8008B348 1280023C */  lui        $v0, %hi(simGlobal)
    /* 7BB4C 8008B34C ACE04C24 */  addiu      $t4, $v0, %lo(simGlobal)
    /* 7BB50 8008B350 FFFF6D24 */  addiu      $t5, $v1, -0x1
    /* 7BB54 8008B354 21180000 */  addu       $v1, $zero, $zero
  .L8008B358:
    /* 7BB58 8008B358 2400A019 */  blez       $t5, .L8008B3EC
    /* 7BB5C 8008B35C 21486000 */   addu      $t1, $v1, $zero
    /* 7BB60 8008B360 A802828F */  lw         $v0, %gp_rel(Cars_gNumCars)($gp)
    /* 7BB64 8008B364 00000000 */  nop
    /* 7BB68 8008B368 FFFF4A24 */  addiu      $t2, $v0, -0x1
    /* 7BB6C 8008B36C 80100300 */  sll        $v0, $v1, 2
  .L8008B370:
    /* 7BB70 8008B370 21384B00 */  addu       $a3, $v0, $t3
    /* 7BB74 8008B374 01006824 */  addiu      $t0, $v1, 0x1
    /* 7BB78 8008B378 80100800 */  sll        $v0, $t0, 2
    /* 7BB7C 8008B37C 21304B00 */  addu       $a2, $v0, $t3
    /* 7BB80 8008B380 0000E58C */  lw         $a1, 0x0($a3)
    /* 7BB84 8008B384 0000C48C */  lw         $a0, 0x0($a2)
    /* 7BB88 8008B388 0600A394 */  lhu        $v1, 0x6($a1)
    /* 7BB8C 8008B38C 06008294 */  lhu        $v0, 0x6($a0)
    /* 7BB90 8008B390 00000000 */  nop
    /* 7BB94 8008B394 2B104300 */  sltu       $v0, $v0, $v1
    /* 7BB98 8008B398 11004010 */  beqz       $v0, .L8008B3E0
    /* 7BB9C 8008B39C 21180001 */   addu      $v1, $t0, $zero
    /* 7BBA0 8008B3A0 8002A4AC */  sw         $a0, 0x280($a1)
    /* 7BBA4 8008B3A4 0000C38C */  lw         $v1, 0x0($a2)
    /* 7BBA8 8008B3A8 0000E28C */  lw         $v0, 0x0($a3)
    /* 7BBAC 8008B3AC 00000000 */  nop
    /* 7BBB0 8008B3B0 800262AC */  sw         $v0, 0x280($v1)
    /* 7BBB4 8008B3B4 0000C48C */  lw         $a0, 0x0($a2)
    /* 7BBB8 8008B3B8 0400828D */  lw         $v0, 0x4($t4)
    /* 7BBBC 8008B3BC 0000E38C */  lw         $v1, 0x0($a3)
    /* 7BBC0 8008B3C0 840282AC */  sw         $v0, 0x284($a0)
    /* 7BBC4 8008B3C4 840262AC */  sw         $v0, 0x284($v1)
    /* 7BBC8 8008B3C8 0000E38C */  lw         $v1, 0x0($a3)
    /* 7BBCC 8008B3CC 0000C28C */  lw         $v0, 0x0($a2)
    /* 7BBD0 8008B3D0 01000924 */  addiu      $t1, $zero, 0x1
    /* 7BBD4 8008B3D4 0000E2AC */  sw         $v0, 0x0($a3)
    /* 7BBD8 8008B3D8 0000C3AC */  sw         $v1, 0x0($a2)
    /* 7BBDC 8008B3DC 21180001 */  addu       $v1, $t0, $zero
  .L8008B3E0:
    /* 7BBE0 8008B3E0 2A106A00 */  slt        $v0, $v1, $t2
    /* 7BBE4 8008B3E4 E2FF4014 */  bnez       $v0, .L8008B370
    /* 7BBE8 8008B3E8 80100300 */   sll       $v0, $v1, 2
  .L8008B3EC:
    /* 7BBEC 8008B3EC DAFF2015 */  bnez       $t1, .L8008B358
    /* 7BBF0 8008B3F0 21180000 */   addu      $v1, $zero, $zero
    /* 7BBF4 8008B3F4 0800E003 */  jr         $ra
    /* 7BBF8 8008B3F8 00000000 */   nop
endlabel Cars_SortCars__Fv
