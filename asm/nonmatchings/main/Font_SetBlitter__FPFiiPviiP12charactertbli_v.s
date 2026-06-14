.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_SetBlitter__FPFiiPviiP12charactertbli_v, 0xC

glabel Font_SetBlitter__FPFiiPviiP12charactertbli_v
    /* BBFCC 800CB7CC A01884AF */  sw         $a0, %gp_rel(D_8013DDEC)($gp)
    /* BBFD0 800CB7D0 0800E003 */  jr         $ra
    /* BBFD4 800CB7D4 00000000 */   nop
endlabel Font_SetBlitter__FPFiiPviiP12charactertbli_v
