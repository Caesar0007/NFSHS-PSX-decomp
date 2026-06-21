.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SaveTracks__13tTrackManagerR14tSaveTrackInfo, 0x28

glabel SaveTracks__13tTrackManagerR14tSaveTrackInfo
    /* 1227C 80021A7C 21300000 */  addu       $a2, $zero, $zero
  .L80021A80:
    /* 12280 80021A80 08008390 */  lbu        $v1, 0x8($a0)
    /* 12284 80021A84 2110A600 */  addu       $v0, $a1, $a2
    /* 12288 80021A88 0100C624 */  addiu      $a2, $a2, 0x1
    /* 1228C 80021A8C 000043A0 */  sb         $v1, 0x0($v0)
    /* 12290 80021A90 1000C22C */  sltiu      $v0, $a2, 0x10
    /* 12294 80021A94 FAFF4014 */  bnez       $v0, .L80021A80
    /* 12298 80021A98 04008424 */   addiu     $a0, $a0, 0x4
    /* 1229C 80021A9C 0800E003 */  jr         $ra
    /* 122A0 80021AA0 00000000 */   nop
endlabel SaveTracks__13tTrackManagerR14tSaveTrackInfo
