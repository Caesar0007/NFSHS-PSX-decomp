.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F0D24, 0x5C

glabel func_800F0D24
    /* E1524 800F0D24 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E1528 800F0D28 1000B0AF */  sw         $s0, 0x10($sp)
    /* E152C 800F0D2C 2180C000 */  addu       $s0, $a2, $zero
    /* E1530 800F0D30 1800BFAF */  sw         $ra, 0x18($sp)
    /* E1534 800F0D34 1400B1AF */  sw         $s1, 0x14($sp)
    /* E1538 800F0D38 1800048E */  lw         $a0, 0x18($s0)
    /* E153C 800F0D3C ACB0030C */  jal        FILE_completeop
    /* E1540 800F0D40 21880002 */   addu      $s1, $s0, $zero
    /* E1544 800F0D44 0C00028E */  lw         $v0, 0xC($s0)
    /* E1548 800F0D48 00000000 */  nop
    /* E154C 800F0D4C 05004010 */  beqz       $v0, .L800F0D64
    /* E1550 800F0D50 00000000 */   nop
    /* E1554 800F0D54 14C3030C */  jal        func_800F0C50
    /* E1558 800F0D58 21200002 */   addu      $a0, $s0, $zero
    /* E155C 800F0D5C 5BC30308 */  j          .L800F0D6C
    /* E1560 800F0D60 00000000 */   nop
  .L800F0D64:
    /* E1564 800F0D64 3AC3030C */  jal        func_800F0CE8
    /* E1568 800F0D68 21202002 */   addu      $a0, $s1, $zero
  .L800F0D6C:
    /* E156C 800F0D6C 1800BF8F */  lw         $ra, 0x18($sp)
    /* E1570 800F0D70 1400B18F */  lw         $s1, 0x14($sp)
    /* E1574 800F0D74 1000B08F */  lw         $s0, 0x10($sp)
    /* E1578 800F0D78 0800E003 */  jr         $ra
    /* E157C 800F0D7C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_800F0D24
