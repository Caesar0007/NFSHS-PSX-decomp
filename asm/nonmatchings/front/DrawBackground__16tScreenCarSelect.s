.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__16tScreenCarSelect, 0x130

glabel DrawBackground__16tScreenCarSelect
    /* 2CD3C 8003C53C 18FFBD27 */  addiu      $sp, $sp, -0xE8
    /* 2CD40 8003C540 E000B0AF */  sw         $s0, 0xE0($sp)
    /* 2CD44 8003C544 21808000 */  addu       $s0, $a0, $zero
    /* 2CD48 8003C548 E400BFAF */  sw         $ra, 0xE4($sp)
    /* 2CD4C 8003C54C 6000028E */  lw         $v0, 0x60($s0)
    /* 2CD50 8003C550 1000A527 */  addiu      $a1, $sp, 0x10
    /* 2CD54 8003C554 68004484 */  lh         $a0, 0x68($v0)
    /* 2CD58 8003C558 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2CD5C 8003C55C 00000000 */  nop
    /* 2CD60 8003C560 09F84000 */  jalr       $v0
    /* 2CD64 8003C564 21200402 */   addu      $a0, $s0, $a0
    /* 2CD68 8003C568 30004010 */  beqz       $v0, .L8003C62C
    /* 2CD6C 8003C56C 21200002 */   addu      $a0, $s0, $zero
    /* 2CD70 8003C570 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 2CD74 8003C574 28000526 */   addiu     $a1, $s0, 0x28
    /* 2CD78 8003C578 2C00028E */  lw         $v0, 0x2C($s0)
    /* 2CD7C 8003C57C 00000000 */  nop
    /* 2CD80 8003C580 17004010 */  beqz       $v0, .L8003C5E0
    /* 2CD84 8003C584 21200000 */   addu      $a0, $zero, $zero
    /* 2CD88 8003C588 18030386 */  lh         $v1, 0x318($s0)
    /* 2CD8C 8003C58C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2CD90 8003C590 13006210 */  beq        $v1, $v0, .L8003C5E0
    /* 2CD94 8003C594 0580023C */   lui       $v0, %hi(FEApp)
    /* 2CD98 8003C598 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 2CD9C 8003C59C 0580033C */  lui        $v1, %hi(gCarObj)
    /* 2CDA0 8003C5A0 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 2CDA4 8003C5A4 682A6324 */  addiu      $v1, $v1, %lo(gCarObj)
    /* 2CDA8 8003C5A8 80100200 */  sll        $v0, $v0, 2
    /* 2CDAC 8003C5AC 21104300 */  addu       $v0, $v0, $v1
    /* 2CDB0 8003C5B0 0000428C */  lw         $v0, 0x0($v0)
    /* 2CDB4 8003C5B4 00000000 */  nop
    /* 2CDB8 8003C5B8 D808428C */  lw         $v0, 0x8D8($v0)
    /* 2CDBC 8003C5BC 00000000 */  nop
    /* 2CDC0 8003C5C0 07004014 */  bnez       $v0, .L8003C5E0
    /* 2CDC4 8003C5C4 1480023C */   lui       $v0, %hi(ticks)
    /* 2CDC8 8003C5C8 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2CDCC 8003C5CC 7C03038E */  lw         $v1, 0x37C($s0)
    /* 2CDD0 8003C5D0 00000000 */  nop
    /* 2CDD4 8003C5D4 23104300 */  subu       $v0, $v0, $v1
    /* 2CDD8 8003C5D8 81004228 */  slti       $v0, $v0, 0x81
    /* 2CDDC 8003C5DC 01004438 */  xori       $a0, $v0, 0x1
  .L8003C5E0:
    /* 2CDE0 8003C5E0 12008010 */  beqz       $a0, .L8003C62C
    /* 2CDE4 8003C5E4 21200002 */   addu      $a0, $s0, $zero
    /* 2CDE8 8003C5E8 F497000C */  jal        UploadSwapShapes__7tScreeni
    /* 2CDEC 8003C5EC 0B000524 */   addiu     $a1, $zero, 0xB
    /* 2CDF0 8003C5F0 BEDB000C */  jal        TurnOn__10tVideoWall
    /* 2CDF4 8003C5F4 04030426 */   addiu     $a0, $s0, 0x304
    /* 2CDF8 8003C5F8 74030386 */  lh         $v1, 0x374($s0)
    /* 2CDFC 8003C5FC 78030286 */  lh         $v0, 0x378($s0)
    /* 2CE00 8003C600 00000000 */  nop
    /* 2CE04 8003C604 09006214 */  bne        $v1, $v0, .L8003C62C
    /* 2CE08 8003C608 00000000 */   nop
    /* 2CE0C 8003C60C 1700A293 */  lbu        $v0, 0x17($sp)
    /* 2CE10 8003C610 00000000 */  nop
    /* 2CE14 8003C614 02004010 */  beqz       $v0, .L8003C620
    /* 2CE18 8003C618 20000524 */   addiu     $a1, $zero, 0x20
    /* 2CE1C 8003C61C 80000524 */  addiu      $a1, $zero, 0x80
  .L8003C620:
    /* 2CE20 8003C620 21200002 */  addu       $a0, $s0, $zero
    /* 2CE24 8003C624 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2CE28 8003C628 21300000 */   addu      $a2, $zero, $zero
  .L8003C62C:
    /* 2CE2C 8003C62C 5C000286 */  lh         $v0, 0x5C($s0)
    /* 2CE30 8003C630 00000000 */  nop
    /* 2CE34 8003C634 80004228 */  slti       $v0, $v0, 0x80
    /* 2CE38 8003C638 08004010 */  beqz       $v0, .L8003C65C
    /* 2CE3C 8003C63C 21280000 */   addu      $a1, $zero, $zero
    /* 2CE40 8003C640 6000028E */  lw         $v0, 0x60($s0)
    /* 2CE44 8003C644 00000000 */  nop
    /* 2CE48 8003C648 50004484 */  lh         $a0, 0x50($v0)
    /* 2CE4C 8003C64C 5400428C */  lw         $v0, 0x54($v0)
    /* 2CE50 8003C650 00000000 */  nop
    /* 2CE54 8003C654 09F84000 */  jalr       $v0
    /* 2CE58 8003C658 21200402 */   addu      $a0, $s0, $a0
  .L8003C65C:
    /* 2CE5C 8003C65C E400BF8F */  lw         $ra, 0xE4($sp)
    /* 2CE60 8003C660 E000B08F */  lw         $s0, 0xE0($sp)
    /* 2CE64 8003C664 0800E003 */  jr         $ra
    /* 2CE68 8003C668 E800BD27 */   addiu     $sp, $sp, 0xE8
endlabel DrawBackground__16tScreenCarSelect
