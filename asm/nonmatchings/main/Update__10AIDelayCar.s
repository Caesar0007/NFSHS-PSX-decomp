.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Update__10AIDelayCar, 0x250

glabel Update__10AIDelayCar
    /* 4B344 8005AB44 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 4B348 8005AB48 3000B0AF */  sw         $s0, 0x30($sp)
    /* 4B34C 8005AB4C 21808000 */  addu       $s0, $a0, $zero
    /* 4B350 8005AB50 3400BFAF */  sw         $ra, 0x34($sp)
    /* 4B354 8005AB54 0800048E */  lw         $a0, 0x8($s0)
    /* 4B358 8005AB58 0400058E */  lw         $a1, 0x4($s0)
    /* 4B35C 8005AB5C 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 4B360 8005AB60 00000000 */   nop
    /* 4B364 8005AB64 0C00048E */  lw         $a0, 0xC($s0)
    /* 4B368 8005AB68 0000058E */  lw         $a1, 0x0($s0)
    /* 4B36C 8005AB6C CA90030C */  jal        fixedmult
    /* 4B370 8005AB70 23204400 */   subu      $a0, $v0, $a0
    /* 4B374 8005AB74 AA2A043C */  lui        $a0, (0x2AAAAAAB >> 16)
    /* 4B378 8005AB78 0C00038E */  lw         $v1, 0xC($s0)
    /* 4B37C 8005AB7C ABAA8434 */  ori        $a0, $a0, (0x2AAAAAAB & 0xFFFF)
    /* 4B380 8005AB80 21186200 */  addu       $v1, $v1, $v0
    /* 4B384 8005AB84 18006400 */  mult       $v1, $a0
    /* 4B388 8005AB88 0C0003AE */  sw         $v1, 0xC($s0)
    /* 4B38C 8005AB8C C31F0300 */  sra        $v1, $v1, 31
    /* 4B390 8005AB90 10380000 */  mfhi       $a3
    /* 4B394 8005AB94 03140700 */  sra        $v0, $a3, 16
    /* 4B398 8005AB98 23184300 */  subu       $v1, $v0, $v1
    /* 4B39C 8005AB9C 0C006004 */  bltz       $v1, .L8005ABD0
    /* 4B3A0 8005ABA0 00000000 */   nop
    /* 4B3A4 8005ABA4 0400028E */  lw         $v0, 0x4($s0)
    /* 4B3A8 8005ABA8 00000000 */  nop
    /* 4B3AC 8005ABAC 08004284 */  lh         $v0, 0x8($v0)
    /* 4B3B0 8005ABB0 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 4B3B4 8005ABB4 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 4B3B8 8005ABB8 21184300 */  addu       $v1, $v0, $v1
    /* 4B3BC 8005ABBC 2A106400 */  slt        $v0, $v1, $a0
    /* 4B3C0 8005ABC0 0E004014 */  bnez       $v0, .L8005ABFC
    /* 4B3C4 8005ABC4 00000000 */   nop
    /* 4B3C8 8005ABC8 FF6A0108 */  j          .L8005ABFC
    /* 4B3CC 8005ABCC 23186400 */   subu      $v1, $v1, $a0
  .L8005ABD0:
    /* 4B3D0 8005ABD0 0400028E */  lw         $v0, 0x4($s0)
    /* 4B3D4 8005ABD4 00000000 */  nop
    /* 4B3D8 8005ABD8 08004284 */  lh         $v0, 0x8($v0)
    /* 4B3DC 8005ABDC 00000000 */  nop
    /* 4B3E0 8005ABE0 21184300 */  addu       $v1, $v0, $v1
    /* 4B3E4 8005ABE4 05006104 */  bgez       $v1, .L8005ABFC
    /* 4B3E8 8005ABE8 00000000 */   nop
    /* 4B3EC 8005ABEC 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4B3F0 8005ABF0 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4B3F4 8005ABF4 00000000 */  nop
    /* 4B3F8 8005ABF8 21186200 */  addu       $v1, $v1, $v0
  .L8005ABFC:
    /* 4B3FC 8005ABFC 0800028E */  lw         $v0, 0x8($s0)
    /* 4B400 8005AC00 100003AE */  sw         $v1, 0x10($s0)
    /* 4B404 8005AC04 0400038E */  lw         $v1, 0x4($s0)
    /* 4B408 8005AC08 A000448C */  lw         $a0, 0xA0($v0)
    /* 4B40C 8005AC0C A000628C */  lw         $v0, 0xA0($v1)
    /* 4B410 8005AC10 00000000 */  nop
    /* 4B414 8005AC14 23208200 */  subu       $a0, $a0, $v0
    /* 4B418 8005AC18 1000A4AF */  sw         $a0, 0x10($sp)
    /* 4B41C 8005AC1C 0800028E */  lw         $v0, 0x8($s0)
    /* 4B420 8005AC20 0400038E */  lw         $v1, 0x4($s0)
    /* 4B424 8005AC24 A400468C */  lw         $a2, 0xA4($v0)
    /* 4B428 8005AC28 A400628C */  lw         $v0, 0xA4($v1)
    /* 4B42C 8005AC2C 00000000 */  nop
    /* 4B430 8005AC30 2330C200 */  subu       $a2, $a2, $v0
    /* 4B434 8005AC34 1400A6AF */  sw         $a2, 0x14($sp)
    /* 4B438 8005AC38 0800028E */  lw         $v0, 0x8($s0)
    /* 4B43C 8005AC3C 0400058E */  lw         $a1, 0x4($s0)
    /* 4B440 8005AC40 A800438C */  lw         $v1, 0xA8($v0)
    /* 4B444 8005AC44 A800A28C */  lw         $v0, 0xA8($a1)
    /* 4B448 8005AC48 00000000 */  nop
    /* 4B44C 8005AC4C 23186200 */  subu       $v1, $v1, $v0
    /* 4B450 8005AC50 1800A3AF */  sw         $v1, 0x18($sp)
    /* 4B454 8005AC54 1400028E */  lw         $v0, 0x14($s0)
    /* 4B458 8005AC58 00000000 */  nop
    /* 4B45C 8005AC5C 23208200 */  subu       $a0, $a0, $v0
    /* 4B460 8005AC60 2000A4AF */  sw         $a0, 0x20($sp)
    /* 4B464 8005AC64 1800028E */  lw         $v0, 0x18($s0)
    /* 4B468 8005AC68 00000000 */  nop
    /* 4B46C 8005AC6C 2330C200 */  subu       $a2, $a2, $v0
    /* 4B470 8005AC70 2400A6AF */  sw         $a2, 0x24($sp)
    /* 4B474 8005AC74 1C00028E */  lw         $v0, 0x1C($s0)
    /* 4B478 8005AC78 00000000 */  nop
    /* 4B47C 8005AC7C 23186200 */  subu       $v1, $v1, $v0
    /* 4B480 8005AC80 2800A3AF */  sw         $v1, 0x28($sp)
    /* 4B484 8005AC84 0000058E */  lw         $a1, 0x0($s0)
    /* 4B488 8005AC88 CA90030C */  jal        fixedmult
    /* 4B48C 8005AC8C 00000000 */   nop
    /* 4B490 8005AC90 1400038E */  lw         $v1, 0x14($s0)
    /* 4B494 8005AC94 0000058E */  lw         $a1, 0x0($s0)
    /* 4B498 8005AC98 21186200 */  addu       $v1, $v1, $v0
    /* 4B49C 8005AC9C 140003AE */  sw         $v1, 0x14($s0)
    /* 4B4A0 8005ACA0 2400A48F */  lw         $a0, 0x24($sp)
    /* 4B4A4 8005ACA4 CA90030C */  jal        fixedmult
    /* 4B4A8 8005ACA8 00000000 */   nop
    /* 4B4AC 8005ACAC 1800038E */  lw         $v1, 0x18($s0)
    /* 4B4B0 8005ACB0 0000058E */  lw         $a1, 0x0($s0)
    /* 4B4B4 8005ACB4 21186200 */  addu       $v1, $v1, $v0
    /* 4B4B8 8005ACB8 180003AE */  sw         $v1, 0x18($s0)
    /* 4B4BC 8005ACBC 2800A48F */  lw         $a0, 0x28($sp)
    /* 4B4C0 8005ACC0 CA90030C */  jal        fixedmult
    /* 4B4C4 8005ACC4 00000000 */   nop
    /* 4B4C8 8005ACC8 1C00038E */  lw         $v1, 0x1C($s0)
    /* 4B4CC 8005ACCC 0400048E */  lw         $a0, 0x4($s0)
    /* 4B4D0 8005ACD0 21186200 */  addu       $v1, $v1, $v0
    /* 4B4D4 8005ACD4 1C0003AE */  sw         $v1, 0x1C($s0)
    /* 4B4D8 8005ACD8 A000828C */  lw         $v0, 0xA0($a0)
    /* 4B4DC 8005ACDC 1400038E */  lw         $v1, 0x14($s0)
    /* 4B4E0 8005ACE0 00000000 */  nop
    /* 4B4E4 8005ACE4 21104300 */  addu       $v0, $v0, $v1
    /* 4B4E8 8005ACE8 200002AE */  sw         $v0, 0x20($s0)
    /* 4B4EC 8005ACEC A400828C */  lw         $v0, 0xA4($a0)
    /* 4B4F0 8005ACF0 1800038E */  lw         $v1, 0x18($s0)
    /* 4B4F4 8005ACF4 00000000 */  nop
    /* 4B4F8 8005ACF8 21104300 */  addu       $v0, $v0, $v1
    /* 4B4FC 8005ACFC 240002AE */  sw         $v0, 0x24($s0)
    /* 4B500 8005AD00 A800828C */  lw         $v0, 0xA8($a0)
    /* 4B504 8005AD04 1C00038E */  lw         $v1, 0x1C($s0)
    /* 4B508 8005AD08 0000058E */  lw         $a1, 0x0($s0)
    /* 4B50C 8005AD0C 21104300 */  addu       $v0, $v0, $v1
    /* 4B510 8005AD10 280002AE */  sw         $v0, 0x28($s0)
    /* 4B514 8005AD14 0800028E */  lw         $v0, 0x8($s0)
    /* 4B518 8005AD18 21188000 */  addu       $v1, $a0, $zero
    /* 4B51C 8005AD1C 7405448C */  lw         $a0, 0x574($v0)
    /* 4B520 8005AD20 7405628C */  lw         $v0, 0x574($v1)
    /* 4B524 8005AD24 2C00038E */  lw         $v1, 0x2C($s0)
    /* 4B528 8005AD28 23208200 */  subu       $a0, $a0, $v0
    /* 4B52C 8005AD2C CA90030C */  jal        fixedmult
    /* 4B530 8005AD30 23208300 */   subu      $a0, $a0, $v1
    /* 4B534 8005AD34 2C00038E */  lw         $v1, 0x2C($s0)
    /* 4B538 8005AD38 0400048E */  lw         $a0, 0x4($s0)
    /* 4B53C 8005AD3C 21186200 */  addu       $v1, $v1, $v0
    /* 4B540 8005AD40 2C0003AE */  sw         $v1, 0x2C($s0)
    /* 4B544 8005AD44 7405858C */  lw         $a1, 0x574($a0)
    /* 4B548 8005AD48 1000048E */  lw         $a0, 0x10($s0)
    /* 4B54C 8005AD4C 2128A300 */  addu       $a1, $a1, $v1
    /* 4B550 8005AD50 33CD010C */  jal        AIWorld_LaneIndex__Fii
    /* 4B554 8005AD54 300005AE */   sw        $a1, 0x30($s0)
    /* 4B558 8005AD58 0800038E */  lw         $v1, 0x8($s0)
    /* 4B55C 8005AD5C 3800048E */  lw         $a0, 0x38($s0)
    /* 4B560 8005AD60 340002AE */  sw         $v0, 0x34($s0)
    /* 4B564 8005AD64 6405628C */  lw         $v0, 0x564($v1)
    /* 4B568 8005AD68 0000058E */  lw         $a1, 0x0($s0)
    /* 4B56C 8005AD6C CA90030C */  jal        fixedmult
    /* 4B570 8005AD70 23204400 */   subu      $a0, $v0, $a0
    /* 4B574 8005AD74 3800038E */  lw         $v1, 0x38($s0)
    /* 4B578 8005AD78 00000000 */  nop
    /* 4B57C 8005AD7C 21186200 */  addu       $v1, $v1, $v0
    /* 4B580 8005AD80 380003AE */  sw         $v1, 0x38($s0)
    /* 4B584 8005AD84 3400BF8F */  lw         $ra, 0x34($sp)
    /* 4B588 8005AD88 3000B08F */  lw         $s0, 0x30($sp)
    /* 4B58C 8005AD8C 0800E003 */  jr         $ra
    /* 4B590 8005AD90 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Update__10AIDelayCar
