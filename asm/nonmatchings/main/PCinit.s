.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PCinit, 0xC

glabel PCinit
    /* F74C4 80106CC4 4D400000 */  break      0, 257
    /* F74C8 80106CC8 0800E003 */  jr         $ra
    /* F74CC 80106CCC 00000000 */   nop
endlabel PCinit
