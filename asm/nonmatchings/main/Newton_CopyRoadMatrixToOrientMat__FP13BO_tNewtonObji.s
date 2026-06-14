.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji, 0xD4

glabel Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
    /* 91DF4 800A15F4 1200A014 */  bnez       $a1, .L800A1640
    /* 91DF8 800A15F8 44018324 */   addiu     $v1, $a0, 0x144
    /* 91DFC 800A15FC F0008524 */  addiu      $a1, $a0, 0xF0
    /* 91E00 800A1600 44018224 */  addiu      $v0, $a0, 0x144
    /* 91E04 800A1604 64018324 */  addiu      $v1, $a0, 0x164
  .L800A1608:
    /* 91E08 800A1608 0000468C */  lw         $a2, 0x0($v0)
    /* 91E0C 800A160C 0400478C */  lw         $a3, 0x4($v0)
    /* 91E10 800A1610 0800488C */  lw         $t0, 0x8($v0)
    /* 91E14 800A1614 0C00498C */  lw         $t1, 0xC($v0)
    /* 91E18 800A1618 0000A6AC */  sw         $a2, 0x0($a1)
    /* 91E1C 800A161C 0400A7AC */  sw         $a3, 0x4($a1)
    /* 91E20 800A1620 0800A8AC */  sw         $t0, 0x8($a1)
    /* 91E24 800A1624 0C00A9AC */  sw         $t1, 0xC($a1)
    /* 91E28 800A1628 10004224 */  addiu      $v0, $v0, 0x10
    /* 91E2C 800A162C F6FF4314 */  bne        $v0, $v1, .L800A1608
    /* 91E30 800A1630 1000A524 */   addiu     $a1, $a1, 0x10
    /* 91E34 800A1634 0000468C */  lw         $a2, 0x0($v0)
    /* 91E38 800A1638 0800E003 */  jr         $ra
    /* 91E3C 800A163C 0000A6AC */   sw        $a2, 0x0($a1)
  .L800A1640:
    /* 91E40 800A1640 4401828C */  lw         $v0, 0x144($a0)
    /* 91E44 800A1644 00000000 */  nop
    /* 91E48 800A1648 23100200 */  negu       $v0, $v0
    /* 91E4C 800A164C F00082AC */  sw         $v0, 0xF0($a0)
    /* 91E50 800A1650 0400628C */  lw         $v0, 0x4($v1)
    /* 91E54 800A1654 F0008424 */  addiu      $a0, $a0, 0xF0
    /* 91E58 800A1658 23100200 */  negu       $v0, $v0
    /* 91E5C 800A165C 040082AC */  sw         $v0, 0x4($a0)
    /* 91E60 800A1660 0800628C */  lw         $v0, 0x8($v1)
    /* 91E64 800A1664 00000000 */  nop
    /* 91E68 800A1668 23100200 */  negu       $v0, $v0
    /* 91E6C 800A166C 080082AC */  sw         $v0, 0x8($a0)
    /* 91E70 800A1670 0C00628C */  lw         $v0, 0xC($v1)
    /* 91E74 800A1674 00000000 */  nop
    /* 91E78 800A1678 0C0082AC */  sw         $v0, 0xC($a0)
    /* 91E7C 800A167C 1000628C */  lw         $v0, 0x10($v1)
    /* 91E80 800A1680 00000000 */  nop
    /* 91E84 800A1684 100082AC */  sw         $v0, 0x10($a0)
    /* 91E88 800A1688 1400628C */  lw         $v0, 0x14($v1)
    /* 91E8C 800A168C 00000000 */  nop
    /* 91E90 800A1690 140082AC */  sw         $v0, 0x14($a0)
    /* 91E94 800A1694 1800628C */  lw         $v0, 0x18($v1)
    /* 91E98 800A1698 00000000 */  nop
    /* 91E9C 800A169C 23100200 */  negu       $v0, $v0
    /* 91EA0 800A16A0 180082AC */  sw         $v0, 0x18($a0)
    /* 91EA4 800A16A4 1C00628C */  lw         $v0, 0x1C($v1)
    /* 91EA8 800A16A8 00000000 */  nop
    /* 91EAC 800A16AC 23100200 */  negu       $v0, $v0
    /* 91EB0 800A16B0 1C0082AC */  sw         $v0, 0x1C($a0)
    /* 91EB4 800A16B4 2000628C */  lw         $v0, 0x20($v1)
    /* 91EB8 800A16B8 00000000 */  nop
    /* 91EBC 800A16BC 23100200 */  negu       $v0, $v0
    /* 91EC0 800A16C0 0800E003 */  jr         $ra
    /* 91EC4 800A16C4 200082AC */   sw        $v0, 0x20($a0)
endlabel Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
