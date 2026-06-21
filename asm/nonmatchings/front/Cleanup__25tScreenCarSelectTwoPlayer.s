.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__25tScreenCarSelectTwoPlayer, 0x30

glabel Cleanup__25tScreenCarSelectTwoPlayer
    /* 2F610 8003EE10 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2F614 8003EE14 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2F618 8003EE18 21808000 */  addu       $s0, $a0, $zero
    /* 2F61C 8003EE1C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2F620 8003EE20 4162000C */  jal        Hide__11tDialogBase
    /* 2F624 8003EE24 A0030426 */   addiu     $a0, $s0, 0x3A0
    /* 2F628 8003EE28 2EEB000C */  jal        Cleanup__16tScreenCarSelect
    /* 2F62C 8003EE2C 21200002 */   addu      $a0, $s0, $zero
    /* 2F630 8003EE30 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2F634 8003EE34 1000B08F */  lw         $s0, 0x10($sp)
    /* 2F638 8003EE38 0800E003 */  jr         $ra
    /* 2F63C 8003EE3C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__25tScreenCarSelectTwoPlayer
