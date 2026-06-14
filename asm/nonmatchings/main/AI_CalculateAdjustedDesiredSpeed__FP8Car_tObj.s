.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj, 0x298

glabel AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj
    /* 4AB90 8005A390 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 4AB94 8005A394 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4AB98 8005A398 21888000 */  addu       $s1, $a0, $zero
    /* 4AB9C 8005A39C 1180023C */  lui        $v0, %hi(AI_Info)
    /* 4ABA0 8005A3A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4ABA4 8005A3A4 F0CC5024 */  addiu      $s0, $v0, %lo(AI_Info)
    /* 4ABA8 8005A3A8 2400BFAF */  sw         $ra, 0x24($sp)
    /* 4ABAC 8005A3AC 2000B4AF */  sw         $s4, 0x20($sp)
    /* 4ABB0 8005A3B0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 4ABB4 8005A3B4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4ABB8 8005A3B8 3C00038E */  lw         $v1, 0x3C($s0)
    /* 4ABBC 8005A3BC C406228E */  lw         $v0, 0x6C4($s1)
    /* 4ABC0 8005A3C0 00000000 */  nop
    /* 4ABC4 8005A3C4 4E006210 */  beq        $v1, $v0, .L8005A500
    /* 4ABC8 8005A3C8 1180023C */   lui       $v0, %hi(D_8010CD0C)
    /* 4ABCC 8005A3CC 0400058E */  lw         $a1, 0x4($s0)
    /* 4ABD0 8005A3D0 00000000 */  nop
    /* 4ABD4 8005A3D4 4A00A010 */  beqz       $a1, .L8005A500
    /* 4ABD8 8005A3D8 00000000 */   nop
    /* 4ABDC 8005A3DC 7E01A294 */  lhu        $v0, 0x17E($a1)
    /* 4ABE0 8005A3E0 00000000 */  nop
    /* 4ABE4 8005A3E4 46004014 */  bnez       $v0, .L8005A500
    /* 4ABE8 8005A3E8 1180023C */   lui       $v0, %hi(D_8010CD0C)
    /* 4ABEC 8005A3EC 89CC010C */  jal        AIWorld_SplineDistance__FP8Car_tObjT0
    /* 4ABF0 8005A3F0 00000000 */   nop
    /* 4ABF4 8005A3F4 06004018 */  blez       $v0, .L8005A410
    /* 4ABF8 8005A3F8 00000000 */   nop
    /* 4ABFC 8005A3FC 0400058E */  lw         $a1, 0x4($s0)
    /* 4AC00 8005A400 89CC010C */  jal        AIWorld_SplineDistance__FP8Car_tObjT0
    /* 4AC04 8005A404 21202002 */   addu      $a0, $s1, $zero
    /* 4AC08 8005A408 08690108 */  j          .L8005A420
    /* 4AC0C 8005A40C 21A04000 */   addu      $s4, $v0, $zero
  .L8005A410:
    /* 4AC10 8005A410 0400058E */  lw         $a1, 0x4($s0)
    /* 4AC14 8005A414 89CC010C */  jal        AIWorld_SplineDistance__FP8Car_tObjT0
    /* 4AC18 8005A418 21202002 */   addu      $a0, $s1, $zero
    /* 4AC1C 8005A41C 23A00200 */  negu       $s4, $v0
  .L8005A420:
    /* 4AC20 8005A420 1180023C */  lui        $v0, %hi(D_8010CCF4)
    /* 4AC24 8005A424 F4CC428C */  lw         $v0, %lo(D_8010CCF4)($v0)
    /* 4AC28 8005A428 6405238E */  lw         $v1, 0x564($s1)
    /* 4AC2C 8005A42C 6405428C */  lw         $v0, 0x564($v0)
    /* 4AC30 8005A430 00000000 */  nop
    /* 4AC34 8005A434 23906200 */  subu       $s2, $v1, $v0
    /* 4AC38 8005A438 0200401E */  bgtz       $s2, .L8005A444
    /* 4AC3C 8005A43C 00000000 */   nop
    /* 4AC40 8005A440 23904300 */  subu       $s2, $v0, $v1
  .L8005A444:
    /* 4AC44 8005A444 5805238E */  lw         $v1, 0x558($s1)
    /* 4AC48 8005A448 7405228E */  lw         $v0, 0x574($s1)
    /* 4AC4C 8005A44C 00000000 */  nop
    /* 4AC50 8005A450 23806200 */  subu       $s0, $v1, $v0
    /* 4AC54 8005A454 0200001E */  bgtz       $s0, .L8005A460
    /* 4AC58 8005A458 00000000 */   nop
    /* 4AC5C 8005A45C 23804300 */  subu       $s0, $v0, $v1
  .L8005A460:
    /* 4AC60 8005A460 47CE010C */  jal        AIWorld_CalcLateralVelocity__FP8Car_tObj
    /* 4AC64 8005A464 21202002 */   addu      $a0, $s1, $zero
    /* 4AC68 8005A468 05004018 */  blez       $v0, .L8005A480
    /* 4AC6C 8005A46C 00000000 */   nop
    /* 4AC70 8005A470 47CE010C */  jal        AIWorld_CalcLateralVelocity__FP8Car_tObj
    /* 4AC74 8005A474 21202002 */   addu      $a0, $s1, $zero
    /* 4AC78 8005A478 23690108 */  j          .L8005A48C
    /* 4AC7C 8005A47C 21984000 */   addu      $s3, $v0, $zero
  .L8005A480:
    /* 4AC80 8005A480 47CE010C */  jal        AIWorld_CalcLateralVelocity__FP8Car_tObj
    /* 4AC84 8005A484 21202002 */   addu      $a0, $s1, $zero
    /* 4AC88 8005A488 23980200 */  negu       $s3, $v0
  .L8005A48C:
    /* 4AC8C 8005A48C 21200002 */  addu       $a0, $s0, $zero
    /* 4AC90 8005A490 CA90030C */  jal        fixedmult
    /* 4AC94 8005A494 21284002 */   addu      $a1, $s2, $zero
    /* 4AC98 8005A498 21208002 */  addu       $a0, $s4, $zero
    /* 4AC9C 8005A49C 21286002 */  addu       $a1, $s3, $zero
    /* 4ACA0 8005A4A0 CA90030C */  jal        fixedmult
    /* 4ACA4 8005A4A4 21804000 */   addu      $s0, $v0, $zero
    /* 4ACA8 8005A4A8 21200002 */  addu       $a0, $s0, $zero
    /* 4ACAC 8005A4AC 0100053C */  lui        $a1, (0x13333 >> 16)
    /* 4ACB0 8005A4B0 3333A534 */  ori        $a1, $a1, (0x13333 & 0xFFFF)
    /* 4ACB4 8005A4B4 CA90030C */  jal        fixedmult
    /* 4ACB8 8005A4B8 21804000 */   addu      $s0, $v0, $zero
    /* 4ACBC 8005A4BC 2A105000 */  slt        $v0, $v0, $s0
    /* 4ACC0 8005A4C0 0E004010 */  beqz       $v0, .L8005A4FC
    /* 4ACC4 8005A4C4 1180023C */   lui       $v0, %hi(AI_Info)
    /* 4ACC8 8005A4C8 F0CC4424 */  addiu      $a0, $v0, %lo(AI_Info)
    /* 4ACCC 8005A4CC 3C00838C */  lw         $v1, 0x3C($a0)
    /* 4ACD0 8005A4D0 C406228E */  lw         $v0, 0x6C4($s1)
    /* 4ACD4 8005A4D4 00000000 */  nop
    /* 4ACD8 8005A4D8 2A104300 */  slt        $v0, $v0, $v1
    /* 4ACDC 8005A4DC 04004010 */  beqz       $v0, .L8005A4F0
    /* 4ACE0 8005A4E0 00000000 */   nop
    /* 4ACE4 8005A4E4 2000848C */  lw         $a0, 0x20($a0)
    /* 4ACE8 8005A4E8 41690108 */  j          .L8005A504
    /* 4ACEC 8005A4EC 00000000 */   nop
  .L8005A4F0:
    /* 4ACF0 8005A4F0 1800848C */  lw         $a0, 0x18($a0)
    /* 4ACF4 8005A4F4 41690108 */  j          .L8005A504
    /* 4ACF8 8005A4F8 00000000 */   nop
  .L8005A4FC:
    /* 4ACFC 8005A4FC 1180023C */  lui        $v0, %hi(D_8010CD0C)
  .L8005A500:
    /* 4AD00 8005A500 0CCD448C */  lw         $a0, %lo(D_8010CD0C)($v0)
  .L8005A504:
    /* 4AD04 8005A504 5405238E */  lw         $v1, 0x554($s1)
    /* 4AD08 8005A508 01000224 */  addiu      $v0, $zero, 0x1
    /* 4AD0C 8005A50C 0B006214 */  bne        $v1, $v0, .L8005A53C
    /* 4AD10 8005A510 00000000 */   nop
    /* 4AD14 8005A514 5C05228E */  lw         $v0, 0x55C($s1)
    /* 4AD18 8005A518 00000000 */  nop
    /* 4AD1C 8005A51C 2A108200 */  slt        $v0, $a0, $v0
    /* 4AD20 8005A520 02004010 */  beqz       $v0, .L8005A52C
    /* 4AD24 8005A524 FEFF033C */   lui       $v1, (0xFFFEB334 >> 16)
    /* 4AD28 8005A528 5C0524AE */  sw         $a0, 0x55C($s1)
  .L8005A52C:
    /* 4AD2C 8005A52C 5C05228E */  lw         $v0, 0x55C($s1)
    /* 4AD30 8005A530 34B36334 */  ori        $v1, $v1, (0xFFFEB334 & 0xFFFF)
    /* 4AD34 8005A534 58690108 */  j          .L8005A560
    /* 4AD38 8005A538 2A104300 */   slt       $v0, $v0, $v1
  .L8005A53C:
    /* 4AD3C 8005A53C 5C05228E */  lw         $v0, 0x55C($s1)
    /* 4AD40 8005A540 00000000 */  nop
    /* 4AD44 8005A544 2A104400 */  slt        $v0, $v0, $a0
    /* 4AD48 8005A548 02004010 */  beqz       $v0, .L8005A554
    /* 4AD4C 8005A54C 0100033C */   lui       $v1, (0x14CCC >> 16)
    /* 4AD50 8005A550 5C0524AE */  sw         $a0, 0x55C($s1)
  .L8005A554:
    /* 4AD54 8005A554 5C05228E */  lw         $v0, 0x55C($s1)
    /* 4AD58 8005A558 CC4C6334 */  ori        $v1, $v1, (0x14CCC & 0xFFFF)
    /* 4AD5C 8005A55C 2A106200 */  slt        $v0, $v1, $v0
  .L8005A560:
    /* 4AD60 8005A560 02004010 */  beqz       $v0, .L8005A56C
    /* 4AD64 8005A564 1180023C */   lui       $v0, %hi(AI_Info)
    /* 4AD68 8005A568 5C0523AE */  sw         $v1, 0x55C($s1)
  .L8005A56C:
    /* 4AD6C 8005A56C F0CC4424 */  addiu      $a0, $v0, %lo(AI_Info)
    /* 4AD70 8005A570 3C00838C */  lw         $v1, 0x3C($a0)
    /* 4AD74 8005A574 C406228E */  lw         $v0, 0x6C4($s1)
    /* 4AD78 8005A578 00000000 */  nop
    /* 4AD7C 8005A57C 22006210 */  beq        $v1, $v0, .L8005A608
    /* 4AD80 8005A580 00000000 */   nop
    /* 4AD84 8005A584 0400828C */  lw         $v0, 0x4($a0)
    /* 4AD88 8005A588 00000000 */  nop
    /* 4AD8C 8005A58C 1E004010 */  beqz       $v0, .L8005A608
    /* 4AD90 8005A590 0900033C */   lui       $v1, (0x9FFFF >> 16)
    /* 4AD94 8005A594 6405428C */  lw         $v0, 0x564($v0)
    /* 4AD98 8005A598 FFFF6334 */  ori        $v1, $v1, (0x9FFFF & 0xFFFF)
    /* 4AD9C 8005A59C 02004104 */  bgez       $v0, .L8005A5A8
    /* 4ADA0 8005A5A0 00000000 */   nop
    /* 4ADA4 8005A5A4 23100200 */  negu       $v0, $v0
  .L8005A5A8:
    /* 4ADA8 8005A5A8 2A186200 */  slt        $v1, $v1, $v0
    /* 4ADAC 8005A5AC 16006014 */  bnez       $v1, .L8005A608
    /* 4ADB0 8005A5B0 01000224 */   addiu     $v0, $zero, 0x1
    /* 4ADB4 8005A5B4 5405238E */  lw         $v1, 0x554($s1)
    /* 4ADB8 8005A5B8 00000000 */  nop
    /* 4ADBC 8005A5BC 0A006214 */  bne        $v1, $v0, .L8005A5E8
    /* 4ADC0 8005A5C0 F9FF023C */   lui       $v0, (0xFFF95556 >> 16)
    /* 4ADC4 8005A5C4 5C05238E */  lw         $v1, 0x55C($s1)
    /* 4ADC8 8005A5C8 0600023C */  lui        $v0, (0x6AAAA >> 16)
    /* 4ADCC 8005A5CC AAAA4234 */  ori        $v0, $v0, (0x6AAAA & 0xFFFF)
    /* 4ADD0 8005A5D0 2A106200 */  slt        $v0, $v1, $v0
    /* 4ADD4 8005A5D4 0B004010 */  beqz       $v0, .L8005A604
    /* 4ADD8 8005A5D8 00000000 */   nop
    /* 4ADDC 8005A5DC 0600033C */  lui        $v1, (0x6AAAA >> 16)
    /* 4ADE0 8005A5E0 81690108 */  j          .L8005A604
    /* 4ADE4 8005A5E4 AAAA6334 */   ori       $v1, $v1, (0x6AAAA & 0xFFFF)
  .L8005A5E8:
    /* 4ADE8 8005A5E8 5C05238E */  lw         $v1, 0x55C($s1)
    /* 4ADEC 8005A5EC 56554234 */  ori        $v0, $v0, (0xFFF95556 & 0xFFFF)
    /* 4ADF0 8005A5F0 2A104300 */  slt        $v0, $v0, $v1
    /* 4ADF4 8005A5F4 03004010 */  beqz       $v0, .L8005A604
    /* 4ADF8 8005A5F8 00000000 */   nop
    /* 4ADFC 8005A5FC F9FF033C */  lui        $v1, (0xFFF95556 >> 16)
    /* 4AE00 8005A600 56556334 */  ori        $v1, $v1, (0xFFF95556 & 0xFFFF)
  .L8005A604:
    /* 4AE04 8005A604 5C0523AE */  sw         $v1, 0x55C($s1)
  .L8005A608:
    /* 4AE08 8005A608 2400BF8F */  lw         $ra, 0x24($sp)
    /* 4AE0C 8005A60C 2000B48F */  lw         $s4, 0x20($sp)
    /* 4AE10 8005A610 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 4AE14 8005A614 1800B28F */  lw         $s2, 0x18($sp)
    /* 4AE18 8005A618 1400B18F */  lw         $s1, 0x14($sp)
    /* 4AE1C 8005A61C 1000B08F */  lw         $s0, 0x10($sp)
    /* 4AE20 8005A620 0800E003 */  jr         $ra
    /* 4AE24 8005A624 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj
