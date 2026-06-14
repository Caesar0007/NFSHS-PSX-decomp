.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Force_HitSign__FP8Car_tObj, 0x8

glabel Force_HitSign__FP8Car_tObj
    /* BB9FC 800CB1FC 0800E003 */  jr         $ra
    /* BBA00 800CB200 00000000 */   nop
endlabel Force_HitSign__FP8Car_tObj
