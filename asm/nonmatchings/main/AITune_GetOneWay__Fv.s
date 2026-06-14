.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AITune_GetOneWay__Fv, 0x58

glabel AITune_GetOneWay__Fv
    /* 63668 80072E68 1180023C */  lui        $v0, %hi(D_80113228)
    /* 6366C 80072E6C 2832448C */  lw         $a0, %lo(D_80113228)($v0)
    /* 63670 80072E70 00000000 */  nop
    /* 63674 80072E74 0C008228 */  slti       $v0, $a0, 0xC
    /* 63678 80072E78 09004014 */  bnez       $v0, .L80072EA0
    /* 6367C 80072E7C 1180033C */   lui       $v1, %hi(AITune_trackInfo)
    /* 63680 80072E80 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 63684 80072E84 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 63688 80072E88 00000000 */  nop
    /* 6368C 80072E8C 3D004290 */  lbu        $v0, 0x3D($v0)
    /* 63690 80072E90 00000000 */  nop
    /* 63694 80072E94 02110200 */  srl        $v0, $v0, 4
    /* 63698 80072E98 0800E003 */  jr         $ra
    /* 6369C 80072E9C 0100422C */   sltiu     $v0, $v0, 0x1
  .L80072EA0:
    /* 636A0 80072EA0 74DE6324 */  addiu      $v1, $v1, %lo(AITune_trackInfo)
    /* 636A4 80072EA4 40100400 */  sll        $v0, $a0, 1
    /* 636A8 80072EA8 21104400 */  addu       $v0, $v0, $a0
    /* 636AC 80072EAC 80100200 */  sll        $v0, $v0, 2
    /* 636B0 80072EB0 21104300 */  addu       $v0, $v0, $v1
    /* 636B4 80072EB4 0000428C */  lw         $v0, 0x0($v0)
    /* 636B8 80072EB8 0800E003 */  jr         $ra
    /* 636BC 80072EBC 00000000 */   nop
endlabel AITune_GetOneWay__Fv
