.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_FixEngineRpm__FP8Car_tObj, 0x158

glabel Physics_FixEngineRpm__FP8Car_tObj
    /* 9ACE4 800AA4E4 AC00838C */  lw         $v1, 0xAC($a0)
    /* 9ACE8 800AA4E8 00000000 */  nop
    /* 9ACEC 800AA4EC 02006104 */  bgez       $v1, .L800AA4F8
    /* 9ACF0 800AA4F0 00000000 */   nop
    /* 9ACF4 800AA4F4 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AA4F8:
    /* 9ACF8 800AA4F8 C401828C */  lw         $v0, 0x1C4($a0)
    /* 9ACFC 800AA4FC 00000000 */  nop
    /* 9AD00 800AA500 02004104 */  bgez       $v0, .L800AA50C
    /* 9AD04 800AA504 032A0300 */   sra       $a1, $v1, 8
    /* 9AD08 800AA508 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AA50C:
    /* 9AD0C 800AA50C 03120200 */  sra        $v0, $v0, 8
    /* 9AD10 800AA510 1800A200 */  mult       $a1, $v0
    /* 9AD14 800AA514 B000838C */  lw         $v1, 0xB0($a0)
    /* 9AD18 800AA518 12280000 */  mflo       $a1
    /* 9AD1C 800AA51C 02006104 */  bgez       $v1, .L800AA528
    /* 9AD20 800AA520 00000000 */   nop
    /* 9AD24 800AA524 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AA528:
    /* 9AD28 800AA528 C801828C */  lw         $v0, 0x1C8($a0)
    /* 9AD2C 800AA52C 00000000 */  nop
    /* 9AD30 800AA530 02004104 */  bgez       $v0, .L800AA53C
    /* 9AD34 800AA534 031A0300 */   sra       $v1, $v1, 8
    /* 9AD38 800AA538 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AA53C:
    /* 9AD3C 800AA53C 03120200 */  sra        $v0, $v0, 8
    /* 9AD40 800AA540 18006200 */  mult       $v1, $v0
    /* 9AD44 800AA544 B400838C */  lw         $v1, 0xB4($a0)
    /* 9AD48 800AA548 12380000 */  mflo       $a3
    /* 9AD4C 800AA54C 02006104 */  bgez       $v1, .L800AA558
    /* 9AD50 800AA550 2128A700 */   addu      $a1, $a1, $a3
    /* 9AD54 800AA554 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AA558:
    /* 9AD58 800AA558 CC01828C */  lw         $v0, 0x1CC($a0)
    /* 9AD5C 800AA55C 00000000 */  nop
    /* 9AD60 800AA560 02004104 */  bgez       $v0, .L800AA56C
    /* 9AD64 800AA564 031A0300 */   sra       $v1, $v1, 8
    /* 9AD68 800AA568 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AA56C:
    /* 9AD6C 800AA56C 03120200 */  sra        $v0, $v0, 8
    /* 9AD70 800AA570 18006200 */  mult       $v1, $v0
    /* 9AD74 800AA574 AC00838C */  lw         $v1, 0xAC($a0)
    /* 9AD78 800AA578 12380000 */  mflo       $a3
    /* 9AD7C 800AA57C 2110A700 */  addu       $v0, $a1, $a3
    /* 9AD80 800AA580 02006104 */  bgez       $v1, .L800AA58C
    /* 9AD84 800AA584 180482AC */   sw        $v0, 0x418($a0)
    /* 9AD88 800AA588 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AA58C:
    /* 9AD8C 800AA58C DC01828C */  lw         $v0, 0x1DC($a0)
    /* 9AD90 800AA590 00000000 */  nop
    /* 9AD94 800AA594 02004104 */  bgez       $v0, .L800AA5A0
    /* 9AD98 800AA598 032A0300 */   sra       $a1, $v1, 8
    /* 9AD9C 800AA59C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AA5A0:
    /* 9ADA0 800AA5A0 03120200 */  sra        $v0, $v0, 8
    /* 9ADA4 800AA5A4 1800A200 */  mult       $a1, $v0
    /* 9ADA8 800AA5A8 B000838C */  lw         $v1, 0xB0($a0)
    /* 9ADAC 800AA5AC 12300000 */  mflo       $a2
    /* 9ADB0 800AA5B0 02006104 */  bgez       $v1, .L800AA5BC
    /* 9ADB4 800AA5B4 00000000 */   nop
    /* 9ADB8 800AA5B8 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AA5BC:
    /* 9ADBC 800AA5BC E001828C */  lw         $v0, 0x1E0($a0)
    /* 9ADC0 800AA5C0 00000000 */  nop
    /* 9ADC4 800AA5C4 02004104 */  bgez       $v0, .L800AA5D0
    /* 9ADC8 800AA5C8 031A0300 */   sra       $v1, $v1, 8
    /* 9ADCC 800AA5CC FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AA5D0:
    /* 9ADD0 800AA5D0 03120200 */  sra        $v0, $v0, 8
    /* 9ADD4 800AA5D4 18006200 */  mult       $v1, $v0
    /* 9ADD8 800AA5D8 B400858C */  lw         $a1, 0xB4($a0)
    /* 9ADDC 800AA5DC 12380000 */  mflo       $a3
    /* 9ADE0 800AA5E0 0200A104 */  bgez       $a1, .L800AA5EC
    /* 9ADE4 800AA5E4 2118C700 */   addu      $v1, $a2, $a3
    /* 9ADE8 800AA5E8 FF00A524 */  addiu      $a1, $a1, 0xFF
  .L800AA5EC:
    /* 9ADEC 800AA5EC E401828C */  lw         $v0, 0x1E4($a0)
    /* 9ADF0 800AA5F0 00000000 */  nop
    /* 9ADF4 800AA5F4 02004104 */  bgez       $v0, .L800AA600
    /* 9ADF8 800AA5F8 032A0500 */   sra       $a1, $a1, 8
    /* 9ADFC 800AA5FC FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AA600:
    /* 9AE00 800AA600 03120200 */  sra        $v0, $v0, 8
    /* 9AE04 800AA604 1800A200 */  mult       $a1, $v0
    /* 9AE08 800AA608 12380000 */  mflo       $a3
    /* 9AE0C 800AA60C 21186700 */  addu       $v1, $v1, $a3
    /* 9AE10 800AA610 200483AC */  sw         $v1, 0x420($a0)
    /* 9AE14 800AA614 8C01838C */  lw         $v1, 0x18C($a0)
    /* 9AE18 800AA618 02000224 */  addiu      $v0, $zero, 0x2
    /* 9AE1C 800AA61C 6C0480AC */  sw         $zero, 0x46C($a0)
    /* 9AE20 800AA620 780480AC */  sw         $zero, 0x478($a0)
    /* 9AE24 800AA624 840480AC */  sw         $zero, 0x484($a0)
    /* 9AE28 800AA628 02006214 */  bne        $v1, $v0, .L800AA634
    /* 9AE2C 800AA62C 880480AC */   sw        $zero, 0x488($a0)
    /* 9AE30 800AA630 8C0180AC */  sw         $zero, 0x18C($a0)
  .L800AA634:
    /* 9AE34 800AA634 0800E003 */  jr         $ra
    /* 9AE38 800AA638 00000000 */   nop
endlabel Physics_FixEngineRpm__FP8Car_tObj
