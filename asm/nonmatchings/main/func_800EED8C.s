.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800EED8C, 0x23C

glabel func_800EED8C
    /* DF58C 800EED8C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* DF590 800EED90 1400B1AF */  sw         $s1, 0x14($sp)
    /* DF594 800EED94 21888000 */  addu       $s1, $a0, $zero
    /* DF598 800EED98 1800B2AF */  sw         $s2, 0x18($sp)
    /* DF59C 800EED9C 2190A000 */  addu       $s2, $a1, $zero
    /* DF5A0 800EEDA0 2800BFAF */  sw         $ra, 0x28($sp)
    /* DF5A4 800EEDA4 2400B5AF */  sw         $s5, 0x24($sp)
    /* DF5A8 800EEDA8 2000B4AF */  sw         $s4, 0x20($sp)
    /* DF5AC 800EEDAC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DF5B0 800EEDB0 BEBE030C */  jal        func_800EFAF8
    /* DF5B4 800EEDB4 1000B0AF */   sw        $s0, 0x10($sp)
    /* DF5B8 800EEDB8 04002586 */  lh         $a1, 0x4($s1)
    /* DF5BC 800EEDBC 04002396 */  lhu        $v1, 0x4($s1)
    /* DF5C0 800EEDC0 0B00A004 */  bltz       $a1, .L800EEDF0
    /* DF5C4 800EEDC4 21A80000 */   addu      $s5, $zero, $zero
    /* DF5C8 800EEDC8 21206000 */  addu       $a0, $v1, $zero
    /* DF5CC 800EEDCC 1280023C */  lui        $v0, %hi(D_801236A0)
    /* DF5D0 800EEDD0 A0364284 */  lh         $v0, %lo(D_801236A0)($v0)
    /* DF5D4 800EEDD4 1280033C */  lui        $v1, %hi(D_801236A0)
    /* DF5D8 800EEDD8 A0366394 */  lhu        $v1, %lo(D_801236A0)($v1)
    /* DF5DC 800EEDDC 2A104500 */  slt        $v0, $v0, $a1
    /* DF5E0 800EEDE0 04004010 */  beqz       $v0, .L800EEDF4
    /* DF5E4 800EEDE4 00000000 */   nop
    /* DF5E8 800EEDE8 7DBB0308 */  j          .L800EEDF4
    /* DF5EC 800EEDEC 21206000 */   addu      $a0, $v1, $zero
  .L800EEDF0:
    /* DF5F0 800EEDF0 21200000 */  addu       $a0, $zero, $zero
  .L800EEDF4:
    /* DF5F4 800EEDF4 06002586 */  lh         $a1, 0x6($s1)
    /* DF5F8 800EEDF8 06002396 */  lhu        $v1, 0x6($s1)
    /* DF5FC 800EEDFC 0B00A004 */  bltz       $a1, .L800EEE2C
    /* DF600 800EEE00 040024A6 */   sh        $a0, 0x4($s1)
    /* DF604 800EEE04 21206000 */  addu       $a0, $v1, $zero
    /* DF608 800EEE08 1280023C */  lui        $v0, %hi(D_801236A2)
    /* DF60C 800EEE0C A2364284 */  lh         $v0, %lo(D_801236A2)($v0)
    /* DF610 800EEE10 1280033C */  lui        $v1, %hi(D_801236A2)
    /* DF614 800EEE14 A2366394 */  lhu        $v1, %lo(D_801236A2)($v1)
    /* DF618 800EEE18 2A104500 */  slt        $v0, $v0, $a1
    /* DF61C 800EEE1C 05004010 */  beqz       $v0, .L800EEE34
    /* DF620 800EEE20 00140400 */   sll       $v0, $a0, 16
    /* DF624 800EEE24 8CBB0308 */  j          .L800EEE30
    /* DF628 800EEE28 21206000 */   addu      $a0, $v1, $zero
  .L800EEE2C:
    /* DF62C 800EEE2C 21200000 */  addu       $a0, $zero, $zero
  .L800EEE30:
    /* DF630 800EEE30 00140400 */  sll        $v0, $a0, 16
  .L800EEE34:
    /* DF634 800EEE34 04002386 */  lh         $v1, 0x4($s1)
    /* DF638 800EEE38 03140200 */  sra        $v0, $v0, 16
    /* DF63C 800EEE3C 18006200 */  mult       $v1, $v0
    /* DF640 800EEE40 060024A6 */  sh         $a0, 0x6($s1)
    /* DF644 800EEE44 12300000 */  mflo       $a2
    /* DF648 800EEE48 0100C324 */  addiu      $v1, $a2, 0x1
    /* DF64C 800EEE4C C2170300 */  srl        $v0, $v1, 31
    /* DF650 800EEE50 21186200 */  addu       $v1, $v1, $v0
    /* DF654 800EEE54 43200300 */  sra        $a0, $v1, 1
    /* DF658 800EEE58 0300801C */  bgtz       $a0, .L800EEE68
    /* DF65C 800EEE5C 43810300 */   sra       $s0, $v1, 5
    /* DF660 800EEE60 E9BB0308 */  j          .L800EEFA4
    /* DF664 800EEE64 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800EEE68:
    /* DF668 800EEE68 21180002 */  addu       $v1, $s0, $zero
    /* DF66C 800EEE6C 00110300 */  sll        $v0, $v1, 4
    /* DF670 800EEE70 23808200 */  subu       $s0, $a0, $v0
    /* DF674 800EEE74 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DF678 800EEE78 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DF67C 800EEE7C 21A06000 */  addu       $s4, $v1, $zero
    /* DF680 800EEE80 0000428C */  lw         $v0, 0x0($v0)
    /* DF684 800EEE84 0004033C */  lui        $v1, (0x4000000 >> 16)
    /* DF688 800EEE88 24104300 */  and        $v0, $v0, $v1
    /* DF68C 800EEE8C 0E004014 */  bnez       $v0, .L800EEEC8
    /* DF690 800EEE90 00A0043C */   lui       $a0, (0xA0000000 >> 16)
    /* DF694 800EEE94 0004133C */  lui        $s3, (0x4000000 >> 16)
  .L800EEE98:
    /* DF698 800EEE98 CBBE030C */  jal        func_800EFB2C
    /* DF69C 800EEE9C 00000000 */   nop
    /* DF6A0 800EEEA0 40004014 */  bnez       $v0, .L800EEFA4
    /* DF6A4 800EEEA4 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* DF6A8 800EEEA8 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DF6AC 800EEEAC A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DF6B0 800EEEB0 00000000 */  nop
    /* DF6B4 800EEEB4 0000428C */  lw         $v0, 0x0($v0)
    /* DF6B8 800EEEB8 00000000 */  nop
    /* DF6BC 800EEEBC 24105300 */  and        $v0, $v0, $s3
    /* DF6C0 800EEEC0 F5FF4010 */  beqz       $v0, .L800EEE98
    /* DF6C4 800EEEC4 00A0043C */   lui       $a0, (0xA0000000 >> 16)
  .L800EEEC8:
    /* DF6C8 800EEEC8 1280033C */  lui        $v1, %hi(D_801237A4)
    /* DF6CC 800EEECC A437638C */  lw         $v1, %lo(D_801237A4)($v1)
    /* DF6D0 800EEED0 0004023C */  lui        $v0, (0x4000000 >> 16)
    /* DF6D4 800EEED4 000062AC */  sw         $v0, 0x0($v1)
    /* DF6D8 800EEED8 1280033C */  lui        $v1, %hi(D_801237A0)
    /* DF6DC 800EEEDC A037638C */  lw         $v1, %lo(D_801237A0)($v1)
    /* DF6E0 800EEEE0 0001023C */  lui        $v0, (0x1000000 >> 16)
    /* DF6E4 800EEEE4 000062AC */  sw         $v0, 0x0($v1)
    /* DF6E8 800EEEE8 1280023C */  lui        $v0, %hi(D_801237A0)
    /* DF6EC 800EEEEC A037428C */  lw         $v0, %lo(D_801237A0)($v0)
    /* DF6F0 800EEEF0 0200A012 */  beqz       $s5, .L800EEEFC
    /* DF6F4 800EEEF4 00000000 */   nop
    /* DF6F8 800EEEF8 00B0043C */  lui        $a0, (0xB0000000 >> 16)
  .L800EEEFC:
    /* DF6FC 800EEEFC 000044AC */  sw         $a0, 0x0($v0)
    /* DF700 800EEF00 1280033C */  lui        $v1, %hi(D_801237A0)
    /* DF704 800EEF04 A037638C */  lw         $v1, %lo(D_801237A0)($v1)
    /* DF708 800EEF08 0000228E */  lw         $v0, 0x0($s1)
    /* DF70C 800EEF0C 00000000 */  nop
    /* DF710 800EEF10 000062AC */  sw         $v0, 0x0($v1)
    /* DF714 800EEF14 1280033C */  lui        $v1, %hi(D_801237A0)
    /* DF718 800EEF18 A037638C */  lw         $v1, %lo(D_801237A0)($v1)
    /* DF71C 800EEF1C 0400228E */  lw         $v0, 0x4($s1)
    /* DF720 800EEF20 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* DF724 800EEF24 000062AC */  sw         $v0, 0x0($v1)
    /* DF728 800EEF28 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* DF72C 800EEF2C 09000212 */  beq        $s0, $v0, .L800EEF54
    /* DF730 800EEF30 00000000 */   nop
    /* DF734 800EEF34 FFFF0424 */  addiu      $a0, $zero, -0x1
  .L800EEF38:
    /* DF738 800EEF38 0000438E */  lw         $v1, 0x0($s2)
    /* DF73C 800EEF3C 04005226 */  addiu      $s2, $s2, 0x4
    /* DF740 800EEF40 1280023C */  lui        $v0, %hi(D_801237A0)
    /* DF744 800EEF44 A037428C */  lw         $v0, %lo(D_801237A0)($v0)
    /* DF748 800EEF48 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* DF74C 800EEF4C FAFF0416 */  bne        $s0, $a0, .L800EEF38
    /* DF750 800EEF50 000043AC */   sw        $v1, 0x0($v0)
  .L800EEF54:
    /* DF754 800EEF54 12008012 */  beqz       $s4, .L800EEFA0
    /* DF758 800EEF58 0004033C */   lui       $v1, (0x4000002 >> 16)
    /* DF75C 800EEF5C 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DF760 800EEF60 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DF764 800EEF64 02006334 */  ori        $v1, $v1, (0x4000002 & 0xFFFF)
    /* DF768 800EEF68 000043AC */  sw         $v1, 0x0($v0)
    /* DF76C 800EEF6C 1280023C */  lui        $v0, %hi(D_801237A8)
    /* DF770 800EEF70 A837428C */  lw         $v0, %lo(D_801237A8)($v0)
    /* DF774 800EEF74 0001043C */  lui        $a0, (0x1000201 >> 16)
    /* DF778 800EEF78 000052AC */  sw         $s2, 0x0($v0)
    /* DF77C 800EEF7C 00141400 */  sll        $v0, $s4, 16
    /* DF780 800EEF80 1280033C */  lui        $v1, %hi(D_801237AC)
    /* DF784 800EEF84 AC37638C */  lw         $v1, %lo(D_801237AC)($v1)
    /* DF788 800EEF88 10004234 */  ori        $v0, $v0, 0x10
    /* DF78C 800EEF8C 000062AC */  sw         $v0, 0x0($v1)
    /* DF790 800EEF90 1280023C */  lui        $v0, %hi(D_801237B0)
    /* DF794 800EEF94 B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* DF798 800EEF98 01028434 */  ori        $a0, $a0, (0x1000201 & 0xFFFF)
    /* DF79C 800EEF9C 000044AC */  sw         $a0, 0x0($v0)
  .L800EEFA0:
    /* DF7A0 800EEFA0 21100000 */  addu       $v0, $zero, $zero
  .L800EEFA4:
    /* DF7A4 800EEFA4 2800BF8F */  lw         $ra, 0x28($sp)
    /* DF7A8 800EEFA8 2400B58F */  lw         $s5, 0x24($sp)
    /* DF7AC 800EEFAC 2000B48F */  lw         $s4, 0x20($sp)
    /* DF7B0 800EEFB0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DF7B4 800EEFB4 1800B28F */  lw         $s2, 0x18($sp)
    /* DF7B8 800EEFB8 1400B18F */  lw         $s1, 0x14($sp)
    /* DF7BC 800EEFBC 1000B08F */  lw         $s0, 0x10($sp)
    /* DF7C0 800EEFC0 0800E003 */  jr         $ra
    /* DF7C4 800EEFC4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel func_800EED8C
