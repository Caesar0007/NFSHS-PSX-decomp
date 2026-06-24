.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sim_MainGameLoop__Fv, 0x504

glabel Sim_MainGameLoop__Fv
    /* A754C 800B6D4C C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* A7550 800B6D50 1280023C */  lui        $v0, %hi(simVar)
    /* A7554 800B6D54 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* A7558 800B6D58 C4E05124 */  addiu      $s1, $v0, %lo(simVar)
    /* A755C 800B6D5C 1280023C */  lui        $v0, %hi(simGlobal)
    /* A7560 800B6D60 ACE04224 */  addiu      $v0, $v0, %lo(simGlobal)
    /* A7564 800B6D64 2400B3AF */  sw         $s3, 0x24($sp)
    /* A7568 800B6D68 21984000 */  addu       $s3, $v0, $zero
    /* A756C 800B6D6C 01000224 */  addiu      $v0, $zero, 0x1
    /* A7570 800B6D70 E40E82AF */  sw         $v0, %gp_rel(quitType)($gp)
    /* A7574 800B6D74 1180023C */  lui        $v0, %hi(D_80110C28)
    /* A7578 800B6D78 280C428C */  lw         $v0, %lo(D_80110C28)($v0)
    /* A757C 800B6D7C 1480033C */  lui        $v1, %hi(Input_gTime)
    /* A7580 800B6D80 20D2638C */  lw         $v1, %lo(Input_gTime)($v1)
    /* A7584 800B6D84 3400B7AF */  sw         $s7, 0x34($sp)
    /* A7588 800B6D88 21B80000 */  addu       $s7, $zero, $zero
    /* A758C 800B6D8C 3800BEAF */  sw         $fp, 0x38($sp)
    /* A7590 800B6D90 11801E3C */  lui        $fp, %hi(Replay_ReplayInterface)
    /* A7594 800B6D94 2800B4AF */  sw         $s4, 0x28($sp)
    /* A7598 800B6D98 2C70D427 */  addiu      $s4, $fp, %lo(Replay_ReplayInterface)
    /* A759C 800B6D9C 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* A75A0 800B6DA0 3000B6AF */  sw         $s6, 0x30($sp)
    /* A75A4 800B6DA4 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* A75A8 800B6DA8 2000B2AF */  sw         $s2, 0x20($sp)
    /* A75AC 800B6DAC 1800B0AF */  sw         $s0, 0x18($sp)
    /* A75B0 800B6DB0 10275624 */  addiu      $s6, $v0, 0x2710
    /* A75B4 800B6DB4 080063AE */  sw         $v1, 0x8($s3)
  .L800B6DB8:
    /* A75B8 800B6DB8 0400228E */  lw         $v0, 0x4($s1)
    /* A75BC 800B6DBC 00000000 */  nop
    /* A75C0 800B6DC0 0D014014 */  bnez       $v0, .L800B71F8
    /* A75C4 800B6DC4 00000000 */   nop
    /* A75C8 800B6DC8 019B030C */  jal        systemtask
    /* A75CC 800B6DCC 21200000 */   addu      $a0, $zero, $zero
    /* A75D0 800B6DD0 1180023C */  lui        $v0, %hi(D_80110C28)
    /* A75D4 800B6DD4 1480033C */  lui        $v1, %hi(gSimQueue_Ticker)
    /* A75D8 800B6DD8 34D4638C */  lw         $v1, %lo(gSimQueue_Ticker)($v1)
    /* A75DC 800B6DDC 280C458C */  lw         $a1, %lo(D_80110C28)($v0)
    /* A75E0 800B6DE0 40200300 */  sll        $a0, $v1, 1
    /* A75E4 800B6DE4 2318B600 */  subu       $v1, $a1, $s6
    /* A75E8 800B6DE8 23109700 */  subu       $v0, $a0, $s7
    /* A75EC 800B6DEC 2A104300 */  slt        $v0, $v0, $v1
    /* A75F0 800B6DF0 03004010 */  beqz       $v0, .L800B6E00
    /* A75F4 800B6DF4 140024AE */   sw        $a0, 0x14($s1)
    /* A75F8 800B6DF8 01008224 */  addiu      $v0, $a0, 0x1
    /* A75FC 800B6DFC 140022AE */  sw         $v0, 0x14($s1)
  .L800B6E00:
    /* A7600 800B6E00 1480033C */  lui        $v1, %hi(Input_gTime)
    /* A7604 800B6E04 20D2638C */  lw         $v1, %lo(Input_gTime)($v1)
    /* A7608 800B6E08 0800628E */  lw         $v0, 0x8($s3)
    /* A760C 800B6E0C 1400378E */  lw         $s7, 0x14($s1)
    /* A7610 800B6E10 23106200 */  subu       $v0, $v1, $v0
    /* A7614 800B6E14 11004228 */  slti       $v0, $v0, 0x11
    /* A7618 800B6E18 02004014 */  bnez       $v0, .L800B6E24
    /* A761C 800B6E1C 21B0A000 */   addu      $s6, $a1, $zero
    /* A7620 800B6E20 080063AE */  sw         $v1, 0x8($s3)
  .L800B6E24:
    /* A7624 800B6E24 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A7628 800B6E28 EC315524 */  addiu      $s5, $v0, %lo(GameSetup_gData)
  .L800B6E2C:
    /* A762C 800B6E2C 0800638E */  lw         $v1, 0x8($s3)
    /* A7630 800B6E30 1480023C */  lui        $v0, %hi(Input_gTime)
    /* A7634 800B6E34 20D2428C */  lw         $v0, %lo(Input_gTime)($v0)
    /* A7638 800B6E38 00000000 */  nop
    /* A763C 800B6E3C 2A104300 */  slt        $v0, $v0, $v1
    /* A7640 800B6E40 88004014 */  bnez       $v0, .L800B7064
    /* A7644 800B6E44 00000000 */   nop
    /* A7648 800B6E48 0400228E */  lw         $v0, 0x4($s1)
    /* A764C 800B6E4C 00000000 */  nop
    /* A7650 800B6E50 84004014 */  bnez       $v0, .L800B7064
    /* A7654 800B6E54 02000224 */   addiu     $v0, $zero, 0x2
    /* A7658 800B6E58 1480033C */  lui        $v1, %hi(Replay_ReplayMode)
    /* A765C 800B6E5C F4D3638C */  lw         $v1, %lo(Replay_ReplayMode)($v1)
    /* A7660 800B6E60 00000000 */  nop
    /* A7664 800B6E64 2D006214 */  bne        $v1, $v0, .L800B6F1C
    /* A7668 800B6E68 00000000 */   nop
    /* A766C 800B6E6C 0800228E */  lw         $v0, 0x8($s1)
    /* A7670 800B6E70 00000000 */  nop
    /* A7674 800B6E74 29004014 */  bnez       $v0, .L800B6F1C
    /* A7678 800B6E78 00000000 */   nop
    /* A767C 800B6E7C 1CD4020C */  jal        Replay_GetInterfaceKey__Fv
    /* A7680 800B6E80 00000000 */   nop
    /* A7684 800B6E84 1400838E */  lw         $v1, 0x14($s4)
    /* A7688 800B6E88 04000224 */  addiu      $v0, $zero, 0x4
    /* A768C 800B6E8C 23006214 */  bne        $v1, $v0, .L800B6F1C
    /* A7690 800B6E90 00000000 */   nop
    /* A7694 800B6E94 0800838E */  lw         $v1, 0x8($s4)
    /* A7698 800B6E98 2800A28E */  lw         $v0, 0x28($s5)
    /* A769C 800B6E9C 140080AE */  sw         $zero, 0x14($s4)
    /* A76A0 800B6EA0 05004010 */  beqz       $v0, .L800B6EB8
    /* A76A4 800B6EA4 040023AE */   sw        $v1, 0x4($s1)
    /* A76A8 800B6EA8 63E7010C */  jal        AudioCmn_UnPauseAndRestart__Fv
    /* A76AC 800B6EAC 00000000 */   nop
    /* A76B0 800B6EB0 C7DB0208 */  j          .L800B6F1C
    /* A76B4 800B6EB4 00000000 */   nop
  .L800B6EB8:
    /* A76B8 800B6EB8 09006010 */  beqz       $v1, .L800B6EE0
    /* A76BC 800B6EBC 00000000 */   nop
    /* A76C0 800B6EC0 1000228E */  lw         $v0, 0x10($s1)
    /* A76C4 800B6EC4 00000000 */  nop
    /* A76C8 800B6EC8 06004010 */  beqz       $v0, .L800B6EE4
    /* A76CC 800B6ECC 00000000 */   nop
    /* A76D0 800B6ED0 29E7010C */  jal        AudioCmn_UnPauseAndQuit__Fv
    /* A76D4 800B6ED4 100020AE */   sw        $zero, 0x10($s1)
    /* A76D8 800B6ED8 C7DB0208 */  j          .L800B6F1C
    /* A76DC 800B6EDC 00000000 */   nop
  .L800B6EE0:
    /* A76E0 800B6EE0 1000228E */  lw         $v0, 0x10($s1)
  .L800B6EE4:
    /* A76E4 800B6EE4 2C70C38F */  lw         $v1, %lo(Replay_ReplayInterface)($fp)
    /* A76E8 800B6EE8 00000000 */  nop
    /* A76EC 800B6EEC 0B004310 */  beq        $v0, $v1, .L800B6F1C
    /* A76F0 800B6EF0 00000000 */   nop
    /* A76F4 800B6EF4 07006010 */  beqz       $v1, .L800B6F14
    /* A76F8 800B6EF8 100023AE */   sw        $v1, 0x10($s1)
    /* A76FC 800B6EFC F60C020C */  jal        Camera_Update__Fv
    /* A7700 800B6F00 00000000 */   nop
    /* A7704 800B6F04 D8E6010C */  jal        AudioCmn_Pause__Fv
    /* A7708 800B6F08 00000000 */   nop
    /* A770C 800B6F0C C7DB0208 */  j          .L800B6F1C
    /* A7710 800B6F10 00000000 */   nop
  .L800B6F14:
    /* A7714 800B6F14 06E7010C */  jal        AudioCmn_UnPause__Fv
    /* A7718 800B6F18 00000000 */   nop
  .L800B6F1C:
    /* A771C 800B6F1C 0400228E */  lw         $v0, 0x4($s1)
    /* A7720 800B6F20 00000000 */  nop
    /* A7724 800B6F24 4A004014 */  bnez       $v0, .L800B7050
    /* A7728 800B6F28 00000000 */   nop
    /* A772C 800B6F2C 0800228E */  lw         $v0, 0x8($s1)
    /* A7730 800B6F30 00000000 */  nop
    /* A7734 800B6F34 06004010 */  beqz       $v0, .L800B6F50
    /* A7738 800B6F38 15000424 */   addiu     $a0, $zero, 0x15
    /* A773C 800B6F3C E7DA020C */  jal        Sim_ProcessPause__Fv
    /* A7740 800B6F40 00000000 */   nop
    /* A7744 800B6F44 18000224 */  addiu      $v0, $zero, 0x18
    /* A7748 800B6F48 14DC0208 */  j          .L800B7050
    /* A774C 800B6F4C 0C0022AE */   sw        $v0, 0xC($s1)
  .L800B6F50:
    /* A7750 800B6F50 C674020C */  jal        Input_Interface__FUli
    /* A7754 800B6F54 01000524 */   addiu     $a1, $zero, 0x1
    /* A7758 800B6F58 06004010 */  beqz       $v0, .L800B6F74
    /* A775C 800B6F5C 00000000 */   nop
    /* A7760 800B6F60 39E8010C */  jal        AudioMus_SwitchSong__Fv
    /* A7764 800B6F64 00000000 */   nop
    /* A7768 800B6F68 01000224 */  addiu      $v0, $zero, 0x1
    /* A776C 800B6F6C 1480013C */  lui        $at, %hi(Hud_ActivateCDPlayer)
    /* A7770 800B6F70 30D922AC */  sw         $v0, %lo(Hud_ActivateCDPlayer)($at)
  .L800B6F74:
    /* A7774 800B6F74 0C00248E */  lw         $a0, 0xC($s1)
    /* A7778 800B6F78 00000000 */  nop
    /* A777C 800B6F7C 07008010 */  beqz       $a0, .L800B6F9C
    /* A7780 800B6F80 21800000 */   addu      $s0, $zero, $zero
    /* A7784 800B6F84 C674020C */  jal        Input_Interface__FUli
    /* A7788 800B6F88 21280000 */   addu      $a1, $zero, $zero
    /* A778C 800B6F8C 30004014 */  bnez       $v0, .L800B7050
    /* A7790 800B6F90 00000000 */   nop
    /* A7794 800B6F94 14DC0208 */  j          .L800B7050
    /* A7798 800B6F98 0C0020AE */   sw        $zero, 0xC($s1)
  .L800B6F9C:
    /* A779C 800B6F9C 21100002 */  addu       $v0, $s0, $zero
    /* A77A0 800B6FA0 2B004014 */  bnez       $v0, .L800B7050
    /* A77A4 800B6FA4 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* A77A8 800B6FA8 EC315224 */  addiu      $s2, $v0, %lo(GameSetup_gData)
  .L800B6FAC:
    /* A77AC 800B6FAC 02000012 */  beqz       $s0, .L800B6FB8
    /* A77B0 800B6FB0 1A000424 */   addiu     $a0, $zero, 0x1A
    /* A77B4 800B6FB4 1B000424 */  addiu      $a0, $zero, 0x1B
  .L800B6FB8:
    /* A77B8 800B6FB8 C674020C */  jal        Input_Interface__FUli
    /* A77BC 800B6FBC 01000524 */   addiu     $a1, $zero, 0x1
    /* A77C0 800B6FC0 09004010 */  beqz       $v0, .L800B6FE8
    /* A77C4 800B6FC4 00000000 */   nop
    /* A77C8 800B6FC8 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* A77CC 800B6FCC F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* A77D0 800B6FD0 00000000 */  nop
    /* A77D4 800B6FD4 02004228 */  slti       $v0, $v0, 0x2
    /* A77D8 800B6FD8 03004010 */  beqz       $v0, .L800B6FE8
    /* A77DC 800B6FDC 00000000 */   nop
    /* A77E0 800B6FE0 0716020C */  jal        Camera_NextMode__Fi
    /* A77E4 800B6FE4 21200002 */   addu      $a0, $s0, $zero
  .L800B6FE8:
    /* A77E8 800B6FE8 02000012 */  beqz       $s0, .L800B6FF4
    /* A77EC 800B6FEC 1C000424 */   addiu     $a0, $zero, 0x1C
    /* A77F0 800B6FF0 1D000424 */  addiu      $a0, $zero, 0x1D
  .L800B6FF4:
    /* A77F4 800B6FF4 C674020C */  jal        Input_Interface__FUli
    /* A77F8 800B6FF8 01000524 */   addiu     $a1, $zero, 0x1
    /* A77FC 800B6FFC 04004010 */  beqz       $v0, .L800B7010
    /* A7800 800B7000 16000426 */   addiu     $a0, $s0, 0x16
    /* A7804 800B7004 1D6C020C */  jal        DashHUD_ToggleHud__Fi
    /* A7808 800B7008 21200002 */   addu      $a0, $s0, $zero
    /* A780C 800B700C 16000426 */  addiu      $a0, $s0, 0x16
  .L800B7010:
    /* A7810 800B7010 C674020C */  jal        Input_Interface__FUli
    /* A7814 800B7014 21280000 */   addu      $a1, $zero, $zero
    /* A7818 800B7018 01000424 */  addiu      $a0, $zero, 0x1
    /* A781C 800B701C 80281000 */  sll        $a1, $s0, 2
    /* A7820 800B7020 1480033C */  lui        $v1, %hi(Input_gLookBehind)
    /* A7824 800B7024 30D26324 */  addiu      $v1, $v1, %lo(Input_gLookBehind)
    /* A7828 800B7028 2128A300 */  addu       $a1, $a1, $v1
    /* A782C 800B702C 28DB020C */  jal        Sim_CheckForPause__Fi
    /* A7830 800B7030 0000A2AC */   sw        $v0, 0x0($a1)
    /* A7834 800B7034 0C00428E */  lw         $v0, 0xC($s2)
    /* A7838 800B7038 01001026 */  addiu      $s0, $s0, 0x1
    /* A783C 800B703C 01004238 */  xori       $v0, $v0, 0x1
    /* A7840 800B7040 0100422C */  sltiu      $v0, $v0, 0x1
    /* A7844 800B7044 2A105000 */  slt        $v0, $v0, $s0
    /* A7848 800B7048 D8FF4010 */  beqz       $v0, .L800B6FAC
    /* A784C 800B704C 00000000 */   nop
  .L800B7050:
    /* A7850 800B7050 0800628E */  lw         $v0, 0x8($s3)
    /* A7854 800B7054 00000000 */  nop
    /* A7858 800B7058 01004224 */  addiu      $v0, $v0, 0x1
    /* A785C 800B705C 8BDB0208 */  j          .L800B6E2C
    /* A7860 800B7060 080062AE */   sw        $v0, 0x8($s3)
  .L800B7064:
    /* A7864 800B7064 0800228E */  lw         $v0, 0x8($s1)
    /* A7868 800B7068 E00E80AF */  sw         $zero, %gp_rel(skipRender)($gp)
    /* A786C 800B706C 49004014 */  bnez       $v0, .L800B7194
    /* A7870 800B7070 00000000 */   nop
    /* A7874 800B7074 1000228E */  lw         $v0, 0x10($s1)
    /* A7878 800B7078 00000000 */  nop
    /* A787C 800B707C 45004014 */  bnez       $v0, .L800B7194
    /* A7880 800B7080 00000000 */   nop
    /* A7884 800B7084 0400228E */  lw         $v0, 0x4($s1)
    /* A7888 800B7088 00000000 */  nop
    /* A788C 800B708C 41004014 */  bnez       $v0, .L800B7194
    /* A7890 800B7090 00000000 */   nop
    /* A7894 800B7094 1800238E */  lw         $v1, 0x18($s1)
    /* A7898 800B7098 1400228E */  lw         $v0, 0x14($s1)
    /* A789C 800B709C 00000000 */  nop
    /* A78A0 800B70A0 2A104300 */  slt        $v0, $v0, $v1
    /* A78A4 800B70A4 04004010 */  beqz       $v0, .L800B70B8
    /* A78A8 800B70A8 01000224 */   addiu     $v0, $zero, 0x1
    /* A78AC 800B70AC E00E82AF */  sw         $v0, %gp_rel(skipRender)($gp)
    /* A78B0 800B70B0 67DC0208 */  j          .L800B719C
    /* A78B4 800B70B4 00000000 */   nop
  .L800B70B8:
    /* A78B8 800B70B8 01001024 */  addiu      $s0, $zero, 0x1
  .L800B70BC:
    /* A78BC 800B70BC 1800248E */  lw         $a0, 0x18($s1)
    /* A78C0 800B70C0 00000000 */  nop
    /* A78C4 800B70C4 01008230 */  andi       $v0, $a0, 0x1
    /* A78C8 800B70C8 03004014 */  bnez       $v0, .L800B70D8
    /* A78CC 800B70CC 00000000 */   nop
    /* A78D0 800B70D0 39DD020C */  jal        SimQueue_SetCurrentInput__Fi
    /* A78D4 800B70D4 43200400 */   sra       $a0, $a0, 1
  .L800B70D8:
    /* A78D8 800B70D8 1480033C */  lui        $v1, %hi(Replay_ReplayMode)
    /* A78DC 800B70DC F4D3638C */  lw         $v1, %lo(Replay_ReplayMode)($v1)
    /* A78E0 800B70E0 02000224 */  addiu      $v0, $zero, 0x2
    /* A78E4 800B70E4 C00E80AF */  sw         $zero, %gp_rel(InBetween)($gp)
    /* A78E8 800B70E8 20006214 */  bne        $v1, $v0, .L800B716C
    /* A78EC 800B70EC 00000000 */   nop
    /* A78F0 800B70F0 0400848E */  lw         $a0, 0x4($s4)
    /* A78F4 800B70F4 00000000 */  nop
    /* A78F8 800B70F8 1C008310 */  beq        $a0, $v1, .L800B716C
    /* A78FC 800B70FC 00000000 */   nop
    /* A7900 800B7100 06009014 */  bne        $a0, $s0, .L800B711C
    /* A7904 800B7104 00000000 */   nop
    /* A7908 800B7108 1800228E */  lw         $v0, 0x18($s1)
    /* A790C 800B710C 00000000 */  nop
    /* A7910 800B7110 01004230 */  andi       $v0, $v0, 0x1
    /* A7914 800B7114 15004010 */  beqz       $v0, .L800B716C
    /* A7918 800B7118 00000000 */   nop
  .L800B711C:
    /* A791C 800B711C 06008014 */  bnez       $a0, .L800B7138
    /* A7920 800B7120 00000000 */   nop
    /* A7924 800B7124 1800228E */  lw         $v0, 0x18($s1)
    /* A7928 800B7128 00000000 */  nop
    /* A792C 800B712C 03004230 */  andi       $v0, $v0, 0x3
    /* A7930 800B7130 0E004010 */  beqz       $v0, .L800B716C
    /* A7934 800B7134 00000000 */   nop
  .L800B7138:
    /* A7938 800B7138 0400838E */  lw         $v1, 0x4($s4)
    /* A793C 800B713C 03000224 */  addiu      $v0, $zero, 0x3
    /* A7940 800B7140 05006214 */  bne        $v1, $v0, .L800B7158
    /* A7944 800B7144 00000000 */   nop
    /* A7948 800B7148 1EDA020C */  jal        Sim_ProcessSimSchedules__Fv
    /* A794C 800B714C 00000000 */   nop
    /* A7950 800B7150 5BDC0208 */  j          .L800B716C
    /* A7954 800B7154 00000000 */   nop
  .L800B7158:
    /* A7958 800B7158 C00E90AF */  sw         $s0, %gp_rel(InBetween)($gp)
    /* A795C 800B715C F60C020C */  jal        Camera_Update__Fv
    /* A7960 800B7160 00000000 */   nop
    /* A7964 800B7164 5DDC0208 */  j          .L800B7174
    /* A7968 800B7168 00000000 */   nop
  .L800B716C:
    /* A796C 800B716C 1EDA020C */  jal        Sim_ProcessSimSchedules__Fv
    /* A7970 800B7170 00000000 */   nop
  .L800B7174:
    /* A7974 800B7174 1800228E */  lw         $v0, 0x18($s1)
    /* A7978 800B7178 1400238E */  lw         $v1, 0x14($s1)
    /* A797C 800B717C 01004224 */  addiu      $v0, $v0, 0x1
    /* A7980 800B7180 2A186200 */  slt        $v1, $v1, $v0
    /* A7984 800B7184 CDFF6010 */  beqz       $v1, .L800B70BC
    /* A7988 800B7188 180022AE */   sw        $v0, 0x18($s1)
    /* A798C 800B718C 67DC0208 */  j          .L800B719C
    /* A7990 800B7190 00000000 */   nop
  .L800B7194:
    /* A7994 800B7194 F60C020C */  jal        Camera_Update__Fv
    /* A7998 800B7198 00000000 */   nop
  .L800B719C:
    /* A799C 800B719C E00E828F */  lw         $v0, %gp_rel(skipRender)($gp)
    /* A79A0 800B71A0 00000000 */  nop
    /* A79A4 800B71A4 04004014 */  bnez       $v0, .L800B71B8
    /* A79A8 800B71A8 00000000 */   nop
    /* A79AC 800B71AC 0800248E */  lw         $a0, 0x8($s1)
    /* A79B0 800B71B0 2ACD020C */  jal        Render_Render__Fi
    /* A79B4 800B71B4 00000000 */   nop
  .L800B71B8:
    /* A79B8 800B71B8 EF74020C */  jal        Input_MainExitKey__Fv
    /* A79BC 800B71BC 00000000 */   nop
    /* A79C0 800B71C0 0B004014 */  bnez       $v0, .L800B71F0
    /* A79C4 800B71C4 01000224 */   addiu     $v0, $zero, 0x1
    /* A79C8 800B71C8 1480033C */  lui        $v1, %hi(Replay_ReplayMode)
    /* A79CC 800B71CC F4D3638C */  lw         $v1, %lo(Replay_ReplayMode)($v1)
    /* A79D0 800B71D0 03000224 */  addiu      $v0, $zero, 0x3
    /* A79D4 800B71D4 F8FE6214 */  bne        $v1, $v0, .L800B6DB8
    /* A79D8 800B71D8 00000000 */   nop
    /* A79DC 800B71DC 0400628E */  lw         $v0, 0x4($s3)
    /* A79E0 800B71E0 00000000 */  nop
    /* A79E4 800B71E4 41004228 */  slti       $v0, $v0, 0x41
    /* A79E8 800B71E8 F3FE4014 */  bnez       $v0, .L800B6DB8
    /* A79EC 800B71EC 01000224 */   addiu     $v0, $zero, 0x1
  .L800B71F0:
    /* A79F0 800B71F0 6EDB0208 */  j          .L800B6DB8
    /* A79F4 800B71F4 040022AE */   sw        $v0, 0x4($s1)
  .L800B71F8:
    /* A79F8 800B71F8 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* A79FC 800B71FC F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* A7A00 800B7200 00000000 */  nop
    /* A7A04 800B7204 02004228 */  slti       $v0, $v0, 0x2
    /* A7A08 800B7208 05004010 */  beqz       $v0, .L800B7220
    /* A7A0C 800B720C 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* A7A10 800B7210 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* A7A14 800B7214 B401438C */  lw         $v1, 0x1B4($v0)
    /* A7A18 800B7218 00000000 */  nop
    /* A7A1C 800B721C B80143AC */  sw         $v1, 0x1B8($v0)
  .L800B7220:
    /* A7A20 800B7220 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* A7A24 800B7224 3800BE8F */  lw         $fp, 0x38($sp)
    /* A7A28 800B7228 3400B78F */  lw         $s7, 0x34($sp)
    /* A7A2C 800B722C 3000B68F */  lw         $s6, 0x30($sp)
    /* A7A30 800B7230 2C00B58F */  lw         $s5, 0x2C($sp)
    /* A7A34 800B7234 2800B48F */  lw         $s4, 0x28($sp)
    /* A7A38 800B7238 2400B38F */  lw         $s3, 0x24($sp)
    /* A7A3C 800B723C 2000B28F */  lw         $s2, 0x20($sp)
    /* A7A40 800B7240 1C00B18F */  lw         $s1, 0x1C($sp)
    /* A7A44 800B7244 1800B08F */  lw         $s0, 0x18($sp)
    /* A7A48 800B7248 0800E003 */  jr         $ra
    /* A7A4C 800B724C 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Sim_MainGameLoop__Fv
