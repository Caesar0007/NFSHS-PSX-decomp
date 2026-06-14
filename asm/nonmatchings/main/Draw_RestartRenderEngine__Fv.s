.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_RestartRenderEngine__Fv, 0x8

glabel Draw_RestartRenderEngine__Fv
    /* AEE7C 800BE67C 0800E003 */  jr         $ra
    /* AEE80 800BE680 00000000 */   nop
endlabel Draw_RestartRenderEngine__Fv
