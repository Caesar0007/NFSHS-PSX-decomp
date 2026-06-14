.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_DeInitRenderEngine__Fv, 0x24

glabel Draw_DeInitRenderEngine__Fv
    /* AEE84 800BE684 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AEE88 800BE688 1000BFAF */  sw         $ra, 0x10($sp)
    /* AEE8C 800BE68C 01F8020C */  jal        ClearPlatformPrimitivesBuffer__Fv
    /* AEE90 800BE690 00000000 */   nop
    /* AEE94 800BE694 1000BF8F */  lw         $ra, 0x10($sp)
    /* AEE98 800BE698 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* AEE9C 800BE69C 681282AF */  sw         $v0, %gp_rel(gFlip)($gp)
    /* AEEA0 800BE6A0 0800E003 */  jr         $ra
    /* AEEA4 800BE6A4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Draw_DeInitRenderEngine__Fv
