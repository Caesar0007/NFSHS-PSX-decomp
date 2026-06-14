.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __gtdf2, 0xD4

glabel __gtdf2
    /* E0D14 800F0514 21408000 */  addu       $t0, $a0, $zero
    /* E0D18 800F0518 2148A000 */  addu       $t1, $a1, $zero
    /* E0D1C 800F051C 03002715 */  bne        $t1, $a3, .L800F052C
    /* E0D20 800F0520 FF7F033C */   lui       $v1, (0x7FFFFFFF >> 16)
    /* E0D24 800F0524 2E000611 */  beq        $t0, $a2, .L800F05E0
    /* E0D28 800F0528 21100000 */   addu      $v0, $zero, $zero
  .L800F052C:
    /* E0D2C 800F052C FFFF6334 */  ori        $v1, $v1, (0x7FFFFFFF & 0xFFFF)
    /* E0D30 800F0530 24102301 */  and        $v0, $t1, $v1
    /* E0D34 800F0534 0A004014 */  bnez       $v0, .L800F0560
    /* E0D38 800F0538 0080023C */   lui       $v0, (0x80000000 >> 16)
    /* E0D3C 800F053C 08000015 */  bnez       $t0, .L800F0560
    /* E0D40 800F0540 00000000 */   nop
    /* E0D44 800F0544 2410E300 */  and        $v0, $a3, $v1
    /* E0D48 800F0548 05004014 */  bnez       $v0, .L800F0560
    /* E0D4C 800F054C 0080023C */   lui       $v0, (0x80000000 >> 16)
    /* E0D50 800F0550 0400C014 */  bnez       $a2, .L800F0564
    /* E0D54 800F0554 24182201 */   and       $v1, $t1, $v0
    /* E0D58 800F0558 78C10308 */  j          .L800F05E0
    /* E0D5C 800F055C 21100000 */   addu      $v0, $zero, $zero
  .L800F0560:
    /* E0D60 800F0560 24182201 */  and        $v1, $t1, $v0
  .L800F0564:
    /* E0D64 800F0564 2410E200 */  and        $v0, $a3, $v0
    /* E0D68 800F0568 1D006214 */  bne        $v1, $v0, .L800F05E0
    /* E0D6C 800F056C 0100622C */   sltiu     $v0, $v1, 0x1
    /* E0D70 800F0570 03150900 */  sra        $v0, $t1, 20
    /* E0D74 800F0574 FF074430 */  andi       $a0, $v0, 0x7FF
    /* E0D78 800F0578 03150700 */  sra        $v0, $a3, 20
    /* E0D7C 800F057C FF074330 */  andi       $v1, $v0, 0x7FF
    /* E0D80 800F0580 2A106400 */  slt        $v0, $v1, $a0
    /* E0D84 800F0584 12004014 */  bnez       $v0, .L800F05D0
    /* E0D88 800F0588 0080023C */   lui       $v0, (0x80000000 >> 16)
    /* E0D8C 800F058C 14008314 */  bne        $a0, $v1, .L800F05E0
    /* E0D90 800F0590 00002229 */   slti      $v0, $t1, 0x0
    /* E0D94 800F0594 0F00023C */  lui        $v0, (0xFFFFF >> 16)
    /* E0D98 800F0598 FFFF4234 */  ori        $v0, $v0, (0xFFFFF & 0xFFFF)
    /* E0D9C 800F059C 24182201 */  and        $v1, $t1, $v0
    /* E0DA0 800F05A0 1000043C */  lui        $a0, (0x100000 >> 16)
    /* E0DA4 800F05A4 25186400 */  or         $v1, $v1, $a0
    /* E0DA8 800F05A8 2410E200 */  and        $v0, $a3, $v0
    /* E0DAC 800F05AC 25204400 */  or         $a0, $v0, $a0
    /* E0DB0 800F05B0 2A108300 */  slt        $v0, $a0, $v1
    /* E0DB4 800F05B4 06004014 */  bnez       $v0, .L800F05D0
    /* E0DB8 800F05B8 0080023C */   lui       $v0, (0x80000000 >> 16)
    /* E0DBC 800F05BC 08006414 */  bne        $v1, $a0, .L800F05E0
    /* E0DC0 800F05C0 00002229 */   slti      $v0, $t1, 0x0
    /* E0DC4 800F05C4 2B10C800 */  sltu       $v0, $a2, $t0
    /* E0DC8 800F05C8 04004010 */  beqz       $v0, .L800F05DC
    /* E0DCC 800F05CC 0080023C */   lui       $v0, (0x80000000 >> 16)
  .L800F05D0:
    /* E0DD0 800F05D0 24102201 */  and        $v0, $t1, $v0
    /* E0DD4 800F05D4 78C10308 */  j          .L800F05E0
    /* E0DD8 800F05D8 0100422C */   sltiu     $v0, $v0, 0x1
  .L800F05DC:
    /* E0DDC 800F05DC 00002229 */  slti       $v0, $t1, 0x0
  .L800F05E0:
    /* E0DE0 800F05E0 0800E003 */  jr         $ra
    /* E0DE4 800F05E4 00000000 */   nop
endlabel __gtdf2
    /* E0DE8 800F05E8 00000000 */  nop
    /* E0DEC 800F05EC 00000000 */  nop
    /* E0DF0 800F05F0 00000000 */  nop
