.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AITune_GetRoughLapTimes__Fv, 0x40

glabel AITune_GetRoughLapTimes__Fv
    /* 63700 80072F00 1180023C */  lui        $v0, %hi(D_80113228)
    /* 63704 80072F04 2832448C */  lw         $a0, %lo(D_80113228)($v0)
    /* 63708 80072F08 00000000 */  nop
    /* 6370C 80072F0C 0C008228 */  slti       $v0, $a0, 0xC
    /* 63710 80072F10 03004014 */  bnez       $v0, .L80072F20
    /* 63714 80072F14 1180033C */   lui       $v1, %hi(AITune_trackInfo)
    /* 63718 80072F18 0800E003 */  jr         $ra
    /* 6371C 80072F1C BE000224 */   addiu     $v0, $zero, 0xBE
  .L80072F20:
    /* 63720 80072F20 74DE6324 */  addiu      $v1, $v1, %lo(AITune_trackInfo)
    /* 63724 80072F24 40100400 */  sll        $v0, $a0, 1
    /* 63728 80072F28 21104400 */  addu       $v0, $v0, $a0
    /* 6372C 80072F2C 80100200 */  sll        $v0, $v0, 2
    /* 63730 80072F30 21104300 */  addu       $v0, $v0, $v1
    /* 63734 80072F34 0800428C */  lw         $v0, 0x8($v0)
    /* 63738 80072F38 0800E003 */  jr         $ra
    /* 6373C 80072F3C 00000000 */   nop
endlabel AITune_GetRoughLapTimes__Fv
