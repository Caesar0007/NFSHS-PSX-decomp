.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VIDEO_destroy__Fi, 0x58

glabel VIDEO_destroy__Fi
    /* 41640 80050E40 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 41644 80050E44 1000B0AF */  sw         $s0, 0x10($sp)
    /* 41648 80050E48 21808000 */  addu       $s0, $a0, $zero
    /* 4164C 80050E4C 4457033C */  lui        $v1, (0x57444956 >> 16)
    /* 41650 80050E50 1400BFAF */  sw         $ra, 0x14($sp)
    /* 41654 80050E54 0000028E */  lw         $v0, 0x0($s0)
    /* 41658 80050E58 56496334 */  ori        $v1, $v1, (0x57444956 & 0xFFFF)
    /* 4165C 80050E5C 0A004314 */  bne        $v0, $v1, .L80050E88
    /* 41660 80050E60 00000000 */   nop
    /* 41664 80050E64 1000048E */  lw         $a0, 0x10($s0)
    /* 41668 80050E68 9542010C */  jal        restoremdec
    /* 4166C 80050E6C 000000AE */   sw        $zero, 0x0($s0)
    /* 41670 80050E70 1800048E */  lw         $a0, 0x18($s0)
    /* 41674 80050E74 51F4030C */  jal        STREAM_destroy
    /* 41678 80050E78 00000000 */   nop
    /* 4167C 80050E7C 0C00048E */  lw         $a0, 0xC($s0)
    /* 41680 80050E80 5095030C */  jal        purgememadr
    /* 41684 80050E84 00000000 */   nop
  .L80050E88:
    /* 41688 80050E88 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4168C 80050E8C 1000B08F */  lw         $s0, 0x10($sp)
    /* 41690 80050E90 0800E003 */  jr         $ra
    /* 41694 80050E94 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel VIDEO_destroy__Fi
