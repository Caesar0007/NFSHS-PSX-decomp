.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching s_upper__FPc, 0x60

glabel s_upper__FPc
    /* 170F0 800268F0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 170F4 800268F4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 170F8 800268F8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 170FC 800268FC DDA7030C */  jal        strlen
    /* 17100 80026900 21808000 */   addu      $s0, $a0, $zero
    /* 17104 80026904 21304000 */  addu       $a2, $v0, $zero
    /* 17108 80026908 0D00C018 */  blez       $a2, .L80026940
    /* 1710C 8002690C 21200000 */   addu      $a0, $zero, $zero
    /* 17110 80026910 21280402 */  addu       $a1, $s0, $a0
  .L80026914:
    /* 17114 80026914 0000A390 */  lbu        $v1, 0x0($a1)
    /* 17118 80026918 00000000 */  nop
    /* 1711C 8002691C 9FFF6224 */  addiu      $v0, $v1, -0x61
    /* 17120 80026920 1A00422C */  sltiu      $v0, $v0, 0x1A
    /* 17124 80026924 02004010 */  beqz       $v0, .L80026930
    /* 17128 80026928 E0006224 */   addiu     $v0, $v1, 0xE0
    /* 1712C 8002692C 0000A2A0 */  sb         $v0, 0x0($a1)
  .L80026930:
    /* 17130 80026930 01008424 */  addiu      $a0, $a0, 0x1
    /* 17134 80026934 2A108600 */  slt        $v0, $a0, $a2
    /* 17138 80026938 F6FF4014 */  bnez       $v0, .L80026914
    /* 1713C 8002693C 21280402 */   addu      $a1, $s0, $a0
  .L80026940:
    /* 17140 80026940 1400BF8F */  lw         $ra, 0x14($sp)
    /* 17144 80026944 1000B08F */  lw         $s0, 0x10($sp)
    /* 17148 80026948 0800E003 */  jr         $ra
    /* 1714C 8002694C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel s_upper__FPc
