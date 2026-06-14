.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Force_UnPause__Fv, 0x8

glabel Force_UnPause__Fv
    /* BB9F4 800CB1F4 0800E003 */  jr         $ra
    /* BB9F8 800CB1F8 00000000 */   nop
endlabel Force_UnPause__Fv
