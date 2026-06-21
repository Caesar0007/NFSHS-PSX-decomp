.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TurnOffVideoWall__25tScreenCarSelectTwoPlayer, 0x20

glabel TurnOffVideoWall__25tScreenCarSelectTwoPlayer
    /* 2EC9C 8003E49C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2ECA0 8003E4A0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2ECA4 8003E4A4 9FDB000C */  jal        TurnOffInstant__10tVideoWall
    /* 2ECA8 8003E4A8 04038424 */   addiu     $a0, $a0, 0x304
    /* 2ECAC 8003E4AC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 2ECB0 8003E4B0 00000000 */  nop
    /* 2ECB4 8003E4B4 0800E003 */  jr         $ra
    /* 2ECB8 8003E4B8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TurnOffVideoWall__25tScreenCarSelectTwoPlayer
