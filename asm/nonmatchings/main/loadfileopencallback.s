.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadfileopencallback, 0x10C

glabel loadfileopencallback
    /* E1718 800F0F18 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E171C 800F0F1C 1800B0AF */  sw         $s0, 0x18($sp)
    /* E1720 800F0F20 2180C000 */  addu       $s0, $a2, $zero
    /* E1724 800F0F24 2000BFAF */  sw         $ra, 0x20($sp)
    /* E1728 800F0F28 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* E172C 800F0F2C 1800048E */  lw         $a0, 0x18($s0)
    /* E1730 800F0F30 ACB0030C */  jal        FILE_completeop
    /* E1734 800F0F34 21880002 */   addu      $s1, $s0, $zero
    /* E1738 800F0F38 21204000 */  addu       $a0, $v0, $zero
    /* E173C 800F0F3C 0D008014 */  bnez       $a0, .L800F0F74
    /* E1740 800F0F40 1C0004AE */   sw        $a0, 0x1C($s0)
    /* E1744 800F0F44 0C00028E */  lw         $v0, 0xC($s0)
    /* E1748 800F0F48 00000000 */  nop
    /* E174C 800F0F4C 05004010 */  beqz       $v0, .L800F0F64
    /* E1750 800F0F50 00000000 */   nop
    /* E1754 800F0F54 14C3030C */  jal        cancelrequest
    /* E1758 800F0F58 21200002 */   addu      $a0, $s0, $zero
    /* E175C 800F0F5C 04C40308 */  j          .L800F1010
    /* E1760 800F0F60 00000000 */   nop
  .L800F0F64:
    /* E1764 800F0F64 3AC3030C */  jal        finishrequest
    /* E1768 800F0F68 21200002 */   addu      $a0, $s0, $zero
    /* E176C 800F0F6C 04C40308 */  j          .L800F1010
    /* E1770 800F0F70 00000000 */   nop
  .L800F0F74:
    /* E1774 800F0F74 0C00028E */  lw         $v0, 0xC($s0)
    /* E1778 800F0F78 00000000 */  nop
    /* E177C 800F0F7C 09004010 */  beqz       $v0, .L800F0FA4
    /* E1780 800F0F80 63000524 */   addiu     $a1, $zero, 0x63
    /* E1784 800F0F84 0BB1030C */  jal        FILE_close
    /* E1788 800F0F88 21300002 */   addu      $a2, $s0, $zero
    /* E178C 800F0F8C 20004010 */  beqz       $v0, .L800F1010
    /* E1790 800F0F90 180002AE */   sw        $v0, 0x18($s0)
    /* E1794 800F0F94 21204000 */  addu       $a0, $v0, $zero
    /* E1798 800F0F98 0F80053C */  lui        $a1, %hi(loadfileclosecallback)
    /* E179C 800F0F9C 02C40308 */  j          .L800F1008
    /* E17A0 800F0FA0 240DA524 */   addiu     $a1, $a1, %lo(loadfileclosecallback)
  .L800F0FA4:
    /* E17A4 800F0FA4 1000028E */  lw         $v0, 0x10($s0)
    /* E17A8 800F0FA8 00000000 */  nop
    /* E17AC 800F0FAC 0F004014 */  bnez       $v0, .L800F0FEC
    /* E17B0 800F0FB0 63000224 */   addiu     $v0, $zero, 0x63
    /* E17B4 800F0FB4 1000A2AF */  sw         $v0, 0x10($sp)
    /* E17B8 800F0FB8 1400B0AF */  sw         $s0, 0x14($sp)
    /* E17BC 800F0FBC 1C00048E */  lw         $a0, 0x1C($s0)
    /* E17C0 800F0FC0 2000058E */  lw         $a1, 0x20($s0)
    /* E17C4 800F0FC4 4419878F */  lw         $a3, %gp_rel(D_8013DE90)($gp)
    /* E17C8 800F0FC8 2800068E */  lw         $a2, 0x28($s0)
    /* E17CC 800F0FCC 3BB1030C */  jal        FILE_read
    /* E17D0 800F0FD0 00000000 */   nop
    /* E17D4 800F0FD4 0E004010 */  beqz       $v0, .L800F1010
    /* E17D8 800F0FD8 180002AE */   sw        $v0, 0x18($s0)
    /* E17DC 800F0FDC 21204000 */  addu       $a0, $v0, $zero
    /* E17E0 800F0FE0 0F80053C */  lui        $a1, %hi(loadfilereadcallback)
    /* E17E4 800F0FE4 02C40308 */  j          .L800F1008
    /* E17E8 800F0FE8 800DA524 */   addiu     $a1, $a1, %lo(loadfilereadcallback)
  .L800F0FEC:
    /* E17EC 800F0FEC 74B1030C */  jal        FILE_size
    /* E17F0 800F0FF0 21302002 */   addu      $a2, $s1, $zero
    /* E17F4 800F0FF4 06004010 */  beqz       $v0, .L800F1010
    /* E17F8 800F0FF8 180022AE */   sw        $v0, 0x18($s1)
    /* E17FC 800F0FFC 21204000 */  addu       $a0, $v0, $zero
    /* E1800 800F1000 0F80053C */  lui        $a1, %hi(loadfilesizecallback)
    /* E1804 800F1004 540EA524 */  addiu      $a1, $a1, %lo(loadfilesizecallback)
  .L800F1008:
    /* E1808 800F1008 93AF030C */  jal        FILE_callbackop
    /* E180C 800F100C 00000000 */   nop
  .L800F1010:
    /* E1810 800F1010 2000BF8F */  lw         $ra, 0x20($sp)
    /* E1814 800F1014 1C00B18F */  lw         $s1, 0x1C($sp)
    /* E1818 800F1018 1800B08F */  lw         $s0, 0x18($sp)
    /* E181C 800F101C 0800E003 */  jr         $ra
    /* E1820 800F1020 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel loadfileopencallback
