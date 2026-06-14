.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDatodlrv, 0x1B4

glabel iSNDatodlrv
    /* FB6F4 8010AEF4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* FB6F8 8010AEF8 2400B5AF */  sw         $s5, 0x24($sp)
    /* FB6FC 8010AEFC 21A88000 */  addu       $s5, $a0, $zero
    /* FB700 8010AF00 1400B1AF */  sw         $s1, 0x14($sp)
    /* FB704 8010AF04 2188C000 */  addu       $s1, $a2, $zero
    /* FB708 8010AF08 1800B2AF */  sw         $s2, 0x18($sp)
    /* FB70C 8010AF0C 2190E000 */  addu       $s2, $a3, $zero
    /* FB710 8010AF10 2000B4AF */  sw         $s4, 0x20($sp)
    /* FB714 8010AF14 4000B48F */  lw         $s4, 0x40($sp)
    /* FB718 8010AF18 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* FB71C 8010AF1C 4400B38F */  lw         $s3, 0x44($sp)
    /* FB720 8010AF20 2800BFAF */  sw         $ra, 0x28($sp)
    /* FB724 8010AF24 2532040C */  jal        iSNDlibatodlrv
    /* FB728 8010AF28 1000B0AF */   sw        $s0, 0x10($sp)
    /* FB72C 8010AF2C 07008106 */  bgez       $s4, .L8010AF4C
    /* FB730 8010AF30 00000000 */   nop
    /* FB734 8010AF34 0B006106 */  bgez       $s3, .L8010AF64
    /* FB738 8010AF38 2A109302 */   slt       $v0, $s4, $s3
    /* FB73C 8010AF3C 12004010 */  beqz       $v0, .L8010AF88
    /* FB740 8010AF40 02000524 */   addiu     $a1, $zero, 0x2
    /* FB744 8010AF44 E22B0408 */  j          .L8010AF88
    /* FB748 8010AF48 01000524 */   addiu     $a1, $zero, 0x1
  .L8010AF4C:
    /* FB74C 8010AF4C 05006006 */  bltz       $s3, .L8010AF64
    /* FB750 8010AF50 2A109302 */   slt       $v0, $s4, $s3
    /* FB754 8010AF54 0C004010 */  beqz       $v0, .L8010AF88
    /* FB758 8010AF58 01000524 */   addiu     $a1, $zero, 0x1
    /* FB75C 8010AF5C E22B0408 */  j          .L8010AF88
    /* FB760 8010AF60 02000524 */   addiu     $a1, $zero, 0x2
  .L8010AF64:
    /* FB764 8010AF64 B72B040C */  jal        iSNDabs
    /* FB768 8010AF68 21208002 */   addu      $a0, $s4, $zero
    /* FB76C 8010AF6C 21206002 */  addu       $a0, $s3, $zero
    /* FB770 8010AF70 B72B040C */  jal        iSNDabs
    /* FB774 8010AF74 21804000 */   addu      $s0, $v0, $zero
    /* FB778 8010AF78 2A105000 */  slt        $v0, $v0, $s0
    /* FB77C 8010AF7C 02004010 */  beqz       $v0, .L8010AF88
    /* FB780 8010AF80 03000524 */   addiu     $a1, $zero, 0x3
    /* FB784 8010AF84 04000524 */  addiu      $a1, $zero, 0x4
  .L8010AF88:
    /* FB788 8010AF88 00C0A326 */  addiu      $v1, $s5, -0x4000
    /* FB78C 8010AF8C FF7F0224 */  addiu      $v0, $zero, 0x7FFF
    /* FB790 8010AF90 2B104300 */  sltu       $v0, $v0, $v1
    /* FB794 8010AF94 11004014 */  bnez       $v0, .L8010AFDC
    /* FB798 8010AF98 21300000 */   addu      $a2, $zero, $zero
    /* FB79C 8010AF9C 0000228E */  lw         $v0, 0x0($s1)
    /* FB7A0 8010AFA0 0000438E */  lw         $v1, 0x0($s2)
    /* FB7A4 8010AFA4 00000000 */  nop
    /* FB7A8 8010AFA8 2A104300 */  slt        $v0, $v0, $v1
    /* FB7AC 8010AFAC 02004010 */  beqz       $v0, .L8010AFB8
    /* FB7B0 8010AFB0 04000424 */   addiu     $a0, $zero, 0x4
    /* FB7B4 8010AFB4 03000424 */  addiu      $a0, $zero, 0x3
  .L8010AFB8:
    /* FB7B8 8010AFB8 0300A228 */  slti       $v0, $a1, 0x3
    /* FB7BC 8010AFBC 17004010 */  beqz       $v0, .L8010B01C
    /* FB7C0 8010AFC0 03000224 */   addiu     $v0, $zero, 0x3
    /* FB7C4 8010AFC4 15008214 */  bne        $a0, $v0, .L8010B01C
    /* FB7C8 8010AFC8 02000624 */   addiu     $a2, $zero, 0x2
    /* FB7CC 8010AFCC 1300A614 */  bne        $a1, $a2, .L8010B01C
    /* FB7D0 8010AFD0 00000000 */   nop
    /* FB7D4 8010AFD4 072C0408 */  j          .L8010B01C
    /* FB7D8 8010AFD8 01000624 */   addiu     $a2, $zero, 0x1
  .L8010AFDC:
    /* FB7DC 8010AFDC 0000228E */  lw         $v0, 0x0($s1)
    /* FB7E0 8010AFE0 0000438E */  lw         $v1, 0x0($s2)
    /* FB7E4 8010AFE4 00000000 */  nop
    /* FB7E8 8010AFE8 2A104300 */  slt        $v0, $v0, $v1
    /* FB7EC 8010AFEC 02004010 */  beqz       $v0, .L8010AFF8
    /* FB7F0 8010AFF0 01000424 */   addiu     $a0, $zero, 0x1
    /* FB7F4 8010AFF4 02000424 */  addiu      $a0, $zero, 0x2
  .L8010AFF8:
    /* FB7F8 8010AFF8 0300A228 */  slti       $v0, $a1, 0x3
    /* FB7FC 8010AFFC 07004014 */  bnez       $v0, .L8010B01C
    /* FB800 8010B000 00000000 */   nop
    /* FB804 8010B004 02000624 */  addiu      $a2, $zero, 0x2
    /* FB808 8010B008 04008614 */  bne        $a0, $a2, .L8010B01C
    /* FB80C 8010B00C 03000224 */   addiu     $v0, $zero, 0x3
    /* FB810 8010B010 0200A214 */  bne        $a1, $v0, .L8010B01C
    /* FB814 8010B014 00000000 */   nop
    /* FB818 8010B018 01000624 */  addiu      $a2, $zero, 0x1
  .L8010B01C:
    /* FB81C 8010B01C 05008106 */  bgez       $s4, .L8010B034
    /* FB820 8010B020 00000000 */   nop
    /* FB824 8010B024 0000228E */  lw         $v0, 0x0($s1)
    /* FB828 8010B028 00000000 */  nop
    /* FB82C 8010B02C 23100200 */  negu       $v0, $v0
    /* FB830 8010B030 000022AE */  sw         $v0, 0x0($s1)
  .L8010B034:
    /* FB834 8010B034 06006106 */  bgez       $s3, .L8010B050
    /* FB838 8010B038 01000224 */   addiu     $v0, $zero, 0x1
    /* FB83C 8010B03C 0000428E */  lw         $v0, 0x0($s2)
    /* FB840 8010B040 00000000 */  nop
    /* FB844 8010B044 23100200 */  negu       $v0, $v0
    /* FB848 8010B048 000042AE */  sw         $v0, 0x0($s2)
    /* FB84C 8010B04C 01000224 */  addiu      $v0, $zero, 0x1
  .L8010B050:
    /* FB850 8010B050 0600C214 */  bne        $a2, $v0, .L8010B06C
    /* FB854 8010B054 02000224 */   addiu     $v0, $zero, 0x2
    /* FB858 8010B058 0000228E */  lw         $v0, 0x0($s1)
    /* FB85C 8010B05C 00000000 */  nop
    /* FB860 8010B060 23100200 */  negu       $v0, $v0
    /* FB864 8010B064 212C0408 */  j          .L8010B084
    /* FB868 8010B068 000022AE */   sw        $v0, 0x0($s1)
  .L8010B06C:
    /* FB86C 8010B06C 0500C214 */  bne        $a2, $v0, .L8010B084
    /* FB870 8010B070 00000000 */   nop
    /* FB874 8010B074 0000428E */  lw         $v0, 0x0($s2)
    /* FB878 8010B078 00000000 */  nop
    /* FB87C 8010B07C 23100200 */  negu       $v0, $v0
    /* FB880 8010B080 000042AE */  sw         $v0, 0x0($s2)
  .L8010B084:
    /* FB884 8010B084 2800BF8F */  lw         $ra, 0x28($sp)
    /* FB888 8010B088 2400B58F */  lw         $s5, 0x24($sp)
    /* FB88C 8010B08C 2000B48F */  lw         $s4, 0x20($sp)
    /* FB890 8010B090 1C00B38F */  lw         $s3, 0x1C($sp)
    /* FB894 8010B094 1800B28F */  lw         $s2, 0x18($sp)
    /* FB898 8010B098 1400B18F */  lw         $s1, 0x14($sp)
    /* FB89C 8010B09C 1000B08F */  lw         $s0, 0x10($sp)
    /* FB8A0 8010B0A0 0800E003 */  jr         $ra
    /* FB8A4 8010B0A4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDatodlrv
