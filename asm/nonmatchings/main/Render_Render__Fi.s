.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_Render__Fi, 0x140

glabel Render_Render__Fi
    /* A3CA8 800B34A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A3CAC 800B34AC 1400BFAF */  sw         $ra, 0x14($sp)
    /* A3CB0 800B34B0 2A008010 */  beqz       $a0, .L800B355C
    /* A3CB4 800B34B4 1000B0AF */   sw        $s0, 0x10($sp)
    /* A3CB8 800B34B8 900E828F */  lw         $v0, %gp_rel(gPauseRender)($gp)
    /* A3CBC 800B34BC 00000000 */  nop
    /* A3CC0 800B34C0 12004014 */  bnez       $v0, .L800B350C
    /* A3CC4 800B34C4 01001024 */   addiu     $s0, $zero, 0x1
    /* A3CC8 800B34C8 40010224 */  addiu      $v0, $zero, 0x140
    /* A3CCC 800B34CC 8C0E82A7 */  sh         $v0, %gp_rel(D_8013D3D8)($gp)
    /* A3CD0 800B34D0 F0000224 */  addiu      $v0, $zero, 0xF0
    /* A3CD4 800B34D4 900E90AF */  sw         $s0, %gp_rel(gPauseRender)($gp)
    /* A3CD8 800B34D8 880E80A7 */  sh         $zero, %gp_rel(gPauseMenuRect)($gp)
    /* A3CDC 800B34DC 8A0E80A7 */  sh         $zero, %gp_rel(D_8013D3D6)($gp)
    /* A3CE0 800B34E0 8E0E82A7 */  sh         $v0, %gp_rel(D_8013D3DA)($gp)
    /* A3CE4 800B34E4 1FB6030C */  jal        DrawSync
    /* A3CE8 800B34E8 21200000 */   addu      $a0, $zero, $zero
    /* A3CEC 800B34EC B173030C */  jal        RPause_CopyBackToFrontBuffer__Fv
    /* A3CF0 800B34F0 00000000 */   nop
    /* A3CF4 800B34F4 207B020C */  jal        MPause_StartPauseMenu__Fv
    /* A3CF8 800B34F8 00000000 */   nop
    /* A3CFC 800B34FC 1480013C */  lui        $at, %hi(gMPauseUpdate)
    /* A3D00 800B3500 64D230AC */  sw         $s0, %lo(gMPauseUpdate)($at)
    /* A3D04 800B3504 1480013C */  lui        $at, %hi(gMPauseUpdateNextTime)
    /* A3D08 800B3508 40D220AC */  sw         $zero, %lo(gMPauseUpdateNextTime)($at)
  .L800B350C:
    /* A3D0C 800B350C 1480033C */  lui        $v1, %hi(gMPauseUpdate)
    /* A3D10 800B3510 64D2638C */  lw         $v1, %lo(gMPauseUpdate)($v1)
    /* A3D14 800B3514 4E000224 */  addiu      $v0, $zero, 0x4E
    /* A3D18 800B3518 880E82A7 */  sh         $v0, %gp_rel(gPauseMenuRect)($gp)
    /* A3D1C 800B351C 62000224 */  addiu      $v0, $zero, 0x62
    /* A3D20 800B3520 8A0E82A7 */  sh         $v0, %gp_rel(D_8013D3D6)($gp)
    /* A3D24 800B3524 A4000224 */  addiu      $v0, $zero, 0xA4
    /* A3D28 800B3528 8C0E82A7 */  sh         $v0, %gp_rel(D_8013D3D8)($gp)
    /* A3D2C 800B352C 8B000224 */  addiu      $v0, $zero, 0x8B
    /* A3D30 800B3530 8E0E82A7 */  sh         $v0, %gp_rel(D_8013D3DA)($gp)
    /* A3D34 800B3534 28006010 */  beqz       $v1, .L800B35D8
    /* A3D38 800B3538 00000000 */   nop
    /* A3D3C 800B353C E173030C */  jal        RPause_StartPauseMenu__Fv
    /* A3D40 800B3540 00000000 */   nop
    /* A3D44 800B3544 0CCD020C */  jal        Render_RenderPauseMenuView__Fv
    /* A3D48 800B3548 00000000 */   nop
    /* A3D4C 800B354C E973030C */  jal        RPause_StopPauseMenu__Fv
    /* A3D50 800B3550 00000000 */   nop
    /* A3D54 800B3554 76CD0208 */  j          .L800B35D8
    /* A3D58 800B3558 00000000 */   nop
  .L800B355C:
    /* A3D5C 800B355C 900E828F */  lw         $v0, %gp_rel(gPauseRender)($gp)
    /* A3D60 800B3560 00000000 */  nop
    /* A3D64 800B3564 04004010 */  beqz       $v0, .L800B3578
    /* A3D68 800B3568 1180023C */   lui       $v0, %hi(D_801131F8)
    /* A3D6C 800B356C 900E80AF */  sw         $zero, %gp_rel(gPauseRender)($gp)
    /* A3D70 800B3570 76CD0208 */  j          .L800B35D8
    /* A3D74 800B3574 00000000 */   nop
  .L800B3578:
    /* A3D78 800B3578 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* A3D7C 800B357C 01000224 */  addiu      $v0, $zero, 0x1
    /* A3D80 800B3580 09006214 */  bne        $v1, $v0, .L800B35A8
    /* A3D84 800B3584 00000000 */   nop
    /* A3D88 800B3588 ECCC020C */  jal        Render_StartFrameRender__Fv
    /* A3D8C 800B358C 00000000 */   nop
    /* A3D90 800B3590 800E848F */  lw         $a0, %gp_rel(Draw_gPlayer1View)($gp)
    /* A3D94 800B3594 D7CC020C */  jal        Render_RenderPlayerView__Fii
    /* A3D98 800B3598 21280000 */   addu      $a1, $zero, $zero
    /* A3D9C 800B359C 840E848F */  lw         $a0, %gp_rel(Draw_gPlayer2View)($gp)
    /* A3DA0 800B35A0 6ECD0208 */  j          .L800B35B8
    /* A3DA4 800B35A4 01000524 */   addiu     $a1, $zero, 0x1
  .L800B35A8:
    /* A3DA8 800B35A8 ECCC020C */  jal        Render_StartFrameRender__Fv
    /* A3DAC 800B35AC 00000000 */   nop
    /* A3DB0 800B35B0 800E848F */  lw         $a0, %gp_rel(Draw_gPlayer1View)($gp)
    /* A3DB4 800B35B4 21280000 */  addu       $a1, $zero, $zero
  .L800B35B8:
    /* A3DB8 800B35B8 D7CC020C */  jal        Render_RenderPlayerView__Fii
    /* A3DBC 800B35BC 00000000 */   nop
    /* A3DC0 800B35C0 1664030C */  jal        Hud_Render__Fv
    /* A3DC4 800B35C4 00000000 */   nop
    /* A3DC8 800B35C8 EACC020C */  jal        Render_RenderDebugView__Fv
    /* A3DCC 800B35CC 00000000 */   nop
    /* A3DD0 800B35D0 FCCC020C */  jal        Render_StopFrameRender__Fv
    /* A3DD4 800B35D4 00000000 */   nop
  .L800B35D8:
    /* A3DD8 800B35D8 1400BF8F */  lw         $ra, 0x14($sp)
    /* A3DDC 800B35DC 1000B08F */  lw         $s0, 0x10($sp)
    /* A3DE0 800B35E0 0800E003 */  jr         $ra
    /* A3DE4 800B35E4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_Render__Fi
