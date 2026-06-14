.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_SaveReplay__Fv, 0x8C

glabel Replay_SaveReplay__Fv
    /* A5798 800B4F98 A80E828F */  lw         $v0, %gp_rel(Replay_ReplayMode)($gp)
    /* A579C 800B4F9C 00000000 */  nop
    /* A57A0 800B4FA0 06004014 */  bnez       $v0, .L800B4FBC
    /* A57A4 800B4FA4 1180023C */   lui       $v0, %hi(Replay_ReplayBuffer)
    /* A57A8 800B4FA8 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* A57AC 800B4FAC B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* A57B0 800B4FB0 00000000 */  nop
    /* A57B4 800B4FB4 A00E82AF */  sw         $v0, %gp_rel(Replay_Size)($gp)
    /* A57B8 800B4FB8 1180023C */  lui        $v0, %hi(Replay_ReplayBuffer)
  .L800B4FBC:
    /* A57BC 800B4FBC 6C714324 */  addiu      $v1, $v0, %lo(Replay_ReplayBuffer)
    /* A57C0 800B4FC0 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A57C4 800B4FC4 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* A57C8 800B4FC8 200A4424 */  addiu      $a0, $v0, 0xA20
  .L800B4FCC:
    /* A57CC 800B4FCC 0000458C */  lw         $a1, 0x0($v0)
    /* A57D0 800B4FD0 0400468C */  lw         $a2, 0x4($v0)
    /* A57D4 800B4FD4 0800478C */  lw         $a3, 0x8($v0)
    /* A57D8 800B4FD8 0C00488C */  lw         $t0, 0xC($v0)
    /* A57DC 800B4FDC 000065AC */  sw         $a1, 0x0($v1)
    /* A57E0 800B4FE0 040066AC */  sw         $a2, 0x4($v1)
    /* A57E4 800B4FE4 080067AC */  sw         $a3, 0x8($v1)
    /* A57E8 800B4FE8 0C0068AC */  sw         $t0, 0xC($v1)
    /* A57EC 800B4FEC 10004224 */  addiu      $v0, $v0, 0x10
    /* A57F0 800B4FF0 F6FF4414 */  bne        $v0, $a0, .L800B4FCC
    /* A57F4 800B4FF4 10006324 */   addiu     $v1, $v1, 0x10
    /* A57F8 800B4FF8 0000458C */  lw         $a1, 0x0($v0)
    /* A57FC 800B4FFC 0400468C */  lw         $a2, 0x4($v0)
    /* A5800 800B5000 000065AC */  sw         $a1, 0x0($v1)
    /* A5804 800B5004 040066AC */  sw         $a2, 0x4($v1)
    /* A5808 800B5008 1180023C */  lui        $v0, %hi(Replay_ReplayBuffer)
    /* A580C 800B500C 6C714224 */  addiu      $v0, $v0, %lo(Replay_ReplayBuffer)
    /* A5810 800B5010 A00E848F */  lw         $a0, %gp_rel(Replay_Size)($gp)
    /* A5814 800B5014 02000324 */  addiu      $v1, $zero, 0x2
    /* A5818 800B5018 240043AC */  sw         $v1, 0x24($v0)
    /* A581C 800B501C 0800E003 */  jr         $ra
    /* A5820 800B5020 280A44AC */   sw        $a0, 0xA28($v0)
endlabel Replay_SaveReplay__Fv
