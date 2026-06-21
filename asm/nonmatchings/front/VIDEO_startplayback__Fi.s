.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VIDEO_startplayback__Fi, 0x60

glabel VIDEO_startplayback__Fi
    /* 416F4 80050EF4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 416F8 80050EF8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 416FC 80050EFC 21808000 */  addu       $s0, $a0, $zero
    /* 41700 80050F00 4457033C */  lui        $v1, (0x57444956 >> 16)
    /* 41704 80050F04 1400BFAF */  sw         $ra, 0x14($sp)
    /* 41708 80050F08 0000028E */  lw         $v0, 0x0($s0)
    /* 4170C 80050F0C 56496334 */  ori        $v1, $v1, (0x57444956 & 0xFFFF)
    /* 41710 80050F10 0C004314 */  bne        $v0, $v1, .L80050F44
    /* 41714 80050F14 00000000 */   nop
    /* 41718 80050F18 1C00028E */  lw         $v0, 0x1C($s0)
    /* 4171C 80050F1C 00000000 */  nop
    /* 41720 80050F20 08004010 */  beqz       $v0, .L80050F44
    /* 41724 80050F24 00000000 */   nop
    /* 41728 80050F28 1800048E */  lw         $a0, 0x18($s0)
    /* 4172C 80050F2C 38F7030C */  jal        STREAM_bufferusage
    /* 41730 80050F30 00000000 */   nop
    /* 41734 80050F34 214E4228 */  slti       $v0, $v0, 0x4E21
    /* 41738 80050F38 02004014 */  bnez       $v0, .L80050F44
    /* 4173C 80050F3C 03000224 */   addiu     $v0, $zero, 0x3
    /* 41740 80050F40 1C0002AE */  sw         $v0, 0x1C($s0)
  .L80050F44:
    /* 41744 80050F44 1400BF8F */  lw         $ra, 0x14($sp)
    /* 41748 80050F48 1000B08F */  lw         $s0, 0x10($sp)
    /* 4174C 80050F4C 0800E003 */  jr         $ra
    /* 41750 80050F50 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel VIDEO_startplayback__Fi
