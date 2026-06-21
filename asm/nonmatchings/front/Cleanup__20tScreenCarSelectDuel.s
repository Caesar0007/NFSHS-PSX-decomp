.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__20tScreenCarSelectDuel, 0x30

glabel Cleanup__20tScreenCarSelectDuel
    /* 2DB34 8003D334 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2DB38 8003D338 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2DB3C 8003D33C 21808000 */  addu       $s0, $a0, $zero
    /* 2DB40 8003D340 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2DB44 8003D344 2599000C */  jal        FreeShapes__7tScreenR17tShapeInformation
    /* 2DB48 8003D348 A8030526 */   addiu     $a1, $s0, 0x3A8
    /* 2DB4C 8003D34C 2EEB000C */  jal        Cleanup__16tScreenCarSelect
    /* 2DB50 8003D350 21200002 */   addu      $a0, $s0, $zero
    /* 2DB54 8003D354 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2DB58 8003D358 1000B08F */  lw         $s0, 0x10($sp)
    /* 2DB5C 8003D35C 0800E003 */  jr         $ra
    /* 2DB60 8003D360 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__20tScreenCarSelectDuel
