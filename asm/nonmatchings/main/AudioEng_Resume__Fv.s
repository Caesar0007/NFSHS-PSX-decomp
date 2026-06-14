.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioEng_Resume__Fv, 0x8

glabel AudioEng_Resume__Fv
    /* 6CD2C 8007C52C 0800E003 */  jr         $ra
    /* 6CD30 8007C530 00000000 */   nop
endlabel AudioEng_Resume__Fv
