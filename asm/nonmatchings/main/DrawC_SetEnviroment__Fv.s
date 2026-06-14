.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_SetEnviroment__Fv, 0x8

glabel DrawC_SetEnviroment__Fv
    /* AEEE8 800BE6E8 0800E003 */  jr         $ra
    /* AEEEC 800BE6EC 00000000 */   nop
endlabel DrawC_SetEnviroment__Fv
