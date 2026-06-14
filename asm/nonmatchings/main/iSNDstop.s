.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstop, 0x104

glabel iSNDstop
    /* F0690 800FFE90 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* F0694 800FFE94 1400B1AF */  sw         $s1, 0x14($sp)
    /* F0698 800FFE98 21888000 */  addu       $s1, $a0, $zero
    /* F069C 800FFE9C 40101100 */  sll        $v0, $s1, 1
    /* F06A0 800FFEA0 21105100 */  addu       $v0, $v0, $s1
    /* F06A4 800FFEA4 80100200 */  sll        $v0, $v0, 2
    /* F06A8 800FFEA8 23105100 */  subu       $v0, $v0, $s1
    /* F06AC 800FFEAC 80100200 */  sll        $v0, $v0, 2
    /* F06B0 800FFEB0 1480033C */  lui        $v1, %hi(D_801479F0)
    /* F06B4 800FFEB4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F06B8 800FFEB8 F0797324 */  addiu      $s3, $v1, %lo(D_801479F0)
    /* F06BC 800FFEBC 1000B0AF */  sw         $s0, 0x10($sp)
    /* F06C0 800FFEC0 21805300 */  addu       $s0, $v0, $s3
    /* F06C4 800FFEC4 2800BFAF */  sw         $ra, 0x28($sp)
    /* F06C8 800FFEC8 2400B5AF */  sw         $s5, 0x24($sp)
    /* F06CC 800FFECC 2000B4AF */  sw         $s4, 0x20($sp)
    /* F06D0 800FFED0 1800B2AF */  sw         $s2, 0x18($sp)
    /* F06D4 800FFED4 27000292 */  lbu        $v0, 0x27($s0)
    /* F06D8 800FFED8 00000000 */  nop
    /* F06DC 800FFEDC 00160200 */  sll        $v0, $v0, 24
    /* F06E0 800FFEE0 05004004 */  bltz       $v0, .L800FFEF8
    /* F06E4 800FFEE4 00000000 */   nop
    /* F06E8 800FFEE8 4C06628E */  lw         $v0, 0x64C($s3)
    /* F06EC 800FFEEC 00000000 */  nop
    /* F06F0 800FFEF0 09F84000 */  jalr       $v0
    /* F06F4 800FFEF4 21200002 */   addu      $a0, $s0, $zero
  .L800FFEF8:
    /* F06F8 800FFEF8 03FB030C */  jal        iSNDfreechan
    /* F06FC 800FFEFC 21202002 */   addu      $a0, $s1, $zero
    /* F0700 800FFF00 03001524 */  addiu      $s5, $zero, 0x3
    /* F0704 800FFF04 01001424 */  addiu      $s4, $zero, 0x1
    /* F0708 800FFF08 1D0015A2 */  sb         $s5, 0x1D($s0)
    /* F070C 800FFF0C 1C0000A2 */  sb         $zero, 0x1C($s0)
    /* F0710 800FFF10 1F000292 */  lbu        $v0, 0x1F($s0)
    /* F0714 800FFF14 00000000 */  nop
    /* F0718 800FFF18 0200422C */  sltiu      $v0, $v0, 0x2
    /* F071C 800FFF1C 11004014 */  bnez       $v0, .L800FFF64
    /* F0720 800FFF20 04903402 */   sllv      $s2, $s4, $s1
    /* F0724 800FFF24 20000292 */  lbu        $v0, 0x20($s0)
    /* F0728 800FFF28 00000000 */  nop
    /* F072C 800FFF2C 00160200 */  sll        $v0, $v0, 24
    /* F0730 800FFF30 038E0200 */  sra        $s1, $v0, 24
    /* F0734 800FFF34 03FB030C */  jal        iSNDfreechan
    /* F0738 800FFF38 21202002 */   addu      $a0, $s1, $zero
    /* F073C 800FFF3C 04109102 */  sllv       $v0, $s1, $s4
    /* F0740 800FFF40 21105100 */  addu       $v0, $v0, $s1
    /* F0744 800FFF44 80100200 */  sll        $v0, $v0, 2
    /* F0748 800FFF48 23105100 */  subu       $v0, $v0, $s1
    /* F074C 800FFF4C 80100200 */  sll        $v0, $v0, 2
    /* F0750 800FFF50 21805300 */  addu       $s0, $v0, $s3
    /* F0754 800FFF54 04103402 */  sllv       $v0, $s4, $s1
    /* F0758 800FFF58 25904202 */  or         $s2, $s2, $v0
    /* F075C 800FFF5C 1D0015A2 */  sb         $s5, 0x1D($s0)
    /* F0760 800FFF60 1C0000A2 */  sb         $zero, 0x1C($s0)
  .L800FFF64:
    /* F0764 800FFF64 5AFC030C */  jal        iSNDpsxkeyoff
    /* F0768 800FFF68 21204002 */   addu      $a0, $s2, $zero
    /* F076C 800FFF6C 2800BF8F */  lw         $ra, 0x28($sp)
    /* F0770 800FFF70 2400B58F */  lw         $s5, 0x24($sp)
    /* F0774 800FFF74 2000B48F */  lw         $s4, 0x20($sp)
    /* F0778 800FFF78 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F077C 800FFF7C 1800B28F */  lw         $s2, 0x18($sp)
    /* F0780 800FFF80 1400B18F */  lw         $s1, 0x14($sp)
    /* F0784 800FFF84 1000B08F */  lw         $s0, 0x10($sp)
    /* F0788 800FFF88 21100000 */  addu       $v0, $zero, $zero
    /* F078C 800FFF8C 0800E003 */  jr         $ra
    /* F0790 800FFF90 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDstop
