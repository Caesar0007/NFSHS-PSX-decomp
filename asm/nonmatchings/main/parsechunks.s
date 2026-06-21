.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching parsechunks, 0x1DC

glabel parsechunks
    /* ECE34 800FC634 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* ECE38 800FC638 1800B2AF */  sw         $s2, 0x18($sp)
    /* ECE3C 800FC63C 21908000 */  addu       $s2, $a0, $zero
    /* ECE40 800FC640 2800BFAF */  sw         $ra, 0x28($sp)
    /* ECE44 800FC644 2400B5AF */  sw         $s5, 0x24($sp)
    /* ECE48 800FC648 2000B4AF */  sw         $s4, 0x20($sp)
    /* ECE4C 800FC64C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* ECE50 800FC650 1400B1AF */  sw         $s1, 0x14($sp)
    /* ECE54 800FC654 1000B0AF */  sw         $s0, 0x10($sp)
    /* ECE58 800FC658 4800438E */  lw         $v1, 0x48($s2)
    /* ECE5C 800FC65C 4400508E */  lw         $s0, 0x44($s2)
    /* ECE60 800FC660 5000538E */  lw         $s3, 0x50($s2)
    /* ECE64 800FC664 23107000 */  subu       $v0, $v1, $s0
    /* ECE68 800FC668 08004228 */  slti       $v0, $v0, 0x8
    /* ECE6C 800FC66C 5F004014 */  bnez       $v0, .L800FC7EC
    /* ECE70 800FC670 21100000 */   addu      $v0, $zero, $zero
    /* ECE74 800FC674 FEFF1524 */  addiu      $s5, $zero, -0x2
  .L800FC678:
    /* ECE78 800FC678 0400118E */  lw         $s1, 0x4($s0)
    /* ECE7C 800FC67C 00FF023C */  lui        $v0, (0xFF000000 >> 16)
    /* ECE80 800FC680 24102202 */  and        $v0, $s1, $v0
    /* ECE84 800FC684 58004014 */  bnez       $v0, .L800FC7E8
    /* ECE88 800FC688 21A00002 */   addu      $s4, $s0, $zero
    /* ECE8C 800FC68C 21101102 */  addu       $v0, $s0, $s1
    /* ECE90 800FC690 2B106200 */  sltu       $v0, $v1, $v0
    /* ECE94 800FC694 54004014 */  bnez       $v0, .L800FC7E8
    /* ECE98 800FC698 21204002 */   addu      $a0, $s2, $zero
    /* ECE9C 800FC69C 79F1030C */  jal        filterchunk
    /* ECEA0 800FC6A0 21280002 */   addu      $a1, $s0, $zero
    /* ECEA4 800FC6A4 21204000 */  addu       $a0, $v0, $zero
    /* ECEA8 800FC6A8 17008104 */  bgez       $a0, .L800FC708
    /* ECEAC 800FC6AC 001E0400 */   sll       $v1, $a0, 24
    /* ECEB0 800FC6B0 00600640 */  mfc0       $a2, $12 /* handwritten instruction */
    /* ECEB4 800FC6B4 00000000 */  nop
    /* ECEB8 800FC6B8 FEFB0124 */  addiu      $at, $zero, -0x402
    /* ECEBC 800FC6BC 2440C100 */  and        $t0, $a2, $at
    /* ECEC0 800FC6C0 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* ECEC4 800FC6C4 00000000 */  nop
    /* ECEC8 800FC6C8 00000000 */  nop
    /* ECECC 800FC6CC 00000000 */  nop
    /* ECED0 800FC6D0 0400628E */  lw         $v0, 0x4($s3)
    /* ECED4 800FC6D4 00000000 */  nop
    /* ECED8 800FC6D8 04004238 */  xori       $v0, $v0, 0x4
    /* ECEDC 800FC6DC 0100452C */  sltiu      $a1, $v0, 0x1
    /* ECEE0 800FC6E0 0600A014 */  bnez       $a1, .L800FC6FC
    /* ECEE4 800FC6E4 00000000 */   nop
    /* ECEE8 800FC6E8 000015AE */  sw         $s5, 0x0($s0)
    /* ECEEC 800FC6EC 4400428E */  lw         $v0, 0x44($s2)
    /* ECEF0 800FC6F0 00000000 */  nop
    /* ECEF4 800FC6F4 21105100 */  addu       $v0, $v0, $s1
    /* ECEF8 800FC6F8 440042AE */  sw         $v0, 0x44($s2)
  .L800FC6FC:
    /* ECEFC 800FC6FC 00608640 */  mtc0       $a2, $12 /* handwritten instruction */
    /* ECF00 800FC700 ECF10308 */  j          .L800FC7B0
    /* ECF04 800FC704 00000000 */   nop
  .L800FC708:
    /* ECF08 800FC708 0400028E */  lw         $v0, 0x4($s0)
    /* ECF0C 800FC70C 00000000 */  nop
    /* ECF10 800FC710 25104300 */  or         $v0, $v0, $v1
    /* ECF14 800FC714 040002AE */  sw         $v0, 0x4($s0)
    /* ECF18 800FC718 00600640 */  mfc0       $a2, $12 /* handwritten instruction */
    /* ECF1C 800FC71C 00000000 */  nop
    /* ECF20 800FC720 FEFB0124 */  addiu      $at, $zero, -0x402
    /* ECF24 800FC724 2440C100 */  and        $t0, $a2, $at
    /* ECF28 800FC728 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* ECF2C 800FC72C 00000000 */  nop
    /* ECF30 800FC730 00000000 */  nop
    /* ECF34 800FC734 00000000 */  nop
    /* ECF38 800FC738 0400628E */  lw         $v0, 0x4($s3)
    /* ECF3C 800FC73C 00000000 */  nop
    /* ECF40 800FC740 04004238 */  xori       $v0, $v0, 0x4
    /* ECF44 800FC744 0100452C */  sltiu      $a1, $v0, 0x1
    /* ECF48 800FC748 1800A014 */  bnez       $a1, .L800FC7AC
    /* ECF4C 800FC74C 00110400 */   sll       $v0, $a0, 4
    /* ECF50 800FC750 1800438E */  lw         $v1, 0x18($s2)
    /* ECF54 800FC754 F0FF4224 */  addiu      $v0, $v0, -0x10
    /* ECF58 800FC758 21186200 */  addu       $v1, $v1, $v0
    /* ECF5C 800FC75C 0800628C */  lw         $v0, 0x8($v1)
    /* ECF60 800FC760 00000000 */  nop
    /* ECF64 800FC764 21105100 */  addu       $v0, $v0, $s1
    /* ECF68 800FC768 02005114 */  bne        $v0, $s1, .L800FC774
    /* ECF6C 800FC76C 080062AC */   sw        $v0, 0x8($v1)
    /* ECF70 800FC770 0C0070AC */  sw         $s0, 0xC($v1)
  .L800FC774:
    /* ECF74 800FC774 4400428E */  lw         $v0, 0x44($s2)
    /* ECF78 800FC778 00000000 */  nop
    /* ECF7C 800FC77C 21105100 */  addu       $v0, $v0, $s1
    /* ECF80 800FC780 440042AE */  sw         $v0, 0x44($s2)
    /* ECF84 800FC784 3C00428E */  lw         $v0, 0x3C($s2)
    /* ECF88 800FC788 3400448E */  lw         $a0, 0x34($s2)
    /* ECF8C 800FC78C 21185100 */  addu       $v1, $v0, $s1
    /* ECF90 800FC790 2A104400 */  slt        $v0, $v0, $a0
    /* ECF94 800FC794 05004010 */  beqz       $v0, .L800FC7AC
    /* ECF98 800FC798 3C0043AE */   sw        $v1, 0x3C($s2)
    /* ECF9C 800FC79C 2A106400 */  slt        $v0, $v1, $a0
    /* ECFA0 800FC7A0 02004014 */  bnez       $v0, .L800FC7AC
    /* ECFA4 800FC7A4 00000000 */   nop
    /* ECFA8 800FC7A8 380040AE */  sw         $zero, 0x38($s2)
  .L800FC7AC:
    /* ECFAC 800FC7AC 00608640 */  mtc0       $a2, $12 /* handwritten instruction */
  .L800FC7B0:
    /* ECFB0 800FC7B0 0E00A014 */  bnez       $a1, .L800FC7EC
    /* ECFB4 800FC7B4 21100000 */   addu      $v0, $zero, $zero
    /* ECFB8 800FC7B8 0000838E */  lw         $v1, 0x0($s4)
    /* ECFBC 800FC7BC 5C00628E */  lw         $v0, 0x5C($s3)
    /* ECFC0 800FC7C0 00000000 */  nop
    /* ECFC4 800FC7C4 09006210 */  beq        $v1, $v0, .L800FC7EC
    /* ECFC8 800FC7C8 01000224 */   addiu     $v0, $zero, 0x1
    /* ECFCC 800FC7CC 4800438E */  lw         $v1, 0x48($s2)
    /* ECFD0 800FC7D0 4400508E */  lw         $s0, 0x44($s2)
    /* ECFD4 800FC7D4 00000000 */  nop
    /* ECFD8 800FC7D8 23107000 */  subu       $v0, $v1, $s0
    /* ECFDC 800FC7DC 08004228 */  slti       $v0, $v0, 0x8
    /* ECFE0 800FC7E0 A5FF4010 */  beqz       $v0, .L800FC678
    /* ECFE4 800FC7E4 00000000 */   nop
  .L800FC7E8:
    /* ECFE8 800FC7E8 21100000 */  addu       $v0, $zero, $zero
  .L800FC7EC:
    /* ECFEC 800FC7EC 2800BF8F */  lw         $ra, 0x28($sp)
    /* ECFF0 800FC7F0 2400B58F */  lw         $s5, 0x24($sp)
    /* ECFF4 800FC7F4 2000B48F */  lw         $s4, 0x20($sp)
    /* ECFF8 800FC7F8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* ECFFC 800FC7FC 1800B28F */  lw         $s2, 0x18($sp)
    /* ED000 800FC800 1400B18F */  lw         $s1, 0x14($sp)
    /* ED004 800FC804 1000B08F */  lw         $s0, 0x10($sp)
    /* ED008 800FC808 0800E003 */  jr         $ra
    /* ED00C 800FC80C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel parsechunks
