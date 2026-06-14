.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIHigh_Execute__Fv, 0x108

glabel AIHigh_Execute__Fv
    /* 4BA10 8005B210 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 4BA14 8005B214 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 4BA18 8005B218 21980000 */  addu       $s3, $zero, $zero
    /* 4BA1C 8005B21C 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 4BA20 8005B220 2000B0AF */  sw         $s0, 0x20($sp)
    /* 4BA24 8005B224 38CD5024 */  addiu      $s0, $v0, %lo(highLevelAIObjs)
    /* 4BA28 8005B228 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 4BA2C 8005B22C 2800B2AF */  sw         $s2, 0x28($sp)
    /* 4BA30 8005B230 DCF95224 */  addiu      $s2, $v0, %lo(Cars_gList)
    /* 4BA34 8005B234 3000BFAF */  sw         $ra, 0x30($sp)
    /* 4BA38 8005B238 2400B1AF */  sw         $s1, 0x24($sp)
  .L8005B23C:
    /* 4BA3C 8005B23C 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 4BA40 8005B240 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 4BA44 8005B244 00000000 */  nop
    /* 4BA48 8005B248 2A106202 */  slt        $v0, $s3, $v0
    /* 4BA4C 8005B24C 2B004010 */  beqz       $v0, .L8005B2FC
    /* 4BA50 8005B250 00000000 */   nop
    /* 4BA54 8005B254 0000028E */  lw         $v0, 0x0($s0)
    /* 4BA58 8005B258 0000478E */  lw         $a3, 0x0($s2)
    /* 4BA5C 8005B25C 23004010 */  beqz       $v0, .L8005B2EC
    /* 4BA60 8005B260 00000000 */   nop
    /* 4BA64 8005B264 0C00428C */  lw         $v0, 0xC($v0)
    /* 4BA68 8005B268 00000000 */  nop
    /* 4BA6C 8005B26C 13004014 */  bnez       $v0, .L8005B2BC
    /* 4BA70 8005B270 21880000 */   addu      $s1, $zero, $zero
    /* 4BA74 8005B274 1480023C */  lui        $v0, %hi(AI_time)
    /* 4BA78 8005B278 50C54224 */  addiu      $v0, $v0, %lo(AI_time)
    /* 4BA7C 8005B27C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 4BA80 8005B280 1480023C */  lui        $v0, %hi(AI_elapsedTime)
    /* 4BA84 8005B284 54C54224 */  addiu      $v0, $v0, %lo(AI_elapsedTime)
    /* 4BA88 8005B288 1400A2AF */  sw         $v0, 0x14($sp)
    /* 4BA8C 8005B28C 1480023C */  lui        $v0, %hi(AI_iTime)
    /* 4BA90 8005B290 58C54224 */  addiu      $v0, $v0, %lo(AI_iTime)
    /* 4BA94 8005B294 1800A2AF */  sw         $v0, 0x18($sp)
    /* 4BA98 8005B298 5C07E28C */  lw         $v0, 0x75C($a3)
    /* 4BA9C 8005B29C 01000424 */  addiu      $a0, $zero, 0x1
    /* 4BAA0 8005B2A0 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 4BAA4 8005B2A4 8C00E68C */  lw         $a2, 0x8C($a3)
    /* 4BAA8 8005B2A8 0000E78C */  lw         $a3, 0x0($a3)
    /* 4BAAC 8005B2AC 6FD8020C */  jal        Sched_ExecuteCheck__FiiiiPiN24i
    /* 4BAB0 8005B2B0 21282002 */   addu      $a1, $s1, $zero
    /* 4BAB4 8005B2B4 02004010 */  beqz       $v0, .L8005B2C0
    /* 4BAB8 8005B2B8 00000000 */   nop
  .L8005B2BC:
    /* 4BABC 8005B2BC 01001124 */  addiu      $s1, $zero, 0x1
  .L8005B2C0:
    /* 4BAC0 8005B2C0 0A002012 */  beqz       $s1, .L8005B2EC
    /* 4BAC4 8005B2C4 00000000 */   nop
    /* 4BAC8 8005B2C8 0000038E */  lw         $v1, 0x0($s0)
    /* 4BACC 8005B2CC 00000000 */  nop
    /* 4BAD0 8005B2D0 1400628C */  lw         $v0, 0x14($v1)
    /* 4BAD4 8005B2D4 00000000 */  nop
    /* 4BAD8 8005B2D8 08004484 */  lh         $a0, 0x8($v0)
    /* 4BADC 8005B2DC 0C00428C */  lw         $v0, 0xC($v0)
    /* 4BAE0 8005B2E0 00000000 */  nop
    /* 4BAE4 8005B2E4 09F84000 */  jalr       $v0
    /* 4BAE8 8005B2E8 21206400 */   addu      $a0, $v1, $a0
  .L8005B2EC:
    /* 4BAEC 8005B2EC 04001026 */  addiu      $s0, $s0, 0x4
    /* 4BAF0 8005B2F0 04005226 */  addiu      $s2, $s2, 0x4
    /* 4BAF4 8005B2F4 8F6C0108 */  j          .L8005B23C
    /* 4BAF8 8005B2F8 01007326 */   addiu     $s3, $s3, 0x1
  .L8005B2FC:
    /* 4BAFC 8005B2FC 3000BF8F */  lw         $ra, 0x30($sp)
    /* 4BB00 8005B300 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 4BB04 8005B304 2800B28F */  lw         $s2, 0x28($sp)
    /* 4BB08 8005B308 2400B18F */  lw         $s1, 0x24($sp)
    /* 4BB0C 8005B30C 2000B08F */  lw         $s0, 0x20($sp)
    /* 4BB10 8005B310 0800E003 */  jr         $ra
    /* 4BB14 8005B314 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel AIHigh_Execute__Fv
