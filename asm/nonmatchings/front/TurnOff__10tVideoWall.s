.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TurnOff__10tVideoWall, 0x24

glabel TurnOff__10tVideoWall
    /* 27658 80036E58 14008284 */  lh         $v0, 0x14($a0)
    /* 2765C 80036E5C FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 27660 80036E60 04004310 */  beq        $v0, $v1, .L80036E74
    /* 27664 80036E64 1480023C */   lui       $v0, %hi(ticks)
    /* 27668 80036E68 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2766C 80036E6C 140083A4 */  sh         $v1, 0x14($a0)
    /* 27670 80036E70 100082AC */  sw         $v0, 0x10($a0)
  .L80036E74:
    /* 27674 80036E74 0800E003 */  jr         $ra
    /* 27678 80036E78 00000000 */   nop
endlabel TurnOff__10tVideoWall
