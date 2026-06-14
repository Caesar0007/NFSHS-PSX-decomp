.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RemoveRecordFromCollection__14AIDataRecord_t, 0x3C

glabel RemoveRecordFromCollection__14AIDataRecord_t
    /* 5D700 8006CF00 21280000 */  addu       $a1, $zero, $zero
    /* 5D704 8006CF04 1480023C */  lui        $v0, %hi(D_8013DF64)
    /* 5D708 8006CF08 64DF4324 */  addiu      $v1, $v0, %lo(D_8013DF64)
  .L8006CF0C:
    /* 5D70C 8006CF0C 0000628C */  lw         $v0, 0x0($v1)
    /* 5D710 8006CF10 00000000 */  nop
    /* 5D714 8006CF14 04004414 */  bne        $v0, $a0, .L8006CF28
    /* 5D718 8006CF18 0100A524 */   addiu     $a1, $a1, 0x1
    /* 5D71C 8006CF1C 000060AC */  sw         $zero, 0x0($v1)
    /* 5D720 8006CF20 0800E003 */  jr         $ra
    /* 5D724 8006CF24 01000224 */   addiu     $v0, $zero, 0x1
  .L8006CF28:
    /* 5D728 8006CF28 1800A228 */  slti       $v0, $a1, 0x18
    /* 5D72C 8006CF2C F7FF4014 */  bnez       $v0, .L8006CF0C
    /* 5D730 8006CF30 04006324 */   addiu     $v1, $v1, 0x4
    /* 5D734 8006CF34 0800E003 */  jr         $ra
    /* 5D738 8006CF38 21100000 */   addu      $v0, $zero, $zero
endlabel RemoveRecordFromCollection__14AIDataRecord_t
