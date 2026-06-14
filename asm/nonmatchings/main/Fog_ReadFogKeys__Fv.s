.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Fog_ReadFogKeys__Fv, 0x118

glabel Fog_ReadFogKeys__Fv
    /* D1714 800E0F14 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D1718 800E0F18 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* D171C 800E0F1C EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* D1720 800E0F20 2000BFAF */  sw         $ra, 0x20($sp)
    /* D1724 800E0F24 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D1728 800E0F28 1800B2AF */  sw         $s2, 0x18($sp)
    /* D172C 800E0F2C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D1730 800E0F30 1000B0AF */  sw         $s0, 0x10($sp)
    /* D1734 800E0F34 5400628C */  lw         $v0, 0x54($v1)
    /* D1738 800E0F38 00000000 */  nop
    /* D173C 800E0F3C 08004010 */  beqz       $v0, .L800E0F60
    /* D1740 800E0F40 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* D1744 800E0F44 4800628C */  lw         $v0, 0x48($v1)
    /* D1748 800E0F48 00000000 */  nop
    /* D174C 800E0F4C 03004010 */  beqz       $v0, .L800E0F5C
    /* D1750 800E0F50 1480043C */   lui       $a0, %hi(D_8013DB4C)
    /* D1754 800E0F54 E7830308 */  j          .L800E0F9C
    /* D1758 800E0F58 4CDB8424 */   addiu     $a0, $a0, %lo(D_8013DB4C)
  .L800E0F5C:
    /* D175C 800E0F5C 1180023C */  lui        $v0, %hi(GameSetup_gData)
  .L800E0F60:
    /* D1760 800E0F60 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* D1764 800E0F64 5400628C */  lw         $v0, 0x54($v1)
    /* D1768 800E0F68 00000000 */  nop
    /* D176C 800E0F6C 03004010 */  beqz       $v0, .L800E0F7C
    /* D1770 800E0F70 1480043C */   lui       $a0, %hi(D_8013DB54)
    /* D1774 800E0F74 E7830308 */  j          .L800E0F9C
    /* D1778 800E0F78 54DB8424 */   addiu     $a0, $a0, %lo(D_8013DB54)
  .L800E0F7C:
    /* D177C 800E0F7C 4800628C */  lw         $v0, 0x48($v1)
    /* D1780 800E0F80 00000000 */  nop
    /* D1784 800E0F84 03004010 */  beqz       $v0, .L800E0F94
    /* D1788 800E0F88 1480043C */   lui       $a0, %hi(D_8013DB5C)
    /* D178C 800E0F8C E7830308 */  j          .L800E0F9C
    /* D1790 800E0F90 5CDB8424 */   addiu     $a0, $a0, %lo(D_8013DB5C)
  .L800E0F94:
    /* D1794 800E0F94 1480043C */  lui        $a0, %hi(D_8013DB64)
    /* D1798 800E0F98 64DB8424 */  addiu      $a0, $a0, %lo(D_8013DB64)
  .L800E0F9C:
    /* D179C 800E0F9C B183030C */  jal        Fog_MakeTrackPathName__FPc
    /* D17A0 800E0FA0 00000000 */   nop
    /* D17A4 800E0FA4 21204000 */  addu       $a0, $v0, $zero
    /* D17A8 800E0FA8 FA95030C */  jal        loadfileadr
    /* D17AC 800E0FAC 21280000 */   addu      $a1, $zero, $zero
    /* D17B0 800E0FB0 21904000 */  addu       $s2, $v0, $zero
    /* D17B4 800E0FB4 16004012 */  beqz       $s2, .L800E1010
    /* D17B8 800E0FB8 21100000 */   addu      $v0, $zero, $zero
    /* D17BC 800E0FBC 0000538E */  lw         $s3, 0x0($s2)
    /* D17C0 800E0FC0 00000000 */  nop
    /* D17C4 800E0FC4 2000622E */  sltiu      $v0, $s3, 0x20
    /* D17C8 800E0FC8 03004014 */  bnez       $v0, .L800E0FD8
    /* D17CC 800E0FCC 21880000 */   addu      $s1, $zero, $zero
    /* D17D0 800E0FD0 04840308 */  j          .L800E1010
    /* D17D4 800E0FD4 21100000 */   addu      $v0, $zero, $zero
  .L800E0FD8:
    /* D17D8 800E0FD8 21804002 */  addu       $s0, $s2, $zero
    /* D17DC 800E0FDC 2A103302 */  slt        $v0, $s1, $s3
  .L800E0FE0:
    /* D17E0 800E0FE0 08004010 */  beqz       $v0, .L800E1004
    /* D17E4 800E0FE4 00000000 */   nop
    /* D17E8 800E0FE8 0400048E */  lw         $a0, 0x4($s0)
    /* D17EC 800E0FEC 0800058E */  lw         $a1, 0x8($s0)
    /* D17F0 800E0FF0 08001026 */  addiu      $s0, $s0, 0x8
    /* D17F4 800E0FF4 3383030C */  jal        Fog_AddKey__Fii
    /* D17F8 800E0FF8 01003126 */   addiu     $s1, $s1, 0x1
    /* D17FC 800E0FFC F8830308 */  j          .L800E0FE0
    /* D1800 800E1000 2A103302 */   slt       $v0, $s1, $s3
  .L800E1004:
    /* D1804 800E1004 5095030C */  jal        purgememadr
    /* D1808 800E1008 21204002 */   addu      $a0, $s2, $zero
    /* D180C 800E100C 01000224 */  addiu      $v0, $zero, 0x1
  .L800E1010:
    /* D1810 800E1010 2000BF8F */  lw         $ra, 0x20($sp)
    /* D1814 800E1014 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D1818 800E1018 1800B28F */  lw         $s2, 0x18($sp)
    /* D181C 800E101C 1400B18F */  lw         $s1, 0x14($sp)
    /* D1820 800E1020 1000B08F */  lw         $s0, 0x10($sp)
    /* D1824 800E1024 0800E003 */  jr         $ra
    /* D1828 800E1028 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Fog_ReadFogKeys__Fv
