.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching s_lower__FPc, 0x60

glabel s_lower__FPc
    /* 17150 80026950 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 17154 80026954 1000B0AF */  sw         $s0, 0x10($sp)
    /* 17158 80026958 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1715C 8002695C DDA7030C */  jal        strlen
    /* 17160 80026960 21808000 */   addu      $s0, $a0, $zero
    /* 17164 80026964 21304000 */  addu       $a2, $v0, $zero
    /* 17168 80026968 0D00C018 */  blez       $a2, .L800269A0
    /* 1716C 8002696C 21200000 */   addu      $a0, $zero, $zero
    /* 17170 80026970 21280402 */  addu       $a1, $s0, $a0
  .L80026974:
    /* 17174 80026974 0000A390 */  lbu        $v1, 0x0($a1)
    /* 17178 80026978 00000000 */  nop
    /* 1717C 8002697C BFFF6224 */  addiu      $v0, $v1, -0x41
    /* 17180 80026980 1A00422C */  sltiu      $v0, $v0, 0x1A
    /* 17184 80026984 02004010 */  beqz       $v0, .L80026990
    /* 17188 80026988 20006224 */   addiu     $v0, $v1, 0x20
    /* 1718C 8002698C 0000A2A0 */  sb         $v0, 0x0($a1)
  .L80026990:
    /* 17190 80026990 01008424 */  addiu      $a0, $a0, 0x1
    /* 17194 80026994 2A108600 */  slt        $v0, $a0, $a2
    /* 17198 80026998 F6FF4014 */  bnez       $v0, .L80026974
    /* 1719C 8002699C 21280402 */   addu      $a1, $s0, $a0
  .L800269A0:
    /* 171A0 800269A0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 171A4 800269A4 1000B08F */  lw         $s0, 0x10($sp)
    /* 171A8 800269A8 0800E003 */  jr         $ra
    /* 171AC 800269AC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel s_lower__FPc
