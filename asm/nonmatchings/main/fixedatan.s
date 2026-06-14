.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fixedatan, 0x148

glabel fixedatan
    /* DDD28 800ED528 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DDD2C 800ED52C 21188000 */  addu       $v1, $a0, $zero
    /* DDD30 800ED530 1800B0AF */  sw         $s0, 0x18($sp)
    /* DDD34 800ED534 2180A000 */  addu       $s0, $a1, $zero
    /* DDD38 800ED538 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* DDD3C 800ED53C 21880000 */  addu       $s1, $zero, $zero
    /* DDD40 800ED540 03000106 */  bgez       $s0, .L800ED550
    /* DDD44 800ED544 2000BFAF */   sw        $ra, 0x20($sp)
    /* DDD48 800ED548 02001124 */  addiu      $s1, $zero, 0x2
    /* DDD4C 800ED54C 23801000 */  negu       $s0, $s0
  .L800ED550:
    /* DDD50 800ED550 03006104 */  bgez       $v1, .L800ED560
    /* DDD54 800ED554 00000000 */   nop
    /* DDD58 800ED558 04003136 */  ori        $s1, $s1, 0x4
    /* DDD5C 800ED55C 23180300 */  negu       $v1, $v1
  .L800ED560:
    /* DDD60 800ED560 03007014 */  bne        $v1, $s0, .L800ED570
    /* DDD64 800ED564 2A100302 */   slt       $v0, $s0, $v1
    /* DDD68 800ED568 7AB50308 */  j          .L800ED5E8
    /* DDD6C 800ED56C 00200624 */   addiu     $a2, $zero, 0x2000
  .L800ED570:
    /* DDD70 800ED570 04004010 */  beqz       $v0, .L800ED584
    /* DDD74 800ED574 21106000 */   addu      $v0, $v1, $zero
    /* DDD78 800ED578 21180002 */  addu       $v1, $s0, $zero
    /* DDD7C 800ED57C 21804000 */  addu       $s0, $v0, $zero
    /* DDD80 800ED580 01003136 */  ori        $s1, $s1, 0x1
  .L800ED584:
    /* DDD84 800ED584 1000A427 */  addiu      $a0, $sp, 0x10
    /* DDD88 800ED588 21286000 */  addu       $a1, $v1, $zero
    /* DDD8C 800ED58C 22F9030C */  jal        make64
    /* DDD90 800ED590 20000624 */   addiu     $a2, $zero, 0x20
    /* DDD94 800ED594 1000A48F */  lw         $a0, 0x10($sp)
    /* DDD98 800ED598 1400A58F */  lw         $a1, 0x14($sp)
    /* DDD9C 800ED59C 38F9030C */  jal        divu64
    /* DDDA0 800ED5A0 21300002 */   addu      $a2, $s0, $zero
    /* DDDA4 800ED5A4 022A0200 */  srl        $a1, $v0, 8
    /* DDDA8 800ED5A8 02160200 */  srl        $v0, $v0, 24
    /* DDDAC 800ED5AC 1380043C */  lui        $a0, %hi(fatantbl)
    /* DDDB0 800ED5B0 68788424 */  addiu      $a0, $a0, %lo(fatantbl)
    /* DDDB4 800ED5B4 80180200 */  sll        $v1, $v0, 2
    /* DDDB8 800ED5B8 21186400 */  addu       $v1, $v1, $a0
    /* DDDBC 800ED5BC 01004224 */  addiu      $v0, $v0, 0x1
    /* DDDC0 800ED5C0 80100200 */  sll        $v0, $v0, 2
    /* DDDC4 800ED5C4 21104400 */  addu       $v0, $v0, $a0
    /* DDDC8 800ED5C8 0000668C */  lw         $a2, 0x0($v1)
    /* DDDCC 800ED5CC 0000428C */  lw         $v0, 0x0($v0)
    /* DDDD0 800ED5D0 FFFFA530 */  andi       $a1, $a1, 0xFFFF
    /* DDDD4 800ED5D4 23104600 */  subu       $v0, $v0, $a2
    /* DDDD8 800ED5D8 18004500 */  mult       $v0, $a1
    /* DDDDC 800ED5DC 12380000 */  mflo       $a3
    /* DDDE0 800ED5E0 02140700 */  srl        $v0, $a3, 16
    /* DDDE4 800ED5E4 2130C200 */  addu       $a2, $a2, $v0
  .L800ED5E8:
    /* DDDE8 800ED5E8 0800222E */  sltiu      $v0, $s1, 0x8
    /* DDDEC 800ED5EC 1A004010 */  beqz       $v0, .L800ED658
    /* DDDF0 800ED5F0 0580023C */   lui       $v0, %hi(jtbl_80056CB8)
    /* DDDF4 800ED5F4 B86C4224 */  addiu      $v0, $v0, %lo(jtbl_80056CB8)
    /* DDDF8 800ED5F8 80181100 */  sll        $v1, $s1, 2
    /* DDDFC 800ED5FC 21186200 */  addu       $v1, $v1, $v0
    /* DDE00 800ED600 0000628C */  lw         $v0, 0x0($v1)
    /* DDE04 800ED604 00000000 */  nop
    /* DDE08 800ED608 08004000 */  jr         $v0
    /* DDE0C 800ED60C 00000000 */   nop
  jlabel .L800ED610
    /* DDE10 800ED610 23100600 */  negu       $v0, $a2
    /* DDE14 800ED614 96B50308 */  j          .L800ED658
    /* DDE18 800ED618 00404624 */   addiu     $a2, $v0, 0x4000
  jlabel .L800ED61C
    /* DDE1C 800ED61C 00800234 */  ori        $v0, $zero, 0x8000
    /* DDE20 800ED620 97B50308 */  j          .L800ED65C
    /* DDE24 800ED624 23104600 */   subu      $v0, $v0, $a2
  jlabel .L800ED628
    /* DDE28 800ED628 97B50308 */  j          .L800ED65C
    /* DDE2C 800ED62C 0040C224 */   addiu     $v0, $a2, 0x4000
  jlabel .L800ED630
    /* DDE30 800ED630 97B50308 */  j          .L800ED65C
    /* DDE34 800ED634 23100600 */   negu      $v0, $a2
  jlabel .L800ED638
    /* DDE38 800ED638 97B50308 */  j          .L800ED65C
    /* DDE3C 800ED63C 00C0C224 */   addiu     $v0, $a2, -0x4000
  jlabel .L800ED640
    /* DDE40 800ED640 00800224 */  addiu      $v0, $zero, -0x8000
    /* DDE44 800ED644 97B50308 */  j          .L800ED65C
    /* DDE48 800ED648 2110C200 */   addu      $v0, $a2, $v0
  jlabel .L800ED64C
    /* DDE4C 800ED64C 23100600 */  negu       $v0, $a2
    /* DDE50 800ED650 97B50308 */  j          .L800ED65C
    /* DDE54 800ED654 00C04224 */   addiu     $v0, $v0, -0x4000
  jlabel .L800ED658
    /* DDE58 800ED658 2110C000 */  addu       $v0, $a2, $zero
  .L800ED65C:
    /* DDE5C 800ED65C 2000BF8F */  lw         $ra, 0x20($sp)
    /* DDE60 800ED660 1C00B18F */  lw         $s1, 0x1C($sp)
    /* DDE64 800ED664 1800B08F */  lw         $s0, 0x18($sp)
    /* DDE68 800ED668 0800E003 */  jr         $ra
    /* DDE6C 800ED66C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel fixedatan
