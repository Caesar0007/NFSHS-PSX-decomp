.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BustedOverlayOff__Fv, 0xC

glabel Hud_BustedOverlayOff__Fv
    /* C9FE4 800D97E4 DC1380AF */  sw         $zero, %gp_rel(HudBustedOverlay)($gp)
    /* C9FE8 800D97E8 0800E003 */  jr         $ra
    /* C9FEC 800D97EC 00000000 */   nop
endlabel Hud_BustedOverlayOff__Fv
