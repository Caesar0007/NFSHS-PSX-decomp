.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__23tScreenControllerConfig, 0x124

glabel Initialize__23tScreenControllerConfig
    /* 35EFC 800456FC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 35F00 80045700 1000B0AF */  sw         $s0, 0x10($sp)
    /* 35F04 80045704 21808000 */  addu       $s0, $a0, $zero
    /* 35F08 80045708 1400BFAF */  sw         $ra, 0x14($sp)
    /* 35F0C 8004570C 6B0C010C */  jal        TurnOffShakers__23tScreenControllerConfig
    /* 35F10 80045710 640000A2 */   sb        $zero, 0x64($s0)
    /* 35F14 80045714 460C010C */  jal        ClearActuators__23tScreenControllerConfig
    /* 35F18 80045718 21200002 */   addu      $a0, $s0, $zero
    /* 35F1C 8004571C 01000224 */  addiu      $v0, $zero, 0x1
    /* 35F20 80045720 700102AE */  sw         $v0, 0x170($s0)
    /* 35F24 80045724 0580023C */  lui        $v0, %hi(FEApp)
    /* 35F28 80045728 C014438C */  lw         $v1, %lo(FEApp)($v0)
    /* 35F2C 8004572C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 35F30 80045730 6C0102A6 */  sh         $v0, 0x16C($s0)
    /* 35F34 80045734 2D026390 */  lbu        $v1, 0x22D($v1)
    /* 35F38 80045738 21200002 */  addu       $a0, $s0, $zero
    /* 35F3C 8004573C 600100AE */  sw         $zero, 0x160($s0)
    /* 35F40 80045740 960002A6 */  sh         $v0, 0x96($s0)
    /* 35F44 80045744 980002A6 */  sh         $v0, 0x98($s0)
    /* 35F48 80045748 2B98000C */  jal        Initialize__7tScreen
    /* 35F4C 8004574C 780103AE */   sw        $v1, 0x178($s0)
    /* 35F50 80045750 0580023C */  lui        $v0, %hi(menuDefs)
    /* 35F54 80045754 01000524 */  addiu      $a1, $zero, 0x1
    /* 35F58 80045758 740100A2 */  sb         $zero, 0x174($s0)
    /* 35F5C 8004575C 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 35F60 80045760 21300000 */  addu       $a2, $zero, $zero
    /* 35F64 80045764 4A77000C */  jal        SetMenu__20tMenuItemSlidingMenubP14tInsideBoxMenu
    /* 35F68 80045768 282B8424 */   addiu     $a0, $a0, 0x2B28
    /* 35F6C 8004576C 21200002 */  addu       $a0, $s0, $zero
    /* 35F70 80045770 DE0D010C */  jal        SetCurrentController__23tScreenControllerConfigb
    /* 35F74 80045774 01000524 */   addiu     $a1, $zero, 0x1
    /* 35F78 80045778 BB0D010C */  jal        SwapInController__23tScreenControllerConfig
    /* 35F7C 8004577C 21200002 */   addu      $a0, $s0, $zero
    /* 35F80 80045780 A8000286 */  lh         $v0, 0xA8($s0)
    /* 35F84 80045784 74010392 */  lbu        $v1, 0x174($s0)
    /* 35F88 80045788 80004228 */  slti       $v0, $v0, 0x80
    /* 35F8C 8004578C 03004014 */  bnez       $v0, .L8004579C
    /* 35F90 80045790 6F0003A2 */   sb        $v1, 0x6F($s0)
    /* 35F94 80045794 21106000 */  addu       $v0, $v1, $zero
    /* 35F98 80045798 6E0002A2 */  sb         $v0, 0x6E($s0)
  .L8004579C:
    /* 35F9C 8004579C 6E000392 */  lbu        $v1, 0x6E($s0)
    /* 35FA0 800457A0 06000224 */  addiu      $v0, $zero, 0x6
    /* 35FA4 800457A4 04006214 */  bne        $v1, $v0, .L800457B8
    /* 35FA8 800457A8 1180023C */   lui       $v0, %hi(frontEnd)
    /* 35FAC 800457AC 05000224 */  addiu      $v0, $zero, 0x5
    /* 35FB0 800457B0 6E0002A2 */  sb         $v0, 0x6E($s0)
    /* 35FB4 800457B4 1180023C */  lui        $v0, %hi(frontEnd)
  .L800457B8:
    /* 35FB8 800457B8 7801038E */  lw         $v1, 0x178($s0)
    /* 35FBC 800457BC 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 35FC0 800457C0 21186200 */  addu       $v1, $v1, $v0
    /* 35FC4 800457C4 62036290 */  lbu        $v0, 0x362($v1)
    /* 35FC8 800457C8 21200002 */  addu       $a0, $s0, $zero
    /* 35FCC 800457CC 6C0002A2 */  sb         $v0, 0x6C($s0)
    /* 35FD0 800457D0 000D010C */  jal        CheckConfigs__23tScreenControllerConfig
    /* 35FD4 800457D4 6D0002A2 */   sb        $v0, 0x6D($s0)
    /* 35FD8 800457D8 80000224 */  addiu      $v0, $zero, 0x80
    /* 35FDC 800457DC 7C0000A6 */  sh         $zero, 0x7C($s0)
    /* 35FE0 800457E0 7E0000A6 */  sh         $zero, 0x7E($s0)
    /* 35FE4 800457E4 8C0000A6 */  sh         $zero, 0x8C($s0)
    /* 35FE8 800457E8 700000A6 */  sh         $zero, 0x70($s0)
    /* 35FEC 800457EC 720000A6 */  sh         $zero, 0x72($s0)
    /* 35FF0 800457F0 A80002A6 */  sh         $v0, 0xA8($s0)
    /* 35FF4 800457F4 AA0000A6 */  sh         $zero, 0xAA($s0)
    /* 35FF8 800457F8 AC0000A6 */  sh         $zero, 0xAC($s0)
    /* 35FFC 800457FC 680100AE */  sw         $zero, 0x168($s0)
    /* 36000 80045800 9C0000AE */  sw         $zero, 0x9C($s0)
    /* 36004 80045804 A00000AE */  sw         $zero, 0xA0($s0)
    /* 36008 80045808 A40000AE */  sw         $zero, 0xA4($s0)
    /* 3600C 8004580C 640100AE */  sw         $zero, 0x164($s0)
    /* 36010 80045810 1400BF8F */  lw         $ra, 0x14($sp)
    /* 36014 80045814 1000B08F */  lw         $s0, 0x10($sp)
    /* 36018 80045818 0800E003 */  jr         $ra
    /* 3601C 8004581C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Initialize__23tScreenControllerConfig
