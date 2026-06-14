.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_UnPackSample, 0x188

glabel iSPCH_UnPackSample
    /* FBDD4 8010B5D4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* FBDD8 8010B5D8 2000B4AF */  sw         $s4, 0x20($sp)
    /* FBDDC 8010B5DC 21A08000 */  addu       $s4, $a0, $zero
    /* FBDE0 8010B5E0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* FBDE4 8010B5E4 2198A000 */  addu       $s3, $a1, $zero
    /* FBDE8 8010B5E8 2400B5AF */  sw         $s5, 0x24($sp)
    /* FBDEC 8010B5EC 21A8C000 */  addu       $s5, $a2, $zero
    /* FBDF0 8010B5F0 1400B1AF */  sw         $s1, 0x14($sp)
    /* FBDF4 8010B5F4 21880000 */  addu       $s1, $zero, $zero
    /* FBDF8 8010B5F8 1800B2AF */  sw         $s2, 0x18($sp)
    /* FBDFC 8010B5FC 21902002 */  addu       $s2, $s1, $zero
    /* FBE00 8010B600 2120A002 */  addu       $a0, $s5, $zero
    /* FBE04 8010B604 2800BFAF */  sw         $ra, 0x28($sp)
    /* FBE08 8010B608 6B2D040C */  jal        iSPCH_InitSample
    /* FBE0C 8010B60C 1000B0AF */   sw        $s0, 0x10($sp)
    /* FBE10 8010B610 03008292 */  lbu        $v0, 0x3($s4)
    /* FBE14 8010B614 00000000 */  nop
    /* FBE18 8010B618 2A106202 */  slt        $v0, $s3, $v0
    /* FBE1C 8010B61C 45004010 */  beqz       $v0, .L8010B734
    /* FBE20 8010B620 21802002 */   addu      $s0, $s1, $zero
    /* FBE24 8010B624 02008292 */  lbu        $v0, 0x2($s4)
    /* FBE28 8010B628 00000000 */  nop
    /* FBE2C 8010B62C 0F004530 */  andi       $a1, $v0, 0xF
    /* FBE30 8010B630 0200A724 */  addiu      $a3, $a1, 0x2
    /* FBE34 8010B634 18006702 */  mult       $s3, $a3
    /* FBE38 8010B638 08008626 */  addiu      $a2, $s4, 0x8
    /* FBE3C 8010B63C 21202002 */  addu       $a0, $s1, $zero
    /* FBE40 8010B640 2A102502 */  slt        $v0, $s1, $a1
    /* FBE44 8010B644 0800A5AE */  sw         $a1, 0x8($s5)
    /* FBE48 8010B648 12480000 */  mflo       $t1
    /* FBE4C 8010B64C 09004010 */  beqz       $v0, .L8010B674
    /* FBE50 8010B650 2130C900 */   addu      $a2, $a2, $t1
    /* FBE54 8010B654 2118A402 */  addu       $v1, $s5, $a0
  .L8010B658:
    /* FBE58 8010B658 21108600 */  addu       $v0, $a0, $a2
    /* FBE5C 8010B65C 02004290 */  lbu        $v0, 0x2($v0)
    /* FBE60 8010B660 01008424 */  addiu      $a0, $a0, 0x1
    /* FBE64 8010B664 0C0062A0 */  sb         $v0, 0xC($v1)
    /* FBE68 8010B668 2A108500 */  slt        $v0, $a0, $a1
    /* FBE6C 8010B66C FAFF4014 */  bnez       $v0, .L8010B658
    /* FBE70 8010B670 2118A402 */   addu      $v1, $s5, $a0
  .L8010B674:
    /* FBE74 8010B674 0000C290 */  lbu        $v0, 0x0($a2)
    /* FBE78 8010B678 00000000 */  nop
    /* FBE7C 8010B67C 80004230 */  andi       $v0, $v0, 0x80
    /* FBE80 8010B680 08004010 */  beqz       $v0, .L8010B6A4
    /* FBE84 8010B684 2120C700 */   addu      $a0, $a2, $a3
    /* FBE88 8010B688 0100D390 */  lbu        $s3, 0x1($a2)
    /* FBE8C 8010B68C 00000000 */  nop
    /* FBE90 8010B690 18006702 */  mult       $s3, $a3
    /* FBE94 8010B694 08008626 */  addiu      $a2, $s4, 0x8
    /* FBE98 8010B698 12480000 */  mflo       $t1
    /* FBE9C 8010B69C 2130C900 */  addu       $a2, $a2, $t1
    /* FBEA0 8010B6A0 2120C700 */  addu       $a0, $a2, $a3
  .L8010B6A4:
    /* FBEA4 8010B6A4 01006526 */  addiu      $a1, $s3, 0x1
    /* FBEA8 8010B6A8 0000C290 */  lbu        $v0, 0x0($a2)
    /* FBEAC 8010B6AC 0100C390 */  lbu        $v1, 0x1($a2)
    /* FBEB0 8010B6B0 00120200 */  sll        $v0, $v0, 8
    /* FBEB4 8010B6B4 21304300 */  addu       $a2, $v0, $v1
    /* FBEB8 8010B6B8 00320600 */  sll        $a2, $a2, 8
    /* FBEBC 8010B6BC 1A004016 */  bnez       $s2, .L8010B728
    /* FBEC0 8010B6C0 0400A6AE */   sw        $a2, 0x4($s5)
    /* FBEC4 8010B6C4 03008892 */  lbu        $t0, 0x3($s4)
    /* FBEC8 8010B6C8 00000000 */  nop
    /* FBECC 8010B6CC 2A10A800 */  slt        $v0, $a1, $t0
  .L8010B6D0:
    /* FBED0 8010B6D0 05004014 */  bnez       $v0, .L8010B6E8
    /* FBED4 8010B6D4 00000000 */   nop
    /* FBED8 8010B6D8 04008296 */  lhu        $v0, 0x4($s4)
    /* FBEDC 8010B6DC 01001224 */  addiu      $s2, $zero, 0x1
    /* FBEE0 8010B6E0 C82D0408 */  j          .L8010B720
    /* FBEE4 8010B6E4 00820200 */   sll       $s0, $v0, 8
  .L8010B6E8:
    /* FBEE8 8010B6E8 00008290 */  lbu        $v0, 0x0($a0)
    /* FBEEC 8010B6EC 00000000 */  nop
    /* FBEF0 8010B6F0 80004230 */  andi       $v0, $v0, 0x80
    /* FBEF4 8010B6F4 04004010 */  beqz       $v0, .L8010B708
    /* FBEF8 8010B6F8 00000000 */   nop
    /* FBEFC 8010B6FC 21208700 */  addu       $a0, $a0, $a3
    /* FBF00 8010B700 C82D0408 */  j          .L8010B720
    /* FBF04 8010B704 0100A524 */   addiu     $a1, $a1, 0x1
  .L8010B708:
    /* FBF08 8010B708 01001224 */  addiu      $s2, $zero, 0x1
    /* FBF0C 8010B70C 00008290 */  lbu        $v0, 0x0($a0)
    /* FBF10 8010B710 01008390 */  lbu        $v1, 0x1($a0)
    /* FBF14 8010B714 00120200 */  sll        $v0, $v0, 8
    /* FBF18 8010B718 21804300 */  addu       $s0, $v0, $v1
    /* FBF1C 8010B71C 00821000 */  sll        $s0, $s0, 8
  .L8010B720:
    /* FBF20 8010B720 EBFF4012 */  beqz       $s2, .L8010B6D0
    /* FBF24 8010B724 2A10A800 */   slt       $v0, $a1, $t0
  .L8010B728:
    /* FBF28 8010B728 23100602 */  subu       $v0, $s0, $a2
    /* FBF2C 8010B72C 0000A2AE */  sw         $v0, 0x0($s5)
    /* FBF30 8010B730 01001124 */  addiu      $s1, $zero, 0x1
  .L8010B734:
    /* FBF34 8010B734 21102002 */  addu       $v0, $s1, $zero
    /* FBF38 8010B738 2800BF8F */  lw         $ra, 0x28($sp)
    /* FBF3C 8010B73C 2400B58F */  lw         $s5, 0x24($sp)
    /* FBF40 8010B740 2000B48F */  lw         $s4, 0x20($sp)
    /* FBF44 8010B744 1C00B38F */  lw         $s3, 0x1C($sp)
    /* FBF48 8010B748 1800B28F */  lw         $s2, 0x18($sp)
    /* FBF4C 8010B74C 1400B18F */  lw         $s1, 0x14($sp)
    /* FBF50 8010B750 1000B08F */  lw         $s0, 0x10($sp)
    /* FBF54 8010B754 0800E003 */  jr         $ra
    /* FBF58 8010B758 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSPCH_UnPackSample
