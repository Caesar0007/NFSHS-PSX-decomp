.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformresolve, 0x1FC

glabel iSNDplatformresolve
    /* FBF5C 8010B75C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* FBF60 8010B760 3800B6AF */  sw         $s6, 0x38($sp)
    /* FBF64 8010B764 21B0A000 */  addu       $s6, $a1, $zero
    /* FBF68 8010B768 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* FBF6C 8010B76C 21B8C000 */  addu       $s7, $a2, $zero
    /* FBF70 8010B770 2400B1AF */  sw         $s1, 0x24($sp)
    /* FBF74 8010B774 21880000 */  addu       $s1, $zero, $zero
    /* FBF78 8010B778 3400B5AF */  sw         $s5, 0x34($sp)
    /* FBF7C 8010B77C 01001524 */  addiu      $s5, $zero, 0x1
    /* FBF80 8010B780 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* FBF84 8010B784 21982002 */  addu       $s3, $s1, $zero
    /* FBF88 8010B788 3000B4AF */  sw         $s4, 0x30($sp)
    /* FBF8C 8010B78C 21A02002 */  addu       $s4, $s1, $zero
    /* FBF90 8010B790 2800B2AF */  sw         $s2, 0x28($sp)
    /* FBF94 8010B794 21902002 */  addu       $s2, $s1, $zero
    /* FBF98 8010B798 4000BFAF */  sw         $ra, 0x40($sp)
    /* FBF9C 8010B79C 2000B0AF */  sw         $s0, 0x20($sp)
    /* FBFA0 8010B7A0 4800A4AF */  sw         $a0, 0x48($sp)
    /* FBFA4 8010B7A4 4800A427 */  addiu      $a0, $sp, 0x48
  .L8010B7A8:
    /* FBFA8 8010B7A8 1000A527 */  addiu      $a1, $sp, 0x10
  .L8010B7AC:
    /* FBFAC 8010B7AC 1400A627 */  addiu      $a2, $sp, 0x14
    /* FBFB0 8010B7B0 542F040C */  jal        iSNDgettag
    /* FBFB4 8010B7B4 1800A727 */   addiu     $a3, $sp, 0x18
    /* FBFB8 8010B7B8 1C004010 */  beqz       $v0, .L8010B82C
    /* FBFBC 8010B7BC FE000224 */   addiu     $v0, $zero, 0xFE
    /* FBFC0 8010B7C0 1000A38F */  lw         $v1, 0x10($sp)
    /* FBFC4 8010B7C4 00000000 */  nop
    /* FBFC8 8010B7C8 18006210 */  beq        $v1, $v0, .L8010B82C
    /* FBFCC 8010B7CC 80000224 */   addiu     $v0, $zero, 0x80
    /* FBFD0 8010B7D0 F5FF6210 */  beq        $v1, $v0, .L8010B7A8
    /* FBFD4 8010B7D4 4800A427 */   addiu     $a0, $sp, 0x48
    /* FBFD8 8010B7D8 88000224 */  addiu      $v0, $zero, 0x88
    /* FBFDC 8010B7DC 04006214 */  bne        $v1, $v0, .L8010B7F0
    /* FBFE0 8010B7E0 8A000224 */   addiu     $v0, $zero, 0x8A
    /* FBFE4 8010B7E4 1400B38F */  lw         $s3, 0x14($sp)
    /* FBFE8 8010B7E8 EB2D0408 */  j          .L8010B7AC
    /* FBFEC 8010B7EC 1000A527 */   addiu     $a1, $sp, 0x10
  .L8010B7F0:
    /* FBFF0 8010B7F0 04006214 */  bne        $v1, $v0, .L8010B804
    /* FBFF4 8010B7F4 82000224 */   addiu     $v0, $zero, 0x82
    /* FBFF8 8010B7F8 1800B48F */  lw         $s4, 0x18($sp)
    /* FBFFC 8010B7FC EA2D0408 */  j          .L8010B7A8
    /* FC000 8010B800 4800A427 */   addiu     $a0, $sp, 0x48
  .L8010B804:
    /* FC004 8010B804 04006214 */  bne        $v1, $v0, .L8010B818
    /* FC008 8010B808 85000224 */   addiu     $v0, $zero, 0x85
    /* FC00C 8010B80C 1400B58F */  lw         $s5, 0x14($sp)
    /* FC010 8010B810 EA2D0408 */  j          .L8010B7A8
    /* FC014 8010B814 4800A427 */   addiu     $a0, $sp, 0x48
  .L8010B818:
    /* FC018 8010B818 E3FF6214 */  bne        $v1, $v0, .L8010B7A8
    /* FC01C 8010B81C 4800A427 */   addiu     $a0, $sp, 0x48
    /* FC020 8010B820 1400B18F */  lw         $s1, 0x14($sp)
    /* FC024 8010B824 EB2D0408 */  j          .L8010B7AC
    /* FC028 8010B828 1000A527 */   addiu     $a1, $sp, 0x10
  .L8010B82C:
    /* FC02C 8010B82C 3E00C012 */  beqz       $s6, .L8010B928
    /* FC030 8010B830 C0101200 */   sll       $v0, $s2, 3
    /* FC034 8010B834 21205700 */  addu       $a0, $v0, $s7
    /* FC038 8010B838 0000838C */  lw         $v1, 0x0($a0)
    /* FC03C 8010B83C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* FC040 8010B840 0D006210 */  beq        $v1, $v0, .L8010B878
    /* FC044 8010B844 00000000 */   nop
    /* FC048 8010B848 21284000 */  addu       $a1, $v0, $zero
    /* FC04C 8010B84C 21188000 */  addu       $v1, $a0, $zero
  .L8010B850:
    /* FC050 8010B850 21206000 */  addu       $a0, $v1, $zero
    /* FC054 8010B854 0000828C */  lw         $v0, 0x0($a0)
    /* FC058 8010B858 00000000 */  nop
    /* FC05C 8010B85C 21005310 */  beq        $v0, $s3, .L8010B8E4
    /* FC060 8010B860 00000000 */   nop
    /* FC064 8010B864 08008324 */  addiu      $v1, $a0, 0x8
    /* FC068 8010B868 0800828C */  lw         $v0, 0x8($a0)
    /* FC06C 8010B86C 00000000 */  nop
    /* FC070 8010B870 F7FF4514 */  bne        $v0, $a1, .L8010B850
    /* FC074 8010B874 01005226 */   addiu     $s2, $s2, 0x1
  .L8010B878:
    /* FC078 8010B878 0000828E */  lw         $v0, 0x0($s4)
    /* FC07C 8010B87C 00000000 */  nop
    /* FC080 8010B880 2A004014 */  bnez       $v0, .L8010B92C
    /* FC084 8010B884 07000224 */   addiu     $v0, $zero, 0x7
    /* FC088 8010B888 4992023C */  lui        $v0, (0x92492493 >> 16)
    /* FC08C 8010B88C 93244234 */  ori        $v0, $v0, (0x92492493 & 0xFFFF)
    /* FC090 8010B890 18002202 */  mult       $s1, $v0
    /* FC094 8010B894 C31F1100 */  sra        $v1, $s1, 31
    /* FC098 8010B898 10400000 */  mfhi       $t0
    /* FC09C 8010B89C 21101101 */  addu       $v0, $t0, $s1
    /* FC0A0 8010B8A0 03110200 */  sra        $v0, $v0, 4
    /* FC0A4 8010B8A4 23804300 */  subu       $s0, $v0, $v1
    /* FC0A8 8010B8A8 C0101000 */  sll        $v0, $s0, 3
    /* FC0AC 8010B8AC 23105000 */  subu       $v0, $v0, $s0
    /* FC0B0 8010B8B0 80100200 */  sll        $v0, $v0, 2
    /* FC0B4 8010B8B4 02002212 */  beq        $s1, $v0, .L8010B8C0
    /* FC0B8 8010B8B8 00111500 */   sll       $v0, $s5, 4
    /* FC0BC 8010B8BC 01001026 */  addiu      $s0, $s0, 0x1
  .L8010B8C0:
    /* FC0C0 8010B8C0 18000202 */  mult       $s0, $v0
    /* FC0C4 8010B8C4 12800000 */  mflo       $s0
    /* FC0C8 8010B8C8 7329040C */  jal        iSNDpsxmalloc
    /* FC0CC 8010B8CC 21200002 */   addu      $a0, $s0, $zero
    /* FC0D0 8010B8D0 21884000 */  addu       $s1, $v0, $zero
    /* FC0D4 8010B8D4 06002016 */  bnez       $s1, .L8010B8F0
    /* FC0D8 8010B8D8 21282002 */   addu      $a1, $s1, $zero
    /* FC0DC 8010B8DC 4B2E0408 */  j          .L8010B92C
    /* FC0E0 8010B8E0 FAFF0224 */   addiu     $v0, $zero, -0x6
  .L8010B8E4:
    /* FC0E4 8010B8E4 0400628C */  lw         $v0, 0x4($v1)
    /* FC0E8 8010B8E8 1E2E0408 */  j          .L8010B878
    /* FC0EC 8010B8EC 000082AE */   sw        $v0, 0x0($s4)
  .L8010B8F0:
    /* FC0F0 8010B8F0 2120D302 */  addu       $a0, $s6, $s3
    /* FC0F4 8010B8F4 21300002 */  addu       $a2, $s0, $zero
    /* FC0F8 8010B8F8 652B040C */  jal        iSNDdmqueuesplit
    /* FC0FC 8010B8FC 01000724 */   addiu     $a3, $zero, 0x1
    /* FC100 8010B900 21804000 */  addu       $s0, $v0, $zero
    /* FC104 8010B904 C0101200 */  sll        $v0, $s2, 3
    /* FC108 8010B908 21105700 */  addu       $v0, $v0, $s7
    /* FC10C 8010B90C 000091AE */  sw         $s1, 0x0($s4)
    /* FC110 8010B910 000053AC */  sw         $s3, 0x0($v0)
    /* FC114 8010B914 040051AC */  sw         $s1, 0x4($v0)
  .L8010B918:
    /* FC118 8010B918 9B2B040C */  jal        iSNDdmcomplete
    /* FC11C 8010B91C 21200002 */   addu      $a0, $s0, $zero
    /* FC120 8010B920 FDFF4010 */  beqz       $v0, .L8010B918
    /* FC124 8010B924 00000000 */   nop
  .L8010B928:
    /* FC128 8010B928 07000224 */  addiu      $v0, $zero, 0x7
  .L8010B92C:
    /* FC12C 8010B92C 4000BF8F */  lw         $ra, 0x40($sp)
    /* FC130 8010B930 3C00B78F */  lw         $s7, 0x3C($sp)
    /* FC134 8010B934 3800B68F */  lw         $s6, 0x38($sp)
    /* FC138 8010B938 3400B58F */  lw         $s5, 0x34($sp)
    /* FC13C 8010B93C 3000B48F */  lw         $s4, 0x30($sp)
    /* FC140 8010B940 2C00B38F */  lw         $s3, 0x2C($sp)
    /* FC144 8010B944 2800B28F */  lw         $s2, 0x28($sp)
    /* FC148 8010B948 2400B18F */  lw         $s1, 0x24($sp)
    /* FC14C 8010B94C 2000B08F */  lw         $s0, 0x20($sp)
    /* FC150 8010B950 0800E003 */  jr         $ra
    /* FC154 8010B954 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel iSNDplatformresolve
