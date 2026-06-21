.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__10tMenuBlank, 0x8

glabel UpdateTransition__10tMenuBlank
    /* C6F8 8001BEF8 0800E003 */  jr         $ra
    /* C6FC 8001BEFC 00000000 */   nop
endlabel UpdateTransition__10tMenuBlank
