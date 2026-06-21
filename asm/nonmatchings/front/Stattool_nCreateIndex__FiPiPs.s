.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stattool_nCreateIndex__FiPiPs, 0x134

glabel Stattool_nCreateIndex__FiPiPs
    /* 3B068 8004A868 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 3B06C 8004A86C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3B070 8004A870 21888000 */  addu       $s1, $a0, $zero
    /* 3B074 8004A874 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 3B078 8004A878 2198A000 */  addu       $s3, $a1, $zero
    /* 3B07C 8004A87C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 3B080 8004A880 2190C000 */  addu       $s2, $a2, $zero
    /* 3B084 8004A884 0180043C */  lui        $a0, %hi(D_80012514)
    /* 3B088 8004A888 14258424 */  addiu      $a0, $a0, %lo(D_80012514)
    /* 3B08C 8004A88C 01002526 */  addiu      $a1, $s1, 0x1
    /* 3B090 8004A890 80280500 */  sll        $a1, $a1, 2
    /* 3B094 8004A894 10000624 */  addiu      $a2, $zero, 0x10
    /* 3B098 8004A898 2000BFAF */  sw         $ra, 0x20($sp)
    /* 3B09C 8004A89C CF94030C */  jal        reservememadr
    /* 3B0A0 8004A8A0 1000B0AF */   sw        $s0, 0x10($sp)
    /* 3B0A4 8004A8A4 21800000 */  addu       $s0, $zero, $zero
    /* 3B0A8 8004A8A8 0D00201A */  blez       $s1, .L8004A8E0
    /* 3B0AC 8004A8AC 21204000 */   addu      $a0, $v0, $zero
    /* 3B0B0 8004A8B0 21308000 */  addu       $a2, $a0, $zero
    /* 3B0B4 8004A8B4 21286002 */  addu       $a1, $s3, $zero
    /* 3B0B8 8004A8B8 21184002 */  addu       $v1, $s2, $zero
  .L8004A8BC:
    /* 3B0BC 8004A8BC 000070A4 */  sh         $s0, 0x0($v1)
    /* 3B0C0 8004A8C0 0000A28C */  lw         $v0, 0x0($a1)
    /* 3B0C4 8004A8C4 0400A524 */  addiu      $a1, $a1, 0x4
    /* 3B0C8 8004A8C8 02006324 */  addiu      $v1, $v1, 0x2
    /* 3B0CC 8004A8CC 01001026 */  addiu      $s0, $s0, 0x1
    /* 3B0D0 8004A8D0 0000C2AC */  sw         $v0, 0x0($a2)
    /* 3B0D4 8004A8D4 2A101102 */  slt        $v0, $s0, $s1
    /* 3B0D8 8004A8D8 F8FF4014 */  bnez       $v0, .L8004A8BC
    /* 3B0DC 8004A8DC 0400C624 */   addiu     $a2, $a2, 0x4
  .L8004A8E0:
    /* 3B0E0 8004A8E0 01000224 */  addiu      $v0, $zero, 0x1
    /* 3B0E4 8004A8E4 24002212 */  beq        $s1, $v0, .L8004A978
    /* 3B0E8 8004A8E8 01001024 */   addiu     $s0, $zero, 0x1
    /* 3B0EC 8004A8EC 2A101102 */  slt        $v0, $s0, $s1
    /* 3B0F0 8004A8F0 21004010 */  beqz       $v0, .L8004A978
    /* 3B0F4 8004A8F4 02004A26 */   addiu     $t2, $s2, 0x2
    /* 3B0F8 8004A8F8 04008924 */  addiu      $t1, $a0, 0x4
  .L8004A8FC:
    /* 3B0FC 8004A8FC FFFF0626 */  addiu      $a2, $s0, -0x1
    /* 3B100 8004A900 0000288D */  lw         $t0, 0x0($t1)
    /* 3B104 8004A904 00004B85 */  lh         $t3, 0x0($t2)
    /* 3B108 8004A908 1000C004 */  bltz       $a2, .L8004A94C
    /* 3B10C 8004A90C 40100600 */   sll       $v0, $a2, 1
    /* 3B110 8004A910 21385200 */  addu       $a3, $v0, $s2
    /* 3B114 8004A914 80100600 */  sll        $v0, $a2, 2
    /* 3B118 8004A918 21284400 */  addu       $a1, $v0, $a0
  .L8004A91C:
    /* 3B11C 8004A91C 0000A38C */  lw         $v1, 0x0($a1)
    /* 3B120 8004A920 00000000 */  nop
    /* 3B124 8004A924 2A100301 */  slt        $v0, $t0, $v1
    /* 3B128 8004A928 08004010 */  beqz       $v0, .L8004A94C
    /* 3B12C 8004A92C 00000000 */   nop
    /* 3B130 8004A930 0400A3AC */  sw         $v1, 0x4($a1)
    /* 3B134 8004A934 FCFFA524 */  addiu      $a1, $a1, -0x4
    /* 3B138 8004A938 0000E294 */  lhu        $v0, 0x0($a3)
    /* 3B13C 8004A93C FFFFC624 */  addiu      $a2, $a2, -0x1
    /* 3B140 8004A940 0200E2A4 */  sh         $v0, 0x2($a3)
    /* 3B144 8004A944 F5FFC104 */  bgez       $a2, .L8004A91C
    /* 3B148 8004A948 FEFFE724 */   addiu     $a3, $a3, -0x2
  .L8004A94C:
    /* 3B14C 8004A94C 02004A25 */  addiu      $t2, $t2, 0x2
    /* 3B150 8004A950 01001026 */  addiu      $s0, $s0, 0x1
    /* 3B154 8004A954 80100600 */  sll        $v0, $a2, 2
    /* 3B158 8004A958 21104400 */  addu       $v0, $v0, $a0
    /* 3B15C 8004A95C 040048AC */  sw         $t0, 0x4($v0)
    /* 3B160 8004A960 40100600 */  sll        $v0, $a2, 1
    /* 3B164 8004A964 21105200 */  addu       $v0, $v0, $s2
    /* 3B168 8004A968 02004BA4 */  sh         $t3, 0x2($v0)
    /* 3B16C 8004A96C 2A101102 */  slt        $v0, $s0, $s1
    /* 3B170 8004A970 E2FF4014 */  bnez       $v0, .L8004A8FC
    /* 3B174 8004A974 04002925 */   addiu     $t1, $t1, 0x4
  .L8004A978:
    /* 3B178 8004A978 5095030C */  jal        purgememadr
    /* 3B17C 8004A97C 00000000 */   nop
    /* 3B180 8004A980 2000BF8F */  lw         $ra, 0x20($sp)
    /* 3B184 8004A984 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 3B188 8004A988 1800B28F */  lw         $s2, 0x18($sp)
    /* 3B18C 8004A98C 1400B18F */  lw         $s1, 0x14($sp)
    /* 3B190 8004A990 1000B08F */  lw         $s0, 0x10($sp)
    /* 3B194 8004A994 0800E003 */  jr         $ra
    /* 3B198 8004A998 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Stattool_nCreateIndex__FiPiPs
