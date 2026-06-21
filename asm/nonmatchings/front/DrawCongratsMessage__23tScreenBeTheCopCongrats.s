.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawCongratsMessage__23tScreenBeTheCopCongrats, 0xBC

glabel DrawCongratsMessage__23tScreenBeTheCopCongrats
    /* 39D2C 8004952C D8FEBD27 */  addiu      $sp, $sp, -0x128
    /* 39D30 80049530 1C01B1AF */  sw         $s1, 0x11C($sp)
    /* 39D34 80049534 21888000 */  addu       $s1, $a0, $zero
    /* 39D38 80049538 1801B0AF */  sw         $s0, 0x118($sp)
    /* 39D3C 8004953C 4C001024 */  addiu      $s0, $zero, 0x4C
    /* 39D40 80049540 29000224 */  addiu      $v0, $zero, 0x29
    /* 39D44 80049544 1000A2A7 */  sh         $v0, 0x10($sp)
    /* 39D48 80049548 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 39D4C 8004954C 1200A2A7 */  sh         $v0, 0x12($sp)
    /* 39D50 80049550 C8000224 */  addiu      $v0, $zero, 0xC8
    /* 39D54 80049554 1400A2A7 */  sh         $v0, 0x14($sp)
    /* 39D58 80049558 1600A2A7 */  sh         $v0, 0x16($sp)
    /* 39D5C 8004955C 1180023C */  lui        $v0, %hi(D_8011472D)
    /* 39D60 80049560 2D474390 */  lbu        $v1, %lo(D_8011472D)($v0)
    /* 39D64 80049564 1C000224 */  addiu      $v0, $zero, 0x1C
    /* 39D68 80049568 02006214 */  bne        $v1, $v0, .L80049574
    /* 39D6C 8004956C 2001BFAF */   sw        $ra, 0x120($sp)
    /* 39D70 80049570 4D001024 */  addiu      $s0, $zero, 0x4D
  .L80049574:
    /* 39D74 80049574 6B90030C */  jal        PAD_state
    /* 39D78 80049578 04000424 */   addiu     $a0, $zero, 0x4
    /* 39D7C 8004957C FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 39D80 80049580 04004010 */  beqz       $v0, .L80049594
    /* 39D84 80049584 00000000 */   nop
    /* 39D88 80049588 94002482 */  lb         $a0, 0x94($s1)
    /* 39D8C 8004958C 94E4020C */  jal        TextSys_Word__Fi
    /* 39D90 80049590 21018424 */   addiu     $a0, $a0, 0x121
  .L80049594:
    /* 39D94 80049594 94E4020C */  jal        TextSys_Word__Fi
    /* 39D98 80049598 21200002 */   addu      $a0, $s0, $zero
    /* 39D9C 8004959C 94002482 */  lb         $a0, 0x94($s1)
    /* 39DA0 800495A0 21884000 */  addu       $s1, $v0, $zero
    /* 39DA4 800495A4 94E4020C */  jal        TextSys_Word__Fi
    /* 39DA8 800495A8 21018424 */   addiu     $a0, $a0, 0x121
    /* 39DAC 800495AC 1800B027 */  addiu      $s0, $sp, 0x18
    /* 39DB0 800495B0 21200002 */  addu       $a0, $s0, $zero
    /* 39DB4 800495B4 21282002 */  addu       $a1, $s1, $zero
    /* 39DB8 800495B8 2F91030C */  jal        sprintf
    /* 39DBC 800495BC 21304000 */   addu      $a2, $v0, $zero
    /* 39DC0 800495C0 21200002 */  addu       $a0, $s0, $zero
    /* 39DC4 800495C4 1000A527 */  addiu      $a1, $sp, 0x10
    /* 39DC8 800495C8 01000624 */  addiu      $a2, $zero, 0x1
    /* 39DCC 800495CC FA85000C */  jal        FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
    /* 39DD0 800495D0 0A000724 */   addiu     $a3, $zero, 0xA
    /* 39DD4 800495D4 2001BF8F */  lw         $ra, 0x120($sp)
    /* 39DD8 800495D8 1C01B18F */  lw         $s1, 0x11C($sp)
    /* 39DDC 800495DC 1801B08F */  lw         $s0, 0x118($sp)
    /* 39DE0 800495E0 0800E003 */  jr         $ra
    /* 39DE4 800495E4 2801BD27 */   addiu     $sp, $sp, 0x128
endlabel DrawCongratsMessage__23tScreenBeTheCopCongrats
