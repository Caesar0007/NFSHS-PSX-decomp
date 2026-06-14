.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextureProcess_Init__Fv, 0x14

glabel TextureProcess_Init__Fv
    /* D1934 800E1134 10000224 */  addiu      $v0, $zero, 0x10
    /* D1938 800E1138 281682AF */  sw         $v0, %gp_rel(gZDepth)($gp)
    /* D193C 800E113C 2C1680AF */  sw         $zero, %gp_rel(TP_gZPaletteSystem)($gp)
    /* D1940 800E1140 0800E003 */  jr         $ra
    /* D1944 800E1144 00000000 */   nop
endlabel TextureProcess_Init__Fv
