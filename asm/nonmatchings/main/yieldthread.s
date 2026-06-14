.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching yieldthread, 0x8

glabel yieldthread
    /* EEC1C 800FE41C 0800E003 */  jr         $ra
    /* EEC20 800FE420 00000000 */   nop
endlabel yieldthread
