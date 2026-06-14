.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FastRandom_CleanUp__Fv, 0x8

glabel FastRandom_CleanUp__Fv
    /* 8BBC8 8009B3C8 0800E003 */  jr         $ra
    /* 8BBCC 8009B3CC 00000000 */   nop
endlabel FastRandom_CleanUp__Fv
