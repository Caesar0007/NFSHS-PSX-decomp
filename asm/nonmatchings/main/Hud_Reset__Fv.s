.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_Reset__Fv, 0x58

glabel Hud_Reset__Fv
    /* C9FF0 800D97F0 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* C9FF4 800D97F4 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* C9FF8 800D97F8 00000000 */  nop
    /* C9FFC 800D97FC 02004228 */  slti       $v0, $v0, 0x2
    /* CA000 800D9800 0A004010 */  beqz       $v0, .L800D982C
    /* CA004 800D9804 21200000 */   addu      $a0, $zero, $zero
    /* CA008 800D9808 1480053C */  lui        $a1, %hi(D_8013E850)
    /* CA00C 800D980C 1480033C */  lui        $v1, %hi(Hud_NextPerp)
    /* CA010 800D9810 94D96324 */  addiu      $v1, $v1, %lo(Hud_NextPerp)
  .L800D9814:
    /* CA014 800D9814 000060A4 */  sh         $zero, 0x0($v1)
    /* CA018 800D9818 02006324 */  addiu      $v1, $v1, 0x2
    /* CA01C 800D981C 01008424 */  addiu      $a0, $a0, 0x1
    /* CA020 800D9820 02008228 */  slti       $v0, $a0, 0x2
    /* CA024 800D9824 FBFF4014 */  bnez       $v0, .L800D9814
    /* CA028 800D9828 50E8A0A0 */   sb        $zero, %lo(D_8013E850)($a1)
  .L800D982C:
    /* CA02C 800D982C DC1880AF */  sw         $zero, %gp_rel(D_8013DE28)($gp)
    /* CA030 800D9830 DC1380AF */  sw         $zero, %gp_rel(HudBustedOverlay)($gp)
    /* CA034 800D9834 EC1880AF */  sw         $zero, %gp_rel(D_8013DE38)($gp)
    /* CA038 800D9838 F01880AF */  sw         $zero, %gp_rel(D_8013DE3C)($gp)
    /* CA03C 800D983C E41880AF */  sw         $zero, %gp_rel(D_8013DE30)($gp)
    /* CA040 800D9840 0800E003 */  jr         $ra
    /* CA044 800D9844 00000000 */   nop
endlabel Hud_Reset__Fv
