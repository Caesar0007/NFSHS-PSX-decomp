.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8002A56C, 0x140

glabel func_8002A56C
    /* 1AD6C 8002A56C B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 1AD70 8002A570 4400B1AF */  sw         $s1, 0x44($sp)
    /* 1AD74 8002A574 21888000 */  addu       $s1, $a0, $zero
    /* 1AD78 8002A578 4800B2AF */  sw         $s2, 0x48($sp)
    /* 1AD7C 8002A57C 2190A000 */  addu       $s2, $a1, $zero
    /* 1AD80 8002A580 4000B0AF */  sw         $s0, 0x40($sp)
    /* 1AD84 8002A584 1180103C */  lui        $s0, %hi(frontEnd)
    /* 1AD88 8002A588 00461026 */  addiu      $s0, $s0, %lo(frontEnd)
    /* 1AD8C 8002A58C 1180043C */  lui        $a0, %hi(trackManager)
    /* 1AD90 8002A590 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 1AD94 8002A594 46000292 */  lbu        $v0, 0x46($s0)
    /* 1AD98 8002A598 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 1AD9C 8002A59C 21105000 */  addu       $v0, $v0, $s0
    /* 1ADA0 8002A5A0 23004590 */  lbu        $a1, 0x23($v0)
    /* 1ADA4 8002A5A4 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 1ADA8 8002A5A8 1000A627 */   addiu     $a2, $sp, 0x10
    /* 1ADAC 8002A5AC 20030392 */  lbu        $v1, 0x320($s0)
    /* 1ADB0 8002A5B0 01000224 */  addiu      $v0, $zero, 0x1
    /* 1ADB4 8002A5B4 0E006210 */  beq        $v1, $v0, .L8002A5F0
    /* 1ADB8 8002A5B8 21200000 */   addu      $a0, $zero, $zero
    /* 1ADBC 8002A5BC 02006228 */  slti       $v0, $v1, 0x2
    /* 1ADC0 8002A5C0 05004014 */  bnez       $v0, .L8002A5D8
    /* 1ADC4 8002A5C4 02000224 */   addiu     $v0, $zero, 0x2
    /* 1ADC8 8002A5C8 04006214 */  bne        $v1, $v0, .L8002A5DC
    /* 1ADCC 8002A5CC 0580033C */   lui       $v1, %hi(CountryMeasurement)
    /* 1ADD0 8002A5D0 7CA90008 */  j          .L8002A5F0
    /* 1ADD4 8002A5D4 01000424 */   addiu     $a0, $zero, 0x1
  .L8002A5D8:
    /* 1ADD8 8002A5D8 0580033C */  lui        $v1, %hi(CountryMeasurement)
  .L8002A5DC:
    /* 1ADDC 8002A5DC 3A00A293 */  lbu        $v0, 0x3A($sp)
    /* 1ADE0 8002A5E0 10166324 */  addiu      $v1, $v1, %lo(CountryMeasurement)
    /* 1ADE4 8002A5E4 40100200 */  sll        $v0, $v0, 1
    /* 1ADE8 8002A5E8 21104300 */  addu       $v0, $v0, $v1
    /* 1ADEC 8002A5EC 00004484 */  lh         $a0, 0x0($v0)
  .L8002A5F0:
    /* 1ADF0 8002A5F0 1A000224 */  addiu      $v0, $zero, 0x1A
    /* 1ADF4 8002A5F4 000022AE */  sw         $v0, 0x0($s1)
    /* 1ADF8 8002A5F8 04003126 */  addiu      $s1, $s1, 0x4
    /* 1ADFC 8002A5FC 000024AE */  sw         $a0, 0x0($s1)
    /* 1AE00 8002A600 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE04 8002A604 18000224 */  addiu      $v0, $zero, 0x18
    /* 1AE08 8002A608 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE0C 8002A60C C2024292 */  lbu        $v0, 0x2C2($s2)
    /* 1AE10 8002A610 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE14 8002A614 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE18 8002A618 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE1C 8002A61C 19000224 */  addiu      $v0, $zero, 0x19
    /* 1AE20 8002A620 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE24 8002A624 C1024292 */  lbu        $v0, 0x2C1($s2)
    /* 1AE28 8002A628 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE2C 8002A62C 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE30 8002A630 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE34 8002A634 14000224 */  addiu      $v0, $zero, 0x14
    /* 1AE38 8002A638 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE3C 8002A63C C4024292 */  lbu        $v0, 0x2C4($s2)
    /* 1AE40 8002A640 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE44 8002A644 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE48 8002A648 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE4C 8002A64C 17000224 */  addiu      $v0, $zero, 0x17
    /* 1AE50 8002A650 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE54 8002A654 C3024292 */  lbu        $v0, 0x2C3($s2)
    /* 1AE58 8002A658 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE5C 8002A65C 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE60 8002A660 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE64 8002A664 12000224 */  addiu      $v0, $zero, 0x12
    /* 1AE68 8002A668 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE6C 8002A66C 91024292 */  lbu        $v0, 0x291($s2)
    /* 1AE70 8002A670 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE74 8002A674 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE78 8002A678 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE7C 8002A67C 0B000224 */  addiu      $v0, $zero, 0xB
    /* 1AE80 8002A680 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE84 8002A684 E002428E */  lw         $v0, 0x2E0($s2)
    /* 1AE88 8002A688 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AE8C 8002A68C 000022AE */  sw         $v0, 0x0($s1)
    /* 1AE90 8002A690 04002226 */  addiu      $v0, $s1, 0x4
    /* 1AE94 8002A694 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 1AE98 8002A698 4800B28F */  lw         $s2, 0x48($sp)
    /* 1AE9C 8002A69C 4400B18F */  lw         $s1, 0x44($sp)
    /* 1AEA0 8002A6A0 4000B08F */  lw         $s0, 0x40($sp)
    /* 1AEA4 8002A6A4 0800E003 */  jr         $ra
    /* 1AEA8 8002A6A8 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel func_8002A56C
