.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_Debug__FPce, 0x18

glabel AILife_Debug__FPce
    /* 591D0 800689D0 0000A4AF */  sw         $a0, 0x0($sp)
    /* 591D4 800689D4 0400A5AF */  sw         $a1, 0x4($sp)
    /* 591D8 800689D8 0800A6AF */  sw         $a2, 0x8($sp)
    /* 591DC 800689DC 0C00A7AF */  sw         $a3, 0xC($sp)
    /* 591E0 800689E0 0800E003 */  jr         $ra
    /* 591E4 800689E4 00000000 */   nop
endlabel AILife_Debug__FPce
