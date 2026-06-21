.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetPads__Fv, 0x13C

glabel SetPads__Fv
    /* 17D0C 8002750C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 17D10 80027510 2400B5AF */  sw         $s5, 0x24($sp)
    /* 17D14 80027514 21A80000 */  addu       $s5, $zero, $zero
    /* 17D18 80027518 3000BEAF */  sw         $fp, 0x30($sp)
    /* 17D1C 8002751C 14801E3C */  lui        $fp, %hi(ticks)
    /* 17D20 80027520 1180023C */  lui        $v0, %hi(frontEnd)
    /* 17D24 80027524 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 17D28 80027528 00465724 */  addiu      $s7, $v0, %lo(frontEnd)
    /* 17D2C 8002752C 3400BFAF */  sw         $ra, 0x34($sp)
    /* 17D30 80027530 2800B6AF */  sw         $s6, 0x28($sp)
    /* 17D34 80027534 2000B4AF */  sw         $s4, 0x20($sp)
    /* 17D38 80027538 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 17D3C 8002753C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 17D40 80027540 1400B1AF */  sw         $s1, 0x14($sp)
    /* 17D44 80027544 1000B0AF */  sw         $s0, 0x10($sp)
  .L80027548:
    /* 17D48 80027548 0200A22A */  slti       $v0, $s5, 0x2
    /* 17D4C 8002754C 32004010 */  beqz       $v0, .L80027618
    /* 17D50 80027550 04001624 */   addiu     $s6, $zero, 0x4
    /* 17D54 80027554 4804E28E */  lw         $v0, 0x448($s7)
    /* 17D58 80027558 00000000 */  nop
    /* 17D5C 8002755C 02004010 */  beqz       $v0, .L80027568
    /* 17D60 80027560 0488D502 */   sllv      $s1, $s5, $s6
    /* 17D64 80027564 07001624 */  addiu      $s6, $zero, 0x7
  .L80027568:
    /* 17D68 80027568 ACDCD08F */  lw         $s0, %lo(ticks)($fp)
  .L8002756C:
    /* 17D6C 8002756C ACDCC28F */  lw         $v0, %lo(ticks)($fp)
    /* 17D70 80027570 00000000 */  nop
    /* 17D74 80027574 23105000 */  subu       $v0, $v0, $s0
    /* 17D78 80027578 80004228 */  slti       $v0, $v0, 0x80
    /* 17D7C 8002757C 05004010 */  beqz       $v0, .L80027594
    /* 17D80 80027580 21180000 */   addu      $v1, $zero, $zero
    /* 17D84 80027584 A8BF030C */  jal        PadGetState
    /* 17D88 80027588 21202002 */   addu      $a0, $s1, $zero
    /* 17D8C 8002758C 06004238 */  xori       $v0, $v0, 0x6
    /* 17D90 80027590 2B180200 */  sltu       $v1, $zero, $v0
  .L80027594:
    /* 17D94 80027594 F5FF6014 */  bnez       $v1, .L8002756C
    /* 17D98 80027598 00000000 */   nop
    /* 17D9C 8002759C A8BF030C */  jal        PadGetState
    /* 17DA0 800275A0 21202002 */   addu      $a0, $s1, $zero
    /* 17DA4 800275A4 06000324 */  addiu      $v1, $zero, 0x6
    /* 17DA8 800275A8 18004314 */  bne        $v0, $v1, .L8002760C
    /* 17DAC 800275AC 21A00000 */   addu      $s4, $zero, $zero
    /* 17DB0 800275B0 21988002 */  addu       $s3, $s4, $zero
    /* 17DB4 800275B4 21202002 */  addu       $a0, $s1, $zero
    /* 17DB8 800275B8 04000524 */  addiu      $a1, $zero, 0x4
    /* 17DBC 800275BC D8BF030C */  jal        PadInfoMode
    /* 17DC0 800275C0 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 17DC4 800275C4 21904000 */  addu       $s2, $v0, $zero
    /* 17DC8 800275C8 21808002 */  addu       $s0, $s4, $zero
  .L800275CC:
    /* 17DCC 800275CC 2A101202 */  slt        $v0, $s0, $s2
    /* 17DD0 800275D0 0A004010 */  beqz       $v0, .L800275FC
    /* 17DD4 800275D4 21202002 */   addu      $a0, $s1, $zero
    /* 17DD8 800275D8 04000524 */  addiu      $a1, $zero, 0x4
    /* 17DDC 800275DC D8BF030C */  jal        PadInfoMode
    /* 17DE0 800275E0 21300002 */   addu      $a2, $s0, $zero
    /* 17DE4 800275E4 03005614 */  bne        $v0, $s6, .L800275F4
    /* 17DE8 800275E8 00000000 */   nop
    /* 17DEC 800275EC 01001324 */  addiu      $s3, $zero, 0x1
    /* 17DF0 800275F0 21A00002 */  addu       $s4, $s0, $zero
  .L800275F4:
    /* 17DF4 800275F4 739D0008 */  j          .L800275CC
    /* 17DF8 800275F8 01001026 */   addiu     $s0, $s0, 0x1
  .L800275FC:
    /* 17DFC 800275FC 03006012 */  beqz       $s3, .L8002760C
    /* 17E00 80027600 21288002 */   addu      $a1, $s4, $zero
    /* 17E04 80027604 59C0030C */  jal        PadSetMainMode
    /* 17E08 80027608 21300000 */   addu      $a2, $zero, $zero
  .L8002760C:
    /* 17E0C 8002760C 0400F726 */  addiu      $s7, $s7, 0x4
    /* 17E10 80027610 529D0008 */  j          .L80027548
    /* 17E14 80027614 0100B526 */   addiu     $s5, $s5, 0x1
  .L80027618:
    /* 17E18 80027618 3400BF8F */  lw         $ra, 0x34($sp)
    /* 17E1C 8002761C 3000BE8F */  lw         $fp, 0x30($sp)
    /* 17E20 80027620 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 17E24 80027624 2800B68F */  lw         $s6, 0x28($sp)
    /* 17E28 80027628 2400B58F */  lw         $s5, 0x24($sp)
    /* 17E2C 8002762C 2000B48F */  lw         $s4, 0x20($sp)
    /* 17E30 80027630 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 17E34 80027634 1800B28F */  lw         $s2, 0x18($sp)
    /* 17E38 80027638 1400B18F */  lw         $s1, 0x14($sp)
    /* 17E3C 8002763C 1000B08F */  lw         $s0, 0x10($sp)
    /* 17E40 80027640 0800E003 */  jr         $ra
    /* 17E44 80027644 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel SetPads__Fv
