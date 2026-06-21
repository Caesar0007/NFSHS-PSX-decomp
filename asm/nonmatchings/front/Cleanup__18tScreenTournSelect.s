.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__18tScreenTournSelect, 0x40

glabel Cleanup__18tScreenTournSelect
    /* 302E8 8003FAE8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 302EC 8003FAEC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 302F0 8003FAF0 21808000 */  addu       $s0, $a0, $zero
    /* 302F4 8003FAF4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 302F8 8003FAF8 6400048E */  lw         $a0, 0x64($s0)
    /* 302FC 8003FAFC 9043010C */  jal        VIDEO_destroy__Fi
    /* 30300 8003FB00 00000000 */   nop
    /* 30304 8003FB04 6400048E */  lw         $a0, 0x64($s0)
    /* 30308 8003FB08 5095030C */  jal        purgememadr
    /* 3030C 8003FB0C 00000000 */   nop
    /* 30310 8003FB10 6898000C */  jal        Cleanup__7tScreen
    /* 30314 8003FB14 21200002 */   addu      $a0, $s0, $zero
    /* 30318 8003FB18 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3031C 8003FB1C 1000B08F */  lw         $s0, 0x10($sp)
    /* 30320 8003FB20 0800E003 */  jr         $ra
    /* 30324 8003FB24 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__18tScreenTournSelect
