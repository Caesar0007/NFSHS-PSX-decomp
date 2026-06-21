.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching getasyncreadstatus, 0x98

glabel getasyncreadstatus
    /* E1ED8 800F16D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E1EDC 800F16DC 1400BFAF */  sw         $ra, 0x14($sp)
    /* E1EE0 800F16E0 FDC2030C */  jal        func_800F0BF4
    /* E1EE4 800F16E4 1000B0AF */   sw        $s0, 0x10($sp)
    /* E1EE8 800F16E8 21284000 */  addu       $a1, $v0, $zero
    /* E1EEC 800F16EC 1C00A010 */  beqz       $a1, .L800F1760
    /* E1EF0 800F16F0 FEFF0224 */   addiu     $v0, $zero, -0x2
    /* E1EF4 800F16F4 0C00A28C */  lw         $v0, 0xC($a1)
    /* E1EF8 800F16F8 00000000 */  nop
    /* E1EFC 800F16FC 18004014 */  bnez       $v0, .L800F1760
    /* E1F00 800F1700 FEFF0224 */   addiu     $v0, $zero, -0x2
    /* E1F04 800F1704 1800A28C */  lw         $v0, 0x18($a1)
    /* E1F08 800F1708 00000000 */  nop
    /* E1F0C 800F170C 14004014 */  bnez       $v0, .L800F1760
    /* E1F10 800F1710 21100000 */   addu      $v0, $zero, $zero
    /* E1F14 800F1714 0800B08C */  lw         $s0, 0x8($a1)
    /* E1F18 800F1718 00000000 */  nop
    /* E1F1C 800F171C 02000016 */  bnez       $s0, .L800F1728
    /* E1F20 800F1720 00000000 */   nop
    /* E1F24 800F1724 FFFF1024 */  addiu      $s0, $zero, -0x1
  .L800F1728:
    /* E1F28 800F1728 1000A28C */  lw         $v0, 0x10($a1)
    /* E1F2C 800F172C 00000000 */  nop
    /* E1F30 800F1730 0B004014 */  bnez       $v0, .L800F1760
    /* E1F34 800F1734 21100002 */   addu      $v0, $s0, $zero
    /* E1F38 800F1738 1400A28C */  lw         $v0, 0x14($a1)
    /* E1F3C 800F173C 00000000 */  nop
    /* E1F40 800F1740 07004014 */  bnez       $v0, .L800F1760
    /* E1F44 800F1744 21100002 */   addu      $v0, $s0, $zero
    /* E1F48 800F1748 0000A290 */  lbu        $v0, 0x0($a1)
    /* E1F4C 800F174C 1480043C */  lui        $a0, %hi(D_8013DEA0)
    /* E1F50 800F1750 A0DE8424 */  addiu      $a0, $a0, %lo(D_8013DEA0)
    /* E1F54 800F1754 C7C2030C */  jal        queueadd
    /* E1F58 800F1758 0000A2AC */   sw        $v0, 0x0($a1)
    /* E1F5C 800F175C 21100002 */  addu       $v0, $s0, $zero
  .L800F1760:
    /* E1F60 800F1760 1400BF8F */  lw         $ra, 0x14($sp)
    /* E1F64 800F1764 1000B08F */  lw         $s0, 0x10($sp)
    /* E1F68 800F1768 0800E003 */  jr         $ra
    /* E1F6C 800F176C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel getasyncreadstatus
