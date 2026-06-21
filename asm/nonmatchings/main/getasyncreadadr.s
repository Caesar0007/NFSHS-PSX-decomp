.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching getasyncreadadr, 0x98

glabel getasyncreadadr
    /* E1E40 800F1640 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E1E44 800F1644 1400BFAF */  sw         $ra, 0x14($sp)
    /* E1E48 800F1648 FDC2030C */  jal        func_800F0BF4
    /* E1E4C 800F164C 1000B0AF */   sw        $s0, 0x10($sp)
    /* E1E50 800F1650 21284000 */  addu       $a1, $v0, $zero
    /* E1E54 800F1654 1C00A010 */  beqz       $a1, .L800F16C8
    /* E1E58 800F1658 21100000 */   addu      $v0, $zero, $zero
    /* E1E5C 800F165C 0C00A28C */  lw         $v0, 0xC($a1)
    /* E1E60 800F1660 00000000 */  nop
    /* E1E64 800F1664 18004014 */  bnez       $v0, .L800F16C8
    /* E1E68 800F1668 21100000 */   addu      $v0, $zero, $zero
    /* E1E6C 800F166C 1800A28C */  lw         $v0, 0x18($a1)
    /* E1E70 800F1670 00000000 */  nop
    /* E1E74 800F1674 14004014 */  bnez       $v0, .L800F16C8
    /* E1E78 800F1678 21100000 */   addu      $v0, $zero, $zero
    /* E1E7C 800F167C 1000B08C */  lw         $s0, 0x10($a1)
    /* E1E80 800F1680 01000224 */  addiu      $v0, $zero, 0x1
    /* E1E84 800F1684 02000216 */  bne        $s0, $v0, .L800F1690
    /* E1E88 800F1688 00000000 */   nop
    /* E1E8C 800F168C 21800000 */  addu       $s0, $zero, $zero
  .L800F1690:
    /* E1E90 800F1690 1000A28C */  lw         $v0, 0x10($a1)
    /* E1E94 800F1694 00000000 */  nop
    /* E1E98 800F1698 0B004010 */  beqz       $v0, .L800F16C8
    /* E1E9C 800F169C 21100002 */   addu      $v0, $s0, $zero
    /* E1EA0 800F16A0 1400A28C */  lw         $v0, 0x14($a1)
    /* E1EA4 800F16A4 00000000 */  nop
    /* E1EA8 800F16A8 07004014 */  bnez       $v0, .L800F16C8
    /* E1EAC 800F16AC 21100002 */   addu      $v0, $s0, $zero
    /* E1EB0 800F16B0 0000A290 */  lbu        $v0, 0x0($a1)
    /* E1EB4 800F16B4 1480043C */  lui        $a0, %hi(D_8013DEA0)
    /* E1EB8 800F16B8 A0DE8424 */  addiu      $a0, $a0, %lo(D_8013DEA0)
    /* E1EBC 800F16BC C7C2030C */  jal        queueadd
    /* E1EC0 800F16C0 0000A2AC */   sw        $v0, 0x0($a1)
    /* E1EC4 800F16C4 21100002 */  addu       $v0, $s0, $zero
  .L800F16C8:
    /* E1EC8 800F16C8 1400BF8F */  lw         $ra, 0x14($sp)
    /* E1ECC 800F16CC 1000B08F */  lw         $s0, 0x10($sp)
    /* E1ED0 800F16D0 0800E003 */  jr         $ra
    /* E1ED4 800F16D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel getasyncreadadr
