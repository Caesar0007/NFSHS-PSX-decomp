.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Force_HitWall__Fi, 0x8

glabel Force_HitWall__Fi
    /* BBA04 800CB204 0800E003 */  jr         $ra
    /* BBA08 800CB208 00000000 */   nop
endlabel Force_HitWall__Fi
