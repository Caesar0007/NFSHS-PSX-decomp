.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_StopFrameRender__Fv, 0x20

glabel Render_StopFrameRender__Fv
    /* A3BF0 800B33F0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A3BF4 800B33F4 1000BFAF */  sw         $ra, 0x10($sp)
    /* A3BF8 800B33F8 DBF8020C */  jal        Draw_StopFrameRender__Fv
    /* A3BFC 800B33FC 00000000 */   nop
    /* A3C00 800B3400 1000BF8F */  lw         $ra, 0x10($sp)
    /* A3C04 800B3404 00000000 */  nop
    /* A3C08 800B3408 0800E003 */  jr         $ra
    /* A3C0C 800B340C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_StopFrameRender__Fv
