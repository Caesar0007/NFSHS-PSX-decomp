.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetGeomScreen, 0xC

glabel SetGeomScreen
    /* DB39C 800EAB9C 00D0C448 */  ctc2       $a0, $26 /* handwritten instruction */
    /* DB3A0 800EABA0 0800E003 */  jr         $ra
    /* DB3A4 800EABA4 00000000 */   nop
endlabel SetGeomScreen
    /* DB3A8 800EABA8 00000000 */  nop
