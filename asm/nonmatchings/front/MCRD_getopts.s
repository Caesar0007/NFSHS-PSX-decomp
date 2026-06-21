.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MCRD_getopts, 0x78

glabel MCRD_getopts
    /* 3FD1C 8004F51C 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 3FD20 8004F520 682D438C */  lw         $v1, %lo(gMemCardInfo)($v0)
    /* 3FD24 8004F524 682D4224 */  addiu      $v0, $v0, %lo(gMemCardInfo)
    /* 3FD28 8004F528 040080AC */  sw         $zero, 0x4($a0)
    /* 3FD2C 8004F52C 000083AC */  sw         $v1, 0x0($a0)
    /* 3FD30 8004F530 2000438C */  lw         $v1, 0x20($v0)
    /* 3FD34 8004F534 00000000 */  nop
    /* 3FD38 8004F538 140083AC */  sw         $v1, 0x14($a0)
    /* 3FD3C 8004F53C 2400438C */  lw         $v1, 0x24($v0)
    /* 3FD40 8004F540 00000000 */  nop
    /* 3FD44 8004F544 180083AC */  sw         $v1, 0x18($a0)
    /* 3FD48 8004F548 2800438C */  lw         $v1, 0x28($v0)
    /* 3FD4C 8004F54C 00000000 */  nop
    /* 3FD50 8004F550 1C0083AC */  sw         $v1, 0x1C($a0)
    /* 3FD54 8004F554 2C00438C */  lw         $v1, 0x2C($v0)
    /* 3FD58 8004F558 00000000 */  nop
    /* 3FD5C 8004F55C 200083AC */  sw         $v1, 0x20($a0)
    /* 3FD60 8004F560 1400438C */  lw         $v1, 0x14($v0)
    /* 3FD64 8004F564 00000000 */  nop
    /* 3FD68 8004F568 080083AC */  sw         $v1, 0x8($a0)
    /* 3FD6C 8004F56C 1B004588 */  lwl        $a1, 0x1B($v0)
    /* 3FD70 8004F570 18004598 */  lwr        $a1, 0x18($v0)
    /* 3FD74 8004F574 1F004688 */  lwl        $a2, 0x1F($v0)
    /* 3FD78 8004F578 1C004698 */  lwr        $a2, 0x1C($v0)
    /* 3FD7C 8004F57C 0F0085A8 */  swl        $a1, 0xF($a0)
    /* 3FD80 8004F580 0C0085B8 */  swr        $a1, 0xC($a0)
    /* 3FD84 8004F584 130086A8 */  swl        $a2, 0x13($a0)
    /* 3FD88 8004F588 100086B8 */  swr        $a2, 0x10($a0)
    /* 3FD8C 8004F58C 0800E003 */  jr         $ra
    /* 3FD90 8004F590 00000000 */   nop
endlabel MCRD_getopts
