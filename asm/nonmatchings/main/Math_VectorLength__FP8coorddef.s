.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Math_VectorLength__FP8coorddef, 0x19C

glabel Math_VectorLength__FP8coorddef
    /* 8DEEC 8009D6EC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 8DEF0 8009D6F0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 8DEF4 8009D6F4 21980000 */  addu       $s3, $zero, $zero
    /* 8DEF8 8009D6F8 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 8DEFC 8009D6FC 2800B6AF */  sw         $s6, 0x28($sp)
    /* 8DF00 8009D700 2400B5AF */  sw         $s5, 0x24($sp)
    /* 8DF04 8009D704 2000B4AF */  sw         $s4, 0x20($sp)
    /* 8DF08 8009D708 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8DF0C 8009D70C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8DF10 8009D710 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8DF14 8009D714 0000928C */  lw         $s2, 0x0($a0)
    /* 8DF18 8009D718 0400918C */  lw         $s1, 0x4($a0)
    /* 8DF1C 8009D71C 0800908C */  lw         $s0, 0x8($a0)
    /* 8DF20 8009D720 02004106 */  bgez       $s2, .L8009D72C
    /* 8DF24 8009D724 21104002 */   addu      $v0, $s2, $zero
    /* 8DF28 8009D728 23100200 */  negu       $v0, $v0
  .L8009D72C:
    /* 8DF2C 8009D72C D5750208 */  j          .L8009D754
    /* 8DF30 8009D730 0001033C */   lui       $v1, (0x1000000 >> 16)
  .L8009D734:
    /* 8DF34 8009D734 43901200 */  sra        $s2, $s2, 1
    /* 8DF38 8009D738 43881100 */  sra        $s1, $s1, 1
    /* 8DF3C 8009D73C 43801000 */  sra        $s0, $s0, 1
    /* 8DF40 8009D740 01007326 */  addiu      $s3, $s3, 0x1
    /* 8DF44 8009D744 02004106 */  bgez       $s2, .L8009D750
    /* 8DF48 8009D748 21104002 */   addu      $v0, $s2, $zero
    /* 8DF4C 8009D74C 23100200 */  negu       $v0, $v0
  .L8009D750:
    /* 8DF50 8009D750 0001033C */  lui        $v1, (0x1000000 >> 16)
  .L8009D754:
    /* 8DF54 8009D754 2A106200 */  slt        $v0, $v1, $v0
    /* 8DF58 8009D758 F6FF4014 */  bnez       $v0, .L8009D734
    /* 8DF5C 8009D75C 00000000 */   nop
    /* 8DF60 8009D760 02002106 */  bgez       $s1, .L8009D76C
    /* 8DF64 8009D764 21102002 */   addu      $v0, $s1, $zero
    /* 8DF68 8009D768 23100200 */  negu       $v0, $v0
  .L8009D76C:
    /* 8DF6C 8009D76C 2A106200 */  slt        $v0, $v1, $v0
    /* 8DF70 8009D770 F0FF4014 */  bnez       $v0, .L8009D734
    /* 8DF74 8009D774 00000000 */   nop
    /* 8DF78 8009D778 02000106 */  bgez       $s0, .L8009D784
    /* 8DF7C 8009D77C 21100002 */   addu      $v0, $s0, $zero
    /* 8DF80 8009D780 23100200 */  negu       $v0, $v0
  .L8009D784:
    /* 8DF84 8009D784 2A106200 */  slt        $v0, $v1, $v0
    /* 8DF88 8009D788 EAFF4014 */  bnez       $v0, .L8009D734
    /* 8DF8C 8009D78C 21204002 */   addu      $a0, $s2, $zero
    /* 8DF90 8009D790 CA90030C */  jal        fixedmult
    /* 8DF94 8009D794 21284002 */   addu      $a1, $s2, $zero
    /* 8DF98 8009D798 21A84000 */  addu       $s5, $v0, $zero
    /* 8DF9C 8009D79C 21202002 */  addu       $a0, $s1, $zero
    /* 8DFA0 8009D7A0 CA90030C */  jal        fixedmult
    /* 8DFA4 8009D7A4 21282002 */   addu      $a1, $s1, $zero
    /* 8DFA8 8009D7A8 21A04000 */  addu       $s4, $v0, $zero
    /* 8DFAC 8009D7AC 21200002 */  addu       $a0, $s0, $zero
    /* 8DFB0 8009D7B0 CA90030C */  jal        fixedmult
    /* 8DFB4 8009D7B4 21280002 */   addu      $a1, $s0, $zero
    /* 8DFB8 8009D7B8 21304000 */  addu       $a2, $v0, $zero
    /* 8DFBC 8009D7BC 82101500 */  srl        $v0, $s5, 2
    /* 8DFC0 8009D7C0 82201400 */  srl        $a0, $s4, 2
    /* 8DFC4 8009D7C4 82280600 */  srl        $a1, $a2, 2
    /* 8DFC8 8009D7C8 21184400 */  addu       $v1, $v0, $a0
    /* 8DFCC 8009D7CC 21186500 */  addu       $v1, $v1, $a1
    /* 8DFD0 8009D7D0 0040023C */  lui        $v0, (0x40000000 >> 16)
    /* 8DFD4 8009D7D4 2B104300 */  sltu       $v0, $v0, $v1
    /* 8DFD8 8009D7D8 1A004010 */  beqz       $v0, .L8009D844
    /* 8DFDC 8009D7DC 2120B402 */   addu      $a0, $s5, $s4
    /* 8DFE0 8009D7E0 0040163C */  lui        $s6, (0x40000000 >> 16)
  .L8009D7E4:
    /* 8DFE4 8009D7E4 43901200 */  sra        $s2, $s2, 1
    /* 8DFE8 8009D7E8 43881100 */  sra        $s1, $s1, 1
    /* 8DFEC 8009D7EC 43801000 */  sra        $s0, $s0, 1
    /* 8DFF0 8009D7F0 01007326 */  addiu      $s3, $s3, 0x1
    /* 8DFF4 8009D7F4 21204002 */  addu       $a0, $s2, $zero
    /* 8DFF8 8009D7F8 CA90030C */  jal        fixedmult
    /* 8DFFC 8009D7FC 21284002 */   addu      $a1, $s2, $zero
    /* 8E000 8009D800 21A84000 */  addu       $s5, $v0, $zero
    /* 8E004 8009D804 21202002 */  addu       $a0, $s1, $zero
    /* 8E008 8009D808 CA90030C */  jal        fixedmult
    /* 8E00C 8009D80C 21282002 */   addu      $a1, $s1, $zero
    /* 8E010 8009D810 21A04000 */  addu       $s4, $v0, $zero
    /* 8E014 8009D814 21200002 */  addu       $a0, $s0, $zero
    /* 8E018 8009D818 CA90030C */  jal        fixedmult
    /* 8E01C 8009D81C 21280002 */   addu      $a1, $s0, $zero
    /* 8E020 8009D820 21304000 */  addu       $a2, $v0, $zero
    /* 8E024 8009D824 82101500 */  srl        $v0, $s5, 2
    /* 8E028 8009D828 82201400 */  srl        $a0, $s4, 2
    /* 8E02C 8009D82C 82280600 */  srl        $a1, $a2, 2
    /* 8E030 8009D830 21104400 */  addu       $v0, $v0, $a0
    /* 8E034 8009D834 21104500 */  addu       $v0, $v0, $a1
    /* 8E038 8009D838 2B10C202 */  sltu       $v0, $s6, $v0
    /* 8E03C 8009D83C E9FF4014 */  bnez       $v0, .L8009D7E4
    /* 8E040 8009D840 2120B402 */   addu      $a0, $s5, $s4
  .L8009D844:
    /* 8E044 8009D844 2BAC030C */  jal        fixedsqrt
    /* 8E048 8009D848 21208600 */   addu      $a0, $a0, $a2
    /* 8E04C 8009D84C 04006012 */  beqz       $s3, .L8009D860
    /* 8E050 8009D850 00000000 */   nop
  .L8009D854:
    /* 8E054 8009D854 FFFF7326 */  addiu      $s3, $s3, -0x1
    /* 8E058 8009D858 FEFF6016 */  bnez       $s3, .L8009D854
    /* 8E05C 8009D85C 40100200 */   sll       $v0, $v0, 1
  .L8009D860:
    /* 8E060 8009D860 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 8E064 8009D864 2800B68F */  lw         $s6, 0x28($sp)
    /* 8E068 8009D868 2400B58F */  lw         $s5, 0x24($sp)
    /* 8E06C 8009D86C 2000B48F */  lw         $s4, 0x20($sp)
    /* 8E070 8009D870 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 8E074 8009D874 1800B28F */  lw         $s2, 0x18($sp)
    /* 8E078 8009D878 1400B18F */  lw         $s1, 0x14($sp)
    /* 8E07C 8009D87C 1000B08F */  lw         $s0, 0x10($sp)
    /* 8E080 8009D880 0800E003 */  jr         $ra
    /* 8E084 8009D884 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Math_VectorLength__FP8coorddef
