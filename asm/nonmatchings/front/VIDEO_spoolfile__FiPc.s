.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VIDEO_spoolfile__FiPc, 0x5C

glabel VIDEO_spoolfile__FiPc
    /* 41698 80050E98 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4169C 80050E9C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 416A0 80050EA0 21808000 */  addu       $s0, $a0, $zero
    /* 416A4 80050EA4 4457033C */  lui        $v1, (0x57444956 >> 16)
    /* 416A8 80050EA8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 416AC 80050EAC 0000028E */  lw         $v0, 0x0($s0)
    /* 416B0 80050EB0 56496334 */  ori        $v1, $v1, (0x57444956 & 0xFFFF)
    /* 416B4 80050EB4 0B004314 */  bne        $v0, $v1, .L80050EE4
    /* 416B8 80050EB8 00000000 */   nop
    /* 416BC 80050EBC 1C00028E */  lw         $v0, 0x1C($s0)
    /* 416C0 80050EC0 00000000 */  nop
    /* 416C4 80050EC4 07004014 */  bnez       $v0, .L80050EE4
    /* 416C8 80050EC8 21300000 */   addu      $a2, $zero, $zero
    /* 416CC 80050ECC 1800048E */  lw         $a0, 0x18($s0)
    /* 416D0 80050ED0 C5F4030C */  jal        STREAM_queuefile
    /* 416D4 80050ED4 2138C000 */   addu      $a3, $a2, $zero
    /* 416D8 80050ED8 200002AE */  sw         $v0, 0x20($s0)
    /* 416DC 80050EDC 01000224 */  addiu      $v0, $zero, 0x1
    /* 416E0 80050EE0 1C0002AE */  sw         $v0, 0x1C($s0)
  .L80050EE4:
    /* 416E4 80050EE4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 416E8 80050EE8 1000B08F */  lw         $s0, 0x10($sp)
    /* 416EC 80050EEC 0800E003 */  jr         $ra
    /* 416F0 80050EF0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel VIDEO_spoolfile__FiPc
