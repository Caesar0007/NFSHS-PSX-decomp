.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AddRecordToCollection__14AIDataRecord_t, 0x3C

glabel AddRecordToCollection__14AIDataRecord_t
    /* 5D6C4 8006CEC4 21280000 */  addu       $a1, $zero, $zero
    /* 5D6C8 8006CEC8 1480023C */  lui        $v0, %hi(D_8013DF64)
    /* 5D6CC 8006CECC 64DF4324 */  addiu      $v1, $v0, %lo(D_8013DF64)
  .L8006CED0:
    /* 5D6D0 8006CED0 0000628C */  lw         $v0, 0x0($v1)
    /* 5D6D4 8006CED4 00000000 */  nop
    /* 5D6D8 8006CED8 04004014 */  bnez       $v0, .L8006CEEC
    /* 5D6DC 8006CEDC 0100A524 */   addiu     $a1, $a1, 0x1
    /* 5D6E0 8006CEE0 000064AC */  sw         $a0, 0x0($v1)
    /* 5D6E4 8006CEE4 0800E003 */  jr         $ra
    /* 5D6E8 8006CEE8 01000224 */   addiu     $v0, $zero, 0x1
  .L8006CEEC:
    /* 5D6EC 8006CEEC 1800A228 */  slti       $v0, $a1, 0x18
    /* 5D6F0 8006CEF0 F7FF4014 */  bnez       $v0, .L8006CED0
    /* 5D6F4 8006CEF4 04006324 */   addiu     $v1, $v1, 0x4
    /* 5D6F8 8006CEF8 0800E003 */  jr         $ra
    /* 5D6FC 8006CEFC 21100000 */   addu      $v0, $zero, $zero
endlabel AddRecordToCollection__14AIDataRecord_t
