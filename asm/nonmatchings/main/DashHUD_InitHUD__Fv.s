.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DashHUD_InitHUD__Fv, 0x134

glabel DashHUD_InitHUD__Fv
    /* 8B6BC 8009AEBC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8B6C0 8009AEC0 21200000 */  addu       $a0, $zero, $zero
    /* 8B6C4 8009AEC4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 8B6C8 8009AEC8 EC314824 */  addiu      $t0, $v0, %lo(GameSetup_gData)
    /* 8B6CC 8009AECC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8B6D0 8009AED0 0C00028D */  lw         $v0, 0xC($t0)
    /* 8B6D4 8009AED4 1180033C */  lui        $v1, %hi(DashHUD_gInfo)
    /* 8B6D8 8009AED8 01004238 */  xori       $v0, $v0, 0x1
    /* 8B6DC 8009AEDC 0100422C */  sltiu      $v0, $v0, 0x1
    /* 8B6E0 8009AEE0 302762AC */  sw         $v0, %lo(DashHUD_gInfo)($v1)
    /* 8B6E4 8009AEE4 2A104400 */  slt        $v0, $v0, $a0
    /* 8B6E8 8009AEE8 17004014 */  bnez       $v0, .L8009AF48
    /* 8B6EC 8009AEEC 1180023C */   lui       $v0, %hi(DashHUD_gInfo)
    /* 8B6F0 8009AEF0 0200063C */  lui        $a2, (0x23CA5 >> 16)
    /* 8B6F4 8009AEF4 A53CC634 */  ori        $a2, $a2, (0x23CA5 & 0xFFFF)
    /* 8B6F8 8009AEF8 01000924 */  addiu      $t1, $zero, 0x1
    /* 8B6FC 8009AEFC 0300053C */  lui        $a1, (0x39999 >> 16)
    /* 8B700 8009AF00 9999A534 */  ori        $a1, $a1, (0x39999 & 0xFFFF)
    /* 8B704 8009AF04 21386000 */  addu       $a3, $v1, $zero
    /* 8B708 8009AF08 21180001 */  addu       $v1, $t0, $zero
  .L8009AF0C:
    /* 8B70C 8009AF0C 4404628C */  lw         $v0, 0x444($v1)
    /* 8B710 8009AF10 00000000 */  nop
    /* 8B714 8009AF14 03004014 */  bnez       $v0, .L8009AF24
    /* 8B718 8009AF18 00000000 */   nop
    /* 8B71C 8009AF1C CC6B0208 */  j          .L8009AF30
    /* 8B720 8009AF20 480466AC */   sw        $a2, 0x448($v1)
  .L8009AF24:
    /* 8B724 8009AF24 02004914 */  bne        $v0, $t1, .L8009AF30
    /* 8B728 8009AF28 00000000 */   nop
    /* 8B72C 8009AF2C 480465AC */  sw         $a1, 0x448($v1)
  .L8009AF30:
    /* 8B730 8009AF30 3027E28C */  lw         $v0, %lo(DashHUD_gInfo)($a3)
    /* 8B734 8009AF34 01008424 */  addiu      $a0, $a0, 0x1
    /* 8B738 8009AF38 2A104400 */  slt        $v0, $v0, $a0
    /* 8B73C 8009AF3C F3FF4010 */  beqz       $v0, .L8009AF0C
    /* 8B740 8009AF40 B4006324 */   addiu     $v1, $v1, 0xB4
    /* 8B744 8009AF44 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
  .L8009AF48:
    /* 8B748 8009AF48 30274424 */  addiu      $a0, $v0, %lo(DashHUD_gInfo)
    /* 8B74C 8009AF4C 3027428C */  lw         $v0, %lo(DashHUD_gInfo)($v0)
    /* 8B750 8009AF50 01000324 */  addiu      $v1, $zero, 0x1
    /* 8B754 8009AF54 1C0083AC */  sw         $v1, 0x1C($a0)
    /* 8B758 8009AF58 04004010 */  beqz       $v0, .L8009AF6C
    /* 8B75C 8009AF5C 200083AC */   sw        $v1, 0x20($a0)
    /* 8B760 8009AF60 240080AC */  sw         $zero, 0x24($a0)
    /* 8B764 8009AF64 DC6B0208 */  j          .L8009AF70
    /* 8B768 8009AF68 280080AC */   sw        $zero, 0x28($a0)
  .L8009AF6C:
    /* 8B76C 8009AF6C 240083AC */  sw         $v1, 0x24($a0)
  .L8009AF70:
    /* 8B770 8009AF70 1180033C */  lui        $v1, %hi(DashHUD_gInfo)
    /* 8B774 8009AF74 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* 8B778 8009AF78 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* 8B77C 8009AF7C 30276324 */  addiu      $v1, $v1, %lo(DashHUD_gInfo)
    /* 8B780 8009AF80 2C0060AC */  sw         $zero, 0x2C($v1)
    /* 8B784 8009AF84 02004228 */  slti       $v0, $v0, 0x2
    /* 8B788 8009AF88 05004010 */  beqz       $v0, .L8009AFA0
    /* 8B78C 8009AF8C 300060AC */   sw        $zero, 0x30($v1)
    /* 8B790 8009AF90 1180023C */  lui        $v0, %hi(D_801132D4)
    /* 8B794 8009AF94 D432428C */  lw         $v0, %lo(D_801132D4)($v0)
    /* 8B798 8009AF98 E96B0208 */  j          .L8009AFA4
    /* 8B79C 8009AF9C 5C0062AC */   sw        $v0, 0x5C($v1)
  .L8009AFA0:
    /* 8B7A0 8009AFA0 5C0060AC */  sw         $zero, 0x5C($v1)
  .L8009AFA4:
    /* 8B7A4 8009AFA4 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
    /* 8B7A8 8009AFA8 1180033C */  lui        $v1, %hi(D_801131F0)
    /* 8B7AC 8009AFAC F031638C */  lw         $v1, %lo(D_801131F0)($v1)
    /* 8B7B0 8009AFB0 30274224 */  addiu      $v0, $v0, %lo(DashHUD_gInfo)
    /* 8B7B4 8009AFB4 600040AC */  sw         $zero, 0x60($v0)
    /* 8B7B8 8009AFB8 640040AC */  sw         $zero, 0x64($v0)
    /* 8B7BC 8009AFBC 680040AC */  sw         $zero, 0x68($v0)
    /* 8B7C0 8009AFC0 3749020C */  jal        HudPmx_InitTextures__Fv
    /* 8B7C4 8009AFC4 3C0043AC */   sw        $v1, 0x3C($v0)
    /* 8B7C8 8009AFC8 BD4A030C */  jal        Hud_Init0__Fv
    /* 8B7CC 8009AFCC 00000000 */   nop
    /* 8B7D0 8009AFD0 0B4C030C */  jal        Hud_Init__Fv
    /* 8B7D4 8009AFD4 00000000 */   nop
    /* 8B7D8 8009AFD8 3065030C */  jal        Hud_PositionMap__Fv
    /* 8B7DC 8009AFDC 00000000 */   nop
    /* 8B7E0 8009AFE0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8B7E4 8009AFE4 00000000 */  nop
    /* 8B7E8 8009AFE8 0800E003 */  jr         $ra
    /* 8B7EC 8009AFEC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DashHUD_InitHUD__Fv
