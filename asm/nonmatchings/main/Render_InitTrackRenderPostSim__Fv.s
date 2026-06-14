.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_InitTrackRenderPostSim__Fv, 0x2C

glabel Render_InitTrackRenderPostSim__Fv
    /* A3FF4 800B37F4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A3FF8 800B37F8 1000BFAF */  sw         $ra, 0x10($sp)
    /* A3FFC 800B37FC 900E80AF */  sw         $zero, %gp_rel(gPauseRender)($gp)
    /* A4000 800B3800 8C7D030C */  jal        Texture_DeInitPaletteSharing__Fv
    /* A4004 800B3804 00000000 */   nop
    /* A4008 800B3808 4485030C */  jal        CV_InitColorVertices__Fv
    /* A400C 800B380C 00000000 */   nop
    /* A4010 800B3810 1000BF8F */  lw         $ra, 0x10($sp)
    /* A4014 800B3814 00000000 */  nop
    /* A4018 800B3818 0800E003 */  jr         $ra
    /* A401C 800B381C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_InitTrackRenderPostSim__Fv
