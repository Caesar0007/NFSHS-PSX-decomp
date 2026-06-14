.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DashHUD_ResetHUD__Fv, 0x64

glabel DashHUD_ResetHUD__Fv
    /* 8B810 8009B010 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* 8B814 8009B014 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* 8B818 8009B018 00000000 */  nop
    /* 8B81C 8009B01C 02004228 */  slti       $v0, $v0, 0x2
    /* 8B820 8009B020 05004010 */  beqz       $v0, .L8009B038
    /* 8B824 8009B024 1180023C */   lui       $v0, %hi(D_801132D4)
    /* 8B828 8009B028 D432438C */  lw         $v1, %lo(D_801132D4)($v0)
    /* 8B82C 8009B02C 1180023C */  lui        $v0, %hi(D_8011278C)
    /* 8B830 8009B030 106C0208 */  j          .L8009B040
    /* 8B834 8009B034 8C2743AC */   sw        $v1, %lo(D_8011278C)($v0)
  .L8009B038:
    /* 8B838 8009B038 1180023C */  lui        $v0, %hi(D_8011278C)
    /* 8B83C 8009B03C 8C2740AC */  sw         $zero, %lo(D_8011278C)($v0)
  .L8009B040:
    /* 8B840 8009B040 1180033C */  lui        $v1, %hi(DashHUD_gInfo)
    /* 8B844 8009B044 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* 8B848 8009B048 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* 8B84C 8009B04C 30276324 */  addiu      $v1, $v1, %lo(DashHUD_gInfo)
    /* 8B850 8009B050 640060AC */  sw         $zero, 0x64($v1)
    /* 8B854 8009B054 02004228 */  slti       $v0, $v0, 0x2
    /* 8B858 8009B058 04004010 */  beqz       $v0, .L8009B06C
    /* 8B85C 8009B05C 680060AC */   sw        $zero, 0x68($v1)
    /* 8B860 8009B060 01000224 */  addiu      $v0, $zero, 0x1
    /* 8B864 8009B064 1C0062AC */  sw         $v0, 0x1C($v1)
    /* 8B868 8009B068 200062AC */  sw         $v0, 0x20($v1)
  .L8009B06C:
    /* 8B86C 8009B06C 0800E003 */  jr         $ra
    /* 8B870 8009B070 00000000 */   nop
endlabel DashHUD_ResetHUD__Fv
