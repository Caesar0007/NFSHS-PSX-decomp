.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadTracks__13tTrackManagerR14tSaveTrackInfo, 0x2C

glabel LoadTracks__13tTrackManagerR14tSaveTrackInfo
    /* 12250 80021A50 21180000 */  addu       $v1, $zero, $zero
  .L80021A54:
    /* 12254 80021A54 2110A300 */  addu       $v0, $a1, $v1
    /* 12258 80021A58 00004290 */  lbu        $v0, 0x0($v0)
    /* 1225C 80021A5C 01006324 */  addiu      $v1, $v1, 0x1
    /* 12260 80021A60 2B100200 */  sltu       $v0, $zero, $v0
    /* 12264 80021A64 080082AC */  sw         $v0, 0x8($a0)
    /* 12268 80021A68 1000622C */  sltiu      $v0, $v1, 0x10
    /* 1226C 80021A6C F9FF4014 */  bnez       $v0, .L80021A54
    /* 12270 80021A70 04008424 */   addiu     $a0, $a0, 0x4
    /* 12274 80021A74 0800E003 */  jr         $ra
    /* 12278 80021A78 00000000 */   nop
endlabel LoadTracks__13tTrackManagerR14tSaveTrackInfo
