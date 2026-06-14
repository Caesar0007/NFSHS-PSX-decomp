.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_WingmanFlash__Fii, 0xB4

glabel Hud_WingmanFlash__Fii
    /* C67B8 800D5FB8 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* C67BC 800D5FBC F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* C67C0 800D5FC0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C67C4 800D5FC4 1400B1AF */  sw         $s1, 0x14($sp)
    /* C67C8 800D5FC8 21888000 */  addu       $s1, $a0, $zero
    /* C67CC 800D5FCC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C67D0 800D5FD0 2198A000 */  addu       $s3, $a1, $zero
    /* C67D4 800D5FD4 2000BFAF */  sw         $ra, 0x20($sp)
    /* C67D8 800D5FD8 1800B2AF */  sw         $s2, 0x18($sp)
    /* C67DC 800D5FDC 02004228 */  slti       $v0, $v0, 0x2
    /* C67E0 800D5FE0 1B004010 */  beqz       $v0, .L800D6050
    /* C67E4 800D5FE4 1000B0AF */   sw        $s0, 0x10($sp)
    /* C67E8 800D5FE8 DC13828F */  lw         $v0, %gp_rel(HudBustedOverlay)($gp)
    /* C67EC 800D5FEC 00000000 */  nop
    /* C67F0 800D5FF0 17004014 */  bnez       $v0, .L800D6050
    /* C67F4 800D5FF4 01001224 */   addiu     $s2, $zero, 0x1
    /* C67F8 800D5FF8 1480023C */  lui        $v0, %hi(Hud_gWingmanInterface)
    /* C67FC 800D5FFC B0D84224 */  addiu      $v0, $v0, %lo(Hud_gWingmanInterface)
    /* C6800 800D6000 21802202 */  addu       $s0, $s1, $v0
    /* C6804 800D6004 00000292 */  lbu        $v0, 0x0($s0)
    /* C6808 800D6008 00000000 */  nop
    /* C680C 800D600C 04005210 */  beq        $v0, $s2, .L800D6020
    /* C6810 800D6010 00000000 */   nop
    /* C6814 800D6014 D34A030C */  jal        Hud_InitMapFrame__Fii
    /* C6818 800D6018 21284002 */   addu      $a1, $s2, $zero
    /* C681C 800D601C 000012A2 */  sb         $s2, 0x0($s0)
  .L800D6020:
    /* C6820 800D6020 1480023C */  lui        $v0, %hi(Hud_gWingmanFlashIcon)
    /* C6824 800D6024 B4D84224 */  addiu      $v0, $v0, %lo(Hud_gWingmanFlashIcon)
    /* C6828 800D6028 21102202 */  addu       $v0, $s1, $v0
    /* C682C 800D602C 80181100 */  sll        $v1, $s1, 2
    /* C6830 800D6030 1480043C */  lui        $a0, %hi(Hud_gWingmanFlashTicks)
    /* C6834 800D6034 B8D88424 */  addiu      $a0, $a0, %lo(Hud_gWingmanFlashTicks)
    /* C6838 800D6038 000053A0 */  sb         $s3, 0x0($v0)
    /* C683C 800D603C 1480023C */  lui        $v0, %hi(ticks)
    /* C6840 800D6040 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* C6844 800D6044 21186400 */  addu       $v1, $v1, $a0
    /* C6848 800D6048 64004224 */  addiu      $v0, $v0, 0x64
    /* C684C 800D604C 000062AC */  sw         $v0, 0x0($v1)
  .L800D6050:
    /* C6850 800D6050 2000BF8F */  lw         $ra, 0x20($sp)
    /* C6854 800D6054 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C6858 800D6058 1800B28F */  lw         $s2, 0x18($sp)
    /* C685C 800D605C 1400B18F */  lw         $s1, 0x14($sp)
    /* C6860 800D6060 1000B08F */  lw         $s0, 0x10($sp)
    /* C6864 800D6064 0800E003 */  jr         $ra
    /* C6868 800D6068 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hud_WingmanFlash__Fii
