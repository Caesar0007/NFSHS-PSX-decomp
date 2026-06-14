.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AITune_StartUp2__Fv, 0x8

glabel AITune_StartUp2__Fv
    /* 63778 80072F78 0800E003 */  jr         $ra
    /* 6377C 80072F7C 00000000 */   nop
endlabel AITune_StartUp2__Fv
