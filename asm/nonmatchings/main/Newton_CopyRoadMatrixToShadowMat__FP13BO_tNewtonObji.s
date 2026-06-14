.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji, 0xD4

glabel Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji
    /* 91EC8 800A16C8 1200A014 */  bnez       $a1, .L800A1714
    /* 91ECC 800A16CC 44018324 */   addiu     $v1, $a0, 0x144
    /* 91ED0 800A16D0 C4018524 */  addiu      $a1, $a0, 0x1C4
    /* 91ED4 800A16D4 44018224 */  addiu      $v0, $a0, 0x144
    /* 91ED8 800A16D8 64018324 */  addiu      $v1, $a0, 0x164
  .L800A16DC:
    /* 91EDC 800A16DC 0000468C */  lw         $a2, 0x0($v0)
    /* 91EE0 800A16E0 0400478C */  lw         $a3, 0x4($v0)
    /* 91EE4 800A16E4 0800488C */  lw         $t0, 0x8($v0)
    /* 91EE8 800A16E8 0C00498C */  lw         $t1, 0xC($v0)
    /* 91EEC 800A16EC 0000A6AC */  sw         $a2, 0x0($a1)
    /* 91EF0 800A16F0 0400A7AC */  sw         $a3, 0x4($a1)
    /* 91EF4 800A16F4 0800A8AC */  sw         $t0, 0x8($a1)
    /* 91EF8 800A16F8 0C00A9AC */  sw         $t1, 0xC($a1)
    /* 91EFC 800A16FC 10004224 */  addiu      $v0, $v0, 0x10
    /* 91F00 800A1700 F6FF4314 */  bne        $v0, $v1, .L800A16DC
    /* 91F04 800A1704 1000A524 */   addiu     $a1, $a1, 0x10
    /* 91F08 800A1708 0000468C */  lw         $a2, 0x0($v0)
    /* 91F0C 800A170C 0800E003 */  jr         $ra
    /* 91F10 800A1710 0000A6AC */   sw        $a2, 0x0($a1)
  .L800A1714:
    /* 91F14 800A1714 4401828C */  lw         $v0, 0x144($a0)
    /* 91F18 800A1718 00000000 */  nop
    /* 91F1C 800A171C 23100200 */  negu       $v0, $v0
    /* 91F20 800A1720 C40182AC */  sw         $v0, 0x1C4($a0)
    /* 91F24 800A1724 0400628C */  lw         $v0, 0x4($v1)
    /* 91F28 800A1728 C4018424 */  addiu      $a0, $a0, 0x1C4
    /* 91F2C 800A172C 23100200 */  negu       $v0, $v0
    /* 91F30 800A1730 040082AC */  sw         $v0, 0x4($a0)
    /* 91F34 800A1734 0800628C */  lw         $v0, 0x8($v1)
    /* 91F38 800A1738 00000000 */  nop
    /* 91F3C 800A173C 23100200 */  negu       $v0, $v0
    /* 91F40 800A1740 080082AC */  sw         $v0, 0x8($a0)
    /* 91F44 800A1744 0C00628C */  lw         $v0, 0xC($v1)
    /* 91F48 800A1748 00000000 */  nop
    /* 91F4C 800A174C 0C0082AC */  sw         $v0, 0xC($a0)
    /* 91F50 800A1750 1000628C */  lw         $v0, 0x10($v1)
    /* 91F54 800A1754 00000000 */  nop
    /* 91F58 800A1758 100082AC */  sw         $v0, 0x10($a0)
    /* 91F5C 800A175C 1400628C */  lw         $v0, 0x14($v1)
    /* 91F60 800A1760 00000000 */  nop
    /* 91F64 800A1764 140082AC */  sw         $v0, 0x14($a0)
    /* 91F68 800A1768 1800628C */  lw         $v0, 0x18($v1)
    /* 91F6C 800A176C 00000000 */  nop
    /* 91F70 800A1770 23100200 */  negu       $v0, $v0
    /* 91F74 800A1774 180082AC */  sw         $v0, 0x18($a0)
    /* 91F78 800A1778 1C00628C */  lw         $v0, 0x1C($v1)
    /* 91F7C 800A177C 00000000 */  nop
    /* 91F80 800A1780 23100200 */  negu       $v0, $v0
    /* 91F84 800A1784 1C0082AC */  sw         $v0, 0x1C($a0)
    /* 91F88 800A1788 2000628C */  lw         $v0, 0x20($v1)
    /* 91F8C 800A178C 00000000 */  nop
    /* 91F90 800A1790 23100200 */  negu       $v0, $v0
    /* 91F94 800A1794 0800E003 */  jr         $ra
    /* 91F98 800A1798 200082AC */   sw        $v0, 0x20($a0)
endlabel Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji
