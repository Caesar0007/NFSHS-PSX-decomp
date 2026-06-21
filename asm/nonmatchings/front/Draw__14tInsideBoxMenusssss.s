.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__14tInsideBoxMenusssss, 0x264

glabel Draw__14tInsideBoxMenusssss
    /* D6FC 8001CEFC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* D700 8001CF00 1800B0AF */  sw         $s0, 0x18($sp)
    /* D704 8001CF04 21808000 */  addu       $s0, $a0, $zero
    /* D708 8001CF08 3400BFAF */  sw         $ra, 0x34($sp)
    /* D70C 8001CF0C 3000B6AF */  sw         $s6, 0x30($sp)
    /* D710 8001CF10 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* D714 8001CF14 2800B4AF */  sw         $s4, 0x28($sp)
    /* D718 8001CF18 2400B3AF */  sw         $s3, 0x24($sp)
    /* D71C 8001CF1C 2000B2AF */  sw         $s2, 0x20($sp)
    /* D720 8001CF20 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D724 8001CF24 6C000286 */  lh         $v0, 0x6C($s0)
    /* D728 8001CF28 0800038E */  lw         $v1, 0x8($s0)
    /* D72C 8001CF2C 4800B697 */  lhu        $s6, 0x48($sp)
    /* D730 8001CF30 0D006210 */  beq        $v1, $v0, .L8001CF68
    /* D734 8001CF34 2A104300 */   slt       $v0, $v0, $v1
    /* D738 8001CF38 04004010 */  beqz       $v0, .L8001CF4C
    /* D73C 8001CF3C 18000224 */   addiu     $v0, $zero, 0x18
    /* D740 8001CF40 6E0002A6 */  sh         $v0, 0x6E($s0)
    /* D744 8001CF44 D6730008 */  j          .L8001CF58
    /* D748 8001CF48 FCFF0224 */   addiu     $v0, $zero, -0x4
  .L8001CF4C:
    /* D74C 8001CF4C E8FF0224 */  addiu      $v0, $zero, -0x18
    /* D750 8001CF50 6E0002A6 */  sh         $v0, 0x6E($s0)
    /* D754 8001CF54 04000224 */  addiu      $v0, $zero, 0x4
  .L8001CF58:
    /* D758 8001CF58 700002A6 */  sh         $v0, 0x70($s0)
    /* D75C 8001CF5C 08000296 */  lhu        $v0, 0x8($s0)
    /* D760 8001CF60 00000000 */  nop
    /* D764 8001CF64 6C0002A6 */  sh         $v0, 0x6C($s0)
  .L8001CF68:
    /* D768 8001CF68 6E000286 */  lh         $v0, 0x6E($s0)
    /* D76C 8001CF6C 6E000496 */  lhu        $a0, 0x6E($s0)
    /* D770 8001CF70 14004010 */  beqz       $v0, .L8001CFC4
    /* D774 8001CF74 21880000 */   addu      $s1, $zero, $zero
    /* D778 8001CF78 70000296 */  lhu        $v0, 0x70($s0)
    /* D77C 8001CF7C 70000386 */  lh         $v1, 0x70($s0)
    /* D780 8001CF80 21108200 */  addu       $v0, $a0, $v0
    /* D784 8001CF84 05006104 */  bgez       $v1, .L8001CF9C
    /* D788 8001CF88 6E0002A6 */   sh        $v0, 0x6E($s0)
    /* D78C 8001CF8C 00140200 */  sll        $v0, $v0, 16
    /* D790 8001CF90 02004104 */  bgez       $v0, .L8001CF9C
    /* D794 8001CF94 00000000 */   nop
    /* D798 8001CF98 6E0000A6 */  sh         $zero, 0x6E($s0)
  .L8001CF9C:
    /* D79C 8001CF9C 70000286 */  lh         $v0, 0x70($s0)
    /* D7A0 8001CFA0 00000000 */  nop
    /* D7A4 8001CFA4 07004018 */  blez       $v0, .L8001CFC4
    /* D7A8 8001CFA8 21880000 */   addu      $s1, $zero, $zero
    /* D7AC 8001CFAC 6E000286 */  lh         $v0, 0x6E($s0)
    /* D7B0 8001CFB0 00000000 */  nop
    /* D7B4 8001CFB4 04004018 */  blez       $v0, .L8001CFC8
    /* D7B8 8001CFB8 00140500 */   sll       $v0, $a1, 16
    /* D7BC 8001CFBC 6E0000A6 */  sh         $zero, 0x6E($s0)
    /* D7C0 8001CFC0 21880000 */  addu       $s1, $zero, $zero
  .L8001CFC4:
    /* D7C4 8001CFC4 00140500 */  sll        $v0, $a1, 16
  .L8001CFC8:
    /* D7C8 8001CFC8 03AC0200 */  sra        $s5, $v0, 16
    /* D7CC 8001CFCC 00140600 */  sll        $v0, $a2, 16
    /* D7D0 8001CFD0 03A40200 */  sra        $s4, $v0, 16
    /* D7D4 8001CFD4 00140700 */  sll        $v0, $a3, 16
    /* D7D8 8001CFD8 039C0200 */  sra        $s3, $v0, 16
  .L8001CFDC:
    /* D7DC 8001CFDC 08000396 */  lhu        $v1, 0x8($s0)
    /* D7E0 8001CFE0 FEFF2226 */  addiu      $v0, $s1, -0x2
    /* D7E4 8001CFE4 21186200 */  addu       $v1, $v1, $v0
    /* D7E8 8001CFE8 00141100 */  sll        $v0, $s1, 16
    /* D7EC 8001CFEC 03140200 */  sra        $v0, $v0, 16
    /* D7F0 8001CFF0 04004228 */  slti       $v0, $v0, 0x4
    /* D7F4 8001CFF4 08004014 */  bnez       $v0, .L8001D018
    /* D7F8 8001CFF8 21906000 */   addu      $s2, $v1, $zero
    /* D7FC 8001CFFC 00140300 */  sll        $v0, $v1, 16
    /* D800 8001D000 83130200 */  sra        $v0, $v0, 14
    /* D804 8001D004 21105000 */  addu       $v0, $v0, $s0
    /* D808 8001D008 0C00428C */  lw         $v0, 0xC($v0)
    /* D80C 8001D00C 00000000 */  nop
    /* D810 8001D010 49004010 */  beqz       $v0, .L8001D138
    /* D814 8001D014 00000000 */   nop
  .L8001D018:
    /* D818 8001D018 00140300 */  sll        $v0, $v1, 16
    /* D81C 8001D01C 032C0200 */  sra        $a1, $v0, 16
    /* D820 8001D020 3E00A004 */  bltz       $a1, .L8001D11C
    /* D824 8001D024 80100500 */   sll       $v0, $a1, 2
    /* D828 8001D028 21100202 */  addu       $v0, $s0, $v0
    /* D82C 8001D02C 1000448C */  lw         $a0, 0x10($v0)
    /* D830 8001D030 00000000 */  nop
    /* D834 8001D034 3A008010 */  beqz       $a0, .L8001D120
    /* D838 8001D038 01002226 */   addiu     $v0, $s1, 0x1
    /* D83C 8001D03C 1800828C */  lw         $v0, 0x18($a0)
    /* D840 8001D040 00000000 */  nop
    /* D844 8001D044 50004624 */  addiu      $a2, $v0, 0x50
    /* D848 8001D048 50004284 */  lh         $v0, 0x50($v0)
    /* D84C 8001D04C 6E000386 */  lh         $v1, 0x6E($s0)
    /* D850 8001D050 00000000 */  nop
    /* D854 8001D054 06006014 */  bnez       $v1, .L8001D070
    /* D858 8001D058 21208200 */   addu      $a0, $a0, $v0
    /* D85C 8001D05C 0800028E */  lw         $v0, 0x8($s0)
    /* D860 8001D060 00000000 */  nop
    /* D864 8001D064 2610A200 */  xor        $v0, $a1, $v0
    /* D868 8001D068 1D740008 */  j          .L8001D074
    /* D86C 8001D06C 0100452C */   sltiu     $a1, $v0, 0x1
  .L8001D070:
    /* D870 8001D070 21280000 */  addu       $a1, $zero, $zero
  .L8001D074:
    /* D874 8001D074 0400C28C */  lw         $v0, 0x4($a2)
    /* D878 8001D078 00000000 */  nop
    /* D87C 8001D07C 09F84000 */  jalr       $v0
    /* D880 8001D080 00000000 */   nop
    /* D884 8001D084 00141200 */  sll        $v0, $s2, 16
    /* D888 8001D088 032C0200 */  sra        $a1, $v0, 16
    /* D88C 8001D08C 80100500 */  sll        $v0, $a1, 2
    /* D890 8001D090 21100202 */  addu       $v0, $s0, $v0
    /* D894 8001D094 1000448C */  lw         $a0, 0x10($v0)
    /* D898 8001D098 00000000 */  nop
    /* D89C 8001D09C 1800828C */  lw         $v0, 0x18($a0)
    /* D8A0 8001D0A0 00000000 */  nop
    /* D8A4 8001D0A4 30004824 */  addiu      $t0, $v0, 0x30
    /* D8A8 8001D0A8 30004384 */  lh         $v1, 0x30($v0)
    /* D8AC 8001D0AC 00141100 */  sll        $v0, $s1, 16
    /* D8B0 8001D0B0 03140200 */  sra        $v0, $v0, 16
    /* D8B4 8001D0B4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D8B8 8001D0B8 21388300 */  addu       $a3, $a0, $v1
    /* D8BC 8001D0BC 00241600 */  sll        $a0, $s6, 16
    /* D8C0 8001D0C0 03240400 */  sra        $a0, $a0, 16
    /* D8C4 8001D0C4 21208402 */  addu       $a0, $s4, $a0
    /* D8C8 8001D0C8 40180200 */  sll        $v1, $v0, 1
    /* D8CC 8001D0CC 21186200 */  addu       $v1, $v1, $v0
    /* D8D0 8001D0D0 C0180300 */  sll        $v1, $v1, 3
    /* D8D4 8001D0D4 6E000286 */  lh         $v0, 0x6E($s0)
    /* D8D8 8001D0D8 21208300 */  addu       $a0, $a0, $v1
    /* D8DC 8001D0DC 21204400 */  addu       $a0, $v0, $a0
    /* D8E0 8001D0E0 07004014 */  bnez       $v0, .L8001D100
    /* D8E4 8001D0E4 05008624 */   addiu     $a2, $a0, 0x5
    /* D8E8 8001D0E8 0800028E */  lw         $v0, 0x8($s0)
    /* D8EC 8001D0EC 00000000 */  nop
    /* D8F0 8001D0F0 2610A200 */  xor        $v0, $a1, $v0
    /* D8F4 8001D0F4 0100422C */  sltiu      $v0, $v0, 0x1
    /* D8F8 8001D0F8 41740008 */  j          .L8001D104
    /* D8FC 8001D0FC 1000A2AF */   sw        $v0, 0x10($sp)
  .L8001D100:
    /* D900 8001D100 1000A0AF */  sw         $zero, 0x10($sp)
  .L8001D104:
    /* D904 8001D104 2120E000 */  addu       $a0, $a3, $zero
    /* D908 8001D108 2128A002 */  addu       $a1, $s5, $zero
    /* D90C 8001D10C 0400028D */  lw         $v0, 0x4($t0)
    /* D910 8001D110 00000000 */  nop
    /* D914 8001D114 09F84000 */  jalr       $v0
    /* D918 8001D118 21386002 */   addu      $a3, $s3, $zero
  .L8001D11C:
    /* D91C 8001D11C 01002226 */  addiu      $v0, $s1, 0x1
  .L8001D120:
    /* D920 8001D120 21884000 */  addu       $s1, $v0, $zero
    /* D924 8001D124 00140200 */  sll        $v0, $v0, 16
    /* D928 8001D128 03140200 */  sra        $v0, $v0, 16
    /* D92C 8001D12C 05004228 */  slti       $v0, $v0, 0x5
    /* D930 8001D130 AAFF4014 */  bnez       $v0, .L8001CFDC
    /* D934 8001D134 00000000 */   nop
  .L8001D138:
    /* D938 8001D138 3400BF8F */  lw         $ra, 0x34($sp)
    /* D93C 8001D13C 3000B68F */  lw         $s6, 0x30($sp)
    /* D940 8001D140 2C00B58F */  lw         $s5, 0x2C($sp)
    /* D944 8001D144 2800B48F */  lw         $s4, 0x28($sp)
    /* D948 8001D148 2400B38F */  lw         $s3, 0x24($sp)
    /* D94C 8001D14C 2000B28F */  lw         $s2, 0x20($sp)
    /* D950 8001D150 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D954 8001D154 1800B08F */  lw         $s0, 0x18($sp)
    /* D958 8001D158 0800E003 */  jr         $ra
    /* D95C 8001D15C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Draw__14tInsideBoxMenusssss
