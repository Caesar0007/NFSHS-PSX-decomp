.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__10tMenuBlank, 0x8

glabel Initialize__10tMenuBlank
    /* C1CC 8001B9CC 0800E003 */  jr         $ra
    /* C1D0 8001B9D0 00000000 */   nop
endlabel Initialize__10tMenuBlank
