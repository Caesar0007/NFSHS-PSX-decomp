.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCurrentStickRange2__Fi, 0x5C

glabel GetCurrentStickRange2__Fi
    /* 100BC 8001F8BC 1480023C */  lui        $v0, %hi(gPadinfo)
    /* 100C0 8001F8C0 9CE84224 */  addiu      $v0, $v0, %lo(gPadinfo)
    /* 100C4 8001F8C4 40210400 */  sll        $a0, $a0, 5
    /* 100C8 8001F8C8 21208200 */  addu       $a0, $a0, $v0
    /* 100CC 8001F8CC 0A008290 */  lbu        $v0, 0xA($a0)
    /* 100D0 8001F8D0 80000324 */  addiu      $v1, $zero, 0x80
    /* 100D4 8001F8D4 23286200 */  subu       $a1, $v1, $v0
    /* 100D8 8001F8D8 0200A01C */  bgtz       $a1, .L8001F8E4
    /* 100DC 8001F8DC 00000000 */   nop
    /* 100E0 8001F8E0 80FF4524 */  addiu      $a1, $v0, -0x80
  .L8001F8E4:
    /* 100E4 8001F8E4 0B008490 */  lbu        $a0, 0xB($a0)
    /* 100E8 8001F8E8 00000000 */  nop
    /* 100EC 8001F8EC 23106400 */  subu       $v0, $v1, $a0
    /* 100F0 8001F8F0 0300401C */  bgtz       $v0, .L8001F900
    /* 100F4 8001F8F4 21184000 */   addu      $v1, $v0, $zero
    /* 100F8 8001F8F8 80FF8224 */  addiu      $v0, $a0, -0x80
    /* 100FC 8001F8FC 21184000 */  addu       $v1, $v0, $zero
  .L8001F900:
    /* 10100 8001F900 2A106500 */  slt        $v0, $v1, $a1
    /* 10104 8001F904 02004010 */  beqz       $v0, .L8001F910
    /* 10108 8001F908 00000000 */   nop
    /* 1010C 8001F90C 2118A000 */  addu       $v1, $a1, $zero
  .L8001F910:
    /* 10110 8001F910 0800E003 */  jr         $ra
    /* 10114 8001F914 21106000 */   addu      $v0, $v1, $zero
endlabel GetCurrentStickRange2__Fi
