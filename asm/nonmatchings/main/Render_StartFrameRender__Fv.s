.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_StartFrameRender__Fv, 0x40

glabel Render_StartFrameRender__Fv
    /* A3BB0 800B33B0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A3BB4 800B33B4 1000BFAF */  sw         $ra, 0x10($sp)
    /* A3BB8 800B33B8 70F9010C */  jal        BWorld_StartLoop__Fv
    /* A3BBC 800B33BC 00000000 */   nop
    /* A3BC0 800B33C0 77E6020C */  jal        Track_AnimateTextures__Fv
    /* A3BC4 800B33C4 00000000 */   nop
    /* A3BC8 800B33C8 3BDE020C */  jal        Souffle_DoSouffle__Fv
    /* A3BCC 800B33CC 00000000 */   nop
    /* A3BD0 800B33D0 8CF8020C */  jal        Draw_CheckFirstFrameRender__Fv
    /* A3BD4 800B33D4 00000000 */   nop
    /* A3BD8 800B33D8 B0F8020C */  jal        Draw_StartFrameRender__Fv
    /* A3BDC 800B33DC 00000000 */   nop
    /* A3BE0 800B33E0 1000BF8F */  lw         $ra, 0x10($sp)
    /* A3BE4 800B33E4 00000000 */  nop
    /* A3BE8 800B33E8 0800E003 */  jr         $ra
    /* A3BEC 800B33EC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_StartFrameRender__Fv
