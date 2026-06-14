.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_RenderDebugView__Fv, 0x8

glabel Render_RenderDebugView__Fv
    /* A3BA8 800B33A8 0800E003 */  jr         $ra
    /* A3BAC 800B33AC 00000000 */   nop
endlabel Render_RenderDebugView__Fv
