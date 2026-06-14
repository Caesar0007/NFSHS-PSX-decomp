.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_InitLibRender__Fv, 0x20

glabel Render_InitLibRender__Fv
    /* A4088 800B3888 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A408C 800B388C 1000BFAF */  sw         $ra, 0x10($sp)
    /* A4090 800B3890 AAF9020C */  jal        Draw_InitLibRender__Fv
    /* A4094 800B3894 00000000 */   nop
    /* A4098 800B3898 1000BF8F */  lw         $ra, 0x10($sp)
    /* A409C 800B389C 00000000 */  nop
    /* A40A0 800B38A0 0800E003 */  jr         $ra
    /* A40A4 800B38A4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_InitLibRender__Fv
