.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_DeInit__Fv, 0x8

glabel BWorldSm_DeInit__Fv
    /* 6F168 8007E968 0800E003 */  jr         $ra
    /* 6F16C 8007E96C 00000000 */   nop
endlabel BWorldSm_DeInit__Fv
