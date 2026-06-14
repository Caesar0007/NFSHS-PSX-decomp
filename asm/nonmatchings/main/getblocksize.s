.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching getblocksize, 0xC

glabel getblocksize
    /* D5AD4 800E52D4 F4FF828C */  lw         $v0, -0xC($a0)
    /* D5AD8 800E52D8 0800E003 */  jr         $ra
    /* D5ADC 800E52DC 00000000 */   nop
endlabel getblocksize
