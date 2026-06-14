.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_InitLibRender__Fv, 0x28

glabel Draw_InitLibRender__Fv
    /* AEEA8 800BE6A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AEEAC 800BE6AC 01000224 */  addiu      $v0, $zero, 0x1
    /* AEEB0 800BE6B0 1000BFAF */  sw         $ra, 0x10($sp)
    /* AEEB4 800BE6B4 6C1282AF */  sw         $v0, %gp_rel(gLoop)($gp)
    /* AEEB8 800BE6B8 69C8030C */  jal        InitGeom
    /* AEEBC 800BE6BC 00000000 */   nop
    /* AEEC0 800BE6C0 1000BF8F */  lw         $ra, 0x10($sp)
    /* AEEC4 800BE6C4 00000000 */  nop
    /* AEEC8 800BE6C8 0800E003 */  jr         $ra
    /* AEECC 800BE6CC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Draw_InitLibRender__Fv
