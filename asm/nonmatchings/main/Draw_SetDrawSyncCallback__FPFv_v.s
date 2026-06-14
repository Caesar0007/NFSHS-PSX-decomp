.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_SetDrawSyncCallback__FPFv_v, 0xC

glabel Draw_SetDrawSyncCallback__FPFv_v
    /* AEB60 800BE360 9C1884AF */  sw         $a0, %gp_rel(D_8013DDE8)($gp)
    /* AEB64 800BE364 0800E003 */  jr         $ra
    /* AEB68 800BE368 00000000 */   nop
endlabel Draw_SetDrawSyncCallback__FPFv_v
