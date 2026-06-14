.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __ltdf2, 0xDC

glabel __ltdf2
    /* DC0E4 800EB8E4 21408000 */  addu       $t0, $a0, $zero
    /* DC0E8 800EB8E8 2148A000 */  addu       $t1, $a1, $zero
    /* DC0EC 800EB8EC 03002715 */  bne        $t1, $a3, .L800EB8FC
    /* DC0F0 800EB8F0 FF7F033C */   lui       $v1, (0x7FFFFFFF >> 16)
    /* DC0F4 800EB8F4 30000611 */  beq        $t0, $a2, .L800EB9B8
    /* DC0F8 800EB8F8 21100000 */   addu      $v0, $zero, $zero
  .L800EB8FC:
    /* DC0FC 800EB8FC FFFF6334 */  ori        $v1, $v1, (0x7FFFFFFF & 0xFFFF)
    /* DC100 800EB900 24102301 */  and        $v0, $t1, $v1
    /* DC104 800EB904 08004014 */  bnez       $v0, .L800EB928
    /* DC108 800EB908 0080023C */   lui       $v0, (0x80000000 >> 16)
    /* DC10C 800EB90C 06000015 */  bnez       $t0, .L800EB928
    /* DC110 800EB910 00000000 */   nop
    /* DC114 800EB914 2410E300 */  and        $v0, $a3, $v1
    /* DC118 800EB918 03004014 */  bnez       $v0, .L800EB928
    /* DC11C 800EB91C 0080023C */   lui       $v0, (0x80000000 >> 16)
    /* DC120 800EB920 2400C010 */  beqz       $a2, .L800EB9B4
    /* DC124 800EB924 00000000 */   nop
  .L800EB928:
    /* DC128 800EB928 24182201 */  and        $v1, $t1, $v0
    /* DC12C 800EB92C 2410E200 */  and        $v0, $a3, $v0
    /* DC130 800EB930 05006210 */  beq        $v1, $v0, .L800EB948
    /* DC134 800EB934 03150900 */   sra       $v0, $t1, 20
    /* DC138 800EB938 1F006014 */  bnez       $v1, .L800EB9B8
    /* DC13C 800EB93C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* DC140 800EB940 6EAE0308 */  j          .L800EB9B8
    /* DC144 800EB944 21100000 */   addu      $v0, $zero, $zero
  .L800EB948:
    /* DC148 800EB948 FF074430 */  andi       $a0, $v0, 0x7FF
    /* DC14C 800EB94C 03150700 */  sra        $v0, $a3, 20
    /* DC150 800EB950 FF074330 */  andi       $v1, $v0, 0x7FF
    /* DC154 800EB954 2A108300 */  slt        $v0, $a0, $v1
    /* DC158 800EB958 10004014 */  bnez       $v0, .L800EB99C
    /* DC15C 800EB95C 00000000 */   nop
    /* DC160 800EB960 12008314 */  bne        $a0, $v1, .L800EB9AC
    /* DC164 800EB964 0F00023C */   lui       $v0, (0xFFFFF >> 16)
    /* DC168 800EB968 FFFF4234 */  ori        $v0, $v0, (0xFFFFF & 0xFFFF)
    /* DC16C 800EB96C 24182201 */  and        $v1, $t1, $v0
    /* DC170 800EB970 1000043C */  lui        $a0, (0x100000 >> 16)
    /* DC174 800EB974 25186400 */  or         $v1, $v1, $a0
    /* DC178 800EB978 2410E200 */  and        $v0, $a3, $v0
    /* DC17C 800EB97C 25204400 */  or         $a0, $v0, $a0
    /* DC180 800EB980 2A106400 */  slt        $v0, $v1, $a0
    /* DC184 800EB984 05004014 */  bnez       $v0, .L800EB99C
    /* DC188 800EB988 00000000 */   nop
    /* DC18C 800EB98C 07006414 */  bne        $v1, $a0, .L800EB9AC
    /* DC190 800EB990 2B100601 */   sltu      $v0, $t0, $a2
    /* DC194 800EB994 05004010 */  beqz       $v0, .L800EB9AC
    /* DC198 800EB998 00000000 */   nop
  .L800EB99C:
    /* DC19C 800EB99C 06002005 */  bltz       $t1, .L800EB9B8
    /* DC1A0 800EB9A0 21100000 */   addu      $v0, $zero, $zero
    /* DC1A4 800EB9A4 6EAE0308 */  j          .L800EB9B8
    /* DC1A8 800EB9A8 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800EB9AC:
    /* DC1AC 800EB9AC 02002005 */  bltz       $t1, .L800EB9B8
    /* DC1B0 800EB9B0 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800EB9B4:
    /* DC1B4 800EB9B4 21100000 */  addu       $v0, $zero, $zero
  .L800EB9B8:
    /* DC1B8 800EB9B8 0800E003 */  jr         $ra
    /* DC1BC 800EB9BC 00000000 */   nop
endlabel __ltdf2
    /* DC1C0 800EB9C0 00000000 */  nop
