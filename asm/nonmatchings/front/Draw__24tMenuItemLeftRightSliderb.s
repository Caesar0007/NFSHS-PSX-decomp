.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__24tMenuItemLeftRightSliderb, 0x12C

glabel Draw__24tMenuItemLeftRightSliderb
    /* 159E4 800251E4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 159E8 800251E8 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 159EC 800251EC 21888000 */  addu       $s1, $a0, $zero
    /* 159F0 800251F0 4400BFAF */  sw         $ra, 0x44($sp)
    /* 159F4 800251F4 4000B2AF */  sw         $s2, 0x40($sp)
    /* 159F8 800251F8 3800B0AF */  sw         $s0, 0x38($sp)
    /* 159FC 800251FC 2000228E */  lw         $v0, 0x20($s1)
    /* 15A00 80025200 00000000 */  nop
    /* 15A04 80025204 08004014 */  bnez       $v0, .L80025228
    /* 15A08 80025208 2190A000 */   addu      $s2, $a1, $zero
    /* 15A0C 8002520C 0400248E */  lw         $a0, 0x4($s1)
    /* 15A10 80025210 A4E4020C */  jal        TextSys_WordX__Fi
    /* 15A14 80025214 00000000 */   nop
    /* 15A18 80025218 0400248E */  lw         $a0, 0x4($s1)
    /* 15A1C 8002521C ACE4020C */  jal        TextSys_WordY__Fi
    /* 15A20 80025220 200022A6 */   sh        $v0, 0x20($s1)
    /* 15A24 80025224 220022A6 */  sh         $v0, 0x22($s1)
  .L80025228:
    /* 15A28 80025228 2B381200 */  sltu       $a3, $zero, $s2
    /* 15A2C 8002522C 04002486 */  lh         $a0, 0x4($s1)
    /* 15A30 80025230 20002596 */  lhu        $a1, 0x20($s1)
    /* 15A34 80025234 22002696 */  lhu        $a2, 0x22($s1)
    /* 15A38 80025238 06001024 */  addiu      $s0, $zero, 0x6
    /* 15A3C 8002523C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 15A40 80025240 0800A524 */  addiu      $a1, $a1, 0x8
    /* 15A44 80025244 002C0500 */  sll        $a1, $a1, 16
    /* 15A48 80025248 032C0500 */  sra        $a1, $a1, 16
    /* 15A4C 8002524C 0300C624 */  addiu      $a2, $a2, 0x3
    /* 15A50 80025250 00340600 */  sll        $a2, $a2, 16
    /* 15A54 80025254 0584000C */  jal        FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
    /* 15A58 80025258 03340600 */   sra       $a2, $a2, 16
    /* 15A5C 8002525C 1C00238E */  lw         $v1, 0x1C($s1)
    /* 15A60 80025260 00000000 */  nop
    /* 15A64 80025264 0C00628C */  lw         $v0, 0xC($v1)
    /* 15A68 80025268 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 15A6C 8002526C 10004484 */  lh         $a0, 0x10($v0)
    /* 15A70 80025270 1400428C */  lw         $v0, 0x14($v0)
    /* 15A74 80025274 00000000 */  nop
    /* 15A78 80025278 09F84000 */  jalr       $v0
    /* 15A7C 8002527C 21206400 */   addu      $a0, $v1, $a0
    /* 15A80 80025280 FF004830 */  andi       $t0, $v0, 0xFF
    /* 15A84 80025284 04000224 */  addiu      $v0, $zero, 0x4
    /* 15A88 80025288 22002396 */  lhu        $v1, 0x22($s1)
    /* 15A8C 8002528C 1C00248E */  lw         $a0, 0x1C($s1)
    /* 15A90 80025290 04006324 */  addiu      $v1, $v1, 0x4
    /* 15A94 80025294 001C0300 */  sll        $v1, $v1, 16
    /* 15A98 80025298 08008590 */  lbu        $a1, 0x8($a0)
    /* 15A9C 8002529C 09008690 */  lbu        $a2, 0x9($a0)
    /* 15AA0 800252A0 20002496 */  lhu        $a0, 0x20($s1)
    /* 15AA4 800252A4 031C0300 */  sra        $v1, $v1, 16
    /* 15AA8 800252A8 1000A3AF */  sw         $v1, 0x10($sp)
    /* 15AAC 800252AC 24002386 */  lh         $v1, 0x24($s1)
    /* 15AB0 800252B0 73008424 */  addiu      $a0, $a0, 0x73
    /* 15AB4 800252B4 00240400 */  sll        $a0, $a0, 16
    /* 15AB8 800252B8 1400A3AF */  sw         $v1, 0x14($sp)
    /* 15ABC 800252BC 26002386 */  lh         $v1, 0x26($s1)
    /* 15AC0 800252C0 033C0400 */  sra        $a3, $a0, 16
    /* 15AC4 800252C4 1C00B0AF */  sw         $s0, 0x1C($sp)
    /* 15AC8 800252C8 2000A2AF */  sw         $v0, 0x20($sp)
    /* 15ACC 800252CC 2400A0AF */  sw         $zero, 0x24($sp)
    /* 15AD0 800252D0 2800A0AF */  sw         $zero, 0x28($sp)
    /* 15AD4 800252D4 04004012 */  beqz       $s2, .L800252E8
    /* 15AD8 800252D8 1800A3AF */   sw        $v1, 0x18($sp)
    /* 15ADC 800252DC 80000224 */  addiu      $v0, $zero, 0x80
    /* 15AE0 800252E0 BB940008 */  j          .L800252EC
    /* 15AE4 800252E4 2C00A2AF */   sw        $v0, 0x2C($sp)
  .L800252E8:
    /* 15AE8 800252E8 2C00A0AF */  sw         $zero, 0x2C($sp)
  .L800252EC:
    /* 15AEC 800252EC 21200001 */  addu       $a0, $t0, $zero
    /* 15AF0 800252F0 0B93000C */  jal        DrawSlider__FsssssssssbT9ss
    /* 15AF4 800252F4 3000A0AF */   sw        $zero, 0x30($sp)
    /* 15AF8 800252F8 4400BF8F */  lw         $ra, 0x44($sp)
    /* 15AFC 800252FC 4000B28F */  lw         $s2, 0x40($sp)
    /* 15B00 80025300 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 15B04 80025304 3800B08F */  lw         $s0, 0x38($sp)
    /* 15B08 80025308 0800E003 */  jr         $ra
    /* 15B0C 8002530C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Draw__24tMenuItemLeftRightSliderb
