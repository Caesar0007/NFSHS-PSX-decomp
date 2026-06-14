.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fortext4, 0x8

glabel fortext4
    /* D4640 800E3E40 0800E003 */  jr         $ra
    /* D4644 800E3E44 00000000 */   nop
endlabel fortext4
