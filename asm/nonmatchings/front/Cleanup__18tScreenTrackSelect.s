.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__18tScreenTrackSelect, 0x40

glabel Cleanup__18tScreenTrackSelect
    /* 32528 80041D28 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3252C 80041D2C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 32530 80041D30 21808000 */  addu       $s0, $a0, $zero
    /* 32534 80041D34 1400BFAF */  sw         $ra, 0x14($sp)
    /* 32538 80041D38 6400048E */  lw         $a0, 0x64($s0)
    /* 3253C 80041D3C 9043010C */  jal        VIDEO_destroy__Fi
    /* 32540 80041D40 00000000 */   nop
    /* 32544 80041D44 6400048E */  lw         $a0, 0x64($s0)
    /* 32548 80041D48 5095030C */  jal        purgememadr
    /* 3254C 80041D4C 00000000 */   nop
    /* 32550 80041D50 6898000C */  jal        Cleanup__7tScreen
    /* 32554 80041D54 21200002 */   addu      $a0, $s0, $zero
    /* 32558 80041D58 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3255C 80041D5C 1000B08F */  lw         $s0, 0x10($sp)
    /* 32560 80041D60 0800E003 */  jr         $ra
    /* 32564 80041D64 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__18tScreenTrackSelect
