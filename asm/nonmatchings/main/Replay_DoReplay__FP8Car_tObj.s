.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_DoReplay__FP8Car_tObj, 0x44

glabel Replay_DoReplay__FP8Car_tObj
    /* A582C 800B502C A80E828F */  lw         $v0, %gp_rel(Replay_ReplayMode)($gp)
    /* A5830 800B5030 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A5834 800B5034 0200422C */  sltiu      $v0, $v0, 0x2
    /* A5838 800B5038 06004010 */  beqz       $v0, .L800B5054
    /* A583C 800B503C 1000BFAF */   sw        $ra, 0x10($sp)
    /* A5840 800B5040 5802848C */  lw         $a0, 0x258($a0)
    /* A5844 800B5044 09D2020C */  jal        Replay_SaveInput__Fi
    /* A5848 800B5048 00000000 */   nop
    /* A584C 800B504C 18D40208 */  j          .L800B5060
    /* A5850 800B5050 00000000 */   nop
  .L800B5054:
    /* A5854 800B5054 5802848C */  lw         $a0, 0x258($a0)
    /* A5858 800B5058 CED2020C */  jal        Replay_GetInput__Fi
    /* A585C 800B505C 00000000 */   nop
  .L800B5060:
    /* A5860 800B5060 1000BF8F */  lw         $ra, 0x10($sp)
    /* A5864 800B5064 00000000 */  nop
    /* A5868 800B5068 0800E003 */  jr         $ra
    /* A586C 800B506C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Replay_DoReplay__FP8Car_tObj
