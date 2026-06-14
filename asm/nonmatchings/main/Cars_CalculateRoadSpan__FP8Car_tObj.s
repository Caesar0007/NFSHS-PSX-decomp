.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_CalculateRoadSpan__FP8Car_tObj, 0x248

glabel Cars_CalculateRoadSpan__FP8Car_tObj
    /* 7B480 8008AC80 4401888C */  lw         $t0, 0x144($a0)
    /* 7B484 8008AC84 00000000 */  nop
    /* 7B488 8008AC88 02000105 */  bgez       $t0, .L8008AC94
    /* 7B48C 8008AC8C 21180001 */   addu      $v1, $t0, $zero
    /* 7B490 8008AC90 FF000325 */  addiu      $v1, $t0, 0xFF
  .L8008AC94:
    /* 7B494 8008AC94 F000828C */  lw         $v0, 0xF0($a0)
    /* 7B498 8008AC98 00000000 */  nop
    /* 7B49C 8008AC9C 02004104 */  bgez       $v0, .L8008ACA8
    /* 7B4A0 8008ACA0 035A0300 */   sra       $t3, $v1, 8
    /* 7B4A4 8008ACA4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008ACA8:
    /* 7B4A8 8008ACA8 03120200 */  sra        $v0, $v0, 8
    /* 7B4AC 8008ACAC 18006201 */  mult       $t3, $v0
    /* 7B4B0 8008ACB0 4801878C */  lw         $a3, 0x148($a0)
    /* 7B4B4 8008ACB4 12280000 */  mflo       $a1
    /* 7B4B8 8008ACB8 0200E104 */  bgez       $a3, .L8008ACC4
    /* 7B4BC 8008ACBC 2118E000 */   addu      $v1, $a3, $zero
    /* 7B4C0 8008ACC0 FF00E324 */  addiu      $v1, $a3, 0xFF
  .L8008ACC4:
    /* 7B4C4 8008ACC4 F400828C */  lw         $v0, 0xF4($a0)
    /* 7B4C8 8008ACC8 00000000 */  nop
    /* 7B4CC 8008ACCC 02004104 */  bgez       $v0, .L8008ACD8
    /* 7B4D0 8008ACD0 03520300 */   sra       $t2, $v1, 8
    /* 7B4D4 8008ACD4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008ACD8:
    /* 7B4D8 8008ACD8 03120200 */  sra        $v0, $v0, 8
    /* 7B4DC 8008ACDC 18004201 */  mult       $t2, $v0
    /* 7B4E0 8008ACE0 4C01868C */  lw         $a2, 0x14C($a0)
    /* 7B4E4 8008ACE4 00000000 */  nop
    /* 7B4E8 8008ACE8 2118C000 */  addu       $v1, $a2, $zero
    /* 7B4EC 8008ACEC 12600000 */  mflo       $t4
    /* 7B4F0 8008ACF0 0200C104 */  bgez       $a2, .L8008ACFC
    /* 7B4F4 8008ACF4 2128AC00 */   addu      $a1, $a1, $t4
    /* 7B4F8 8008ACF8 FF00C324 */  addiu      $v1, $a2, 0xFF
  .L8008ACFC:
    /* 7B4FC 8008ACFC F800828C */  lw         $v0, 0xF8($a0)
    /* 7B500 8008AD00 00000000 */  nop
    /* 7B504 8008AD04 02004104 */  bgez       $v0, .L8008AD10
    /* 7B508 8008AD08 034A0300 */   sra       $t1, $v1, 8
    /* 7B50C 8008AD0C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008AD10:
    /* 7B510 8008AD10 03120200 */  sra        $v0, $v0, 8
    /* 7B514 8008AD14 18002201 */  mult       $t1, $v0
    /* 7B518 8008AD18 12600000 */  mflo       $t4
    /* 7B51C 8008AD1C 2128AC00 */  addu       $a1, $a1, $t4
    /* 7B520 8008AD20 0200A104 */  bgez       $a1, .L8008AD2C
    /* 7B524 8008AD24 2110A000 */   addu      $v0, $a1, $zero
    /* 7B528 8008AD28 23100200 */  negu       $v0, $v0
  .L8008AD2C:
    /* 7B52C 8008AD2C 02004104 */  bgez       $v0, .L8008AD38
    /* 7B530 8008AD30 00000000 */   nop
    /* 7B534 8008AD34 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008AD38:
    /* 7B538 8008AD38 3401838C */  lw         $v1, 0x134($a0)
    /* 7B53C 8008AD3C 00000000 */  nop
    /* 7B540 8008AD40 02006104 */  bgez       $v1, .L8008AD4C
    /* 7B544 8008AD44 032A0200 */   sra       $a1, $v0, 8
    /* 7B548 8008AD48 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008AD4C:
    /* 7B54C 8008AD4C 03120300 */  sra        $v0, $v1, 8
    /* 7B550 8008AD50 1800A200 */  mult       $a1, $v0
    /* 7B554 8008AD54 12280000 */  mflo       $a1
    /* 7B558 8008AD58 FC00828C */  lw         $v0, 0xFC($a0)
    /* 7B55C 8008AD5C 00000000 */  nop
    /* 7B560 8008AD60 02004104 */  bgez       $v0, .L8008AD6C
    /* 7B564 8008AD64 00000000 */   nop
    /* 7B568 8008AD68 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008AD6C:
    /* 7B56C 8008AD6C 03120200 */  sra        $v0, $v0, 8
    /* 7B570 8008AD70 18006201 */  mult       $t3, $v0
    /* 7B574 8008AD74 12180000 */  mflo       $v1
    /* 7B578 8008AD78 0001828C */  lw         $v0, 0x100($a0)
    /* 7B57C 8008AD7C 00000000 */  nop
    /* 7B580 8008AD80 02004104 */  bgez       $v0, .L8008AD8C
    /* 7B584 8008AD84 00000000 */   nop
    /* 7B588 8008AD88 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008AD8C:
    /* 7B58C 8008AD8C 03120200 */  sra        $v0, $v0, 8
    /* 7B590 8008AD90 18004201 */  mult       $t2, $v0
    /* 7B594 8008AD94 12600000 */  mflo       $t4
    /* 7B598 8008AD98 0401828C */  lw         $v0, 0x104($a0)
    /* 7B59C 8008AD9C 00000000 */  nop
    /* 7B5A0 8008ADA0 02004104 */  bgez       $v0, .L8008ADAC
    /* 7B5A4 8008ADA4 21186C00 */   addu      $v1, $v1, $t4
    /* 7B5A8 8008ADA8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008ADAC:
    /* 7B5AC 8008ADAC 03120200 */  sra        $v0, $v0, 8
    /* 7B5B0 8008ADB0 18002201 */  mult       $t1, $v0
    /* 7B5B4 8008ADB4 12600000 */  mflo       $t4
    /* 7B5B8 8008ADB8 21106C00 */  addu       $v0, $v1, $t4
    /* 7B5BC 8008ADBC 02004104 */  bgez       $v0, .L8008ADC8
    /* 7B5C0 8008ADC0 21184000 */   addu      $v1, $v0, $zero
    /* 7B5C4 8008ADC4 23180300 */  negu       $v1, $v1
  .L8008ADC8:
    /* 7B5C8 8008ADC8 02006104 */  bgez       $v1, .L8008ADD4
    /* 7B5CC 8008ADCC 00000000 */   nop
    /* 7B5D0 8008ADD0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008ADD4:
    /* 7B5D4 8008ADD4 3801828C */  lw         $v0, 0x138($a0)
    /* 7B5D8 8008ADD8 00000000 */  nop
    /* 7B5DC 8008ADDC 02004104 */  bgez       $v0, .L8008ADE8
    /* 7B5E0 8008ADE0 031A0300 */   sra       $v1, $v1, 8
    /* 7B5E4 8008ADE4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008ADE8:
    /* 7B5E8 8008ADE8 03120200 */  sra        $v0, $v0, 8
    /* 7B5EC 8008ADEC 18006200 */  mult       $v1, $v0
    /* 7B5F0 8008ADF0 4401838C */  lw         $v1, 0x144($a0)
    /* 7B5F4 8008ADF4 12600000 */  mflo       $t4
    /* 7B5F8 8008ADF8 02006104 */  bgez       $v1, .L8008AE04
    /* 7B5FC 8008ADFC 2128AC00 */   addu      $a1, $a1, $t4
    /* 7B600 8008AE00 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008AE04:
    /* 7B604 8008AE04 0801828C */  lw         $v0, 0x108($a0)
    /* 7B608 8008AE08 00000000 */  nop
    /* 7B60C 8008AE0C 02004104 */  bgez       $v0, .L8008AE18
    /* 7B610 8008AE10 03320300 */   sra       $a2, $v1, 8
    /* 7B614 8008AE14 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008AE18:
    /* 7B618 8008AE18 03120200 */  sra        $v0, $v0, 8
    /* 7B61C 8008AE1C 1800C200 */  mult       $a2, $v0
    /* 7B620 8008AE20 4801838C */  lw         $v1, 0x148($a0)
    /* 7B624 8008AE24 12300000 */  mflo       $a2
    /* 7B628 8008AE28 02006104 */  bgez       $v1, .L8008AE34
    /* 7B62C 8008AE2C 00000000 */   nop
    /* 7B630 8008AE30 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008AE34:
    /* 7B634 8008AE34 0C01828C */  lw         $v0, 0x10C($a0)
    /* 7B638 8008AE38 00000000 */  nop
    /* 7B63C 8008AE3C 02004104 */  bgez       $v0, .L8008AE48
    /* 7B640 8008AE40 031A0300 */   sra       $v1, $v1, 8
    /* 7B644 8008AE44 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008AE48:
    /* 7B648 8008AE48 03120200 */  sra        $v0, $v0, 8
    /* 7B64C 8008AE4C 18006200 */  mult       $v1, $v0
    /* 7B650 8008AE50 4C01838C */  lw         $v1, 0x14C($a0)
    /* 7B654 8008AE54 12600000 */  mflo       $t4
    /* 7B658 8008AE58 02006104 */  bgez       $v1, .L8008AE64
    /* 7B65C 8008AE5C 2130CC00 */   addu      $a2, $a2, $t4
    /* 7B660 8008AE60 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008AE64:
    /* 7B664 8008AE64 1001828C */  lw         $v0, 0x110($a0)
    /* 7B668 8008AE68 00000000 */  nop
    /* 7B66C 8008AE6C 02004104 */  bgez       $v0, .L8008AE78
    /* 7B670 8008AE70 031A0300 */   sra       $v1, $v1, 8
    /* 7B674 8008AE74 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008AE78:
    /* 7B678 8008AE78 03120200 */  sra        $v0, $v0, 8
    /* 7B67C 8008AE7C 18006200 */  mult       $v1, $v0
    /* 7B680 8008AE80 12600000 */  mflo       $t4
    /* 7B684 8008AE84 2110CC00 */  addu       $v0, $a2, $t4
    /* 7B688 8008AE88 02004104 */  bgez       $v0, .L8008AE94
    /* 7B68C 8008AE8C 21184000 */   addu      $v1, $v0, $zero
    /* 7B690 8008AE90 23180300 */  negu       $v1, $v1
  .L8008AE94:
    /* 7B694 8008AE94 02006104 */  bgez       $v1, .L8008AEA0
    /* 7B698 8008AE98 00000000 */   nop
    /* 7B69C 8008AE9C FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008AEA0:
    /* 7B6A0 8008AEA0 3C01828C */  lw         $v0, 0x13C($a0)
    /* 7B6A4 8008AEA4 00000000 */  nop
    /* 7B6A8 8008AEA8 02004104 */  bgez       $v0, .L8008AEB4
    /* 7B6AC 8008AEAC 031A0300 */   sra       $v1, $v1, 8
    /* 7B6B0 8008AEB0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008AEB4:
    /* 7B6B4 8008AEB4 03120200 */  sra        $v0, $v0, 8
    /* 7B6B8 8008AEB8 18006200 */  mult       $v1, $v0
    /* 7B6BC 8008AEBC 12600000 */  mflo       $t4
    /* 7B6C0 8008AEC0 0800E003 */  jr         $ra
    /* 7B6C4 8008AEC4 2110AC00 */   addu      $v0, $a1, $t4
endlabel Cars_CalculateRoadSpan__FP8Car_tObj
