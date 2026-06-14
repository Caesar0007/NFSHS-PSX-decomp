.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching intarcsin, 0xC0

glabel intarcsin
    /* DB4D8 800EACD8 03008104 */  bgez       $a0, .L800EACE8
    /* DB4DC 800EACDC 21300000 */   addu      $a2, $zero, $zero
    /* DB4E0 800EACE0 23200400 */  negu       $a0, $a0
    /* DB4E4 800EACE4 01000624 */  addiu      $a2, $zero, 0x1
  .L800EACE8:
    /* DB4E8 800EACE8 00FA0234 */  ori        $v0, $zero, 0xFA00
    /* DB4EC 800EACEC 2A104400 */  slt        $v0, $v0, $a0
    /* DB4F0 800EACF0 0D004014 */  bnez       $v0, .L800EAD28
    /* DB4F4 800EACF4 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* DB4F8 800EACF8 40008230 */  andi       $v0, $a0, 0x40
    /* DB4FC 800EACFC 03004010 */  beqz       $v0, .L800EAD0C
    /* DB500 800EAD00 C3110400 */   sra       $v0, $a0, 7
    /* DB504 800EAD04 44AB0308 */  j          .L800EAD10
    /* DB508 800EAD08 01004524 */   addiu     $a1, $v0, 0x1
  .L800EAD0C:
    /* DB50C 800EAD0C C3290400 */  sra        $a1, $a0, 7
  .L800EAD10:
    /* DB510 800EAD10 1380023C */  lui        $v0, %hi(asintbl)
    /* DB514 800EAD14 60724224 */  addiu      $v0, $v0, %lo(asintbl)
    /* DB518 800EAD18 2110A200 */  addu       $v0, $a1, $v0
    /* DB51C 800EAD1C 00004290 */  lbu        $v0, 0x0($v0)
    /* DB520 800EAD20 61AB0308 */  j          .L800EAD84
    /* DB524 800EAD24 00000000 */   nop
  .L800EAD28:
    /* DB528 800EAD28 2A104400 */  slt        $v0, $v0, $a0
    /* DB52C 800EAD2C 15004014 */  bnez       $v0, .L800EAD84
    /* DB530 800EAD30 00010224 */   addiu     $v0, $zero, 0x100
    /* DB534 800EAD34 C3290400 */  sra        $a1, $a0, 7
    /* DB538 800EAD38 FF010224 */  addiu      $v0, $zero, 0x1FF
    /* DB53C 800EAD3C 0500A214 */  bne        $a1, $v0, .L800EAD54
    /* DB540 800EAD40 7F008430 */   andi      $a0, $a0, 0x7F
    /* DB544 800EAD44 1380023C */  lui        $v0, %hi(D_8013745F)
    /* DB548 800EAD48 5F744390 */  lbu        $v1, %lo(D_8013745F)($v0)
    /* DB54C 800EAD4C 5BAB0308 */  j          .L800EAD6C
    /* DB550 800EAD50 00010224 */   addiu     $v0, $zero, 0x100
  .L800EAD54:
    /* DB554 800EAD54 1380023C */  lui        $v0, %hi(asintbl)
    /* DB558 800EAD58 60724224 */  addiu      $v0, $v0, %lo(asintbl)
    /* DB55C 800EAD5C 2118A200 */  addu       $v1, $a1, $v0
    /* DB560 800EAD60 21106000 */  addu       $v0, $v1, $zero
    /* DB564 800EAD64 00006390 */  lbu        $v1, 0x0($v1)
    /* DB568 800EAD68 01004290 */  lbu        $v0, 0x1($v0)
  .L800EAD6C:
    /* DB56C 800EAD6C 00000000 */  nop
    /* DB570 800EAD70 23104300 */  subu       $v0, $v0, $v1
    /* DB574 800EAD74 18004400 */  mult       $v0, $a0
    /* DB578 800EAD78 12380000 */  mflo       $a3
    /* DB57C 800EAD7C C3110700 */  sra        $v0, $a3, 7
    /* DB580 800EAD80 21106200 */  addu       $v0, $v1, $v0
  .L800EAD84:
    /* DB584 800EAD84 0200C010 */  beqz       $a2, .L800EAD90
    /* DB588 800EAD88 00000000 */   nop
    /* DB58C 800EAD8C 23100200 */  negu       $v0, $v0
  .L800EAD90:
    /* DB590 800EAD90 0800E003 */  jr         $ra
    /* DB594 800EAD94 00000000 */   nop
endlabel intarcsin
