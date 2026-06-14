.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_RestartTrackRender__Fv, 0x48

glabel Render_RestartTrackRender__Fv
    /* A3FAC 800B37AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A3FB0 800B37B0 1000BFAF */  sw         $ra, 0x10($sp)
    /* A3FB4 800B37B4 9FF9020C */  jal        Draw_RestartRenderEngine__Fv
    /* A3FB8 800B37B8 00000000 */   nop
    /* A3FBC 800B37BC 542A030C */  jal        DepthCue_Init__Fv
    /* A3FC0 800B37C0 00000000 */   nop
    /* A3FC4 800B37C4 0870030C */  jal        Night_RestartNightDriving__Fv
    /* A3FC8 800B37C8 00000000 */   nop
    /* A3FCC 800B37CC 5E7D030C */  jal        Skidmark_RestartSkidmark__Fv
    /* A3FD0 800B37D0 00000000 */   nop
    /* A3FD4 800B37D4 C5DF020C */  jal        Souffle_RestartTrackSouffle__Fv
    /* A3FD8 800B37D8 00000000 */   nop
    /* A3FDC 800B37DC 76EE020C */  jal        TrgSfx_RestartTrgSfx__Fv
    /* A3FE0 800B37E0 00000000 */   nop
    /* A3FE4 800B37E4 1000BF8F */  lw         $ra, 0x10($sp)
    /* A3FE8 800B37E8 00000000 */  nop
    /* A3FEC 800B37EC 0800E003 */  jr         $ra
    /* A3FF0 800B37F0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_RestartTrackRender__Fv
