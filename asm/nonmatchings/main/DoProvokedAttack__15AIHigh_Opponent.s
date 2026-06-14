.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DoProvokedAttack__15AIHigh_Opponent, 0xAC

glabel DoProvokedAttack__15AIHigh_Opponent
    /* 5432C 80063B2C 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 54330 80063B30 0000858C */  lw         $a1, 0x0($a0)
    /* 54334 80063B34 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 54338 80063B38 B801A38C */  lw         $v1, 0x1B8($a1)
    /* 5433C 80063B3C 00000000 */  nop
    /* 54340 80063B40 23104300 */  subu       $v0, $v0, $v1
    /* 54344 80063B44 0F004228 */  slti       $v0, $v0, 0xF
    /* 54348 80063B48 21004010 */  beqz       $v0, .L80063BD0
    /* 5434C 80063B4C 00000000 */   nop
    /* 54350 80063B50 B001A68C */  lw         $a2, 0x1B0($a1)
    /* 54354 80063B54 00000000 */  nop
    /* 54358 80063B58 1D00C010 */  beqz       $a2, .L80063BD0
    /* 5435C 80063B5C 00000000 */   nop
    /* 54360 80063B60 6002C28C */  lw         $v0, 0x260($a2)
    /* 54364 80063B64 00000000 */  nop
    /* 54368 80063B68 04004230 */  andi       $v0, $v0, 0x4
    /* 5436C 80063B6C 18004010 */  beqz       $v0, .L80063BD0
    /* 54370 80063B70 00000000 */   nop
    /* 54374 80063B74 B400828C */  lw         $v0, 0xB4($a0)
    /* 54378 80063B78 00000000 */  nop
    /* 5437C 80063B7C 03004610 */  beq        $v0, $a2, .L80063B8C
    /* 54380 80063B80 00000000 */   nop
    /* 54384 80063B84 B40086AC */  sw         $a2, 0xB4($a0)
    /* 54388 80063B88 B80080AC */  sw         $zero, 0xB8($a0)
  .L80063B8C:
    /* 5438C 80063B8C B800828C */  lw         $v0, 0xB8($a0)
    /* 54390 80063B90 0000838C */  lw         $v1, 0x0($a0)
    /* 54394 80063B94 01004224 */  addiu      $v0, $v0, 0x1
    /* 54398 80063B98 B80082AC */  sw         $v0, 0xB8($a0)
    /* 5439C 80063B9C F004658C */  lw         $a1, 0x4F0($v1)
    /* 543A0 80063BA0 00000000 */  nop
    /* 543A4 80063BA4 2400A38C */  lw         $v1, 0x24($a1)
    /* 543A8 80063BA8 00000000 */  nop
    /* 543AC 80063BAC 2A186200 */  slt        $v1, $v1, $v0
    /* 543B0 80063BB0 07006010 */  beqz       $v1, .L80063BD0
    /* 543B4 80063BB4 00000000 */   nop
    /* 543B8 80063BB8 2800A28C */  lw         $v0, 0x28($a1)
    /* 543BC 80063BBC B80080AC */  sw         $zero, 0xB8($a0)
    /* 543C0 80063BC0 BC0082AC */  sw         $v0, 0xBC($a0)
    /* 543C4 80063BC4 5402C28C */  lw         $v0, 0x254($a2)
    /* 543C8 80063BC8 0800E003 */  jr         $ra
    /* 543CC 80063BCC 00000000 */   nop
  .L80063BD0:
    /* 543D0 80063BD0 0800E003 */  jr         $ra
    /* 543D4 80063BD4 FFFF0224 */   addiu     $v0, $zero, -0x1
endlabel DoProvokedAttack__15AIHigh_Opponent
