.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_StopRenderingWorldView__Fi, 0x20

glabel Render_StopRenderingWorldView__Fi
    /* A3A98 800B3298 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A3A9C 800B329C 1000BFAF */  sw         $ra, 0x10($sp)
    /* A3AA0 800B32A0 46F8020C */  jal        Draw_StopRenderingView__Fi
    /* A3AA4 800B32A4 00000000 */   nop
    /* A3AA8 800B32A8 1000BF8F */  lw         $ra, 0x10($sp)
    /* A3AAC 800B32AC 00000000 */  nop
    /* A3AB0 800B32B0 0800E003 */  jr         $ra
    /* A3AB4 800B32B4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_StopRenderingWorldView__Fi
