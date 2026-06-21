.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__12tOptionsMenu, 0x2B0

glabel UpdateTransition__12tOptionsMenu
    /* D054 8001C854 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D058 8001C858 1400B1AF */  sw         $s1, 0x14($sp)
    /* D05C 8001C85C 21888000 */  addu       $s1, $a0, $zero
    /* D060 8001C860 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D064 8001C864 1800B2AF */  sw         $s2, 0x18($sp)
    /* D068 8001C868 1000B0AF */  sw         $s0, 0x10($sp)
    /* D06C 8001C86C 6C00228E */  lw         $v0, 0x6C($s1)
    /* D070 8001C870 00000000 */  nop
    /* D074 8001C874 74004010 */  beqz       $v0, .L8001CA48
    /* D078 8001C878 00000000 */   nop
    /* D07C 8001C87C 70002382 */  lb         $v1, 0x70($s1)
    /* D080 8001C880 00000000 */  nop
    /* D084 8001C884 2B006104 */  bgez       $v1, .L8001C934
    /* D088 8001C888 00000000 */   nop
    /* D08C 8001C88C 7400228E */  lw         $v0, 0x74($s1)
    /* D090 8001C890 00000000 */  nop
    /* D094 8001C894 05004018 */  blez       $v0, .L8001C8AC
    /* D098 8001C898 21104300 */   addu      $v0, $v0, $v1
    /* D09C 8001C89C 8C004104 */  bgez       $v0, .L8001CAD0
    /* D0A0 8001C8A0 740022AE */   sw        $v0, 0x74($s1)
    /* D0A4 8001C8A4 B4720008 */  j          .L8001CAD0
    /* D0A8 8001C8A8 740020AE */   sw        $zero, 0x74($s1)
  .L8001C8AC:
    /* D0AC 8001C8AC 1000228E */  lw         $v0, 0x10($s1)
    /* D0B0 8001C8B0 00000000 */  nop
    /* D0B4 8001C8B4 86004010 */  beqz       $v0, .L8001CAD0
    /* D0B8 8001C8B8 21800000 */   addu      $s0, $zero, $zero
  .L8001C8BC:
    /* D0BC 8001C8BC 00141000 */  sll        $v0, $s0, 16
    /* D0C0 8001C8C0 83130200 */  sra        $v0, $v0, 14
    /* D0C4 8001C8C4 21102202 */  addu       $v0, $s1, $v0
    /* D0C8 8001C8C8 1000438C */  lw         $v1, 0x10($v0)
    /* D0CC 8001C8CC 00000000 */  nop
    /* D0D0 8001C8D0 1800628C */  lw         $v0, 0x18($v1)
    /* D0D4 8001C8D4 00000000 */  nop
    /* D0D8 8001C8D8 48004484 */  lh         $a0, 0x48($v0)
    /* D0DC 8001C8DC 4C00428C */  lw         $v0, 0x4C($v0)
    /* D0E0 8001C8E0 00000000 */  nop
    /* D0E4 8001C8E4 09F84000 */  jalr       $v0
    /* D0E8 8001C8E8 21206400 */   addu      $a0, $v1, $a0
    /* D0EC 8001C8EC 08004010 */  beqz       $v0, .L8001C910
    /* D0F0 8001C8F0 01000226 */   addiu     $v0, $s0, 0x1
    /* D0F4 8001C8F4 001C0200 */  sll        $v1, $v0, 16
    /* D0F8 8001C8F8 831B0300 */  sra        $v1, $v1, 14
    /* D0FC 8001C8FC 21182302 */  addu       $v1, $s1, $v1
    /* D100 8001C900 1000638C */  lw         $v1, 0x10($v1)
    /* D104 8001C904 00000000 */  nop
    /* D108 8001C908 ECFF6014 */  bnez       $v1, .L8001C8BC
    /* D10C 8001C90C 21804000 */   addu      $s0, $v0, $zero
  .L8001C910:
    /* D110 8001C910 00141000 */  sll        $v0, $s0, 16
    /* D114 8001C914 83130200 */  sra        $v0, $v0, 14
    /* D118 8001C918 21102202 */  addu       $v0, $s1, $v0
    /* D11C 8001C91C 1000438C */  lw         $v1, 0x10($v0)
    /* D120 8001C920 00000000 */  nop
    /* D124 8001C924 6A006010 */  beqz       $v1, .L8001CAD0
    /* D128 8001C928 00000000 */   nop
    /* D12C 8001C92C 7A720008 */  j          .L8001C9E8
    /* D130 8001C930 00000000 */   nop
  .L8001C934:
    /* D134 8001C934 1000228E */  lw         $v0, 0x10($s1)
    /* D138 8001C938 00000000 */  nop
    /* D13C 8001C93C 09004010 */  beqz       $v0, .L8001C964
    /* D140 8001C940 21800000 */   addu      $s0, $zero, $zero
  .L8001C944:
    /* D144 8001C944 01000226 */  addiu      $v0, $s0, 0x1
    /* D148 8001C948 001C0200 */  sll        $v1, $v0, 16
    /* D14C 8001C94C 831B0300 */  sra        $v1, $v1, 14
    /* D150 8001C950 21182302 */  addu       $v1, $s1, $v1
    /* D154 8001C954 1000638C */  lw         $v1, 0x10($v1)
    /* D158 8001C958 00000000 */  nop
    /* D15C 8001C95C F9FF6014 */  bnez       $v1, .L8001C944
    /* D160 8001C960 21804000 */   addu      $s0, $v0, $zero
  .L8001C964:
    /* D164 8001C964 FFFF0226 */  addiu      $v0, $s0, -0x1
    /* D168 8001C968 21804000 */  addu       $s0, $v0, $zero
    /* D16C 8001C96C 00140200 */  sll        $v0, $v0, 16
    /* D170 8001C970 03140200 */  sra        $v0, $v0, 16
    /* D174 8001C974 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* D178 8001C978 25004310 */  beq        $v0, $v1, .L8001CA10
    /* D17C 8001C97C 21906000 */   addu      $s2, $v1, $zero
    /* D180 8001C980 00141000 */  sll        $v0, $s0, 16
  .L8001C984:
    /* D184 8001C984 83130200 */  sra        $v0, $v0, 14
    /* D188 8001C988 21102202 */  addu       $v0, $s1, $v0
    /* D18C 8001C98C 1000438C */  lw         $v1, 0x10($v0)
    /* D190 8001C990 00000000 */  nop
    /* D194 8001C994 1800628C */  lw         $v0, 0x18($v1)
    /* D198 8001C998 00000000 */  nop
    /* D19C 8001C99C 48004484 */  lh         $a0, 0x48($v0)
    /* D1A0 8001C9A0 4C00428C */  lw         $v0, 0x4C($v0)
    /* D1A4 8001C9A4 00000000 */  nop
    /* D1A8 8001C9A8 09F84000 */  jalr       $v0
    /* D1AC 8001C9AC 21206400 */   addu      $a0, $v1, $a0
    /* D1B0 8001C9B0 06004010 */  beqz       $v0, .L8001C9CC
    /* D1B4 8001C9B4 FFFF0226 */   addiu     $v0, $s0, -0x1
    /* D1B8 8001C9B8 21804000 */  addu       $s0, $v0, $zero
    /* D1BC 8001C9BC 00140200 */  sll        $v0, $v0, 16
    /* D1C0 8001C9C0 03140200 */  sra        $v0, $v0, 16
    /* D1C4 8001C9C4 EFFF5214 */  bne        $v0, $s2, .L8001C984
    /* D1C8 8001C9C8 00141000 */   sll       $v0, $s0, 16
  .L8001C9CC:
    /* D1CC 8001C9CC 00141000 */  sll        $v0, $s0, 16
    /* D1D0 8001C9D0 031C0200 */  sra        $v1, $v0, 16
    /* D1D4 8001C9D4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* D1D8 8001C9D8 0D006210 */  beq        $v1, $v0, .L8001CA10
    /* D1DC 8001C9DC 80100300 */   sll       $v0, $v1, 2
    /* D1E0 8001C9E0 21102202 */  addu       $v0, $s1, $v0
    /* D1E4 8001C9E4 1000438C */  lw         $v1, 0x10($v0)
  .L8001C9E8:
    /* D1E8 8001C9E8 00000000 */  nop
    /* D1EC 8001C9EC 1800628C */  lw         $v0, 0x18($v1)
    /* D1F0 8001C9F0 21280000 */  addu       $a1, $zero, $zero
    /* D1F4 8001C9F4 50004484 */  lh         $a0, 0x50($v0)
    /* D1F8 8001C9F8 5400428C */  lw         $v0, 0x54($v0)
    /* D1FC 8001C9FC 00000000 */  nop
    /* D200 8001CA00 09F84000 */  jalr       $v0
    /* D204 8001CA04 21206400 */   addu      $a0, $v1, $a0
    /* D208 8001CA08 B4720008 */  j          .L8001CAD0
    /* D20C 8001CA0C 00000000 */   nop
  .L8001CA10:
    /* D210 8001CA10 7400238E */  lw         $v1, 0x74($s1)
    /* D214 8001CA14 00000000 */  nop
    /* D218 8001CA18 28026228 */  slti       $v0, $v1, 0x228
    /* D21C 8001CA1C 2C004010 */  beqz       $v0, .L8001CAD0
    /* D220 8001CA20 00000000 */   nop
    /* D224 8001CA24 70002282 */  lb         $v0, 0x70($s1)
    /* D228 8001CA28 00000000 */  nop
    /* D22C 8001CA2C 21106200 */  addu       $v0, $v1, $v0
    /* D230 8001CA30 740022AE */  sw         $v0, 0x74($s1)
    /* D234 8001CA34 29024228 */  slti       $v0, $v0, 0x229
    /* D238 8001CA38 25004014 */  bnez       $v0, .L8001CAD0
    /* D23C 8001CA3C 28020224 */   addiu     $v0, $zero, 0x228
    /* D240 8001CA40 B4720008 */  j          .L8001CAD0
    /* D244 8001CA44 740022AE */   sw        $v0, 0x74($s1)
  .L8001CA48:
    /* D248 8001CA48 1000228E */  lw         $v0, 0x10($s1)
    /* D24C 8001CA4C 00000000 */  nop
    /* D250 8001CA50 1F004010 */  beqz       $v0, .L8001CAD0
    /* D254 8001CA54 21800000 */   addu      $s0, $zero, $zero
  .L8001CA58:
    /* D258 8001CA58 00141000 */  sll        $v0, $s0, 16
    /* D25C 8001CA5C 03340200 */  sra        $a2, $v0, 16
    /* D260 8001CA60 80100600 */  sll        $v0, $a2, 2
    /* D264 8001CA64 21102202 */  addu       $v0, $s1, $v0
    /* D268 8001CA68 1000448C */  lw         $a0, 0x10($v0)
    /* D26C 8001CA6C 00000000 */  nop
    /* D270 8001CA70 1800828C */  lw         $v0, 0x18($a0)
    /* D274 8001CA74 21280000 */  addu       $a1, $zero, $zero
    /* D278 8001CA78 50004724 */  addiu      $a3, $v0, 0x50
    /* D27C 8001CA7C 50004284 */  lh         $v0, 0x50($v0)
    /* D280 8001CA80 6C00238E */  lw         $v1, 0x6C($s1)
    /* D284 8001CA84 00000000 */  nop
    /* D288 8001CA88 05006014 */  bnez       $v1, .L8001CAA0
    /* D28C 8001CA8C 21208200 */   addu      $a0, $a0, $v0
    /* D290 8001CA90 0800228E */  lw         $v0, 0x8($s1)
    /* D294 8001CA94 00000000 */  nop
    /* D298 8001CA98 2610C200 */  xor        $v0, $a2, $v0
    /* D29C 8001CA9C 0100452C */  sltiu      $a1, $v0, 0x1
  .L8001CAA0:
    /* D2A0 8001CAA0 0400E28C */  lw         $v0, 0x4($a3)
    /* D2A4 8001CAA4 00000000 */  nop
    /* D2A8 8001CAA8 09F84000 */  jalr       $v0
    /* D2AC 8001CAAC 00000000 */   nop
    /* D2B0 8001CAB0 01000326 */  addiu      $v1, $s0, 0x1
    /* D2B4 8001CAB4 00140300 */  sll        $v0, $v1, 16
    /* D2B8 8001CAB8 83130200 */  sra        $v0, $v0, 14
    /* D2BC 8001CABC 21102202 */  addu       $v0, $s1, $v0
    /* D2C0 8001CAC0 1000428C */  lw         $v0, 0x10($v0)
    /* D2C4 8001CAC4 00000000 */  nop
    /* D2C8 8001CAC8 E3FF4014 */  bnez       $v0, .L8001CA58
    /* D2CC 8001CACC 21806000 */   addu      $s0, $v1, $zero
  .L8001CAD0:
    /* D2D0 8001CAD0 6800228E */  lw         $v0, 0x68($s1)
    /* D2D4 8001CAD4 00000000 */  nop
    /* D2D8 8001CAD8 38004484 */  lh         $a0, 0x38($v0)
    /* D2DC 8001CADC 3C00428C */  lw         $v0, 0x3C($v0)
    /* D2E0 8001CAE0 00000000 */  nop
    /* D2E4 8001CAE4 09F84000 */  jalr       $v0
    /* D2E8 8001CAE8 21202402 */   addu      $a0, $s1, $a0
    /* D2EC 8001CAEC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D2F0 8001CAF0 1800B28F */  lw         $s2, 0x18($sp)
    /* D2F4 8001CAF4 1400B18F */  lw         $s1, 0x14($sp)
    /* D2F8 8001CAF8 1000B08F */  lw         $s0, 0x10($sp)
    /* D2FC 8001CAFC 0800E003 */  jr         $ra
    /* D300 8001CB00 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateTransition__12tOptionsMenu
