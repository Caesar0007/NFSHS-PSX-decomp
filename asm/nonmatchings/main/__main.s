.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __main, 0x8

glabel __main
    /* D4824 800E4024 0800E003 */  jr         $ra
    /* D4828 800E4028 00000000 */   nop
endlabel __main
