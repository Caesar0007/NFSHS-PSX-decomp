.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F0E54, 0xC4

glabel func_800F0E54
    /* E1654 800F0E54 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E1658 800F0E58 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* E165C 800F0E5C 2188C000 */  addu       $s1, $a2, $zero
    /* E1660 800F0E60 2000BFAF */  sw         $ra, 0x20($sp)
    /* E1664 800F0E64 1800B0AF */  sw         $s0, 0x18($sp)
    /* E1668 800F0E68 1800248E */  lw         $a0, 0x18($s1)
    /* E166C 800F0E6C ACB0030C */  jal        FILE_completeop
    /* E1670 800F0E70 21802002 */   addu      $s0, $s1, $zero
    /* E1674 800F0E74 0C00238E */  lw         $v1, 0xC($s1)
    /* E1678 800F0E78 00000000 */  nop
    /* E167C 800F0E7C 0A006010 */  beqz       $v1, .L800F0EA8
    /* E1680 800F0E80 63000524 */   addiu     $a1, $zero, 0x63
    /* E1684 800F0E84 1C00248E */  lw         $a0, 0x1C($s1)
    /* E1688 800F0E88 0BB1030C */  jal        FILE_close
    /* E168C 800F0E8C 21302002 */   addu      $a2, $s1, $zero
    /* E1690 800F0E90 1C004010 */  beqz       $v0, .L800F0F04
    /* E1694 800F0E94 180022AE */   sw        $v0, 0x18($s1)
    /* E1698 800F0E98 21204000 */  addu       $a0, $v0, $zero
    /* E169C 800F0E9C 0F80053C */  lui        $a1, %hi(func_800F0D24)
    /* E16A0 800F0EA0 BFC30308 */  j          .L800F0EFC
    /* E16A4 800F0EA4 240DA524 */   addiu     $a1, $a1, %lo(func_800F0D24)
  .L800F0EA8:
    /* E16A8 800F0EA8 0580043C */  lui        $a0, %hi(D_80056F24)
    /* E16AC 800F0EAC 246F8424 */  addiu      $a0, $a0, %lo(D_80056F24)
    /* E16B0 800F0EB0 2400068E */  lw         $a2, 0x24($s0)
    /* E16B4 800F0EB4 CF94030C */  jal        reservememadr
    /* E16B8 800F0EB8 21284000 */   addu      $a1, $v0, $zero
    /* E16BC 800F0EBC 100002AE */  sw         $v0, 0x10($s0)
    /* E16C0 800F0EC0 280002AE */  sw         $v0, 0x28($s0)
    /* E16C4 800F0EC4 63000224 */  addiu      $v0, $zero, 0x63
    /* E16C8 800F0EC8 1000A2AF */  sw         $v0, 0x10($sp)
    /* E16CC 800F0ECC 1400B0AF */  sw         $s0, 0x14($sp)
    /* E16D0 800F0ED0 1C00048E */  lw         $a0, 0x1C($s0)
    /* E16D4 800F0ED4 2000058E */  lw         $a1, 0x20($s0)
    /* E16D8 800F0ED8 4419878F */  lw         $a3, %gp_rel(D_8013DE90)($gp)
    /* E16DC 800F0EDC 2800068E */  lw         $a2, 0x28($s0)
    /* E16E0 800F0EE0 3BB1030C */  jal        FILE_read
    /* E16E4 800F0EE4 00000000 */   nop
    /* E16E8 800F0EE8 06004010 */  beqz       $v0, .L800F0F04
    /* E16EC 800F0EEC 180002AE */   sw        $v0, 0x18($s0)
    /* E16F0 800F0EF0 21204000 */  addu       $a0, $v0, $zero
    /* E16F4 800F0EF4 0F80053C */  lui        $a1, %hi(func_800F0D80)
    /* E16F8 800F0EF8 800DA524 */  addiu      $a1, $a1, %lo(func_800F0D80)
  .L800F0EFC:
    /* E16FC 800F0EFC 93AF030C */  jal        FILE_callbackop
    /* E1700 800F0F00 00000000 */   nop
  .L800F0F04:
    /* E1704 800F0F04 2000BF8F */  lw         $ra, 0x20($sp)
    /* E1708 800F0F08 1C00B18F */  lw         $s1, 0x1C($sp)
    /* E170C 800F0F0C 1800B08F */  lw         $s0, 0x18($sp)
    /* E1710 800F0F10 0800E003 */  jr         $ra
    /* E1714 800F0F14 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel func_800F0E54
