.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_InitViews__Fv, 0xC

glabel Draw_InitViews__Fv
    /* AE3D4 800BDBD4 601280AF */  sw         $zero, %gp_rel(Draw_gNumView)($gp)
    /* AE3D8 800BDBD8 0800E003 */  jr         $ra
    /* AE3DC 800BDBDC 00000000 */   nop
endlabel Draw_InitViews__Fv
