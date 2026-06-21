.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VIDEO_abortplayback__Fi, 0x44

glabel VIDEO_abortplayback__Fi
    /* 41754 80050F54 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 41758 80050F58 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4175C 80050F5C 21808000 */  addu       $s0, $a0, $zero
    /* 41760 80050F60 4457033C */  lui        $v1, (0x57444956 >> 16)
    /* 41764 80050F64 1400BFAF */  sw         $ra, 0x14($sp)
    /* 41768 80050F68 0000028E */  lw         $v0, 0x0($s0)
    /* 4176C 80050F6C 56496334 */  ori        $v1, $v1, (0x57444956 & 0xFFFF)
    /* 41770 80050F70 05004314 */  bne        $v0, $v1, .L80050F88
    /* 41774 80050F74 00000000 */   nop
    /* 41778 80050F78 1800048E */  lw         $a0, 0x18($s0)
    /* 4177C 80050F7C 02F6030C */  jal        STREAM_kill
    /* 41780 80050F80 00000000 */   nop
    /* 41784 80050F84 1C0000AE */  sw         $zero, 0x1C($s0)
  .L80050F88:
    /* 41788 80050F88 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4178C 80050F8C 1000B08F */  lw         $s0, 0x10($sp)
    /* 41790 80050F90 0800E003 */  jr         $ra
    /* 41794 80050F94 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel VIDEO_abortplayback__Fi
