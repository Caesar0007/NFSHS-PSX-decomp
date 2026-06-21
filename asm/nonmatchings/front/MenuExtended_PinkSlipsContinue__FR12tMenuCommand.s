.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_PinkSlipsContinue__FR12tMenuCommand, 0x6C

glabel MenuExtended_PinkSlipsContinue__FR12tMenuCommand
    /* 1EB4C 8002E34C 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1EB50 8002E350 00464624 */  addiu      $a2, $v0, %lo(frontEnd)
    /* 1EB54 8002E354 4700C290 */  lbu        $v0, 0x47($a2)
    /* 1EB58 8002E358 4800C390 */  lbu        $v1, 0x48($a2)
    /* 1EB5C 8002E35C 42100200 */  srl        $v0, $v0, 1
    /* 1EB60 8002E360 01004524 */  addiu      $a1, $v0, 0x1
    /* 1EB64 8002E364 2A186500 */  slt        $v1, $v1, $a1
    /* 1EB68 8002E368 06006010 */  beqz       $v1, .L8002E384
    /* 1EB6C 8002E36C 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1EB70 8002E370 4900C290 */  lbu        $v0, 0x49($a2)
    /* 1EB74 8002E374 00000000 */  nop
    /* 1EB78 8002E378 2A104500 */  slt        $v0, $v0, $a1
    /* 1EB7C 8002E37C 07004014 */  bnez       $v0, .L8002E39C
    /* 1EB80 8002E380 0580023C */   lui       $v0, %hi(menuDefs)
  .L8002E384:
    /* 1EB84 8002E384 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1EB88 8002E388 02000324 */  addiu      $v1, $zero, 0x2
    /* 1EB8C 8002E38C 000083AC */  sw         $v1, 0x0($a0)
    /* 1EB90 8002E390 7C384224 */  addiu      $v0, $v0, 0x387C
    /* 1EB94 8002E394 0800E003 */  jr         $ra
    /* 1EB98 8002E398 040082AC */   sw        $v0, 0x4($a0)
  .L8002E39C:
    /* 1EB9C 8002E39C 4600C290 */  lbu        $v0, 0x46($a2)
    /* 1EBA0 8002E3A0 00000000 */  nop
    /* 1EBA4 8002E3A4 01004224 */  addiu      $v0, $v0, 0x1
    /* 1EBA8 8002E3A8 4600C2A0 */  sb         $v0, 0x46($a2)
    /* 1EBAC 8002E3AC 05000224 */  addiu      $v0, $zero, 0x5
    /* 1EBB0 8002E3B0 0800E003 */  jr         $ra
    /* 1EBB4 8002E3B4 000082AC */   sw        $v0, 0x0($a0)
endlabel MenuExtended_PinkSlipsContinue__FR12tMenuCommand
