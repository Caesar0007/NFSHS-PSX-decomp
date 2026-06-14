.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BTC_BonusTime__Fl, 0x18

glabel Hud_BTC_BonusTime__Fl
    /* CA10C 800D990C 1480023C */  lui        $v0, %hi(ticks)
    /* CA110 800D9910 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* CA114 800D9914 DC1884AF */  sw         $a0, %gp_rel(D_8013DE28)($gp)
    /* CA118 800D9918 E01882AF */  sw         $v0, %gp_rel(D_8013DE2C)($gp)
    /* CA11C 800D991C 0800E003 */  jr         $ra
    /* CA120 800D9920 00000000 */   nop
endlabel Hud_BTC_BonusTime__Fl
