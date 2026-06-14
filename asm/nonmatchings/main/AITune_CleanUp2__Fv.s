.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AITune_CleanUp2__Fv, 0x8

glabel AITune_CleanUp2__Fv
    /* 63788 80072F88 0800E003 */  jr         $ra
    /* 6378C 80072F8C 00000000 */   nop
endlabel AITune_CleanUp2__Fv
