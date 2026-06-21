.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TurnOn__10tVideoWall, 0x24

glabel TurnOn__10tVideoWall
    /* 276F8 80036EF8 14008284 */  lh         $v0, 0x14($a0)
    /* 276FC 80036EFC 01000324 */  addiu      $v1, $zero, 0x1
    /* 27700 80036F00 04004310 */  beq        $v0, $v1, .L80036F14
    /* 27704 80036F04 1480023C */   lui       $v0, %hi(ticks)
    /* 27708 80036F08 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2770C 80036F0C 140083A4 */  sh         $v1, 0x14($a0)
    /* 27710 80036F10 100082AC */  sw         $v0, 0x10($a0)
  .L80036F14:
    /* 27714 80036F14 0800E003 */  jr         $ra
    /* 27718 80036F18 00000000 */   nop
endlabel TurnOn__10tVideoWall
    /* 2771C 80036F1C 00000000 */  nop
