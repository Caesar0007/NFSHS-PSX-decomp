.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_SndError__Fi, 0x8

glabel AudioClc_SndError__Fi
    /* 64F30 80074730 0800E003 */  jr         $ra
    /* 64F34 80074734 00000000 */   nop
endlabel AudioClc_SndError__Fi
