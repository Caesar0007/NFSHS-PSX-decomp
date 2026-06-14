.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji, 0x8C

glabel AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji
    /* 5F550 8006ED50 1500A018 */  blez       $a1, .L8006EDA8
    /* 5F554 8006ED54 F2FF023C */   lui       $v0, (0xFFF2999A >> 16)
    /* 5F558 8006ED58 9A994234 */  ori        $v0, $v0, (0xFFF2999A & 0xFFFF)
    /* 5F55C 8006ED5C 9005848C */  lw         $a0, 0x590($a0)
    /* 5F560 8006ED60 2118A200 */  addu       $v1, $a1, $v0
    /* 5F564 8006ED64 02008104 */  bgez       $a0, .L8006ED70
    /* 5F568 8006ED68 032A0500 */   sra       $a1, $a1, 8
    /* 5F56C 8006ED6C FF008424 */  addiu      $a0, $a0, 0xFF
  .L8006ED70:
    /* 5F570 8006ED70 03120400 */  sra        $v0, $a0, 8
    /* 5F574 8006ED74 1800A200 */  mult       $a1, $v0
    /* 5F578 8006ED78 12280000 */  mflo       $a1
    /* 5F57C 8006ED7C 2A10A300 */  slt        $v0, $a1, $v1
    /* 5F580 8006ED80 02004010 */  beqz       $v0, .L8006ED8C
    /* 5F584 8006ED84 0800023C */   lui       $v0, (0x8E665 >> 16)
    /* 5F588 8006ED88 21286000 */  addu       $a1, $v1, $zero
  .L8006ED8C:
    /* 5F58C 8006ED8C 65E64234 */  ori        $v0, $v0, (0x8E665 & 0xFFFF)
    /* 5F590 8006ED90 2A104500 */  slt        $v0, $v0, $a1
    /* 5F594 8006ED94 0F004014 */  bnez       $v0, .L8006EDD4
    /* 5F598 8006ED98 00000000 */   nop
    /* 5F59C 8006ED9C 0800053C */  lui        $a1, (0x8E666 >> 16)
    /* 5F5A0 8006EDA0 75BB0108 */  j          .L8006EDD4
    /* 5F5A4 8006EDA4 66E6A534 */   ori       $a1, $a1, (0x8E666 & 0xFFFF)
  .L8006EDA8:
    /* 5F5A8 8006EDA8 0200A104 */  bgez       $a1, .L8006EDB4
    /* 5F5AC 8006EDAC 00000000 */   nop
    /* 5F5B0 8006EDB0 FF00A524 */  addiu      $a1, $a1, 0xFF
  .L8006EDB4:
    /* 5F5B4 8006EDB4 9005828C */  lw         $v0, 0x590($a0)
    /* 5F5B8 8006EDB8 00000000 */  nop
    /* 5F5BC 8006EDBC 02004104 */  bgez       $v0, .L8006EDC8
    /* 5F5C0 8006EDC0 032A0500 */   sra       $a1, $a1, 8
    /* 5F5C4 8006EDC4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006EDC8:
    /* 5F5C8 8006EDC8 03120200 */  sra        $v0, $v0, 8
    /* 5F5CC 8006EDCC 1800A200 */  mult       $a1, $v0
    /* 5F5D0 8006EDD0 12280000 */  mflo       $a1
  .L8006EDD4:
    /* 5F5D4 8006EDD4 0800E003 */  jr         $ra
    /* 5F5D8 8006EDD8 2110A000 */   addu      $v0, $a1, $zero
endlabel AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji
