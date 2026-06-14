.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForActivation__18AIHigh_BTC_Wingman, 0x130

glabel CheckForActivation__18AIHigh_BTC_Wingman
    /* 4F5C8 8005EDC8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 4F5CC 8005EDCC 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 4F5D0 8005EDD0 21888000 */  addu       $s1, $a0, $zero
    /* 4F5D4 8005EDD4 2400B3AF */  sw         $s3, 0x24($sp)
    /* 4F5D8 8005EDD8 21980000 */  addu       $s3, $zero, $zero
    /* 4F5DC 8005EDDC 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 4F5E0 8005EDE0 2800B4AF */  sw         $s4, 0x28($sp)
    /* 4F5E4 8005EDE4 38CD5424 */  addiu      $s4, $v0, %lo(highLevelAIObjs)
    /* 4F5E8 8005EDE8 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 4F5EC 8005EDEC 2000B2AF */  sw         $s2, 0x20($sp)
    /* 4F5F0 8005EDF0 DCF95224 */  addiu      $s2, $v0, %lo(Cars_gList)
    /* 4F5F4 8005EDF4 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 4F5F8 8005EDF8 1800B0AF */  sw         $s0, 0x18($sp)
    /* 4F5FC 8005EDFC 1000A0AF */  sw         $zero, 0x10($sp)
  .L8005EE00:
    /* 4F600 8005EE00 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 4F604 8005EE04 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 4F608 8005EE08 00000000 */  nop
    /* 4F60C 8005EE0C 2A106202 */  slt        $v0, $s3, $v0
    /* 4F610 8005EE10 26004010 */  beqz       $v0, .L8005EEAC
    /* 4F614 8005EE14 00000000 */   nop
    /* 4F618 8005EE18 0000438E */  lw         $v1, 0x0($s2)
    /* 4F61C 8005EE1C 00000000 */  nop
    /* 4F620 8005EE20 6002628C */  lw         $v0, 0x260($v1)
    /* 4F624 8005EE24 00000000 */  nop
    /* 4F628 8005EE28 00024230 */  andi       $v0, $v0, 0x200
    /* 4F62C 8005EE2C 1C004010 */  beqz       $v0, .L8005EEA0
    /* 4F630 8005EE30 00000000 */   nop
    /* 4F634 8005EE34 91006290 */  lbu        $v0, 0x91($v1)
    /* 4F638 8005EE38 00000000 */  nop
    /* 4F63C 8005EE3C 18004010 */  beqz       $v0, .L8005EEA0
    /* 4F640 8005EE40 00000000 */   nop
    /* 4F644 8005EE44 5402628C */  lw         $v0, 0x254($v1)
    /* 4F648 8005EE48 00000000 */  nop
    /* 4F64C 8005EE4C 80100200 */  sll        $v0, $v0, 2
    /* 4F650 8005EE50 21105400 */  addu       $v0, $v0, $s4
    /* 4F654 8005EE54 0000508C */  lw         $s0, 0x0($v0)
    /* 4F658 8005EE58 BB77010C */  jal        CheckForWingmanRequest__19AIHigh_BTC_HumanCop
    /* 4F65C 8005EE5C 21200002 */   addu      $a0, $s0, $zero
    /* 4F660 8005EE60 03004010 */  beqz       $v0, .L8005EE70
    /* 4F664 8005EE64 01000224 */   addiu     $v0, $zero, 0x1
    /* 4F668 8005EE68 680022AE */  sw         $v0, 0x68($s1)
    /* 4F66C 8005EE6C 6C0030AE */  sw         $s0, 0x6C($s1)
  .L8005EE70:
    /* 4F670 8005EE70 21200002 */  addu       $a0, $s0, $zero
    /* 4F674 8005EE74 C477010C */  jal        CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi
    /* 4F678 8005EE78 1000A527 */   addiu     $a1, $sp, 0x10
    /* 4F67C 8005EE7C 08004010 */  beqz       $v0, .L8005EEA0
    /* 4F680 8005EE80 00000000 */   nop
    /* 4F684 8005EE84 1000A28F */  lw         $v0, 0x10($sp)
    /* 4F688 8005EE88 00000000 */  nop
    /* 4F68C 8005EE8C 02004010 */  beqz       $v0, .L8005EE98
    /* 4F690 8005EE90 02000324 */   addiu     $v1, $zero, 0x2
    /* 4F694 8005EE94 03000324 */  addiu      $v1, $zero, 0x3
  .L8005EE98:
    /* 4F698 8005EE98 680023AE */  sw         $v1, 0x68($s1)
    /* 4F69C 8005EE9C 6C0030AE */  sw         $s0, 0x6C($s1)
  .L8005EEA0:
    /* 4F6A0 8005EEA0 04005226 */  addiu      $s2, $s2, 0x4
    /* 4F6A4 8005EEA4 807B0108 */  j          .L8005EE00
    /* 4F6A8 8005EEA8 01007326 */   addiu     $s3, $s3, 0x1
  .L8005EEAC:
    /* 4F6AC 8005EEAC 6C00248E */  lw         $a0, 0x6C($s1)
    /* 4F6B0 8005EEB0 00000000 */  nop
    /* 4F6B4 8005EEB4 04008010 */  beqz       $a0, .L8005EEC8
    /* 4F6B8 8005EEB8 00000000 */   nop
    /* 4F6BC 8005EEBC 6400258E */  lw         $a1, 0x64($s1)
    /* 4F6C0 8005EEC0 D577010C */  jal        UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role
    /* 4F6C4 8005EEC4 00000000 */   nop
  .L8005EEC8:
    /* 4F6C8 8005EEC8 6400228E */  lw         $v0, 0x64($s1)
    /* 4F6CC 8005EECC 6800238E */  lw         $v1, 0x68($s1)
    /* 4F6D0 8005EED0 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 4F6D4 8005EED4 2800B48F */  lw         $s4, 0x28($sp)
    /* 4F6D8 8005EED8 2400B38F */  lw         $s3, 0x24($sp)
    /* 4F6DC 8005EEDC 2000B28F */  lw         $s2, 0x20($sp)
    /* 4F6E0 8005EEE0 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 4F6E4 8005EEE4 1800B08F */  lw         $s0, 0x18($sp)
    /* 4F6E8 8005EEE8 26104300 */  xor        $v0, $v0, $v1
    /* 4F6EC 8005EEEC 2B100200 */  sltu       $v0, $zero, $v0
    /* 4F6F0 8005EEF0 0800E003 */  jr         $ra
    /* 4F6F4 8005EEF4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CheckForActivation__18AIHigh_BTC_Wingman
