.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching IsFalseArrest__15AIHigh_BTC_Perp, 0x220

glabel IsFalseArrest__15AIHigh_BTC_Perp
    /* 4FF98 8005F798 1480033C */  lui        $v1, %hi(fastRandom)
    /* 4FF9C 8005F79C FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 4FFA0 8005F7A0 1480023C */  lui        $v0, %hi(randSeed)
    /* 4FFA4 8005F7A4 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 4FFA8 8005F7A8 00000000 */  nop
    /* 4FFAC 8005F7AC 18006200 */  mult       $v1, $v0
    /* 4FFB0 8005F7B0 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 4FFB4 8005F7B4 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 4FFB8 8005F7B8 21988000 */  addu       $s3, $a0, $zero
    /* 4FFBC 8005F7BC 3800BFAF */  sw         $ra, 0x38($sp)
    /* 4FFC0 8005F7C0 3400B5AF */  sw         $s5, 0x34($sp)
    /* 4FFC4 8005F7C4 3000B4AF */  sw         $s4, 0x30($sp)
    /* 4FFC8 8005F7C8 2800B2AF */  sw         $s2, 0x28($sp)
    /* 4FFCC 8005F7CC 2400B1AF */  sw         $s1, 0x24($sp)
    /* 4FFD0 8005F7D0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 4FFD4 8005F7D4 12180000 */  mflo       $v1
    /* 4FFD8 8005F7D8 FFFF6230 */  andi       $v0, $v1, 0xFFFF
    /* 4FFDC 8005F7DC 1480013C */  lui        $at, %hi(randtemp)
    /* 4FFE0 8005F7E0 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 4FFE4 8005F7E4 021A0300 */  srl        $v1, $v1, 8
    /* 4FFE8 8005F7E8 FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* 4FFEC 8005F7EC 1480013C */  lui        $at, %hi(fastRandom)
    /* 4FFF0 8005F7F0 FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 4FFF4 8005F7F4 40110300 */  sll        $v0, $v1, 5
    /* 4FFF8 8005F7F8 23104300 */  subu       $v0, $v0, $v1
    /* 4FFFC 8005F7FC 80100200 */  sll        $v0, $v0, 2
    /* 50000 8005F800 21104300 */  addu       $v0, $v0, $v1
    /* 50004 8005F804 0000638E */  lw         $v1, 0x0($s3)
    /* 50008 8005F808 C0100200 */  sll        $v0, $v0, 3
    /* 5000C 8005F80C 6002638C */  lw         $v1, 0x260($v1)
    /* 50010 8005F810 00000000 */  nop
    /* 50014 8005F814 04006330 */  andi       $v1, $v1, 0x4
    /* 50018 8005F818 5D006014 */  bnez       $v1, .L8005F990
    /* 5001C 8005F81C 02140200 */   srl       $v0, $v0, 16
    /* 50020 8005F820 D4034228 */  slti       $v0, $v0, 0x3D4
    /* 50024 8005F824 5B004014 */  bnez       $v0, .L8005F994
    /* 50028 8005F828 21100000 */   addu      $v0, $zero, $zero
    /* 5002C 8005F82C 21A80000 */  addu       $s5, $zero, $zero
    /* 50030 8005F830 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 50034 8005F834 DCF95424 */  addiu      $s4, $v0, %lo(Cars_gList)
  .L8005F838:
    /* 50038 8005F838 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 5003C 8005F83C F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 50040 8005F840 00000000 */  nop
    /* 50044 8005F844 2A10A202 */  slt        $v0, $s5, $v0
    /* 50048 8005F848 52004010 */  beqz       $v0, .L8005F994
    /* 5004C 8005F84C 21100000 */   addu      $v0, $zero, $zero
    /* 50050 8005F850 0000858E */  lw         $a1, 0x0($s4)
    /* 50054 8005F854 00000000 */  nop
    /* 50058 8005F858 6002A28C */  lw         $v0, 0x260($a1)
    /* 5005C 8005F85C 00000000 */  nop
    /* 50060 8005F860 00024230 */  andi       $v0, $v0, 0x200
    /* 50064 8005F864 47004010 */  beqz       $v0, .L8005F984
    /* 50068 8005F868 00000000 */   nop
    /* 5006C 8005F86C 0000628E */  lw         $v0, 0x0($s3)
    /* 50070 8005F870 A000A48C */  lw         $a0, 0xA0($a1)
    /* 50074 8005F874 A000428C */  lw         $v0, 0xA0($v0)
    /* 50078 8005F878 00000000 */  nop
    /* 5007C 8005F87C 23208200 */  subu       $a0, $a0, $v0
    /* 50080 8005F880 1000A4AF */  sw         $a0, 0x10($sp)
    /* 50084 8005F884 0000638E */  lw         $v1, 0x0($s3)
    /* 50088 8005F888 A400A28C */  lw         $v0, 0xA4($a1)
    /* 5008C 8005F88C A400638C */  lw         $v1, 0xA4($v1)
    /* 50090 8005F890 00000000 */  nop
    /* 50094 8005F894 23104300 */  subu       $v0, $v0, $v1
    /* 50098 8005F898 1400A2AF */  sw         $v0, 0x14($sp)
    /* 5009C 8005F89C 0000638E */  lw         $v1, 0x0($s3)
    /* 500A0 8005F8A0 A800A28C */  lw         $v0, 0xA8($a1)
    /* 500A4 8005F8A4 A800638C */  lw         $v1, 0xA8($v1)
    /* 500A8 8005F8A8 00000000 */  nop
    /* 500AC 8005F8AC 23104300 */  subu       $v0, $v0, $v1
    /* 500B0 8005F8B0 1800A2AF */  sw         $v0, 0x18($sp)
    /* 500B4 8005F8B4 0000628E */  lw         $v0, 0x0($s3)
    /* 500B8 8005F8B8 00000000 */  nop
    /* 500BC 8005F8BC F000458C */  lw         $a1, 0xF0($v0)
    /* 500C0 8005F8C0 CA90030C */  jal        fixedmult
    /* 500C4 8005F8C4 00000000 */   nop
    /* 500C8 8005F8C8 0000638E */  lw         $v1, 0x0($s3)
    /* 500CC 8005F8CC 1400A48F */  lw         $a0, 0x14($sp)
    /* 500D0 8005F8D0 F400658C */  lw         $a1, 0xF4($v1)
    /* 500D4 8005F8D4 CA90030C */  jal        fixedmult
    /* 500D8 8005F8D8 21904000 */   addu      $s2, $v0, $zero
    /* 500DC 8005F8DC 0000638E */  lw         $v1, 0x0($s3)
    /* 500E0 8005F8E0 1800A48F */  lw         $a0, 0x18($sp)
    /* 500E4 8005F8E4 F800658C */  lw         $a1, 0xF8($v1)
    /* 500E8 8005F8E8 CA90030C */  jal        fixedmult
    /* 500EC 8005F8EC 21804000 */   addu      $s0, $v0, $zero
    /* 500F0 8005F8F0 21905002 */  addu       $s2, $s2, $s0
    /* 500F4 8005F8F4 0000638E */  lw         $v1, 0x0($s3)
    /* 500F8 8005F8F8 1000A48F */  lw         $a0, 0x10($sp)
    /* 500FC 8005F8FC 0801658C */  lw         $a1, 0x108($v1)
    /* 50100 8005F900 CA90030C */  jal        fixedmult
    /* 50104 8005F904 21904202 */   addu      $s2, $s2, $v0
    /* 50108 8005F908 0000638E */  lw         $v1, 0x0($s3)
    /* 5010C 8005F90C 1400A48F */  lw         $a0, 0x14($sp)
    /* 50110 8005F910 0C01658C */  lw         $a1, 0x10C($v1)
    /* 50114 8005F914 CA90030C */  jal        fixedmult
    /* 50118 8005F918 21884000 */   addu      $s1, $v0, $zero
    /* 5011C 8005F91C 0000638E */  lw         $v1, 0x0($s3)
    /* 50120 8005F920 1800A48F */  lw         $a0, 0x18($sp)
    /* 50124 8005F924 1001658C */  lw         $a1, 0x110($v1)
    /* 50128 8005F928 CA90030C */  jal        fixedmult
    /* 5012C 8005F92C 21804000 */   addu      $s0, $v0, $zero
    /* 50130 8005F930 21883002 */  addu       $s1, $s1, $s0
    /* 50134 8005F934 21882202 */  addu       $s1, $s1, $v0
    /* 50138 8005F938 02004106 */  bgez       $s2, .L8005F944
    /* 5013C 8005F93C 00000000 */   nop
    /* 50140 8005F940 23901200 */  negu       $s2, $s2
  .L8005F944:
    /* 50144 8005F944 0300023C */  lui        $v0, (0x30000 >> 16)
    /* 50148 8005F948 2A105200 */  slt        $v0, $v0, $s2
    /* 5014C 8005F94C 06004014 */  bnez       $v0, .L8005F968
    /* 50150 8005F950 0800023C */   lui       $v0, (0x80000 >> 16)
    /* 50154 8005F954 2A105100 */  slt        $v0, $v0, $s1
    /* 50158 8005F958 03004014 */  bnez       $v0, .L8005F968
    /* 5015C 8005F95C 00000000 */   nop
    /* 50160 8005F960 09002106 */  bgez       $s1, .L8005F988
    /* 50164 8005F964 04009426 */   addiu     $s4, $s4, 0x4
  .L8005F968:
    /* 50168 8005F968 0000648E */  lw         $a0, 0x0($s3)
    /* 5016C 8005F96C 02000524 */  addiu      $a1, $zero, 0x2
    /* 50170 8005F970 80000624 */  addiu      $a2, $zero, 0x80
    /* 50174 8005F974 EAD1010C */  jal        AudioClc_HonkHorn__FP8Car_tObjiii
    /* 50178 8005F978 20000724 */   addiu     $a3, $zero, 0x20
    /* 5017C 8005F97C 657E0108 */  j          .L8005F994
    /* 50180 8005F980 01000224 */   addiu     $v0, $zero, 0x1
  .L8005F984:
    /* 50184 8005F984 04009426 */  addiu      $s4, $s4, 0x4
  .L8005F988:
    /* 50188 8005F988 0E7E0108 */  j          .L8005F838
    /* 5018C 8005F98C 0100B526 */   addiu     $s5, $s5, 0x1
  .L8005F990:
    /* 50190 8005F990 21100000 */  addu       $v0, $zero, $zero
  .L8005F994:
    /* 50194 8005F994 3800BF8F */  lw         $ra, 0x38($sp)
    /* 50198 8005F998 3400B58F */  lw         $s5, 0x34($sp)
    /* 5019C 8005F99C 3000B48F */  lw         $s4, 0x30($sp)
    /* 501A0 8005F9A0 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 501A4 8005F9A4 2800B28F */  lw         $s2, 0x28($sp)
    /* 501A8 8005F9A8 2400B18F */  lw         $s1, 0x24($sp)
    /* 501AC 8005F9AC 2000B08F */  lw         $s0, 0x20($sp)
    /* 501B0 8005F9B0 0800E003 */  jr         $ra
    /* 501B4 8005F9B4 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel IsFalseArrest__15AIHigh_BTC_Perp
