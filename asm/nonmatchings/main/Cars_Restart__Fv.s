.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_Restart__Fv, 0xE8

glabel Cars_Restart__Fv
    /* 7ACCC 8008A4CC A802868F */  lw         $a2, %gp_rel(Cars_gNumCars)($gp)
    /* 7ACD0 8008A4D0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 7ACD4 8008A4D4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 7ACD8 8008A4D8 21800000 */  addu       $s0, $zero, $zero
    /* 7ACDC 8008A4DC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 7ACE0 8008A4E0 1200C018 */  blez       $a2, .L8008A52C
    /* 7ACE4 8008A4E4 1400B1AF */   sw        $s1, 0x14($sp)
    /* 7ACE8 8008A4E8 1180023C */  lui        $v0, %hi(Cars_gTotalSortedList)
    /* 7ACEC 8008A4EC 20FB4524 */  addiu      $a1, $v0, %lo(Cars_gTotalSortedList)
    /* 7ACF0 8008A4F0 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7ACF4 8008A4F4 DCF94324 */  addiu      $v1, $v0, %lo(Cars_gList)
    /* 7ACF8 8008A4F8 1180023C */  lui        $v0, %hi(Cars_gSortedList)
    /* 7ACFC 8008A4FC FCFA4424 */  addiu      $a0, $v0, %lo(Cars_gSortedList)
  .L8008A500:
    /* 7AD00 8008A500 0000628C */  lw         $v0, 0x0($v1)
    /* 7AD04 8008A504 01001026 */  addiu      $s0, $s0, 0x1
    /* 7AD08 8008A508 000082AC */  sw         $v0, 0x0($a0)
    /* 7AD0C 8008A50C 0000628C */  lw         $v0, 0x0($v1)
    /* 7AD10 8008A510 04006324 */  addiu      $v1, $v1, 0x4
    /* 7AD14 8008A514 04008424 */  addiu      $a0, $a0, 0x4
    /* 7AD18 8008A518 0000A2AC */  sw         $v0, 0x0($a1)
    /* 7AD1C 8008A51C 2A100602 */  slt        $v0, $s0, $a2
    /* 7AD20 8008A520 F7FF4014 */  bnez       $v0, .L8008A500
    /* 7AD24 8008A524 0400A524 */   addiu     $a1, $a1, 0x4
    /* 7AD28 8008A528 21800000 */  addu       $s0, $zero, $zero
  .L8008A52C:
    /* 7AD2C 8008A52C 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7AD30 8008A530 DCF95124 */  addiu      $s1, $v0, %lo(Cars_gList)
  .L8008A534:
    /* 7AD34 8008A534 A802828F */  lw         $v0, %gp_rel(Cars_gNumCars)($gp)
    /* 7AD38 8008A538 00000000 */  nop
    /* 7AD3C 8008A53C 2A100202 */  slt        $v0, $s0, $v0
    /* 7AD40 8008A540 07004010 */  beqz       $v0, .L8008A560
    /* 7AD44 8008A544 21280002 */   addu      $a1, $s0, $zero
    /* 7AD48 8008A548 0000248E */  lw         $a0, 0x0($s1)
    /* 7AD4C 8008A54C 04003126 */  addiu      $s1, $s1, 0x4
    /* 7AD50 8008A550 6227020C */  jal        Cars_IniCarObjects__FP8Car_tObji
    /* 7AD54 8008A554 01001026 */   addiu     $s0, $s0, 0x1
    /* 7AD58 8008A558 4D290208 */  j          .L8008A534
    /* 7AD5C 8008A55C 00000000 */   nop
  .L8008A560:
    /* 7AD60 8008A560 21800000 */  addu       $s0, $zero, $zero
  .L8008A564:
    /* 7AD64 8008A564 0198020C */  jal        Object_GetNumIMassObjects__Fv
    /* 7AD68 8008A568 00000000 */   nop
    /* 7AD6C 8008A56C 2A100202 */  slt        $v0, $s0, $v0
    /* 7AD70 8008A570 0A004010 */  beqz       $v0, .L8008A59C
    /* 7AD74 8008A574 40111000 */   sll       $v0, $s0, 5
    /* 7AD78 8008A578 1480033C */  lui        $v1, %hi(Object_IMassObjInst)
    /* 7AD7C 8008A57C D8D2638C */  lw         $v1, %lo(Object_IMassObjInst)($v1)
    /* 7AD80 8008A580 01001026 */  addiu      $s0, $s0, 0x1
    /* 7AD84 8008A584 21104300 */  addu       $v0, $v0, $v1
    /* 7AD88 8008A588 100040AC */  sw         $zero, 0x10($v0)
    /* 7AD8C 8008A58C 140040AC */  sw         $zero, 0x14($v0)
    /* 7AD90 8008A590 180040AC */  sw         $zero, 0x18($v0)
    /* 7AD94 8008A594 59290208 */  j          .L8008A564
    /* 7AD98 8008A598 1C0040AC */   sw        $zero, 0x1C($v0)
  .L8008A59C:
    /* 7AD9C 8008A59C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 7ADA0 8008A5A0 1400B18F */  lw         $s1, 0x14($sp)
    /* 7ADA4 8008A5A4 1000B08F */  lw         $s0, 0x10($sp)
    /* 7ADA8 8008A5A8 C80280AF */  sw         $zero, %gp_rel(accidentSlice)($gp)
    /* 7ADAC 8008A5AC 0800E003 */  jr         $ra
    /* 7ADB0 8008A5B0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Cars_Restart__Fv
