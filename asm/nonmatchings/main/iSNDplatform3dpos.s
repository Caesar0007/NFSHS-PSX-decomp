.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatform3dpos, 0x11C

glabel iSNDplatform3dpos
    /* EF630 800FEE30 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* EF634 800FEE34 2400B1AF */  sw         $s1, 0x24($sp)
    /* EF638 800FEE38 21888000 */  addu       $s1, $a0, $zero
    /* EF63C 800FEE3C 2120A000 */  addu       $a0, $a1, $zero
    /* EF640 800FEE40 40101100 */  sll        $v0, $s1, 1
    /* EF644 800FEE44 21405100 */  addu       $t0, $v0, $s1
    /* EF648 800FEE48 80180800 */  sll        $v1, $t0, 2
    /* EF64C 800FEE4C 23187100 */  subu       $v1, $v1, $s1
    /* EF650 800FEE50 80180300 */  sll        $v1, $v1, 2
    /* EF654 800FEE54 1480023C */  lui        $v0, %hi(D_801479F0)
    /* EF658 800FEE58 F0794224 */  addiu      $v0, $v0, %lo(D_801479F0)
    /* EF65C 800FEE5C 2000B0AF */  sw         $s0, 0x20($sp)
    /* EF660 800FEE60 21806200 */  addu       $s0, $v1, $v0
    /* EF664 800FEE64 2800BFAF */  sw         $ra, 0x28($sp)
    /* EF668 800FEE68 180004A6 */  sh         $a0, 0x18($s0)
    /* EF66C 800FEE6C 1C000392 */  lbu        $v1, 0x1C($s0)
    /* EF670 800FEE70 02000224 */  addiu      $v0, $zero, 0x2
    /* EF674 800FEE74 30006214 */  bne        $v1, $v0, .L800FEF38
    /* EF678 800FEE78 21100000 */   addu      $v0, $zero, $zero
    /* EF67C 800FEE7C 1E000392 */  lbu        $v1, 0x1E($s0)
    /* EF680 800FEE80 01000224 */  addiu      $v0, $zero, 0x1
    /* EF684 800FEE84 14006214 */  bne        $v1, $v0, .L800FEED8
    /* EF688 800FEE88 1800A627 */   addiu     $a2, $sp, 0x18
    /* EF68C 800FEE8C 1480033C */  lui        $v1, %hi(D_801478F4)
    /* EF690 800FEE90 C0100800 */  sll        $v0, $t0, 3
    /* EF694 800FEE94 21105100 */  addu       $v0, $v0, $s1
    /* EF698 800FEE98 80100200 */  sll        $v0, $v0, 2
    /* EF69C 800FEE9C F478658C */  lw         $a1, %lo(D_801478F4)($v1)
    /* EF6A0 800FEEA0 24000392 */  lbu        $v1, 0x24($s0)
    /* EF6A4 800FEEA4 21104500 */  addu       $v0, $v0, $a1
    /* EF6A8 800FEEA8 001E0300 */  sll        $v1, $v1, 24
    /* EF6AC 800FEEAC 2D004580 */  lb         $a1, 0x2D($v0)
    /* EF6B0 800FEEB0 031E0300 */  sra        $v1, $v1, 24
    /* EF6B4 800FEEB4 1000A3AF */  sw         $v1, 0x10($sp)
    /* EF6B8 800FEEB8 25000292 */  lbu        $v0, 0x25($s0)
    /* EF6BC 800FEEBC 1C00A727 */  addiu      $a3, $sp, 0x1C
    /* EF6C0 800FEEC0 00160200 */  sll        $v0, $v0, 24
    /* EF6C4 800FEEC4 03160200 */  sra        $v0, $v0, 24
    /* EF6C8 800FEEC8 BD2B040C */  jal        iSNDatodlrv
    /* EF6CC 800FEECC 1400A2AF */   sw        $v0, 0x14($sp)
    /* EF6D0 800FEED0 C3FB0308 */  j          .L800FEF0C
    /* EF6D4 800FEED4 00000000 */   nop
  .L800FEED8:
    /* EF6D8 800FEED8 1E000292 */  lbu        $v0, 0x1E($s0)
    /* EF6DC 800FEEDC 00000000 */  nop
    /* EF6E0 800FEEE0 0A004014 */  bnez       $v0, .L800FEF0C
    /* EF6E4 800FEEE4 1800A627 */   addiu     $a2, $sp, 0x18
    /* EF6E8 800FEEE8 1480023C */  lui        $v0, %hi(D_801478F4)
    /* EF6EC 800FEEEC C0180800 */  sll        $v1, $t0, 3
    /* EF6F0 800FEEF0 21187100 */  addu       $v1, $v1, $s1
    /* EF6F4 800FEEF4 F478428C */  lw         $v0, %lo(D_801478F4)($v0)
    /* EF6F8 800FEEF8 80180300 */  sll        $v1, $v1, 2
    /* EF6FC 800FEEFC 21186200 */  addu       $v1, $v1, $v0
    /* EF700 800FEF00 2D006580 */  lb         $a1, 0x2D($v1)
    /* EF704 800FEF04 2A2C040C */  jal        iSNDatolrv
    /* EF708 800FEF08 1C00A727 */   addiu     $a3, $sp, 0x1C
  .L800FEF0C:
    /* EF70C 800FEF0C 1800A293 */  lbu        $v0, 0x18($sp)
    /* EF710 800FEF10 00000000 */  nop
    /* EF714 800FEF14 240002A2 */  sb         $v0, 0x24($s0)
    /* EF718 800FEF18 1C00A293 */  lbu        $v0, 0x1C($sp)
    /* EF71C 800FEF1C 00000000 */  nop
    /* EF720 800FEF20 250002A2 */  sb         $v0, 0x25($s0)
    /* EF724 800FEF24 1800A58F */  lw         $a1, 0x18($sp)
    /* EF728 800FEF28 1C00A68F */  lw         $a2, 0x1C($sp)
    /* EF72C 800FEF2C 8EFC030C */  jal        iSNDsetvol
    /* EF730 800FEF30 21202002 */   addu      $a0, $s1, $zero
    /* EF734 800FEF34 21100000 */  addu       $v0, $zero, $zero
  .L800FEF38:
    /* EF738 800FEF38 2800BF8F */  lw         $ra, 0x28($sp)
    /* EF73C 800FEF3C 2400B18F */  lw         $s1, 0x24($sp)
    /* EF740 800FEF40 2000B08F */  lw         $s0, 0x20($sp)
    /* EF744 800FEF44 0800E003 */  jr         $ra
    /* EF748 800FEF48 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDplatform3dpos
