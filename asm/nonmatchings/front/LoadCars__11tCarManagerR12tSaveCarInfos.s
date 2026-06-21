.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadCars__11tCarManagerR12tSaveCarInfos, 0x9C

glabel LoadCars__11tCarManagerR12tSaveCarInfos
    /* 7254 80016A54 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 7258 80016A58 1400B1AF */  sw         $s1, 0x14($sp)
    /* 725C 80016A5C 21888000 */  addu       $s1, $a0, $zero
    /* 7260 80016A60 1800B2AF */  sw         $s2, 0x18($sp)
    /* 7264 80016A64 2190A000 */  addu       $s2, $a1, $zero
    /* 7268 80016A68 1000B0AF */  sw         $s0, 0x10($sp)
    /* 726C 80016A6C 00840600 */  sll        $s0, $a2, 16
    /* 7270 80016A70 03841000 */  sra        $s0, $s0, 16
    /* 7274 80016A74 C0291000 */  sll        $a1, $s0, 7
    /* 7278 80016A78 0800A524 */  addiu      $a1, $a1, 0x8
    /* 727C 80016A7C 21204002 */  addu       $a0, $s2, $zero
    /* 7280 80016A80 21282502 */  addu       $a1, $s1, $a1
    /* 7284 80016A84 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 7288 80016A88 B798030C */  jal        blockmove
    /* 728C 80016A8C 80000624 */   addiu     $a2, $zero, 0x80
    /* 7290 80016A90 11000016 */  bnez       $s0, .L80016AD8
    /* 7294 80016A94 00000000 */   nop
    /* 7298 80016A98 0000228E */  lw         $v0, 0x0($s1)
    /* 729C 80016A9C 00000000 */  nop
    /* 72A0 80016AA0 0D004010 */  beqz       $v0, .L80016AD8
    /* 72A4 80016AA4 21280000 */   addu      $a1, $zero, $zero
    /* 72A8 80016AA8 21204502 */  addu       $a0, $s2, $a1
  .L80016AAC:
    /* 72AC 80016AAC 80008290 */  lbu        $v0, 0x80($a0)
    /* 72B0 80016AB0 21182502 */  addu       $v1, $s1, $a1
    /* 72B4 80016AB4 080262A0 */  sb         $v0, 0x208($v1)
    /* 72B8 80016AB8 B0008290 */  lbu        $v0, 0xB0($a0)
    /* 72BC 80016ABC 00000000 */  nop
    /* 72C0 80016AC0 380262A0 */  sb         $v0, 0x238($v1)
    /* 72C4 80016AC4 0000228E */  lw         $v0, 0x0($s1)
    /* 72C8 80016AC8 0100A524 */  addiu      $a1, $a1, 0x1
    /* 72CC 80016ACC 2B10A200 */  sltu       $v0, $a1, $v0
    /* 72D0 80016AD0 F6FF4014 */  bnez       $v0, .L80016AAC
    /* 72D4 80016AD4 21204502 */   addu      $a0, $s2, $a1
  .L80016AD8:
    /* 72D8 80016AD8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 72DC 80016ADC 1800B28F */  lw         $s2, 0x18($sp)
    /* 72E0 80016AE0 1400B18F */  lw         $s1, 0x14($sp)
    /* 72E4 80016AE4 1000B08F */  lw         $s0, 0x10($sp)
    /* 72E8 80016AE8 0800E003 */  jr         $ra
    /* 72EC 80016AEC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel LoadCars__11tCarManagerR12tSaveCarInfos
