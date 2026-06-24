.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching uppercase__FPc, 0x60

glabel uppercase__FPc
    /* C3244 800D2A44 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C3248 800D2A48 1000B0AF */  sw         $s0, 0x10($sp)
    /* C324C 800D2A4C 1400BFAF */  sw         $ra, 0x14($sp)
    /* C3250 800D2A50 DDA7030C */  jal        strlen
    /* C3254 800D2A54 21808000 */   addu      $s0, $a0, $zero
    /* C3258 800D2A58 21304000 */  addu       $a2, $v0, $zero
    /* C325C 800D2A5C 0D00C018 */  blez       $a2, .L800D2A94
    /* C3260 800D2A60 21200000 */   addu      $a0, $zero, $zero
    /* C3264 800D2A64 21280402 */  addu       $a1, $s0, $a0
  .L800D2A68:
    /* C3268 800D2A68 0000A390 */  lbu        $v1, 0x0($a1)
    /* C326C 800D2A6C 00000000 */  nop
    /* C3270 800D2A70 9FFF6224 */  addiu      $v0, $v1, -0x61
    /* C3274 800D2A74 1A00422C */  sltiu      $v0, $v0, 0x1A
    /* C3278 800D2A78 02004010 */  beqz       $v0, .L800D2A84
    /* C327C 800D2A7C E0006224 */   addiu     $v0, $v1, 0xE0
    /* C3280 800D2A80 0000A2A0 */  sb         $v0, 0x0($a1)
  .L800D2A84:
    /* C3284 800D2A84 01008424 */  addiu      $a0, $a0, 0x1
    /* C3288 800D2A88 2A108600 */  slt        $v0, $a0, $a2
    /* C328C 800D2A8C F6FF4014 */  bnez       $v0, .L800D2A68
    /* C3290 800D2A90 21280402 */   addu      $a1, $s0, $a0
  .L800D2A94:
    /* C3294 800D2A94 1400BF8F */  lw         $ra, 0x14($sp)
    /* C3298 800D2A98 1000B08F */  lw         $s0, 0x10($sp)
    /* C329C 800D2A9C 0800E003 */  jr         $ra
    /* C32A0 800D2AA0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel uppercase__FPc
