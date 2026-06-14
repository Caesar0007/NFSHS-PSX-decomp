.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_Request__FP17CopSpeak_tRequest, 0x13C

glabel CopSpeak_Request__FP17CopSpeak_tRequest
    /* 8ACC8 8009A4C8 7C0B878F */  lw         $a3, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8ACCC 8009A4CC 00000000 */  nop
    /* 8ACD0 8009A4D0 3F00E228 */  slti       $v0, $a3, 0x3F
    /* 8ACD4 8009A4D4 02004010 */  beqz       $v0, .L8009A4E0
    /* 8ACD8 8009A4D8 21180000 */   addu      $v1, $zero, $zero
    /* 8ACDC 8009A4DC 0100E324 */  addiu      $v1, $a3, 0x1
  .L8009A4E0:
    /* 8ACE0 8009A4E0 800B828F */  lw         $v0, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8ACE4 8009A4E4 00000000 */  nop
    /* 8ACE8 8009A4E8 16006210 */  beq        $v1, $v0, .L8009A544
    /* 8ACEC 8009A4EC 1180033C */   lui       $v1, %hi(Copspeak_gBank)
    /* 8ACF0 8009A4F0 1E008280 */  lb         $v0, 0x1E($a0)
    /* 8ACF4 8009A4F4 A41E6324 */  addiu      $v1, $v1, %lo(Copspeak_gBank)
    /* 8ACF8 8009A4F8 00110200 */  sll        $v0, $v0, 4
    /* 8ACFC 8009A4FC 21284300 */  addu       $a1, $v0, $v1
    /* 8AD00 8009A500 0400A28C */  lw         $v0, 0x4($a1)
    /* 8AD04 8009A504 00000000 */  nop
    /* 8AD08 8009A508 0E004010 */  beqz       $v0, .L8009A544
    /* 8AD0C 8009A50C 00000000 */   nop
    /* 8AD10 8009A510 0800A28C */  lw         $v0, 0x8($a1)
    /* 8AD14 8009A514 00000000 */  nop
    /* 8AD18 8009A518 0A004010 */  beqz       $v0, .L8009A544
    /* 8AD1C 8009A51C 00000000 */   nop
    /* 8AD20 8009A520 1800838C */  lw         $v1, 0x18($a0)
    /* 8AD24 8009A524 00000000 */  nop
    /* 8AD28 8009A528 06006004 */  bltz       $v1, .L8009A544
    /* 8AD2C 8009A52C 00000000 */   nop
    /* 8AD30 8009A530 0C00A28C */  lw         $v0, 0xC($a1)
    /* 8AD34 8009A534 00000000 */  nop
    /* 8AD38 8009A538 2A104300 */  slt        $v0, $v0, $v1
    /* 8AD3C 8009A53C 03004010 */  beqz       $v0, .L8009A54C
    /* 8AD40 8009A540 00000000 */   nop
  .L8009A544:
    /* 8AD44 8009A544 0800E003 */  jr         $ra
    /* 8AD48 8009A548 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L8009A54C:
    /* 8AD4C 8009A54C 0000A28C */  lw         $v0, 0x0($a1)
    /* 8AD50 8009A550 00000000 */  nop
    /* 8AD54 8009A554 100082AC */  sw         $v0, 0x10($a0)
    /* 8AD58 8009A558 1800828C */  lw         $v0, 0x18($a0)
    /* 8AD5C 8009A55C 0800A38C */  lw         $v1, 0x8($a1)
    /* 8AD60 8009A560 C0100200 */  sll        $v0, $v0, 3
    /* 8AD64 8009A564 21104300 */  addu       $v0, $v0, $v1
    /* 8AD68 8009A568 0000428C */  lw         $v0, 0x0($v0)
    /* 8AD6C 8009A56C 00000000 */  nop
    /* 8AD70 8009A570 080082AC */  sw         $v0, 0x8($a0)
    /* 8AD74 8009A574 1800828C */  lw         $v0, 0x18($a0)
    /* 8AD78 8009A578 0800A38C */  lw         $v1, 0x8($a1)
    /* 8AD7C 8009A57C C0100200 */  sll        $v0, $v0, 3
    /* 8AD80 8009A580 21104300 */  addu       $v0, $v0, $v1
    /* 8AD84 8009A584 0400428C */  lw         $v0, 0x4($v0)
    /* 8AD88 8009A588 00000000 */  nop
    /* 8AD8C 8009A58C EDFF4010 */  beqz       $v0, .L8009A544
    /* 8AD90 8009A590 0C0082AC */   sw        $v0, 0xC($a0)
    /* 8AD94 8009A594 1180033C */  lui        $v1, %hi(CopSpeak_gQueue)
    /* 8AD98 8009A598 241F6324 */  addiu      $v1, $v1, %lo(CopSpeak_gQueue)
    /* 8AD9C 8009A59C 40110700 */  sll        $v0, $a3, 5
    /* 8ADA0 8009A5A0 7C0B858F */  lw         $a1, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8ADA4 8009A5A4 21104300 */  addu       $v0, $v0, $v1
    /* 8ADA8 8009A5A8 0000888C */  lw         $t0, 0x0($a0)
    /* 8ADAC 8009A5AC 0400898C */  lw         $t1, 0x4($a0)
    /* 8ADB0 8009A5B0 08008A8C */  lw         $t2, 0x8($a0)
    /* 8ADB4 8009A5B4 0C008B8C */  lw         $t3, 0xC($a0)
    /* 8ADB8 8009A5B8 000048AC */  sw         $t0, 0x0($v0)
    /* 8ADBC 8009A5BC 040049AC */  sw         $t1, 0x4($v0)
    /* 8ADC0 8009A5C0 08004AAC */  sw         $t2, 0x8($v0)
    /* 8ADC4 8009A5C4 0C004BAC */  sw         $t3, 0xC($v0)
    /* 8ADC8 8009A5C8 1000888C */  lw         $t0, 0x10($a0)
    /* 8ADCC 8009A5CC 1400898C */  lw         $t1, 0x14($a0)
    /* 8ADD0 8009A5D0 18008A8C */  lw         $t2, 0x18($a0)
    /* 8ADD4 8009A5D4 1C008B8C */  lw         $t3, 0x1C($a0)
    /* 8ADD8 8009A5D8 100048AC */  sw         $t0, 0x10($v0)
    /* 8ADDC 8009A5DC 140049AC */  sw         $t1, 0x14($v0)
    /* 8ADE0 8009A5E0 18004AAC */  sw         $t2, 0x18($v0)
    /* 8ADE4 8009A5E4 1C004BAC */  sw         $t3, 0x1C($v0)
    /* 8ADE8 8009A5E8 3F00A228 */  slti       $v0, $a1, 0x3F
    /* 8ADEC 8009A5EC 02004010 */  beqz       $v0, .L8009A5F8
    /* 8ADF0 8009A5F0 21300000 */   addu      $a2, $zero, $zero
    /* 8ADF4 8009A5F4 0100A624 */  addiu      $a2, $a1, 0x1
  .L8009A5F8:
    /* 8ADF8 8009A5F8 7C0B86AF */  sw         $a2, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8ADFC 8009A5FC 0800E003 */  jr         $ra
    /* 8AE00 8009A600 2110E000 */   addu      $v0, $a3, $zero
endlabel CopSpeak_Request__FP17CopSpeak_tRequest
