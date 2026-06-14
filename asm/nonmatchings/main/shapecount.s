.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching shapecount, 0xC

glabel shapecount
    /* E12AC 800F0AAC 0800828C */  lw         $v0, 0x8($a0)
    /* E12B0 800F0AB0 0800E003 */  jr         $ra
    /* E12B4 800F0AB4 00000000 */   nop
endlabel shapecount
