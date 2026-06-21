.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__16tScreenPinkSlips, 0x48

glabel Cleanup__16tScreenPinkSlips
    /* 29B20 80039320 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 29B24 80039324 1000B0AF */  sw         $s0, 0x10($sp)
    /* 29B28 80039328 21808000 */  addu       $s0, $a0, $zero
    /* 29B2C 8003932C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 29B30 80039330 6800048E */  lw         $a0, 0x68($s0)
    /* 29B34 80039334 9043010C */  jal        VIDEO_destroy__Fi
    /* 29B38 80039338 00000000 */   nop
    /* 29B3C 8003933C 6800048E */  lw         $a0, 0x68($s0)
    /* 29B40 80039340 5095030C */  jal        purgememadr
    /* 29B44 80039344 00000000 */   nop
    /* 29B48 80039348 21200002 */  addu       $a0, $s0, $zero
    /* 29B4C 8003934C 1180023C */  lui        $v0, %hi(D_80114646)
    /* 29B50 80039350 6898000C */  jal        Cleanup__7tScreen
    /* 29B54 80039354 464640A0 */   sb        $zero, %lo(D_80114646)($v0)
    /* 29B58 80039358 1400BF8F */  lw         $ra, 0x14($sp)
    /* 29B5C 8003935C 1000B08F */  lw         $s0, 0x10($sp)
    /* 29B60 80039360 0800E003 */  jr         $ra
    /* 29B64 80039364 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__16tScreenPinkSlips
