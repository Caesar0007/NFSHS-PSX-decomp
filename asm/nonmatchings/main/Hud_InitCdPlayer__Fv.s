.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_InitCdPlayer__Fv, 0x24

glabel Hud_InitCdPlayer__Fv
    /* C6BB8 800D63B8 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* C6BBC 800D63BC F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* C6BC0 800D63C0 381480AF */  sw         $zero, %gp_rel(Hud_gCdLastTick)($gp)
    /* C6BC4 800D63C4 3C1480AF */  sw         $zero, %gp_rel(Hud_gCdScrollTitle)($gp)
    /* C6BC8 800D63C8 E01380AF */  sw         $zero, %gp_rel(Hud_gCdActive)($gp)
    /* C6BCC 800D63CC 02004228 */  slti       $v0, $v0, 0x2
    /* C6BD0 800D63D0 E41382AF */  sw         $v0, %gp_rel(Hud_ActivateCDPlayer)($gp)
    /* C6BD4 800D63D4 0800E003 */  jr         $ra
    /* C6BD8 800D63D8 00000000 */   nop
endlabel Hud_InitCdPlayer__Fv
