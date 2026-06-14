.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AITune_GetDriveSide__Fv, 0x40

glabel AITune_GetDriveSide__Fv
    /* 636C0 80072EC0 1180023C */  lui        $v0, %hi(D_80113228)
    /* 636C4 80072EC4 2832448C */  lw         $a0, %lo(D_80113228)($v0)
    /* 636C8 80072EC8 00000000 */  nop
    /* 636CC 80072ECC 0C008228 */  slti       $v0, $a0, 0xC
    /* 636D0 80072ED0 03004014 */  bnez       $v0, .L80072EE0
    /* 636D4 80072ED4 1180033C */   lui       $v1, %hi(AITune_trackInfo)
    /* 636D8 80072ED8 0800E003 */  jr         $ra
    /* 636DC 80072EDC 01000224 */   addiu     $v0, $zero, 0x1
  .L80072EE0:
    /* 636E0 80072EE0 74DE6324 */  addiu      $v1, $v1, %lo(AITune_trackInfo)
    /* 636E4 80072EE4 40100400 */  sll        $v0, $a0, 1
    /* 636E8 80072EE8 21104400 */  addu       $v0, $v0, $a0
    /* 636EC 80072EEC 80100200 */  sll        $v0, $v0, 2
    /* 636F0 80072EF0 21104300 */  addu       $v0, $v0, $v1
    /* 636F4 80072EF4 0400428C */  lw         $v0, 0x4($v0)
    /* 636F8 80072EF8 0800E003 */  jr         $ra
    /* 636FC 80072EFC 00000000 */   nop
endlabel AITune_GetDriveSide__Fv
